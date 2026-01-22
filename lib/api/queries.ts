import { createClient } from './supabase';
import type {
  Court,
  CourtWithRegion,
  ContactWithRole,
  ShellCell,
  TeamsLink,
  BailCourt,
  BailTeam,
  BailContact,
  Program,
  CourtDetails,
} from '@/types';

const supabase = createClient();

// =============================================================================
// COURTS
// =============================================================================

export async function fetchCourts(): Promise<Court[]> {
  const { data, error } = await supabase
    .from('courts')
    .select('*')
    .order('name');

  if (error) throw error;
  return data || [];
}

export async function fetchCourtById(id: string): Promise<CourtWithRegion | null> {
  const { data, error } = await supabase
    .from('courts')
    .select(`
      *,
      region:regions(*)
    `)
    .eq('id', id)
    .single();

  if (error) throw error;
  return data;
}

// =============================================================================
// CONTACTS
// =============================================================================

export async function fetchContacts(): Promise<ContactWithRole[]> {
  const { data, error } = await supabase
    .from('contacts')
    .select(`
      *,
      role:contact_roles(*)
    `)
    .order('role_id');

  if (error) throw error;
  return data || [];
}

export async function fetchContactsByCourtId(courtId: string): Promise<ContactWithRole[]> {
  const { data, error } = await supabase
    .from('contacts_courts')
    .select(`
      contact:contacts(
        *,
        role:contact_roles(*)
      )
    `)
    .eq('court_id', courtId);

  if (error) throw error;
  return data?.map(item => item.contact).filter(Boolean) || [];
}

// =============================================================================
// CELLS
// =============================================================================

export async function fetchCells(): Promise<ShellCell[]> {
  const { data, error } = await supabase
    .from('sheriff_cells')
    .select('*')
    .order('name');

  if (error) throw error;
  return data || [];
}

export async function fetchCellsByCourtId(courtId: string): Promise<ShellCell[]> {
  const { data, error } = await supabase
    .from('sheriff_cells_courts')
    .select(`
      cell:sheriff_cells(*)
    `)
    .eq('court_id', courtId);

  if (error) throw error;
  return data?.map(item => item.cell).filter(Boolean) || [];
}

// =============================================================================
// TEAMS LINKS
// =============================================================================

export async function fetchTeamsLinks(): Promise<TeamsLink[]> {
  const { data, error } = await supabase
    .from('teams_links')
    .select('*')
    .order('name');

  if (error) throw error;
  return data || [];
}

export async function fetchTeamsLinksByCourtId(courtId: string): Promise<TeamsLink[]> {
  const { data, error } = await supabase
    .from('teams_links')
    .select('*')
    .eq('court_id', courtId)
    .order('name');

  if (error) throw error;
  return data || [];
}

// =============================================================================
// BAIL
// =============================================================================

export async function fetchBailCourts(): Promise<BailCourt[]> {
  const { data, error } = await supabase
    .from('bail_courts')
    .select('*')
    .order('name');

  if (error) throw error;
  return data || [];
}

export async function fetchBailCourtById(id: string): Promise<BailCourt | null> {
  const { data, error } = await supabase
    .from('bail_courts')
    .select('*')
    .eq('id', id)
    .single();

  if (error) throw error;
  return data;
}

export async function fetchBailTeamsByBailCourtId(bailCourtId: string): Promise<BailTeam[]> {
  const { data, error } = await supabase
    .from('bail_teams')
    .select('*')
    .eq('bail_court_id', bailCourtId)
    .order('name');

  if (error) throw error;
  return data || [];
}

export async function fetchBailContactsByRegionId(regionId: string): Promise<BailContact[]> {
  const { data, error } = await supabase
    .from('bail_contacts')
    .select('*')
    .eq('region_id', regionId)
    .order('role');

  if (error) throw error;
  return data || [];
}

// =============================================================================
// PROGRAMS
// =============================================================================

export async function fetchPrograms(): Promise<Program[]> {
  const { data, error } = await supabase
    .from('programs')
    .select('*')
    .order('name');

  if (error) throw error;
  return data || [];
}

export async function fetchProgramsByRegionId(regionId: string): Promise<Program[]> {
  const { data, error } = await supabase
    .from('programs')
    .select('*')
    .eq('region_id', regionId)
    .order('name');

  if (error) throw error;
  return data || [];
}

// =============================================================================
// COMBINED QUERIES
// =============================================================================

export async function fetchCourtDetails(courtId: string): Promise<CourtDetails | null> {
  const court = await fetchCourtById(courtId);
  if (!court) return null;

  const [contacts, cells, teamsLinks] = await Promise.all([
    fetchContactsByCourtId(courtId),
    fetchCellsByCourtId(courtId),
    fetchTeamsLinksByCourtId(courtId),
  ]);

  let bailCourt: BailCourt | null = null;
  let bailTeams: BailTeam[] = [];
  let bailContacts: BailContact[] = [];
  let programs: Program[] = [];

  if (court.bail_hub_id) {
    bailCourt = await fetchBailCourtById(court.bail_hub_id);
    if (bailCourt) {
      bailTeams = await fetchBailTeamsByBailCourtId(bailCourt.id);
    }
  }

  if (court.region_id) {
    [bailContacts, programs] = await Promise.all([
      fetchBailContactsByRegionId(court.region_id),
      fetchProgramsByRegionId(court.region_id),
    ]);
  }

  return {
    court,
    contacts,
    cells,
    teamsLinks,
    bailCourt,
    bailTeams,
    bailContacts,
    programs,
  };
}

// =============================================================================
// BULK FETCH FOR SEARCH INDEX
// =============================================================================

export interface SearchIndexData {
  courts: Court[];
  contacts: ContactWithRole[];
  cells: ShellCell[];
  teamsLinks: TeamsLink[];
}

export async function fetchSearchIndexData(): Promise<SearchIndexData> {
  const [courts, contacts, cells, teamsLinks] = await Promise.all([
    fetchCourts(),
    fetchContacts(),
    fetchCells(),
    fetchTeamsLinks(),
  ]);

  return { courts, contacts, cells, teamsLinks };
}
