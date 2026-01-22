// =============================================================================
// CENTRALIZED THEME - All styling constants in one place
// =============================================================================

// Card styles
export const cardClasses = {
  base: 'bg-slate-800/30 rounded-lg border border-slate-700/50',
  padded: 'bg-slate-800/30 rounded-lg border border-slate-700/50 p-4',
  divided: 'bg-slate-800/30 rounded-lg border border-slate-700/50 divide-y divide-slate-700/50',
  interactive: 'bg-slate-800/30 rounded-lg border border-slate-700/50 hover:bg-slate-800/50 transition-colors cursor-pointer',
} as const;

// Text styles
export const textClasses = {
  // Section headers (COURT CONTACTS, CROWN CONTACTS, SCHEDULE, etc.)
  sectionHeader: 'text-xs text-slate-500 uppercase tracking-wide',
  // Role labels (CRIMINAL REGISTRY, PROVINCIAL CROWN, etc.)
  roleLabel: 'text-[10px] text-slate-400 uppercase font-medium',
  // Schedule labels (TRIAGE, COURT, CUTOFF, YOUTH)
  scheduleLabel: 'text-xs font-mono font-semibold uppercase text-slate-300',
  scheduleLabelAmber: 'text-xs font-mono font-semibold uppercase text-amber-400',
  // Values
  value: 'text-sm text-slate-300',
  valueMono: 'font-mono text-sm text-slate-400',
  // Muted text
  muted: 'text-xs text-slate-500',
  // Links
  link: 'text-blue-400 hover:text-blue-300 transition-colors',
} as const;

// Button styles
export const buttonClasses = {
  primary: 'bg-blue-600 hover:bg-blue-500 text-white px-4 py-2 rounded-lg font-medium transition-colors',
  secondary: 'bg-slate-700 hover:bg-slate-600 text-slate-200 px-4 py-2 rounded-lg font-medium transition-colors',
  ghost: 'text-slate-400 hover:text-slate-200 hover:bg-slate-700/50 px-2 py-1 rounded transition-colors',
  icon: 'p-2 rounded-lg hover:bg-slate-700/50 text-slate-400 hover:text-slate-200 transition-colors',
  join: 'bg-gradient-to-r from-purple-600 to-blue-600 hover:from-purple-500 hover:to-blue-500 text-white px-3 py-1.5 rounded-lg text-sm font-medium transition-all',
} as const;

// Icon sizes
export const iconClasses = {
  xs: 'w-3 h-3',
  sm: 'w-3.5 h-3.5',
  md: 'w-4 h-4',
  lg: 'w-5 h-5',
  xl: 'w-6 h-6',
} as const;

// Accordion colors
export const accordionColors = {
  blue: {
    dot: 'bg-blue-400',
    border: 'border-l-blue-500/50',
    hover: 'hover:bg-slate-800/50',
  },
  purple: {
    dot: 'bg-purple-400',
    border: 'border-l-purple-500/50',
    hover: 'hover:bg-slate-800/50',
  },
  teal: {
    dot: 'bg-teal-400',
    border: 'border-l-teal-500/50',
    hover: 'hover:bg-slate-800/50',
  },
  amber: {
    dot: 'bg-amber-400',
    border: 'border-l-amber-500/50',
    hover: 'hover:bg-slate-800/50',
  },
  slate: {
    dot: 'bg-slate-400',
    border: 'border-l-slate-500/50',
    hover: 'hover:bg-slate-800/50',
  },
} as const;

// Inline styles (for properties not in Tailwind)
export const inlineStyles = {
  sectionHeader: { 
    fontFamily: 'Inter, sans-serif', 
    letterSpacing: '1px' 
  },
  roleLabel: { 
    fontFamily: 'Inter, sans-serif', 
    letterSpacing: '1px' 
  },
  scheduleLabel: { 
    letterSpacing: '1px' 
  },
} as const;

// Animation classes
export const animationClasses = {
  fadeIn: 'animate-fade-in',
  slideUp: 'animate-slide-up',
  slideDown: 'animate-slide-down',
  transition: 'transition-all duration-200 ease-out',
} as const;

// =============================================================================
// HELPER FUNCTIONS
// =============================================================================

/**
 * Combine class names (like clsx/cn)
 */
export function cn(...classes: (string | undefined | null | false)[]): string {
  return classes.filter(Boolean).join(' ');
}

/**
 * Get section header props for consistent styling
 */
export function getSectionHeaderStyle() {
  return {
    className: textClasses.sectionHeader,
    style: inlineStyles.sectionHeader,
  };
}

/**
 * Get role label props for consistent styling
 */
export function getRoleLabelStyle() {
  return {
    className: textClasses.roleLabel,
    style: inlineStyles.roleLabel,
  };
}

/**
 * Get schedule label class
 */
export function getScheduleLabelClass(isAmber = false) {
  return isAmber ? textClasses.scheduleLabelAmber : textClasses.scheduleLabel;
}
