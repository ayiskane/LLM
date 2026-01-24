'use client';

import { useState, useMemo, useCallback } from 'react';
import { FaMagnifyingGlass, FaXmark, FaBuildingShield, FaLocationDot, FaPhone, FaSliders } from '@/lib/icons';
import { cn } from '@/lib/config/theme';
import { useCorrectionsCentres } from '@/lib/hooks/useCorrectionsCentres';
import type { CorrectionsCentreWithRegion } from '@/lib/hooks/useCorrectionsCentres';

// =============================================================================
// CONSTANTS
// =============================================================================

const REGIONS = [
  { id: 0, name: 'All Regions', code: 'ALL' },
  { id: 1, name: 'Island', code: 'R1' },
  { id: 3, name: 'Fraser', code: 'R3' },
  { id: 4, name: 'Interior', code: 'R4' },
  { id: 5, name: 'Northern', code: 'R5' },
] as const;

const REGION_COLORS: Record<number, { dot: string; tag: string }> = {
  1: { dot: 'bg-amber-500', tag: 'bg-amber-500/15 text-amber-400' },
  2: { dot: 'bg-blue-500', tag: 'bg-blue-500/15 text-blue-400' },
  3: { dot: 'bg-emerald-500', tag: 'bg-emerald-500/15 text-emerald-400' },
  4: { dot: 'bg-purple-500', tag: 'bg-purple-500/15 text-purple-400' },
  5: { dot: 'bg-cyan-500', tag: 'bg-cyan-500/15 text-cyan-400' },
};

type GenderFilter = 'all' | 'men' | 'women';
type TypeFilter = 'all' | 'pretrial' | 'sentenced';

interface Filters {
  region: number;
  gender: GenderFilter;
  type: TypeFilter;
}

// =============================================================================
// SUB-COMPONENTS
// =============================================================================

interface SearchBarProps {
  value: string;
  onChange: (value: string) => void;
  onClear: () => void;
  onFilterClick: () => void;
  hasActiveFilters: boolean;
}

function SearchBar({ value, onChange, onClear, onFilterClick, hasActiveFilters }: SearchBarProps) {
  return (
    <div className="flex gap-2">
      <div className="relative flex-1">
        <div className="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400">
          <FaMagnifyingGlass className="w-4 h-4" />
        </div>
        <input
          type="text"
          value={value}
          onChange={(e) => onChange(e.target.value)}
          placeholder="Search centres..."
          className={cn(
            'w-full bg-slate-800/50 border border-slate-700/50 rounded-xl',
            'pl-11 pr-10 py-3 text-sm',
            'text-slate-200 placeholder:text-slate-500',
            'focus:outline-none focus:ring-2 focus:ring-blue-500/40 focus:border-blue-500/40',
            'transition-all duration-200'
          )}
        />
        {value && (
          <button
            onClick={onClear}
            className="absolute right-4 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-200 transition-colors"
          >
            <FaXmark className="w-4 h-4" />
          </button>
        )}
      </div>
      <button
        onClick={onFilterClick}
        className={cn(
          'relative flex items-center justify-center w-12 rounded-xl border transition-all',
          hasActiveFilters
            ? 'bg-blue-500/20 border-blue-500/50 text-blue-400'
            : 'bg-slate-800/50 border-slate-700/50 text-slate-400 hover:text-slate-200'
        )}
      >
        <FaSliders className="w-4 h-4" />
        {hasActiveFilters && (
          <span className="absolute -top-1 -right-1 w-2.5 h-2.5 bg-blue-500 rounded-full" />
        )}
      </button>
    </div>
  );
}

interface FilterPanelProps {
  isOpen: boolean;
  filters: Filters;
  onFilterChange: (filters: Filters) => void;
  onClearAll: () => void;
}

