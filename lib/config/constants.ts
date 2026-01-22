// ============================================================================
// LLM: LEGAL LEGENDS MANUAL - APPLICATION CONSTANTS
// ============================================================================
// All app-wide constants, role IDs, location aliases, bail contacts
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
// CONTACT ROLE IDS (from Supabase)
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

// Contact role display names
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

// Group contacts into categories
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
    // Also map canonical to itself
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
// REGION CONFIGURATION
// ============================================================================

export const REGIONS = {
  ISLAND: { id: 1, code: 'R1', name: 'Vancouver Island', color: 'cyan' },
  COASTAL: { id: 2, code: 'R2', name: 'Vancouver Coastal', color: 'violet' },
  FRASER: { id: 3, code: 'R3', name: 'Fraser', color: 'amber' },
  INTERIOR: { id: 4, code: 'R4', name: 'Interior', color: 'emerald' },
  NORTHERN: { id: 5, code: 'R5', name: 'Northern', color: 'red' },
} as const;

export type RegionId = 1 | 2 | 3 | 4 | 5;
export type RegionCode = 'R1' | 'R2' | 'R3' | 'R4' | 'R5';

// ============================================================================
// BAIL CONTACTS BY REGION
// ============================================================================

export interface BailRegion {
  region: string;
  code: string;
  name: string;
  color: string;
  contactType?: 'court-specific';
  daytime?: string;
  daytimeNote?: string;
  afterHours?: string;
  afterHoursNote?: string;
  allHours?: boolean;
  rabc?: { name: string; email: string; phone: string };
  subjectLine: string;
  vrs?: string[];
  courtCount: number;
  courts?: Array<{
    court: string;
    email: string;
    note?: string;
    areas: string[];
  }>;
  areas: string[];
}

