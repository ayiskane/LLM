'use client';

import { useState, useMemo } from 'react';
import { MicrosoftTeams, Eye, EyeSlash, Clipboard, ClipboardCheck, Telephone } from 'react-bootstrap-icons';
import { Button } from '@/app/components/ui/Button';
import { cn, textClasses, iconClasses, inlineStyles } from '@/lib/config/theme';
import { formatDate, joinTeamsMeeting } from '@/lib/utils';
import { isVBTriageLink } from '@/lib/config/constants';
import type { TeamsLink, BailTeam } from '@/types';

// ============================================================================
// HELPER: Format courtroom name (matches backup - ADDS CR prefix)
// ============================================================================

function formatCourtroomName(link: TeamsLink | BailTeam): string {
  const name = link.courtroom || link.name || 'MS Teams';
  
  // Don't modify JCM FXD or special names
  if (name.toLowerCase().includes('jcm') || name.toLowerCase().includes('fxd') || name.toLowerCase().includes('triage')) {
    return name;
  }
  
  // Check if it's already prefixed with CR
  if (name.toLowerCase().startsWith('cr ') || name.toLowerCase().startsWith('cr-')) {
    return name;
  }
  
  // Check if it's a number or starts with a number (courtroom number)
  const numMatch = name.match(/^(\d+)/);
  if (numMatch) {
    return `CR ${name}`;
  }
  
  // Check for patterns like "Courtroom 101" and convert to "CR 101"
  const courtroomMatch = name.match(/^courtroom\s*(\d+)/i);
  if (courtroomMatch) {
    return `CR ${courtroomMatch[1]}`;
  }
  
  return name;
}

// ============================================================================
// TEAMS CARD COMPONENT
// ============================================================================

interface TeamsCardProps {
  link: TeamsLink | BailTeam;
  showDialIn?: boolean;
  onCopy?: (text: string, id: string) => void;
  isCopied?: (id: string) => boolean;
}

export function TeamsCard({ link, showDialIn = false, onCopy, isCopied }: TeamsCardProps) {
  const displayName = formatCourtroomName(link);
  const hasDialInInfo = link.phone || link.conference_id;
  
  const handleCopyAll = () => {
    if (!onCopy) return;
    const text = [
      link.phone && `Phone: ${link.phone}`,
      link.phone_toll_free && `Toll-free: ${link.phone_toll_free}`,
      link.conference_id && `Conference ID: ${link.conference_id}`,
    ].filter(Boolean).join('\n');
    onCopy(text, `teams-${link.id}`);
  };

  return (
    <div className="py-2.5 px-3 rounded-lg bg-slate-800/30">
      <div className="flex items-center justify-between gap-2">
        <div className="flex items-center gap-2 flex-1 min-w-0">
          <MicrosoftTeams className={cn(iconClasses.md, 'text-slate-400 flex-shrink-0')} />
          <span className={cn(textClasses.secondary, 'text-sm font-medium truncate')}>{displayName}</span>
        </div>
        
        {link.teams_link && (
          <Button
            variant="join"
            size="sm"
            onClick={() => joinTeamsMeeting(link.teams_link)}
          >
            Join
          </Button>
        )}
      </div>
      
      {/* Dial-in info - collapsed by default */}
      {hasDialInInfo && showDialIn && (
        <div 
          className="mt-2 p-2 rounded bg-slate-900/50 cursor-pointer hover:bg-slate-900/70 transition-colors"
          onClick={handleCopyAll}
        >
          <div className="flex items-start justify-between gap-2">
            <div className="flex-1 min-w-0 space-y-0.5">
              {link.phone && (
                <div className="flex items-center gap-1.5 text-xs text-slate-400">
                  <Telephone className={iconClasses.xs} />
                  <span>{link.phone}</span>
                </div>
              )}
              {link.phone_toll_free && (
                <div className="text-xs text-slate-500 ml-4.5">
                  Toll-free: {link.phone_toll_free}
                </div>
              )}
              {link.conference_id && (
                <div className={cn(textClasses.monoValue, 'text-slate-400')}>
                  ID: {link.conference_id}
                </div>
              )}
            </div>
            
            {isCopied && isCopied(`teams-${link.id}`) ? (
              <ClipboardCheck className={cn(iconClasses.md, 'text-green-400 flex-shrink-0')} />
            ) : (
              <Clipboard className={cn(iconClasses.md, 'text-slate-500 flex-shrink-0')} />
            )}
          </div>
        </div>
      )}
    </div>
  );
}

// ============================================================================
// TEAMS LIST COMPONENT
// ============================================================================

interface TeamsListProps {
  links: (TeamsLink | BailTeam)[];
  filterVBTriage?: boolean;
  onCopy?: (text: string, id: string) => void;
  isCopied?: (id: string) => boolean;
}

export function TeamsList({ links, filterVBTriage = true, onCopy, isCopied }: TeamsListProps) {
  const [showDialIn, setShowDialIn] = useState(false);
  
  // Filter out VB Triage if requested
  const filteredLinks = useMemo(() => {
    if (!filterVBTriage) return links;
    return links.filter(link => !isVBTriageLink(link.name || link.courtroom));
  }, [links, filterVBTriage]);
  
  // Check if any links have dial-in info
  const hasAnyDialInInfo = filteredLinks.some(link => link.phone || link.conference_id);
  
  // Get most recent update date
  const lastUpdated = useMemo(() => {
    const dates = filteredLinks
      .map(l => 'source_updated_at' in l ? l.source_updated_at : null)
      .filter((d): d is string => !!d)
      .map(d => new Date(d))
      .filter(d => !isNaN(d.getTime()));
    
    if (dates.length === 0) return null;
    
    const mostRecent = new Date(Math.max(...dates.map(d => d.getTime())));
    return mostRecent.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
  }, [filteredLinks]);

  if (filteredLinks.length === 0) return null;

  return (
    <div className="space-y-1.5">
      {/* Header with Last Updated and Eye Toggle */}
      <div className="flex items-center justify-between px-1">
        {lastUpdated && (
          <span 
            className={textClasses.lastUpdated}
            style={inlineStyles.roleLabelNormal}
          >
            Last Updated: {lastUpdated}
          </span>
        )}
        {hasAnyDialInInfo && (
          <button
            onClick={() => setShowDialIn(!showDialIn)}
            className="flex items-center gap-1 text-xs text-slate-500 hover:text-slate-300 transition-colors"
            style={inlineStyles.roleLabelNormal}
          >
            {showDialIn ? (
              <>
                <EyeSlash className={iconClasses.sm} />
                <span>Hide dial-in</span>
              </>
            ) : (
              <>
                <Eye className={iconClasses.sm} />
                <span>Show dial-in</span>
              </>
            )}
          </button>
        )}
      </div>
      
      {/* Links */}
      {filteredLinks.map((link) => (
        <TeamsCard
          key={link.id}
          link={link}
          showDialIn={showDialIn}
          onCopy={onCopy}
          isCopied={isCopied}
        />
      ))}
    </div>
  );
}
