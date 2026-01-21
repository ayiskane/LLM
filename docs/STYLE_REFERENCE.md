# Cyber Ocean Theme - Style Reference Guide

## File Overview

| File | Location | Purpose |
|------|----------|---------|
| `theme.ts` | `/lib/theme.ts` | **Main source of truth** - All colors, spacing, effects |
| `ui.tsx` | `/app/components/ui.tsx` | Reusable components that use theme.ts |
| `globals.css` | `/app/globals.css` | Tailwind base + optional CSS variables |

---

## 1. THEME.TS - Color & Style Tokens

This is where you change colors, backgrounds, borders, etc.

### Background Colors
```typescript
// Location: theme.colors.bg
bg: {
  primary: '#080b12',           // Main page background (dark blue-black)
  card: 'rgba(59,130,246,0.03)',      // Card/section background
  cardHover: 'rgba(59,130,246,0.06)', // Hover state for cards
  cardActive: 'rgba(59,130,246,0.08)', // Active/pressed state
  subtle: 'rgba(59,130,246,0.02)',    // Very subtle background
  item: 'rgba(59,130,246,0.04)',      // Individual items (eDisclosure icons, etc.)
  header: 'rgba(8,11,18,0.95)',       // Sticky header with blur
  headerSolid: 'rgba(8,11,18,0.9)',   // Header without blur
}
```

**To change:** Edit the hex/rgba values. The `59,130,246` is blue (rgb) - change all instances to shift the overall hue.

---

### Border Colors
```typescript
// Location: theme.colors.border
border: {
  primary: 'rgba(59,130,246,0.12)',   // Main card borders
  subtle: 'rgba(59,130,246,0.08)',    // Section dividers
  light: 'rgba(59,130,246,0.06)',     // Entry row separators
  accent: 'rgba(59,130,246,0.15)',    // Buttons, interactive elements
  strong: 'rgba(59,130,246,0.2)',     // Emphasis borders
}
```

**To change:** Adjust opacity (last number) for subtlety, or change `59,130,246` for different hue.

---

### Accent Colors (Gradients & Primary)
```typescript
// Location: theme.colors.accent
accent: {
  primary: '#3b82f6',      // Blue - main accent
  secondary: '#22d3ee',    // Cyan - gradient end
  gradient: 'linear-gradient(135deg, #3b82f6, #22d3ee)',  // Active buttons, toast
}
```

**To change:** 
- `primary` affects icon colors, active states
- `secondary` is the gradient end color
- `gradient` is used for: active pills, copy toast, logo background

---

### Text Colors
```typescript
// Location: theme.colors.text
text: {
  primary: '#ffffff',      // Main headings, court names
  secondary: '#e4e4e7',    // Entry values, content text (zinc-200)
  muted: '#a1a1aa',        // Labels, secondary info (zinc-400)
  subtle: '#71717a',       // Hints, timestamps (zinc-500)
  disabled: '#52525b',     // Inactive counts, placeholders (zinc-600)
}
```

---

### Section/Category Colors
```typescript
// Location: theme.colors.section
section: {
  emerald: {               // Contacts, Provincial tag
    dot: '#34d399',
    bg: 'rgba(16,185,129,0.15)',
    text: '#34d399',
  },
  blue: {                  // Visits, Region tag
    dot: '#60a5fa',
    bg: 'rgba(59,130,246,0.15)',
    text: '#60a5fa',
  },
  amber: {                 // Sheriff Cells, Callback, Circuit tag
    dot: '#fbbf24',
    bg: 'rgba(245,158,11,0.15)',
    text: '#fbbf24',
  },
  cyan: {                  // eDisclosure, Virtual
    dot: '#22d3ee',
    bg: 'rgba(34,211,238,0.15)',
    text: '#22d3ee',
  },
  indigo: {                // MS Teams
    dot: '#a5b4fc',
    bg: 'rgba(99,102,241,0.15)',
    text: '#a5b4fc',
  },
  purple: {                // Supreme tag, Federal, Support
    dot: '#a78bfa',
    bg: 'rgba(139,92,246,0.15)',
    text: '#a78bfa',
  },
  teal: {                  // Virtual Bail
    dot: '#2dd4bf',
    bg: 'rgba(20,184,166,0.15)',
    text: '#2dd4bf',
  },
}
```

**To change:** Each section has 3 values - the dot color, background tint, and text color. Keep them matching.

---

### Background Effects (Grid + Orbs)
```typescript
// Location: theme.effects
effects: {
  grid: {
    image: 'linear-gradient(rgba(59,130,246,0.06) 1px, transparent 1px), ...',
    size: '40px 40px',     // Grid cell size
    opacity: 0.2,          // Overall grid visibility
  },
  orb1: {                  // Top-right blue/cyan glow
    position: { top: '-150px', right: '-100px' },
    size: { width: '500px', height: '500px' },
    gradient: 'radial-gradient(circle, rgba(59,130,246,0.25) 0%, rgba(6,182,212,0.12) 40%, transparent 70%)',
    blur: '100px',
  },
  orb2: {                  // Bottom-left purple glow
    position: { bottom: '-150px', left: '-100px' },
    size: { width: '400px', height: '400px' },
    gradient: 'radial-gradient(circle, rgba(99,102,241,0.18) 0%, transparent 60%)',
    blur: '100px',
  },
}
```

