'use client';

import { Telephone } from 'react-bootstrap-icons';
import { Card } from '@/app/components/ui/Card';
import { cn, textClasses, iconClasses, cardClasses } from '@/lib/config/theme';
import { formatPhone, makeCall } from '@/lib/utils';
import type { ShellCell } from '@/types';

interface CellCardProps {
  cell: ShellCell;
}

export function CellCard({ cell }: CellCardProps) {
  const handleCall = (phone: string) => {
    makeCall(phone);
  };

  return (
    <Card className="p-3">
      <div className="font-medium text-slate-200 text-sm mb-2">
        {cell.name}
      </div>
      
      {cell.phones && cell.phones.length > 0 && (
        <div className="flex flex-wrap items-center gap-2">
          {cell.phones.map((phone, idx) => (
            <button
              key={idx}
              onClick={() => handleCall(phone)}
              className={cn(
                'inline-flex items-center gap-1.5 px-2 py-1 rounded',
                'bg-slate-700/50 text-slate-300 text-sm',
                'hover:bg-slate-700 hover:text-white transition-colors'
              )}
            >
              <Telephone className={iconClasses.xs} />
              {formatPhone(phone)}
            </button>
          ))}
        </div>
      )}
      
      {cell.notes && (
        <div className={cn(textClasses.muted, 'mt-2')}>
          {cell.notes}
        </div>
      )}
    </Card>
  );
}

// Cell list component
interface CellListProps {
  cells: ShellCell[];
}

export function CellList({ cells }: CellListProps) {
  if (cells.length === 0) return null;

  return (
    <div className="space-y-2">
      {cells.map(cell => (
        <CellCard key={cell.id} cell={cell} />
      ))}
    </div>
  );
}
