'use client';

import { useState, forwardRef } from 'react';
import { ChevronDown } from 'react-bootstrap-icons';
import { cn, accordionColors } from '@/lib/config/theme';

interface SectionProps {
  title: string;
  count?: string | number;
  color?: keyof typeof accordionColors;
  defaultOpen?: boolean;
  children: React.ReactNode;
}

export const Section = forwardRef<HTMLDivElement, SectionProps>(
  ({ title, count, color = 'slate', defaultOpen = false, children }, ref) => {
    const [isOpen, setIsOpen] = useState(defaultOpen);
    const colors = accordionColors[color];

    return (
      <div
        ref={ref}
        className={cn(
          'rounded-lg overflow-hidden border-l-2',
          colors.border,
          'bg-slate-900/50'
        )}
      >
        {/* Header */}
        <button
          onClick={() => setIsOpen(!isOpen)}
          className={cn(
            'w-full px-4 py-3 flex items-center justify-between',
            'text-left transition-colors',
            colors.hover
          )}
        >
          <div className="flex items-center gap-2">
            <div className={cn('w-2 h-2 rounded-full', colors.dot)} />
            <span className="text-sm font-medium text-slate-200 uppercase tracking-wide">
              {title}
            </span>
            {count !== undefined && (
              <span className="text-xs text-slate-400 bg-slate-800/50 px-2 py-0.5 rounded">
                {count}
              </span>
            )}
          </div>
          <ChevronDown
            className={cn(
              'w-4 h-4 text-slate-400 transition-transform duration-200',
              isOpen && 'rotate-180'
            )}
          />
        </button>

        {/* Content */}
        <div
          className={cn(
            'overflow-hidden transition-all duration-200',
            isOpen ? 'max-h-[2000px] opacity-100' : 'max-h-0 opacity-0'
          )}
        >
          <div className="px-4 pb-4">
            {children}
          </div>
        </div>
      </div>
    );
  }
);

Section.displayName = 'Section';