**To change:**
- `grid.size` - make grid larger/smaller
- `grid.opacity` - make grid more/less visible
- `orb1/orb2.size` - bigger/smaller glow areas
- `orb1/orb2.blur` - sharper/softer edges
- `orb1/orb2.gradient` - change glow colors

---

## 2. UI.TSX - Component Styling

These are the actual components. Change these for layout/spacing adjustments.

### Key Components & What They Control

| Component | Controls | Key Styles |
|-----------|----------|------------|
| `CyberOceanBackground` | Grid + orbs | Uses theme.effects |
| `PageLayout` | Page wrapper | `min-h-screen`, background |
| `StickyHeader` | Top nav bar | `backdrop-blur-md`, border-bottom |
| `Section` | Accordion sections | Border radius, padding, animation |
| `SectionDot` | Colored dots (●) | Font size `text-[6px]` |
| `EntryRow` | Label + value rows | Padding `py-2 px-3`, font sizes |
| `InfoRow` | Label + value (no copy) | Same as EntryRow |
| `CopyButton` | Copy icon button | Size `w-7 h-7` |
| `Tag` | Colored badges | Padding, font size `text-[9px]` |
| `PillButton` | Filter/nav pills | Padding `px-3 py-1.5`, border-radius |
| `Toast` | Copy confirmation | Position `bottom-6`, animation |
| `BackButton` | Back navigation | Font size, gap |
| `PageLabel` | "COURT_DETAIL" etc. | Font size `text-[9px]`, tracking |

### Common Adjustments

**Change section padding:**
```tsx
// In Section component, find:
className="w-full flex items-center gap-2.5 p-3"
// Change p-3 to p-4 for more padding
```

**Change entry row spacing:**
```tsx
// In EntryRow component, find:
className="py-2 px-3"
// Change to py-3 px-4 for more space
```

**Change tag size:**
```tsx
// In Tag component:
const padding = size === 'sm' ? 'px-2 py-0.5' : 'px-2.5 py-1';
const fontSize = size === 'sm' ? 'text-[9px]' : 'text-[10px]';
```

**Change copy button size:**
```tsx
// In CopyButton component:
const sizeClasses = size === 'sm' ? 'w-7 h-7' : 'w-8 h-8';
const iconSize = size === 'sm' ? 'w-3.5 h-3.5' : 'w-4 h-4';
```

---

## 3. Quick Reference - Common Changes

### "I want to change the overall blue tint"
Edit `theme.ts` - search/replace `59,130,246` with new RGB values:
- More purple: `99,102,241`
- More cyan: `6,182,212`
- More green: `16,185,129`

### "I want darker/lighter backgrounds"
Edit `theme.ts` → `colors.bg.primary`:
- Darker: `#050709`
- Lighter: `#0f1420`

### "I want less visible grid"
Edit `theme.ts` → `effects.grid.opacity`:
- Subtle: `0.1`
- Hidden: `0`

### "I want bigger section headers"
Edit `ui.tsx` → `Section` component:
- Find: `fontSize: '10px'`
- Change to: `fontSize: '11px'` or `'12px'`

### "I want more padding in cards"
Edit `ui.tsx` → `Section` component:
- Find: `p-3`
- Change to: `p-4`

### "I want different tag colors for Provincial/Supreme"
Edit the page files directly where `<Tag>` is used:
```tsx
// Provincial currently uses emerald
<Tag color="emerald">PROVINCIAL</Tag>
// Change to:
<Tag color="blue">PROVINCIAL</Tag>
```

---

## 4. Files That Use Theme

| Page | File | Uses |
|------|------|------|
| Main search/results/detail | `/app/page.tsx` | PageLayout, Section, Tag, PillButton, Toast |
| Centre detail | `/app/correctional-centres/[shortName]/page.tsx` | PageLayout, Section, EntryRow, Tag, Toast |
| Centres list | `/app/correctional-centres/page.tsx` | Needs updating |
| Programs | `/app/programs/page.tsx` | Needs updating |

---

## 5. Color Palette Cheat Sheet

```
Background:    #080b12 (dark blue-black)
Card BG:       rgba(59,130,246,0.03) (very subtle blue)
Border:        rgba(59,130,246,0.12) (subtle blue line)

Accent Blue:   #3b82f6
Accent Cyan:   #22d3ee
Gradient:      #3b82f6 → #22d3ee

Emerald:       #34d399 (contacts, provincial)
Blue:          #60a5fa (visits, region)
Amber:         #fbbf24 (cells, callbacks)
Cyan:          #22d3ee (teams virtual)
Indigo:        #a5b4fc (ms teams)
Purple:        #a78bfa (supreme, federal)
Teal:          #2dd4bf (bail)

Text White:    #ffffff
Text Light:    #e4e4e7
Text Muted:    #a1a1aa
Text Subtle:   #71717a
Text Disabled: #52525b
```
