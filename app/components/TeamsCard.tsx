'use client';

import { useState } from 'react';
import { CameraVideo, Telephone, Clipboard, Check, ChevronRight, BoxArrowUpRight } from 'react-bootstrap-icons';
import { Button } from '@/components/ui/button';
import copy from 'copy-to-clipboard';
import type { TeamsLink } from '@/types';

interface TeamsCardProps {
  link: TeamsLink;
  onCopyAll?: () => void;
}

export function TeamsCard({ link, onCopyAll }: TeamsCardProps) {
  const [copied, setCopied] = useState(false);

  const handleCopyAll = () => {
    const text = [
      link.phone && `Phone: ${link.phone}`,
      link.phone_toll_free && `Toll-free: ${link.phone_toll_free}`,
      link.conference_id && `Conference ID: ${link.conference_id}`,
    ].filter(Boolean).join('\n');
    
    copy(text);
    setCopied(true);
    onCopyAll?.();
    setTimeout(() => setCopied(false), 2000);
  };

  const handleJoin = () => {
    if (link.teams_link) {
      window.open(link.teams_link, '_blank');
    }
  };

  const displayName = link.courtroom || link.name || 'MS Teams';

  return (
    <div className="py-2.5 px-3 rounded-lg bg-slate-800/30">
      <div className="flex items-center justify-between gap-2">
        <div className="flex items-center gap-2 flex-1 min-w-0">
          <CameraVideo className="w-4 h-4 text-slate-400 flex-shrink-0" />
          <span className="text-sm font-medium text-slate-200 truncate">{displayName}</span>
        </div>
        
        {link.teams_link && (
          <Button
            variant="secondary"
            size="sm"
            className="bg-indigo-600 hover:bg-indigo-500 text-white text-xs px-3 h-7"
            onClick={handleJoin}
          >
            <BoxArrowUpRight className="w-3 h-3 mr-1" />
            Join
          </Button>
        )}
      </div>
      
      {/* Dial-in info - tap to copy */}
      {(link.phone || link.conference_id) && (
        <div 
          className="mt-2 p-2 rounded bg-slate-900/50 cursor-pointer hover:bg-slate-900/70 transition-colors"
          onClick={handleCopyAll}
        >
          <div className="flex items-start justify-between gap-2">
            <div className="flex-1 min-w-0 space-y-0.5">
              {link.phone && (
                <div className="flex items-center gap-1.5 text-xs text-slate-400">
                  <Telephone className="w-3 h-3" />
                  <span>{link.phone}</span>
                </div>
              )}
              {link.phone_toll_free && (
                <div className="text-xs text-slate-500 ml-4.5">
                  Toll-free: {link.phone_toll_free}
                </div>
              )}
              {link.conference_id && (
                <div className="text-xs text-slate-400 font-mono">
                  ID: {link.conference_id}
                </div>
              )}
            </div>
            
            {copied ? (
              <Check className="w-4 h-4 text-green-400 flex-shrink-0" />
            ) : (
              <Clipboard className="w-4 h-4 text-slate-500 flex-shrink-0" />
            )}
          </div>
        </div>
      )}
    </div>
  );
}

// Teams links preview card for search results (shows count, tap to navigate)
interface TeamsLinkCountCardProps {
  count: number;
  onClick?: () => void;
}

export function TeamsLinkCountCard({ count, onClick }: TeamsLinkCountCardProps) {
  if (count === 0) return null;

  return (
    <div 
      className="py-3 px-4 rounded-lg bg-slate-800/50 border border-slate-700/50 cursor-pointer hover:bg-slate-800 transition-colors active:bg-slate-700"
      onClick={onClick}
    >
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-2">
          <CameraVideo className="w-4 h-4 text-indigo-400" />
          <span className="text-sm font-medium text-slate-200">
            {count} MS Teams Link{count !== 1 ? 's' : ''}
          </span>
        </div>
        <ChevronRight className="w-4 h-4 text-slate-500" />
      </div>
    </div>
  );
}

// Full teams list for court detail page
interface TeamsListProps {
  links: TeamsLink[];
  onCopyAll?: () => void;
}

export function TeamsList({ links, onCopyAll }: TeamsListProps) {
  if (links.length === 0) return null;

  return (
    <div className="space-y-1.5">
      <h4 className="text-xs font-medium text-slate-400 uppercase tracking-wide px-1">MS Teams</h4>
      {links.map((link) => (
        <TeamsCard key={link.id} link={link} onCopyAll={onCopyAll} />
      ))}
    </div>
  );
}

