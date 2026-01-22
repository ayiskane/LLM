'use client';

import { useState } from 'react';
import { Clipboard, ClipboardCheck, Telephone, Envelope, ChevronDown, ChevronUp } from 'react-bootstrap-icons';
import { Card } from '@/app/components/ui/Card';
import { cn, textClasses, iconClasses, inlineStyles } from '@/lib/config/theme';
import { formatPhone, formatEmailsForCopy, makeCall, sendEmail } from '@/lib/utils';
import { ROLE_DISPLAY_NAMES, COURT_CONTACT_ROLES, CROWN_CONTACT_ROLES } from '@/lib/config/constants';
import type { ContactWithRole } from '@/types';

interface ContactCardProps {
  contact: ContactWithRole;
  onCopy: (text: string, id: string) => void;
  isCopied: (id: string) => boolean;
}

export function ContactCard({ contact, onCopy, isCopied }: ContactCardProps) {
  const [isExpanded, setIsExpanded] = useState(false);
  const roleDisplayName = ROLE_DISPLAY_NAMES[contact.role_id] || contact.role?.name || 'Contact';
  
  // Get all emails
  const emails = contact.emails?.length ? contact.emails : (contact.email ? [contact.email] : []);
  const hasMultipleEmails = emails.length > 1;
  
  // Format emails for display
  const displayEmails = emails.join(', ');
  const copyText = formatEmailsForCopy(emails);
  const isTruncated = displayEmails.length > 40;

  return (
    <Card className="p-3">
      <div className="flex items-start justify-between gap-2">
        <div className="flex-1 min-w-0">
          {/* Role label */}
          <div 
            className={textClasses.roleLabel}
            style={inlineStyles.roleLabel}
          >
            {roleDisplayName}
          </div>
          
          {/* Email(s) */}
          {emails.length > 0 && (
            <div className="mt-1">
              {isExpanded ? (
                <div className="space-y-0.5">
                  {emails.map((email, idx) => (
                    <button
                      key={idx}
                      onClick={() => sendEmail(email)}
                      className={cn(textClasses.link, 'text-sm block truncate')}
                    >
                      {email}
                    </button>
                  ))}
                </div>
              ) : (
                <span className="text-sm text-slate-300 truncate block">
                  {isTruncated ? displayEmails.slice(0, 40) + '...' : displayEmails}
                </span>
              )}
            </div>
          )}
          
          {/* Phone */}
          {contact.phone && (
            <button
              onClick={() => makeCall(contact.phone!)}
              className={cn(textClasses.link, 'text-sm mt-1 flex items-center gap-1')}
            >
              <Telephone className={iconClasses.xs} />
              {formatPhone(contact.phone)}
            </button>
          )}
        </div>
        
        {/* Actions */}
        <div className="flex items-center gap-1">
          {(isTruncated || hasMultipleEmails) && (
            <button
              onClick={() => setIsExpanded(!isExpanded)}
              className="p-1.5 rounded hover:bg-slate-700/50 text-slate-400 hover:text-slate-200 transition-colors"
            >
              {isExpanded ? <ChevronUp className={iconClasses.sm} /> : <ChevronDown className={iconClasses.sm} />}
            </button>
          )}
          {emails.length > 0 && (
            <button
              onClick={() => onCopy(copyText, `contact-${contact.id}`)}
              className="p-1.5 rounded hover:bg-slate-700/50 text-slate-400 hover:text-slate-200 transition-colors"
            >
              {isCopied(`contact-${contact.id}`) ? (
                <ClipboardCheck className={cn(iconClasses.sm, 'text-green-400')} />
              ) : (
                <Clipboard className={iconClasses.sm} />
              )}
            </button>
          )}
        </div>
      </div>
    </Card>
  );
}

// Contact stack for court or crown contacts
interface ContactStackProps {
  contacts: ContactWithRole[];
  category: 'court' | 'crown';
  onCopy: (text: string, id: string) => void;
  isCopied: (id: string) => boolean;
}

export function ContactStack({ contacts, category, onCopy, isCopied }: ContactStackProps) {
  const roleOrder = category === 'court' ? COURT_CONTACT_ROLES : CROWN_CONTACT_ROLES;
  
  // Filter and sort contacts by role order
  const filteredContacts = contacts
    .filter(c => roleOrder.includes(c.role_id as typeof roleOrder[number]))
    .sort((a, b) => {
      const aIndex = roleOrder.indexOf(a.role_id as typeof roleOrder[number]);
      const bIndex = roleOrder.indexOf(b.role_id as typeof roleOrder[number]);
      return aIndex - bIndex;
    });

  if (filteredContacts.length === 0) return null;

  const title = category === 'court' ? 'COURT CONTACTS' : 'CROWN CONTACTS';

  return (
    <div className="space-y-2">
      <h3 
        className={textClasses.sectionHeader}
        style={inlineStyles.sectionHeader}
      >
        {title}
      </h3>
      <div className="space-y-2">
        {filteredContacts.map(contact => (
          <ContactCard
            key={contact.id}
            contact={contact}
            onCopy={onCopy}
            isCopied={isCopied}
          />
        ))}
      </div>
    </div>
  );
}
