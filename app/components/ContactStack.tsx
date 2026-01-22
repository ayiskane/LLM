'use client';

import { useState, useCallback, useRef, useEffect, useMemo } from 'react';
import { Check, Clipboard, Eye, EyeSlash } from 'react-bootstrap-icons';
import copy from 'copy-to-clipboard';
import type { Contact, BailContact } from '@/types';
import { CONTACT_ROLE_NAMES, CONTACT_ROLES } from '@/types';
import { theme } from '@/lib/theme';

// Category colors for accent bar
type ContactCategory = 'court' | 'provincial' | 'supreme' | 'bail' | 'other';

const categoryColors: Record<ContactCategory, string> = {
  court: '#60a5fa',      // blue
  provincial: '#34d399', // emerald
  supreme: '#a78bfa',    // purple
  bail: '#fbbf24',       // amber
  other: '#71717a',      // zinc
};

// Hook to detect if any text is truncated
function useTruncationDetection(emails: string[], showFull: boolean) {
  const containerRef = useRef<HTMLDivElement>(null);
  const [hasTruncation, setHasTruncation] = useState(false);

  const checkTruncation = useCallback(() => {
    // Don't check if showing full - no truncation possible
    if (showFull) {
      setHasTruncation(false);
      return;
    }

    const container = containerRef.current;
    if (!container) return;

    // Find all email elements within this container
    const emailElements = container.querySelectorAll('[data-email]');
    let anyTruncated = false;

    emailElements.forEach((el) => {
      const htmlEl = el as HTMLElement;
      // Check if content is wider than visible area (no tolerance - exact check)
      if (htmlEl.scrollWidth > htmlEl.clientWidth) {
        anyTruncated = true;
      }
    });

    setHasTruncation(anyTruncated);
  }, [showFull]);

  useEffect(() => {
    // Don't check if showing full
    if (showFull) {
      setHasTruncation(false);
      return;
    }

    // Check after fonts are loaded
    const checkAfterFonts = async () => {
      // Wait for fonts to be ready
      if (document.fonts && document.fonts.ready) {
        await document.fonts.ready;
      }
      checkTruncation();
    };

    // Initial check with multiple timing strategies
    checkAfterFonts();
    
    // Also check after a short delay (fallback for any timing issues)
    const timeoutId = setTimeout(checkTruncation, 100);
    
    // And after a longer delay for slow font loading
    const timeoutId2 = setTimeout(checkTruncation, 500);

    // Use ResizeObserver for resize detection
    const resizeObserver = new ResizeObserver(() => {
      checkTruncation();
    });

    if (containerRef.current) {
      resizeObserver.observe(containerRef.current);
    }

    return () => {
      clearTimeout(timeoutId);
      clearTimeout(timeoutId2);
      resizeObserver.disconnect();
    };
  }, [checkTruncation, showFull, emails.join(',')]);

  return { containerRef, hasTruncation };
}

// Section header with eye toggle (only shows if truncation detected)
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
  return (
    <div className="flex items-center justify-between mb-2 px-1">
      <h4 
        className="text-[10px] text-slate-400 uppercase tracking-wider"
        style={{ fontFamily: 'Inter, sans-serif' }}
      >
        {title}
      </h4>
      {showToggle && (
        <button
          onClick={onToggle}
          className="flex items-center gap-1.5 px-2 py-1 rounded text-[9px] uppercase tracking-wide transition-all"
          style={{ 
            fontFamily: 'Inter, sans-serif',
            background: showFull ? 'rgba(59,130,246,0.15)' : 'transparent',
            border: `1px solid ${showFull ? 'rgba(59,130,246,0.4)' : theme.colors.border.primary}`,
            color: showFull ? '#60a5fa' : theme.colors.text.disabled,
          }}
        >
          {showFull ? (
            <EyeSlash className="w-3 h-3" />
          ) : (
            <Eye className="w-3 h-3" />
          )}
          <span>{showFull ? 'Truncate' : 'Show full'}</span>
        </button>
      )}
    </div>
  );
}

