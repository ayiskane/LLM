'use client';

import { Telephone } from 'react-bootstrap-icons';
import { cn } from '@/lib/utils';
import type { ShellCell } from '@/types';

// ============================================================================
// HELPERS
// ============================================================================

function isPoliceCell(cell: ShellCell): boolean {
  const cellType = cell.cell_type?.toLowerCase() || '';
  const name = cell.name?.toLowerCase() || '';
  return cellType !== 'ch' && cellType !== 'courthouse' && 
         !name.includes('courthouse') && !name.includes(' ch ');
}

function getCellTypeLabel(cell: ShellCell): string {
  const name = cell.name?.toLowerCase() || '';
  if (name.includes('rcmp')) return 'RCMP';
  if (name.includes(' pd') || name.includes('police')) return 'PD';
  if (cell.cell_type === 'CH' || cell.cell_type === 'courthouse') return 'CH';
  return '';
}

// ============================================================================
// CELL ROW COMPONENT - Phone Pills Design
// ============================================================================

interface CellRowProps {
  cell: ShellCell;
}

function CellRow({ cell }: CellRowProps) {
  const isPolice = isPoliceCell(cell);
  const dotColor = isPolice ? 'bg-amber-400' : 'bg-blue-400';
  
  const handleCall = (phoneNumber: string) => {
    window.open(`tel:${phoneNumber.replace(/\D/g, '')}`, '_self');
  };

  return (
    <div className="py-3 border-b border-slate-700/30 last:border-b-0">
      {/* Cell name with color dot */}
      <div className="flex items-center gap-2 mb-2">
        <span className={cn('w-2 h-2 rounded-full shrink-0', dotColor)} />
        <span className="text-sm text-slate-200">{cell.name}</span>
      </div>
      
      {/* Phone pills */}
      {cell.phones && cell.phones.length > 0 && (
        <div className="flex flex-wrap gap-1.5 ml-4">
          {cell.phones.map((phone, idx) => (
            <button
              key={idx}
              onClick={() => handleCall(phone)}
              className="inline-flex items-center gap-1 px-2 py-1 rounded-md bg-slate-700/40 hover:bg-indigo-500/20 text-xs text-slate-300 hover:text-indigo-300 font-mono transition-colors"
            >
              <Telephone className="w-2.5 h-2.5" />
              {phone}
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
// CELL LIST COMPONENT
// ============================================================================

interface CellListProps {
  cells: ShellCell[];
  maxDisplay?: number;
}

export function CellList({ cells, maxDisplay = 20 }: CellListProps) {
  if (cells.length === 0) return null;

  // Sort: police/RCMP first, then courthouse
  const sortedCells = [...cells].sort((a, b) => {
    const aIsPolice = isPoliceCell(a);
    const bIsPolice = isPoliceCell(b);
    if (aIsPolice && !bIsPolice) return -1;
    if (!aIsPolice && bIsPolice) return 1;
    return a.name.localeCompare(b.name);
  });

  const displayCells = sortedCells.slice(0, maxDisplay);

  return (
    <div className="rounded-lg bg-slate-800/30 border border-slate-700/50 px-4">
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
