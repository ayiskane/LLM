'use client';

import { cn } from '@/lib/utils';

interface StickyHeaderProps {
  children: React.ReactNode;
  className?: string;
}

export function StickyHeader({ children, className }: StickyHeaderProps) {
  return (
    <div 
      className={cn(
        'flex-shrink-0 bg-slate-900/95 backdrop-blur-md border-b border-slate-700/50',
        className
      )}
    >
      {children}
    </div>
  );
}
