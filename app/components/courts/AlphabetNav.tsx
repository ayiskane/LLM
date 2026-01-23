'use client';

import React, { useRef, useState, useCallback } from 'react';
import { cn } from '@/lib/utils';
import { alphabetNav } from '@/lib/config/theme';

const ALL_LETTERS = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ#'.split('');

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
    const letterHeight = rect.height / ALL_LETTERS.length;
    const index = Math.floor(relativeY / letterHeight);
    
    if (index >= 0 && index < ALL_LETTERS.length) {
      setBubbleY(Math.max(24, Math.min(rect.height - 24, relativeY)));
      return findNearestAvailable(ALL_LETTERS[index]);
    }
    return null;
  }, [findNearestAvailable]);

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
      {/* Scrub bubble - positioned outside the card */}
      {isDragging && scrubLetter && (
        <div
          className="fixed z-50 pointer-events-none"
          style={{
            right: 56,
            top: containerRef.current 
              ? containerRef.current.getBoundingClientRect().top + bubbleY 
              : 0,
            transform: 'translateY(-50%)',
          }}
        >
          <div className="flex items-center">
            <div className={alphabetNav.bubble}>
              <span className="text-xl font-bold text-blue-400">{scrubLetter}</span>
            </div>
            <div 
              className="w-0 h-0 -ml-px"
              style={{
                borderTop: '8px solid transparent',
                borderBottom: '8px solid transparent',
                borderLeft: '8px solid rgb(30, 41, 59)',
              }}
            />
          </div>
        </div>
      )}

      {/* Alphabet card */}
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
        {ALL_LETTERS.map((letter) => {
          const isAvailable = letters.includes(letter);
          const isActive = activeLetter === letter || scrubLetter === letter;

          return (
            <span
              key={letter}
              className={cn(
                alphabetNav.letter,
                isAvailable
                  ? isActive
                    ? alphabetNav.letterActive
                    : alphabetNav.letterAvailable
                  : alphabetNav.letterUnavailable
              )}
            >
              {letter}
            </span>
          );
        })}
      </div>
    </>
  );
}
