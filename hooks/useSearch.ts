'use client';

import { useState, useCallback, useEffect, useRef } from 'react';
import Fuse from 'fuse.js';
import { createClient } from '@/lib/supabase/client';
import type { Court, Contact, ShellCell, TeamsLink, BailCourt, BailContact, SearchResults } from '@/types';
import { parseSearchQuery, getContactRoleIds, getContactTypeLabel } from '@/lib/searchParser';

// ============================================================================
// ALIAS EXPANSION
// ============================================================================
const LOCATION_ALIASES: Record<string, string[]> = {
  'north vancouver': ['north van', 'n van', 'nvan', 'n. van', 'north v', 'nv'],
  'vancouver': ['van', 'vcr', 'yvr', '222 main', 'robson square', 'dcc', 'downtown'],
  'richmond': ['rich', 'rmd'],
  'surrey': ['sur', 'sry', 'srry'],
  'abbotsford': ['abby', 'abb', 'abbot', 'abotsford', 'abbotford'],
  'chilliwack': ['chwk', 'cwk', 'chl', 'chilli', 'chilwack', 'chillwack'],
  'new westminster': ['new west', 'newwest', 'nw', 'n westminster'],
  'port coquitlam': ['poco', 'port coq', 'coquitlam', 'pco'],
  'kelowna': ['kel', 'kelo', 'klowna'],
  'kamloops': ['kam', 'kams', 'kamloop'],
  'penticton': ['pent', 'pentic'],
  'vernon': ['vern'],
  'cranbrook': ['cran'],
  'nelson': ['nel'],
  'victoria': ['vic', 'vict', 'victora'],
  'nanaimo': ['nan', 'nanaino', 'nanimo'],
  'courtenay': ['court', 'ctnay'],
  'campbell river': ['campbell', 'camp river', 'campbel river'],
  'duncan': ['dun'],
  'port alberni': ['alberni', 'port alb'],
  'prince george': ['pg', 'prg', 'prince g', 'pringe george', 'prince goerge'],
  'prince rupert': ['rupert', 'pr'],
  'terrace': ['terr'],
  'dawson creek': ['dawson', 'dc'],
  'fort st john': ['fort st j', 'fsj', 'fort st. john'],
  'fort nelson': ['fort n', 'fn'],
  'quesnel': ['ques'],
  'williams lake': ['williams', 'wl'],
};

// Build reverse lookup
const ALIAS_TO_CANONICAL: Record<string, string> = {};
for (const [canonical, aliases] of Object.entries(LOCATION_ALIASES)) {
  for (const alias of aliases) {
    ALIAS_TO_CANONICAL[alias.toLowerCase()] = canonical;
  }
  ALIAS_TO_CANONICAL[canonical.toLowerCase()] = canonical;
}

function expandAlias(term: string): string {
  const lower = term.toLowerCase().trim();
  return ALIAS_TO_CANONICAL[lower] || term;
}

// ============================================================================
// CACHED DATA & FUSE INDEX
// ============================================================================
interface CachedData {
  courts: Court[];
  cells: ShellCell[];
  contacts: Contact[];
  teamsLinks: TeamsLink[];
  bailCourts: BailCourt[];
  bailContacts: BailContact[];
  // Relationship maps
  courtToContacts: Map<number, number[]>;
  courtToCells: Map<number, number[]>;
  courtToTeamsLinks: Map<number, number[]>;
  courtToBailCourt: Map<number, number>;
  regionToBailContacts: Map<number, number[]>;
  // Fuse instances
  courtsFuse: Fuse<Court>;
  cellsFuse: Fuse<ShellCell>;
}

let cachedData: CachedData | null = null;
let loadingPromise: Promise<CachedData> | null = null;

// ============================================================================
// FILTER HELPERS
// ============================================================================
function filterTeamsLinksByCourtroom(links: TeamsLink[], courtroomNum: string): TeamsLink[] {
  const normalizedNum = parseInt(courtroomNum, 10).toString();
  return links.filter(link => {
    const courtroom = (link.courtroom || link.name || '').toLowerCase();
    const patterns = [
      new RegExp(`\\bcr\\s*0*${normalizedNum}\\b`, 'i'),
      new RegExp(`\\broom\\s*0*${normalizedNum}\\b`, 'i'),
      new RegExp(`\\bcourtroom\\s*0*${normalizedNum}\\b`, 'i'),
      new RegExp(`^0*${normalizedNum}$`),
    ];
    return patterns.some(pattern => pattern.test(courtroom));
  });
}

