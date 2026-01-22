// ============================================================================
// LLM: LEGAL LEGENDS MANUAL - THEME CONFIGURATION (OPTIMIZED)
// ============================================================================
// Slimmed down theme tokens - colors now handled by CSS variables in globals.css
// Button variants handled by shadcn cva in components/ui/button.tsx
// ============================================================================

// Re-export cn from lib/utils (shadcn version with tailwind-merge)
export { cn } from '@/lib/utils';

// ============================================================================
// TEXT CLASSES - Typography tokens
// ============================================================================

export const textClasses = {
  // Headers
  sectionHeader: 'text-xs text-slate-500 uppercase tracking-wider',
  roleLabel: 'text-[10px] text-slate-400 uppercase font-medium tracking-wide',
  scheduleLabel: 'text-xs font-mono font-semibold uppercase tracking-wide',
  
  // Content
  muted: 'text-xs text-slate-500',
  subtle: 'text-sm text-slate-400',
  
  // Interactive
  link: 'text-blue-400 hover:text-blue-300 transition-colors cursor-pointer',
} as const;

// ============================================================================
// ICON CLASSES - Size tokens for react-bootstrap-icons
// ============================================================================

export const iconClasses = {
  xs: 'w-3 h-3',
  sm: 'w-4 h-4',
  md: 'w-5 h-5',
  lg: 'w-6 h-6',
} as const;

// ============================================================================
// CARD CLASSES - Additional card styling (base handled by shadcn Card)
// ============================================================================

export const cardClasses = {
  // Interactive card variant (for clickable cards like BailHubLink)
  interactive: 'bg-slate-800/30 rounded-lg border border-slate-700/50 cursor-pointer hover:bg-slate-800/50 hover:border-slate-600/50 transition-all',
} as const;

// ============================================================================
// ACCORDION COLORS - For Section component
// ============================================================================

export const accordionColors = {
  slate: {
    border: 'border-slate-600',
    dot: 'bg-slate-400',
    hover: 'hover:bg-slate-800/50',
  },
  emerald: {
    border: 'border-emerald-500/50',
    dot: 'bg-emerald-400',
    hover: 'hover:bg-emerald-500/10',
  },
  blue: {
    border: 'border-blue-500/50',
    dot: 'bg-blue-400',
    hover: 'hover:bg-blue-500/10',
  },
  amber: {
    border: 'border-amber-500/50',
    dot: 'bg-amber-400',
    hover: 'hover:bg-amber-500/10',
  },
  purple: {
    border: 'border-purple-500/50',
    dot: 'bg-purple-400',
    hover: 'hover:bg-purple-500/10',
  },
  cyan: {
    border: 'border-cyan-500/50',
    dot: 'bg-cyan-400',
    hover: 'hover:bg-cyan-500/10',
  },
  rose: {
    border: 'border-rose-500/50',
    dot: 'bg-rose-400',
    hover: 'hover:bg-rose-500/10',
  },
} as const;

// ============================================================================
// HELPER FUNCTIONS - Props generators for common patterns
// ============================================================================

/**
 * Get section header props (className + style)
 */
export function getSectionHeaderProps() {
  return {
    className: textClasses.sectionHeader,
    style: { letterSpacing: '0.1em' } as const,
  };
}

/**
 * Get role label props (className + optional letter spacing)
 */
export function getRoleLabelProps(withLetterSpacing = true) {
  return {
    className: textClasses.roleLabel,
    ...(withLetterSpacing && { style: { letterSpacing: '0.05em' } as const }),
  };
}

/**
 * Get schedule label class with optional amber highlight
 */
export function getScheduleLabelClass(isAmber = false) {
  return `${textClasses.scheduleLabel} ${isAmber ? 'text-amber-400' : 'text-slate-300'}`;
}

// ============================================================================
// TYPE EXPORTS
// ============================================================================

export type AccordionColor = keyof typeof accordionColors;
