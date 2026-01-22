'use client';

import { useQuery } from '@tanstack/react-query';
import { fetchCourtDetails } from '@/lib/api/queries';
import { CACHE_CONFIG } from '@/lib/config/constants';
import type { CourtDetails } from '@/types';

/**
 * Hook to fetch court details with React Query caching
 * Returns error as string for consistent error display
 */
export function useCourtDetails(courtId: number | null) {
  const query = useQuery<CourtDetails | null, Error>({
    queryKey: ['courtDetails', courtId],
    queryFn: () => courtId ? fetchCourtDetails(courtId) : Promise.resolve(null),
    enabled: !!courtId,
    staleTime: CACHE_CONFIG.STALE_TIME_MS,
    gcTime: CACHE_CONFIG.GC_TIME_MS,
  });

  return {
    data: query.data ?? null,
    isLoading: query.isLoading,
    error: query.error?.message ?? null,  // Convert Error to string
    refetch: query.refetch,
  };
}
