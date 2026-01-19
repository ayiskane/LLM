# BC Legal Reference App - Building Recommendations

## Executive Summary

Based on my research, here's the optimal approach to build your legal reference app for BC duty counsel lawyers:

**Recommended Stack:**
- **Framework**: Next.js 14+ (App Router) - You already have this!
- **Database**: Supabase (PostgreSQL) - Already configured
- **Search**: Fuse.js (client-side) + PostgreSQL pg_trgm (server-side)
- **Offline**: PWA with `@ducanh2912/next-pwa`
- **UI**: Tailwind CSS + shadcn/ui components

---

## Why This Stack?

### 1. **Fuse.js for Client-Side Fuzzy Search**
For a legal reference app with ~1,000 records, client-side search is ideal because:
- **Instant results** - No network latency
- **Works offline** - Critical for courthouse use with poor WiFi
- **Typo tolerance** - "Campbel River" → "Campbell River"
- **Lightweight** - ~24KB gzipped

```javascript
// Example Fuse.js configuration
const fuse = new Fuse(allData, {
  keys: [
    { name: 'name', weight: 0.4 },
    { name: 'location', weight: 0.3 },
    { name: 'email', weight: 0.2 },
    { name: 'phone', weight: 0.1 }
  ],
  threshold: 0.3,  // Lower = stricter matching
  includeScore: true,
  minMatchCharLength: 2
});
```

### 2. **PWA for Offline Access**
Lawyers often work in courthouses with poor connectivity. A PWA ensures:
- **App-like experience** - Install on home screen
- **Offline functionality** - All data cached locally
- **Fast loading** - <1 second after first visit
- **No app store needed** - Deploy via web

Use `@ducanh2912/next-pwa` (the maintained fork):
```bash
npm install @ducanh2912/next-pwa
```

### 3. **Supabase for Data Management**
You already have Supabase configured. Benefits:
- **PostgreSQL full-text search** as a backup
- **Real-time updates** when contacts change
- **Row-level security** if needed
- **Easy data management** via dashboard

---

## Recommended Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    User's Device                         │
├─────────────────────────────────────────────────────────┤
│  ┌─────────────────┐    ┌─────────────────────────┐    │
│  │   PWA Shell     │    │   Cached Data (JSON)    │    │
│  │   (Next.js)     │    │   ~220KB compressed     │    │
│  └────────┬────────┘    └────────────┬────────────┘    │
│           │                          │                  │
│           ▼                          ▼                  │
│  ┌─────────────────────────────────────────────────┐   │
│  │              Fuse.js Search Engine               │   │
│  │         (Client-side fuzzy matching)             │   │
│  └─────────────────────────────────────────────────┘   │
│                         │                               │
│                         ▼ (if online)                   │
│  ┌─────────────────────────────────────────────────┐   │
│  │              Service Worker Cache                │   │
│  │         (Offline-first strategy)                 │   │
│  └─────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼ (background sync)
┌─────────────────────────────────────────────────────────┐
│                      Supabase                            │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │    Courts    │  │ Police Cells │  │    Crown     │  │
│  │     (82)     │  │    (106)     │  │   Contacts   │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │  Duty Counsel│  │  Corrections │  │   Programs   │  │
│  │    (262)     │  │     (44)     │  │     (18)     │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
└─────────────────────────────────────────────────────────┘
```

---

## Implementation Steps

### Phase 1: Data Import (1 day)
1. Run `schema.sql` in Supabase SQL Editor
2. Run `import_data.js` to load 1,040 records
3. Verify data in Supabase dashboard

### Phase 2: Search Implementation (2-3 days)
1. Install Fuse.js: `npm install fuse.js`
2. Create a unified search index combining all tables
3. Build search UI with category filters
4. Add "recent searches" and "favorites" features

### Phase 3: PWA Setup (1-2 days)
1. Install `@ducanh2912/next-pwa`
2. Configure service worker for offline caching
3. Create `manifest.json` with app icons
4. Add offline fallback page
5. Test offline functionality

### Phase 4: UI/UX Polish (2-3 days)
1. Time-aware display (daytime vs evening contacts)
2. One-tap copy for phone/email
3. Region filtering
4. Dark mode support
5. Responsive design for phone/tablet/desktop

---

## Key Features to Implement

### 1. Universal Search Bar
```
┌────────────────────────────────────────────┐
│ 🔍 Search courts, contacts, programs...    │
└────────────────────────────────────────────┘
         │
         ▼
