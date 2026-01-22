'use client';

import { useState, useEffect, useMemo, useCallback, useRef } from 'react';
import { createClient } from '@/lib/api/supabase';
import { UI } from '@/lib/config/constants';

// ============================================================================
// CLIPBOARD HOOK
// ============================================================================

/**
 * Hook for clipboard functionality with auto-reset toast
 */
export function useCopyToClipboard(resetDelay = UI.TOAST_DURATION) {
  const [copiedField, setCopiedField] = useState<string | null>(null);

  const copyToClipboard = useCallback((text: string, field: string) => {
    navigator.clipboard.writeText(text);
    setCopiedField(field);
  }, []);

  useEffect(() => {
    if (copiedField) {
      const timer = setTimeout(() => setCopiedField(null), resetDelay);
      return () => clearTimeout(timer);
    }
  }, [copiedField, resetDelay]);

  return { copiedField, copyToClipboard, showToast: !!copiedField };
}

// ============================================================================
// SCROLL HEADER HOOK
// ============================================================================

/**
 * Hook for collapsing header on scroll with hysteresis to prevent flickering
 */
export function useScrollHeader(
  collapseThreshold = UI.HEADER_COLLAPSE_THRESHOLD,
  expandThreshold = UI.HEADER_EXPAND_THRESHOLD
) {
  const [isCollapsed, setIsCollapsed] = useState(false);
  const containerRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const container = containerRef.current;
    if (!container) return;

    const handleScroll = () => {
      const scrollTop = container.scrollTop;
      
      if (isCollapsed && scrollTop < expandThreshold) {
        setIsCollapsed(false);
      } else if (!isCollapsed && scrollTop > collapseThreshold) {
        setIsCollapsed(true);
      }
    };

    container.addEventListener('scroll', handleScroll, { passive: true });
    return () => container.removeEventListener('scroll', handleScroll);
  }, [isCollapsed, collapseThreshold, expandThreshold]);

  return { isCollapsed, containerRef };
}

// ============================================================================
// DEBOUNCE HOOK
// ============================================================================

/**
 * Hook for debouncing a value
 */
export function useDebounce<T>(value: T, delay = UI.SEARCH_DEBOUNCE): T {
  const [debouncedValue, setDebouncedValue] = useState<T>(value);

  useEffect(() => {
    const timer = setTimeout(() => setDebouncedValue(value), delay);
    return () => clearTimeout(timer);
  }, [value, delay]);

  return debouncedValue;
}

// ============================================================================
// DAYTIME HOOK
// ============================================================================

/**
 * Hook for checking daytime hours (8am-5pm weekdays PT)
 */
export function useDaytime() {
  const [isDaytime, setIsDaytime] = useState(() => {
    const now = new Date();
    const hour = now.getHours();
    const day = now.getDay();
    return day >= 1 && day <= 5 && hour >= 8 && hour < 17;
  });

  useEffect(() => {
    const interval = setInterval(() => {
      const now = new Date();
      const hour = now.getHours();
      const day = now.getDay();
      setIsDaytime(day >= 1 && day <= 5 && hour >= 8 && hour < 17);
    }, 60000);

    return () => clearInterval(interval);
  }, []);

  return isDaytime;
}

// ============================================================================
// LOCAL STORAGE HOOK
// ============================================================================

/**
 * Hook for persisting state to localStorage
 */
export function useLocalStorage<T>(key: string, initialValue: T) {
  const [storedValue, setStoredValue] = useState<T>(() => {
    if (typeof window === 'undefined') return initialValue;
    
    try {
      const item = window.localStorage.getItem(key);
      return item ? JSON.parse(item) : initialValue;
    } catch (error) {
      console.error(`Error reading localStorage key "${key}":`, error);
      return initialValue;
    }
  });

  const setValue = useCallback((value: T | ((val: T) => T)) => {
    try {
      const valueToStore = value instanceof Function ? value(storedValue) : value;
      setStoredValue(valueToStore);
      if (typeof window !== 'undefined') {
        window.localStorage.setItem(key, JSON.stringify(valueToStore));
      }
    } catch (error) {
      console.error(`Error setting localStorage key "${key}":`, error);
    }
  }, [key, storedValue]);

  return [storedValue, setValue] as const;
}

