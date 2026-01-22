'use client';

import { cn } from '@/lib/utils';

// Pill colors from backup theme
const pillStyles = {
  active: {
    background: 'rgba(59,130,246,0.25)',
    border: '1px solid rgba(59,130,246,0.4)',
    color: '#93c5fd',
  },
  inactive: {
    background: 'rgba(59,130,246,0.04)',
    border: '1px solid rgba(59,130,246,0.15)',
    color: '#a1a1aa',
  },
} as const;

interface PillButtonProps {
  children: React.ReactNode;
  isActive?: boolean;
  onClick?: () => void;
  className?: string;
}

export function PillButton({ children, isActive = false, onClick, className }: PillButtonProps) {
  return (
    <button
      onClick={onClick}
      className={cn(
        'flex items-center gap-1.5 px-3 py-1.5 rounded-md text-xs font-medium whitespace-nowrap transition-colors',
        className
      )}
      style={isActive ? pillStyles.active : pillStyles.inactive}
    >
      {children}
    </button>
  );
}
