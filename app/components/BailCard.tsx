'use client';

import { Bank2, ChevronRight } from 'react-bootstrap-icons';
import { 
  theme, 
  cardClasses, 
  textClasses, 
  iconClasses, 
  buttonClasses,
  inlineStyles,
  cn,
  getScheduleLabelClass 
} from '@/lib/theme';
import { TeamsList } from './TeamsCard';
import type { BailCourt, TeamsLink } from '@/types';

// ============================================================================
// SCHEDULE ROW COMPONENT
// ============================================================================

interface ScheduleRowProps {
  label: string;
  value: string;
  isAmber?: boolean;
}

function ScheduleRow({ label, value, isAmber = false }: ScheduleRowProps) {
  return (
    <div className={cardClasses.flexRow}>
      <span 
        className={getScheduleLabelClass(isAmber)}
        style={inlineStyles.scheduleLabel}
      >
        {label}
      </span>
      <span className={textClasses.monoValue}>{value}</span>
    </div>
  );
}

// ============================================================================
// BAIL SCHEDULE COMPONENT
// ============================================================================

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
        className={textClasses.sectionHeader}
        style={inlineStyles.sectionHeader}
      >
        Schedule
      </h4>
      
      <div className={cardClasses.containerDivided}>
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

// ============================================================================
// BAIL HUB LINK COMPONENT
// ============================================================================

interface BailHubLinkProps {
  bailCourt: BailCourt;
  onNavigate: (courtId: number) => void;
}

export function BailHubLink({ bailCourt, onNavigate }: BailHubLinkProps) {
  if (!bailCourt.court_id) return null;

  return (
    <button
      onClick={() => onNavigate(bailCourt.court_id!)}
      className={buttonClasses.navLink}
      style={{ background: theme.colors.bg.item, border: `1px solid ${theme.colors.border.subtle}` }}
    >
      <Bank2 className={cn(iconClasses.md, 'text-teal-400')} />
      <span className="flex-1 text-left text-sm font-medium text-white">
        {bailCourt.name.replace(' Virtual Bail', '')} Law Courts
      </span>
      <ChevronRight className={cn(iconClasses.md, 'text-slate-500')} />
    </button>
  );
}

// ============================================================================
// BAIL TEAMS LIST COMPONENT
// ============================================================================

interface BailTeamsListProps {
  bailTeams: TeamsLink[];
  courtTeams: TeamsLink[];
  onCopyAll?: () => void;
}

export function BailTeamsList({ bailTeams, courtTeams, onCopyAll }: BailTeamsListProps) {
  // Get VB Triage links from court teams
  const isVBTriageLink = (link: TeamsLink): boolean => {
    const name = (link.courtroom || link.name || '').toLowerCase();
    return name.includes('vb triage') || name.includes('vbtriage') || name.includes('triage');
  };

  const vbTriageLinks = courtTeams.filter(isVBTriageLink);
  
  // Deduplicate: only add VB Triage links that aren't already in bail teams
  const existingIds = new Set(bailTeams.map(l => l.id));
  const uniqueVbTriageLinks = vbTriageLinks.filter(l => !existingIds.has(l.id));
  
  const allBailTeams = [...bailTeams, ...uniqueVbTriageLinks];
  
  if (allBailTeams.length === 0) return null;

  return <TeamsList links={allBailTeams} onCopyAll={onCopyAll} filterVBTriage={false} />;
}

// ============================================================================
// BAIL SECTION CONTENT COMPONENT
// ============================================================================

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

// ============================================================================
// HELPER FUNCTIONS
// ============================================================================

/**
 * Get bail hub tag text for section header
 */
export function getBailHubTag(bailCourt: BailCourt): string {
  if (!bailCourt.name) return '';
  return `${bailCourt.name.toUpperCase().replace(' VIRTUAL BAIL', '').replace('FRASER', 'ABBY')} HUB`;
}
