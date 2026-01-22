'use client';

import Fuse from 'fuse.js';

// ============================================================================
// CONTEXTUAL SEARCH ENGINE
// ============================================================================
// When you search "north van", this returns:
// - North Vancouver Court (primary match)
// - All contacts for that court (crown, JCM, registry, etc.)
// - RCMP/Police cells that serve North Vancouver
// - Teams links for North Vancouver courtrooms
// - Bail info for that region
// - Programs in that area
// ============================================================================

// Types
export interface SearchableEntity {
  id: number;
  type: 'court' | 'cell' | 'bail_court' | 'program' | 'contact' | 'teams_link';
  name: string;
  searchTerms: string[];  // Multiple terms for matching
  regionId: number | null;
  courtId: number | null; // Links cells/contacts back to their court
  metadata: Record<string, any>;
}

export interface ContextualResult {
  primary: {
    type: 'court' | 'cell' | 'bail_court' | 'program';
    item: any;
    matchScore: number;
  };
  related: {
    contacts: any[];
    cells: any[];
    teamsLinks: any[];
    bailCourt: any | null;
    bailContacts: any[];
    programs: any[];
  };
}

// ============================================================================
// ALIAS EXPANSION
// ============================================================================
// Expands short forms and common variations to canonical names

const LOCATION_ALIASES: Record<string, string[]> = {
  // Vancouver Coastal
  'north vancouver': ['north van', 'n van', 'nvan', 'n. van', 'north v', 'nv'],
  'vancouver': ['van', 'vcr', 'yvr', '222 main', 'robson square', 'dcc', 'downtown'],
  'richmond': ['rich', 'rmd'],
  'north van - sechelt': ['sechelt', 'sunshine coast'],
  
  // Fraser
  'surrey': ['sur', 'sry', 'srry'],
  'abbotsford': ['abby', 'abb', 'abbot', 'abotsford', 'abbotford'],
  'chilliwack': ['chwk', 'cwk', 'chl', 'chilli', 'chilwack', 'chillwack'],
  'new westminster': ['new west', 'newwest', 'nw', 'n westminster'],
  'port coquitlam': ['poco', 'port coq', 'coquitlam', 'pco'],
  
  // Interior
  'kelowna': ['kel', 'kelo', 'klowna'],
  'kamloops': ['kam', 'kams', 'kamloop'],
  'penticton': ['pent', 'pentic'],
  'vernon': ['vern'],
  'cranbrook': ['cran'],
  'nelson': ['nel'],
  
  // Island
  'victoria': ['vic', 'vict', 'victora'],
  'nanaimo': ['nan', 'nanaino', 'nanimo'],
  'courtenay': ['court', 'ctnay'],
  'campbell river': ['campbell', 'camp river', 'campbel river'],
  'duncan': ['dun'],
  'port alberni': ['alberni', 'port alb'],
  
  // Northern
  'prince george': ['pg', 'prg', 'prince g', 'pringe george', 'prince goerge'],
  'prince rupert': ['rupert', 'pr'],
  'terrace': ['terr'],
  'dawson creek': ['dawson', 'dc'],
  'fort st john': ['fort st j', 'fsj', 'fort st. john'],
  'fort nelson': ['fort n', 'fn'],
  'quesnel': ['ques'],
  'williams lake': ['williams', 'wl'],
};

// Build reverse lookup: alias -> canonical name
const ALIAS_TO_CANONICAL: Record<string, string> = {};
for (const [canonical, aliases] of Object.entries(LOCATION_ALIASES)) {
  for (const alias of aliases) {
    ALIAS_TO_CANONICAL[alias.toLowerCase()] = canonical;
  }
  // Also map canonical to itself
  ALIAS_TO_CANONICAL[canonical.toLowerCase()] = canonical;
}

/**
 * Expand a search term to its canonical form
 * "north van" -> "north vancouver"
 * "abby" -> "abbotsford"
 */
export function expandSearchTerm(term: string): string {
  const normalized = term.toLowerCase().trim();
  return ALIAS_TO_CANONICAL[normalized] || term;
}

