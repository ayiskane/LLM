'use client';

// Re-export search hooks
export { useSearch, useCourtDetails } from './useSearch';
export type { SearchResults, CourtDetails } from './useSearch';

// Re-export other hooks
export { useCopyToClipboard } from './useCopyToClipboard';
export { useScrollHeader } from './useScrollHeader';