function FilterPanel({ isOpen, filters, onFilterChange, onClearAll }: FilterPanelProps) {
  if (!isOpen) return null;

  const genderOptions: { value: GenderFilter; label: string }[] = [
    { value: 'all', label: 'All' },
    { value: 'men', label: 'Men' },
    { value: 'women', label: 'Women' },
  ];

  const typeOptions: { value: TypeFilter; label: string }[] = [
    { value: 'all', label: 'All' },
    { value: 'pretrial', label: 'Pretrial' },
    { value: 'sentenced', label: 'Sentenced' },
  ];

  const hasFilters = filters.region !== 0 || filters.gender !== 'all' || filters.type !== 'all';

  return (
    <div className="border-t border-slate-700/30 bg-slate-900/50">
      <div className="px-4 py-3 space-y-3">
        {/* Region Filter */}
        <div>
          <label className="text-[10px] uppercase tracking-wider text-slate-500 mb-1.5 block">Region</label>
          <div className="flex flex-wrap gap-1.5">
            {REGIONS.map((region) => (
              <button
                key={region.id}
                onClick={() => onFilterChange({ ...filters, region: region.id })}
                className={cn(
                  'px-2.5 py-1.5 rounded-lg text-xs font-medium transition-all',
                  'flex items-center gap-1.5',
                  filters.region === region.id
                    ? 'bg-blue-500/20 text-blue-400 border border-blue-500/30'
                    : 'bg-slate-800/50 text-slate-400 border border-slate-700/50 hover:border-slate-600'
                )}
              >
                {region.id !== 0 && (
                  <span className={cn('w-1.5 h-1.5 rounded-full', REGION_COLORS[region.id]?.dot)} />
                )}
                {region.name}
              </button>
            ))}
          </div>
        </div>

        {/* Gender Filter */}
        <div>
          <label className="text-[10px] uppercase tracking-wider text-slate-500 mb-1.5 block">Gender</label>
          <div className="flex gap-1.5">
            {genderOptions.map((option) => (
              <button
                key={option.value}
                onClick={() => onFilterChange({ ...filters, gender: option.value })}
                className={cn(
                  'px-2.5 py-1.5 rounded-lg text-xs font-medium transition-all',
                  filters.gender === option.value
                    ? 'bg-blue-500/20 text-blue-400 border border-blue-500/30'
                    : 'bg-slate-800/50 text-slate-400 border border-slate-700/50 hover:border-slate-600'
                )}
              >
                {option.label}
              </button>
            ))}
          </div>
        </div>

        {/* Type Filter */}
        <div>
          <label className="text-[10px] uppercase tracking-wider text-slate-500 mb-1.5 block">Type</label>
          <div className="flex gap-1.5">
            {typeOptions.map((option) => (
              <button
                key={option.value}
                onClick={() => onFilterChange({ ...filters, type: option.value })}
                className={cn(
                  'px-2.5 py-1.5 rounded-lg text-xs font-medium transition-all',
                  filters.type === option.value
                    ? 'bg-blue-500/20 text-blue-400 border border-blue-500/30'
                    : 'bg-slate-800/50 text-slate-400 border border-slate-700/50 hover:border-slate-600'
                )}
              >
                {option.label}
              </button>
            ))}
          </div>
        </div>

        {/* Clear All */}
        {hasFilters && (
          <button
            onClick={onClearAll}
            className="text-xs text-slate-400 hover:text-slate-200 underline underline-offset-2"
          >
            Clear all filters
          </button>
        )}
      </div>
    </div>
  );
}

interface CentreCardProps {
  centre: CorrectionsCentreWithRegion;
}

function CentreCard({ centre }: CentreCardProps) {
  const regionColors = REGION_COLORS[centre.region_id] || { tag: 'bg-slate-500/15 text-slate-400' };
  
  // Format phone for tel: link
  const phoneLink = centre.phone.replace(/[^0-9]/g, '');

  return (
    <div className="px-4 py-3 border-b border-slate-800/50 hover:bg-slate-800/30 transition-colors">
      <div className="flex items-start gap-3">
        <div className="flex-shrink-0 w-10 h-10 rounded-lg bg-slate-800/80 flex items-center justify-center">
          <FaBuildingShield className="w-5 h-5 text-slate-400" />
        </div>
        <div className="flex-1 min-w-0">
          <div className="flex items-center gap-2 mb-1">
            <h3 className="text-sm font-medium text-slate-100 truncate">
              {centre.name}
            </h3>
          </div>
          <div className="flex items-center gap-2 text-xs text-slate-500 mb-2">
            <FaLocationDot className="w-3 h-3 flex-shrink-0" />
            <span className="truncate">{centre.city}</span>
            <span className={cn('px-1.5 py-0.5 rounded text-[10px] font-medium', regionColors.tag)}>
              {centre.region_name}
            </span>
          </div>
          <a 
            href={`tel:+1${phoneLink}`}
            className="inline-flex items-center gap-1.5 text-xs text-blue-400 hover:text-blue-300 transition-colors"
          >
            <FaPhone className="w-3 h-3" />
            {centre.phone}
          </a>
          {centre.is_women_only && (
            <span className="ml-2 px-1.5 py-0.5 rounded text-[10px] font-medium bg-pink-500/15 text-pink-400">
              Women
            </span>
          )}
          {centre.is_pretrial && (
            <span className="ml-2 px-1.5 py-0.5 rounded text-[10px] font-medium bg-amber-500/15 text-amber-400">
              Pretrial
            </span>
          )}
        </div>
      </div>
    </div>
  );
}

// =============================================================================
// MAIN COMPONENT
// =============================================================================