/**
 * Get all possible search terms for a location
 * "north vancouver" -> ["north vancouver", "north van", "n van", ...]
 */
export function getAllSearchTerms(canonicalName: string): string[] {
  const lower = canonicalName.toLowerCase();
  const aliases = LOCATION_ALIASES[lower] || [];
  return [canonicalName, ...aliases];
}

// ============================================================================
// SEARCH INDEX
// ============================================================================

interface SearchIndex {
  courts: Map<number, any>;
  cells: Map<number, any>;
  contacts: Map<number, any>;
  teamsLinks: Map<number, any>;
  bailCourts: Map<number, any>;
  bailContacts: Map<number, any>;
  programs: Map<number, any>;
  
  // Relationship maps
  courtToCells: Map<number, number[]>;      // court_id -> cell_ids
  courtToContacts: Map<number, number[]>;   // court_id -> contact_ids
  courtToTeamsLinks: Map<number, number[]>; // court_id -> teams_link_ids
  courtToBailCourt: Map<number, number>;    // court_id -> bail_court_id
  regionToBailContacts: Map<number, number[]>; // region_id -> bail_contact_ids
  regionToPrograms: Map<number, number[]>;  // region_id -> program_ids
  regionToCells: Map<number, number[]>;     // region_id -> cell_ids
  
  // Fuse instance for fuzzy matching
  fuse: Fuse<SearchableEntity> | null;
}

let searchIndex: SearchIndex = {
  courts: new Map(),
  cells: new Map(),
  contacts: new Map(),
  teamsLinks: new Map(),
  bailCourts: new Map(),
  bailContacts: new Map(),
  programs: new Map(),
  courtToCells: new Map(),
  courtToContacts: new Map(),
  courtToTeamsLinks: new Map(),
  courtToBailCourt: new Map(),
  regionToBailContacts: new Map(),
  regionToPrograms: new Map(),
  regionToCells: new Map(),
  fuse: null,
};

/**
 * Initialize the search index with all data
 */
