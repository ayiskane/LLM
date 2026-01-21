'use client';

import { Phone, Shield } from 'lucide-react';
import type { ShellCell } from '@/types';

interface CellCardProps {
  cell: ShellCell;
}

export function CellCard({ cell }: CellCardProps) {
  const phones = Array.isArray(cell.phones) ? cell.phones : [];
  const isCourtCell = cell.cell_type === 'courthouse';
  
  // Format display name
  const displayName = isCourtCell 
    ? 'CH Cells'
    : cell.name.replace(' RCMP', '').replace(' PD', '').replace(' Police', '');

  return (
    <div className="py-2 px-3 rounded-lg bg-slate-800/30">
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-2 flex-1 min-w-0">
          <Shield className="w-4 h-4 text-slate-400 flex-shrink-0" />
          <span className="text-sm text-slate-200 truncate">{displayName}</span>
        </div>
        
        <div className="flex items-center gap-2 flex-shrink-0 ml-2">
          {phones.slice(0, 1).map((phone, idx) => (
            <a 
              key={idx}
              href={`tel:${phone}`}
              className="flex items-center gap-1 px-2 py-1 bg-slate-700/50 rounded text-xs text-slate-300 hover:bg-slate-700 transition-colors"
            >
              <Phone className="w-3 h-3" />
              <span>{phone}</span>
            </a>
          ))}
        </div>
      </div>
      
      {/* Additional phones if multiple */}
      {phones.length > 1 && (
        <div className="flex flex-wrap gap-1.5 mt-1.5 ml-6">
          {phones.slice(1).map((phone, idx) => (
            <a 
              key={idx}
              href={`tel:${phone}`}
              className="text-xs text-slate-400 hover:text-slate-300 transition-colors"
            >
              {phone}
            </a>
          ))}
        </div>
      )}
    </div>
  );
}

// List of cells for search results
interface CellsListProps {
  cells: ShellCell[];
  maxDisplay?: number;
}

export function CellsList({ cells, maxDisplay = 5 }: CellsListProps) {
  // Separate courthouse cells and RCMP/PD cells
  const chCells = cells.filter(c => c.cell_type === 'courthouse');
  const policeCells = cells.filter(c => c.cell_type !== 'courthouse');
  
  // Sort by name
  policeCells.sort((a, b) => a.name.localeCompare(b.name));
  
  // Combine: courthouse first, then police
  const sortedCells = [...chCells, ...policeCells].slice(0, maxDisplay);
  
  if (sortedCells.length === 0) return null;

  return (
    <div className="space-y-1.5">
      <h4 className="text-xs font-medium text-slate-400 uppercase tracking-wide px-1">Cells</h4>
      {sortedCells.map((cell) => (
        <CellCard key={cell.id} cell={cell} />
      ))}
      {cells.length > maxDisplay && (
        <div className="text-xs text-slate-500 text-center py-1">
          +{cells.length - maxDisplay} more
        </div>
      )}
    </div>
  );
}

// Compact cell display for search results
export function CellsPreview({ cells }: { cells: ShellCell[] }) {
  const chCell = cells.find(c => c.cell_type === 'courthouse');
  const rcmpCell = cells.find(c => c.cell_type !== 'courthouse');
  
  const displayCells = [chCell, rcmpCell].filter((c): c is ShellCell => c !== null);
  
  if (displayCells.length === 0) return null;

  return (
    <div className="space-y-1">
      {displayCells.map((cell) => (
        <CellCard key={cell.id} cell={cell} />
      ))}
    </div>
  );
}
