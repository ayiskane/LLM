// ============================================================================
// LLM: LEGAL LEGENDS MANUAL - TYPE DEFINITIONS
// ============================================================================
// Types that match the Supabase database schema
// ============================================================================

// ============================================================================
// COURT
// ============================================================================

export interface Court {
  id: number;
  name: string;
  region_id: number;
  region_name?: string;
  region_code?: string;
  has_provincial: boolean;
  has_supreme: boolean;
  is_circuit: boolean;
  is_staffed: boolean;
  contact_hub: string | null;
  contact_hub_name?: string;
  address: string | null;
  phone: string | null;
  fax: string | null;
  sheriff_phone: string | null;
  supreme_scheduling_phone: string | null;
  access_code: string | null;
  bail_hub_id: number | null;
}

// ============================================================================
// CONTACT
// ============================================================================

export interface Contact {
  id: number;
  email: string | null;
  emails: string[] | null;
  contact_role_id: number;
  role_name?: string;
  court_id?: number;
}

export interface ContactRole {
  id: number;
  name: string;
}

// ============================================================================
// SHERIFF CELL
// ============================================================================

export interface ShellCell {
  id: number;
  name: string;
  cell_type: string;
  phones: string[];
  catchment: string | null;
  court_id: number | null;
  region_id: number | null;
  court_name?: string;
}

// ============================================================================
// TEAMS LINK
// ============================================================================

export interface TeamsLink {
  id: number;
  name: string | null;
  courtroom: string | null;
  conference_id: string | null;
  phone: string | null;
  phone_toll_free: string | null;
  teams_link: string | null;
  teams_link_type_id: number | null;
  type_name?: string;
  court_id?: number | null;
  bail_court_id?: number | null;
  source_updated_at?: string | null;
}

// ============================================================================
// BAIL
// ============================================================================

export interface BailCourt {
  id: number;
  name: string;
  court_id: number | null;
  region_id: number;
  is_hybrid: boolean;
  is_daytime: boolean;
  triage_time_am: string | null;
  triage_time_pm: string | null;
  court_start_am: string | null;
  court_start_pm: string | null;
  court_end: string | null;
  cutoff_new_arrests: string | null;
  youth_custody_day: string | null;
  youth_custody_time: string | null;
}

export interface BailContact {
  id: number;
  email: string | null;
  bail_court_id: number | null;
  region_id: number | null;
  role_id: number;
  availability_id: number | null;
  role_name?: string;
  availability_name?: string;
}

// ============================================================================
// REGION
// ============================================================================

export interface Region {
  id: number;
  code: string;
  name: string;
}

// ============================================================================
// PROGRAM
// ============================================================================

export interface Program {
  id: number;
  name: string;
  type_id: number | null;
  location: string | null;
  region_id: number | null;
  address: string | null;
  phone: string | null;
  phone_secondary: string | null;
  fax: string | null;
  email: string | null;
  website: string | null;
  gender: 'all' | 'men' | 'women' | null;
  indigenous_only: boolean;
  accepts_sa_records: boolean;
  is_residential: boolean;
  application_method: 'phone' | 'written' | 'referral' | null;
  parent_organization: string | null;
  notes: string | null;
  is_active: boolean;
  type_code?: string;
  type_name?: string;
  region_name?: string;
}

// ============================================================================
// VIEW MODES
// ============================================================================

export type ViewMode = 'home' | 'results' | 'detail';

// ============================================================================
// CONTACT ROLE CONSTANTS
// ============================================================================

export const CONTACT_ROLES = {
  CROWN: 1,
  JCM: 2,
  SHERIFF_QB: 3,
  REGISTRY_QB: 4,
  LABC_NAVIGATOR: 5,
  FEDERAL_CROWN: 6,
  SCHEDULING: 8,
  COURT_REGISTRY: 9,
  CRIMINAL_REGISTRY: 10,
  INTERPRETER: 11,
  BAIL_CROWN: 12,
  BAIL_JCM: 13,
  TRANSCRIPTS: 14,
  COORDINATOR: 21,
  FIRST_NATIONS_CROWN: 23,
} as const;

export const CONTACT_ROLE_NAMES: Record<number, string> = {
  1: 'Crown',
  2: 'JCM',
  3: 'Sheriff QB',
  4: 'Registry QB',
  5: 'LABC Navigator',
  6: 'Federal Crown',
  8: 'SC Scheduling',
  9: 'Court Registry',
  10: 'Criminal Registry',
  11: 'Interpreter Request',
  12: 'Bail Crown',
  13: 'Bail JCM',
  14: 'Transcripts',
  21: 'Coordinator',
  23: 'First Nations Crown',
};

// Court contact roles (displayed in "Court Contacts" section)
export const COURT_CONTACT_ROLE_IDS = [
  CONTACT_ROLES.CRIMINAL_REGISTRY,
  CONTACT_ROLES.JCM,
  CONTACT_ROLES.BAIL_JCM,
  CONTACT_ROLES.SCHEDULING,
  CONTACT_ROLES.INTERPRETER,
  CONTACT_ROLES.LABC_NAVIGATOR,
];

// Crown contact roles (displayed in "Crown Contacts" section)
export const CROWN_CONTACT_ROLE_IDS = [
  CONTACT_ROLES.CROWN,
  CONTACT_ROLES.FEDERAL_CROWN,
  CONTACT_ROLES.FIRST_NATIONS_CROWN,
];

// ============================================================================
// REGION CONSTANTS
// ============================================================================

export const REGION_CODES: Record<number, string> = {
  1: 'R1',
  2: 'R2',
  3: 'R3',
  4: 'R4',
  5: 'R5',
  6: 'FED',
};

export const REGION_NAMES: Record<number, string> = {
  1: 'Island',
  2: 'Vancouver Coastal',
  3: 'Fraser',
  4: 'Interior',
  5: 'Northern',
  6: 'Federal',
};

// ============================================================================
// HELPER FUNCTIONS
// ============================================================================

/**
 * Check if a teams link is a VB Triage link
 */
export function isVBTriageLink(link: TeamsLink): boolean {
  const name = (link.name || link.courtroom || '').toLowerCase();
  return name.includes('triage') || name.includes('vb triage');
}

/**
 * Get display name for a contact role
 */
export function getContactRoleName(roleId: number): string {
  return CONTACT_ROLE_NAMES[roleId] || 'Contact';
}

/**
 * Get region code from ID
 */
export function getRegionCode(regionId: number): string {
  return REGION_CODES[regionId] || '';
}

/**
 * Get region name from ID
 */
export function getRegionName(regionId: number): string {
  return REGION_NAMES[regionId] || '';
}
