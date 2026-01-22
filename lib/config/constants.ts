// ============================================================================
// LLM: LEGAL LEGENDS MANUAL - APPLICATION CONSTANTS
// ============================================================================
// Only true constants that don't change and aren't in the database
// Database data (contacts, bail info, etc.) is fetched via queries.ts
// ============================================================================

// ============================================================================
// APP METADATA
// ============================================================================

export const APP_CONFIG = {
  name: 'LLM: Legal Legends Manual',
  shortName: 'LLM',
  description: 'Quick reference for BC criminal lawyers',
  version: '2.0.0',
} as const;

// ============================================================================
// CONTACT ROLE IDS (references to contact_roles table in Supabase)
// ============================================================================

export const ROLE_IDS = {
  // Court contacts
  CRIMINAL_REGISTRY: 1,
  PROVINCIAL_JCM: 2,
  BAIL_JCM: 3,
  SC_SCHEDULING: 4,
  INTERPRETER_REQUEST: 5,
  LABC_NAVIGATOR: 6,
  
  // Crown contacts
  PROVINCIAL_CROWN: 10,
  FEDERAL_CROWN: 11,
  SC_CROWN: 12,
  
  // Regional contacts
  REGIONAL_CROWN: 20,
  REGIONAL_ADMIN: 21,
} as const;

// Contact role display names (backup if not fetched from DB)
export const ROLE_NAMES: Record<number, string> = {
  [ROLE_IDS.CRIMINAL_REGISTRY]: 'Criminal Registry',
  [ROLE_IDS.PROVINCIAL_JCM]: 'Provincial JCM',
  [ROLE_IDS.BAIL_JCM]: 'Bail JCM',
  [ROLE_IDS.SC_SCHEDULING]: 'SC Scheduling',
  [ROLE_IDS.INTERPRETER_REQUEST]: 'Interpreter Request',
  [ROLE_IDS.LABC_NAVIGATOR]: 'LABC Navigator',
  [ROLE_IDS.PROVINCIAL_CROWN]: 'Provincial Crown',
  [ROLE_IDS.FEDERAL_CROWN]: 'Federal Crown (PPSC)',
  [ROLE_IDS.SC_CROWN]: 'SC Crown',
  [ROLE_IDS.REGIONAL_CROWN]: 'Regional Crown',
  [ROLE_IDS.REGIONAL_ADMIN]: 'Regional Admin',
};

// Group contacts into categories for UI display
export const COURT_CONTACT_ROLES = [
  ROLE_IDS.CRIMINAL_REGISTRY,
  ROLE_IDS.PROVINCIAL_JCM,
  ROLE_IDS.BAIL_JCM,
  ROLE_IDS.SC_SCHEDULING,
  ROLE_IDS.INTERPRETER_REQUEST,
  ROLE_IDS.LABC_NAVIGATOR,
];

export const CROWN_CONTACT_ROLES = [
  ROLE_IDS.PROVINCIAL_CROWN,
  ROLE_IDS.FEDERAL_CROWN,
  ROLE_IDS.SC_CROWN,
];

// ============================================================================
// LOCATION ALIASES FOR FUZZY SEARCH
// ============================================================================
// Maps common abbreviations/nicknames to canonical court names
// Used by Fuse.js search to expand search terms

export const LOCATION_ALIASES: Record<string, string[]> = {
  // Vancouver Coastal
  'north vancouver': ['north van', 'n van', 'nvan', 'n. van', 'north v', 'nv'],
  'vancouver': ['van', 'vcr', 'yvr', '222 main', 'robson square', 'dcc', 'downtown'],
  'richmond': ['rich', 'rmd'],
  'north van - sechelt': ['sechelt', 'sunshine coast'],
  
  // Fraser
  'surrey': ['sur', 'sry', 'srry'],
  'abbotsford': ['abby', 'abb', 'abbot', 'abotsford', 'abbotford'],
  'chilliwack': ['chwk', 'cwk', 'chl', 'chilli', 'chilwack', 'chillwack'],
  'new westminster': ['new west', 'newwest', 'nw', 'n westminster'],
  'port coquitlam': ['poco', 'port coq', 'coquitlam', 'pco'],
  
  // Interior
  'kelowna': ['kel', 'kelo', 'klowna'],
  'kamloops': ['kam', 'kams', 'kamloop'],
  'penticton': ['pent', 'pentic'],
  'vernon': ['vern'],
  'cranbrook': ['cran'],
  'nelson': ['nel'],
  
  // Island
  'victoria': ['vic', 'vict', 'victora'],
  'nanaimo': ['nan', 'nanaino', 'nanimo'],
  'courtenay': ['court', 'ctnay'],
  'campbell river': ['campbell', 'camp river', 'campbel river'],
  'duncan': ['dun'],
  'port alberni': ['alberni', 'port alb'],
  
  // Northern
  'prince george': ['pg', 'prg', 'prince g', 'pringe george', 'prince goerge'],
  'prince rupert': ['rupert', 'pr'],
  'terrace': ['terr'],
  'dawson creek': ['dawson', 'dc'],
  'fort st john': ['fort st j', 'fsj', 'fort st. john'],
  'fort nelson': ['fort n', 'fn'],
  'quesnel': ['ques'],
  'williams lake': ['williams', 'wl'],
};