export function initContextualSearch(data: {
  courts: any[];
  cells: any[];
  contacts: any[];
  teamsLinks: any[];
  bailCourts: any[];
  bailContacts: any[];
  programs: any[];
  // Relationship data
  contactsCourts: { court_id: number; contact_id: number }[];
  cellsCourts: { court_id: number; cell_id: number }[];
}): void {
  // Clear existing
  searchIndex = {
    courts: new Map(),
    cells: new Map(),
    contacts: new Map(),
    teamsLinks: new Map(),
    bailCourts: new Map(),
    bailContacts: new Map(),
    programs: new Map(),
    courtToCells: new Map(),
    courtToContacts: new Map(),
    courtToTeamsLinks: new Map(),
    courtToBailCourt: new Map(),
    regionToBailContacts: new Map(),
    regionToPrograms: new Map(),
    regionToCells: new Map(),
    fuse: null,
  };

  // Index courts
  for (const court of data.courts) {
    searchIndex.courts.set(court.id, court);
    
    // Map court to bail court
    if (court.bail_hub_id) {
      searchIndex.courtToBailCourt.set(court.id, court.bail_hub_id);
    }
  }

  // Index cells and build relationships
  for (const cell of data.cells) {
    searchIndex.cells.set(cell.id, cell);
    
    // Region -> cells mapping
    if (cell.region_id) {
      const existing = searchIndex.regionToCells.get(cell.region_id) || [];
      existing.push(cell.id);
      searchIndex.regionToCells.set(cell.region_id, existing);
    }
  }

  // Index contacts
  for (const contact of data.contacts) {
    searchIndex.contacts.set(contact.id, contact);
  }

  // Index teams links
  for (const link of data.teamsLinks) {
    searchIndex.teamsLinks.set(link.id, link);
    
    // Court -> teams links mapping
    if (link.court_id) {
      const existing = searchIndex.courtToTeamsLinks.get(link.court_id) || [];
      existing.push(link.id);
      searchIndex.courtToTeamsLinks.set(link.court_id, existing);
    }
  }

  // Index bail courts
  for (const bailCourt of data.bailCourts) {
    searchIndex.bailCourts.set(bailCourt.id, bailCourt);
  }

  // Index bail contacts and build region mapping
  for (const bailContact of data.bailContacts) {
    searchIndex.bailContacts.set(bailContact.id, bailContact);
    
    if (bailContact.region_id) {
      const existing = searchIndex.regionToBailContacts.get(bailContact.region_id) || [];
      existing.push(bailContact.id);
      searchIndex.regionToBailContacts.set(bailContact.region_id, existing);
    }
  }

  // Index programs and build region mapping
  for (const program of data.programs) {
    searchIndex.programs.set(program.id, program);
    
    if (program.region_id) {
      const existing = searchIndex.regionToPrograms.get(program.region_id) || [];
      existing.push(program.id);
      searchIndex.regionToPrograms.set(program.region_id, existing);
    }
  }

  // Build court -> contacts mapping
  for (const cc of data.contactsCourts) {
    const existing = searchIndex.courtToContacts.get(cc.court_id) || [];
    existing.push(cc.contact_id);
    searchIndex.courtToContacts.set(cc.court_id, existing);
  }

  // Build court -> cells mapping
  for (const cc of data.cellsCourts) {
    const existing = searchIndex.courtToCells.get(cc.court_id) || [];
    existing.push(cc.cell_id);
    searchIndex.courtToCells.set(cc.court_id, existing);
  }

  // Build Fuse.js index for fuzzy matching
  const searchableEntities: SearchableEntity[] = [];

  // Add courts with expanded search terms
  for (const court of data.courts) {
    const allTerms = getAllSearchTerms(court.name);
    searchableEntities.push({
      id: court.id,
      type: 'court',
      name: court.name,
      searchTerms: [
        court.name,
        ...allTerms,
        court.region_name || '',
        court.address || '',
      ].filter(Boolean),
      regionId: court.region_id,
      courtId: null,
      metadata: court,
    });
  }

  // Add cells
  for (const cell of data.cells) {
    const allTerms = getAllSearchTerms(cell.name);
    searchableEntities.push({
      id: cell.id,
      type: 'cell',
      name: cell.name,
      searchTerms: [
        cell.name,
        ...allTerms,
        cell.catchment || '',
        cell.cell_type,
      ].filter(Boolean),
      regionId: cell.region_id,
      courtId: cell.court_id,
      metadata: cell,
    });
  }

  // Add bail courts
  for (const bailCourt of data.bailCourts) {
    const allTerms = getAllSearchTerms(bailCourt.name);
    searchableEntities.push({
      id: bailCourt.id,
      type: 'bail_court',
      name: bailCourt.name,
      searchTerms: [bailCourt.name, ...allTerms].filter(Boolean),
      regionId: bailCourt.region_id,
      courtId: bailCourt.court_id,
      metadata: bailCourt,
    });
  }

  // Add programs
  for (const program of data.programs) {
    const locationTerms = program.location ? getAllSearchTerms(program.location) : [];
    searchableEntities.push({
      id: program.id,
      type: 'program',
      name: program.name,
      searchTerms: [
        program.name,
        program.location || '',
        ...locationTerms,
        program.type_name || '',
      ].filter(Boolean),
      regionId: program.region_id,
      courtId: null,
      metadata: program,
    });
  }

  // Create Fuse instance
  searchIndex.fuse = new Fuse(searchableEntities, {
    keys: [
      { name: 'name', weight: 0.5 },
      { name: 'searchTerms', weight: 0.4 },
    ],
    threshold: 0.35,
    distance: 100,
    minMatchCharLength: 2,
    includeScore: true,
    ignoreLocation: true,
  });
}

// ============================================================================
// CONTEXTUAL SEARCH
// ============================================================================

/**
 * Perform contextual search
 * Returns primary matches with all related entities
 */
