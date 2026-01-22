'use client';

import { useMemo } from 'react';
import { Bank2, ChevronRight } from 'react-bootstrap-icons';
import { TeamsList } from './TeamsCard';
import { 
  cn, 
  textClasses, 
  cardClasses, 
  iconClasses, 
  inlineStyles,
  colors,
  getScheduleLabelClass,
  getSectionHeaderProps,
} from '@/lib/config/theme';
import { isVBTriageLink, getBailHubTag } from '@/lib/config/constants';
import type { BailCourt, BailTeam, TeamsLink, Court } from '@/types';

// ============================================================================
// SCHEDULE ROW COMPONENT (matches backup exactly)
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
// BAIL SCHEDULE COMPONENT (matches backup exactly)
// ============================================================================

interface BailScheduleProps {
  bailCourt: BailCourt;
}

export function BailSchedule({ bailCourt }: BailScheduleProps) {
  const hasSchedule = bailCourt.triage_time_am || bailCourt.triage_time_pm || 
                      bailCourt.court_start_am || bailCourt.cutoff_new_arrests;
  
  if (!hasSchedule) return null;

  const headerProps = getSectionHeaderProps();

  return (
    <div className="space-y-1.5">
      <h4 
        className={headerProps.className}
        style={headerProps.style}
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
      className="w-full flex items-center gap-3 px-3 py-2.5 rounded-lg transition-colors"
      style={{ 
        background: colors.bg.item, 
        border: `1px solid ${colors.border.subtle}` 
      }}
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
// BAIL SECTION CONTENT COMPONENT
// ============================================================================

interface BailSectionContentProps {
  bailCourt: BailCourt;
  currentCourtId: number;
  bailTeams: BailTeam[];
  courtTeams: TeamsLink[];
  onNavigateToHub?: (courtId: number) => void;
  onCopy?: (text: string, id: string) => void;
  isCopied?: (id: string) => boolean;
}

export function BailSectionContent({
  bailCourt,
  currentCourtId,
  bailTeams,
  courtTeams,
  onNavigateToHub,
  onCopy,
  isCopied,
}: BailSectionContentProps) {
  const isHub = bailCourt.court_id === currentCourtId;
  
  // Combine bail teams with VB Triage links from court teams
  const allBailTeams = useMemo(() => {
    const vbTriageFromCourt = courtTeams.filter(t => isVBTriageLink(t.name || t.courtroom));
    const combined = [...bailTeams, ...vbTriageFromCourt];
    const seen = new Set<number>();
    return combined.filter(t => {
      if (seen.has(t.id)) return false;
      seen.add(t.id);
      return true;
    });
  }, [bailTeams, courtTeams]);

  return (
    <div className="space-y-3">
      {/* Link to hub court if not the hub */}
      {!isHub && bailCourt.court_id && onNavigateToHub && (
        <BailHubLink bailCourt={bailCourt} onNavigate={onNavigateToHub} />
      )}
      
      {/* Schedule */}
      <BailSchedule bailCourt={bailCourt} />
      
      {/* Teams links */}
      {allBailTeams.length > 0 && (
        <TeamsList
          links={allBailTeams}
          filterVBTriage={false}
          onCopy={onCopy}
          isCopied={isCopied}
        />
      )}
    </div>
  );
}

export { getBailHubTag };
