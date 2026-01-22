// ============================================================================
// LLM: LEGAL LEGENDS MANUAL - CONSTANTS
// ============================================================================

// App metadata
export const APP_NAME = 'LLM: Legal Legends Manual';
export const APP_DESCRIPTION = 'BC Court contacts and information directory';

// ============================================================================
// UI CONFIGURATION
// ============================================================================

export const UI_CONFIG = {
  // Search
  MIN_SEARCH_LENGTH: 2,
  DEBOUNCE_MS: 300,
  
  // Scroll behavior
  HEADER_COLLAPSE_THRESHOLD: 80,
  HEADER_EXPAND_THRESHOLD: 30,
  
  // Animation
  TOAST_DURATION_MS: 2000,
  COPY_FEEDBACK_MS: 2000,
  
  // Display
  MAX_PREVIEW_CONTACTS: 3,
  MAX_PREVIEW_CELLS: 5,
} as const;

// ============================================================================
// CONTACT ROLES
// ============================================================================

export const CONTACT_ROLES = {
  // Court operations
  COURT_REGISTRY: 1,
  CRIMINAL_REGISTRY: 2,
  JCM: 3,           // Judicial Case Manager
  BAIL_JCM: 4,
  SCHEDULING: 5,    // Supreme Court Scheduling
  INTERPRETER: 6,
  
  // Crown
  CROWN: 7,         // Provincial Crown
  BAIL_CROWN: 8,
  FEDERAL_CROWN: 9,
  FIRST_NATIONS_CROWN: 10,
} as const;

// Display names for role IDs
export const ROLE_DISPLAY_NAMES: Record<number, string> = {
  [CONTACT_ROLES.COURT_REGISTRY]: 'Court Registry',
  [CONTACT_ROLES.CRIMINAL_REGISTRY]: 'Criminal Registry',
  [CONTACT_ROLES.JCM]: 'JCM',
  [CONTACT_ROLES.BAIL_JCM]: 'Bail JCM',
  [CONTACT_ROLES.SCHEDULING]: 'SC Scheduling',
  [CONTACT_ROLES.INTERPRETER]: 'Interpreter Request',
  [CONTACT_ROLES.CROWN]: 'Crown',
  [CONTACT_ROLES.BAIL_CROWN]: 'Bail Crown',
  [CONTACT_ROLES.FEDERAL_CROWN]: 'Federal Crown',
  [CONTACT_ROLES.FIRST_NATIONS_CROWN]: 'First Nations Crown',
};

// Court contact role IDs (for filtering)
export const COURT_CONTACT_ROLE_IDS = [
  CONTACT_ROLES.CRIMINAL_REGISTRY,
  CONTACT_ROLES.COURT_REGISTRY,
  CONTACT_ROLES.JCM,
  CONTACT_ROLES.BAIL_JCM,
  CONTACT_ROLES.SCHEDULING,
  CONTACT_ROLES.INTERPRETER,
];

// Crown contact role IDs (for filtering)
export const CROWN_CONTACT_ROLE_IDS = [
  CONTACT_ROLES.CROWN,
  CONTACT_ROLES.BAIL_CROWN,
  CONTACT_ROLES.FEDERAL_CROWN,
  CONTACT_ROLES.FIRST_NATIONS_CROWN,
];

// ============================================================================
// HELPER FUNCTIONS
// ============================================================================

/**
 * Check if a link is a VB Triage link
 */
export function isVBTriageLink(name: string | null | undefined): boolean {
  if (!name) return false;
  const lower = name.toLowerCase();
  return lower.includes('vb triage') || lower.includes('vbtriage') || lower.includes('triage');
}

/**
 * Get bail hub tag text for section header (matches backup exactly)
 * Examples:
 * - "Abbotsford Virtual Bail" -> "ABBOTSFORD HUB"
 * - "Fraser Virtual Bail" -> "ABBY HUB"
 * - "Victoria Virtual Bail" -> "VICTORIA HUB"
 */
export function getBailHubTag(bailCourtName: string | null | undefined): string {
  if (!bailCourtName) return '';
  return bailCourtName
    .toUpperCase()
    .replace(' VIRTUAL BAIL', '')
    .replace('FRASER', 'ABBY')
    .trim() + ' HUB';
}

/**
 * Format courtroom name - ADD CR prefix for courtroom numbers (matches backup)
 */
export function formatCourtroomName(name: string | null | undefined): string {
  if (!name) return 'MS Teams';
  
  // Don't modify JCM FXD or special names
  if (name.toLowerCase().includes('jcm') || 
      name.toLowerCase().includes('fxd') || 
      name.toLowerCase().includes('triage')) {
    return name;
  }
  
  // Check if it's already prefixed with CR
  if (name.toLowerCase().startsWith('cr ') || name.toLowerCase().startsWith('cr-')) {
    return name;
  }
  
  // Check if it's a number or starts with a number (courtroom number)
  const numMatch = name.match(/^(\d+)/);
  if (numMatch) {
    return `CR ${name}`;
  }
  
  // Check for patterns like "Courtroom 101" and convert to "CR 101"
  const courtroomMatch = name.match(/^courtroom\s*(\d+)/i);
  if (courtroomMatch) {
    return `CR ${courtroomMatch[1]}`;
  }
  
  return name;
}

// Legacy alias - used by old code
export function formatCourtRoom(courtroom: string | null | undefined): string {
  return formatCourtroomName(courtroom);
}

// ============================================================================
// LOCATION ALIASES (for future fuzzy search)
// ============================================================================

export const LOCATION_ALIASES: Record<string, string[]> = {
  'north vancouver': ['north van', 'n van', 'nvan', 'n. van', 'north v', 'nv'],
  'vancouver': ['van', 'vcr', 'yvr', '222 main', 'robson square', 'dcc', 'downtown'],
  'richmond': ['rich', 'rmd'],
  'surrey': ['sur', 'sry', 'srry'],
  'abbotsford': ['abby', 'abb', 'abbot', 'abotsford', 'abbotford'],
  'chilliwack': ['chwk', 'cwk', 'chl', 'chilli', 'chilwack', 'chillwack'],
  'new westminster': ['new west', 'newwest', 'nw', 'n westminster'],
  'port coquitlam': ['poco', 'pcq', 'port coq'],
  'kelowna': ['kel', 'kelo'],
  'kamloops': ['kam', 'kml'],
  'nanaimo': ['nan', 'nmo'],
  'victoria': ['vic', 'vict'],
  'prince george': ['pg', 'p george', 'prince g'],
  'cranbrook': ['cran', 'crk'],
  'vernon': ['vern', 'vrn'],
  'penticton': ['pent', 'pen'],
  'nelson': ['nel'],
  'powell river': ['powell', 'pr'],
  'terrace': ['ter'],
  'prince rupert': ['rupert', 'p rupert'],
  'fort st john': ['fsj', 'fort st j', 'ft st john'],
  'dawson creek': ['dawson', 'dc'],
  'williams lake': ['williams', 'wl'],
  'quesnel': ['ques'],
  'salmon arm': ['salmon', 'sa'],
  'courtenay': ['court', 'ctnay'],
  'campbell river': ['campbell', 'cr'],
  'duncan': ['dunc'],
  'langley': ['lang'],
  'maple ridge': ['maple', 'mr'],
  'mission': ['miss'],
  'sechelt': ['sech'],
  'squamish': ['squam'],
  'whistler': ['whis'],
} as const;
