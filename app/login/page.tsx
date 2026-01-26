'use client';

import { useState, useRef, useEffect } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { login } from '@/lib/auth/actions';
import { LLMLogo } from '@/lib/icons';
import { cn } from '@/lib/config/theme';

export default function LoginPage() {
  const router = useRouter();
  const searchParams = useSearchParams();
  const [pin, setPin] = useState(['', '', '', '', '', '', '', '']);
  const [rememberMe, setRememberMe] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [isLoading, setIsLoading] = useState(false);
  const inputRefs = useRef<(HTMLInputElement | null)[]>([]);
  
  const redirectTo = searchParams.get('from') || '/';

  // Focus first input on mount
  useEffect(() => {
    inputRefs.current[0]?.focus();
  }, []);

  const handleInputChange = (index: number, value: string) => {
    // Only allow alphanumeric characters
    const char = value.toUpperCase().replace(/[^A-Z0-9]/g, '');
    
    if (char.length <= 1) {
      const newPin = [...pin];
      newPin[index] = char;
      setPin(newPin);
      setError(null);
      
      // Move to next input if character entered
      if (char && index < 7) {
        inputRefs.current[index + 1]?.focus();
      }
    }
  };

  const handleKeyDown = (index: number, e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Backspace' && !pin[index] && index > 0) {
      // Move to previous input on backspace if current is empty
      inputRefs.current[index - 1]?.focus();
    } else if (e.key === 'Enter') {
      handleSubmit();
    }
  };

  const handlePaste = (e: React.ClipboardEvent) => {
    e.preventDefault();
    const pastedText = e.clipboardData.getData('text').toUpperCase().replace(/[^A-Z0-9]/g, '');
    
    if (pastedText.length === 8) {
      const newPin = pastedText.split('');
      setPin(newPin);
      setError(null);
      inputRefs.current[7]?.focus();
    }
  };

  const handleSubmit = async () => {
    const fullPin = pin.join('');
    
    if (fullPin.length !== 8) {
      setError('Please enter your complete 8-character PIN');
      return;
    }
    
    setIsLoading(true);
    setError(null);
    
    try {
      const result = await login(fullPin, rememberMe);
      
      if (result.success) {
        router.push(redirectTo);
        router.refresh();
      } else {
        setError(result.error || 'Login failed');
        // Clear PIN on error
        setPin(['', '', '', '', '', '', '', '']);
        inputRefs.current[0]?.focus();
      }
    } catch (err) {
      setError('An unexpected error occurred');
    } finally {
      setIsLoading(false);
    }
  };

  return (
    <div className="min-h-screen bg-slate-950 flex flex-col items-center justify-center p-4">
      {/* Logo */}
      <div className="mb-8">
        <LLMLogo className="w-20 h-20 text-[#074f88]" />
      </div>
      
      {/* Title */}
      <h1 className="text-2xl font-bold text-white mb-2">Legal Legends Manual</h1>
      <p className="text-slate-400 text-sm mb-8">Enter your 8-character PIN to continue</p>
      
      {/* PIN Input */}
      <div className="flex gap-2 mb-6" onPaste={handlePaste}>
        {pin.map((char, index) => (
          <input
            key={index}
            ref={(el) => { inputRefs.current[index] = el; }}
            type="text"
            inputMode="text"
            maxLength={1}
            value={char}
            onChange={(e) => handleInputChange(index, e.target.value)}
            onKeyDown={(e) => handleKeyDown(index, e)}
            disabled={isLoading}
            className={cn(
              'w-10 h-12 text-center text-xl font-mono font-bold rounded-lg border-2 bg-slate-900 text-white',
              'focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500',
              'disabled:opacity-50 disabled:cursor-not-allowed',
              'transition-all',
              error ? 'border-red-500/50' : 'border-slate-700'
            )}
          />
        ))}
      </div>
      
      {/* Error message */}
      {error && (
        <div className="mb-4 px-4 py-2 bg-red-500/10 border border-red-500/30 rounded-lg">
          <p className="text-red-400 text-sm text-center">{error}</p>
        </div>
      )}
      
      {/* Remember me checkbox */}
      <label className="flex items-center gap-3 mb-6 cursor-pointer">
        <div className="relative">
          <input
            type="checkbox"
            checked={rememberMe}
            onChange={(e) => setRememberMe(e.target.checked)}
            disabled={isLoading}
            className="sr-only"
          />
          <div className={cn(
            'w-5 h-5 rounded border-2 flex items-center justify-center transition-all',
            rememberMe 
              ? 'bg-blue-500 border-blue-500' 
              : 'bg-slate-900 border-slate-600'
          )}>
            {rememberMe && (
              <svg className="w-3 h-3 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={3}>
                <path strokeLinecap="round" strokeLinejoin="round" d="M5 13l4 4L19 7" />
              </svg>
            )}
          </div>
        </div>
        <span className="text-slate-400 text-sm">Remember me for 7 days</span>
      </label>
      
      {/* Submit button */}
      <button
        onClick={handleSubmit}
        disabled={isLoading || pin.join('').length !== 8}
        className={cn(
          'w-full max-w-xs py-3 px-6 rounded-xl font-medium text-white transition-all',
          'focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 focus:ring-offset-slate-950',
          isLoading || pin.join('').length !== 8
            ? 'bg-slate-700 cursor-not-allowed'
            : 'bg-blue-600 hover:bg-blue-500 active:bg-blue-700'
        )}
      >
        {isLoading ? (
          <span className="flex items-center justify-center gap-2">
            <svg className="w-5 h-5 animate-spin" viewBox="0 0 24 24">
              <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" fill="none" />
              <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z" />
            </svg>
            Signing in...
          </span>
        ) : (
          'Sign In'
        )}
      </button>
      
      {/* Help text */}
      <p className="mt-8 text-slate-500 text-xs text-center max-w-xs">
        Don't have a PIN? Register via WhatsApp to get access.
      </p>
    </div>
  );
}
