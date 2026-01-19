// TypeScript Types for BC Legal Reference Database

export interface Court {
  id: number;
  name: string;
  region?: string;
  crown_email?: string;
  jcm_scheduling_email?: string;
  court_registry_email?: string;
  criminal_registry_email?: string;
  bail_crown_email?: string;
  bail_jcm_email?: string;
  interpreter_request_email?: string;
  address?: string;
  phone?: string;
}

export interface PoliceCell {
  id: number;
  name: string;
  region?: string;
  phone1?: string;
  phone2?: string;
  phone3?: string;
  phone4?: string;
  notes?: string;
}

export interface CorrectionalFacility {
  id: number;
  name: string;
  type: 'provincial' | 'federal';
  region?: string;
  phone?: string;
  fax?: string;
  email?: string;
  unlock_hours?: string;
  visit_hours?: string;
  notes?: string;
}

export interface BailContact {
  id: number;
  region: string;
  name: string;
  email?: string;
  type: 'daytime' | 'evening' | 'all_hours';
  notes?: string;
}

export interface BailCoordinator {
  id: number;
  name: string;
  region: string;
  email?: string;
  phone?: string;
  is_backup: boolean;
}

export interface CrownContact {
  id: number;
  name: string;
  region?: string;
  court?: string;
  email?: string;
  phone?: string;
  mobile?: string;
  role?: string;
}

export interface LABCOffice {
  id: number;
  location?: string;
  region?: string;
  type: 'intake' | 'call_centre' | 'priority_line' | 'email' | 'navigator' | 'local_agent';
  phone?: string;
  email?: string;
  hours?: string;
  local_agent?: string;
  assistant?: string;
}

export interface LABCNavigator {
  id: number;
  name: string;
  phone?: string;
  email?: string;
  courts?: string;
  spare_for?: string;
}

export interface ForensicClinic {
  id: number;
  name: string;
  address?: string;
  city?: string;
  phone?: string;
  email?: string;
}

export interface IndigenousJusticeCentre {
  id: number;
  location: string;
  phone?: string;
  email?: string;
  website?: string;
}

export interface MSTeamsLink {
  id: number;
  court?: string;
  courtroom?: string;
  region?: string;
  function?: string;
  teams_link?: string;
  conference_id?: string;
  phone: string;
  toll_free: string;
}

export interface Program {
  id: number;
  name: string;
  location?: string;
  phone?: string;
  gender?: string;
  indigenous_only: boolean;
  in_residence: boolean;
  application_by?: string;
  notes?: string;
}

export interface AccessCode {
  id: number;
  court: string;
  code?: string;
  notes?: string;
}

export interface CircuitCourt {
  id: number;
  name: string;
  region?: string;
  contact_hub?: string;
  schedule?: string;
}

// Search result type
export interface SearchResult {
  type: 'court' | 'police_cell' | 'corrections' | 'forensic_clinic' | 'ijc' | 'program' | 'crown' | 'labc';
  id: number;
  title: string;
  details: string;
  region?: string;
}

// Virtual Bail Region
export type VirtualBailRegion = 'R1' | 'R2' | 'R3' | 'R4' | 'R5';

export interface VirtualBailRegionInfo {
  code: VirtualBailRegion;
  name: string;
  coverage: string[];
  hasDaytime: boolean;
  hasEvening: boolean;
  email: string;
  eveningEmail?: string;
}

export const VIRTUAL_BAIL_REGIONS: Record<VirtualBailRegion, VirtualBailRegionInfo> = {
  R1: {
    code: 'R1',
    name: 'Island',
    coverage: ['Victoria', 'Duncan', 'Nanaimo', 'Campbell River', 'Courtenay', 'Port Alberni', 'Port Hardy', 'Powell River'],
    hasDaytime: true,
    hasEvening: true,
    email: 'Region1.virtualbail@gov.bc.ca',
    eveningEmail: 'VictoriaCrown.Public@gov.bc.ca'
  },
  R2: {
    code: 'R2',
    name: 'Vancouver Coastal',
    coverage: ['222 Main (Vancouver)', 'North Vancouver', 'Richmond'],
    hasDaytime: true,
    hasEvening: false,
    email: '222MainCrownBail@gov.bc.ca'
  },
  R3: {
    code: 'R3',
    name: 'Fraser',
    coverage: ['Abbotsford', 'Chilliwack', 'Surrey', 'Port Coquitlam', 'New Westminster'],
    hasDaytime: true,
    hasEvening: false,
    email: 'Abbotsford.VirtualBail@gov.bc.ca'
  },
  R4: {
    code: 'R4',
    name: 'Interior',
    coverage: ['Kelowna', 'Penticton', 'Kamloops', 'Vernon', 'Salmon Arm', 'Cranbrook', 'Nelson'],
    hasDaytime: true,
    hasEvening: true,
    email: 'Region4.virtualbail@gov.bc.ca'
  },
  R5: {
    code: 'R5',
    name: 'North',
    coverage: ['Prince George', 'Quesnel', 'Williams Lake', 'Dawson Creek', 'Fort St. John', 'Fort Nelson', 'Prince Rupert', 'Terrace', 'Smithers'],
    hasDaytime: true,
    hasEvening: true,
    email: 'Region5.virtualbail@gov.bc.ca'
  }
};