export const BAIL_REGIONS: BailRegion[] = [
  {
    region: 'VR1',
    code: 'R1',
    name: 'Vancouver Island',
    color: 'cyan',
    daytime: 'Region1.VirtualBail@gov.bc.ca',
    daytimeNote: 'Regular weekday',
    afterHours: 'VictoriaCrown.Public@gov.bc.ca',
    afterHoursNote: 'Evenings, weekends, holidays (remote - no fax)',
    rabc: { name: 'Chloe Rathjen', email: 'chloe.rathjen@gov.bc.ca', phone: '250-940-8522' },
    subjectLine: 'URGENT IC Daytime Program – (Reason) – Detachment – Date',
    vrs: ['VR8 (South Island)', 'VR9 (North Island)'],
    courtCount: 12,
    areas: ['Victoria', 'Colwood', 'Western Communities', 'Duncan', 'Nanaimo', 'Campbell River', 'Courtenay', 'Port Alberni', 'Port Hardy', 'Powell River', 'Tofino', 'Gold River']
  },
  {
    region: 'VR2',
    code: 'R2',
    name: 'Vancouver Coastal',
    color: 'violet',
    contactType: 'court-specific',
    subjectLine: 'URGENT IC – Accused Name/File No. – Date',
    courtCount: 8,
    courts: [
      { court: 'Vancouver Provincial (222 Main)', email: '222MainCrownBail@gov.bc.ca', areas: ['Vancouver', 'Burnaby'] },
      { court: 'North Vancouver', email: 'NorthVanCrown@gov.bc.ca', areas: ['North Vancouver', 'West Vancouver', 'Squamish', 'Whistler', 'Pemberton'] },
      { court: 'Richmond', email: 'RichmondCrown@gov.bc.ca', areas: ['Richmond'] },
      { court: 'Sechelt', email: 'SecheltCrown@gov.bc.ca', note: 'Heard in North Van', areas: ['Sechelt', 'Gibsons', 'Sunshine Coast'] },
      { court: 'Vancouver Youth (Robson)', email: 'VancouverYouthCrown@gov.bc.ca', note: 'Own bail process', areas: ['Vancouver Youth'] },
    ],
    areas: ['Vancouver', 'Burnaby', 'North Vancouver', 'West Vancouver', 'Richmond', 'Squamish', 'Whistler', 'Pemberton', 'Sechelt', 'Gibsons']
  },
  {
    region: 'VR3',
    code: 'R3',
    name: 'Fraser',
    color: 'amber',
    contactType: 'court-specific',
    subjectLine: 'URGENT IC Daytime Program: (reason) – Detachment – Date',
    courtCount: 15,
    courts: [
      { court: 'Abbotsford', email: 'Abbotsford.VirtualBail@gov.bc.ca', areas: ['Abbotsford', 'Mission'] },
      { court: 'Chilliwack', email: 'Chilliwack.VirtualBail@gov.bc.ca', areas: ['Chilliwack', 'Hope', 'Agassiz'] },
      { court: 'New Westminster', email: 'NewWestProv.VirtualBail@gov.bc.ca', areas: ['New Westminster', 'Burnaby'] },
      { court: 'Port Coquitlam', email: 'Poco.VirtualBail@gov.bc.ca', areas: ['Port Coquitlam', 'Coquitlam', 'Port Moody', 'Maple Ridge', 'Pitt Meadows'] },
      { court: 'Surrey', email: 'Surrey.VirtualBail@gov.bc.ca', areas: ['Surrey', 'Langley', 'Delta', 'White Rock'] },
    ],
    areas: ['Surrey', 'Langley', 'Delta', 'White Rock', 'Abbotsford', 'Mission', 'Chilliwack', 'Hope', 'Agassiz', 'New Westminster', 'Port Coquitlam', 'Coquitlam', 'Port Moody', 'Maple Ridge', 'Pitt Meadows']
  },
  {
    region: 'VR4',
    code: 'R4',
    name: 'Interior',
    color: 'emerald',
    daytime: 'Region4.VirtualBail@gov.bc.ca',
    daytimeNote: 'Regular weekday',
    afterHours: 'AGBCPSReg4BailKelownaGen@gov.bc.ca',
    afterHoursNote: 'Evenings, weekends, holidays (remote - no fax)',
    rabc: { name: 'Pamela Robertson', email: 'pamela.robertson@gov.bc.ca', phone: '778-940-0050' },
    subjectLine: 'URGENT IC – (Reason) – Detachment – Date',
    vrs: ['VR3 (Kelowna area)', 'VR4 (Kamloops area)'],
    courtCount: 18,
    areas: ['Kamloops', 'Kelowna', 'Vernon', 'Penticton', 'Salmon Arm', 'Cranbrook', 'Nelson', 'Trail', 'Castlegar', 'Merritt', 'Lillooet', 'Revelstoke', 'Golden', 'Invermere', 'Fernie', 'Grand Forks', 'Princeton', 'Clearwater', 'Ashcroft', 'Chase', 'Oliver', 'Keremeos', 'Osoyoos', 'Summerland', 'Falkland', 'Armstrong', 'Lumby', 'Nakusp', 'Rossland', 'Creston']
  },
  {
    region: 'VR5',
    code: 'R5',
    name: 'North',
    color: 'red',
    daytime: 'Region5.VirtualBail@gov.bc.ca',
    daytimeNote: 'All bail matters (day/evening/weekend/holidays)',
    allHours: true,
    rabc: { name: 'Jacqueline Ettinger', email: 'Jacqueline.ettinger@gov.bc.ca', phone: '250-570-0422' },
    subjectLine: 'URGENT IC VB – (Reason) – VR1/VR2 Location – Date',
    vrs: ['VR1 (Prince George area)', 'VR2 (Peace/Northwest)'],
    courtCount: 24,
    areas: ['Prince George', 'Quesnel', 'Williams Lake', 'Vanderhoof', 'Fort St. John', 'Dawson Creek', 'Fort Nelson', 'Terrace', 'Prince Rupert', 'Smithers', 'Kitimat', 'Burns Lake', 'Mackenzie', '100 Mile House']
  }
];

// ============================================================================
// SHERIFF CONTACTS
// ============================================================================

export interface SheriffContact {
  area: string;
  email: string;
}

export const SHERIFF_CONTACTS: SheriffContact[] = [
  { area: '222 Main Street', email: 'CSB222MainStreet.SheriffVirtualBail@gov.bc.ca' },
  { area: 'Vancouver Coastal', email: 'CSBVancouverCoastal.SheriffVirtualBail@gov.bc.ca' },
  { area: 'Fraser Region', email: 'CSBFraser.SheriffVirtualBail@gov.bc.ca' },
  { area: 'Surrey', email: 'CSBSurrey.SheriffVirtualBail@gov.bc.ca' },
];

