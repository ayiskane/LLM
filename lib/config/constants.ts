// =============================================================================
// CENTRALIZED CONSTANTS - All app constants in one place
// =============================================================================

// App metadata
export const APP_NAME = 'LLM: Legal Legends Manual';
export const APP_DESCRIPTION = 'Quick reference for BC lawyers - courts, contacts, cells, and bail information';
export const APP_VERSION = '2.0.0';

// Contact role IDs (match Supabase contact_roles table)
export const CONTACT_ROLE_IDS = {
  CROWN: 1,
  JCM: 2,
  SHERIFF_QB: 3,
  LABC_NAVIGATOR: 5,
  FEDERAL_CROWN: 6,
  SC_SCHEDULING: 8,
  COURT_REGISTRY: 9,
  CRIMINAL_REGISTRY: 10,
  INTERPRETER: 11,
  BAIL_CROWN: 12,
  BAIL_JCM: 13,
  TRANSCRIPTS: 14,
  COORDINATOR_525: 21,
  FIRST_NATIONS_CROWN: 23,
} as const;

// Court contact role IDs (in display order)
export const COURT_CONTACT_ROLE_IDS: number[] = [
  CONTACT_ROLE_IDS.CRIMINAL_REGISTRY,
  CONTACT_ROLE_IDS.COURT_REGISTRY,
  CONTACT_ROLE_IDS.SC_SCHEDULING,
  CONTACT_ROLE_IDS.JCM,
  CONTACT_ROLE_IDS.BAIL_JCM,
  CONTACT_ROLE_IDS.INTERPRETER,
  CONTACT_ROLE_IDS.TRANSCRIPTS,
  CONTACT_ROLE_IDS.LABC_NAVIGATOR,
  CONTACT_ROLE_IDS.SHERIFF_QB,
  CONTACT_ROLE_IDS.COORDINATOR_525,
];

// Crown contact role IDs (in display order)
export const CROWN_CONTACT_ROLE_IDS: number[] = [
  CONTACT_ROLE_IDS.CROWN,
  CONTACT_ROLE_IDS.FEDERAL_CROWN,
  CONTACT_ROLE_IDS.BAIL_CROWN,
  CONTACT_ROLE_IDS.FIRST_NATIONS_CROWN,
];

// Role display names (keyed by numeric ID)
export const ROLE_DISPLAY_NAMES: Record<number, string> = {
  [CONTACT_ROLE_IDS.CROWN]: 'PROVINCIAL CROWN',
  [CONTACT_ROLE_IDS.JCM]: 'JCM',
  [CONTACT_ROLE_IDS.SHERIFF_QB]: 'SHERIFF QB',
  [CONTACT_ROLE_IDS.LABC_NAVIGATOR]: 'LABC NAVIGATOR',
  [CONTACT_ROLE_IDS.FEDERAL_CROWN]: 'FEDERAL CROWN',
  [CONTACT_ROLE_IDS.SC_SCHEDULING]: 'SC SCHEDULING',
  [CONTACT_ROLE_IDS.COURT_REGISTRY]: 'COURT REGISTRY',
  [CONTACT_ROLE_IDS.CRIMINAL_REGISTRY]: 'CRIMINAL REGISTRY',
  [CONTACT_ROLE_IDS.INTERPRETER]: 'INTERPRETER REQUEST',
  [CONTACT_ROLE_IDS.BAIL_CROWN]: 'BAIL CROWN',
  [CONTACT_ROLE_IDS.BAIL_JCM]: 'BAIL JCM',
  [CONTACT_ROLE_IDS.TRANSCRIPTS]: 'TRANSCRIPTS',
  [CONTACT_ROLE_IDS.COORDINATOR_525]: '525 COORDINATOR',
  [CONTACT_ROLE_IDS.FIRST_NATIONS_CROWN]: 'FIRST NATIONS CROWN',
};

