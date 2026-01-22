'use client';

import { Bank2, ChevronRight } from 'react-bootstrap-icons';
import { theme } from '@/lib/theme';
import { TeamsList, isVBTriageLink } from './TeamsCard';
import type { BailCourt, TeamsLink, Court } from '@/types';

// Schedule row component
function ScheduleRow({ 
  label, 
  value, 
  isAmber = false 
}: { 
  label: string; 
  value: string; 
  isAmber?: boolean;
}) {
  return (
    <div className="flex justify-between px-4 py-2.5">
      <span 
        className={`text-xs font-mono font-semibold uppercase ${isAmber ? 'text-amber-400' : 'text-slate-300'}`}
        style={{ letterSpacing: '1px' }}
      >
        {label}
      </span>
      <span className="text-slate-400 text-xs font-mono">{value}</span>
    </div>
  );
}

// Schedule section for bail court
interface BailScheduleProps {
  bailCourt: BailCourt;
}

export function BailSchedule({ bailCourt }: BailScheduleProps) {
  const hasSchedule = bailCourt.triage_time_am || bailCourt.triage_time_pm || 
                      bailCourt.court_start_am || bailCourt.cutoff_new_arrests;
  
  if (!hasSchedule) return null;

  return (
    <div className="space-y-1.5">
      <h4 
        className="text-xs text-slate-500 uppercase px-1" 
        style={{ fontFamily: 'Inter, sans-serif', letterSpacing: '1px' }}
      >
        Schedule
      </h4>
      
      <div className="bg-slate-800/30 rounded-lg border border-slate-700/50 overflow-hidden divide-y divide-slate-700/50">
        {/* Triage */}
        {(bailCourt.triage_time_am || bailCourt.triage_time_pm) && (
          <ScheduleRow 
            label="Triage" 
            value={[bailCourt.triage_time_am, bailCourt.triage_time_pm].filter(Boolean).join(' / ')} 
          />
        )}

        {/* Court */}
        {(bailCourt.court_start_am || bailCourt.court_start_pm) && (
          <ScheduleRow 
            label="Court" 
            value={[bailCourt.court_start_am, bailCourt.court_start_pm].filter(Boolean).join(' / ')} 
          />
        )}

        {/* Cutoff */}
        {bailCourt.cutoff_new_arrests && (
          <ScheduleRow label="Cutoff" value={bailCourt.cutoff_new_arrests} />
        )}

        {/* Youth In-Custody */}
        {bailCourt.youth_custody_day && bailCourt.youth_custody_time && (
          <ScheduleRow 
            label="Youth" 
            value={`${bailCourt.youth_custody_day} ${bailCourt.youth_custody_time}`}
            isAmber 
          />
        )}
      </div>
    </div>
  );
}

// Link card to navigate to bail hub court
interface BailHubLinkProps {
  bailCourt: BailCourt;
  onNavigate: (courtId: number) => void;
}

export function BailHubLink({ bailCourt, onNavigate }: BailHubLinkProps) {
  if (!bailCourt.court_id) return null;

  return (
    <button
      onClick={() => onNavigate(bailCourt.court_id!)}
      className="w-full flex items-center gap-3 p-3 rounded-lg transition-colors hover:bg-slate-700/50"
      style={{ background: theme.colors.bg.item, border: `1px solid ${theme.colors.border.subtle}` }}
    >
      <Bank2 className="w-4 h-4 text-teal-400" />
      <span className="flex-1 text-left text-sm font-medium text-white">
        {bailCourt.name.replace(' Virtual Bail', '')} Law Courts
      </span>
      <ChevronRight className="w-4 h-4 text-slate-500" />
    </button>
  );
}

// Combined bail teams list (bail court teams + VB Triage from court teams)
interface BailTeamsListProps {
  bailTeams: TeamsLink[];
  courtTeams: TeamsLink[];
  onCopyAll?: () => void;
}

export function BailTeamsList({ bailTeams, courtTeams, onCopyAll }: BailTeamsListProps) {
  // Get VB Triage links from court teams
  const vbTriageLinks = courtTeams.filter(isVBTriageLink);
  
  // Deduplicate: only add VB Triage links that aren't already in bail teams
  const existingIds = new Set(bailTeams.map(l => l.id));
  const uniqueVbTriageLinks = vbTriageLinks.filter(l => !existingIds.has(l.id));
  
  const allBailTeams = [...bailTeams, ...uniqueVbTriageLinks];
  
  if (allBailTeams.length === 0) return null;

  return <TeamsList links={allBailTeams} onCopyAll={onCopyAll} filterVBTriage={false} />;
}

// Full bail section content (used inside Section accordion)
interface BailSectionContentProps {
  bailCourt: BailCourt;
  currentCourtId: number;
  bailTeams: TeamsLink[];
  courtTeams: TeamsLink[];
  onNavigateToHub: (courtId: number) => void;
  onCopyTeams?: () => void;
}

export function BailSectionContent({ 
  bailCourt, 
  currentCourtId,
  bailTeams, 
  courtTeams, 
  onNavigateToHub,
  onCopyTeams 
}: BailSectionContentProps) {
  const isHubCourt = bailCourt.court_id === currentCourtId;

  return (
    <div className="p-3 space-y-3">
      {/* If bail hub is different court, show link card */}
      {!isHubCourt && bailCourt.court_id && (
        <BailHubLink bailCourt={bailCourt} onNavigate={onNavigateToHub} />
      )}

      {/* Schedule */}
      <BailSchedule bailCourt={bailCourt} />

      {/* Teams Links */}
      <BailTeamsList 
        bailTeams={bailTeams} 
        courtTeams={courtTeams} 
        onCopyAll={onCopyTeams} 
      />
    </div>
  );
}

// Helper to get bail hub tag text
export function getBailHubTag(bailCourt: BailCourt): string {
  if (!bailCourt.name) return '';
  return `${bailCourt.name.toUpperCase().replace(' VIRTUAL BAIL', '').replace('FRASER', 'ABBY')} HUB`;
}