function filterContactsByRole(contacts: Contact[], roleIds: number[]): Contact[] {
  return contacts.filter(c => roleIds.includes(c.contact_role_id));
}

function filterCellsByType(cells: ShellCell[], cellType: string): ShellCell[] {
  if (cellType === 'ALL') return cells;
  return cells.filter(c => c.cell_type === cellType);
}

// ============================================================================
// DATA LOADING
// ============================================================================
async function loadAllData(supabase: ReturnType<typeof createClient>): Promise<CachedData> {
  if (cachedData) return cachedData;
  if (loadingPromise) return loadingPromise;

  loadingPromise = (async () => {
    console.log('Loading search data...');
    
    const [
      { data: courts },
      { data: cells },
      { data: contacts },
      { data: teamsLinks },
      { data: bailCourts },
      { data: bailContacts },
      { data: contactsCourts },
      { data: cellsCourts },
    ] = await Promise.all([
      supabase.from('courts').select('*, regions(code, name)').eq('is_staffed', true),
      supabase.from('sheriff_cells').select('*'),
      supabase.from('contacts').select('*, contact_roles(name)'),
      supabase.from('teams_links').select('*'),
      supabase.from('bail_courts').select('*'),
      supabase.from('bail_contacts').select('*, contact_roles(name)'),
      supabase.from('contacts_courts').select('court_id, contact_id'),
      supabase.from('sheriff_cells_courts').select('court_id, sheriff_cell_id'),
    ]);

    // Enrich data
    const enrichedCourts: Court[] = (courts || []).map((c: any) => ({
      ...c,
      region_code: c.regions?.code,
      region_name: c.regions?.name,
    }));

    const enrichedContacts: Contact[] = (contacts || []).map((c: any) => ({
      ...c,
      role_name: c.contact_roles?.name,
    }));

    const enrichedBailContacts: BailContact[] = (bailContacts || []).map((c: any) => ({
      ...c,
      role_name: c.contact_roles?.name,
    }));

    // Build relationship maps
    const courtToContacts = new Map<number, number[]>();
    for (const cc of (contactsCourts || [])) {
      const existing = courtToContacts.get(cc.court_id) || [];
      existing.push(cc.contact_id);
      courtToContacts.set(cc.court_id, existing);
    }

    const courtToCells = new Map<number, number[]>();
    for (const cc of (cellsCourts || [])) {
      const existing = courtToCells.get(cc.court_id) || [];
      existing.push(cc.sheriff_cell_id);
      courtToCells.set(cc.court_id, existing);
    }

    const courtToTeamsLinks = new Map<number, number[]>();
    for (const link of (teamsLinks || [])) {
      if (link.court_id) {
        const existing = courtToTeamsLinks.get(link.court_id) || [];
        existing.push(link.id);
        courtToTeamsLinks.set(link.court_id, existing);
      }
    }

    const courtToBailCourt = new Map<number, number>();
    for (const court of enrichedCourts) {
      if (court.bail_hub_id) {
        courtToBailCourt.set(court.id, court.bail_hub_id);
      }
    }

    const regionToBailContacts = new Map<number, number[]>();
    for (const bc of enrichedBailContacts) {
      if (bc.region_id) {
        const existing = regionToBailContacts.get(bc.region_id) || [];
        existing.push(bc.id);
        regionToBailContacts.set(bc.region_id, existing);
      }
    }

    // Create Fuse instances for fuzzy search
    const courtsFuse = new Fuse(enrichedCourts, {
      keys: ['name', 'region_name', 'address'],
      threshold: 0.35,
      distance: 100,
      minMatchCharLength: 2,
      includeScore: true,
    });

    const cellsFuse = new Fuse(cells || [], {
      keys: ['name', 'catchment'],
      threshold: 0.35,
      distance: 100,
      minMatchCharLength: 2,
      includeScore: true,
    });

    cachedData = {
      courts: enrichedCourts,
      cells: cells || [],
      contacts: enrichedContacts,
      teamsLinks: teamsLinks || [],
      bailCourts: bailCourts || [],
      bailContacts: enrichedBailContacts,
      courtToContacts,
      courtToCells,
      courtToTeamsLinks,
      courtToBailCourt,
      regionToBailContacts,
      courtsFuse,
      cellsFuse,
    };

    console.log('Search data loaded:', {
      courts: enrichedCourts.length,
      cells: cells?.length,
      contacts: enrichedContacts.length,
      teamsLinks: teamsLinks?.length,
    });

    return cachedData;
  })();

  return loadingPromise;
}

