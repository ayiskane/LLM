'use client';

import { useState, useCallback } from 'react';
import { createClient } from '@/lib/supabase/client';
import type { Court, Contact, ShellCell, TeamsLink, BailCourt, BailContact, SearchResults } from '@/types';

export function useSearch() {
  const [results, setResults] = useState<SearchResults | null>(null);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  
  const supabase = createClient();

  const search = useCallback(async (query: string) => {
    if (!query || query.trim().length < 2) {
      setResults(null);
      return;
    }

    setIsLoading(true);
    setError(null);

    try {
      // Search courts using RPC function
      const { data: courts, error: courtsError } = await supabase
        .rpc('search_courts', { search_term: query });
      
      if (courtsError) throw courtsError;

      // Search sheriff cells using RPC function
      const { data: cells, error: cellsError } = await supabase
        .rpc('search_cells', { search_term: query });
      
      if (cellsError) throw cellsError;

      // Search bail courts using RPC function
      const { data: bailCourts, error: bailError } = await supabase
        .rpc('search_bail_courts', { search_term: query });
      
      if (bailError) throw bailError;

      // If we have courts, fetch related data
      let contacts: Contact[] = [];
      let teamsLinks: TeamsLink[] = [];
      let bailContacts: BailContact[] = [];
      let bailTeamsLinks: TeamsLink[] = [];
      let bailCourt: BailCourt | null = null;

      if (courts && courts.length > 0) {
        const courtIds = courts.map((c: Court) => c.id);
        
        // Fetch contacts for these courts
        const { data: contactsData } = await supabase
          .from('contacts_courts')
          .select(`
            contact_id,
            contacts (
              id,
              email,
              emails,
              contact_role_id
            )
          `)
          .in('court_id', courtIds);

        if (contactsData) {
          contacts = contactsData
            .filter((cc: any) => cc.contacts)
            .map((cc: any) => cc.contacts);
        }

        // Fetch teams links for these courts
        const { data: teamsData } = await supabase
          .from('teams_links')
          .select('*')
          .in('court_id', courtIds);

        if (teamsData) {
          teamsLinks = teamsData;
        }

        // Check if any court has a bail hub
        const primaryCourt = courts[0];
        if (primaryCourt.bail_hub_id) {
          const { data: bailData } = await supabase
            .from('bail_courts')
            .select('*')
            .eq('id', primaryCourt.bail_hub_id)
            .single();
          
          if (bailData) {
            bailCourt = bailData;
            
            // Fetch bail contacts
            const { data: bailContactsData } = await supabase
              .from('bail_contacts')
              .select('*, contact_roles(name)')
              .or(`bail_court_id.eq.${bailData.id},region_id.eq.${bailData.region_id}`);
            
            if (bailContactsData) {
              bailContacts = bailContactsData.map((bc: any) => ({
                ...bc,
                role_name: bc.contact_roles?.name
              }));
            }

            // Fetch bail teams links
            const { data: bailTeamsData } = await supabase
              .from('teams_links')
              .select('*')
              .eq('bail_court_id', bailData.id);
            
            if (bailTeamsData) {
              bailTeamsLinks = bailTeamsData;
            }
          }
        }
      }

      // Use bail courts from search if no bail court from court lookup
      if (!bailCourt && bailCourts && bailCourts.length > 0) {
        bailCourt = bailCourts[0];
        
        // Fetch bail contacts and teams
        const { data: bailContactsData } = await supabase
          .from('bail_contacts')
          .select('*, contact_roles(name)')
          .or(`bail_court_id.eq.${bailCourt!.id},region_id.eq.${bailCourt!.region_id}`);
        
        if (bailContactsData) {
          bailContacts = bailContactsData.map((bc: any) => ({
            ...bc,
            role_name: bc.contact_roles?.name
          }));
        }

        const { data: bailTeamsData } = await supabase
          .from('teams_links')
          .select('*')
          .eq('bail_court_id', bailCourt!.id);
        
        if (bailTeamsData) {
          bailTeamsLinks = bailTeamsData;
        }
      }

      // Get region info for courts
      const enrichedCourts = await Promise.all(
        (courts || []).map(async (court: Court) => {
          const { data: region } = await supabase
            .from('regions')
            .select('code, name')
            .eq('id', court.region_id)
            .single();
          
          let contactHubName = null;
          if (court.is_circuit && court.contact_hub) {
            const { data: hubCourt } = await supabase
              .from('courts')
              .select('name')
              .eq('id', parseInt(court.contact_hub))
              .single();
            contactHubName = hubCourt?.name;
          }
          
          return {
            ...court,
            region_code: region?.code,
            region_name: region?.name,
            contact_hub_name: contactHubName
          };
        })
      );

      setResults({
        courts: enrichedCourts,
        contacts,
        sheriffCells: cells || [],
        teamsLinks,
        bailCourt,
        bailContacts,
        bailTeamsLinks
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
    clearResults
  };
}

// Hook to fetch full court details
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
      // Fetch court
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
        .select(`
          contacts (
            id,
            email,
            emails,
            contact_role_id
          )
        `)
        .eq('court_id', courtId);

      if (contactsData) {
        setContacts(
          contactsData
            .filter((cc: any) => cc.contacts)
            .map((cc: any) => cc.contacts)
        );
      }

      // Fetch sheriff cells linked to this court
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
        
        if (cellsData) {
          setSheriffCells(cellsData);
        }
      }

      // Also fetch courthouse cell if exists
      const { data: chCellData } = await supabase
        .from('sheriff_cells')
        .select('*')
        .eq('court_id', courtId);
      
      if (chCellData && chCellData.length > 0) {
        setSheriffCells(prev => {
          const existingIds = prev.map(c => c.id);
          const newCells = chCellData.filter((c: ShellCell) => !existingIds.includes(c.id));
          return [...prev, ...newCells];
        });
      }

      // Fetch teams links
      const { data: teamsData } = await supabase
        .from('teams_links')
        .select('*')
        .eq('court_id', courtId);
      
      if (teamsData) {
        setTeamsLinks(teamsData);
      }

      // Fetch bail info
      if (courtData.bail_hub_id) {
        const { data: bailData } = await supabase
          .from('bail_courts')
          .select('*')
          .eq('id', courtData.bail_hub_id)
          .single();
        
        if (bailData) {
          setBailCourt(bailData);
          
          // Fetch bail contacts
          const { data: bailContactsData } = await supabase
            .from('bail_contacts')
            .select('*, contact_roles(name)')
            .or(`bail_court_id.eq.${bailData.id},region_id.eq.${bailData.region_id}`);
          
          if (bailContactsData) {
            setBailContacts(bailContactsData.map((bc: any) => ({
              ...bc,
              role_name: bc.contact_roles?.name
            })));
          }

          // Fetch bail teams links
          const { data: bailTeamsData } = await supabase
            .from('teams_links')
            .select('*')
            .eq('bail_court_id', bailData.id);
          
          if (bailTeamsData) {
            setBailTeamsLinks(bailTeamsData);
          }
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

