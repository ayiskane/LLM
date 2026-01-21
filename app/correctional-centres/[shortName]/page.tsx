'use client';

import { use } from 'react';
import { notFound } from 'next/navigation';
import { HddFill, UsbDrive, Disc, XCircle, CheckCircle } from 'react-bootstrap-icons';
import { useState, useCallback } from 'react';
import copy from 'copy-to-clipboard';

import { 
  ALL_CORRECTIONAL_CENTRES,
  CENTRE_TYPE_LABELS,
  SECURITY_LEVEL_LABELS,
} from '@/lib/constants/correctional-centres';

// Shared UI Components
import {
  PageLayout,
  StickyHeader,
  Section,
  EntryRow,
  InfoRow,
  Tag,
  Toast,
  BackButton,
  PageLabel,
} from '@/app/components/ui';
import { theme } from '@/lib/theme';

interface PageProps {
  params: Promise<{ shortName: string }>;
}

type SectionKey = 'contact' | 'visits' | 'callback' | 'disclosure' | 'support';

export default function CentreDetailPage({ params }: PageProps) {
  const { shortName } = use(params);
  const [copiedField, setCopiedField] = useState<string | null>(null);
  const [expandedSection, setExpandedSection] = useState<SectionKey | null>('contact');

  const centre = ALL_CORRECTIONAL_CENTRES.find(
    c => c.shortName.toLowerCase() === shortName.toLowerCase()
  );

  if (!centre) {
    notFound();
  }

  const handleCopy = useCallback((text: string, field: string) => {
    copy(text);
    setCopiedField(field);
    setTimeout(() => setCopiedField(null), 2000);
  }, []);

  const toggleSection = useCallback((section: SectionKey) => {
    setExpandedSection(prev => prev === section ? null : section);
  }, []);

  const typeLabel = CENTRE_TYPE_LABELS[centre.centreType] || centre.centreType;

  return (
    <PageLayout>
      {/* Header */}
      <StickyHeader>
        <div className="max-w-2xl mx-auto px-4 py-3">
          <div className="flex items-center justify-between mb-2">
            <BackButton href="/correctional-centres" />
            <PageLabel>CENTRE_DETAIL</PageLabel>
          </div>
          
          <h1 className="text-lg font-semibold text-white">{centre.name.toUpperCase()}</h1>
          <p className="text-xs text-zinc-500 mt-1">
            {centre.location} · R{centre.regionId} {centre.regionName}
          </p>
          
          <div className="flex flex-wrap gap-1.5 mt-2">
            <Tag color={centre.isFederal ? 'purple' : 'emerald'}>
              {centre.isFederal ? 'FEDERAL' : 'PROVINCIAL'}
            </Tag>
            <Tag color="blue">{typeLabel.toUpperCase()}</Tag>
            {centre.securityLevel && (
              <Tag color="amber">{SECURITY_LEVEL_LABELS[centre.securityLevel].toUpperCase()}</Tag>
            )}
          </div>
        </div>
      </StickyHeader>

      {/* Content */}
      <div className="max-w-2xl mx-auto px-4 py-4 space-y-2.5">
        
        {/* Contact Section */}
        {(centre.generalPhone || centre.generalFax || centre.cdnFax) && (
          <Section
            color="emerald"
            title="Contact"
            isExpanded={expandedSection === 'contact'}
            onToggle={() => toggleSection('contact')}
          >
            {centre.generalPhone && (
              <EntryRow 
                label="General Phone" 
                value={centre.generalPhone}
                subtext={centre.generalPhoneOption}
                copyField="phone"
                copiedField={copiedField}
                onCopy={handleCopy}
              />
            )}
            {centre.generalFax && (
              <EntryRow 
                label="Fax" 
                value={centre.generalFax}
                copyField="fax"
                copiedField={copiedField}
                onCopy={handleCopy}
              />
            )}
            {centre.cdnFax && (
              <EntryRow 
                label="CDN Fax" 
                value={centre.cdnFax}
                copyField="cdnFax"
                copiedField={copiedField}
                onCopy={handleCopy}
              />
            )}
          </Section>
        )}

        {/* Visits Section */}
        {(centre.visitRequestPhone || centre.visitRequestEmail || centre.visitHoursInperson) && (
          <Section
            color="blue"
            title="Visits"
            isExpanded={expandedSection === 'visits'}
            onToggle={() => toggleSection('visits')}
          >
            {centre.visitRequestPhone && (
              <EntryRow 
                label="Book Visit" 
                value={centre.visitRequestPhone}
                copyField="visitPhone"
                copiedField={copiedField}
                onCopy={handleCopy}
              />
            )}
            {centre.visitRequestEmail && (
              <EntryRow 
                label="Visit Email" 
                value={centre.visitRequestEmail}
                copyField="visitEmail"
                copiedField={copiedField}
                onCopy={handleCopy}
              />
            )}
            {centre.virtualVisitEmail && centre.virtualVisitEmail !== centre.visitRequestEmail && (
              <EntryRow 
                label="Virtual Visit Email" 
                value={centre.virtualVisitEmail}
                copyField="virtualEmail"
                copiedField={copiedField}
                onCopy={handleCopy}
              />
            )}
            {centre.visitHoursInperson && (
              <InfoRow label="In-Person Hours" value={centre.visitHoursInperson} />
            )}
            {centre.visitHoursVirtual && (
              <InfoRow label="Virtual Hours" value={centre.visitHoursVirtual} />
            )}
            {centre.visitNotes && (
              <div className="px-3 py-2">
                <p className="text-[11px] text-zinc-500">{centre.visitNotes}</p>
              </div>
            )}
          </Section>
        )}

        {/* Callback Windows Section */}
        {(centre.callback1Start || centre.lawyerCallbackEmail) && (
          <Section
            color="amber"
            title="Callback Windows"
            isExpanded={expandedSection === 'callback'}
            onToggle={() => toggleSection('callback')}
          >
            {centre.callback1Start && centre.callback1End && (
              <InfoRow label="Window 1" value={`${centre.callback1Start} - ${centre.callback1End}`} />
            )}
            {centre.callback2Start && centre.callback2End && (
              <InfoRow label="Window 2" value={`${centre.callback2Start} - ${centre.callback2End}`} />
            )}
            {centre.lawyerCallbackEmail && (
              <EntryRow 
                label="Callback Email" 
                value={centre.lawyerCallbackEmail}
                copyField="callbackEmail"
                copiedField={copiedField}
                onCopy={handleCopy}
              />
            )}
          </Section>
        )}

        {/* eDisclosure Section */}
        <Section
          color="cyan"
          title="eDisclosure"
          isExpanded={expandedSection === 'disclosure'}
          onToggle={() => toggleSection('disclosure')}
        >
          <div className="p-3">
            <div className="grid grid-cols-3 gap-2 mb-3">
              <DisclosureItem 
                icon={<HddFill className="w-5 h-5" />} 
                label="HDD" 
                accepted={centre.acceptsHardDrive} 
              />
              <DisclosureItem 
                icon={<Disc className="w-5 h-5" />} 
                label="CD/DVD" 
                accepted={centre.acceptsCdDvd} 
              />
              <DisclosureItem 
                icon={<UsbDrive className="w-5 h-5" />} 
                label="USB" 
                accepted={centre.acceptsUsb} 
              />
            </div>
            {centre.disclosureFormat && (
              <p className="text-[11px] text-amber-400 mb-2">Preferred: {centre.disclosureFormat}</p>
            )}
            {centre.disclosureNotes && (
              <p className="text-[11px] text-zinc-500">{centre.disclosureNotes}</p>
            )}
          </div>
        </Section>

        {/* Support Section */}
        {centre.ciwOrganization && (
          <Section
            color="purple"
            title="Support"
            isExpanded={expandedSection === 'support'}
            onToggle={() => toggleSection('support')}
          >
            <InfoRow label="Community Integration Worker" value={centre.ciwOrganization} />
            <div className="px-3 py-2">
              <p className="text-[10px] text-zinc-600">Additional support contacts available in database</p>
            </div>
          </Section>
        )}

        {/* Notes */}
        {centre.notes && (
          <div 
            className="rounded-lg p-3"
            style={{ background: theme.colors.bg.subtle, border: `1px solid ${theme.colors.border.subtle}` }}
          >
            <p className="text-[12px] text-zinc-400">{centre.notes}</p>
          </div>
        )}
      </div>

      <Toast show={!!copiedField} />
    </PageLayout>
  );
}

// Small helper component for disclosure items
function DisclosureItem({ icon, label, accepted }: { icon: React.ReactNode; label: string; accepted: boolean }) {
  return (
    <div 
      className="flex flex-col items-center gap-1.5 p-3 rounded-lg"
      style={{ background: theme.colors.bg.item }}
    >
      <div className={accepted ? 'text-emerald-400' : 'text-zinc-600'}>{icon}</div>
      <span className="text-[9px] font-mono text-zinc-500 uppercase">{label}</span>
      {accepted ? (
        <CheckCircle className="w-4 h-4 text-emerald-400" />
      ) : (
        <XCircle className="w-4 h-4 text-red-400" />
      )}
    </div>
  );
}