// ============================================================================
// SEARCH HOOK
// ============================================================================
export function useSearch() {
  const [results, setResults] = useState<SearchResults | null>(null);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [isIndexReady, setIsIndexReady] = useState(false);
  
  const supabase = createClient();

  // Pre-load data on mount
  useEffect(() => {
    loadAllData(supabase).then(() => setIsIndexReady(true));
  }, [supabase]);

  const search = useCallback(async (query: string) => {
    if (!query || query.trim().length < 2) {
      setResults(null);
      return;
    }

    setIsLoading(true);
    setError(null);

    try {
      // Ensure data is loaded
      const data = await loadAllData(supabase);
      
      // Parse and expand query
      const parsed = parseSearchQuery(query);
      const expandedTerm = expandAlias(parsed.courtTerm || query);
      
      // Fuzzy search courts
      let courts: Court[] = [];
      if (parsed.courtTerm || parsed.intent === 'court_lookup' || parsed.intent === 'general') {
        const fuseResults = data.courtsFuse.search(expandedTerm);
        courts = fuseResults.map(r => r.item);
        
        // Apply region filter if specified
        if (parsed.filters.region) {
          courts = courts.filter(c => c.region_id === parsed.filters.region);
        }
      }

      // Fuzzy search cells
      let cells: ShellCell[] = [];
      if (parsed.courtTerm || parsed.intent === 'cell_lookup' || parsed.intent === 'general') {
        const fuseResults = data.cellsFuse.search(expandedTerm);
        cells = fuseResults.map(r => r.item);
        
        // Apply cell type filter
        if (parsed.filters.cellType) {
          cells = filterCellsByType(cells, parsed.filters.cellType);
        }
      }

      // If we have courts, get related data
      let contacts: Contact[] = [];
      let teamsLinks: TeamsLink[] = [];
      let bailCourt: BailCourt | null = null;
      let bailContacts: BailContact[] = [];
      let bailTeamsLinks: TeamsLink[] = [];

      if (courts.length > 0) {
        // Get contacts for matched courts
        for (const court of courts) {
          const contactIds = data.courtToContacts.get(court.id) || [];
          const courtContacts = contactIds
            .map(id => data.contacts.find(c => c.id === id))
            .filter((c): c is Contact => c !== undefined)
            .map(c => ({ ...c, court_id: court.id }));
          contacts.push(...courtContacts);
        }

        // Apply contact type filter
        const roleIds = getContactRoleIds(parsed.filters.contactType);
        if (roleIds) {
          contacts = filterContactsByRole(contacts, roleIds);
        }

        // Get teams links for matched courts
        for (const court of courts) {
          const linkIds = data.courtToTeamsLinks.get(court.id) || [];
          const courtLinks = linkIds
            .map(id => data.teamsLinks.find(l => l.id === id))
            .filter((l): l is TeamsLink => l !== undefined);
          teamsLinks.push(...courtLinks);
        }

        // Apply courtroom filter
        if (parsed.filters.courtroom) {
          teamsLinks = filterTeamsLinksByCourtroom(teamsLinks, parsed.filters.courtroom);
        }

        // Get bail info from first court
        const primaryCourt = courts[0];
        const bailCourtId = data.courtToBailCourt.get(primaryCourt.id);
        if (bailCourtId) {
          bailCourt = data.bailCourts.find(bc => bc.id === bailCourtId) || null;
          
          // Get bail contacts for this region
          if (bailCourt) {
            const bailContactIds = data.regionToBailContacts.get(bailCourt.region_id) || [];
            bailContacts = bailContactIds
              .map(id => data.bailContacts.find(bc => bc.id === id))
              .filter((bc): bc is BailContact => bc !== undefined);
            
            // Get bail teams links
            bailTeamsLinks = data.teamsLinks.filter(l => l.bail_court_id === bailCourt!.id);
          }
        }

        // Also get cells linked to matched courts
        for (const court of courts) {
          const cellIds = data.courtToCells.get(court.id) || [];
          const courtCells = cellIds
            .map(id => data.cells.find(c => c.id === id))
            .filter((c): c is ShellCell => c !== undefined);
          // Add cells that aren't already in the list
          for (const cell of courtCells) {
            if (!cells.find(c => c.id === cell.id)) {
              cells.push(cell);
            }
          }
        }
      }

      // If only region filter specified, get all data for that region
      if (!parsed.courtTerm && parsed.filters.region) {
        courts = data.courts.filter(c => c.region_id === parsed.filters.region);
        cells = data.cells.filter(c => c.region_id === parsed.filters.region);
        if (parsed.filters.cellType) {
          cells = filterCellsByType(cells, parsed.filters.cellType);
        }
      }

      // Enrich cells with court names for courthouse cells
      const courtNameMap = new Map(courts.map(c => [c.id, c.name]));
      const enrichedCells = cells.map(cell => {
        if ((cell.cell_type === 'CH' || cell.cell_type === 'courthouse') && cell.court_id) {
          return { ...cell, court_name: courtNameMap.get(cell.court_id) || data.courts.find(c => c.id === cell.court_id)?.name };
        }
        return cell;
      });

      setResults({
        courts,
        contacts,
        sheriffCells: enrichedCells,
        teamsLinks,
        bailCourt,
        bailContacts,
        bailTeamsLinks,
        courtroomFilter: parsed.filters.courtroom,
        contactTypeFilter: parsed.filters.contactType,
        contactTypeLabel: getContactTypeLabel(parsed.filters.contactType),
        cellTypeFilter: parsed.filters.cellType,
        regionFilter: parsed.filters.region,
        searchIntent: parsed.intent,
      });
    } catch (err) {
      console.error('Search error:', err);
      setError('Failed to search. Please try again.');
      setResults(null);
    } finally {
      setIsLoading(false);
    }
  }, [supabase]);

  const clearResults = useCallback(() => {
    setResults(null);
    setError(null);
  }, []);

  return {
    results,
    isLoading,
    error,
    search,
    clearResults,
    isIndexReady,
  };
}

