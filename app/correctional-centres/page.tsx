'use client';

import { useState } from 'react';
import Link from 'next/link';
import { ArrowLeft, Building, ShieldLock } from 'react-bootstrap-icons';
import { 
  PROVINCIAL_CENTRES, 
  FEDERAL_INSTITUTIONS,
  type CorrectionalCentre 
} from '@/lib/constants/correctional-centres';
import { CentreCard, CorrectionsConstantsBanner } from '@/app/components/CentreCard';

type TabType = 'provincial' | 'federal';

// Group centres by region
function groupByRegion(centres: CorrectionalCentre[]): Record<string, CorrectionalCentre[]> {
  return centres.reduce((acc, centre) => {
    const key = `R${centre.regionId} ${centre.regionName}`;
    if (!acc[key]) acc[key] = [];
    acc[key].push(centre);
    return acc;
  }, {} as Record<string, CorrectionalCentre[]>);
}

export default function CorrectionalCentresPage() {
  const [activeTab, setActiveTab] = useState<TabType>('provincial');
  
  const provincialByRegion = groupByRegion(PROVINCIAL_CENTRES);
  const federalByRegion = groupByRegion(FEDERAL_INSTITUTIONS);
  
  const currentGroups = activeTab === 'provincial' ? provincialByRegion : federalByRegion;
  const sortedRegions = Object.keys(currentGroups).sort();

  return (
    <div className="min-h-screen bg-black text-white">
      {/* Header */}
      <div className="sticky top-0 z-10 bg-black/95 backdrop-blur border-b border-zinc-800">
        <div className="max-w-2xl mx-auto px-4 py-3">
          <div className="flex items-center gap-3">
            <Link href="/" className="p-2 -ml-2 hover:bg-zinc-800 rounded-lg transition-colors">
              <ArrowLeft className="w-5 h-5" />
            </Link>
            <h1 className="text-lg font-semibold">Correctional Centres</h1>
          </div>
        </div>
      </div>

      {/* Content */}
      <div className="max-w-2xl mx-auto px-4 py-6">
        {/* Constants Banner */}
        <CorrectionsConstantsBanner />

        {/* Tabs */}
        <div className="flex gap-2 mb-6">
          <button
            onClick={() => setActiveTab('provincial')}
            className={`flex-1 flex items-center justify-center gap-2 py-3 px-4 rounded-xl border transition-colors ${
              activeTab === 'provincial'
                ? 'bg-emerald-500/10 border-emerald-500/30 text-emerald-400'
                : 'bg-zinc-900 border-zinc-800 text-zinc-400 hover:border-zinc-700'
            }`}
          >
            <Building className="w-4 h-4" />
            <span>Provincial ({PROVINCIAL_CENTRES.length})</span>
          </button>
          <button
            onClick={() => setActiveTab('federal')}
            className={`flex-1 flex items-center justify-center gap-2 py-3 px-4 rounded-xl border transition-colors ${
              activeTab === 'federal'
                ? 'bg-purple-500/10 border-purple-500/30 text-purple-400'
                : 'bg-zinc-900 border-zinc-800 text-zinc-400 hover:border-zinc-700'
            }`}
          >
            <ShieldLock className="w-4 h-4" />
            <span>Federal ({FEDERAL_INSTITUTIONS.length})</span>
          </button>
        </div>

        {/* Centres by Region */}
        <div className="space-y-6">
          {sortedRegions.map(region => (
            <div key={region}>
              <h2 className="text-sm font-medium text-zinc-500 mb-3 px-1">{region}</h2>
              <div className="space-y-2">
                {currentGroups[region].map(centre => (
                  <CentreCard key={centre.id} centre={centre} />
                ))}
              </div>
            </div>
          ))}
        </div>

        {/* Quick Links */}
        <div className="mt-8 pt-6 border-t border-zinc-800">
          <h2 className="text-sm font-medium text-zinc-500 mb-3">Related</h2>
          <div className="flex gap-2">
            <Link
              href="/programs"
              className="flex-1 p-3 bg-zinc-900 border border-zinc-800 rounded-xl hover:border-zinc-700 transition-colors text-center"
            >
              <span className="text-sm text-zinc-400">Recovery Programs</span>
            </Link>
          </div>
        </div>
      </div>
    </div>
  );
}
