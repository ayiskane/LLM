'use client';

import { FaAt } from '@/lib/icons';
import { cn } from '@/lib/utils';
import { card, text, iconSize } from '@/lib/config/theme';
import type { JcmFxdSchedule } from '@/types';

// ============================================================================
// JCM FXD SCHEDULE ROW COMPONENT
// ============================================================================

interface ScheduleRowProps {
  label: string;
  value: string;
  icon?: React.ReactNode;
}

function ScheduleRow({ label, value, icon }: ScheduleRowProps) {
  return (
    <div className={card.flexRow}>
      <div className="flex items-center gap-2">
        {icon}
        <span className={cn(text.scheduleLabel, 'text-slate-300')} style={{ letterSpacing: '1px' }}>
          {label}
        </span>
      </div>
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
  // Email only courts (like Chilliwack) - no in-person appearances
  if (schedule.email_only) {
    return (
      <div className="space-y-1.5">
        <h4 className={text.sectionHeader}>JCM Fixed Date</h4>
        <div className={cn(card.base, "p-3")}>
          <div className="flex items-center gap-2.5">
            <div className="w-8 h-8 rounded-lg bg-emerald-500/15 flex items-center justify-center">
              <FaAt className={cn(iconSize.md, "text-emerald-400")} />
            </div>
            <div>
              <div className="text-sm text-slate-200">Email Only</div>
              <div className="text-xs text-slate-500">No in-person JCM FXD appearances</div>
            </div>
          </div>
          {schedule.notes && (
            <div className="mt-2 text-xs text-slate-400">{schedule.notes}</div>
          )}
        </div>
      </div>
    );
  }

  // Courts with scheduled appearances
  return (
    <div className="space-y-1.5">
      <h4 className={text.sectionHeader}>JCM Fixed Date</h4>
      <div className={card.divided}>
        {schedule.days && (
          <ScheduleRow 
            label="Days" 
            value={schedule.days}
          />
        )}
        {schedule.time && (
          <ScheduleRow 
            label="Time" 
            value={schedule.time}
          />
        )}
        {schedule.email_acceptable && (
          <div className={cn(card.flexRow, "items-center")}>
            <span className={cn(text.scheduleLabel, 'text-slate-300')} style={{ letterSpacing: '1px' }}>
              Email
            </span>
            <span className="text-xs text-emerald-400 font-medium">Acceptable</span>
          </div>
        )}
      </div>
      {schedule.notes && (
        <div className="px-1 text-xs text-slate-500">{schedule.notes}</div>
      )}
    </div>
  );
}
