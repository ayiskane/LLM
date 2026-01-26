'use client';

import React, { useRef, useCallback, useState, useEffect, useMemo } from 'react';
import { cn } from '@/lib/utils';

const ALPHABET = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ#'.split('');

interface AlphabetNavProps {
  /** Letters that have content sections */
  availableLetters: string[];
  /** Currently visible section letter (from scroll tracking) */
  activeLetter?: string | null;
  /** Callback when user selects a letter */
  onLetterChange: (letter: string) => void;
}

/**
 * AlphabetNav - iOS Contacts-style alphabet index scrubber
 * 
 * Optimal implementation features:
 * - Fixed positioning outside scroll container
 * - Touch scrub with finger-following indicator
 * - Maps touch position to DISPLAYED items (not full alphabet)
 * - Haptic feedback on letter change
 * - Shows dots for gaps between available letters
 * - Handles touchcancel for edge cases
 */
export function AlphabetNav({ availableLetters, activeLetter, onLetterChange }: AlphabetNavProps) {
  const barRef = useRef<HTMLDivElement>(null);
  const [isScrubbing, setIsScrubbing] = useState(false);
  const [scrubLetter, setScrubLetter] = useState<string | null>(null);
  const [indicatorY, setIndicatorY] = useState<number | null>(null);
  const lastLetterRef = useRef<string | null>(null);

  // Build display items: show all available letters, collapse gaps to single dot
  const displayItems = useMemo(() => {
    const items: { type: 'letter' | 'dot'; value: string; letter?: string }[] = [];
    let inGap = false;

    ALPHABET.forEach((letter) => {
      if (availableLetters.includes(letter)) {
        inGap = false;
        items.push({ type: 'letter', value: letter, letter });
      } else if (!inGap) {
        inGap = true;
        items.push({ type: 'dot', value: '•' });
      }
    });

    return items;
  }, [availableLetters]);

  // Get letter at Y position - maps to DISPLAYED items
  const getLetterAtY = useCallback((clientY: number): string | null => {
    const bar = barRef.current;
    if (!bar || displayItems.length === 0) return null;

    const rect = bar.getBoundingClientRect();
    const relativeY = Math.max(0, Math.min(rect.height, clientY - rect.top));
    const ratio = relativeY / rect.height;
    const index = Math.min(displayItems.length - 1, Math.floor(ratio * displayItems.length));
    
    const item = displayItems[index];
    
    // If we hit a letter, return it
    if (item.type === 'letter' && item.letter) {
      return item.letter;
    }
    
    // If we hit a dot, find nearest letter
    // Search outward from current position
    for (let offset = 1; offset < displayItems.length; offset++) {
      // Prefer direction based on position (top half = look up first, bottom half = look down first)
      const preferUp = ratio < 0.5;
      const firstDir = preferUp ? -offset : offset;
      const secondDir = preferUp ? offset : -offset;
      
      const idx1 = index + firstDir;
      const idx2 = index + secondDir;
      
      if (idx1 >= 0 && idx1 < displayItems.length) {
        const item1 = displayItems[idx1];
        if (item1.type === 'letter' && item1.letter) return item1.letter;
      }
      if (idx2 >= 0 && idx2 < displayItems.length) {
        const item2 = displayItems[idx2];
        if (item2.type === 'letter' && item2.letter) return item2.letter;
      }
    }
    
    return availableLetters[0] || null;
  }, [displayItems, availableLetters]);

  // Trigger haptic feedback
  const triggerHaptic = useCallback(() => {
    if (typeof navigator !== 'undefined' && 'vibrate' in navigator) {
      navigator.vibrate(10);
    }
  }, []);

  // Handle scrub
  const handleScrub = useCallback((clientY: number) => {
    const letter = getLetterAtY(clientY);
    setIndicatorY(clientY);
    
    if (letter && letter !== lastLetterRef.current) {
      lastLetterRef.current = letter;
      setScrubLetter(letter);
      onLetterChange(letter);
      triggerHaptic();
    }
  }, [getLetterAtY, onLetterChange, triggerHaptic]);

  // Start scrub
  const startScrub = useCallback((clientY: number) => {
    setIsScrubbing(true);
    lastLetterRef.current = null;
    handleScrub(clientY);
  }, [handleScrub]);

  // End scrub
  const endScrub = useCallback(() => {
    setIsScrubbing(false);
    setScrubLetter(null);
    setIndicatorY(null);
    lastLetterRef.current = null;
  }, []);

  // Touch handlers
  const handleTouchStart = useCallback((e: React.TouchEvent) => {
    e.preventDefault();
    e.stopPropagation();
    startScrub(e.touches[0].clientY);
  }, [startScrub]);

  const handleTouchMove = useCallback((e: React.TouchEvent) => {
    e.preventDefault();
    if (isScrubbing) {
      handleScrub(e.touches[0].clientY);
    }
  }, [isScrubbing, handleScrub]);

  const handleTouchEnd = useCallback((e: React.TouchEvent) => {
    e.preventDefault();
    endScrub();
  }, [endScrub]);

  // Mouse handlers
  const handleMouseDown = useCallback((e: React.MouseEvent) => {
    e.preventDefault();
    startScrub(e.clientY);
  }, [startScrub]);

  useEffect(() => {
    if (!isScrubbing) return;

    const handleMouseMove = (e: MouseEvent) => {
      handleScrub(e.clientY);
    };

    const handleMouseUp = () => {
      endScrub();
    };

    window.addEventListener('mousemove', handleMouseMove);
    window.addEventListener('mouseup', handleMouseUp);
    
    return () => {
      window.removeEventListener('mousemove', handleMouseMove);
      window.removeEventListener('mouseup', handleMouseUp);
    };
  }, [isScrubbing, handleScrub, endScrub]);

  // Determine which letter to highlight (scrub takes priority over active)
  const highlightedLetter = scrubLetter || activeLetter;

  return (
    <>
      {/* Scrub indicator - follows finger position */}
      {isScrubbing && scrubLetter && indicatorY !== null && (
        <div 
          className="fixed right-10 z-[60] pointer-events-none transition-transform duration-75"
          style={{ 
            top: indicatorY,
            transform: 'translateY(-50%)'
          }}
        >
          <div className="w-12 h-12 rounded-xl bg-slate-800/95 border border-slate-600 shadow-xl flex items-center justify-center backdrop-blur-sm">
            <span className="text-xl font-bold text-blue-400">{scrubLetter}</span>
          </div>
        </div>
      )}

      {/* Alphabet bar */}
      <div
        ref={barRef}
        className={cn(
          'fixed right-0 z-50',
          'flex flex-col items-center justify-center',
          'py-2 px-0.5',
          'select-none',
          isScrubbing && 'bg-slate-900/80 rounded-l-lg'
        )}
        style={{
          top: '50%',
          transform: 'translateY(-50%)',
          touchAction: 'none',
          maxHeight: 'calc(100dvh - 12rem)',
        }}
        onTouchStart={handleTouchStart}
        onTouchMove={handleTouchMove}
        onTouchEnd={handleTouchEnd}
        onTouchCancel={handleTouchEnd}
        onMouseDown={handleMouseDown}
        role="navigation"
        aria-label="Alphabet index"
      >
        {displayItems.map((item, idx) => {
          if (item.type === 'dot') {
            return (
              <span
                key={`dot-${idx}`}
                className="text-[6px] text-slate-600 h-1.5 flex items-center justify-center"
                aria-hidden="true"
              >
                •
              </span>
            );
          }

          const isHighlighted = highlightedLetter === item.letter;

          return (
            <span
              key={item.letter}
              className={cn(
                'text-[9px] font-semibold w-4 h-3.5 flex items-center justify-center',
                'transition-all duration-50',
                isHighlighted 
                  ? 'text-blue-400 scale-125 font-bold' 
                  : 'text-slate-500'
              )}
            >
              {item.value}
            </span>
          );
        })}
      </div>
    </>
  );
}