// Single contact item with coupon style
function ContactItem({ 
  label, 
  email, 
  category = 'other', 
  showFull,
  onCopy,
}: { 
  label: string; 
  email: string; 
  category?: ContactCategory;
  showFull: boolean;
  onCopy: () => void;
}) {
  const [copied, setCopied] = useState(false);

  const handleCopy = useCallback(() => {
    copy(email);
    setCopied(true);
    onCopy();
    setTimeout(() => setCopied(false), 2000);
  }, [email, onCopy]);

  return (
    <div 
      className="flex items-stretch rounded-lg overflow-hidden cursor-pointer transition-all hover:border-blue-500/40"
      style={{ 
        background: 'rgba(59,130,246,0.03)',
        border: '1px dashed rgba(59,130,246,0.25)',
      }}
      onClick={handleCopy}
    >
      {/* Color accent bar */}
      <div 
        className="w-1 flex-shrink-0"
        style={{ background: categoryColors[category] }}
      />
      
      {/* Content */}
      <div className="flex-1 py-2.5 px-3 min-w-0 overflow-hidden">
        <div 
          className="text-[9px] text-slate-400 uppercase tracking-wide mb-1"
          style={{ fontFamily: 'Inter, sans-serif' }}
        >
          {label}
        </div>
        <div 
          data-email="true"
          className={`text-[12px] text-slate-200 font-mono leading-relaxed ${
            showFull ? 'break-all whitespace-normal' : 'whitespace-nowrap overflow-hidden text-ellipsis'
          }`}
        >
          {email}
        </div>
      </div>
      
      {/* Copy button area */}
      <div 
        className="flex items-center justify-center px-3 flex-shrink-0 transition-colors"
        style={{ 
          borderLeft: '1px dashed rgba(59,130,246,0.25)',
          color: copied ? '#34d399' : '#52525b',
        }}
      >
        {copied ? (
          <Check className="w-4 h-4" />
        ) : (
          <Clipboard className="w-4 h-4" />
        )}
      </div>
    </div>
  );
}

// Court contacts (Registry, JCM, SC Scheduling, Bail JCM)
export function CourtContactsStack({ contacts, onCopy }: { contacts: Contact[]; onCopy?: () => void }) {
  const [showFull, setShowFull] = useState(false);

  // Define contact order and categories
  const contactConfig: { roleId: number; category: ContactCategory; label: string }[] = [
    { roleId: CONTACT_ROLES.COURT_REGISTRY, category: 'court', label: 'Court Registry' },
    { roleId: CONTACT_ROLES.CRIMINAL_REGISTRY, category: 'court', label: 'Criminal Registry' },
    { roleId: CONTACT_ROLES.JCM, category: 'provincial', label: 'Provincial JCM' },
    { roleId: CONTACT_ROLES.BAIL_JCM, category: 'bail', label: 'Bail JCM' },
    { roleId: CONTACT_ROLES.SCHEDULING, category: 'supreme', label: 'Supreme Scheduling' },
    { roleId: CONTACT_ROLES.INTERPRETER, category: 'other', label: 'Interpreter' },
  ];

  // Build ordered contact list with useMemo for stable reference
  const orderedContacts = useMemo(() => {
    const result: { label: string; email: string; category: ContactCategory }[] = [];
    
    // Track criminal registry to skip duplicate court registry
    let criminalRegistryEmail: string | null = null;
    const criminalRegistry = contacts.find(c => c.contact_role_id === CONTACT_ROLES.CRIMINAL_REGISTRY);
    if (criminalRegistry) {
      criminalRegistryEmail = criminalRegistry.email || (criminalRegistry.emails && criminalRegistry.emails[0]) || null;
    }

    contactConfig.forEach(config => {
      const contact = contacts.find(c => c.contact_role_id === config.roleId);
      if (contact) {
        const email = contact.email || (contact.emails && contact.emails[0]);
        if (email) {
          // Skip court registry if same as criminal registry
          if (config.roleId === CONTACT_ROLES.COURT_REGISTRY && criminalRegistryEmail && email === criminalRegistryEmail) {
            return;
          }
          result.push({
            label: config.label,
            email,
            category: config.category,
          });
        }
      }
    });

    return result;
  }, [contacts]);

  // Extract just emails for truncation check dependency
  const emails = useMemo(() => orderedContacts.map(c => c.email), [orderedContacts]);

  // Truncation detection
  const { containerRef, hasTruncation } = useTruncationDetection(emails, showFull);

  if (orderedContacts.length === 0) return null;

  return (
    <div className="space-y-1.5">
      <SectionHeader 
        title="Court Contacts" 
        showFull={showFull} 
        onToggle={() => setShowFull(!showFull)}
        showToggle={hasTruncation || showFull}
      />
      <div ref={containerRef} className="space-y-2">
        {orderedContacts.map((contact) => (
          <ContactItem 
            key={contact.label} 
            label={contact.label} 
            email={contact.email}
            category={contact.category}
            showFull={showFull}
            onCopy={onCopy || (() => {})}
          />
        ))}
      </div>
    </div>
  );
}

