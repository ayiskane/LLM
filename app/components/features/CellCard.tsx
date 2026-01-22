'use client';

import { Telephone } from 'react-bootstrap-icons';
import { cn, textClasses, iconClasses, cardClasses } from '@/lib/config/theme';
import type { ShellCell } from '@/types';

// ============================================================================
// CELL ROW COMPONENT (matches backup exactly)
// ============================================================================

interface CellRowProps {
  cell: ShellCell;
}

function CellRow({ cell }: CellRowProps) {
  const handleCall = (phoneNumber: string) => {
    window.open(`tel:${phoneNumber.replace(/\D/g, '')}`, '_self');
  };

  return (
    <div className={cardClasses.row}>
      <div className={cn(textClasses.secondary, 'text-sm mb-1.5')}>{cell.name}</div>
      {cell.phones && cell.phones.length > 0 && (
        <div className="flex items-center gap-3">
          {cell.phones.map((phone, idx) => (
            <button
              key={idx}
              onClick={() => handleCall(phone)}
              className="flex items-center gap-2 text-slate-400 hover:text-indigo-400 transition-colors"
            >
              <Telephone className={iconClasses.xs} />
              <span className="text-xs">{phone}</span>
            </button>
          ))}
        </div>
      )}
    </div>
  );
}

// ============================================================================
// CELL CARD (single cell - for compatibility)
// ============================================================================

interface CellCardProps {
  cell: ShellCell;
}

export function CellCard({ cell }: CellCardProps) {
  return <CellRow cell={cell} />;
}

// ============================================================================
// CELL LIST COMPONENT (matches backup - unified container with rows)
// ============================================================================

interface CellListProps {
  cells: ShellCell[];
  maxDisplay?: number;
}

export function CellList({ cells, maxDisplay = 20 }: CellListProps) {
  const displayCells = cells.slice(0, maxDisplay);
  
  if (displayCells.length === 0) return null;

  return (
    <div className={cardClasses.containerPadded}>
      {displayCells.map((cell) => (
        <CellRow key={cell.id} cell={cell} />
      ))}
      {cells.length > maxDisplay && (
        <div className="text-xs text-slate-500 text-center py-2 border-t border-slate-700/30">
          +{cells.length - maxDisplay} more
        </div>
      )}
    </div>
  );
}