// ============================================================================
// FEDERAL CROWN (PPSC) CONTACTS
// ============================================================================

export interface FederalArea {
  area: string;
  email: string;
  phone?: string;
  org: string;
}

export interface FederalRegion {
  region: string;
  areas: FederalArea[];
}

export const FEDERAL_CROWN_CONTACTS: FederalRegion[] = [
  {
    region: 'Vancouver Coastal',
    areas: [
      { area: 'Vancouver & Burnaby', email: 'Van.detention.van@ppsc-sppc.gc.ca', phone: '604-666-2141', org: 'PPSC 222 Main' },
      { area: 'Richmond', email: 'ppscsupportstaff@mtclaw.ca', phone: '604-590-8855', org: 'MTC Law' },
      { area: 'North Shore, Squamish, Sechelt, Whistler', email: 'NorthShoreandCRC@ppsc-sppc.gc.ca', org: 'PPSC North Van' },
    ]
  },
  {
    region: 'Vancouver Island',
    areas: [
      { area: 'Victoria & Colwood', email: 'Vicinfo@joneslaw.ca', phone: '250-220-6942', org: 'Jones & Co.' },
      { area: 'Nanaimo & Duncan', email: 'Naninfo@joneslaw.ca', phone: '250-714-1113', org: 'Jones & Co.' },
      { area: 'Campbell River, Courtenay, Port Alberni, Port Hardy', email: 'Naninfo@joneslaw.ca', phone: '250-714-1113', org: 'Jones & Co.' },
    ]
  },
  {
    region: 'Fraser',
    areas: [
      { area: 'Surrey, Langley, Delta, White Rock', email: 'PPSC.SurreyInCustody-EnDetentionSurrey.SPPC@ppsc-sppc.gc.ca', phone: '236-456-0015', org: 'PPSC Surrey' },
      { area: 'Port Coquitlam & New Westminster', email: 'ppscsupportstaff@mtclaw.ca', phone: '604-590-8855', org: 'MTC Law' },
      { area: 'Chilliwack & Abbotsford', email: 'jir@jmldlaw.com', phone: '604-514-8203', org: 'JM LeDressay' },
    ]
  },
  {
    region: 'Interior',
    areas: [
      { area: 'Kamloops, Ashcroft, Chase, Clearwater, Lillooet, Merritt, Salmon Arm', email: 'ppscsupportstaff@mtclaw.ca', phone: '604-590-8855', org: 'MTC Law' },
      { area: 'Kelowna, Penticton, Vernon & area', email: 'jir@jmldlaw.com', phone: '604-514-8203', org: 'JM LeDressay' },
      { area: 'Kootenays (Cranbrook, Nelson, Trail, etc.)', email: 'PPSC.SurreyInCustody-EnDetentionSurrey.SPPC@ppsc-sppc.gc.ca', phone: '604-354-9146', org: 'PPSC Surrey' },
    ]
  }
];

// ============================================================================
// REVOI CONTACTS
// ============================================================================

export interface RevoiContact {
  region: string;
  email: string;
}

export const REVOI_CONTACTS: RevoiContact[] = [
  { region: 'R2', email: 'BCPSReVOII2@gov.bc.ca' },
  { region: 'R3', email: 'BCPSReVOII3@gov.bc.ca' },
];

// ============================================================================
// CORRECTIONS SYSTEM CONSTANTS
// ============================================================================

export const CORRECTIONS_CONSTANTS = {
  callerID: '844-369-7776',
  registerAsLawyerPhone: '236-478-0284',
  registerAsLawyerContact: 'Cindy',
  unknownInmateLocationPhone: '250-387-1605',
  unknownInmateLocationHours: 'Mon-Fri 8AM-4PM',
  businessHours: '08:00-16:00',
  unlockHoursWeekday: '07:00-07:30',
  unlockHoursWeekend: '10:00',
  eveningLock: '21:45-22:00',
} as const;

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
  
  // Header collapse scroll threshold
  HEADER_COLLAPSE_THRESHOLD: 80,
  HEADER_EXPAND_THRESHOLD: 30,
  
  // Animation durations in ms
  ANIMATION: {
    FAST: 150,
    NORMAL: 200,
    SLOW: 300,
  },
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
