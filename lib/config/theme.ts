// ============================================================================
// LLM: LEGAL LEGENDS MANUAL - THEME CONFIGURATION
// ============================================================================
// Centralized theme tokens matching backup branch styling exactly
// ============================================================================

export { cn } from '@/lib/utils';

// ============================================================================
// COLOR TOKENS
// ============================================================================

export const colors = {
  accent: {
    blue: '#60a5fa',
    emerald: '#34d399',
    purple: '#a78bfa',
    amber: '#fbbf24',
    cyan: '#22d3ee',
    rose: '#fb7185',
    teal: '#2dd4bf',
    indigo: '#a5b4fc',
    zinc: '#71717a',
  },
  border: {
    primary: 'rgba(59,130,246,0.12)',
    subtle: 'rgba(59,130,246,0.08)',
    accent: 'rgba(59,130,246,0.15)',
    accentHover: 'rgba(59,130,246,0.4)',
  },
  bg: {
    primary: '#080b12',
    card: 'rgba(59,130,246,0.03)',
    cardHover: 'rgba(59,130,246,0.06)',
    item: 'rgba(59,130,246,0.04)',
    header: 'rgba(8,11,18,0.95)',
    subtle: 'rgba(59,130,246,0.02)',
  },
  text: {
    primary: '#ffffff',
    secondary: '#e4e4e7',
    muted: '#a1a1aa',
    subtle: '#71717a',
    disabled: '#52525b',
  },
} as const;

// ============================================================================
// SECTION COLORS - For Tags and Section components
// ============================================================================

export const sectionColors = {
  emerald: { dot: '#34d399', bg: 'rgba(16,185,129,0.15)', text: '#34d399' },
  blue: { dot: '#60a5fa', bg: 'rgba(59,130,246,0.15)', text: '#60a5fa' },
  amber: { dot: '#fbbf24', bg: 'rgba(245,158,11,0.15)', text: '#fbbf24' },
  cyan: { dot: '#22d3ee', bg: 'rgba(34,211,238,0.15)', text: '#22d3ee' },
  indigo: { dot: '#a5b4fc', bg: 'rgba(99,102,241,0.15)', text: '#a5b4fc' },
  purple: { dot: '#a78bfa', bg: 'rgba(139,92,246,0.15)', text: '#a78bfa' },
  teal: { dot: '#2dd4bf', bg: 'rgba(20,184,166,0.15)', text: '#2dd4bf' },
  rose: { dot: '#fb7185', bg: 'rgba(244,63,94,0.15)', text: '#fb7185' },
} as const;

export type SectionColor = keyof typeof sectionColors;

// ============================================================================
// CONTACT CATEGORY COLORS - For accent bars
// ============================================================================

export type ContactCategory = 'court' | 'provincial' | 'supreme' | 'bail' | 'other';

export const contactCategoryColors: Record<ContactCategory, string> = {
  court: '#60a5fa',
  provincial: '#34d399',
  supreme: '#a78bfa',
  bail: '#fbbf24',
  other: '#71717a',
} as const;

// ============================================================================
// TEXT CLASSES - Matches backup exactly
// ============================================================================

export const textClasses = {
  // Headers
  sectionHeader: 'text-xs text-slate-500 uppercase px-1',
  roleLabel: 'text-[9px] text-slate-400 uppercase mb-1',
  scheduleLabel: 'text-xs font-mono font-semibold uppercase',
  lastUpdated: 'text-xs text-slate-500 uppercase',
  
  // Body text
  primary: 'text-white',
  secondary: 'text-slate-200',
  muted: 'text-slate-300',
  subtle: 'text-slate-400',
  disabled: 'text-slate-500',
  
  // Monospace
  mono: 'font-mono',
  monoSm: 'text-xs font-mono',
  monoValue: 'text-slate-400 text-xs font-mono',
  
  // Interactive
  link: 'text-blue-400 hover:text-blue-300 transition-colors cursor-pointer',
} as const;

// ============================================================================
// ICON CLASSES
// ============================================================================

export const iconClasses = {
  xs: 'w-3 h-3',
  sm: 'w-3.5 h-3.5',
  md: 'w-4 h-4',
  lg: 'w-5 h-5',
} as const;

// ============================================================================
// CARD CLASSES - Matches backup exactly
// ============================================================================

