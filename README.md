# BC Legal Directory

A mobile-first web application for BC lawyers to quickly access courthouse, RCMP, correctional facility, and legal service contact information.

## Features

- **90 BC Courts** - All staffed courthouses and circuit courts
- **RCMP & Police Cells** - Coming soon
- **Correctional Facilities** - Coming soon
- **Legal Aid & Services** - Coming soon

## Tech Stack

- **Next.js 15** - React framework
- **Supabase** - PostgreSQL database
- **Tailwind CSS** - Styling
- **TypeScript** - Type safety

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/ayiskane/LLM.git
cd bc-legal-directory
```

### 2. Install dependencies

```bash
npm install
```

### 3. Set up environment variables

Copy `.env.local.example` to `.env.local` and fill in your Supabase credentials:

```bash
cp .env.local.example .env.local
```

Edit `.env.local`:

```
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
```

### 4. Set up the database

Run the SQL files in your Supabase SQL Editor in this order:

1. `supabase-schema.sql` - Creates the tables
2. `bc-courts-complete.sql` - Inserts all 90 BC courts

### 5. Run the development server

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) to view the app.

## Database Schema

### Courts Table

| Column | Type | Description |
|--------|------|-------------|
| id | uuid | Primary key |
| name | text | Court name |
| city | text | City location |
| region | text | Fraser, Interior, North, Vancouver Island, Vancouver Coastal |
| address | text | Full address |
| phone | text | Main phone number |
| fax | text | Fax number |
| sheriff_phone | text | Sheriff's office phone |
| access_code | text | Barrister lounge access code |
| access_code_notes | text | Instructions for access code |
| has_provincial | boolean | Has Provincial Court |
| has_supreme | boolean | Has Supreme Court |
| provincial_contacts | jsonb | Provincial court emails |
| supreme_contacts | jsonb | Supreme court emails |
| is_circuit | boolean | Is a circuit court |
| hub_court_name | text | Parent court for circuit courts |
| notes | text | Additional notes |

## Deployment

### Vercel (Recommended)

1. Push your code to GitHub
2. Import the repository in Vercel
3. Add environment variables in Vercel dashboard
4. Deploy

## License

Private - For use by BC legal professionals.