// Location aliases for search
export const LOCATION_ALIASES: Record<string, string> = {
  // Abbotsford
  'abby': 'abbotsford',
  'abb': 'abbotsford',
  // North Vancouver
  'north van': 'north vancouver',
  'n van': 'north vancouver',
  'nvan': 'north vancouver',
  'n. van': 'north vancouver',
  'n.van': 'north vancouver',
  // West Vancouver
  'west van': 'west vancouver',
  'w van': 'west vancouver',
  'wvan': 'west vancouver',
  // Port Coquitlam
  'poco': 'port coquitlam',
  'port coq': 'port coquitlam',
  // Prince George
  'pg': 'prince george',
  'prg': 'prince george',
  // Victoria
  'vic': 'victoria',
  // Surrey
  'sur': 'surrey',
  'sry': 'surrey',
  // New Westminster
  'new west': 'new westminster',
  'nw': 'new westminster',
  'newwest': 'new westminster',
  // Kelowna
  'kel': 'kelowna',
  // Kamloops
  'kam': 'kamloops',
  // Nanaimo
  'nan': 'nanaimo',
  // Chilliwack
  'chwk': 'chilliwack',
  'chilli': 'chilliwack',
  // Langley
  'lang': 'langley',
  // Burnaby
  'burny': 'burnaby',
  'burn': 'burnaby',
  // Richmond
  'rich': 'richmond',
  // Coquitlam
  'coq': 'coquitlam',
  // Maple Ridge
  'maple': 'maple ridge',
  'mr': 'maple ridge',
  // Mission
  'miss': 'mission',
  // Penticton
  'pent': 'penticton',
  // Vernon
  'vern': 'vernon',
  // Courtenay
  'court': 'courtenay',
  // Campbell River
  'cr': 'campbell river',
  'camp': 'campbell river',
  // Duncan
  'dunc': 'duncan',
  // Port Alberni
  'pa': 'port alberni',
  'alberni': 'port alberni',
  // Powell River
  'powell': 'powell river',
  'pr': 'powell river',
  // Terrace
  'terr': 'terrace',
  // Prince Rupert
  'rupert': 'prince rupert',
  // Fort St. John
  'fsj': 'fort st john',
  'fort st': 'fort st john',
  // Dawson Creek
  'dc': 'dawson creek',
  'dawson': 'dawson creek',
  // Williams Lake
  'wl': 'williams lake',
  // Quesnel
  'ques': 'quesnel',
  // 100 Mile House
  '100 mile': '100 mile house',
  '100mile': '100 mile house',
  // Smithers
  'smith': 'smithers',
  // Kitimat
  'kit': 'kitimat',
  // Cranbrook
  'cran': 'cranbrook',
  // Nelson
  'nel': 'nelson',
  // Trail
  'tra': 'trail',
  // Rossland
  'ross': 'rossland',
  // Golden
  'gold': 'golden',
  // Revelstoke
  'rev': 'revelstoke',
  // Salmon Arm
  'salmon': 'salmon arm',
  'sa': 'salmon arm',
  // Merritt
  'merr': 'merritt',
  // Hope
  // (no alias needed - already short)
  // Squamish
  'squam': 'squamish',
  // Whistler
  'whis': 'whistler',
  // Sechelt
  'sech': 'sechelt',
  // Gibsons
  'gib': 'gibsons',
};

// Search configuration
export const SEARCH_CONFIG = {
  DEBOUNCE_MS: 300,
  MIN_QUERY_LENGTH: 2,
  MAX_RESULTS: 50,
  FUSE_OPTIONS: {
    threshold: 0.3,
    keys: ['name', 'address', 'search_terms'],
    includeScore: true,
  },
} as const;

// UI configuration
export const UI_CONFIG = {
  TOAST_DURATION_MS: 2000,
  HEADER_COLLAPSE_THRESHOLD_DOWN: 80,
  HEADER_COLLAPSE_THRESHOLD_UP: 30,
  ANIMATION_DURATION_MS: 200,
} as const;

// Cache configuration
export const CACHE_CONFIG = {
  STALE_TIME_MS: 5 * 60 * 1000, // 5 minutes
  GC_TIME_MS: 30 * 60 * 1000, // 30 minutes
} as const;

// VB Triage link identifier
export const VB_TRIAGE_KEYWORDS = ['vb triage', 'virtual bail triage', 'triage'];

/**
 * Check if a Teams link is a VB Triage link
 */
export function isVBTriageLink(name: string): boolean {
  const nameLower = name.toLowerCase();
  return VB_TRIAGE_KEYWORDS.some(keyword => nameLower.includes(keyword));
}

/**
 * Format court room name with CR prefix
 */
export function formatCourtRoom(name: string): string {
  // Don't add CR to JCM FXD or VB Triage
  if (name.toLowerCase().includes('jcm') || name.toLowerCase().includes('triage')) {
    return name;
  }
  // Add CR prefix if it's just a number
  if (/^\d+$/.test(name.trim())) {
    return `CR ${name}`;
  }
  // Add CR prefix if it doesn't already have one
  if (!name.toLowerCase().startsWith('cr ')) {
    return `CR ${name}`;
  }
  return name;
}

/**
 * Get bail hub tag from bail court name
 */
export function getBailHubTag(bailCourtName: string): string {
  // Extract location from name like "Fraser Virtual Bail (Abbotsford)"
  const match = bailCourtName.match(/\(([^)]+)\)/);
  if (match) {
    const location = match[1];
    // Create abbreviation
    const abbrev = location.slice(0, 4).toUpperCase();
    return `${abbrev} HUB`;
  }
  // Fallback: use first word
  const firstWord = bailCourtName.split(' ')[0].toUpperCase().slice(0, 4);
  return `${firstWord} HUB`;
}

/**
 * Check if a contact role ID is a court role
 */
export function isCourtRole(roleId: number): boolean {
  return COURT_CONTACT_ROLE_IDS.includes(roleId);
}

/**
 * Check if a contact role ID is a crown role
 */
export function isCrownRole(roleId: number): boolean {
  return CROWN_CONTACT_ROLE_IDS.includes(roleId);
}