// Build reverse lookup: alias -> canonical name
export const ALIAS_TO_CANONICAL: Record<string, string> = (() => {
  const map: Record<string, string> = {};
  for (const [canonical, aliases] of Object.entries(LOCATION_ALIASES)) {
    for (const alias of aliases) {
      map[alias.toLowerCase()] = canonical;
    }
    map[canonical.toLowerCase()] = canonical;
  }
  return map;
})();

/**
 * Expand a search term to its canonical form
 * "north van" -> "north vancouver"
 * "abby" -> "abbotsford"
 */
export function expandSearchTerm(term: string): string {
  const normalized = term.toLowerCase().trim();
  return ALIAS_TO_CANONICAL[normalized] || term;
}

/**
 * Get all possible search terms for a location
 * "north vancouver" -> ["north vancouver", "north van", "n van", ...]
 */
export function getAllSearchTerms(canonicalName: string): string[] {
  const lower = canonicalName.toLowerCase();
  const aliases = LOCATION_ALIASES[lower] || [];
  return [canonicalName, ...aliases];
}

// ============================================================================
// REGION IDS (references to regions table in Supabase)
// ============================================================================

export const REGION_IDS = {
  ISLAND: 1,
  COASTAL: 2,
  FRASER: 3,
  INTERIOR: 4,
  NORTHERN: 5,
} as const;

export type RegionId = 1 | 2 | 3 | 4 | 5;

// ============================================================================
// FUSE.JS SEARCH CONFIGURATION
// ============================================================================

export const FUSE_OPTIONS = {
  keys: [
    { name: 'name', weight: 0.5 },
    { name: 'searchTerms', weight: 0.4 },
  ],
  threshold: 0.35,
  distance: 100,
  minMatchCharLength: 2,
  includeScore: true,
  ignoreLocation: true,
} as const;

// ============================================================================
// UI CONSTANTS
// ============================================================================

export const UI = {
  // Toast duration in ms
  TOAST_DURATION: 2000,
  
  // Debounce delay for search in ms
  SEARCH_DEBOUNCE: 300,
  
  // Header collapse scroll threshold (with hysteresis)
  HEADER_COLLAPSE_THRESHOLD: 80,
  HEADER_EXPAND_THRESHOLD: 30,
  
  // Animation durations in ms
  ANIMATION: {
    FAST: 150,
    NORMAL: 200,
    SLOW: 300,
  },
  
  // Max items for truncated lists
  MAX_PREVIEW_ITEMS: 3,
} as const;

// ============================================================================
// EXTERNAL LINKS
// ============================================================================

export const EXTERNAL_LINKS = {
  LABC: 'https://legalaid.bc.ca',
  COURT_SERVICES: 'https://www.bccourts.ca',
  PPSC: 'https://www.ppsc-sppc.gc.ca',
  CORRECTIONS_BC: 'https://www2.gov.bc.ca/gov/content/justice/criminal-justice/corrections',
} as const;

// ============================================================================
// CORRECTIONS SYSTEM CONSTANTS (system-wide info, not contact data)
// ============================================================================

export const CORRECTIONS_SYSTEM = {
  // System-wide phone numbers (not facility-specific)
  callerID: '844-369-7776',
  registerAsLawyerPhone: '236-478-0284',
  unknownInmateLocationPhone: '250-387-1605',
  unknownInmateLocationHours: 'Mon-Fri 8AM-4PM',
  
  // Standard hours
  businessHours: '08:00-16:00',
  unlockHoursWeekday: '07:00-07:30',
  unlockHoursWeekend: '10:00',
  eveningLock: '21:45-22:00',
} as const;
