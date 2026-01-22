'use client';

import { useState, useCallback, useRef } from 'react';
import { ArrowLeft } from 'react-bootstrap-icons';
import { useSearch, useCourtDetails } from '@/lib/hooks';
import { useCopyToClipboard } from '@/lib/hooks/useCopyToClipboard';
import { APP_NAME } from '@/lib/config/constants';
import { cn } from '@/lib/config/theme';
import type { Court, ViewMode } from '@/types';

export default function Home() {
  // View state
  const [viewMode, setViewMode] = useState<ViewMode>('home');
  const [selectedCourtId, setSelectedCourtId] = useState<number | null>(null);
  const [searchQuery, setSearchQuery] = useState('');
  
  // Hooks
  const { results, isLoading, search, clearSearch, hasResults } = useSearch();
  const { data: courtDetails, isLoading: isLoadingDetails } = useCourtDetails(selectedCourtId);
  const { copiedField, copyToClipboard } = useCopyToClipboard();

  // Handlers
  const handleSelectCourt = useCallback((court: Court) => {
    setSelectedCourtId(court.id);
    setViewMode('detail');
  }, []);

  const handleBack = useCallback(() => {
    if (viewMode === 'detail') {
      setViewMode(hasResults ? 'results' : 'home');
      setSelectedCourtId(null);
    } else if (viewMode === 'results') {
      clearSearch();
      setSearchQuery('');
      setViewMode('home');
    }
  }, [viewMode, hasResults, clearSearch]);

  const handleSearch = useCallback((e: React.ChangeEvent<HTMLInputElement>) => {
    const value = e.target.value;
    setSearchQuery(value);
    search(value);
    if (value.length >= 2) {
      setViewMode('results');
    } else if (value.length === 0) {
      setViewMode('home');
    }
  }, [search]);

  // ============================================================================
  // HOME VIEW
  // ============================================================================
  if (viewMode === 'home') {
    return (
      <div className="min-h-screen flex flex-col items-center justify-center p-4 bg-slate-900">
        <div className="w-full max-w-md space-y-6">
          <h1 className="text-2xl font-bold text-center text-slate-100">
            {APP_NAME}
          </h1>
          <input
            type="text"
            value={searchQuery}
            onChange={handleSearch}
            placeholder="Search courts, contacts, cells..."
            className="w-full px-4 py-3 rounded-lg bg-slate-800 border border-slate-700 text-white placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
          {isLoading && (
            <p className="text-center text-slate-400">Loading...</p>
          )}
        </div>
      </div>
    );
  }

  // ============================================================================
  // RESULTS VIEW
  // ============================================================================
  if (viewMode === 'results') {
    return (
      <div className="min-h-screen bg-slate-900 text-white">
        {/* Header */}
        <div className="sticky top-0 z-10 bg-slate-900/95 backdrop-blur border-b border-slate-800 p-4">
          <div className="flex items-center gap-3">
            <button
              onClick={handleBack}
              className="p-2 rounded-lg hover:bg-slate-800 transition-colors"
            >
              <ArrowLeft className="w-5 h-5" />
            </button>
            <input
              type="text"
              value={searchQuery}
              onChange={handleSearch}
              placeholder="Search..."
              className="flex-1 px-3 py-2 rounded-lg bg-slate-800 border border-slate-700 text-white placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-blue-500 text-sm"
            />
          </div>
        </div>

        {/* Results */}
        <div className="p-4 space-y-4">
          {isLoading && <p className="text-slate-400">Searching...</p>}
          
          {results && results.courts.length > 0 ? (
            <div className="space-y-2">
              <h2 className="text-sm text-slate-400 uppercase tracking-wide">
                Courts ({results.courts.length})
              </h2>
              {results.courts.map((court) => (
                <button
                  key={court.id}
                  onClick={() => handleSelectCourt(court)}
                  className="w-full text-left p-4 rounded-lg bg-slate-800/50 border border-slate-700/50 hover:bg-slate-800 transition-colors"
                >
                  <div className="font-medium">{court.name}</div>
                  <div className="text-sm text-slate-400">
                    {court.region_code} • {court.region_name}
                  </div>
                </button>
              ))}
            </div>
          ) : !isLoading && searchQuery.length >= 2 ? (
            <p className="text-slate-400">No results found</p>
          ) : null}

          {/* Show related data counts */}
          {results && results.courts.length > 0 && (
            <div className="flex gap-2 text-sm text-slate-400">
              <span>{results.contacts.length} contacts</span>
              <span>•</span>
              <span>{results.cells.length} cells</span>
              <span>•</span>
              <span>{results.teamsLinks.length} teams links</span>
            </div>
          )}
        </div>
      </div>
    );
  }

  // ============================================================================
  // DETAIL VIEW
  // ============================================================================
  if (viewMode === 'detail' && courtDetails) {
    const { court, contacts, cells, teamsLinks, bailCourt, bailContacts, bailTeamsLinks } = courtDetails;

    return (
      <div className="min-h-screen bg-slate-900 text-white">
        {/* Header */}
        <div className="sticky top-0 z-10 bg-slate-900/95 backdrop-blur border-b border-slate-800 p-4">
          <div className="flex items-center gap-3">
            <button
              onClick={handleBack}
              className="p-2 rounded-lg hover:bg-slate-800 transition-colors"
            >
              <ArrowLeft className="w-5 h-5" />
            </button>
            <div className="flex-1 min-w-0">
              <h1 className="font-semibold truncate">{court.name}</h1>
              <p className="text-sm text-slate-400">
                {court.region_code} • {court.region_name}
              </p>
            </div>
          </div>
        </div>

        {/* Content */}
        <div className="p-4 space-y-6">
          {/* Court Info */}
          {court.address && (
            <div className="text-sm text-slate-300">{court.address}</div>
          )}
          
          {court.phone && (
            <button
              onClick={() => copyToClipboard(court.phone!, 'court-phone')}
              className="text-blue-400 hover:text-blue-300"
            >
              {court.phone}
            </button>
          )}

          {/* Contacts */}
          {contacts.length > 0 && (
            <section>
              <h2 className="text-sm text-slate-400 uppercase tracking-wide mb-3">
                Contacts ({contacts.length})
              </h2>
              <div className="space-y-2">
                {contacts.map((contact) => (
                  <div
                    key={contact.id}
                    className="p-3 rounded-lg bg-slate-800/50 border border-slate-700/50"
                  >
                    <div className="text-xs text-slate-400 uppercase mb-1">
                      {contact.role_name || 'Contact'}
                    </div>
                    {contact.email && (
                      <button
                        onClick={() => copyToClipboard(contact.email!, `contact-${contact.id}`)}
                        className="text-sm text-blue-400 hover:text-blue-300 break-all"
                      >
                        {contact.email}
                      </button>
                    )}
                  </div>
                ))}
              </div>
            </section>
          )}

          {/* Cells */}
          {cells.length > 0 && (
            <section>
              <h2 className="text-sm text-slate-400 uppercase tracking-wide mb-3">
                Sheriff Cells ({cells.length})
              </h2>
              <div className="space-y-2">
                {cells.map((cell) => (
                  <div
                    key={cell.id}
                    className="p-3 rounded-lg bg-slate-800/50 border border-slate-700/50"
                  >
                    <div className="font-medium text-sm">{cell.name}</div>
                    <div className="text-xs text-slate-400">{cell.cell_type}</div>
                    {cell.phones && cell.phones.length > 0 && (
                      <div className="mt-1">
                        {cell.phones.map((phone, i) => (
                          <button
                            key={i}
                            onClick={() => copyToClipboard(phone, `cell-${cell.id}-${i}`)}
                            className="text-sm text-blue-400 hover:text-blue-300 mr-2"
                          >
                            {phone}
                          </button>
                        ))}
                      </div>
                    )}
                  </div>
                ))}
              </div>
            </section>
          )}

          {/* Teams Links */}
          {teamsLinks.length > 0 && (
            <section>
              <h2 className="text-sm text-slate-400 uppercase tracking-wide mb-3">
                MS Teams ({teamsLinks.length})
              </h2>
              <div className="space-y-2">
                {teamsLinks.map((link) => (
                  <a
                    key={link.id}
                    href={link.teams_link || '#'}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="block p-3 rounded-lg bg-slate-800/50 border border-slate-700/50 hover:bg-slate-800 transition-colors"
                  >
                    <div className="font-medium text-sm">
                      {link.courtroom || link.name || 'Teams Link'}
                    </div>
                    {link.conference_id && (
                      <div className="text-xs text-slate-400">ID: {link.conference_id}</div>
                    )}
                  </a>
                ))}
              </div>
            </section>
          )}

          {/* Bail Info */}
          {bailCourt && (
            <section>
              <h2 className="text-sm text-slate-400 uppercase tracking-wide mb-3">
                Virtual Bail
              </h2>
              <div className="p-3 rounded-lg bg-slate-800/50 border border-slate-700/50">
                <div className="font-medium">{bailCourt.name}</div>
                {bailCourt.triage_time_am && (
                  <div className="text-sm text-slate-300 mt-2">
                    Triage: {bailCourt.triage_time_am} / {bailCourt.triage_time_pm}
                  </div>
                )}
                {bailCourt.court_start_am && (
                  <div className="text-sm text-slate-300">
                    Court: {bailCourt.court_start_am} / {bailCourt.court_start_pm}
                  </div>
                )}
                {bailCourt.cutoff_new_arrests && (
                  <div className="text-sm text-slate-300">
                    Cutoff: {bailCourt.cutoff_new_arrests}
                  </div>
                )}
              </div>
            </section>
          )}
        </div>

        {/* Toast */}
        {copiedField && (
          <div className="fixed bottom-6 left-1/2 -translate-x-1/2 bg-slate-700 text-white px-4 py-2 rounded-lg text-sm shadow-lg">
            Copied to clipboard
          </div>
        )}
      </div>
    );
  }

  // Loading state
  if (isLoadingDetails) {
    return (
      <div className="min-h-screen bg-slate-900 flex items-center justify-center">
        <p className="text-slate-400">Loading...</p>
      </div>
    );
  }

  return null;
}
