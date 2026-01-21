'use client';

import { Telephone } from 'react-bootstrap-icons';
import type { ShellCell } from '@/types';

// Common abbreviations for court names
const COURT_ABBREVS: Record<string, string> = {
  'Abbotsford': 'Abbotsford',
  'Chilliwack': 'Chilliwack',
  'Kelowna': 'Kelowna',
  'Kamloops': 'Kamloops',
  'Nanaimo': 'Nanaimo',
  'New Westminster': 'New West',
  'North Vancouver': 'North Van',
  'Port Coquitlam': 'PoCo',
  'Prince George': 'Prince George',
  'Robson Square': 'Robson Sq',
  'Surrey': 'Surrey',
  'Vancouver': 'Vancouver',
  'Victoria': 'Victoria',
  'Vernon': 'Vernon',
  'Cranbrook': 'Cranbrook',
  'Penticton': 'Penticton',
  'Courtenay': 'Courtenay',
  'Duncan': 'Duncan',
  'Salmon Arm': 'Salmon Arm',
  'Nelson': 'Nelson',
  'Terrace': 'Terrace',
  'Prince Rupert': 'Prince Rupert',
  'Williams Lake': 'Williams Lake',
  'Fort St John': 'Fort St John',
  'Dawson Creek': 'Dawson Creek',
  'Quesnel': 'Quesnel',
  'Campbell River': 'Campbell River',
  'Powell River': 'Powell River',
  'Maple Ridge': 'Maple Ridge',
  'Richmond': 'Richmond',
  'Burnaby': 'Burnaby',
  'Coquitlam': 'Coquitlam',
  'Langley': 'Langley',
  'White Rock': 'White Rock',
};

// Format cell name for display
function formatCellName(cell: ShellCell): string {
  const name = cell.name || '';
  
  // Handle courthouse cells - extract location and format as "Location CH Cells"
  if (cell.cell_type === 'CH' || cell.cell_type === 'courthouse' || name.toLowerCase().includes('courthouse')) {
    // Try to extract the location from the name
    // Common patterns: "Abbotsford Courthouse", "Abbotsford CH", "Abbotsford Cells", etc.
    let location = name
      .replace(/\s*(Courthouse|CH|Law Courts?|Provincial|Court|Cells?)\s*/gi, '')
      .trim();
    
    // If we have an abbreviation, use it
    for (const [full, abbrev] of Object.entries(COURT_ABBREVS)) {
      if (location.toLowerCase() === full.toLowerCase()) {
        location = abbrev;
        break;
      }
    }
    
    // If location is empty, just show "CH Cells"
    if (!location) {
      return 'CH Cells';
    }
    
    return `${location} CH Cells`;
  }
  
  // Check if it's a PD (Police Department)
  if (name.includes(' PD') || name.includes(' Police')) {
    const baseName = name.replace(' PD', '').replace(' Police', '').replace(' Cells', '').trim();
    return `${baseName} PD Cells`;
  }
  
  // Check if it's RCMP
  if (name.includes('RCMP')) {
    const baseName = name.replace(' RCMP', '').replace(' Cells', '').trim();
    return `${baseName} RCMP`;
  }
  
  // Default - just return the name
  return name;
}

interface CellRowProps {
  cell: ShellCell;
}

function CellRow({ cell }: CellRowProps) {
  const phones = Array.isArray(cell.phones) ? cell.phones : [];
  const displayName = formatCellName(cell);

  return (
    <div className="py-3 border-b border-slate-700/30 last:border-b-0">
      <div className="text-sm text-slate-200 mb-1.5">{displayName}</div>
      {phones.length > 0 && (
        <div className="space-y-1">
          {phones.map((phone, idx) => (
            <a 
              key={idx}
              href={`tel:${phone}`}
              className="flex items-center gap-2 text-slate-400 hover:text-indigo-400 transition-colors"
            >
              <Telephone className="w-3.5 h-3.5" />
              <span className="text-sm">{phone}</span>
            </a>
          ))}
        </div>
      )}
    </div>
  );
}

// Full list of cells for search results
interface CellsListProps {
  cells: ShellCell[];
  maxDisplay?: number;
}

export function CellsList({ cells, maxDisplay = 10 }: CellsListProps) {
  // Separate courthouse cells and RCMP/PD cells
  const chCells = cells.filter(c => c.cell_type === 'CH' || c.cell_type === 'courthouse');
  const policeCells = cells.filter(c => c.cell_type !== 'CH' && c.cell_type !== 'courthouse');
  
  // Sort police cells by name
  policeCells.sort((a, b) => a.name.localeCompare(b.name));
  
  // Combine: police first, then courthouse
  const sortedCells = [...policeCells, ...chCells].slice(0, maxDisplay);
  
  if (sortedCells.length === 0) return null;

  return (
    <div className="space-y-2">
      <h4 className="text-xs font-medium text-slate-400 uppercase tracking-wide px-1">Sheriff Cells</h4>
      <div className="bg-slate-800/30 rounded-lg border border-slate-700/50 overflow-hidden px-4">
        {sortedCells.map((cell) => (
          <CellRow key={cell.id} cell={cell} />
        ))}
      </div>
      {cells.length > maxDisplay && (
        <div className="text-xs text-slate-500 text-center py-1">
          +{cells.length - maxDisplay} more
        </div>
      )}
    </div>
  );
}

// Compact cell preview for search results - grouped in one card
export function CellsPreview({ cells }: { cells: ShellCell[] }) {
  // Get one of each type: police first, then courthouse
  const policeCell = cells.find(c => c.cell_type !== 'CH' && c.cell_type !== 'courthouse');
  const chCell = cells.find(c => c.cell_type === 'CH' || c.cell_type === 'courthouse');
  
  const displayCells = [policeCell, chCell].filter((c): c is ShellCell => c !== undefined);
  
  if (displayCells.length === 0) return null;

  return (
    <div className="space-y-2">
      <h4 className="text-xs font-medium text-slate-400 uppercase tracking-wide px-1">Sheriff Cells</h4>
      <div className="bg-slate-800/30 rounded-lg border border-slate-700/50 overflow-hidden px-4">
        {displayCells.map((cell) => (
          <CellRow key={cell.id} cell={cell} />
        ))}
        {cells.length > 2 && (
          <div className="text-xs text-slate-500 text-center py-2 border-t border-slate-700/30">
            +{cells.length - 2} more cells
          </div>
        )}
      </div>
    </div>
  );
}

// Legacy export for compatibility
export function CellCard({ cell }: { cell: ShellCell }) {
  return <CellRow cell={cell} />;
}
