'use client';

import { memo } from 'react';
import { Check, Copy, ChevronRight } from 'lucide-react';
import { Court, CourtContacts } from '@/types/database';

// Navigation Button Component
interface NavButtonProps {
  icon: React.ComponentType<{ size?: number }>;
  label: string;
  active: boolean;
  onClick: () => void;
}

export const NavButton = memo(function NavButton({ icon: Icon, label, active, onClick }: NavButtonProps) {
  return (
    <button
      onClick={onClick}
      className={`flex-1 flex flex-col items-center py-2 ${active ? 'text-white' : 'text-zinc-500'}`}
    >
      <Icon size={20} />
      <span className="text-xs mt-1">{label}</span>
    </button>
  );
});

// Court Card Component
interface CourtCardProps {
  court: Court;
  onClick: () => void;
}

export const CourtCard = memo(function CourtCard({ court, onClick }: CourtCardProps) {
  return (
    <button
      onClick={onClick}
      className="w-full text-left p-3 bg-zinc-900 border border-zinc-800 rounded-xl hover:border-zinc-700 transition-colors"
    >
      <div className="flex items-start justify-between gap-2">
        <div className="flex-1 min-w-0">
          <h3 className="font-medium text-white truncate">{court.name}</h3>
          <div className="flex items-center gap-2 mt-1 flex-wrap">
            {court.access_code && (
              <span className="text-xs px-2 py-0.5 bg-amber-500/20 text-amber-400 rounded">
                {court.access_code}
              </span>
            )}
            <span className="text-xs text-zinc-500">{court.region}</span>
          </div>
        </div>
        <div className="flex items-center gap-1 flex-shrink-0">
          {court.has_provincial && (
            <span className="text-[10px] px-1.5 py-0.5 bg-emerald-500/20 text-emerald-400 rounded">
              Prov
            </span>
          )}
          {court.has_supreme && (
            <span className="text-[10px] px-1.5 py-0.5 bg-blue-500/20 text-blue-400 rounded">
              Sup
            </span>
          )}
          <ChevronRight size={16} className="text-zinc-600 ml-1" />
        </div>
      </div>
      {court.is_circuit && court.hub_court_name && (
        <p className="text-xs text-zinc-500 mt-1">
          Contact: {court.hub_court_name}
        </p>
      )}
    </button>
  );
});

// Copy Button Component
interface CopyButtonProps {
  value: string;
  field: string;
  copiedField: string | null;
  onCopy: (text: string, field: string) => void;
  size?: 'sm' | 'md';
}

export const CopyButton = memo(function CopyButton({ 
  value, 
  field, 
  copiedField, 
  onCopy,
  size = 'md'
}: CopyButtonProps) {
  const isCopied = copiedField === field;
  const iconSize = size === 'sm' ? 14 : 16;
  
  return (
    <button
      onClick={() => onCopy(value, field)}
      className="flex items-center justify-center"
    >
      {isCopied ? (
        <Check size={iconSize} className="text-emerald-500" />
      ) : (
        <Copy size={iconSize} className="text-zinc-500" />
      )}
    </button>
  );
});

// Contact Section Component
interface ContactSectionProps {
  title: string;
  color: 'emerald' | 'blue' | 'amber' | 'purple';
  contacts: CourtContacts;
  fields: string[];
  faxFiling?: string;
  copiedField: string | null;
  onCopy: (text: string, field: string) => void;
}

const COLOR_CLASSES = {
  emerald: { border: 'border-emerald-500/30', bg: 'bg-emerald-500/5', text: 'text-emerald-500' },
  blue: { border: 'border-blue-500/30', bg: 'bg-blue-500/5', text: 'text-blue-500' },
  amber: { border: 'border-amber-500/30', bg: 'bg-amber-500/5', text: 'text-amber-500' },
  purple: { border: 'border-purple-500/30', bg: 'bg-purple-500/5', text: 'text-purple-500' }
};

const FIELD_LABELS: Record<string, string> = {
  registry_email: 'Registry',
  criminal_registry_email: 'Criminal Registry',
  jcm_scheduling_email: 'JCM Scheduling',
  scheduling_email: 'Scheduling',
  crown_email: 'Crown Counsel',
  bail_crown_email: 'Bail Crown',
  bail_jcm_email: 'Bail JCM',
  transcripts_email: 'Transcripts',
  interpreter_email: 'Interpreter Request',
  fax_filing: 'Fax Filing'
};

export const ContactSection = memo(function ContactSection({
  title,
  color,
  contacts,
  fields,
  faxFiling,
  copiedField,
  onCopy
}: ContactSectionProps) {
  const colorClasses = COLOR_CLASSES[color];
  const activeFields = fields.filter(f => contacts[f as keyof CourtContacts]);

  if (activeFields.length === 0 && !faxFiling) return null;

  return (
    <div className={`rounded-xl border ${colorClasses.border} ${colorClasses.bg}`}>
      <div className="px-3 py-2 border-b border-zinc-800/50">
        <h3 className={`text-xs uppercase tracking-wider ${colorClasses.text}`}>
          {title}
        </h3>
      </div>
      <div className="divide-y divide-zinc-800/50">
        {activeFields.map(field => {
          const value = contacts[field as keyof CourtContacts] as string;
          const fieldKey = `${field}-${value}`;
          return (
            <button
              key={field}
              onClick={() => onCopy(value, fieldKey)}
              className="w-full flex items-center justify-between px-3 py-2.5 hover:bg-zinc-800/50 active:bg-zinc-800 transition-colors text-left"
            >
              <div className="flex-1 min-w-0 pr-2">
                <p className="text-xs text-zinc-500">{FIELD_LABELS[field]}</p>
                <p className="text-sm text-white truncate">{value}</p>
              </div>
              <CopyButton
                value={value}
                field={fieldKey}
                copiedField={copiedField}
                onCopy={onCopy}
              />
            </button>
          );
        })}
        {faxFiling && (
          <button
            onClick={() => onCopy(faxFiling, 'fax_filing')}
            className="w-full flex items-center justify-between px-3 py-2.5 hover:bg-zinc-800/50 active:bg-zinc-800 transition-colors text-left border-t border-zinc-800/50"
          >
            <div className="flex-1 min-w-0 pr-2">
              <p className="text-xs text-zinc-500">Fax Filing</p>
              <p className="text-sm text-white">{faxFiling}</p>
            </div>
            <CopyButton
              value={faxFiling}
              field="fax_filing"
              copiedField={copiedField}
              onCopy={onCopy}
            />
          </button>
        )}
      </div>
    </div>
  );
});