┌────────────────────────────────────────────┐
│ 📍 Courts (3 results)                      │
│    • Victoria Provincial Court             │
│    • Victoria Law Courts                   │
│    • Victoria Youth Court                  │
├────────────────────────────────────────────┤
│ 👤 Duty Counsel (2 results)                │
│    • Victoria DC - John Smith              │
│    • Victoria DC - Jane Doe                │
├────────────────────────────────────────────┤
│ 🚔 Police Cells (1 result)                 │
│    • Victoria Police Department            │
└────────────────────────────────────────────┘
```

### 2. Category Quick Access
```
┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐
│  Courts  │ │  Bail    │ │  Police  │ │  Crown   │
│    82    │ │ Contacts │ │  Cells   │ │ Contacts │
└──────────┘ └──────────┘ └──────────┘ └──────────┘
┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐
│Corrections│ │ Programs │ │  LABC   │ │  IJCs    │
│    44    │ │    18    │ │   270+   │ │    10    │
└──────────┘ └──────────┘ └──────────┘ └──────────┘
```

### 3. Smart Contact Card
```
┌────────────────────────────────────────────┐
│ Victoria Provincial Court                   │
│ Region: R1 Island                          │
├────────────────────────────────────────────┤
│ 📧 Crown: VictoriaCrown@gov.bc.ca    [Copy]│
│ 📧 Registry: VicRegistry@gov.bc.ca   [Copy]│
│ 📞 Phone: 250-356-1234               [Call]│
├────────────────────────────────────────────┤
│ 🔗 MS Teams Link                     [Join]│
│ 🔐 Access Code: 1234                 [Copy]│
└────────────────────────────────────────────┘
```

### 4. Time-Aware Bail Contacts
```
┌────────────────────────────────────────────┐
│ 🌅 DAYTIME (8am-5pm)                       │
│ Region1.virtualbail@gov.bc.ca              │
├────────────────────────────────────────────┤
│ 🌙 EVENING (5pm-8am)        [Current]      │
│ VictoriaCrown.Public@gov.bc.ca             │
└────────────────────────────────────────────┘
```

---

## PWA Configuration

### next.config.js
```javascript
const withPWA = require("@ducanh2912/next-pwa").default({
  dest: "public",
  register: true,
  skipWaiting: true,
  disable: process.env.NODE_ENV === 'development',
  cacheOnFrontEndNav: true,
  aggressiveFrontEndNavCaching: true,
  reloadOnOnline: true,
  fallbacks: {
    document: "/offline",
  },
  workboxOptions: {
    disableDevLogs: true,
  },
  runtimeCaching: [
    {
      urlPattern: /^https:\/\/.*\.supabase\.co\/rest\/v1\/.*/i,
      handler: 'StaleWhileRevalidate',
      options: {
        cacheName: 'supabase-api-cache',
        expiration: {
          maxEntries: 50,
          maxAgeSeconds: 60 * 60 * 24 * 7, // 1 week
        },
      },
    },
  ],
});

module.exports = withPWA({
  // Your Next.js config
});
```

### manifest.json
```json
{
  "name": "BC Legal Reference",
  "short_name": "BC Legal",
  "description": "Quick reference for BC duty counsel lawyers",
  "start_url": "/",
  "display": "standalone",
  "background_color": "#ffffff",
  "theme_color": "#1e3a8a",
  "icons": [
    { "src": "/icons/icon-192.png", "sizes": "192x192", "type": "image/png" },
    { "src": "/icons/icon-512.png", "sizes": "512x512", "type": "image/png" }
  ]
}
```

---

## Data Update Strategy

Since contact information changes occasionally:

1. **Background Sync**: When online, check for updates every 24 hours
2. **Version Control**: Store data version in localStorage
3. **Delta Updates**: Only download changed records
4. **Manual Refresh**: Add "Check for updates" button

```javascript
// Check for data updates
const checkForUpdates = async () => {
  const localVersion = localStorage.getItem('dataVersion');
  const { data } = await supabase
    .from('metadata')
    .select('version')
    .single();
  
  if (data.version !== localVersion) {
    await refreshAllData();
    localStorage.setItem('dataVersion', data.version);
  }
};
```

---

## Performance Targets

| Metric | Target |
|--------|--------|
| First Contentful Paint | < 1.5s |
| Time to Interactive | < 3s |
| Search Response Time | < 100ms |
| Offline Availability | 100% |
| Lighthouse PWA Score | 100 |

---

## Cost Estimate

| Item | Cost |
|------|------|
| Supabase (Free tier) | $0/month |
| Vercel Hosting (Free tier) | $0/month |
| Domain (optional) | ~$15/year |
| **Total** | **~$0-15/month** |

---

## Next Steps

1. **Immediate**: Import data into Supabase using provided scripts
2. **Week 1**: Implement Fuse.js search and basic UI
3. **Week 2**: Add PWA capabilities and offline support
4. **Week 3**: Polish UI, add favorites, test thoroughly
5. **Week 4**: Deploy and gather feedback from lawyers

Would you like me to start implementing any of these features?