export function CorrectionsIndexPage() {
  const { centres, isLoading, error } = useCorrectionsCentres();
  const [searchQuery, setSearchQuery] = useState('');
  const [isFilterOpen, setIsFilterOpen] = useState(false);
  const [filters, setFilters] = useState<Filters>({
    region: 0,
    gender: 'all',
    type: 'all',
  });

  const hasActiveFilters = filters.region !== 0 || filters.gender !== 'all' || filters.type !== 'all';

  const clearAllFilters = useCallback(() => {
    setFilters({ region: 0, gender: 'all', type: 'all' });
    setSearchQuery('');
  }, []);

  // Filter centres
  const filteredCentres = useMemo(() => {
    let result = centres;

    // Filter by region
    if (filters.region !== 0) {
      result = result.filter(centre => centre.region_id === filters.region);
    }

    // Filter by gender
    if (filters.gender === 'women') {
      result = result.filter(centre => centre.is_women_only);
    } else if (filters.gender === 'men') {
      result = result.filter(centre => !centre.is_women_only);
    }

    // Filter by type
    if (filters.type === 'pretrial') {
      result = result.filter(centre => centre.is_pretrial);
    } else if (filters.type === 'sentenced') {
      result = result.filter(centre => !centre.is_pretrial);
    }

    // Filter by search
    if (searchQuery.trim()) {
      const query = searchQuery.toLowerCase();
      result = result.filter(centre => 
        centre.name.toLowerCase().includes(query) ||
        centre.city.toLowerCase().includes(query) ||
        centre.region_name.toLowerCase().includes(query)
      );
    }

    return result;
  }, [centres, filters, searchQuery]);

  // Loading state
  if (isLoading) {
    return (
      <div className="h-screen bg-[hsl(222.2,84%,4.9%)] flex items-center justify-center">
        <div className="flex flex-col items-center gap-4">
          <div className="w-8 h-8 border-2 border-blue-500/30 border-t-blue-500 rounded-full animate-spin" />
          <p className="text-slate-400 text-sm">Loading corrections centres...</p>
        </div>
      </div>
    );
  }

  // Error state
  if (error) {
    return (
      <div className="h-screen bg-[hsl(222.2,84%,4.9%)] flex items-center justify-center p-4">
        <div className="text-center">
          <p className="text-red-400 mb-2">Failed to load corrections centres</p>
          <p className="text-slate-500 text-sm">{error}</p>
        </div>
      </div>
    );
  }

  return (
    <div className="h-screen flex flex-col bg-[hsl(222.2,84%,4.9%)] overflow-hidden">
      {/* Fixed Header */}
      <div className="flex-shrink-0 bg-[rgba(8,11,18,0.98)] border-b border-blue-500/10">
        {/* Title */}
        <div className="px-4 pt-4 pb-2">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-xl font-bold text-white">BC Corrections Index</h1>
              <p className="text-xs text-slate-500 mt-0.5">Provincial correctional centres</p>
            </div>
          </div>
        </div>

        {/* Search + Filter Button */}
        <div className="px-4 pb-3">
          <SearchBar
            value={searchQuery}
            onChange={setSearchQuery}
            onClear={() => setSearchQuery('')}
            onFilterClick={() => setIsFilterOpen(!isFilterOpen)}
            hasActiveFilters={hasActiveFilters}
          />
        </div>

        {/* Filter Panel */}
        <FilterPanel
          isOpen={isFilterOpen}
          filters={filters}
          onFilterChange={setFilters}
          onClearAll={clearAllFilters}
        />
      </div>

      {/* Scrollable List */}
      <div className="flex-1 overflow-y-auto">
        {filteredCentres.length === 0 ? (
          <div className="flex flex-col items-center justify-center py-20 px-4">
            <FaBuildingShield className="w-12 h-12 text-slate-700 mb-4" />
            <p className="text-slate-400 text-center">
              {searchQuery 
                ? `No centres found for "${searchQuery}"`
                : 'No centres match your filters'
              }
            </p>
            {(searchQuery || hasActiveFilters) && (
              <button
                onClick={clearAllFilters}
                className="mt-4 text-blue-400 text-sm hover:text-blue-300 transition-colors"
              >
                Clear filters
              </button>
            )}
          </div>
        ) : (
          <>
            {filteredCentres.map((centre) => (
              <CentreCard key={centre.id} centre={centre} />
            ))}
            {/* Footer with count */}
            <div className="py-4 text-center">
              <span className="text-xs text-slate-500">
                {filteredCentres.length} {filteredCentres.length === 1 ? 'centre' : 'centres'}
              </span>
            </div>
          </>
        )}
      </div>
    </div>
  );
}
