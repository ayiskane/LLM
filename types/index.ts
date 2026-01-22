// =============================================================================
// DATABASE TYPES - Match Supabase schema exactly
// =============================================================================

export interface Court {
  id: string;
  name: string;
  address: string | null;
  region_id: string | null;
  bail_hub_id: string | null;
  has_provincial: boolean;
  has_supreme: boolean;
  created_at: string;
  updated_at: string;
}

export interface Region {
  id: string;
  name: string;
  code: string;
  created_at: string;
}

export interface Contact {
  id: string;
  role_id: string;
  email: string | null;
  emails: string[] | null;
  phone: string | null;
  phones: string[] | null;
  fax: string | null;
  notes: string | null;
  created_at: string;
  updated_at: string;
}

export interface ContactRole {
  id: string;
  name: string;
  category: 'court' | 'crown';
  display_order: number;
}

export interface ContactCourt {
  contact_id: string;
  court_id: string;
}

export interface TeamsLink {
  id: string;
  court_id: string;
  name: string;
  url: string;
  phone_number: string | null;
  toll_free: string | null;
  conference_id: string | null;
  source_updated_at: string | null;
  created_at: string;
  updated_at: string;
}

export interface ShellCell {
  id: string;
  name: string;
  phones: string[] | null;
  fax: string | null;
  notes: string | null;
  created_at: string;
  updated_at: string;
}

export interface ShellCellCourt {
  cell_id: string;
  court_id: string;
}

export interface BailCourt {
  id: string;
  name: string;
  triage_time_am: string | null;
  triage_time_pm: string | null;
  court_time_am: string | null;
  court_time_pm: string | null;
  arrest_cutoff: string | null;
  youth_custody_day: string | null;
  youth_custody_time: string | null;
  source_updated_at: string | null;
  created_at: string;
  updated_at: string;
}

export interface BailTeam {
  id: string;
  bail_court_id: string;
  name: string;
  url: string;
  phone_number: string | null;
  toll_free: string | null;
  conference_id: string | null;
  source_updated_at: string | null;
  created_at: string;
  updated_at: string;
}

export interface BailContact {
  id: string;
  region_id: string;
  role: string;
  name: string | null;
  phone: string | null;
  email: string | null;
  created_at: string;
  updated_at: string;
}

export interface Program {
  id: string;
  name: string;
  location: string | null;
  region_id: string | null;
  type: string | null;
  phone: string | null;
  email: string | null;
  notes: string | null;
  created_at: string;
  updated_at: string;
}

// =============================================================================
// EXTENDED TYPES - With joined data
// =============================================================================

export interface ContactWithRole extends Contact {
  role: ContactRole;
}

export interface CourtWithRegion extends Court {
  region: Region | null;
}

export interface CourtDetails {
  court: CourtWithRegion;
  contacts: ContactWithRole[];
  cells: ShellCell[];
  teamsLinks: TeamsLink[];
  bailCourt: BailCourt | null;
  bailTeams: BailTeam[];
  bailContacts: BailContact[];
  programs: Program[];
}

// =============================================================================
// UI TYPES
// =============================================================================

export type ViewMode = 'home' | 'results' | 'detail';

export type AccordionId = 'contacts' | 'cells' | 'bail' | 'teams' | 'programs';

export interface SearchResult {
  courts: Court[];
  contacts: ContactWithRole[];
  cells: ShellCell[];
  teamsLinks: TeamsLink[];
}

export interface Toast {
  id: string;
  message: string;
  type: 'success' | 'error' | 'info';
}

// =============================================================================
// COMPONENT PROPS
// =============================================================================

export interface SectionProps {
  title: string;
  count?: string | number;
  color?: 'blue' | 'purple' | 'teal' | 'amber' | 'slate';
  defaultOpen?: boolean;
  children: React.ReactNode;
}

export interface CardProps {
  className?: string;
  children: React.ReactNode;
}

export interface ButtonProps {
  variant?: 'primary' | 'secondary' | 'ghost';
  size?: 'sm' | 'md' | 'lg';
  className?: string;
  children: React.ReactNode;
  onClick?: () => void;
  disabled?: boolean;
}
