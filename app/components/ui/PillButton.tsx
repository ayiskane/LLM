'use client';

import { cn } from '@/lib/utils';
import { colors } from '@/lib/config/theme';

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
        'inline-flex items-center gap-1.5 px-3 py-1.5 rounded-md text-sm font-medium whitespace-nowrap transition-colors',
        className
      )}
      style={isActive 
        ? { 
            background: 'rgba(59,130,246,0.25)', 
            border: '1px solid rgba(59,130,246,0.4)',
            color: '#93c5fd'
          }
        : { 
            background: colors.bg.item, 
            border: `1px solid ${colors.border.accent}`, 
            color: colors.text.muted 
          }
      }
    >
      {children}
    </button>
  );
}