export const cardClasses = {
  container: 'bg-slate-800/30 rounded-lg border border-slate-700/50 overflow-hidden',
  containerPadded: 'bg-slate-800/30 rounded-lg border border-slate-700/50 overflow-hidden px-4',
  containerDivided: 'bg-slate-800/30 rounded-lg border border-slate-700/50 overflow-hidden divide-y divide-slate-700/50',
  interactive: 'cursor-pointer hover:bg-slate-800 transition-colors active:bg-slate-700',
  row: 'py-3 border-b border-slate-700/30 last:border-b-0',
  flexRow: 'flex justify-between px-4 py-2.5',
  coupon: 'flex items-stretch rounded-lg overflow-hidden cursor-pointer transition-all hover:border-blue-500/40',
} as const;

export const couponCardStyles = {
  container: {
    background: 'rgba(59,130,246,0.03)',
    border: '1px dashed rgba(59,130,246,0.25)',
  },
  divider: {
    borderLeft: '1px dashed rgba(59,130,246,0.25)',
  },
} as const;

// ============================================================================
// INLINE STYLES - Matches backup exactly
// ============================================================================

export const inlineStyles = {
  sectionHeader: { fontFamily: 'Inter, sans-serif', letterSpacing: '1px' } as const,
  roleLabelSpaced: { fontFamily: 'Inter, sans-serif', letterSpacing: '1px' } as const,
  roleLabelNormal: { fontFamily: 'Inter, sans-serif' } as const,
  scheduleLabel: { letterSpacing: '1px' } as const,
  regionTag: { letterSpacing: '2px' } as const,
  letterSpacing: {
    wide: { letterSpacing: '1px' } as const,
    wider: { letterSpacing: '2px' } as const,
  },
} as const;

// ============================================================================
// ACCORDION COLORS
// ============================================================================

export const accordionColors = {
  slate: { border: 'border-slate-600', dot: 'bg-slate-400', hover: 'hover:bg-slate-800/50' },
  emerald: { border: 'border-emerald-500/50', dot: 'bg-emerald-400', hover: 'hover:bg-emerald-500/10' },
  blue: { border: 'border-blue-500/50', dot: 'bg-blue-400', hover: 'hover:bg-blue-500/10' },
  amber: { border: 'border-amber-500/50', dot: 'bg-amber-400', hover: 'hover:bg-amber-500/10' },
  purple: { border: 'border-purple-500/50', dot: 'bg-purple-400', hover: 'hover:bg-purple-500/10' },
  cyan: { border: 'border-cyan-500/50', dot: 'bg-cyan-400', hover: 'hover:bg-cyan-500/10' },
  rose: { border: 'border-rose-500/50', dot: 'bg-rose-400', hover: 'hover:bg-rose-500/10' },
  teal: { border: 'border-teal-500/50', dot: 'bg-teal-400', hover: 'hover:bg-teal-500/10' },
  indigo: { border: 'border-indigo-500/50', dot: 'bg-indigo-400', hover: 'hover:bg-indigo-500/10' },
} as const;

export type AccordionColor = keyof typeof accordionColors;

// ============================================================================
// HELPER FUNCTIONS
// ============================================================================

export function getSectionHeaderProps() {
  return {
    className: textClasses.sectionHeader,
    style: inlineStyles.sectionHeader,
  };
}

export function getRoleLabelProps(withLetterSpacing = true) {
  return {
    className: textClasses.roleLabel,
    style: withLetterSpacing ? inlineStyles.roleLabelSpaced : inlineStyles.roleLabelNormal,
  };
}

export function getTagStyles(color: SectionColor) {
  return {
    background: sectionColors[color].bg,
    color: sectionColors[color].text,
    letterSpacing: '2px',
  };
}

export function getContactCategoryColor(category: ContactCategory): string {
  return contactCategoryColors[category];
}

export function getToggleButtonStyles(isActive: boolean) {
  return {
    background: isActive ? 'rgba(59,130,246,0.15)' : 'transparent',
    border: `1px solid ${isActive ? colors.border.accentHover : colors.border.primary}`,
    color: isActive ? colors.accent.blue : colors.text.disabled,
  };
}

export function getScheduleLabelClass(isAmber = false) {
  return `${textClasses.scheduleLabel} ${isAmber ? 'text-amber-400' : 'text-slate-300'}`;
}
