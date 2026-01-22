'use client';

import { forwardRef, useState } from 'react';
import { ChevronDown } from 'react-bootstrap-icons';
import { cn } from '@/lib/utils';
import { colors as themeColors, sectionColors } from '@/lib/config/theme';

export type SectionColor = keyof typeof sectionColors;

interface SectionProps {
  title: string;
  count?: number | string;
  color?: SectionColor;
  defaultOpen?: boolean;
  isExpanded?: boolean;
  onToggle?: () => void;
  children: React.ReactNode;
  className?: string;
}

export const Section = forwardRef<HTMLDivElement, SectionProps>(
  ({ title, count, color = 'blue', defaultOpen = false, isExpanded, onToggle, children, className }, ref) => {
    const [internalOpen, setInternalOpen] = useState(defaultOpen);
    
    // Support both controlled and uncontrolled modes
    const isOpen = isExpanded !== undefined ? isExpanded : internalOpen;
    const handleToggle = onToggle ?? (() => setInternalOpen(!internalOpen));
    
    const colorConfig = sectionColors[color];

    return (
      <div
        ref={ref}
        className={cn('rounded-lg overflow-hidden', className)}
        style={{ 
          background: themeColors.bg.card, 
          border: `1px solid ${themeColors.border.primary}` 
        }}
      >
        {/* Header */}
        <button
          onClick={handleToggle}
          className="w-full flex items-center gap-2.5 p-3 transition-colors"
          style={{ 
            background: isOpen ? themeColors.bg.cardHover : 'transparent', 
            borderBottom: `1px solid ${themeColors.border.subtle}` 
          }}
        >
          {/* Dot indicator */}
          <span className="text-[6px]" style={{ color: colorConfig.dot }}>●</span>
          
          {/* Title */}
          <span 
            className="flex-1 text-left"
            style={{
              fontSize: '13px',
              textTransform: 'uppercase',
              letterSpacing: '0.1em',
              color: themeColors.text.secondary,
              fontWeight: 500,
            }}
          >
            {title}
          </span>
          
          {/* Count badge */}
          {count !== undefined && count !== '' && (
            <span 
              className="px-1.5 py-0.5 rounded text-[10px]"
              style={{ 
                fontFamily: 'monospace',
                background: colorConfig.bg, 
                color: colorConfig.text 
              }}
            >
              {count}
            </span>
          )}
          
          {/* Chevron */}
          <ChevronDown
            className={cn(
              'w-4 h-4 transition-transform duration-200',
              isOpen && 'rotate-180'
            )}
            style={{ color: themeColors.text.subtle }}
          />
        </button>

        {/* Content */}
        <div
          className={cn(
            'overflow-hidden transition-all duration-200',
            isOpen ? 'max-h-[2000px] opacity-100' : 'max-h-0 opacity-0'
          )}
        >
          <div style={{ background: 'rgba(59,130,246,0.02)' }}>
            {children}
          </div>
        </div>
      </div>
    );
  }
);

Section.displayName = 'Section';