export function contextualSearch(
  query: string,
  options?: {
    limit?: number;
    types?: ('court' | 'cell' | 'bail_court' | 'program')[];
    regionId?: number;
  }
): ContextualResult[] {
  if (!searchIndex.fuse || query.trim().length < 2) {
    return [];
  }

  const limit = options?.limit || 10;
  const allowedTypes = options?.types || ['court', 'cell', 'bail_court', 'program'];

  // Expand the search term
  const expandedQuery = expandSearchTerm(query);
  
  // Search with both original and expanded terms
  const results = searchIndex.fuse.search(expandedQuery);
  
  // If expanded is different, also search original
  if (expandedQuery.toLowerCase() !== query.toLowerCase()) {
    const originalResults = searchIndex.fuse.search(query);
    // Merge, preferring expanded results
    const seen = new Set(results.map(r => `${r.item.type}-${r.item.id}`));
    for (const r of originalResults) {
      if (!seen.has(`${r.item.type}-${r.item.id}`)) {
        results.push(r);
      }
    }
  }

  // Filter and dedupe
  const filtered = results
    .filter(r => allowedTypes.includes(r.item.type as any))
    .filter(r => !options?.regionId || r.item.regionId === options.regionId);

  // Build contextual results
  const contextualResults: ContextualResult[] = [];
  const processedCourts = new Set<number>();

  for (const result of filtered.slice(0, limit)) {
    const entity = result.item;
    
    // For courts, build full context
    if (entity.type === 'court') {
      if (processedCourts.has(entity.id)) continue;
      processedCourts.add(entity.id);
      
      contextualResults.push(buildCourtContext(entity.id, result.score || 0));
    }
    // For cells, find the associated court(s) and build context
    else if (entity.type === 'cell') {
      const cell = searchIndex.cells.get(entity.id);
      
      // Check if this cell is linked to any courts
      for (const [courtId, cellIds] of searchIndex.courtToCells) {
        if (cellIds.includes(entity.id) && !processedCourts.has(courtId)) {
          processedCourts.add(courtId);
          const courtContext = buildCourtContext(courtId, result.score || 0);
          contextualResults.push(courtContext);
        }
      }
      
      // If cell isn't linked to a court, show it standalone with region context
      if (contextualResults.length === 0 || !Array.from(searchIndex.courtToCells.values()).flat().includes(entity.id)) {
        contextualResults.push({
          primary: {
            type: 'cell',
            item: cell,
            matchScore: result.score || 0,
          },
          related: {
            contacts: [],
            cells: getRegionCells(cell.region_id).filter(c => c.id !== cell.id),
            teamsLinks: [],
            bailCourt: null,
            bailContacts: getRegionBailContacts(cell.region_id),
            programs: getRegionPrograms(cell.region_id),
          },
        });
      }
    }
    // For bail courts, build region context
    else if (entity.type === 'bail_court') {
      const bailCourt = searchIndex.bailCourts.get(entity.id);
      contextualResults.push({
        primary: {
          type: 'bail_court',
          item: bailCourt,
          matchScore: result.score || 0,
        },
        related: {
          contacts: [],
          cells: getRegionCells(bailCourt.region_id),
          teamsLinks: getBailCourtTeamsLinks(bailCourt.id),
          bailCourt: null,
          bailContacts: getRegionBailContacts(bailCourt.region_id),
          programs: getRegionPrograms(bailCourt.region_id),
        },
      });
    }
    // For programs, show with region context
    else if (entity.type === 'program') {
      const program = searchIndex.programs.get(entity.id);
      contextualResults.push({
        primary: {
          type: 'program',
          item: program,
          matchScore: result.score || 0,
        },
        related: {
          contacts: [],
          cells: [],
          teamsLinks: [],
          bailCourt: null,
          bailContacts: [],
          programs: getRegionPrograms(program.region_id).filter(p => p.id !== program.id),
        },
      });
    }
  }

  return contextualResults;
}

/**
 * Build full context for a court
 */
