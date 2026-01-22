'use client';

import { useState, useEffect, useCallback, useRef, useMemo } from 'react';
import Fuse from 'fuse.js';
import { useQuery } from '@tanstack/react-query';
import { fetchSearchIndexData, type SearchIndexData } from '@/lib/api/queries';
import { LOCATION_ALIASES, SEARCH_CONFIG, CACHE_CONFIG } from '@/lib/config/constants';
import type { Court, ContactWithRole, ShellCell, TeamsLink } from '@/types';

export interface SearchResults {
  courts: Court[];
  contacts: ContactWithRole[];
  cells: ShellCell[];
  teamsLinks: TeamsLink[];
}

interface FuseInstances {
  courts: Fuse<Court>;
  contacts: Fuse<ContactWithRole>;
  cells: Fuse<ShellCell>;
  teamsLinks: Fuse<TeamsLink>;
}

/**
 * Expand location aliases in search query
 */
function expandAliases(query: string): string {
  const lowerQuery = query.toLowerCase().trim();
  
  // Check for exact alias match
  if (LOCATION_ALIASES[lowerQuery]) {
    return LOCATION_ALIASES[lowerQuery];
  }
  
  // Check if query starts with an alias
  for (const [alias, expanded] of Object.entries(LOCATION_ALIASES)) {
    if (lowerQuery.startsWith(alias + ' ')) {
      return expanded + lowerQuery.slice(alias.length);
    }
  }
  
  return query;
}

/**
 * Create Fuse.js instances for each data type
 */
function createFuseInstances(data: SearchIndexData): FuseInstances {
  return {
    courts: new Fuse(data.courts, {
      ...SEARCH_CONFIG.FUSE_OPTIONS,
      keys: ['name', 'address'],
    }),
    contacts: new Fuse(data.contacts, {
      ...SEARCH_CONFIG.FUSE_OPTIONS,
      keys: ['role.name', 'email', 'phone'],
    }),
    cells: new Fuse(data.cells, {
      ...SEARCH_CONFIG.FUSE_OPTIONS,
      keys: ['name'],
    }),
    teamsLinks: new Fuse(data.teamsLinks, {
      ...SEARCH_CONFIG.FUSE_OPTIONS,
      keys: ['name'],
    }),
  };
}

export function useSearch() {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState<SearchResults>({
    courts: [],
    contacts: [],
    cells: [],
    teamsLinks: [],
  });
  const [isSearching, setIsSearching] = useState(false);
  
  const debounceRef = useRef<NodeJS.Timeout | null>(null);
  const fuseRef = useRef<FuseInstances | null>(null);

  // Fetch search index data using React Query
  const { data: indexData, isLoading: isLoadingIndex } = useQuery({
    queryKey: ['searchIndex'],
    queryFn: fetchSearchIndexData,
    staleTime: CACHE_CONFIG.STALE_TIME_MS,
    gcTime: CACHE_CONFIG.GC_TIME_MS,
  });

  // Create Fuse instances when data changes
  useEffect(() => {
    if (indexData) {
      fuseRef.current = createFuseInstances(indexData);
    }
  }, [indexData]);

  // Perform search
  const performSearch = useCallback((searchQuery: string) => {
    if (!fuseRef.current || !searchQuery.trim()) {
      setResults({ courts: [], contacts: [], cells: [], teamsLinks: [] });
      setIsSearching(false);
      return;
    }

    setIsSearching(true);

    // Expand aliases
    const expandedQuery = expandAliases(searchQuery);

    // Search each category
    const courtResults = fuseRef.current.courts.search(expandedQuery);
    const contactResults = fuseRef.current.contacts.search(expandedQuery);
    const cellResults = fuseRef.current.cells.search(expandedQuery);
    const teamsResults = fuseRef.current.teamsLinks.search(expandedQuery);

    setResults({
      courts: courtResults.map(r => r.item).slice(0, SEARCH_CONFIG.MAX_RESULTS),
      contacts: contactResults.map(r => r.item).slice(0, SEARCH_CONFIG.MAX_RESULTS),
      cells: cellResults.map(r => r.item).slice(0, SEARCH_CONFIG.MAX_RESULTS),
      teamsLinks: teamsResults.map(r => r.item).slice(0, SEARCH_CONFIG.MAX_RESULTS),
    });

    setIsSearching(false);
  }, []);

  // Debounced search
  const search = useCallback((newQuery: string) => {
    setQuery(newQuery);

    if (debounceRef.current) {
      clearTimeout(debounceRef.current);
    }

    if (!newQuery.trim() || newQuery.length < SEARCH_CONFIG.MIN_QUERY_LENGTH) {
      setResults({ courts: [], contacts: [], cells: [], teamsLinks: [] });
      return;
    }

    debounceRef.current = setTimeout(() => {
      performSearch(newQuery);
    }, SEARCH_CONFIG.DEBOUNCE_MS);
  }, [performSearch]);

  // Clear search
  const clearSearch = useCallback(() => {
    setQuery('');
    setResults({ courts: [], contacts: [], cells: [], teamsLinks: [] });
  }, []);

  // Total results count
  const totalResults = useMemo(() => 
    results.courts.length + 
    results.contacts.length + 
    results.cells.length + 
    results.teamsLinks.length,
    [results]
  );

  // Has results
  const hasResults = totalResults > 0;

  return {
    query,
    results,
    search,
    clearSearch,
    isSearching,
    isLoadingIndex,
    totalResults,
    hasResults,
  };
}
