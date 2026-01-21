// Search Parser - Extracts intent and entities from search queries

export interface ParsedQuery {
  // Original query
  raw: string;
  
  // Primary search term (court name, location, etc.)
  courtTerm: string | null;
  
  // Filters extracted from query
  filters: {
    courtroom: string | null;      // "204" from "abby 204"
    contactType: string | null;    // "crown", "jcm", "registry"
    cellType: string | null;       // "rcmp", "pd", "ch" (courthouse)
    region: number | null;         // 1-5 from "r1", "r2", etc.
    entityType: string | null;     // "courts", "contacts", "cells", "teams", "bail"
  };
  
  // Search intent
  intent: 'court_lookup' | 'contact_lookup' | 'cell_lookup' | 'teams_lookup' | 'bail_lookup' | 'general';
}

// Contact type keywords and their role IDs
const CONTACT_TYPE_MAP: Record<string, { roleIds: number[]; label: string }> = {
  'crown': { roleIds: [1], label: 'Crown' },
  'crowns': { roleIds: [1], label: 'Crown' },
  'provincial': { roleIds: [1], label: 'Provincial Crown' },
  'jcm': { roleIds: [2, 13], label: 'JCM' },
  'judicial': { roleIds: [2, 13], label: 'JCM' },
  'registry': { roleIds: [9, 10], label: 'Registry' },
  'criminal': { roleIds: [10], label: 'Criminal Registry' },
  'scheduling': { roleIds: [8], label: 'SC Scheduling' },
  'supreme': { roleIds: [8], label: 'SC Scheduling' },
  'sheriff': { roleIds: [3], label: 'Sheriff QB' },
  'federal': { roleIds: [6], label: 'Federal Crown' },
  'ppsc': { roleIds: [6], label: 'Federal Crown' },
  'navigator': { roleIds: [5], label: 'LABC Navigator' },
  'labc': { roleIds: [5], label: 'LABC Navigator' },
  'bail': { roleIds: [12, 13], label: 'Bail' },
  'transcripts': { roleIds: [14], label: 'Transcripts' },
  'coordinator': { roleIds: [21], label: 'Coordinator' },
  'fnc': { roleIds: [23], label: 'First Nations Crown' },
  'first nations': { roleIds: [23], label: 'First Nations Crown' },
};

// Cell type keywords
const CELL_TYPE_MAP: Record<string, string> = {
  'rcmp': 'RCMP',
  'pd': 'PD',
  'police': 'PD',
  'municipal': 'PD',
  'ch': 'CH',
  'courthouse': 'CH',
  'cells': 'ALL',  // Generic cells search
  'cell': 'ALL',
};

// Region keywords
const REGION_MAP: Record<string, number> = {
  'r1': 1, 'region1': 1, 'island': 1, 'vancouver island': 1,
  'r2': 2, 'region2': 2, 'coastal': 2, 'vancouver coastal': 2,
  'r3': 3, 'region3': 3, 'fraser': 3,
  'r4': 4, 'region4': 4, 'interior': 4,
  'r5': 5, 'region5': 5, 'northern': 5, 'north': 5,
  'fed': 6, 'federal': 6,
};

// Entity type keywords
const ENTITY_TYPE_MAP: Record<string, string> = {
  'courts': 'courts',
  'court': 'courts',
  'contacts': 'contacts',
  'contact': 'contacts',
  'cells': 'cells',
  'cell': 'cells',
  'teams': 'teams',
  'link': 'teams',
  'links': 'teams',
  'bail': 'bail',
  'virtual bail': 'bail',
  'vb': 'bail',
};

// Common typos and fuzzy matches for court names
const COURT_ALIASES: Record<string, string> = {
  // Typos
  'abotsford': 'abbotsford',
  'abbotford': 'abbotsford',
  'abottsford': 'abbotsford',
  'chilwack': 'chilliwack',
  'chillwack': 'chilliwack',
  'kelowna': 'kelowna',
  'klowna': 'kelowna',
  'kamloop': 'kamloops',
  'nanaino': 'nanaimo',
  'nanimo': 'nanaimo',
  'pringe george': 'prince george',
  'prince goerge': 'prince george',
  'vancover': 'vancouver',
  'vancuver': 'vancouver',
  'victora': 'victoria',
  'surey': 'surrey',
  'surry': 'surrey',
  'new west': 'new westminster',
  'newwest': 'new westminster',
  // Short forms (already in DB but good to normalize)
  'abby': 'abbotsford',
  'abb': 'abbotsford',
  'chl': 'chilliwack',
  'chilli': 'chilliwack',
  'cwk': 'chilliwack',
  'kam': 'kamloops',
  'kel': 'kelowna',
  'nan': 'nanaimo',
  'nw': 'new westminster',
  'pg': 'prince george',
  'prg': 'prince george',
  'sur': 'surrey',
  'van': 'vancouver',
  'vic': 'victoria',
  'poco': 'port coquitlam',
  'coquitlam': 'port coquitlam',
  '222': 'vancouver', // 222 Main
  'dcc': 'vancouver', // Downtown Community Court
  'robson': 'vancouver', // Robson Square
};