// ============================================================================
// COURT DETAILS HOOK (unchanged interface)
// ============================================================================
export function useCourtDetails() {
  const [court, setCourt] = useState<Court | null>(null);
  const [contacts, setContacts] = useState<Contact[]>([]);
  const [sheriffCells, setSheriffCells] = useState<ShellCell[]>([]);
  const [teamsLinks, setTeamsLinks] = useState<TeamsLink[]>([]);
  const [bailCourt, setBailCourt] = useState<BailCourt | null>(null);
  const [bailContacts, setBailContacts] = useState<BailContact[]>([]);
  const [bailTeamsLinks, setBailTeamsLinks] = useState<TeamsLink[]>([]);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const supabase = createClient();

  const fetchCourtDetails = useCallback(async (courtId: number) => {
    setIsLoading(true);
    setError(null);

    try {
      // Use cached data if available
      if (cachedData) {
        const courtData = cachedData.courts.find(c => c.id === courtId);
        if (courtData) {
          setCourt(courtData);

          // Get contacts
          const contactIds = cachedData.courtToContacts.get(courtId) || [];
          const courtContacts = contactIds
            .map(id => cachedData!.contacts.find(c => c.id === id))
            .filter((c): c is Contact => c !== undefined);
          setContacts(courtContacts);

          // Get cells
          const cellIds = cachedData.courtToCells.get(courtId) || [];
          const courtCells = cellIds
            .map(id => cachedData!.cells.find(c => c.id === id))
            .filter((c): c is ShellCell => c !== undefined);
          
          // Also get courthouse cells
          const chCells = cachedData.cells.filter(c => c.court_id === courtId);
          const allCells = [...courtCells];
          for (const cell of chCells) {
            if (!allCells.find(c => c.id === cell.id)) {
              allCells.push({ ...cell, court_name: courtData.name });
            }
          }
          setSheriffCells(allCells);

          // Get teams links
          const linkIds = cachedData.courtToTeamsLinks.get(courtId) || [];
          const courtLinks = linkIds
            .map(id => cachedData!.teamsLinks.find(l => l.id === id))
            .filter((l): l is TeamsLink => l !== undefined);
          setTeamsLinks(courtLinks);

          // Get bail info
          const bailCourtId = cachedData.courtToBailCourt.get(courtId);
          if (bailCourtId) {
            const bc = cachedData.bailCourts.find(b => b.id === bailCourtId);
            setBailCourt(bc || null);
            
            if (bc) {
              const bcIds = cachedData.regionToBailContacts.get(bc.region_id) || [];
              const bContacts = bcIds
                .map(id => cachedData!.bailContacts.find(c => c.id === id))
                .filter((c): c is BailContact => c !== undefined);
              setBailContacts(bContacts);
              
              const bLinks = cachedData.teamsLinks.filter(l => l.bail_court_id === bc.id);
              setBailTeamsLinks(bLinks);
            }
          } else {
            setBailCourt(null);
            setBailContacts([]);
            setBailTeamsLinks([]);
          }

          setIsLoading(false);
          return;
        }
      }

      // Fallback to direct database query if no cache
      const { data: courtData, error: courtError } = await supabase
        .from('courts')
        .select('*, regions(code, name)')
        .eq('id', courtId)
        .single();
      
      if (courtError) throw courtError;

      const enrichedCourt = {
        ...courtData,
        region_code: courtData.regions?.code,
        region_name: courtData.regions?.name
      };
      setCourt(enrichedCourt);

      // Fetch contacts
      const { data: contactsData } = await supabase
        .from('contacts_courts')
        .select(`contacts (id, email, emails, contact_role_id, contact_roles(name))`)
        .eq('court_id', courtId);

      if (contactsData) {
        setContacts(
          contactsData
            .filter((cc: any) => cc.contacts)
            .map((cc: any) => ({ ...cc.contacts, role_name: cc.contacts.contact_roles?.name }))
        );
      }

      // Fetch cells
      const { data: cellLinksData } = await supabase
        .from('sheriff_cells_courts')
        .select('sheriff_cell_id')
        .eq('court_id', courtId);

      if (cellLinksData && cellLinksData.length > 0) {
        const cellIds = cellLinksData.map((c: any) => c.sheriff_cell_id);
        const { data: cellsData } = await supabase
          .from('sheriff_cells')
          .select('*')
          .in('id', cellIds);
        
        if (cellsData) setSheriffCells(cellsData);
      }

      // Fetch teams links
      const { data: teamsData } = await supabase
        .from('teams_links')
        .select('*')
        .eq('court_id', courtId);
      
      if (teamsData) setTeamsLinks(teamsData);

      // Fetch bail info
      if (courtData.bail_hub_id) {
        const { data: bailData } = await supabase
          .from('bail_courts')
          .select('*')
          .eq('id', courtData.bail_hub_id)
          .single();
        
        if (bailData) {
          setBailCourt(bailData);
          
          const { data: bailContactsData } = await supabase
            .from('bail_contacts')
            .select('*, contact_roles(name)')
            .or(`bail_court_id.eq.${bailData.id},region_id.eq.${bailData.region_id}`);
          
          if (bailContactsData) {
            setBailContacts(bailContactsData.map((bc: any) => ({
              ...bc, role_name: bc.contact_roles?.name
            })));
          }

          const { data: bailTeamsData } = await supabase
            .from('teams_links')
            .select('*')
            .eq('bail_court_id', bailData.id);
          
          if (bailTeamsData) setBailTeamsLinks(bailTeamsData);
        }
      }
    } catch (err) {
      console.error('Error fetching court details:', err);
      setError('Failed to load court details.');
    } finally {
      setIsLoading(false);
    }
  }, [supabase]);

  return {
    court,
    contacts,
    sheriffCells,
    teamsLinks,
    bailCourt,
    bailContacts,
    bailTeamsLinks,
    isLoading,
    error,
    fetchCourtDetails
  };
}