// ============================================================================
// MEDIA QUERY HOOK
// ============================================================================

/**
 * Hook for responsive design
 */
export function useMediaQuery(query: string): boolean {
  const [matches, setMatches] = useState(false);

  useEffect(() => {
    if (typeof window === 'undefined') return;
    
    const mediaQuery = window.matchMedia(query);
    setMatches(mediaQuery.matches);

    const handler = (event: MediaQueryListEvent) => setMatches(event.matches);
    mediaQuery.addEventListener('change', handler);
    
    return () => mediaQuery.removeEventListener('change', handler);
  }, [query]);

  return matches;
}

/**
 * Convenience hook for mobile detection
 */
export function useIsMobile(): boolean {
  return useMediaQuery('(max-width: 768px)');
}

// ============================================================================
// PREVIOUS VALUE HOOK
// ============================================================================

/**
 * Hook to get the previous value of a state
 */
export function usePrevious<T>(value: T): T | undefined {
  const ref = useRef<T | undefined>(undefined);
  
  useEffect(() => {
    ref.current = value;
  }, [value]);
  
  return ref.current;
}

// ============================================================================
// INTERSECTION OBSERVER HOOK
// ============================================================================

/**
 * Hook for detecting when an element is in viewport
 */
export function useInView(options?: IntersectionObserverInit) {
  const [isInView, setIsInView] = useState(false);
  const ref = useRef<HTMLElement>(null);

  useEffect(() => {
    const element = ref.current;
    if (!element) return;

    const observer = new IntersectionObserver(([entry]) => {
      setIsInView(entry.isIntersecting);
    }, options);

    observer.observe(element);
    return () => observer.disconnect();
  }, [options]);

  return { ref, isInView };
}

// ============================================================================
// KEYBOARD SHORTCUT HOOK
// ============================================================================

/**
 * Hook for handling keyboard shortcuts
 */
export function useKeyboardShortcut(
  key: string,
  callback: () => void,
  modifiers: { ctrl?: boolean; shift?: boolean; alt?: boolean; meta?: boolean } = {}
) {
  useEffect(() => {
    const handler = (event: KeyboardEvent) => {
      const { ctrl, shift, alt, meta } = modifiers;
      
      if (
        event.key.toLowerCase() === key.toLowerCase() &&
        (!ctrl || event.ctrlKey) &&
        (!shift || event.shiftKey) &&
        (!alt || event.altKey) &&
        (!meta || event.metaKey)
      ) {
        event.preventDefault();
        callback();
      }
    };

    window.addEventListener('keydown', handler);
    return () => window.removeEventListener('keydown', handler);
  }, [key, callback, modifiers]);
}

// ============================================================================
// ONLINE STATUS HOOK
// ============================================================================

/**
 * Hook for detecting online/offline status
 */
export function useOnlineStatus(): boolean {
  const [isOnline, setIsOnline] = useState(
    typeof navigator !== 'undefined' ? navigator.onLine : true
  );

  useEffect(() => {
    const handleOnline = () => setIsOnline(true);
    const handleOffline = () => setIsOnline(false);

    window.addEventListener('online', handleOnline);
    window.addEventListener('offline', handleOffline);

    return () => {
      window.removeEventListener('online', handleOnline);
      window.removeEventListener('offline', handleOffline);
    };
  }, []);

  return isOnline;
}

// ============================================================================
// MOUNT STATE HOOK
// ============================================================================

/**
 * Hook for checking if component is mounted (useful for async operations)
 */
export function useIsMounted(): () => boolean {
  const isMounted = useRef(false);

  useEffect(() => {
    isMounted.current = true;
    return () => {
      isMounted.current = false;
    };
  }, []);

  return useCallback(() => isMounted.current, []);
}

// ============================================================================
// EXPORT ALL
// ============================================================================

export {
  useCopyToClipboard,
  useScrollHeader,
  useDebounce,
  useDaytime,
  useLocalStorage,
  useMediaQuery,
  useIsMobile,
  usePrevious,
  useInView,
  useKeyboardShortcut,
  useOnlineStatus,
  useIsMounted,
};
