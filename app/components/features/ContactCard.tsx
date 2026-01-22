'use client';

import { useState, useCallback, useMemo } from 'react';
import { Clipboard, ClipboardCheck, Eye, EyeSlash } from 'react-bootstrap-icons';
import { 
  cn, 
  textClasses, 
  iconClasses, 
  cardClasses,
  couponCardStyles,
  getRoleLabelProps,
  getContactCategoryColor,
  getToggleButtonStyles,
  getSectionHeaderProps,
} from '@/lib/config/theme';
import type { ContactCategory } from '@/lib/config/theme';
import { formatEmailsForCopy } from '@/lib/utils';
import { CONTACT_ROLES } from '@/lib/config/constants';
import type { ContactWithRole, BailContact } from '@/types';

// ============================================================================
// COPY FUNCTION TYPES
// ============================================================================

type CopyFunction = (text: string, fieldId: string) => void | Promise<boolean>;
type IsCopiedFunction = (fieldId: string) => boolean;

// ============================================================================
// CONTACT ITEM (Single coupon-style card)
// ============================================================================

interface ContactItemProps {
  label: string;
  emails: string[];
  category?: ContactCategory;
  showFull: boolean;
  onCopy?: CopyFunction;
  isCopied?: IsCopiedFunction;
  fieldId: string;
}

function ContactItem({ 
  label, 
  emails, 
  category = 'other', 
  showFull,
  onCopy,
  isCopied,
  fieldId,
}: ContactItemProps) {
  const copyText = emails.join(', ');
  const isFieldCopied = isCopied ? isCopied(fieldId) : false;
  const roleLabelProps = getRoleLabelProps();

  const handleCopy = useCallback(() => {
    if (copyText && onCopy) {
      onCopy(copyText, fieldId);
    }
  }, [copyText, onCopy, fieldId]);

  return (
    <div 
      className={cardClasses.coupon}
      style={couponCardStyles.container}
      onClick={handleCopy}
    >
      {/* Color accent bar */}
      <div 
        className="w-1 shrink-0"
        style={{ background: getContactCategoryColor(category) }}
      />
      
      {/* Content */}
      <div className="flex-1 py-2.5 px-3 min-w-0 overflow-hidden">
        <div 
          className={roleLabelProps.className}
          style={roleLabelProps.style}
        >
          {label}
        </div>
        <div 
          data-email="true"
          className={cn(
            'text-[12px] text-slate-200 font-mono leading-relaxed',
            showFull ? 'break-all whitespace-normal' : 'whitespace-nowrap overflow-hidden text-ellipsis'
          )}
        >
          {emails.length > 1 ? (
            <div className={showFull ? 'space-y-1' : ''}>
              {showFull ? (
                emails.map((email, i) => (
                  <div key={i}>{email}</div>
                ))
              ) : (
                emails.join(', ')
              )}
            </div>
          ) : (
            emails[0]
          )}
        </div>
      </div>
      
      {/* Copy button area */}
      <div 
        className="flex items-center justify-center px-3 shrink-0 transition-colors"
        style={{ 
          ...couponCardStyles.divider,
          color: isFieldCopied ? '#34d399' : '#52525b',
        }}
      >
        {isFieldCopied ? (
          <ClipboardCheck className={cn(iconClasses.md, 'text-emerald-400')} />
        ) : (
          <Clipboard className={iconClasses.md} />
        )}
      </div>
    </div>
  );
}

// ============================================================================
// SECTION HEADER WITH TOGGLE
// ============================================================================

function SectionHeader({ 
  title, 
  showFull, 
  onToggle,
  showToggle
}: { 
  title: string; 
  showFull: boolean; 
  onToggle: () => void;
  showToggle: boolean;
}) {
  const headerProps = getSectionHeaderProps();
  
  return (
    <div className="flex items-center justify-between mb-2 px-1">
      <h4 {...headerProps}>
        {title}
      </h4>
      {showToggle && (
        <button
          onClick={(e) => { e.stopPropagation(); onToggle(); }}
          className="flex items-center gap-1.5 px-2 py-1 rounded text-xs tracking-wide transition-all"
          style={getToggleButtonStyles(showFull)}
        >
          {showFull ? (
            <EyeSlash className={iconClasses.xs} />
          ) : (
            <Eye className={iconClasses.xs} />
          )}
          <span>{showFull ? 'Truncate' : 'Show full'}</span>
        </button>
      )}
    </div>
  );
}

// ============================================================================
// COURT CONTACTS STACK
// ============================================================================

interface CourtContactsStackProps {
  contacts: ContactWithRole[];
  onCopy?: CopyFunction;
  isCopied?: IsCopiedFunction;
}

