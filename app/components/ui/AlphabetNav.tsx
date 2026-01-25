'use client';

import React, { useRef, useState, useCallback, useMemo } from 'react';
import { cn } from '@/lib/utils';
import { alphabetNav } from '@/lib/config/theme';

const ALL_LETTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ#'.split('');

// Period/dot icon from FA Pro 7.1.0 light - 128×512
function DotIcon({ className }: { className?: string }) {
  return (
    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 128 512" fill="currentColor" className={className}>
      <path d="M64 448c-17.7 0-32-14.3-32-32s14.3-32 32-32 32 14.3 32 32-14.3 32-32 32zm0 32c35.3 0 64-28.7 64-64s-28.7-64-64-64-64 28.7-64 64 28.7 64 64 64z"/>
    </svg>
  );
}

interface AlphabetNavProps {
  letters: string[];
  activeLetter: string | null;
  onSelect: (letter: string) => void;
}

export function AlphabetNav({ letters, activeLetter, onSelect }: AlphabetNavProps) {
  const containerRef = useRef<HTMLDivElement>(null);
  const [isDragging, setIsDragging] = useState(false);
  const [scrubLetter, setScrubLetter] = useState<string | null>(null);
  const [bubbleY, setBubbleY] = useState(0);

  // Build display items: available letters + single dots for gaps
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
    
    let up = idx - 1;
    let down = idx + 1;
    
    while (up >= 0 || down < ALL_LETTERS.length) {
      if (up >= 0 && letters.includes(ALL_LETTERS[up])) return ALL_LETTERS[up];
      if (down < ALL_LETTERS.length && letters.includes(ALL_LETTERS[down])) return ALL_LETTERS[down];
      up--;
      down++;
    }
    return null;
  }, [letters]);

  const getLetterFromY = useCallback((clientY: number): string | null => {
    const container = containerRef.current;
    if (!container) return null;
    
    const rect = container.getBoundingClientRect();
    const relativeY = clientY - rect.top;
    const itemHeight = rect.height / displayItems.length;
    const index = Math.floor(relativeY / itemHeight);
    
    if (index >= 0 && index < displayItems.length) {
      setBubbleY(Math.max(24, Math.min(rect.height - 24, relativeY)));
      const item = displayItems[index];
      return item.type === 'letter' ? item.letter : findNearestAvailable(item.letter);
    }
    return null;
  }, [displayItems, findNearestAvailable]);

  const handleStart = useCallback((clientY: number) => {
    setIsDragging(true);
    const letter = getLetterFromY(clientY);
    if (letter) {
      setScrubLetter(letter);
      onSelect(letter);
    }
  }, [getLetterFromY, onSelect]);

  const handleMove = useCallback((clientY: number) => {
    if (!isDragging) return;
    const letter = getLetterFromY(clientY);
    if (letter) {
      setScrubLetter(letter);
      onSelect(letter);
    }
  }, [isDragging, getLetterFromY, onSelect]);

  const handleEnd = useCallback(() => {
    setIsDragging(false);
    setScrubLetter(null);
  }, []);

  const onTouchStart = useCallback((e: React.TouchEvent) => {
    e.preventDefault();
    handleStart(e.touches[0].clientY);
  }, [handleStart]);

  const onTouchMove = useCallback((e: React.TouchEvent) => {
    e.preventDefault();
    handleMove(e.touches[0].clientY);
  }, [handleMove]);

  const onTouchEnd = useCallback((e: React.TouchEvent) => {
    e.preventDefault();
    handleEnd();
  }, [handleEnd]);

  const onMouseDown = useCallback((e: React.MouseEvent) => {
    e.preventDefault();
    handleStart(e.clientY);
  }, [handleStart]);

  const onMouseMove = useCallback((e: React.MouseEvent) => {
    handleMove(e.clientY);
  }, [handleMove]);

  const onMouseUp = useCallback(() => handleEnd(), [handleEnd]);
  const onMouseLeave = useCallback(() => { if (isDragging) handleEnd(); }, [isDragging, handleEnd]);

  return (
    <>
      {isDragging && scrubLetter && (
        <div
          className="fixed z-50 pointer-events-none flex items-center"
          style={{
            right: 44,
            top: containerRef.current 
              ? containerRef.current.getBoundingClientRect().top + bubbleY 
              : 0,
            transform: 'translateY(-50%)',
          }}
        >
          <div className="w-14 h-14 rounded-2xl bg-slate-800 border border-slate-600/50 shadow-xl flex items-center justify-center">
            <span className="text-2xl font-bold text-blue-400">{scrubLetter}</span>
          </div>
          <div 
            className="w-0 h-0 -ml-px"
            style={{
              borderTop: '10px solid transparent',
              borderBottom: '10px solid transparent',
              borderLeft: '10px solid rgb(30, 41, 59)',
            }}
          />
        </div>
      )}

      <div
        ref={containerRef}
        className={alphabetNav.card}
        onTouchStart={onTouchStart}
        onTouchMove={onTouchMove}
        onTouchEnd={onTouchEnd}
        onMouseDown={onMouseDown}
        onMouseMove={onMouseMove}
        onMouseUp={onMouseUp}
        onMouseLeave={onMouseLeave}
      >
        {displayItems.map((item, idx) => {
          const isActive = item.type === 'letter' && (activeLetter === item.letter || scrubLetter === item.letter);

          return (
            <span
              key={item.type === 'letter' ? item.letter : `dot-${idx}`}
              className={cn(
                alphabetNav.letter,
                item.type === 'letter'
                  ? isActive ? alphabetNav.letterActive : alphabetNav.letterAvailable
                  : alphabetNav.letterUnavailable
              )}
            >
              {item.type === 'letter' ? item.letter : <DotIcon className="w-1.5 h-1.5" />}
            </span>
          );
        })}
      </div>
    </>
  );
}
