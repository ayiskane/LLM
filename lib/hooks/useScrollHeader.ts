'use client';

import { useState, useEffect, useCallback, useRef } from 'react';
import { UI_CONFIG } from '@/lib/config/constants';

export function useScrollHeader() {
  const [isHeaderCollapsed, setIsHeaderCollapsed] = useState(false);
  const scrollRef = useRef<HTMLDivElement>(null);

  const handleScroll = useCallback(() => {
    if (!scrollRef.current) return;
    
    const scrollTop = scrollRef.current.scrollTop;
    
    // Hysteresis to prevent flickering
    if (!isHeaderCollapsed && scrollTop > UI_CONFIG.HEADER_COLLAPSE_THRESHOLD_DOWN) {
      setIsHeaderCollapsed(true);
    } else if (isHeaderCollapsed && scrollTop < UI_CONFIG.HEADER_COLLAPSE_THRESHOLD_UP) {
      setIsHeaderCollapsed(false);
    }
  }, [isHeaderCollapsed]);

  useEffect(() => {
    const scrollElement = scrollRef.current;
    if (scrollElement) {
      scrollElement.addEventListener('scroll', handleScroll, { passive: true });
      return () => scrollElement.removeEventListener('scroll', handleScroll);
    }
  }, [handleScroll]);

  const scrollToTop = useCallback(() => {
    scrollRef.current?.scrollTo({ top: 0, behavior: 'smooth' });
  }, []);

  return {
    scrollRef,
    isHeaderCollapsed,
    scrollToTop,
  };
}
