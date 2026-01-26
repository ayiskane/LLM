'use client';

import React, { useRef, useCallback, useState, useEffect } from 'react';
import { cn } from '@/lib/utils';

const ALPHABET = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ#'.split('');

interface AlphabetNavProps {
  /** Letters that have content sections */
  availableLetters: string[];
  /** Callback when user selects a letter */
  onLetterChange: (letter: string) => void;
}

/**
 * AlphabetNav - iOS Contacts-style alphabet index scrubber
 * 
 * Features:
 * - Fixed positioning (doesn't interfere with scroll container)
 * - Touch drag/scrub support
 * - Mouse support for desktop
 * - Shows only available letters, dots for gaps
 * - Letter indicator bubble while scrubbing
 * - Uses scrollIntoView for reliable scrolling
 */
export function AlphabetNav({ availableLetters, onLetterChange }: AlphabetNavProps) {
  const barRef = useRef<HTMLDivElement>(null);
  const [isActive, setIsActive] = useState(false);
  const [currentLetter, setCurrentLetter] = useState<string | null>(null);
  const lastLetterRef = useRef<string | null>(null);

  // Calculate which letter is at a given Y coordinate
  const getLetterAtY = useCallback((clientY: number): string | null => {
    const bar = barRef.current;
    if (!bar) return null;

    const rect = bar.getBoundingClientRect();
    const relativeY = Math.max(0, Math.min(rect.height, clientY - rect.top));
    const ratio = relativeY / rect.height;
    const index = Math.min(ALPHABET.length - 1, Math.floor(ratio * ALPHABET.length));
    const letter = ALPHABET[index];

    // If letter is available, return it
    if (availableLetters.includes(letter)) return letter;

    // Find nearest available letter
    const letterIndex = ALPHABET.indexOf(letter);
    for (let offset = 1; offset < ALPHABET.length; offset++) {
      // Check before
      if (letterIndex - offset >= 0) {
        const before = ALPHABET[letterIndex - offset];
        if (availableLetters.includes(before)) return before;
      }
      // Check after
      if (letterIndex + offset < ALPHABET.length) {
        const after = ALPHABET[letterIndex + offset];
        if (availableLetters.includes(after)) return after;
      }
    }
    return null;
  }, [availableLetters]);

  // Handle scrub action
  const handleScrub = useCallback((clientY: number) => {
    const letter = getLetterAtY(clientY);
    if (letter && letter !== lastLetterRef.current) {
      lastLetterRef.current = letter;
      setCurrentLetter(letter);
      onLetterChange(letter);
    }
  }, [getLetterAtY, onLetterChange]);

  // Touch handlers
  const handleTouchStart = useCallback((e: React.TouchEvent) => {
    e.preventDefault();
    setIsActive(true);
    handleScrub(e.touches[0].clientY);
  }, [handleScrub]);

  const handleTouchMove = useCallback((e: React.TouchEvent) => {
    e.preventDefault();
    handleScrub(e.touches[0].clientY);
  }, [handleScrub]);

  const handleTouchEnd = useCallback(() => {
    setIsActive(false);
    setCurrentLetter(null);
    lastLetterRef.current = null;
  }, []);

  // Mouse handlers (desktop)
  const handleMouseDown = useCallback((e: React.MouseEvent) => {
    e.preventDefault();
    setIsActive(true);
    handleScrub(e.clientY);
  }, [handleScrub]);

  const handleMouseMove = useCallback((e: React.MouseEvent) => {
    if (isActive) {
      handleScrub(e.clientY);
    }
  }, [isActive, handleScrub]);

  const handleMouseUp = useCallback(() => {
    setIsActive(false);
    setCurrentLetter(null);
    lastLetterRef.current = null;
  }, []);

  const handleMouseLeave = useCallback(() => {
    if (isActive) {
      setIsActive(false);
      setCurrentLetter(null);
      lastLetterRef.current = null;
    }
  }, [isActive]);

  // Global mouse up listener for when mouse leaves element while dragging
  useEffect(() => {
    if (isActive) {
      const handleGlobalMouseUp = () => {
        setIsActive(false);
        setCurrentLetter(null);
        lastLetterRef.current = null;
      };
      window.addEventListener('mouseup', handleGlobalMouseUp);
      return () => window.removeEventListener('mouseup', handleGlobalMouseUp);
    }
  }, [isActive]);

  // Build display items: available letters + dots for gaps
  const displayItems = React.useMemo(() => {
    const items: { type: 'letter' | 'dot'; value: string; key: string }[] = [];
    let gapCount = 0;

    ALPHABET.forEach((letter, idx) => {
      if (availableLetters.includes(letter)) {
        gapCount = 0;
        items.push({ type: 'letter', value: letter, key: letter });
      } else {
        gapCount++;
        // Only show first dot in a gap
        if (gapCount === 1) {
          items.push({ type: 'dot', value: '•', key: `gap-${idx}` });
        }
      }
    });

    return items;
  }, [availableLetters]);

  return (
    <>
      {/* Letter indicator bubble - shows while scrubbing */}
      {isActive && currentLetter && (
        <div 
          className="fixed right-12 z-[60] pointer-events-none"
          style={{ top: '50%', transform: 'translateY(-50%)' }}
        >
          <div className="w-14 h-14 rounded-2xl bg-slate-800 border border-slate-600 shadow-2xl flex items-center justify-center">
            <span className="text-2xl font-bold text-blue-400">{currentLetter}</span>
          </div>
        </div>
      )}

      {/* Alphabet bar */}
      <div
        ref={barRef}
        className={cn(
          'fixed right-0.5 z-50',
          'flex flex-col items-center justify-center',
          'py-1 px-1 rounded-lg',
          'select-none',
          isActive && 'bg-slate-800/60'
        )}
        style={{
          top: '50%',
          transform: 'translateY(-50%)',
          touchAction: 'none', // Critical: prevents browser scroll
          maxHeight: 'calc(100dvh - 14rem)', // Account for header + bottom nav
        }}
        onTouchStart={handleTouchStart}
        onTouchMove={handleTouchMove}
        onTouchEnd={handleTouchEnd}
        onMouseDown={handleMouseDown}
        onMouseMove={handleMouseMove}
        onMouseUp={handleMouseUp}
        onMouseLeave={handleMouseLeave}
        role="navigation"
        aria-label="Alphabet index"
      >
        {displayItems.map((item) => {
          if (item.type === 'dot') {
            return (
              <span
                key={item.key}
                className="text-[8px] text-slate-600 h-2 flex items-center justify-center"
                aria-hidden="true"
              >
                •
              </span>
            );
          }

          const isCurrentLetter = currentLetter === item.value;

          return (
            <span
              key={item.key}
              className={cn(
                'text-[10px] font-semibold w-5 h-4 flex items-center justify-center',
                'transition-transform duration-75',
                isCurrentLetter && 'text-blue-400 scale-150 font-bold',
                !isCurrentLetter && 'text-slate-400'
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
