'use client';

import { FaAt, FaVideo, FaMicrosoftTeams } from '@/lib/icons';
import { cn } from '@/lib/utils';
import { card, text, iconSize } from '@/lib/config/theme';
import type { JcmFxdSchedule } from '@/types';

// ============================================================================
// JCM FXD SCHEDULE ROW COMPONENT
// ============================================================================

interface ScheduleRowProps {
  label: string;
  value: string;
}

function ScheduleRow({ label, value }: ScheduleRowProps) {
  return (
    <div className={card.flexRow}>
      <span className={cn(text.scheduleLabel, 'text-slate-300')} style={{ letterSpacing: '1px' }}>
        {label}
      </span>
      <span className={text.monoValue}>{value}</span>
    </div>
  );
}

// ============================================================================
// JCM FXD SCHEDULE COMPONENT
// ============================================================================

interface JcmFxdScheduleCardProps {
  schedule: JcmFxdSchedule;
}

export function JcmFxdScheduleCard({ schedule }: JcmFxdScheduleCardProps) {
  // Determine the submission method
  const getMethodDisplay = () => {
    if (schedule.email_only) {
      return { 
        icon: <FaAt className={cn(iconSize.md, "text-emerald-400")} />,
        bg: 'bg-emerald-500/15',
        label: 'Email Only',
        sublabel: 'No in-person JCM FXD appearances',
        color: 'text-emerald-400'
      };
    }
    if (schedule.teams_only) {
      return { 
        icon: <FaMicrosoftTeams className={cn(iconSize.md, "text-indigo-400")} />,
        bg: 'bg-indigo-500/15',
        label: 'Teams Only',
        sublabel: 'Must appear via MS Teams',
        color: 'text-indigo-400'
      };
    }
    // email_acceptable - has schedule with email option
    return null;
  };

  const methodDisplay = getMethodDisplay();

  // Email Only or Teams Only - simple card display
  if (methodDisplay) {
    return (
      <div className="space-y-1.5">
        <h4 className={text.sectionHeader}>JCM Fixed Date</h4>
        <div className={cn(card.base, "p-3")}>
          <div className="flex items-center gap-2.5">
            <div className={cn("w-8 h-8 rounded-lg flex items-center justify-center", methodDisplay.bg)}>
              {methodDisplay.icon}
            </div>
            <div>
              <div className="text-sm text-slate-200">{methodDisplay.label}</div>
              <div className="text-xs text-slate-500">{methodDisplay.sublabel}</div>
            </div>
          </div>
          {schedule.notes && (
            <div className="mt-2 text-xs text-slate-400">{schedule.notes}</div>
          )}
        </div>
      </div>
    );
  }

  // Email Acceptable - shows schedule with email option
  return (
    <div className="space-y-1.5">
      <h4 className={text.sectionHeader}>JCM Fixed Date</h4>
      <div className={card.divided}>
        {schedule.days && (
          <ScheduleRow label="Days" value={schedule.days} />
        )}
        {schedule.time && (
          <ScheduleRow label="Time" value={schedule.time} />
        )}
        <div className={cn(card.flexRow, "items-center")}>
          <span className={cn(text.scheduleLabel, 'text-slate-300')} style={{ letterSpacing: '1px' }}>
            Method
          </span>
          <span className="text-xs text-emerald-400 font-medium">Email Acceptable</span>
        </div>
      </div>
      {schedule.notes && (
        <div className="px-1 text-xs text-slate-500">{schedule.notes}</div>
      )}
    </div>
  );
}
