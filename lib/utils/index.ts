// =============================================================================
// UTILITY FUNCTIONS
// =============================================================================

/**
 * Format phone number for display
 */
export function formatPhone(phone: string): string {
  // Remove all non-digits
  const digits = phone.replace(/\D/g, '');
  
  // Format as (XXX) XXX-XXXX or XXX-XXX-XXXX
  if (digits.length === 10) {
    return `(${digits.slice(0, 3)}) ${digits.slice(3, 6)}-${digits.slice(6)}`;
  } else if (digits.length === 11 && digits[0] === '1') {
    return `1 (${digits.slice(1, 4)}) ${digits.slice(4, 7)}-${digits.slice(7)}`;
  }
  
  return phone;
}

/**
 * Format phone number for tel: link
 */
export function formatPhoneForCall(phone: string): string {
  return phone.replace(/\D/g, '');
}

/**
 * Format date for display
 */
export function formatDate(date: string | Date | null): string {
  if (!date) return '';
  
  const d = new Date(date);
  return d.toLocaleDateString('en-US', {
    month: 'short',
    day: 'numeric',
    year: 'numeric',
  });
}

/**
 * Format emails for copying (comma-separated)
 */
export function formatEmailsForCopy(emails: string[]): string {
  return emails.join(', ');
}

/**
 * Open address in maps app
 */
export function openInMaps(address: string): void {
  const encoded = encodeURIComponent(address);
  // Try Apple Maps on iOS, Google Maps elsewhere
  const isIOS = /iPad|iPhone|iPod/.test(navigator.userAgent);
  const url = isIOS 
    ? `maps://maps.apple.com/?q=${encoded}`
    : `https://maps.google.com/maps?q=${encoded}`;
  window.open(url, '_blank');
}

/**
 * Make a phone call
 */
export function makeCall(phone: string): void {
  window.open(`tel:${formatPhoneForCall(phone)}`, '_self');
}

/**
 * Send an email
 */
export function sendEmail(email: string | string[]): void {
  const emailStr = Array.isArray(email) ? email.join(',') : email;
  window.open(`mailto:${emailStr}`, '_self');
}

/**
 * Join MS Teams meeting
 */
export function joinTeamsMeeting(url: string): void {
  window.open(url, '_blank');
}

/**
 * Truncate text with ellipsis
 */
export function truncate(text: string, maxLength: number): string {
  if (text.length <= maxLength) return text;
  return text.slice(0, maxLength - 3) + '...';
}

/**
 * Get initials from name
 */
export function getInitials(name: string): string {
  return name
    .split(' ')
    .map(word => word[0])
    .join('')
    .toUpperCase()
    .slice(0, 2);
}

/**
 * Check if we're on a mobile device
 */
export function isMobile(): boolean {
  if (typeof window === 'undefined') return false;
  return window.innerWidth < 768;
}

/**
 * Debounce function
 */
export function debounce<T extends (...args: unknown[]) => unknown>(
  fn: T,
  delay: number
): (...args: Parameters<T>) => void {
  let timeoutId: NodeJS.Timeout;
  return (...args: Parameters<T>) => {
    clearTimeout(timeoutId);
    timeoutId = setTimeout(() => fn(...args), delay);
  };
}

/**
 * Group array by key
 */
export function groupBy<T>(array: T[], key: keyof T): Record<string, T[]> {
  return array.reduce((acc, item) => {
    const groupKey = String(item[key]);
    if (!acc[groupKey]) {
      acc[groupKey] = [];
    }
    acc[groupKey].push(item);
    return acc;
  }, {} as Record<string, T[]>);
}

/**
 * Sort by display order
 */
export function sortByDisplayOrder<T extends { display_order?: number }>(items: T[]): T[] {
  return [...items].sort((a, b) => (a.display_order ?? 0) - (b.display_order ?? 0));
}

/**
 * Get unique items by key
 */
export function uniqueBy<T>(array: T[], key: keyof T): T[] {
  const seen = new Set();
  return array.filter(item => {
    const k = item[key];
    if (seen.has(k)) return false;
    seen.add(k);
    return true;
  });
}

/**
 * Sleep for a given number of milliseconds
 */
export function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}