// Toast Notification Component
interface ToastProps {
  message: string;
  visible: boolean;
  position?: 'bottom' | 'bottom-nav';
}

export const Toast = memo(function Toast({ message, visible, position = 'bottom' }: ToastProps) {
  if (!visible) return null;
  
  const positionClass = position === 'bottom-nav' ? 'bottom-24' : 'bottom-8';
  
  return (
    <div className={`fixed ${positionClass} left-1/2 -translate-x-1/2 px-4 py-2 bg-emerald-600 text-white rounded-full text-sm shadow-lg z-50`}>
      {message}
    </div>
  );
});

// Search Input Component
interface SearchInputProps {
  value: string;
  onChange: (value: string) => void;
  onClear: () => void;
  placeholder?: string;
  onSubmit?: () => void;
  rightElement?: React.ReactNode;
}

export const SearchInput = memo(function SearchInput({
  value,
  onChange,
  onClear,
  placeholder = 'Search...',
  onSubmit,
  rightElement
}: SearchInputProps) {
  const handleKeyDown = (e: React.KeyboardEvent) => {
    if (e.key === 'Enter' && onSubmit) {
      onSubmit();
    }
  };

  return (
    <div className="relative">
      <svg
        className="absolute left-3 top-1/2 -translate-y-1/2 text-zinc-500"
        width="18"
        height="18"
        viewBox="0 0 24 24"
        fill="none"
        stroke="currentColor"
        strokeWidth="2"
        strokeLinecap="round"
        strokeLinejoin="round"
      >
        <circle cx="11" cy="11" r="8" />
        <path d="m21 21-4.3-4.3" />
      </svg>
      <input
        type="text"
        value={value}
        onChange={(e) => onChange(e.target.value)}
        onKeyDown={handleKeyDown}
        placeholder={placeholder}
        className={`w-full pl-10 ${rightElement ? 'pr-20' : 'pr-10'} py-3 bg-zinc-900 border border-zinc-800 rounded-xl text-white placeholder-zinc-500 focus:outline-none focus:border-zinc-700`}
      />
      {value && (
        <button
          onClick={onClear}
          className={`absolute ${rightElement ? 'right-16' : 'right-3'} top-1/2 -translate-y-1/2 text-zinc-500 hover:text-white`}
        >
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
            <path d="M18 6 6 18M6 6l12 12" />
          </svg>
        </button>
      )}
      {rightElement && (
        <div className="absolute right-3 top-1/2 -translate-y-1/2">
          {rightElement}
        </div>
      )}
    </div>
  );
});

// Region Filter Pills Component
interface RegionFilterProps {
  regions: readonly string[];
  selectedRegion: string;
  onSelect: (region: string) => void;
  hideCircuit?: boolean;
  onToggleCircuit?: () => void;
}

export const RegionFilter = memo(function RegionFilter({
  regions,
  selectedRegion,
  onSelect,
  hideCircuit,
  onToggleCircuit
}: RegionFilterProps) {
  return (
    <div className="flex gap-2 overflow-x-auto pb-2 -mx-4 px-4 scrollbar-hide">
      <button
        onClick={() => onSelect('All')}
        className={`px-3 py-1.5 rounded-full text-sm whitespace-nowrap transition-colors ${
          selectedRegion === 'All'
            ? 'bg-white text-black'
            : 'bg-zinc-800 text-zinc-400'
        }`}
      >
        All
      </button>
      {regions.map(region => (
        <button
          key={region}
          onClick={() => onSelect(region)}
          className={`px-3 py-1.5 rounded-full text-sm whitespace-nowrap transition-colors ${
            selectedRegion === region
              ? 'bg-white text-black'
              : 'bg-zinc-800 text-zinc-400'
          }`}
        >
          {region}
        </button>
      ))}
      {onToggleCircuit !== undefined && (
        <button
          onClick={onToggleCircuit}
          className={`px-3 py-1.5 rounded-full text-sm whitespace-nowrap transition-colors flex items-center gap-1.5 ${
            hideCircuit
              ? 'bg-amber-500 text-black'
              : 'bg-zinc-800 text-zinc-400'
          }`}
        >
          <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
            <path d="M20 10c0 6-8 12-8 12s-8-6-8-12a8 8 0 0 1 16 0Z" />
            <circle cx="12" cy="10" r="3" />
          </svg>
          {hideCircuit ? 'Circuit Hidden' : 'Hide Circuit'}
        </button>
      )}
    </div>
  );
});