export function parseSearchQuery(query: string): ParsedQuery {
  const raw = query.trim();
  const normalized = raw.toLowerCase();
  const parts = normalized.split(/\s+/);
  
  const result: ParsedQuery = {
    raw,
    courtTerm: null,
    filters: {
      courtroom: null,
      contactType: null,
      cellType: null,
      region: null,
      entityType: null,
    },
    intent: 'general',
  };
  
  const courtTermParts: string[] = [];
  
  for (let i = 0; i < parts.length; i++) {
    const part = parts[i];
    const nextPart = parts[i + 1];
    let matched = false;
    
    // Check for courtroom number (1-3 digits)
    const courtroomMatch = part.match(/^(\d{1,3})$/);
    if (courtroomMatch) {
      result.filters.courtroom = courtroomMatch[1];
      result.intent = 'teams_lookup';
      matched = true;
      continue;
    }
    
    // Check for "cr204" pattern
    const crMatch = part.match(/^cr(\d{1,3})$/i);
    if (crMatch) {
      result.filters.courtroom = crMatch[1];
      result.intent = 'teams_lookup';
      matched = true;
      continue;
    }
    
    // Check for contact type
    if (CONTACT_TYPE_MAP[part]) {
      result.filters.contactType = part;
      result.intent = 'contact_lookup';
      matched = true;
      continue;
    }
    
    // Check for "first nations" (two words)
    if (part === 'first' && nextPart === 'nations') {
      result.filters.contactType = 'first nations';
      result.intent = 'contact_lookup';
      i++; // Skip next part
      matched = true;
      continue;
    }
    
    // Check for cell type
    if (CELL_TYPE_MAP[part]) {
      result.filters.cellType = CELL_TYPE_MAP[part];
      result.intent = 'cell_lookup';
      matched = true;
      continue;
    }
    
    // Check for region
    if (REGION_MAP[part]) {
      result.filters.region = REGION_MAP[part];
      matched = true;
      continue;
    }
    
    // Check for "vancouver island" (two words for region)
    if (part === 'vancouver' && nextPart === 'island') {
      result.filters.region = 1;
      i++;
      matched = true;
      continue;
    }
    
    // Check for "vancouver coastal" (two words for region)
    if (part === 'vancouver' && nextPart === 'coastal') {
      result.filters.region = 2;
      i++;
      matched = true;
      continue;
    }
    
    // Check for entity type
    if (ENTITY_TYPE_MAP[part]) {
      result.filters.entityType = ENTITY_TYPE_MAP[part];
      matched = true;
      continue;
    }
    
    // Check for "virtual bail" (two words)
    if (part === 'virtual' && nextPart === 'bail') {
      result.filters.entityType = 'bail';
      result.intent = 'bail_lookup';
      i++;
      matched = true;
      continue;
    }
    
    // If not matched, it's part of the court search term
    if (!matched) {
      // Apply typo correction / alias normalization
      const corrected = COURT_ALIASES[part] || part;
      courtTermParts.push(corrected);
    }
  }
  
  // Set court term
  if (courtTermParts.length > 0) {
    result.courtTerm = courtTermParts.join(' ');
  }
  
  // Determine intent if not already set
  if (result.intent === 'general') {
    if (result.filters.entityType === 'bail') {
      result.intent = 'bail_lookup';
    } else if (result.filters.contactType) {
      result.intent = 'contact_lookup';
    } else if (result.filters.cellType) {
      result.intent = 'cell_lookup';
    } else if (result.filters.courtroom) {
      result.intent = 'teams_lookup';
    } else if (result.courtTerm) {
      result.intent = 'court_lookup';
    }
  }
  
  return result;
}

// Get contact role IDs from contact type keyword
export function getContactRoleIds(contactType: string | null): number[] | null {
  if (!contactType) return null;
  return CONTACT_TYPE_MAP[contactType]?.roleIds || null;
}

// Get contact type label for display
export function getContactTypeLabel(contactType: string | null): string | null {
  if (!contactType) return null;
  return CONTACT_TYPE_MAP[contactType]?.label || null;
}