export function CourtContactsStack({ contacts, onCopy, isCopied }: CourtContactsStackProps) {
  const [showFull, setShowFull] = useState(false);

  const contactConfig: { roleId: number; category: ContactCategory; label: string }[] = [
    { roleId: CONTACT_ROLES.CRIMINAL_REGISTRY, category: 'court', label: 'Criminal Registry' },
    { roleId: CONTACT_ROLES.COURT_REGISTRY, category: 'court', label: 'Court Registry' },
    { roleId: CONTACT_ROLES.JCM, category: 'provincial', label: 'Provincial JCM' },
    { roleId: CONTACT_ROLES.BAIL_JCM, category: 'bail', label: 'Bail JCM' },
    { roleId: CONTACT_ROLES.SCHEDULING, category: 'supreme', label: 'Supreme Scheduling' },
    { roleId: CONTACT_ROLES.INTERPRETER, category: 'other', label: 'Interpreter Request' },
  ];

  const orderedContacts = useMemo(() => {
    const result: { label: string; emails: string[]; category: ContactCategory; id: number }[] = [];
    
    let criminalRegistryEmails: string[] = [];
    const criminalRegistry = contacts.find(c => c.contact_role_id === CONTACT_ROLES.CRIMINAL_REGISTRY);
    if (criminalRegistry) {
      criminalRegistryEmails = criminalRegistry.emails || (criminalRegistry.email ? [criminalRegistry.email] : []);
    }

    contactConfig.forEach(config => {
      const contact = contacts.find(c => c.contact_role_id === config.roleId);
      if (contact) {
        const contactEmails = contact.emails && contact.emails.length > 0 
          ? contact.emails 
          : (contact.email ? [contact.email] : []);
        
        if (contactEmails.length > 0) {
          if (config.roleId === CONTACT_ROLES.COURT_REGISTRY && 
              criminalRegistryEmails.length > 0 && 
              contactEmails[0] === criminalRegistryEmails[0]) {
            return;
          }
          result.push({
            label: config.label,
            emails: contactEmails,
            category: config.category,
            id: contact.id,
          });
        }
      }
    });

    return result;
  }, [contacts]);

  const hasTruncation = orderedContacts.some(c => c.emails.join(', ').length > 40);

  if (orderedContacts.length === 0) return null;

  return (
    <div className="space-y-1.5">
      <SectionHeader 
        title="Court Contacts" 
        showFull={showFull} 
        onToggle={() => setShowFull(!showFull)}
        showToggle={hasTruncation || showFull}
      />
      <div className="space-y-2">
        {orderedContacts.map((contact) => (
          <ContactItem 
            key={contact.id}
            label={contact.label}
            emails={contact.emails}
            category={contact.category}
            showFull={showFull}
            onCopy={onCopy}
            isCopied={isCopied}
            fieldId={`court-contact-${contact.id}`}
          />
        ))}
      </div>
    </div>
  );
}

// ============================================================================
// CROWN CONTACTS STACK
// ============================================================================

interface CrownContactsStackProps {
  contacts: ContactWithRole[];
  bailContacts?: BailContact[];
  onCopy?: CopyFunction;
  isCopied?: IsCopiedFunction;
}

export function CrownContactsStack({ contacts, bailContacts, onCopy, isCopied }: CrownContactsStackProps) {
  const [showFull, setShowFull] = useState(false);

  const crownContacts = useMemo(() => {
    const result: { label: string; emails: string[]; category: ContactCategory; id: string }[] = [];

    const provCrown = contacts.find(c => c.contact_role_id === CONTACT_ROLES.CROWN);
    if (provCrown) {
      const emails = provCrown.emails && provCrown.emails.length > 0 
        ? provCrown.emails 
        : (provCrown.email ? [provCrown.email] : []);
      if (emails.length > 0) {
        result.push({ label: 'Provincial Crown', emails, category: 'provincial', id: `prov-crown-${provCrown.id}` });
      }
    }

    if (bailContacts) {
      const bailCrown = bailContacts.find(bc => bc.role_id === CONTACT_ROLES.CROWN);
      if (bailCrown?.email) {
        result.push({ label: 'Bail Crown', emails: [bailCrown.email], category: 'bail', id: `bail-crown-${bailCrown.id}` });
      }
    }

    const fedCrown = contacts.find(c => c.contact_role_id === CONTACT_ROLES.FEDERAL_CROWN);
    if (fedCrown) {
      const emails = fedCrown.emails && fedCrown.emails.length > 0 
        ? fedCrown.emails 
        : (fedCrown.email ? [fedCrown.email] : []);
      if (emails.length > 0) {
        result.push({ label: 'Federal Crown', emails, category: 'other', id: `fed-crown-${fedCrown.id}` });
      }
    }

    const fnCrown = contacts.find(c => c.contact_role_id === CONTACT_ROLES.FIRST_NATIONS_CROWN);
    if (fnCrown) {
      const emails = fnCrown.emails && fnCrown.emails.length > 0 
        ? fnCrown.emails 
        : (fnCrown.email ? [fnCrown.email] : []);
      if (emails.length > 0) {
        result.push({ label: 'First Nations Crown', emails, category: 'other', id: `fn-crown-${fnCrown.id}` });
      }
    }

    return result;
  }, [contacts, bailContacts]);

  const hasTruncation = crownContacts.some(c => c.emails.join(', ').length > 40);

  if (crownContacts.length === 0) return null;

  return (
    <div className="space-y-1.5">
      <SectionHeader 
        title="Crown Contacts" 
        showFull={showFull} 
        onToggle={() => setShowFull(!showFull)}
        showToggle={hasTruncation || showFull}
      />
      <div className="space-y-2">
        {crownContacts.map((contact) => (
          <ContactItem 
            key={contact.id}
            label={contact.label}
            emails={contact.emails}
            category={contact.category}
            showFull={showFull}
            onCopy={onCopy}
            isCopied={isCopied}
            fieldId={contact.id}
          />
        ))}
      </div>
    </div>
  );
}

export { ContactItem as ContactCard };
