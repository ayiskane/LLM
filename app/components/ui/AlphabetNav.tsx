'use client';

import React, { useRef, useState, useCallback, useMemo } from 'react';
import { cn } from '@/lib/utils';

const ALL_LETTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ#'.split('');

interface AlphabetNavProps {
  letters: string[];
  activeLetter: string | null;
  onSelect: (letter: string) => void;
}

/**
 * AlphabetNav - iOS-style section index for fast scrolling
 * 
 * OPTIMAL POSITIONING PATTERN:
 * This component should be placed as a sibling to the scrollable list,
 * both inside a relative container. Uses absolute positioning with
 * top/bottom constraints for natural vertical centering.
 * 
 * Usage:
 * <div className="relative flex-1">
 *   <ScrollableList />
 *   <AlphabetNav letters={[...]} onSelect={...} />
 * </div>
 */
export function AlphabetNav({ letters, activeLetter, onSelect }: AlphabetNavProps) {
  const navRef = useRef<HTMLDivElement>(null);
  const [isDragging, setIsDragging] = useState(false);
  const [scrubLetter, setScrubLetter] = useState<string | null>(null);

  // Build display items: available letters + dots for gaps
  const displayItems = useMemo(() => {
    const items: { type: 'letter' | 'dot'; letter: string }[] = [];
    let inGap = false;
    for (const letter of ALL_LETTERS) {
      if (letters.includes(letter)) {
        items.push({ type: 'letter', letter });
        inGap = false;
      } else if (!inGap) {
        items.push({ type: 'dot', letter });
        inGap = true;
      }
    }
    return items;
  }, [letters]);

  const findNearestAvailable = useCallback((letter: string): string | null => {
    if (letters.includes(letter)) return letter;
    const idx = ALL_LETTERS.indexOf(letter);
    if (idx === -1) return null;
    for (let d = 1; d < ALL_LETTERS.length; d++) {
      if (idx - d >= 0 && letters.includes(ALL_LETTERS[idx - d])) return ALL_LETTERS[idx - d];
      if (idx + d < ALL_LETTERS.length && letters.includes(ALL_LETTERS[idx + d])) return ALL_LETTERS[idx + d];
    }
    return null;
  }, [letters]);

  const getLetterFromY = useCallback((clientY: number): { letter: string | null; relativeY: number } => {
    const nav = navRef.current;
    if (!nav) return { letter: null, relativeY: 0 };
    
    const rect = nav.getBoundingClientRect();
    const relativeY = Math.max(0, Math.min(rect.height, clientY - rect.top));
    const itemHeight = rect.height / displayItems.length;
    const index = Math.min(displayItems.length - 1, Math.floor(relativeY / itemHeight));
    
    const item = displayItems[index];
    const letter = item?.type === 'letter' ? item.letter : findNearestAvailable(item?.letter || '');
    
    return { letter, relativeY };
  }, [displayItems, findNearestAvailable]);

  const handleStart = useCallback((clientY: number) => {
    setIsDragging(true);
    const { letter } = getLetterFromY(clientY);
    if (letter) {
      setScrubLetter(letter);
      onSelect(letter);
    }
  }, [getLetterFromY, onSelect]);

  const handleMove = useCallback((clientY: number) => {
    if (!isDragging) return;
    const { letter } = getLetterFromY(clientY);
    if (letter && letter !== scrubLetter) {
      setScrubLetter(letter);
      onSelect(letter);
    }
  }, [isDragging, getLetterFromY, onSelect, scrubLetter]);

  const handleEnd = useCallback(() => {
    setIsDragging(false);
    setScrubLetter(null);
  }, []);

  // Prevent text selection during drag
  const handleTouchStart = useCallback((e: React.TouchEvent) => {
    e.preventDefault();
    handleStart(e.touches[0].clientY);
  }, [handleStart]);

  const handleTouchMove = useCallback((e: React.TouchEvent) => {
    e.preventDefault();
    handleMove(e.touches[0].clientY);
  }, [handleMove]);

  const handleMouseDown = useCallback((e: React.MouseEvent) => {
    e.preventDefault();
    handleStart(e.clientY);
  }, [handleStart]);

  return (
    <>
      {/* Scrub indicator bubble - positioned relative to nav */}
      {isDragging && scrubLetter && (
        <div 
          className="absolute right-10 top-1/2 -translate-y-1/2 z-50 pointer-events-none"
          aria-hidden="true"
        >
          <div className="flex items-center">
            <div className="w-14 h-14 rounded-2xl bg-slate-800 border border-slate-600/50 shadow-xl flex items-center justify-center">
              <span className="text-2xl font-bold text-blue-400">{scrubLetter}</span>
            </div>
            {/* Arrow pointing to nav */}
            <div 
              className="w-0 h-0 -ml-px"
              style={{ 
                borderTop: '10px solid transparent', 
                borderBottom: '10px solid transparent', 
                borderLeft: '10px solid rgb(30, 41, 59)' 
              }} 
            />
          </div>
        </div>
      )}

      {/* Alphabet navigation bar */}
      <div
        ref={navRef}
        className={cn(
          // Absolute positioning within parent container
          'absolute right-1 top-1/2 -translate-y-1/2 z-40',
          // Layout
          'flex flex-col items-center py-2 px-1',
          // Appearance
          'rounded-lg bg-slate-800/25 border border-slate-600/30',
          'shadow-lg backdrop-blur-sm',
          // Interaction
          'select-none touch-none cursor-pointer'
        )}
        onTouchStart={handleTouchStart}
        onTouchMove={handleTouchMove}
        onTouchEnd={handleEnd}
        onMouseDown={handleMouseDown}
        onMouseMove={(e) => handleMove(e.clientY)}
        onMouseUp={handleEnd}
        onMouseLeave={() => isDragging && handleEnd()}
        role="navigation"
        aria-label="Alphabet index"
      >
        {displayItems.map((item, idx) => {
          const isActive = activeLetter === item.letter;
          const isScrubbing = scrubLetter === item.letter;
          
          if (item.type === 'dot') {
            return (
              <span 
                key={`dot-${idx}`} 
                className="text-[11px] font-bold w-5 h-5 flex items-center justify-center text-slate-600"
                aria-hidden="true"
              >
                •
              </span>
            );
          }
          
          return (
            <span
              key={item.letter}
              className={cn(
                'text-[11px] font-bold w-5 h-5 flex items-center justify-center leading-none transition-colors',
                isScrubbing && 'text-blue-400 scale-110',
                isActive && !isScrubbing && 'text-blue-400',
                !isActive && !isScrubbing && 'text-slate-300'
              )}
            >
              {item.letter}
            </span>
          );
        })}
      </div>
    </>
  );
}
