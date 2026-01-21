'use client';

import { Telephone } from 'react-bootstrap-icons';
import type { ShellCell } from '@/types';

// Common abbreviations for court names
const COURT_ABBREVS: Record<string, string> = {
  'Abbotsford Law Courts': 'Abbotsford',
  'Chilliwack Law Courts': 'Chilliwack',
  'Kelowna Law Courts': 'Kelowna',
  'Kamloops Law Courts': 'Kamloops',
  'Nanaimo Law Courts': 'Nanaimo',
  'New Westminster Law Courts': 'New West',
  'North Vancouver Law Courts': 'North Van',
  'Port Coquitlam Law Courts': 'PoCo',
  'Prince George Law Courts': 'Prince George',
  'Robson Square Provincial Court': 'Robson Sq',
  'Surrey Provincial Court': 'Surrey',
  'Vancouver Law Courts': 'Vancouver',
  'Victoria Law Courts': 'Victoria',
  'Vernon Law Courts': 'Vernon',
  'Cranbrook Law Courts': 'Cranbrook',
  'Penticton Law Courts': 'Penticton',
  'Courtenay Law Courts': 'Courtenay',
  'Duncan Law Courts': 'Duncan',
  'Salmon Arm Law Courts': 'Salmon Arm',
  'Nelson Law Courts': 'Nelson',
  'Terrace Law Courts': 'Terrace',
  'Prince Rupert Law Courts': 'Prince Rupert',
  'Williams Lake Law Courts': 'Williams Lake',
  'Fort St John Law Courts': 'Fort St John',
  'Dawson Creek Law Courts': 'Dawson Creek',
  'Quesnel Law Courts': 'Quesnel',
  'Campbell River Law Courts': 'Campbell River',
  'Powell River Law Courts': 'Powell River',
  'Maple Ridge Law Courts': 'Maple Ridge',
  'Richmond Law Courts': 'Richmond',
  'Burnaby Law Courts': 'Burnaby',
  'Coquitlam Law Courts': 'Coquitlam',
  'Langley Law Courts': 'Langley',
  'White Rock Law Courts': 'White Rock',
  // Without "Law Courts" suffix
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
};

// Get abbreviated court name
function getCourtAbbrev(courtName: string): string {
  // Check exact match first
  if (COURT_ABBREVS[courtName]) {
    return COURT_ABBREVS[courtName];
  }
  
  // Try to extract just the city name
  const cityMatch = courtName.match(/^([A-Za-z\s]+?)(?:\s+(?:Law Courts?|Provincial Court|Court))?$/i);
  if (cityMatch) {
    const city = cityMatch[1].trim();
    if (COURT_ABBREVS[city]) {
      return COURT_ABBREVS[city];
    }
    return city;
  }
  
  return courtName;
}

// Format cell name for display
function formatCellName(cell: ShellCell): string {
  const name = cell.name || '';
  
  // Handle courthouse cells - use court_name if available, otherwise extract from name
  if (cell.cell_type === 'CH' || cell.cell_type === 'courthouse' || name.toLowerCase().includes('courthouse')) {
    // If we have the court name from the join, use it
    if (cell.court_name) {
      const abbrev = getCourtAbbrev(cell.court_name);
      return `${abbrev} CH Cells`;
    }
    
    // Try to extract the location from the cell name
    let location = name
      .replace(/\s*(Courthouse|CH|Law Courts?|Provincial|Court|Cells?)\s*/gi, '')
      .trim();
    
    if (location) {
      const abbrev = getCourtAbbrev(location);
      return `${abbrev} CH Cells`;
    }
    
    return 'CH Cells';
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
