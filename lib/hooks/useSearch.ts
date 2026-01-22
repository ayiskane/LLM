'use client';

import { useState, useCallback, useEffect } from 'react';
import { createClient } from '@/lib/api/supabase';
import type { Court, Contact, ShellCell, TeamsLink, BailCourt, BailContact } from '@/types';

// ============================================================================
// SEARCH RESULTS TYPE
// ============================================================================

export interface SearchResults {
  courts: Court[];
  contacts: Contact[];
  cells: ShellCell[];
  teamsLinks: TeamsLink[];
  bailCourt: BailCourt | null;
  bailContacts: BailContact[];
}

// ============================================================================
// SIMPLE SEARCH HOOK (Supabase only, no Fuse.js)
// ============================================================================

export function useSearch() {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState<SearchResults | null>(null);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const supabase = createClient();

  const search = useCallback(async (searchQuery: string) => {
    setQuery(searchQuery);
    
    if (!searchQuery || searchQuery.trim().length < 2) {
      setResults(null);
      return;
    }

    setIsLoading(true);
    setError(null);

    try {
      const term = searchQuery.trim().toLowerCase();
      
      // Search courts by name (simple ILIKE)
      const { data: courts, error: courtsError } = await supabase
        .from('courts')
        .select('*, regions(code, name)')
        .ilike('name', `%${term}%`)
        .eq('is_staffed', true)
        .limit(10);

      if (courtsError) throw courtsError;

      // Enrich courts with region data
      const enrichedCourts: Court[] = (courts || []).map((c: any) => ({
        ...c,
        region_code: c.regions?.code,
        region_name: c.regions?.name,
      }));

      // If we found courts, get related data for the first one
      let contacts: Contact[] = [];
      let cells: ShellCell[] = [];
      let teamsLinks: TeamsLink[] = [];
      let bailCourt: BailCourt | null = null;
      let bailContacts: BailContact[] = [];

      if (enrichedCourts.length > 0) {
        const courtId = enrichedCourts[0].id;

        // Get contacts
        const { data: contactsData } = await supabase
          .from('contacts_courts')
          .select('contact:contacts(*, contact_role:contact_roles(name))')
          .eq('court_id', courtId);

        if (contactsData) {
          contacts = contactsData
            .map((cc: any) => cc.contact)
            .filter(Boolean)
            .map((c: any) => ({ ...c, role_name: c.contact_role?.name }));
        }

        // Get cells
        const { data: cellsData } = await supabase
          .from('sheriff_cells_courts')
          .select('cell:sheriff_cells(*)')
          .eq('court_id', courtId);

        if (cellsData) {
          cells = cellsData.map((cc: any) => cc.cell).filter(Boolean);
        }

        // Get teams links
        const { data: teamsData } = await supabase
          .from('teams_links')
          .select('*')
          .eq('court_id', courtId);

        if (teamsData) {
          teamsLinks = teamsData;
        }

        // Get bail court
        const court = enrichedCourts[0];
        if (court.bail_hub_id) {
          const { data: bailData } = await supabase
            .from('bail_courts')
            .select('*')
            .eq('id', court.bail_hub_id)
            .single();

          if (bailData) {
            bailCourt = bailData;

            // Get bail contacts for region
            const { data: bailContactsData } = await supabase
              .from('bail_contacts')
              .select('*, contact_role:contact_roles(name)')
              .eq('region_id', bailData.region_id);

            if (bailContactsData) {
              bailContacts = bailContactsData.map((bc: any) => ({
                ...bc,
                role_name: bc.contact_role?.name,
              }));
            }
          }
        }
      }

      setResults({
        courts: enrichedCourts,
        contacts,
        cells,
        teamsLinks,
        bailCourt,
        bailContacts,
      });
    } catch (err) {
      console.error('Search error:', err);
      setError('Failed to search');
      setResults(null);
    } finally {
      setIsLoading(false);
    }
  }, [supabase]);

  const clearSearch = useCallback(() => {
    setQuery('');
    setResults(null);
    setError(null);
  }, []);

  return {
    query,
    results,
    isLoading,
    error,
    search,
    clearSearch,
    hasResults: results !== null && results.courts.length > 0,
  };
}

// ============================================================================
// COURT DETAILS HOOK
// ============================================================================

export interface CourtDetails {
  court: Court;
  contacts: Contact[];
  cells: ShellCell[];
  teamsLinks: TeamsLink[];
  bailCourt: BailCourt | null;
  bailContacts: BailContact[];
  bailTeamsLinks: TeamsLink[];
}

export function useCourtDetails(courtId: number | null) {
  const [data, setData] = useState<CourtDetails | null>(null);
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const supabase = createClient();

  useEffect(() => {
    if (!courtId) {
      setData(null);
      return;
    }

    const fetchDetails = async () => {
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

        const court: Court = {
          ...courtData,
          region_code: courtData.regions?.code,
          region_name: courtData.regions?.name,
        };

        // Fetch contacts
        const { data: contactsData } = await supabase
          .from('contacts_courts')
          .select('contact:contacts(*, contact_role:contact_roles(name))')
          .eq('court_id', courtId);

        const contacts: Contact[] = (contactsData || [])
          .map((cc: any) => cc.contact)
          .filter(Boolean)
          .map((c: any) => ({ ...c, role_name: c.contact_role?.name }));

        // Fetch cells
        const { data: cellsData } = await supabase
          .from('sheriff_cells_courts')
          .select('cell:sheriff_cells(*)')
          .eq('court_id', courtId);

        const cells: ShellCell[] = (cellsData || [])
          .map((cc: any) => cc.cell)
          .filter(Boolean);

        // Fetch teams links
        const { data: teamsData } = await supabase
          .from('teams_links')
          .select('*')
          .eq('court_id', courtId);

        const teamsLinks: TeamsLink[] = teamsData || [];

        // Fetch bail info
        let bailCourt: BailCourt | null = null;
        let bailContacts: BailContact[] = [];
        let bailTeamsLinks: TeamsLink[] = [];

        if (court.bail_hub_id) {
          const { data: bailData } = await supabase
            .from('bail_courts')
            .select('*')
            .eq('id', court.bail_hub_id)
            .single();

          if (bailData) {
            bailCourt = bailData;

            // Bail contacts
            const { data: bcData } = await supabase
              .from('bail_contacts')
              .select('*, contact_role:contact_roles(name)')
              .eq('region_id', bailData.region_id);

            bailContacts = (bcData || []).map((bc: any) => ({
              ...bc,
              role_name: bc.contact_role?.name,
            }));

            // Bail teams links
            const { data: btData } = await supabase
              .from('teams_links')
              .select('*')
              .eq('bail_court_id', bailData.id);

            bailTeamsLinks = btData || [];
          }
        }

        setData({
          court,
          contacts,
          cells,
          teamsLinks,
          bailCourt,
          bailContacts,
          bailTeamsLinks,
        });
      } catch (err) {
        console.error('Error fetching court details:', err);
        setError('Failed to load court details');
      } finally {
        setIsLoading(false);
      }
    };

    fetchDetails();
  }, [courtId, supabase]);

  return { data, isLoading, error };
}