function buildCourtContext(courtId: number, matchScore: number): ContextualResult {
  const court = searchIndex.courts.get(courtId);
  
  // Get contacts for this court
  const contactIds = searchIndex.courtToContacts.get(courtId) || [];
  const contacts = contactIds.map(id => searchIndex.contacts.get(id)).filter(Boolean);
  
  // Get cells for this court
  const cellIds = searchIndex.courtToCells.get(courtId) || [];
  const cells = cellIds.map(id => searchIndex.cells.get(id)).filter(Boolean);
  
  // Also get cells in the same region
  const regionCells = getRegionCells(court.region_id);
  const allCells = [...cells];
  for (const cell of regionCells) {
    if (!allCells.find(c => c.id === cell.id)) {
      allCells.push(cell);
    }
  }
  
  // Get teams links for this court
  const teamsLinkIds = searchIndex.courtToTeamsLinks.get(courtId) || [];
  const teamsLinks = teamsLinkIds.map(id => searchIndex.teamsLinks.get(id)).filter(Boolean);
  
  // Get bail court
  const bailCourtId = searchIndex.courtToBailCourt.get(courtId);
  const bailCourt = bailCourtId ? searchIndex.bailCourts.get(bailCourtId) : null;
  
  // Get bail contacts for region
  const bailContacts = getRegionBailContacts(court.region_id);
  
  // Get programs for region
  const programs = getRegionPrograms(court.region_id);
  
  return {
    primary: {
      type: 'court',
      item: court,
      matchScore,
    },
    related: {
      contacts,
      cells: allCells,
      teamsLinks,
      bailCourt,
      bailContacts,
      programs,
    },
  };
}

function getRegionCells(regionId: number | null): any[] {
  if (!regionId) return [];
  const cellIds = searchIndex.regionToCells.get(regionId) || [];
  return cellIds.map(id => searchIndex.cells.get(id)).filter(Boolean);
}

function getRegionBailContacts(regionId: number | null): any[] {
  if (!regionId) return [];
  const contactIds = searchIndex.regionToBailContacts.get(regionId) || [];
  return contactIds.map(id => searchIndex.bailContacts.get(id)).filter(Boolean);
}

function getRegionPrograms(regionId: number | null): any[] {
  if (!regionId) return [];
  const programIds = searchIndex.regionToPrograms.get(regionId) || [];
  return programIds.map(id => searchIndex.programs.get(id)).filter(Boolean);
}

function getBailCourtTeamsLinks(bailCourtId: number): any[] {
  const links: any[] = [];
  for (const [id, link] of searchIndex.teamsLinks) {
    if (link.bail_court_id === bailCourtId) {
      links.push(link);
    }
  }
  return links;
}

// ============================================================================
// QUICK SEARCH (for typeahead)
// ============================================================================

export interface QuickSearchResult {
  id: number;
  type: 'court' | 'cell' | 'bail_court' | 'program';
  name: string;
  subtitle: string;
  regionId: number | null;
}

/**
 * Quick fuzzy search for typeahead
 * Returns simple matches without full context
 */
export function quickSearch(query: string, limit = 8): QuickSearchResult[] {
  if (!searchIndex.fuse || query.trim().length < 2) {
    return [];
  }

  const expandedQuery = expandSearchTerm(query);
  const results = searchIndex.fuse.search(expandedQuery);

  return results.slice(0, limit).map(r => ({
    id: r.item.id,
    type: r.item.type as QuickSearchResult['type'],
    name: r.item.name,
    subtitle: getSubtitle(r.item),
    regionId: r.item.regionId,
  }));
}

function getSubtitle(entity: SearchableEntity): string {
  switch (entity.type) {
    case 'court':
      return entity.metadata.region_name || '';
    case 'cell':
      return `${entity.metadata.cell_type} • ${entity.metadata.catchment || ''}`;
    case 'bail_court':
      return 'Virtual Bail';
    case 'program':
      return entity.metadata.type_name || entity.metadata.location || '';
    default:
      return '';
  }
}

// ============================================================================
// CHECK IF INDEX IS READY
// ============================================================================

export function isSearchIndexReady(): boolean {
  return searchIndex.fuse !== null;
}