// Crown contacts (Provincial, Bail, Federal)
export function CrownContactsStack({ 
  contacts, 
  bailContacts,
  onCopy 
}: { 
  contacts: Contact[]; 
  bailContacts?: BailContact[];
  onCopy?: () => void;
}) {
  const [showFull, setShowFull] = useState(false);

  // Build crown contacts list with useMemo for stable reference
  const crownContacts = useMemo(() => {
    const result: { label: string; email: string; category: ContactCategory }[] = [];

    // Provincial Crown
    const provCrown = contacts.find(c => c.contact_role_id === CONTACT_ROLES.CROWN);
    if (provCrown?.email) {
      result.push({
        label: 'Provincial Crown',
        email: provCrown.email,
        category: 'provincial'
      });
    }

    // Bail Crown (from bail contacts)
    if (bailContacts) {
      const bailCrown = bailContacts.find(bc => bc.role_id === CONTACT_ROLES.CROWN || bc.role_name === 'Crown');
      if (bailCrown?.email) {
        result.push({
          label: 'Bail Crown',
          email: bailCrown.email,
          category: 'bail'
        });
      }
    }

    // Federal Crown
    const fedCrown = contacts.find(c => c.contact_role_id === CONTACT_ROLES.FEDERAL_CROWN);
    if (fedCrown?.email) {
      result.push({
        label: 'Federal Crown',
        email: fedCrown.email,
        category: 'other'
      });
    }

    // First Nations Crown
    const fnCrown = contacts.find(c => c.contact_role_id === CONTACT_ROLES.FIRST_NATIONS_CROWN);
    if (fnCrown?.email) {
      result.push({
        label: 'First Nations Crown',
        email: fnCrown.email,
        category: 'other'
      });
    }

    return result;
  }, [contacts, bailContacts]);

  // Extract just emails for truncation check dependency
  const emails = useMemo(() => crownContacts.map(c => c.email), [crownContacts]);

  // Truncation detection
  const { containerRef, hasTruncation } = useTruncationDetection(emails, showFull);

  if (crownContacts.length === 0) return null;

  return (
    <div className="space-y-1.5">
      <SectionHeader 
        title="Crown Contacts" 
        showFull={showFull} 
        onToggle={() => setShowFull(!showFull)}
        showToggle={hasTruncation || showFull}
      />
      <div ref={containerRef} className="space-y-2">
        {crownContacts.map((contact) => (
          <ContactItem 
            key={contact.label}
            label={contact.label}
            email={contact.email}
            category={contact.category}
            showFull={showFull}
            onCopy={onCopy || (() => {})}
          />
        ))}
      </div>
    </div>
  );
}

// Top contacts for search results preview (no eye toggle, always truncated)
export function TopContactsPreview({ 
  contacts, 
  onCopy,
  showAll = false
}: { 
  contacts: Contact[]; 
  onCopy?: () => void;
  showAll?: boolean;
}) {
  // Map role IDs to categories
  const roleToCategory: Record<number, ContactCategory> = {
    [CONTACT_ROLES.COURT_REGISTRY]: 'court',
    [CONTACT_ROLES.CRIMINAL_REGISTRY]: 'court',
    [CONTACT_ROLES.JCM]: 'provincial',
    [CONTACT_ROLES.BAIL_JCM]: 'bail',
    [CONTACT_ROLES.SCHEDULING]: 'supreme',
    [CONTACT_ROLES.CROWN]: 'provincial',
    [CONTACT_ROLES.BAIL_CROWN]: 'bail',
    [CONTACT_ROLES.FEDERAL_CROWN]: 'other',
    [CONTACT_ROLES.INTERPRETER]: 'other',
  };

  if (showAll) {
    const allContacts = contacts
      .filter(c => c.email)
      .map(c => ({
        label: CONTACT_ROLE_NAMES[c.contact_role_id] || 'Unknown',
        email: c.email!,
        category: roleToCategory[c.contact_role_id] || 'other' as ContactCategory
      }));

    if (allContacts.length === 0) return null;

    return (
      <div className="space-y-2">
        {allContacts.map((contact, idx) => (
          <ContactItem 
            key={`${contact.label}-${idx}`}
            label={contact.label}
            email={contact.email}
            category={contact.category}
            showFull={false}
            onCopy={onCopy || (() => {})}
          />
        ))}
      </div>
    );
  }

  // Priority: Criminal Registry, JCM, Provincial Crown
  const priorityRoles: number[] = [
    CONTACT_ROLES.CRIMINAL_REGISTRY,
    CONTACT_ROLES.JCM,
    CONTACT_ROLES.CROWN
  ];

  const topContacts = priorityRoles
    .map(roleId => {
      const contact = contacts.find(c => c.contact_role_id === roleId);
      if (contact?.email) {
        return {
          label: CONTACT_ROLE_NAMES[roleId] || 'Unknown',
          email: contact.email,
          category: roleToCategory[roleId] || 'other' as ContactCategory
        };
      }
      return null;
    })
    .filter((c): c is { label: string; email: string; category: ContactCategory } => c !== null)
    .slice(0, 3);

  if (topContacts.length === 0) return null;

  return (
    <div className="space-y-2">
      {topContacts.map((contact) => (
        <ContactItem 
          key={contact.label}
          label={contact.label}
          email={contact.email}
          category={contact.category}
          showFull={false}
          onCopy={onCopy || (() => {})}
        />
      ))}
    </div>
  );
}
