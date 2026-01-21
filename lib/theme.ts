// Cyber Ocean Theme Constants
// All color values and styling tokens in one place

export const theme = {
  // Base colors
  colors: {
    bg: {
      primary: '#080b12',
      card: 'rgba(59,130,246,0.03)',
      cardHover: 'rgba(59,130,246,0.06)',
      cardActive: 'rgba(59,130,246,0.08)',
      subtle: 'rgba(59,130,246,0.02)',
      item: 'rgba(59,130,246,0.04)',
      header: 'rgba(8,11,18,0.95)',
      headerSolid: 'rgba(8,11,18,0.9)',
    },
    border: {
      primary: 'rgba(59,130,246,0.12)',
      subtle: 'rgba(59,130,246,0.08)',
      light: 'rgba(59,130,246,0.06)',
      accent: 'rgba(59,130,246,0.15)',
      strong: 'rgba(59,130,246,0.2)',
    },
    accent: {
      primary: '#3b82f6',     // blue-500
      secondary: '#22d3ee',   // cyan-400
      gradient: 'linear-gradient(135deg, #3b82f6, #22d3ee)',
    },
    text: {
      primary: '#ffffff',
      secondary: '#e4e4e7',   // zinc-200
      muted: '#a1a1aa',       // zinc-400
      subtle: '#71717a',      // zinc-500
      disabled: '#52525b',    // zinc-600
    },
    // Section/category colors
    section: {
      emerald: {
        dot: '#34d399',
        bg: 'rgba(16,185,129,0.15)',
        text: '#34d399',
      },
      blue: {
        dot: '#60a5fa',
        bg: 'rgba(59,130,246,0.15)',
        text: '#60a5fa',
      },
      amber: {
        dot: '#fbbf24',
        bg: 'rgba(245,158,11,0.15)',
        text: '#fbbf24',
      },
      cyan: {
        dot: '#22d3ee',
        bg: 'rgba(34,211,238,0.15)',
        text: '#22d3ee',
      },
      indigo: {
        dot: '#a5b4fc',
        bg: 'rgba(99,102,241,0.15)',
        text: '#a5b4fc',
      },
      purple: {
        dot: '#a78bfa',
        bg: 'rgba(139,92,246,0.15)',
        text: '#a78bfa',
      },
      teal: {
        dot: '#2dd4bf',
        bg: 'rgba(20,184,166,0.15)',
        text: '#2dd4bf',
      },
    },
  },

  // Background effects
  effects: {
    grid: {
      image: 'linear-gradient(rgba(59,130,246,0.06) 1px, transparent 1px), linear-gradient(90deg, rgba(59,130,246,0.06) 1px, transparent 1px)',
      size: '40px 40px',
      opacity: 0.2,
    },
    orb1: {
      position: { top: '-150px', right: '-100px' },
      size: { width: '500px', height: '500px' },
      gradient: 'radial-gradient(circle, rgba(59,130,246,0.25) 0%, rgba(6,182,212,0.12) 40%, transparent 70%)',
      blur: '100px',
    },
    orb2: {
      position: { bottom: '-150px', left: '-100px' },
      size: { width: '400px', height: '400px' },
      gradient: 'radial-gradient(circle, rgba(99,102,241,0.18) 0%, transparent 60%)',
      blur: '100px',
    },
  },

  // Component-specific styles
  components: {
    card: {
      base: {
        background: 'rgba(59,130,246,0.03)',
        border: '1px solid rgba(59,130,246,0.12)',
        borderRadius: '8px',
      },
      header: {
        background: 'rgba(59,130,246,0.06)',
        borderBottom: '1px solid rgba(59,130,246,0.08)',
        padding: '12px',
      },
      body: {
        background: 'rgba(59,130,246,0.02)',
      },
    },
    button: {
      primary: {
        background: 'linear-gradient(135deg, #3b82f6, #22d3ee)',
        color: 'white',
      },
      secondary: {
        background: 'rgba(59,130,246,0.08)',
        border: '1px solid rgba(59,130,246,0.15)',
        color: '#a1a1aa',
      },
      copy: {
        background: 'rgba(59,130,246,0.08)',
        border: '1px solid rgba(59,130,246,0.15)',
      },
    },
    tag: {
      base: {
        fontSize: '9px',
        padding: '2px 8px',
        borderRadius: '4px',
        fontFamily: 'monospace',
      },
    },
    section: {
      header: {
        padding: '12px',
        gap: '10px',
      },
      title: {
        fontSize: '10px',
        fontFamily: 'monospace',
        textTransform: 'uppercase' as const,
        letterSpacing: '0.08em',
      },
    },
    entry: {
      label: {
        fontSize: '9px',
        fontFamily: 'monospace',
        textTransform: 'uppercase' as const,
        letterSpacing: '0.04em',
        marginBottom: '4px',
      },
      value: {
        fontSize: '13px',
      },
      row: {
        padding: '8px 12px',
        borderBottom: '1px solid rgba(59,130,246,0.06)',
      },
    },
  },
} as const;

// Type exports for TypeScript
export type SectionColor = keyof typeof theme.colors.section;
export type ThemeColors = typeof theme.colors;
