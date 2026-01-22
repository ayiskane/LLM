'use client';

import { GeoAlt } from 'react-bootstrap-icons';
import { cn, colors } from '@/lib/config/theme';
import { Tag } from '../ui/Tag';
import { openInMaps } from '@/lib/utils';
import type { Court } from '@/types';

interface CourtHeaderProps {
  court: Court;
  collapsed?: boolean;
  className?: string;
}

export function CourtHeader({ court, collapsed = false, className }: CourtHeaderProps) {
  const displayName = court.name.toLowerCase().includes('court') 
    ? court.name 
    : `${court.name} Law Courts`;

  if (collapsed) {
    return (
      <div className={cn('flex items-center gap-2 py-2 px-4', className)}>
        <h1 className="text-sm font-semibold text-white flex-1 truncate">
          {displayName}
        </h1>
        <div className="flex items-center gap-1 shrink-0">
          {court.has_provincial && <Tag color="emerald" size="sm">PC</Tag>}
          {court.has_supreme && <Tag color="purple" size="sm">SC</Tag>}
          {court.is_circuit && <Tag color="amber" size="sm">CIR</Tag>}
        </div>
        {court.address && (
          <button
            onClick={() => openInMaps(court.address)}
            className="p-1.5 rounded-md transition-colors shrink-0"
            style={{ background: colors.bg.item }}
          >
            <GeoAlt className="w-4 h-4 text-blue-400" />
          </button>
        )}
      </div>
    );
  }

  return (
    <div className={cn('py-3 px-4', className)}>
      <h1 className="text-lg font-semibold text-white">
        {displayName}
      </h1>
      
      {court.address && (
        <button
          onClick={() => openInMaps(court.address)}
          className="flex items-center gap-1 text-xs mt-1 hover:text-blue-400 transition-colors"
          style={{ color: colors.text.subtle }}
        >
          <GeoAlt className="w-3 h-3" />
          <span>{court.address}</span>
        </button>
      )}
      
      <div className="flex flex-wrap items-center gap-1.5 mt-2">
        {court.region_code && (
          <span 
            className="px-2 py-1.5 rounded text-[9px] font-mono leading-none inline-flex items-center gap-1 uppercase"
            style={{ 
              background: 'rgba(255,255,255,0.05)', 
              border: `1px solid ${colors.border.primary}`,
              color: colors.text.muted,
              letterSpacing: '2px'
            }}
          >
            <span>{court.region_code}</span>
            <span style={{ color: colors.text.disabled }}>|</span>
            <span>{court.region_name}</span>
          </span>
        )}
        {court.has_provincial && <Tag color="emerald">PROVINCIAL</Tag>}
        {court.has_supreme && <Tag color="purple">SUPREME</Tag>}
        {court.is_circuit && <Tag color="amber">CIRCUIT</Tag>}
      </div>
    </div>
  );
}
