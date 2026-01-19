-- BC Legal Reference Database - Complete Data Import
-- Generated: 2025-01-19
-- Total Records: 1,040
-- 
-- HOW TO USE:
-- 1. Go to your Supabase Dashboard
-- 2. Click on "SQL Editor" in the left sidebar
-- 3. Create a new query
-- 4. Paste this entire file
-- 5. Click "Run" to execute
--
-- This will:
-- - Create all necessary tables (if they don't exist)
-- - Clear existing data
-- - Import all 1,040 records

-- ============================================
-- ENABLE EXTENSIONS
-- ============================================
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";  -- For fuzzy search

-- ============================================
-- CREATE TABLES
-- ============================================

-- Courts & Crown Contacts
CREATE TABLE IF NOT EXISTS courts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    region VARCHAR(50),
    crown_email VARCHAR(255),
    jcm_scheduling_email VARCHAR(255),
    court_registry_email VARCHAR(255),
    criminal_registry_email VARCHAR(255),
    bail_crown_email VARCHAR(255),
    bail_jcm_email VARCHAR(255),
    interpreter_request_email VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Police Cells
CREATE TABLE IF NOT EXISTS police_cells (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    region VARCHAR(50),
    phone1 VARCHAR(50),
    phone2 VARCHAR(50),
    phone3 VARCHAR(50),
    phone4 VARCHAR(50),
    notes TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Correctional Facilities
CREATE TABLE IF NOT EXISTS correctional_facilities (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(50),
    region VARCHAR(50),
    phone VARCHAR(50),
    fax VARCHAR(50),
    email VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Bail Contacts
CREATE TABLE IF NOT EXISTS bail_contacts (
    id SERIAL PRIMARY KEY,
    region VARCHAR(10) NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    type VARCHAR(50),
    notes TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Bail Coordinators (RABCs)
CREATE TABLE IF NOT EXISTS bail_coordinators (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    region VARCHAR(100) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(50),
    is_backup BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Crown Contacts
CREATE TABLE IF NOT EXISTS crown_contacts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    region VARCHAR(50),
    court VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(50),
    mobile VARCHAR(50),
    role VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW()
);

-- LABC Offices
CREATE TABLE IF NOT EXISTS labc_offices (
    id SERIAL PRIMARY KEY,
    location VARCHAR(255),
    region VARCHAR(50),
    type VARCHAR(50),
    phone VARCHAR(100),
    email VARCHAR(255),
    hours TEXT,
    local_agent VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW()
);

-- LABC Navigators
CREATE TABLE IF NOT EXISTS labc_navigators (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(50),
    email VARCHAR(255),
    courts TEXT,
    spare_for TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Duty Counsel Lawyers
CREATE TABLE IF NOT EXISTS duty_counsel_lawyers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    labc_id VARCHAR(20),
    email VARCHAR(255),
    phone VARCHAR(50),
    location VARCHAR(255),
    region VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Forensic Clinics
CREATE TABLE IF NOT EXISTS forensic_clinics (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address TEXT,
    city VARCHAR(100),
    phone VARCHAR(50),
    email VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Indigenous Justice Centres
CREATE TABLE IF NOT EXISTS indigenous_justice_centres (
    id SERIAL PRIMARY KEY,
    location VARCHAR(255) NOT NULL,
    phone VARCHAR(50),
    email VARCHAR(255),
    website VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW()
);

-- MS Teams Links
CREATE TABLE IF NOT EXISTS ms_teams_links (
    id SERIAL PRIMARY KEY,
    court VARCHAR(255),
    courtroom VARCHAR(50),
    region VARCHAR(50),
    conference_id VARCHAR(50),
    phone VARCHAR(50) DEFAULT '+1 778-725-6348',
    toll_free VARCHAR(50) DEFAULT '(844) 636-7837',
    created_at TIMESTAMP DEFAULT NOW()
);

-- Programs
CREATE TABLE IF NOT EXISTS programs (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    phone VARCHAR(50),
    gender VARCHAR(50),
    indigenous_only BOOLEAN DEFAULT FALSE,
    in_residence BOOLEAN DEFAULT FALSE,
    application_by VARCHAR(255),
    notes TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Access Codes
CREATE TABLE IF NOT EXISTS access_codes (
    id SERIAL PRIMARY KEY,
    court VARCHAR(255) NOT NULL,
    code VARCHAR(50),
    notes TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Circuit Courts
CREATE TABLE IF NOT EXISTS circuit_courts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    region VARCHAR(50),
    contact_hub VARCHAR(255),
    schedule TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- ============================================
-- CREATE INDEXES FOR SEARCH
-- ============================================

CREATE INDEX IF NOT EXISTS idx_courts_name ON courts(name);
CREATE INDEX IF NOT EXISTS idx_courts_name_trgm ON courts USING gin (name gin_trgm_ops);
CREATE INDEX IF NOT EXISTS idx_police_cells_name ON police_cells(name);
CREATE INDEX IF NOT EXISTS idx_police_cells_name_trgm ON police_cells USING gin (name gin_trgm_ops);
CREATE INDEX IF NOT EXISTS idx_dc_lawyers_name ON duty_counsel_lawyers(name);
CREATE INDEX IF NOT EXISTS idx_dc_lawyers_name_trgm ON duty_counsel_lawyers USING gin (name gin_trgm_ops);

-- ============================================
-- INSERT DATA
-- ============================================


-- COURTS: 82 records
TRUNCATE TABLE courts RESTART IDENTITY CASCADE;
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('100 Mile House', 'WilliamsLake.Crown@gov.bc.ca', 'Cariboo.Scheduling@provincialcourt.bc.ca', 'Office15231@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Abbotsford (Provincial)', 'BCPS.Abbotsford.Reception@gov.bc.ca', 'Abbotsford.CriminalScheduling@provincialcourt.bc.ca', NULL, 'AbbotsfordCriminalRegistry@gov.bc.ca', 'Abbotsford.VirtualBail@gov.bc.ca', 'Abbotsford.VirtualHybridBail@provincialcourt.bc.ca', 'Tina.Nguyen@gov.bc.ca
Sheila.Hedd@gov.bc.ca
Damaris.Stanciu@gov.bc.ca');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Abbotsford (Supreme)', NULL, 'sc.scheduling_ab@bccourts.ca', NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Burns Lake (Provincial)', 'Smithers.Crown@gov.bc.ca', 'Smithers.Scheduling@provincialcourt.bc.ca', 'Office15219@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Campbell River (Provincial)', 'CampbellRiver.CrownSchedule@gov.bc.ca', 'CampbellRiver.Scheduling@provincialcourt.bc.ca', 'CampbellRiverRegistry@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Campbell River (Supreme)', NULL, 'sc.scheduling_na@bccourts.ca', NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Cariboo', NULL, 'Cariboo.Scheduling@provincialcourt.bc.ca', NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Chilliwack (Provincial)', 'BCPS.Chilliwack.Reception@gov.bc.ca', 'Chilliwack.Scheduling@provincialcourt.bc.ca', NULL, 'CSBChilliwackCriminalRegistry@gov.bc.ca', 'Chilliwack.VirtualBail@gov.bc.ca', 'Abbotsford.VirtualHybridBail@provincialcourt.bc.ca', NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Chilliwack (Supreme)', NULL, 'sc.scheduling_cw@bccourts.ca', '[Fax Filing: 604-795-8397]', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Colwood/Western Communities', 'Colwood.Crown@gov.bc.ca', 'WestComm.CriminalScheduling@provincialcourt.bc.ca', 'wccregistry@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Courtenay (Provincial)', 'Courtenay.CrownSchedule@gov.bc.ca', 'Courtenay.Scheduling@provincialcourt.bc.ca', 'CourtenayRegistry@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Courtenay (Supreme)', NULL, 'sc.scheduling_na@bccourts.ca', NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Cranbrook (Provincial)', 'BCPS.CranbrookGen@gov.bc.ca', 'EKootenays.Scheduling@provincialcourt.bc.ca', 'cranbrookcourtregistry@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Cranbrook (Supreme)', NULL, 'sc.scheduling_ka@bccourts.ca', '[Fax Filing: 250-426-1498]', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Criminal Appeals & Special Prosecutions', 'BCPS.CASPGen@gov.bc.ca', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Dawson Creek (Provincial)', 'DawsonCreek.CrownCounsel@gov.bc.ca', 'PeaceDistrict.CriminalScheduling@provincialcourt.bc.ca', 'office15226@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Dawson Creek (Supreme)', NULL, 'sc.scheduling_pg@bccourts.ca', '[Fax Filing: 250-784-2218]', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Duncan (Provincial)', 'BCPS.Duncan.Reception@gov.bc.ca', 'Dun.Scheduling@provincialcourt.bc.ca', 'JAGCSBDuncanCourtScheduling@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Duncan (Supreme)', NULL, 'sc.scheduling_na@bccourts.ca', NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('East Kootenays', NULL, 'EKootenays.Scheduling@provincialcourt.bc.ca', NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Federal Crown (General)', 'VAN.Detention.VAN@ppsc-sppc.gc.ca', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Federal Crown (Prince George)', 'susan@luckylaw.ca', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('First Nations Court (New West)', 'Lena.DalSanto@gov.bc.ca', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Fort Nelson', 'FortNelson.Crown@gov.bc.ca', 'Terrace.CriminalScheduling@provincialcourt.bc.ca', 'Office15229@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Fort St. John (Provincial)', 'FtStJohn.Crown@gov.bc.ca', 'PeaceDistrict.CriminalScheduling@provincialcourt.bc.ca', 'Office15228@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Fort St. John (Supreme)', NULL, 'sc.scheduling_pg@BCCourts.ca', NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Golden (Provincial)', 'BCPS.CranbrookGen@gov.bc.ca', 'EKootenays.Scheduling@provincialcourt.bc.ca', 'GoldenCourtRegistry@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Golden (Supreme)', NULL, 'sc.scheduling_ka@bccourts.ca', NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Kamloops (Provincial)', 'BCPS.KamloopsGen@gov.bc.ca', 'Kamloops.Scheduling@provincialcourt.bc.ca', 'KamloopsCourtRegistry@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Kamloops (Supreme)', NULL, 'sc.scheduling_ka@bccourts.ca', '[Fax Filing: 250-828-4345]', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Kelowna (Provincial)', 'KelownaCrown@gov.bc.ca', 'Kelowna.CriminalScheduling@provincialcourt.bc.ca', 'KelownaCourtRegistry@gov.bc.ca', 'CSB.KelownaCriminal@gov.bc.ca', NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Kelowna (Supreme)', NULL, 'sc.scheduling_ok@bccourts.ca', '[Fax Filing: 250-979-6768]', 'CSB.KelownaSupreme@gov.bc.ca', NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('MacKenzie', NULL, NULL, 'Office15216@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Nanaimo (Provincial)', 'Nanaimo.CrownSchedule@gov.bc.ca', 'Nanaimo.Scheduling@provincialcourt.bc.ca', NULL, 'crimreg.nanaimo@gov.bc.ca', NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Nanaimo (Supreme)', NULL, 'sc.scheduling_na@bccourts.ca', NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Nelson (Provincial)', 'BCPS.NelsonGen@gov.bc.ca', 'WKootenays.Scheduling@provincialcourt.bc.ca', 'NelsonCourtRegistry@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Nelson (Supreme)', NULL, 'sc.scheduling_ka@bccourts.ca', '[Fax Filing: 250-354-6133]', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('New Westminster (Provincial)', 'NewWestminsterProvincial@gov.bc.ca', 'NewWest.Scheduling@provincialcourt.bc.ca', 'JAGCSBNWestminsterCourtScheduling@gov.bc.ca', NULL, 'NewWestProv.VirtualBail@gov.bc.ca', NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('New Westminster (Supreme)', 'CJB.NewWestRegionalCrown@gov.bc.ca', 'sc.scheduling_nw@BCCourts.ca', NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('North Vancouver', 'NorthVanCrown@gov.bc.ca', 'NVan.Scheduling@provincialcourt.bc.ca', 'NorthVancouverRegistry@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Peace District', NULL, 'Peace.District.Scheduling@provincialcourt.bc.ca', NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Penticton (Provincial)', 'BCPS.PentictonGen@gov.bc.ca', 'Penticton.Scheduling@provincialcourt.bc.ca', 'PentictonCourtRegistry@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Penticton (Supreme)', NULL, 'sc.scheduling_ok@bccourts.ca', '[Fax Filing: 250-492-1290]', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Port Alberni (Provincial)', 'PtAlberni.CrownSchedule@gov.bc.ca', 'PortAlberni.Scheduling@provincialcourt.bc.ca', 'PortAlberniRegistry@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Port Alberni (Supreme)', NULL, 'sc.scheduling_na@bccourts.ca', NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Port Coquitlam (Provincial)', 'Poco.Crown@gov.bc.ca', 'PoCo.Scheduling@provincialcourt.bc.ca', NULL, 'csb.portcoquitlamprovcriminal@gov.bc.ca', 'Poco.VirtualBail@gov.bc.ca', 'Poco.VirtualHybridBail@provincialcourt.bc.ca', NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Port Coquitlam (Supreme)', NULL, 'sc.scheduling_pc@bccourts.ca', NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Port Hardy', 'PortHardy.CrownSchedule@gov.bc.ca', 'PortHardy.Scheduling@provincialcourt.bc.ca', 'porthardycourtregistry@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Powell River (Provincial)', 'PowellRiver.CrownSchedule@gov.bc.ca', 'PowellRiver.Scheduling@provincialcourt.bc.ca', 'powellriverregistry@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Powell River (Supreme)', NULL, 'sc.scheduling_na@bccourts.ca', NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Prince George (Provincial)', 'PrGeorge.crown@gov.bc.ca', 'PG.Scheduling@provincialcourt.bc.ca', NULL, 'csbpg.criminalregistry@gov.bc.ca', NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Prince George (Supreme)', NULL, 'sc.scheduling_pg@bccourts.ca', '[Fax Filing: 250-614-7923]', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Prince Rupert (Provincial)', 'PrinceRupert.Crown@gov.bc.ca', 'PrinceRupert.Scheduling@provincialcourt.bc.ca', 'Office15220@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Prince Rupert (Supreme)', NULL, 'sc.scheduling_pg@bccourts.ca', NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Quesnel (Provincial)', 'Quesnel.Crown@gov.bc.ca', 'Cariboo.Scheduling@provincialcourt.bc.ca', 'Office15230@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Quesnel (Supreme)', NULL, 'sc.scheduling_pg@bccourts.ca', NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Revelstoke (Supreme)', 'BCPS.SalmonArmGen@gov.bc.ca', 'sc.scheduling_ka@bccourts.ca', NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Richmond (Provincial)', 'RichmondCrown@gov.bc.ca', 'Richmond.Scheduling@provincialcourt.bc.ca', 'RichmondCourtRegistry@gov.bc.ca', NULL, NULL, NULL, 'AGCSBRichmondInterpreters@gov.bc.ca');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Richmond (Federal)', 'ppscsupportstaff@mtclaw.ca', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Rossland (Provincial)', 'BCPS.NelsonGen@gov.bc.ca', 'WKootenays.Scheduling@provincialcourt.bc.ca', 'VCRosslandCrt@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Rossland (Supreme)', NULL, 'sc.scheduling_ka@bccourts.ca', '[Fax Filing: 250-362-7321]', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Salmon Arm (Provincial)', 'BCPS.SalmonArmGen@gov.bc.ca', 'SalmonArm.Scheduling@provincialcourt.bc.ca', 'SalmonArmRegistry@gov.bc.ca', 'JAGCSBSalmonArmScheduling@gov.bc.ca', NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Salmon Arm (Supreme)', NULL, 'sc.scheduling_ka@bccourts.ca', '[Fax Filing: 250-833-7401]', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Sechelt', 'SecheltCrown@gov.bc.ca', 'NVan.Scheduling@provincialcourt.bc.ca', 'SecheltRegistry@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Smithers (Provincial)', 'Smithers.Crown@gov.bc.ca', 'Smithers.Scheduling@provincialcourt.bc.ca', 'Office15224@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Smithers (Supreme)', NULL, 'sc.scheduling_pg@bccourts.ca', '[Fax Filing: 250-847-7344]', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Surrey', 'Surrey.Intake@gov.bc.ca', 'Surrey.Scheduling@provincialcourt.bc.ca', NULL, 'CSBSurreyProvincialCourt.CriminalRegistry@gov.bc.ca', 'Surrey.VirtualBail@gov.bc.ca', 'Surrey.CriminalScheduling@provincialcourt.bc.ca', 'CSBSurreyProvincialCourt.AccountingandInterpreters@gov.bc.ca');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Surrey (Federal)', 'ppsc.surreyincustody-endetentionsurrey.sppc@ppsc-sppc.gc.ca', NULL, NULL, NULL, 'PPSC.SurreyInCustody-EnDetentionSurrey.SPPC@ppsc-sppc.gc.ca', NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Terrace (Provincial)', 'Terrace.Crown@gov.bc.ca', 'Terrace.Scheduling@provincialcourt.bc.ca', 'Office15222@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Terrace (Supreme)', NULL, 'sc.scheduling_pg@bccourts.ca', '[Fax Filing: 250-638-2143]', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Valemount', 'PrGeorge.crown@gov.bc.ca', 'PG.Scheduling@provincialcourt.bc.ca', 'Office15215@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Vancouver 222 Main Street & DCC', '222MainCrownGeneral@gov.bc.ca', 'Van.Scheduling@provincialcourt.bc.ca', '222MainCS@gov.bc.ca
222MainTranscripts@gov.bc.ca', NULL, NULL, NULL, 'CSB222.InterpreterRequests@gov.bc.ca');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Vancouver Law Courts (Supreme)', 'VancouverRegionalCrown@gov.bc.ca', 'sc.criminal_va@BCcourts.ca', 'VancouverLawCourtsRegistry@gov.bc.ca', 'Vlc.criminal@gov.bc.ca', NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Vancouver Youth (Robson)', 'VancouverYouthCrown@gov.bc.ca', 'Robson.Scheduling@provincialcourt.bc.ca', 'CSBRCS@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Vanderhoof', 'Vanderhoof.Crown@gov.bc.ca', 'PG.Scheduling@provincialcourt.bc.ca', NULL, 'csbpg.criminalregistry@gov.bc.ca', NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Vernon (Provincial)', 'BCPS.VernonGen@gov.bc.ca', 'Vernon.Scheduling@provincialcourt.bc.ca', 'VernonRegistry@gov.bc.ca', 'JAGCSBVernonScheduling@gov.bc.ca', NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Vernon (Supreme)', NULL, 'sc.scheduling_ok@bccourts.ca', '[Fax Filing: 250-549-5461]', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Victoria (Provincial)', 'VictoriaCrown.Public@gov.bc.ca', 'Vic.Scheduling@provincialcourt.bc.ca', NULL, 'vicprovincialreg@gov.bc.ca', NULL, NULL, 'victoria.finance@gov.bc.ca');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Victoria (Supreme)', NULL, 'sc.scheduling_vi@bccourts.ca', NULL, 'vicsupremereg@gov.bc.ca', NULL, NULL, 'victoria.finance@gov.bc.ca');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('West Kootenays', NULL, 'WKootenays.Scheduling@provincialcourt.bc.ca', NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Williams Lake (Provincial)', 'WilliamsLake.Crown@gov.bc.ca', 'Cariboo.Scheduling@provincialcourt.bc.ca', 'Office15231@gov.bc.ca', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Williams Lake (Supreme)', NULL, 'sc.scheduling_pg@bccourts.ca', '[Fax Filing: 250-398-4264]', NULL, NULL, NULL, NULL);

-- POLICE_CELLS: 106 records
TRUNCATE TABLE police_cells RESTART IDENTITY CASCADE;
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('100 Mile House RCMP', '7783329565.0', '7783329520.0', '2503952456.0', NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Abbotsford CH', '6048553239.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Abbotsford PD', '6048644773.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Agassiz RCMP', '6047961618.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Alexis Creek RCMP', '2503944632.0', '2503944683.0', '2503944211.0', NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Anahim Lake RCMP', '2507423214.0', '2507423509.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Armstrong RCMP', '2505463822.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Ashcroft RCMP', '2504532217.0', '2504532216.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Atlin RCMP', '2506517511.0', '2506517693.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Barriere RCMP', '2506729919.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Bella Bella RCMP', '2509572389.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Bella Coola RCMP', '2507995374.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Burnaby RCMP', '6046469633.0', '6046469986.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Burnaby YDC', '7784522050.0', '7784522051.0', '7784522110.0', '7784522111.0');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Burns Lake RCMP', '2506927171.0', '2506923905.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Castlegar RCMP', '2503653272.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Chase RCMP', '2506793912.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Chetwynd RCMP', '2507888181.0', '2507889221.0', '2507889111.0', NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Chilliwack CH', '6047958328.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Chilliwack RCMP', '6047024199.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Clearwater RCMP', '2506742100.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Clinton RCMP', '2504592203.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Columbia Valley RCMP', '2503426266.0', '2503426769.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Coquitlam RCMP', '6049451565.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Cranbrook RCMP', '2504174207.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Creston RCMP', '2504280960.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Dawson Creek RCMP', '2507843715.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Dease Lake RCMP', '2507714603.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Duncan RCMP', '2507462109.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Elk Valley (Elkford, Fernie, Sparwood) RCMP', '2504252296.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Enderby RCMP', '2508389397.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Federal Crown In-Custody Clerk', '6046662141.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Federal Crown Office', '6046663033.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Fort Nelson RCMP', '2507744980.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Fort St. James RCMP', '2509968269.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Fort St. John RCMP', '2507878124.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Fraser Lake RCMP', '2506996215.0', '2506997777.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Golden RCMP', '2503444000.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Grand Forks RCMP', '2504423919.0', '2504428566.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Houston RCMP', '2508452868.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Hudson’s Hope RCMP', '2507835242.0', '2507839480.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Justice Centre', '6046604134.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Kamloops RCMP', '2508283094.0', '2508283270.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Kaslo RCMP', '2503532242.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Kelowna CH', '2504706841.0', '2504706816.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Kelowna RCMP', '2504706297.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Keremeos RCMP', '2504992500.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Kitimat RCMP', '2506392115.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Klemtu RCMP', '2508391247.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Langley RCMP', '6045323202.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Lillooet RCMP', '2502564722.0', '2502564244.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Lisims/Nass Valley RCMP', '2506332230.0', '2506332222.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Logan Lake RCMP', '2505236222.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Mackenzie RCMP', '2509973447.0', '2506263991.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Masset RCMP', '2506263697.0', '2506263991.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('McBride RCMP', '2505692255.0', '2505692260.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Merritt RCMP', '2503154623.0', '2503784262.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Midway RCMP', '2504428566.0', '2504423919.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Mission RCMP', '6048203543.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('New Hazelton RCMP', '2508424835.0', '2508425244.0', '2508426351.0', NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('New West CH', '6046608545.0', '6046608543.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('New Westminster PD', '6045292469.0', '6045292470.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('North Vancouver CH', '6049810236.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('North Vancouver RCMP', '6049697487.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Pemberton RCMP', '6048946127.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Penticton RCMP', '2507704719.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('POCO CH', '6049272195.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('POCO RCMP', '6049451565.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Port Moody PD', '6049371325.0', '6049371333.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Prince George CH', '2367650633.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Prince George RCMP', '2502778950.0', '2505613300.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Prince Rupert RCMP', '2506270755.0', '2506270700.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Queen Charlotte RCMP', '2505594421.0', '2505594268.0', '2505594785.0', NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Quesnel/Wells RCMP', '2509920500.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Richmond CH', '6046603467.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Richmond RCMP', '6042074894.0', '6042074785.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Ridge Meadows RCMP', '6044677680.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Saanich RCMP', '2504754270.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Smithers RCMP', '2508473233.0', '2508470238.0', '2508764034.0', NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Squamish RCMP', '6048926124.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Stewart RCMP', '2506362865.0', '2508764034.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Sunshine Coast RCMP', '6047403204.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Surrey CH', '6045722270.0', '6045722156.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Surrey RCMP', '6045997765.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Takla Landing RCMP', '2509968574.0', '2509967847.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Terrace CH', '2506382121.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Terrace RCMP', '2506387431.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Tsay Keh Dene RCMP', '2509930000.0', '2509930001.0', '2509932185.0', NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Tumbler Ridge RCMP', '2502425648.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('UFVRD/Hope/Boston Bar RCMP', '6048697772.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('University RCMP', '6042246981.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Valemount RCMP', '2505664457.0', '2505664466.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Vancouver 222 Cr 101', '6047752506.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Vancouver 222 Cr 102', '6047752508.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Vancouver 222 Sheriffs', '6047752522.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Vancouver PD', '6047179966.0', '6047173958.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Vancouver Youth', '6046608870.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Vanderhoof RCMP', '2505679228.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Vernon CH', '2502607185.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Victoria CH', '2503876571.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Victoria/Sechelt RCMP', '2504754321.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Watson Lake, Yukon Territory/Lower Post BC', '8675362677.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('West Vancouver PD', '6049277308.0', '6049257306.0', NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Whistler RCMP', '6048946127.0', '6049051966.0', '6049320568.0', NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('White Rock RCMP', '7785454780.0', NULL, NULL, NULL);
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Williams Lake RCMP', '2503928728.0', '2503928737.0', NULL, NULL);

-- CORRECTIONAL_FACILITIES: 44 records
TRUNCATE TABLE correctional_facilities RESTART IDENTITY CASCADE;
INSERT INTO correctional_facilities (name, type) VALUES ('*** CALL CINDY TO REGISTER AS LAWYER FOR BC CORRECTIONS:', 'provincial');
INSERT INTO correctional_facilities (name, type) VALUES ('Name', 'provincial');
INSERT INTO correctional_facilities (name, type) VALUES ('ACCW (General)', 'provincial');
INSERT INTO correctional_facilities (name, type) VALUES ('ACCW (Visit Request)', 'federal');
INSERT INTO correctional_facilities (name, type) VALUES ('ACCW (CDN)', 'provincial');
INSERT INTO correctional_facilities (name, type) VALUES ('FMCC (General)', 'provincial');
INSERT INTO correctional_facilities (name, type) VALUES ('FMCC (Visit Request)', 'federal');
INSERT INTO correctional_facilities (name, type) VALUES ('Fraser Valley Institution', 'federal');
INSERT INTO correctional_facilities (name, type) VALUES ('FRCC (General)', 'provincial');
INSERT INTO correctional_facilities (name, type) VALUES ('FRCC (Visit Request)', 'federal');
INSERT INTO correctional_facilities (name, type) VALUES ('Kent Institution', 'provincial');
INSERT INTO correctional_facilities (name, type) VALUES ('Kent Institution (Visit Request)', 'federal');
INSERT INTO correctional_facilities (name, type) VALUES ('KRCC (General)', 'provincial');
INSERT INTO correctional_facilities (name, type) VALUES ('KRCC (Visit Request)', 'federal');
INSERT INTO correctional_facilities (name, type) VALUES ('KRCC (Virtual Visits)', 'federal');
INSERT INTO correctional_facilities (name, type) VALUES ('KRCC (CDN)', 'provincial');
INSERT INTO correctional_facilities (name, type) VALUES ('Matsqui Institution', 'federal');
INSERT INTO correctional_facilities (name, type) VALUES ('Mission Institution (Medium)', 'federal');
INSERT INTO correctional_facilities (name, type) VALUES ('Mission Institution (Minimum)', 'federal');
INSERT INTO correctional_facilities (name, type) VALUES ('Mountain Institution', 'federal');
INSERT INTO correctional_facilities (name, type) VALUES ('NCC (General)', 'provincial');
INSERT INTO correctional_facilities (name, type) VALUES ('NCC (Visit Request)', 'federal');
INSERT INTO correctional_facilities (name, type) VALUES ('NCC (CDN)', 'provincial');
INSERT INTO correctional_facilities (name, type) VALUES ('NFPC (General)', 'provincial');
INSERT INTO correctional_facilities (name, type) VALUES ('NFPC (Visit Request)', 'federal');
INSERT INTO correctional_facilities (name, type) VALUES ('NFPC (CDN)', 'provincial');
INSERT INTO correctional_facilities (name, type) VALUES ('OCC (General)', 'provincial');
INSERT INTO correctional_facilities (name, type) VALUES ('OCC (Visit Request)', 'federal');
INSERT INTO correctional_facilities (name, type) VALUES ('OCC (CDN)', 'provincial');
INSERT INTO correctional_facilities (name, type) VALUES ('Pacific Institution', 'federal');
INSERT INTO correctional_facilities (name, type) VALUES ('PGRCC (General)', 'provincial');
INSERT INTO correctional_facilities (name, type) VALUES ('PGRCC (Virtual Visit)', 'federal');
INSERT INTO correctional_facilities (name, type) VALUES ('PGRCC (Visit Request)', 'federal');
INSERT INTO correctional_facilities (name, type) VALUES ('PGRCC (Records - for VB)', 'federal');
INSERT INTO correctional_facilities (name, type) VALUES ('PGRCC (CDN)', 'provincial');
INSERT INTO correctional_facilities (name, type) VALUES ('SPSC (General)', 'provincial');
INSERT INTO correctional_facilities (name, type) VALUES ('SPSC (Lawyer Callback Request)', 'federal');
INSERT INTO correctional_facilities (name, type) VALUES ('SPSC (Virtual Visit)', 'federal');
INSERT INTO correctional_facilities (name, type) VALUES ('SPSC (Visit Request)', 'federal');
INSERT INTO correctional_facilities (name, type) VALUES ('SPSC (CDN)', 'provincial');
INSERT INTO correctional_facilities (name, type) VALUES ('VIRCC (General)', 'provincial');
INSERT INTO correctional_facilities (name, type) VALUES ('VIRCC (Visit Request)', 'federal');
INSERT INTO correctional_facilities (name, type) VALUES ('VIRCC (CDN)', 'provincial');
INSERT INTO correctional_facilities (name, type) VALUES ('William Head Institution', 'federal');

-- BAIL_CONTACTS: 7 records
TRUNCATE TABLE bail_contacts RESTART IDENTITY CASCADE;
INSERT INTO bail_contacts (region, name, email, type, notes) VALUES ('R1', 'Region 1 Virtual Bail', 'Region1.virtualbail@gov.bc.ca', 'daytime', NULL);
INSERT INTO bail_contacts (region, name, email, type, notes) VALUES ('R1', 'Victoria Crown', 'VictoriaCrown.Public@gov.bc.ca', 'evening', NULL);
INSERT INTO bail_contacts (region, name, email, type, notes) VALUES ('R2', '222 Main Crown Bail', '222MainCrownBail@gov.bc.ca', 'daytime', NULL);
INSERT INTO bail_contacts (region, name, email, type, notes) VALUES ('R3', 'Abbotsford Virtual Bail', 'Abbotsford.VirtualBail@gov.bc.ca', 'daytime', NULL);
INSERT INTO bail_contacts (region, name, email, type, notes) VALUES ('R3', 'Chilliwack Virtual Bail', 'Chilliwack.VirtualBail@gov.bc.ca', 'daytime', NULL);
INSERT INTO bail_contacts (region, name, email, type, notes) VALUES ('R4', 'Region 4 Virtual Bail', 'Region4.virtualbail@gov.bc.ca', 'daytime', NULL);
INSERT INTO bail_contacts (region, name, email, type, notes) VALUES ('R5', 'Region 5 Virtual Bail', 'Region5.virtualbail@gov.bc.ca', 'all_hours', NULL);

-- BAIL_COORDINATORS: 4 records
TRUNCATE TABLE bail_coordinators RESTART IDENTITY CASCADE;
INSERT INTO bail_coordinators (name, region, email, phone, is_backup) VALUES ('Chloe Rathjen', 'R1 Island', 'chloe.rathjen@gov.bc.ca', '250-940-8522', NULL);
INSERT INTO bail_coordinators (name, region, email, phone, is_backup) VALUES ('Pamela Robertson', 'R4 Interior', 'pamela.robertson@gov.bc.ca', '778-940-0050', NULL);
INSERT INTO bail_coordinators (name, region, email, phone, is_backup) VALUES ('Angie Fryer', 'R4 Interior (Backup)', 'angie.fryer@gov.bc.ca', '250-312-511', NULL);
INSERT INTO bail_coordinators (name, region, email, phone, is_backup) VALUES ('Jacqueline Ettinger', 'R5 North', 'jacqueline.ettinger@gov.bc.ca', '250-570-0422', NULL);

-- CROWN_CONTACTS: 10 records
TRUNCATE TABLE crown_contacts RESTART IDENTITY CASCADE;
INSERT INTO crown_contacts (name, region, email, phone) VALUES ('Jennifer Watkins', 'R1_daytime', 'jennifer.watkins@gov.bc.ca', '250-739-8644');
INSERT INTO crown_contacts (name, region, email, phone) VALUES ('Rebecca Sutherland', 'R1_daytime', 'rebecca.sutherland@gov.bc.ca', '778-974-5159');
INSERT INTO crown_contacts (name, region, email, phone) VALUES ('Custody
Bryan Pankoff', 'R4_daytime', 'bryan.pankoff@gov.bc.ca', '250-505-8081');
INSERT INTO crown_contacts (name, region, email, phone) VALUES ('Izabel Bonilla', 'R4_daytime', 'izabel.bonilla@gov.bc.ca', '778-943-7129');
INSERT INTO crown_contacts (name, region, email, phone) VALUES ('Winona Yeung', 'R4_daytime', 'winona.yeung@gov.bc.ca', '236-766-7004');
INSERT INTO crown_contacts (name, region, email, phone) VALUES ('Cecilia Mayer', 'R4_daytime', 'cecilia.mayer@gov.bc.ca', '236-455-4397');
INSERT INTO crown_contacts (name, region, email, phone) VALUES ('Remand
Garry Hansen', 'R4_daytime', 'garry.hansen@gov.bc.ca', '250-487-4463');
INSERT INTO crown_contacts (name, region, email, phone) VALUES ('Custody
Bonnie Macdonald', 'R4_daytime', 'bonnie.macdonald@gov.bc.ca', '250-371-7624 250-312-6522');
INSERT INTO crown_contacts (name, region, email, phone) VALUES ('Robyn Sampson', 'R4_daytime', 'robyn.sampson@gov.bc.ca', '778-362-4993');
INSERT INTO crown_contacts (name, region, email, phone) VALUES ('Marie Lafrance', 'R4_daytime', 'marie.lafrance@gov.bc.ca', '250-312-6519');

-- LABC_OFFICES: 11 records
TRUNCATE TABLE labc_offices RESTART IDENTITY CASCADE;
INSERT INTO labc_offices (location, type, phone, email, hours) VALUES ('Dawson Creek', 'intake', '250-782-7366', 'Intake.DawsonCreek@legalaid.bc.ca', 'Mon,Tue,Thurs: 8:30am-12pm, 1pm-3:30pm');
INSERT INTO labc_offices (location, type, phone, email, hours) VALUES ('Fort St James', 'intake', '1-866-614-6999', 'Intake.Vanderhoof.FtStJames@legalaid.bc.ca', 'Alternating Mondays 9am-4pm');
INSERT INTO labc_offices (location, type, phone, email, hours) VALUES ('Fort St John', 'intake', '250-785-8089', 'Intake.FtStJohn@legalaid.bc.ca', 'Mon,Wed: 8:30am-12pm, 1pm-4:30pm');
INSERT INTO labc_offices (location, type, phone, email, hours) VALUES ('Hazelton', 'intake', '250-842-5218', 'Intake.Hazelton@legalaid.bc.ca', 'Mon,Wed,Thurs: 9am-12pm, 1pm-4pm');
INSERT INTO labc_offices (location, type, phone, email, hours) VALUES ('Prince George', 'intake', '250-564-9717', 'Intake.PrinceGeorge@legalaid.bc.ca', 'Mon-Thurs: 9am-12:30pm, 1:30pm-4pm');
INSERT INTO labc_offices (location, type, phone, email, hours) VALUES ('Prince Rupert', 'intake', '250-627-7788', 'Intake.PrinceRupert@legalaid.bc.ca', 'Mon,Tue,Wed: 8:30am-12pm, 1pm-4:30pm');
INSERT INTO labc_offices (location, type, phone, email, hours) VALUES ('Vanderhoof', 'intake', '250-567-2800', 'Intake.Vanderhoof.FtStJames@legalaid.bc.ca', 'Mon-Fri: 8:30am-12:30pm, 1:30pm-5:30pm');
INSERT INTO labc_offices (location, type, phone, email, hours) VALUES ('Williams Lake', 'intake', '250-267-9154', 'Intake.WilliamsLake@legalaid.bc.ca', 'Wed,Thurs: 9am-12pm, 1pm-3pm');
INSERT INTO labc_offices (location, type, phone, email, hours) VALUES ('Province Wide Call Centre', 'call_centre', '1-866-577-2525', NULL, NULL);
INSERT INTO labc_offices (location, type, phone, email, hours) VALUES ('Duty Counsel Priority Line', 'priority_line', '1-888-601-6076 (Option #3)', NULL, NULL);
INSERT INTO labc_offices (location, type, phone, email, hours) VALUES ('Duty Counsel Team', 'email', NULL, 'DutyCounsel@legalaid.bc.ca', NULL);

-- LABC_NAVIGATORS: 8 records
TRUNCATE TABLE labc_navigators RESTART IDENTITY CASCADE;
INSERT INTO labc_navigators (name, phone, email, courts) VALUES ('Conor', '236-333-1260', 'conor.navigator@legalaid.bc.ca', 'Victoria, Nanaimo, VR8, VR9');
INSERT INTO labc_navigators (name, phone, email, courts) VALUES ('Courtney', '236-788-7372', 'courtney.navigator@legalaid.bc.ca', 'Surrey');
INSERT INTO labc_navigators (name, phone, email, courts) VALUES ('Hana', '604-364-6541', 'hana.navigator@legalaid.bc.ca', 'VR4, VR2, Kamloops');
INSERT INTO labc_navigators (name, phone, email, courts) VALUES ('Imtaj', '236-818-7616', 'imtaj.navigator@legalaid.bc.ca', 'North Vancouver, Richmond');
INSERT INTO labc_navigators (name, phone, email, courts) VALUES ('Jennifer', '236-788-5291', 'jennifer.navigator@legalaid.bc.ca', 'Vancouver, DCC');
INSERT INTO labc_navigators (name, phone, email, courts) VALUES ('Naomi', '604-364-5873', 'naomi.navigator@legalaid.bc.ca', 'VR3, Penticton');
INSERT INTO labc_navigators (name, phone, email, courts) VALUES ('Navneet', '236-808-8931', 'navneet.navigator@legalaid.bc.ca', 'Abbotsford, Chilliwack');
INSERT INTO labc_navigators (name, phone, email, courts) VALUES ('Shewaye', '236-788-9268', 'shewaye.navigator@legalaid.bc.ca', 'PoCo, New Westminster');

-- DUTY_COUNSEL_LAWYERS: 262 records
TRUNCATE TABLE duty_counsel_lawyers RESTART IDENTITY CASCADE;
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('ALLINGHAM Jordan', '155631', 'allinghamlaw@gmail.com', '604-762-6664', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('ANDERSON Brent R.', '155902', 'brent@johnsondoyle.com', '604-928-8331', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('BELLOWS Robert W.', '169771', 'bellowslaw@gmail.com', '604-551-8524', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('CARPENTIER Debra', '141267', 'debracarpentier@shaw.ca', '604-730-2840', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('COOPER Edward', '121905', 'edcooper@me.com', '778 772-1818', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('CORRIVEAU Chandra L.', '139715', 'changrilaw@gmail.com', '778-893-5957', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('DANIELLS Susan', '168658', 'sdaniells.law@gmail.com', '604-683-3206', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('ENRIGHT Ray', '188268', 'conmak@shaw.ca', '604-685-2366', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('FAI David', '190652', 'davidfai@telus.net', '604-649-2500', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('FARMER Lionel', '140016', 'LionelFarmer@telus.net', '604-773-1439', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('FERGUSON Paul M', '139775', 'paul@paulfergusonlaw.com', '778-233-3833', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('FUMANO Leo', '139777', 'lfumano@hotmail.com', '604-765-0193', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('FUNG Thomas', '136432', 'tfung456@gmail.com', '604-329-3829', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('GERVIN Mark', '195560', 'mark@gervinlaw.com', '604-825-7154', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('JOHNSON Ryan M. J.', '156183', 'ryan.rj.johnson@gmail.com', '778-872-3155', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('LAGEMAAT Anthony J.', '156448', 'tony@lagemaatlaw.com', '604-428-6821', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('MANDANICI Sandra', '139590', 'mandanicilaw@gmail.com', '604-626-3244', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('MINES Michael', '160739', 'mail@mineslaw.com', '604 618-8872', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('MYERS Justin V.', '156178', 'justin@myerscolaw.com', '604-727-7335', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('MYERS Zachary J.', '156260', 'zackmyers87@gmail.com', '604-833-4992', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('NELSON Andrew', '155738', 'andrew@johnsondoyle.com', '778-837-0301', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('NEURAUTER Kristy Lee', '155849', 'kristy.neurauter@gmail.com', '604-880-9422', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('NIEFER Jayde M.', '157096', 'jmniefer@gmail.com', '778-846-1962', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('OCHITWA Carmen J.', '172890', 'carmen@ochitwalaw.com', '604-874-9747', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('OCHITWA Timothy P.', '192773', 'tochitwa@gmail.com', '604-240-4435', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('PERCIVAL Jacqueline A.', '144188', 'nw1law@telus.net', '604-725-4681', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('PICARD Adrian Robert Paul', '155400', 'law.picard@gmail.com', '778-859-1987', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('SHERREN James', '173435', 'james_sherren@telus.net', '604-803-3644', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('TURNER John', '195727', 'jbturner@shaw.ca', '604-626-3348', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('EDER Birgit', '168468', 'birgit.eder@gmail.com', '604-771-7277', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('FITZMAURICE Patrick Michael', '156515', 'pmfitzmaurice@gmail.com', '778-869-3489', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('GLOUBERMAN Adi', '155533', 'adiglouberman@gmail.com', '778-885-4931', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('SPRACKMAN Paul J.', '185397', 'psprackman@telus.net', '604-551-8836', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('TARNOW David C.', '112375', 'david@tarnow.ca', '604-328-7470', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('TARNOW Jason D.', '155597', 'jason@tarnow.ca', '778-866-9520', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('THOMPSON Mark B', '128272', 'markthompsonlaw@gmail.com', '604-244-7700', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('WARREN Eric', '109702', 'warren.eder@gmail.com', '604-720-7261', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('CHAICHIAN Camran S.', '141010', 'camranchaichian@hotmail.com', '778-800-0201', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('CHAMBERS Herb W.', '125124', 'hwchambers@shaw.ca', '604-892-7839', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('FOSTER, Mitch', NULL, 'mitch@mitchfoster.com', '604-306-6699', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('KHAJURIA, Mansi', NULL, 'Mansi@luckylaw.ca', '778-829-3990', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('LUCK Sonja', '157085', 'sonjaluck@gmail.com', '604-916-4350', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('PARUK Glen A', '170340', 'gparuk@shaw.ca', '604-921-1949', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('SHORTREED Katherine', '157080', 'katherine@ksdefence.ca', '604-744-1066', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('SMITH Michael D.', '129754', 'm_d_smith@mac.com', '604-561-7875', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('WHYNOT Olivia', '157238', 'Olivia.Whynot@outlook.com', '778-858-7674', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('WALSOFF David James', '143198', 'walsoffd@me.com', '604-725-4357', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('DAVIDSON Justine', '156564', 'justine.davidson.law@gmail.com', '604-365-2421', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('JANICKI Sandi', '156547', 'sandi.janicki@gmail.com', '604-358-4100', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('CORRIVEAU Chandra L.', '139715', 'changrilaw@gmail.com', '778-893-5957', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('LAWRENCE Darcy P.', '149559', 'darcy@darcylawrence.com', '604-885-8182', NULL, 'Vancouver Coastal');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Surrey', NULL, 'zainali@sternshapraylaw.ca', '778-834-6023', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Surrey', NULL, 'abdulabdulmalik@adlklaw.com', '604-375-5160', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Surrey', NULL, 'bowlaw@telus.net', '604-781-1951', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Surrey', NULL, 'wdburns@telus.net', '604-218-4154', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Surrey', NULL, 'psslouise@gmail.com', '236-989-4164', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Surrey', NULL, 'pdelrossi@saslaw.ca', '604-590-5600', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Surrey', NULL, 'evids987654@gmail.com', '604-613-0050', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Surrey', NULL, 'alexis.falk@alexisfalklaw.ca', '604-349-0035', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Surrey', NULL, 'rfredrickson@shaw.ca', '604-825-1861', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Surrey', NULL, 'edison.heba@telus.net', '604-818-5081', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Surrey', NULL, 'julia@surreydefence.com', '778-899-3060', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Surrey', NULL, 'ajaswal.law@gmail.com', '604-818-0699', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Surrey', NULL, 'graemejose1@gmail.com', '778-386-4566', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Surrey', NULL, 'gkabanuk@telus.net', '604 220 6561', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('KANDOLA Raman', '157186', 'raman@kandolalaw.ca', '778-968-2522', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Surrey', NULL, 'robblarmer@gmail.com', '604-203-9591', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Surrey', NULL, 'jas@helpslaw.com', '604-782-6553', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Surrey', NULL, 'acquit@telus.net', '604-240-7485', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Surrey', NULL, 'bobby@bmlawfirm.ca', '604-785-6967', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Surrey', NULL, 'dbpayn@gmail.com', '604-767-2120', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Surrey', NULL, 'hrehlan@basralawgroup.com', '604-788-6731', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Surrey', NULL, 'mani4364@hotmail.com', '778-316-7654', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Surrey', NULL, 'casey@stgermainlaw.com', '604-716-8477', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Surrey', NULL, 'georgexuereb@icloud.com', '604-783-1956', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Abbotsford/Chilliwack', NULL, 'arnasonlaw1@gmail.com', '604-996-9675', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Abbotsford/Chilliwack', NULL, 'sarab@ssalawyers.ca', '604-762-2261', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Abbotsford/Chilliwack', NULL, 'philip@derksenlawyer.com', '604-832-8395', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Abbotsford/Chilliwack', NULL, 'vincent@moesandmore.com', '778-242-7077', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Abbotsford/Chilliwack', NULL, 'alexis.falk@alexisfalklaw.ca', '604-349-0035', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Abbotsford/Chilliwack', NULL, 'sgjmar408@gmail.com', '604-807-6679', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Abbotsford/Chilliwack', NULL, 'rebecca@ddlaw.ca', '604-655-1857', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Abbotsford/Chilliwack', NULL, 'dpetri@petrilaw.ca', '604-996-2362', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Abbotsford/Chilliwack', NULL, 'mardon2@telus.net', '604-308-2669', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Abbotsford/Chilliwack', NULL, 'ranjrandhawa@hotmail.com', '604-649-8191', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Abbotsford/Chilliwack', NULL, 'jayse@drugdefence.com', '604-773-1319', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Abbotsford/Chilliwack', NULL, 'djsch@telus.net', '604-807-2680', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Abbotsford/Chilliwack', NULL, 'osnowdon@stlegal.ca', '604-725-6546', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Abbotsford/Chilliwack', NULL, 'cterepocki@gstlegal.ca', '604-997-9289', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('New Westminster/Port Coquitlam', NULL, 'trudy@trudyaulaw.com', '604-600-5919', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('New Westminster', NULL, 'karen@karenbastow.com', '604- 600-2942', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Port Coquitlam', NULL, 'camranchaichian@hotmail.com', '778-800-0201', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('New Westminster/Port Coquitlam', NULL, 'psslouise@gmail.com', '236-989-4164', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('New Westminster/Port Coquitlam', NULL, 'rfredrickson@shaw.ca', '604-825-1861', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('New Westminster/Port Coquitlam', NULL, 'vguo@vguolaw.com', '604-259-6260', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Port Coquitlam', NULL, 'stephanie@platformlit.com', '778-868-3413', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('New Westminster/Port Coquitlam', NULL, 'pauljanzen@pwjanzenlaw.ca', '604-612-0828', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('New Westminster/Port Coquitlam', NULL, 'lisajunglaw@gmail.com', '604-537-1269', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('New Westminster/Port Coquitlam', NULL, 'ludfordlaw@gmail.com', '604-380-0143', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('New Westminster/Port Coquitlam', NULL, 'karen@karenmirsky.com', '604-614-6745', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Port Coquitlam', NULL, 'carmen@ochitwalaw.com', '604-809-9244', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Port Coquitlam', NULL, 'gparuk@shaw.ca', '604-921-1949', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('New Westminster/Port Coquitlam', NULL, 'larrywpippard@shaw.ca', '604-728-0847', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('New Westminster/Port Coquitlam', NULL, 'leerankin@shaw.ca', '778-988-9648', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('New Westminster/Port Coquitlam', NULL, 'brocklehurst2008@hotmail.com', '778-997-2757', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('New Westminster/Port Coquitlam', NULL, 'dougsoga@begbiecourtlaw.com', '604-816-9432', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('New Westminster/Port Coquitlam', NULL, 'psprackman@telus.net', '604-551-8836', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('New Westminster/Port Coquitlam', NULL, 'nonac@live.ca', '604-200-2544', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('New Westminster/Port Coquitlam', NULL, 'roxy@vancouverlegal.ca', '604-724-8955', NULL, 'Fraser');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Weststrate, Blaine', NULL, 'blainewest@shaw.ca', '250-862-8555', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Johnson, David Brian', NULL, 'dbjohnson@me.com', '250-717-6963', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Newby, Kelly', NULL, 'kelly@klnlaw.ca', '250-718-7233', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Stephenson, Michael', NULL, 'mstephensonlawyer@gmail.com', '250-870-1999', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Kelly, Joanna Elizabeth', NULL, 'joannakelly@shaw.ca', '250 215 9209.', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Newcombe, Michael', NULL, 'newcombelaw@telus.net', '250-861-8911', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Walford Helene', NULL, 'hwalfordlaw@shaw.ca', '250-801-0031', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Lowe, Melissa', NULL, 'ml@mwslaw.ca', '778-839-1102', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Jones, Gavin', NULL, 'assistant@joneslawoffice.ca', '250 763 8877', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Kelly, Joanna Elizabeth', NULL, 'joannakelly@shaw.ca', '250-215-9209', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Lundman, Kathyrn', NULL, 'klundman57@gmail.com', '250-328-3302', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Newby, Kelly', NULL, 'kelnewby@gmail.com', '250-718-7233', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Selamaj, Nelson', NULL, 'nelson@selamajlaw.ca', '250-899-7769', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Skobalski, Glen', NULL, 'robglen@telus.net', '250-550-9343', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Varga, Stanley Paul', NULL, 'paul@vargalaw.ca', '250-328-2853', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Yates, Norman', NULL, 'normanyates@gmail.com', '250-328-9996', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Walford, Helene', NULL, 'hwalfordlaw@shaw.ca', '250-801-0031', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('White, Donald James', NULL, 'don@whitelawoffice.ca', '250-777-2990', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Armstrong, Murray', NULL, 'ama51@shaw.ca', '250-851-8461', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('CURRIE Iain A.', '157019', 'Iain@currie-law.ca', '250-572-7186', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Maxwell, Jeff', NULL, 'Jeff@Maxwelllaw.net', '778-921-0698', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Michi, Jay', NULL, 'krystyna@jensenlaw.ca', '778-220-3573', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Tate Sheldon', NULL, 'sheldon@tatelaw.ca', '250-377-1854', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('McNamee, Daniel', NULL, 'daniel@jensenlaw.ca', '647-648-1035', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Ching McNamee, Danielle', NULL, 'danielle@smithlitigation.com', '778-929-5631', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Johnson, Cameron', NULL, 'cjohnson@cfelaw.ca', '780-862-2998', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Kay, Graham', NULL, 'graham@kaylawoffice.com', '250-819-6611', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Killoran, Joseph', NULL, 'krystyna@jensenlaw.ca', '250-682-4767', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('MCLAUGHLIN Courtney A.', '157345', 'cmclaughlinlaw@outlook.com', '250-255-3758', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Gagnon, Dustin Cory', NULL, 'dustin@gagnonlawcorp.com', '778-471-7927', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Jensen, Jeremy', NULL, 'krystyna@jensenlaw.ca', '250-319-5684', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Gustafson, John', NULL, 'john@jpgustafsonlaw.com', '250-572-5718', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Salmond, Lois E.', NULL, 'brocklehurst2008@hotmail.com', '778-997-2757', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Thompson, Christopher H.', NULL, 'chthomp@telus.net', '250-314-9596', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Walker Kenneth', NULL, 'kenwalker@wozniakwalker.ca', '250-374-6226', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Walker, Lana', NULL, 'lana@smithlitigation.com', '647-463-8432', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Avis, Jonathan R.', NULL, 'jonathan@avislaw.ca', '250-307-0149', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Jacob, Nick', NULL, 'nick@nicholasjacob.ca', '250-540-9798', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Mastop, Claire', NULL, 'clairemastop@gmail.com', '250-308-2458', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('McPheeters Laura', NULL, 'laura@mcpheeters.ca', '778-930-2040', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Pielecki, Ignatius', NULL, 'nacio@telus.net', '250-308-9199', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Forbes, Daniel', NULL, 'df@bcdef.ca', NULL, NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Hinman, Tanner', NULL, 'law@tannerhinman.com', '250-602-0020', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Simmons, Courtenay', NULL, 'csimmons@csimmonslaw.ca', '250-540-1432', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Verdurmen, Dominique C.T.', NULL, 'kelly@verdurmenlaw.com', '250-833-0914', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Wark, Roderick W.', NULL, 'rodw@telus.net', '250-938-2177', NULL, 'Interior');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('CURRIE Iain A.', '157019', 'Iain@currie-law.ca', '250-572-7186', NULL, 'Interior Evening');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Hinman, Tanner J.', NULL, 'law@tannerhinman.com', '250-602-0020', NULL, 'Interior Evening');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Jensen, Jeremy', NULL, 'jeremy@jensenlaw.ca', '250-319-5684', NULL, 'Interior Evening');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Johnson, David Brian', NULL, 'dbjohnson@icloud.com', '250-717-6963', NULL, 'Interior Evening');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Killoran, Joe', NULL, 'joe@jensenlaw.ca', '250-682-4767', NULL, 'Interior Evening');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Komarysky, Kyle', NULL, 'kyle@jensenlaw.ca', '780-920-4559', NULL, 'Interior Evening');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Laflamme, Marcel', NULL, 'marcellaflamme@telus.net', '250-342-1094', NULL, 'Interior Evening');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Lundman, Kathyrn', NULL, 'klundman57@gmail.com', '250-328-3302', NULL, 'Interior Evening');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('MCLAUGHLIN Courtney A.', '157345', 'cmclaughlinlaw@outlook.com', '250-255-3758', NULL, 'Interior Evening');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('McNamee, Daniel', NULL, 'daniel@jensenlaw.ca', '647-648-1035', NULL, 'Interior Evening');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Mctavish, Ian', NULL, 'ianmctavish@mctavishlaw.ca', '250-832-5334', NULL, 'Interior Evening');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Michi, Jay', NULL, 'jay@jensenlaw.ca', '778-220-3573', NULL, 'Interior Evening');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Selamaj, Nelson', NULL, 'nelson@selamajlaw.ca', '250-899-7769', NULL, 'Interior Evening');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Stephenson, Michael', NULL, 'mstephensonlawyer@gmail.com', '250-870-1999', NULL, 'Interior Evening');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Verdurmen, Dominique C.T.', NULL, 'dominique@verdurmenlaw.com', '250-833-0914', NULL, 'Interior Evening');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Walford, Helene', NULL, 'hwalfordlaw@shaw.ca', '250-801-0031', NULL, 'Interior Evening');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Yates, Norman E.', NULL, 'normanyates@gmail.com', '250-328-9996', NULL, 'Interior Evening');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('MAXWELL Jean-Francois Normand', '157101', 'Jeff@Maxwelllaw.net', '778-921-0698', NULL, 'Interior Evening');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Tate, Sheldon', NULL, 'sheldon@tatelaw.ca', '250-377-1854', NULL, 'Interior Evening');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Alberto, Roberto', NULL, 'alberto@ameliastreetlawyers.com', '250-920-0144', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Arnold, Jonathan P.', NULL, 'messagejparnold@outlook.com', '250-858-0140', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Acker, Nicholas', NULL, 'na@mwslaw.ca', '250-480-1529', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Blokmanis,Peter Andris', NULL, 'peter@elevationlegal.ca', '250-580-4100', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Bulmer, Thomas', NULL, 'tom@victorialegal.com', '250-384-7116', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Brooks, Neil', NULL, 'brooks.neil@gmail.com', '250-661-1893', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Costa, M. Elizabete', NULL, 'mec@costalaw.ca', '250-884-9490', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Dieno, Raymond G.', NULL, 'ray.dieno@v-law.ca', '250-480-1529', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Drury, Robert Ryan', NULL, 'rdrury@clauscriminallaw.com', '250-361-3000', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Gustafson, Carl Owen', NULL, 'cog43@shaw.ca', '250-217-6919', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Horne, Rolfe S.', NULL, 'moxielawcorp@yahoo.ca', '604-365-6540', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Heller, James', NULL, 'jimheller@shaw.ca', '250-360-1040', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Johnson, Barclay W.', NULL, 'bwjohnson@shaw.ca', '778-679-4417', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Karaszkiewicz, Kirk T.', NULL, 'kirkkaras@shaw.ca', '250-217-5647', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Kuczma, Roland', NULL, 'rkuczma@gmail.com', '250-514-8192', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Lugosi, Charles', NULL, 'Charles@lugosi-law.com', '19-761-7000', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Lynskey, Ben', NULL, 'lynskey@mwslaw.ca', '250-480-1529', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('McCullough, Kevin George', NULL, 'km@mbdglaw.ca', '250-480-1529', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Mills, Jeremy W.D.', NULL, 'jeremy@donaldjmckay.com', '250-853-0253', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Morrison, Marie', NULL, 'marie@mmorrisonlaw.ca', '250-388-9003', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Morino, Thomas', NULL, 'tom_morino@hotmail.com', '250-295-3342', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Motture Miles', NULL, 'milesmotture@gmail.com', '778-410-2363', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Reid, Jennifer Meela', NULL, 'jenslawster@gmail.com', '778-884-6875', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Roy, Schuyler', NULL, 'sroy@clauscriminallaw.com', '778-677-4578', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Schwartz, Richard A.', NULL, 'raschwartz@shaw.ca', '250-812-3807', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Suntok, Stephen N.', NULL, 'stevesuntok@gmail.com', '250-884-7299', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Sutton, Chantelle', NULL, 'cs@mwslaw.ca', '250-480-1529', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('TAIT Alexander P.', '109124', 'aptait@shaw.ca', '250-360-0555', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Tollefson, Claire', NULL, 'cmtollefsonlaw@shaw.ca', '250-881-5877', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('White, Cynthia', NULL, 'cynthia.white@shaw.ca', '250-886-4015', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Watt, Jordan', NULL, 'jw@mwslaw.ca', '250-480-1529', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Alexander P. Tait', NULL, 'aptait@shaw.ca', '250-812-8005', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Barclay W. Johnson', NULL, 'bwjohnson@shaw.ca', '778-679-4417', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Ben Lynskey', NULL, 'bl@mwslaw.ca', '778-679-9580', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Cara Hunt', NULL, 'cara@carahunt.ca', '778-350-4868', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Claire Tollefson', NULL, 'cmtollefsonlaw@shaw.ca', '250-881-5877', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Cynthia White', NULL, 'cynthiawhitelaw@outlook.com', '250-886-4015', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Elizabete M. Costa', NULL, 'mec@costalaw.ca', '250-884-9490', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('James Heller', NULL, 'jimheller@shaw.ca', '250-360-10401', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Jennifer Reid', NULL, 'jenslawster@gmail.com', '778-884-6875', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Jordan Watt', NULL, 'jw@mwslaw.ca', '250-886-8358', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Kirk T. Karaszkiewicz', NULL, 'kirkkaras@shaw.ca', '250-217-5647', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Kevin George McCullough', NULL, 'km@mwslaw.ca', '778-678-2225', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Marion West', NULL, 'mlwest500@gmail.com', '604-768-8396', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Peter Blokmanis', NULL, 'peter@elevationlegal.ca', '250-580-4100', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Richard A. Schwartz', NULL, 'raschwartz@shaw.ca', '250-812-3807', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Robert S. Ramsay', NULL, 'robertstevenramsay@gmail.com', '250-715-5619', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Roberto Alberto', NULL, 'alberto@ameliastreetlawyers.com', '250-920-0144', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Rolfe S. Horne', NULL, 'moxielawcorp@yahoo.ca', '604-365-6540', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Ryan Drury', NULL, 'rdrury@clauscriminallaw.com', '250-361-3000', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Simon Knott', NULL, 'simknott1@gmail.com', '250-597-1820', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Anita Szabo', NULL, 'canmorelawyer@gmail.com', '403-688-2422', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Julia Hunter', NULL, 'juliahunter@strategic-law.ca', '250-884-3930', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Nick Acker', NULL, 'na@mwslaw.ca', '250-480-1529', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Justin Dosanjh', NULL, 'jd@mwslaw.ca', '250-480-1529', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Cheyne Hodson', NULL, 'ch@mwslaw.ca', '250-480-1529', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Schuyler ROY', NULL, 'sroy@clauscriminallaw.com', '778-677-4578', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Thomas Morino', NULL, 'tom_morino@hotmail.com', '250-295-3342', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Thomas W. Bulmer', NULL, 'tom@victorialegal.com', '250-384-7116', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Andrew Uhlman', NULL, 'andrew@uhlmanlaw.com', '250-361-6405', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Tim Russell', NULL, 'km@mwslaw.ca', '250-480-1529', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Jonathan Arnold', NULL, 'messagejparnold@outlook.com', '250-858-0140', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Winkel, Megan', NULL, 'megan@bcdefence.ca', '778-676-1311', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Steve Suntok', NULL, 'stevesuntok@gmail.com', '250-884-7299', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Arends, James K.', NULL, 'arendslaw@shaw.ca', '778-744-3310', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Screech, Martin', NULL, 'screech@sll.ca', '250-381-4040', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Bradshaw, Kelly', NULL, 'kelly@kingbradshaw.com', '250-753-6617', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Wright, C. James', NULL, 'wright-law@telus.net', '250-751-5853', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Waugh, Kendra', NULL, 'kendra@bcdefence.ca', '250-802-8080', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Ritzker, Michael', NULL, 'mikeritzker@gmail.com', '250-668-9377', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Kerr-Donohue, Kathleen', NULL, 'kathleen@bcdefence.ca', '250-713-8080', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Littley, Stephen T.', NULL, 'kimberley.littleylaw@gmail.com', '250-753-5372', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Shelling Louis', NULL, 'jlshelling@telus.net', '888-283-3933', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Turner, Julia', NULL, 'julia@bcdefence.ca', '250-616-3493', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Cara Hunt', NULL, 'cara@carahunt.ca', '778-350-4868', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Norm Yates', NULL, 'normanyates@gmail.com', '250-328-9996', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Zertuche de Iturbide Octavio', NULL, 'zertuche@zertuchelaw.com', '250-889-8377', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Angelique Penhall', NULL, 'angie.penhall@shaw.ca', '250-850-5466', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Kathleen McGuire', NULL, 'Kathleen.mcguire@pkmlaw.ca', '604-315-5551', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Murray L. Gendreau', NULL, 'mljgendreau@shaw.ca', '250-730-1355', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Robert D. Miller', NULL, 'mmmiller@shaw.ca', '250-334-7354', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Robert Yeo', NULL, 'ryeolaw@shaw.ca', '250-703-6994; 250-334-4155', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Herb Chambers', NULL, 'hwchambers@shaw.ca', '604-892-7839', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('Thomas Vincent Martin', NULL, 'quadlaw@hotmail.com', '250-285-2021', NULL, 'Island');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('GILSON Brian G', '175273', 'gilsonlaw@gmail.com', '250-563-7330', NULL, 'Northern');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('JOSEPHY Beatrix L.', '111500', 'bjosephy@gmail.com', '250-561-1808', NULL, 'Northern');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('GRIFFITH-ZAHNER Martin', '144824', 'mgriffithzahner@gmail.com', '250 600-3555', NULL, 'Northern');
INSERT INTO duty_counsel_lawyers (name, labc_id, email, phone, location, region) VALUES ('GRIFFITH-ZAHNER Martin', '144824', 'mgriffithzahner@gmail.com', '250 600-3555', NULL, 'Northern');

-- FORENSIC_CLINICS: 7 records
TRUNCATE TABLE forensic_clinics RESTART IDENTITY CASCADE;
INSERT INTO forensic_clinics (name, address, phone, email) VALUES ('Kamloops Forensic Regional Clinic', '5-1315 Summit Drive, Kamloops, BC V2C 5R9', '250-377-2660', 'KamloopsAdmitting@phsa.ca');
INSERT INTO forensic_clinics (name, address, phone, email) VALUES ('Kelowna Forensic Regional Clinic', '#115-1835 Gordon Drive, Kelowna, BC V1Y 3H5', '778-940-2100', 'KelownaAdmitting@phsa.ca');
INSERT INTO forensic_clinics (name, address, phone, email) VALUES ('Nanaimo Forensic Regional Clinic', '101-190 Wallace Street, Nanaimo, BC V9R 5B1', '250-739-5000', 'NanaimoAdmitting@phsa.ca');
INSERT INTO forensic_clinics (name, address, phone, email) VALUES ('Prince George Forensic Regional Clinic', '2nd Floor, 1584 7th Avenue, Prince George, BC V2L 3P4', '250-561-8060', 'PrinceGeorgeAdmitting@phsa.ca');
INSERT INTO forensic_clinics (name, address, phone, email) VALUES ('Surrey Forensic Regional Clinic', '10022 King George Boulevard, Surrey, BC V3T 2W4', '604-529-3300', 'SurreyAdmitting@phsa.ca');
INSERT INTO forensic_clinics (name, address, phone, email) VALUES ('Vancouver Forensic Regional Clinic', '300-307 West Broadway, Vancouver, BC V5Y 1P9', '604-529-3350', 'VancouverAdmitting@phsa.ca');
INSERT INTO forensic_clinics (name, address, phone, email) VALUES ('Victoria Forensic Regional Clinic', '2840 Nanaimo Street, Victoria, BC V8T 4W9', '250-213-4500', 'VictoriaAdmitting@phsa.ca');

-- INDIGENOUS_JUSTICE_CENTRES: 10 records
TRUNCATE TABLE indigenous_justice_centres RESTART IDENTITY CASCADE;
INSERT INTO indigenous_justice_centres (location, phone, email, website) VALUES ('Chilliwack', '778-704-1355', 'chilliwackinfo@bcfnjc.com', NULL);
INSERT INTO indigenous_justice_centres (location, phone, email, website) VALUES ('Kelowna', '236-763-6881', 'kelownainfo@bcfnjc.com', NULL);
INSERT INTO indigenous_justice_centres (location, phone, email, website) VALUES ('Merritt', '236-575-3004', 'merrittinfo@bcfnjc.com', NULL);
INSERT INTO indigenous_justice_centres (location, phone, email, website) VALUES ('Nanaimo', '778-762-4061', 'nanaimoinfo@bcfnjc.com', NULL);
INSERT INTO indigenous_justice_centres (location, phone, email, website) VALUES ('Prince George', '250-645-5519', 'pginfo@bcfnjc.com', NULL);
INSERT INTO indigenous_justice_centres (location, phone, email, website) VALUES ('Prince Rupert', '778-622-3563', 'prinfo@bcfnjc.com', NULL);
INSERT INTO indigenous_justice_centres (location, phone, email, website) VALUES ('Surrey', '236-947-6777', 'surreyinfo@bcfnjc.com', NULL);
INSERT INTO indigenous_justice_centres (location, phone, email, website) VALUES ('Vancouver', '236-455-6565', 'vancouverinfo@bcfnjc.com', NULL);
INSERT INTO indigenous_justice_centres (location, phone, email, website) VALUES ('Victoria', '250-419-9665', 'victoriainfo@bcfnjc.com', NULL);
INSERT INTO indigenous_justice_centres (location, phone, email, website) VALUES ('Virtual', '1-866-786-0081', 'virtual@bcfnjc.com', NULL);

-- PROGRAMS: 18 records
TRUNCATE TABLE programs RESTART IDENTITY CASCADE;
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Talitha Koum', 'Coquitlam', '6044923393.0', 'All', NULL, NULL, 'Phone Call', NULL);
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Glory House', 'Mission', '6043803665.0', NULL, NULL, NULL, 'Phone Call', NULL);
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Lydia Home', 'Mission', '6042533323.0', NULL, NULL, NULL, 'Phone Call', NULL);
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Hannah House', 'Maple Ridge', '8664664215.0', NULL, NULL, NULL, 'Phone Call', NULL);
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Night & Day', 'Surrey', '7783174673.0', NULL, NULL, NULL, 'Phone Call', NULL);
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Vision Quest Hart House', 'Surrey', '6049461841.0', NULL, NULL, NULL, 'Phone Call', 'Will take people with SA records');
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Stepping Stone', 'Courtenay', '2508970360.0', NULL, NULL, NULL, 'Written', NULL);
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Amethyst', 'Campbell River', '2508702570.0', NULL, NULL, NULL, 'Written', NULL);
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('The Farm', 'Port Alberni', NULL, NULL, NULL, NULL, 'Written', NULL);
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Sancta Marie', 'Vancouver', '6047315550.0', NULL, NULL, NULL, 'Written', NULL);
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Turning Point (North Van)', 'North Van', '6049710111.0', NULL, NULL, NULL, 'Written', NULL);
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Turning Point (Van)', 'Vancouver', '6048751710.0', NULL, NULL, NULL, 'Written', NULL);
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Back On Track', 'Surrey', '7783162625.0', NULL, NULL, NULL, 'Phone Call', NULL);
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Raven’s Moon', 'Abbotsford', NULL, NULL, NULL, 'True', 'Phone Call', 'Jeanette 6047514631
Tina 6043081767');
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Ann Elmore House', 'Campbell River', '2502863666.0', NULL, NULL, 'True', 'Phone Call', NULL);
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('STAR Program', 'Pre-Treatment', NULL, NULL, NULL, NULL, 'Written', NULL);
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Riceblock', 'Post Treatment', '6042532553.0', NULL, NULL, NULL, 'Phone Call', NULL);
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Phoenix', NULL, NULL, NULL, NULL, NULL, NULL, 'Will take people with SA records');

-- ACCESS_CODES: 18 records
TRUNCATE TABLE access_codes RESTART IDENTITY CASCADE;
INSERT INTO access_codes (court, code, notes) VALUES ('Chilliwack', '512.0', NULL);
INSERT INTO access_codes (court, code, notes) VALUES ('Court of Appeal', NULL, NULL);
INSERT INTO access_codes (court, code, notes) VALUES ('Cranbrook', NULL, NULL);
INSERT INTO access_codes (court, code, notes) VALUES ('Duncan', NULL, NULL);
INSERT INTO access_codes (court, code, notes) VALUES ('Fort St. John', '2&4, 3', '2 & 4 together🤘then 3 🖕');
INSERT INTO access_codes (court, code, notes) VALUES ('Nanaimo', '3179#', NULL);
INSERT INTO access_codes (court, code, notes) VALUES ('North Vancouver', '2355.0', NULL);
INSERT INTO access_codes (court, code, notes) VALUES ('Penticton', NULL, NULL);
INSERT INTO access_codes (court, code, notes) VALUES ('Port Coquitlam (Library)', '1379.0', NULL);
INSERT INTO access_codes (court, code, notes) VALUES ('Prince George (1st Floor)', '9588*', NULL);
INSERT INTO access_codes (court, code, notes) VALUES ('Prince Rupert', '266266.0', NULL);
INSERT INTO access_codes (court, code, notes) VALUES ('Richmond', '235#', NULL);
INSERT INTO access_codes (court, code, notes) VALUES ('Robson Square', '35.0', NULL);
INSERT INTO access_codes (court, code, notes) VALUES ('Sechelt', '36.0', 'BC Sport Fishing Reg paper on the window');
INSERT INTO access_codes (court, code, notes) VALUES ('Smithers', NULL, NULL);
INSERT INTO access_codes (court, code, notes) VALUES ('Terrace (Library and Lounge)', '254.0', NULL);
INSERT INTO access_codes (court, code, notes) VALUES ('Vancouver 222 Main', '235.0', NULL);
INSERT INTO access_codes (court, code, notes) VALUES ('Vancouver Supreme', '314.0', NULL);

-- CIRCUIT_COURTS: 48 records
TRUNCATE TABLE circuit_courts RESTART IDENTITY CASCADE;
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('100 Mile House', NULL, 'Williams Lake');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Ahousaht', 'R1 - Island', 'Port Alberni');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Alexis Creek', NULL, 'Williams Lake');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Anahim Lake', NULL, 'Williams Lake');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Ashcroft', 'R4 - Interior', 'Kamloops');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Atlin', NULL, 'Fort St. John');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Bella Bella', NULL, 'Vancouver 222');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Bella Coola', NULL, 'Vancouver 222');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Castlegar', 'R4 - Interior', 'Nelson');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Chase', 'R4 - Interior', 'Kamloops');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Chetwynd', NULL, 'Dawson Creek');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Clearwater', 'R4 - Interior', 'Kamloops');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Creston', 'R4 - Interior', 'Cranbrook');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Daajing Giids/Queen Charlotte', NULL, 'Prince Rupert');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Dease Lake', NULL, 'Terrace');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Fernie', 'R4 - Interior', 'Cranbrook');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Fort St. James', NULL, 'Prince George');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Fraser Lake', NULL, 'Prince George');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Ganges', 'R1 - Island', 'Duncan');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Gold River', NULL, 'Campbell River');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Good Hope Lake', NULL, 'Fort St. John');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Grand Forks', NULL, 'Rossland');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Hazelton', NULL, 'Smithers');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Houston', NULL, 'Smithers');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Hudson''s Hope', NULL, 'Fort St. John');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Invermere', 'R4 - Interior', 'Cranbrook');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Kitimat', NULL, 'Terrace');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Klemtu', NULL, 'Vancouver 222');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Kwadacha/Fort Ware', NULL, 'Prince George');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Lillooet', 'R4 - Interior', 'Kamloops');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Lower Post', NULL, 'Fort St. John');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Masset', NULL, 'Prince Rupert');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('McBride', NULL, 'Valemount');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Merritt', 'R4 - Interior', 'Kamloops');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Nakusp', 'R4 - Interior', 'Nelson');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('New Aiyansh', NULL, 'Terrace');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Pemberton', NULL, 'North Vancouver');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Princeton', 'R4 - Interior', 'Penticton');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Revelstoke', 'R4 - Interior', 'Salmon Arm');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Sidney', 'R1 - Island', 'Victoria');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Sparwood', 'R4 - Interior', 'Cranbrook');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Stewart', NULL, 'Terrace');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Tahsis', 'R1 - Island', 'Campbell River');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Tofino', 'R1 - Island', 'Port Alberni');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Tsay Keh Dene (Ingenika)', NULL, 'Prince George');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Tumbler Ridge', NULL, 'Dawson Creek');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Ucluelet', 'R1 - Island', 'Port Alberni');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Vanderhoof', NULL, 'Prince George');

-- MS_TEAMS_LINKS: 391 unique conference IDs
TRUNCATE TABLE ms_teams_links RESTART IDENTITY CASCADE;
INSERT INTO ms_teams_links (region, conference_id) VALUES ('island', '929 176 188#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('island', '893 653 923#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('interior', '787 097 137#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('interior', '450 095 994#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('vancouver', '157 117 369#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('vancouver', '181 066 25#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('surrey', '136 442 754#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('surrey', '409 841 398#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('justice_centres', '732 076 358#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('justice_centres', '365 751 988#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('justice_centres', '618 706 537#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('justice_centres', '453 417 829#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('justice_centres', '938 770 945#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('justice_centres', '210 409 821#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('justice_centres', '634 183 845#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '512 863 082#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '138 892 86#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '631 620 353#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '445 393 748#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '450 797 759#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '342 802 541#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '727 595 19#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '629 018 7#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '542 800 159#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '984 670 456#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '276 726 712#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '196 429 444#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '883 095 480#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '160 382 81#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '117 947 266#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '414 202 059#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '532 718 803#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '388 791 638#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '843 485 941#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '796 965 864#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '324 573 228#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '958 926 815#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '559 307 51#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '346 309 222#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '523 763 937#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '562 139 269#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '444 614 301#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '767 022 700#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '350 207 934#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '652 694 6#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '941 712 583#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '702 691 531#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '851 800 358#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '421 982 576#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '925 049 356#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '979 135 388#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '847 001 743#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '431 042 257#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '720 252 582#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '621 716 639#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '769 312 662#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '897 037 100#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '999 456 97#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '796 741 472#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '708 253 045#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '868 638 140#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '403 352 480#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '152 991 469#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '466 256 56#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '269 959 292#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '810 098 93#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '568 987 952#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '440 450 232');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '261 512 925#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '409 770 573#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '495 071 267#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '927 312 007#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '853 780 771#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '166 873 724#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '510 160 636#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '349 010 367#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '360 997 139#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '129 460 90#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '923 783 680#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '387 751 163#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '198 985 992#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '853 278 04#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '732 018 12#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '300 630 022#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '369 454 76#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '210 409 821#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '821 318 895#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '884 948 439#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '330 955 573#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '611 394 603#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '807 341 598#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '706 870 52#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '514 396 367#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '800 088 061#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '784 145 306#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '518 345 70#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '975 918 722#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '353 246 460#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '697 177 987#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '239 573 84#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '105 913 790#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '417 902 984#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '183 869 428#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '539 536 696#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '104 734 247#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '944 637 647#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '509 339 604#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '555 594 108#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '653 088 465#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '859 850 730#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '509 417 625#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '960 131 068#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '636 016 038#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '580 972 67#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '662 149 641#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '357 831 278#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '659 501 734#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '373 697 38#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '952 538 820#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '853 614 809#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '790 510 703#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '880 338 174#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '214 075 888#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '945 173 483#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '134 975 221#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '782 551 028#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '416 121 20#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '241 262 73#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '712 653 472#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '417 197 155#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '479 417 487#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '234 916 148#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '429 640 786#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '591 250 399#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '436 341 550#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '467 850 043#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '570 514 391#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '166 486 055#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '146 137 458#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '248 160 458#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '673 715 681#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '199 310 385#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '725 235 053#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '838 641 295#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '914 002 064#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '677 038 211#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '921 296 905#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '771 505 325#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '417 352 670#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '737 552 265#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '935 363 58#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '947 070 272#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '858 013 802#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '552 401 811#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '501 121 085#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '392 981 406#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '784 918 334#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '443 449 47#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '411 791 369#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '148 454 887#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '907 320 491#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '802 411 460#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '698 136 48#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '657 198 089#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '461 130 2#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '764 967 106#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '307 291 074#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '863 653 738#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '638 164 601#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '894 763 344#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '996 622 836#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '195 724 746#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '896 343 603#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '525 813 92#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '579 172 781#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '675 356 507#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '494 687 761#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '128 623 546#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '165 091 248#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '703 149 09#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '679 788 260#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '907 587 854#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '492 745 97#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '351 173 324#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '368 852 598#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '786 419 997#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '459 376 965#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '615 943 390#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '810 732 678#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '183 628 890#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '663 475 845#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '647 274 315#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '624 448 247#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '131 566 11#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '794 200 761#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '218 049 320#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '767 610 49#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '124 942 35#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '268 071 196#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '351 742 576#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '296 612 077#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '188 861 831#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '881 451 017#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '292 781 999#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '477 396 128#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '964 985 116#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '923 928 956#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '733 335 253#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '969 575 89#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '395 376 062#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '750 622 106#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '186 351 498#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '326 758 409#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '852 079 90#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '477 052 596#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '287 253 812#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '786 060 185#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '710 140 453#
100');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '214 517 661#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '222 318 801#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '882 098 250#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '775 517 542#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '183 584 17#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '965 859 825#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '291 863 91#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '927 842 116#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '117 128 571#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '374 145 425#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '438 499 544#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '300 911 530#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '903 692 109#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '291 705 258#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '863 809 663#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '736 762 210#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '439 858 554#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '390 099 177#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '768 282 909#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '594 564 897#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '438 061 494#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '235 121 321#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '817 063 909#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '960 514 963#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '120 276 17#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '180 490 279#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '501 167 806#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '365 414 910#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '456 907 073#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '566 168 232#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '481 046 151#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '498 943 198#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '230 268 796#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '662 873 335#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '330 925 728#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '941 745 729#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '557 323 698#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '977 831 566#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '776 920 300#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '447 361 682#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '776 827 667#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '380 023 982#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '335 295 024#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '303 635 265#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '888 498 28#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '177 656 270#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '252 320 110#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '793 788 114#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '819 188 776#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '998 782 285#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '623 012 692#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '136 442 754#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '488 155 004#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '751 766 318#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '356 054 896#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '938 103 078#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '644 785 637#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '628 652 28#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '716 067 176#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '488 623 15#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '846 483 762#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '156 958 88#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '355 715 369#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '774 664 673#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '171 179 460#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '812 542 284#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '455 183 014#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '777 176 827#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '947 608 47#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '977 285 590#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '872 892 44#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '250 660 215#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '469 525 425#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '299 484 760#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '228 915 47#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '777 820 037#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '384 849 027#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '866 762 433#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '364 340 981#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '211 381 175#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '433 167 282#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '936 688 86#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '911 991 25#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '857');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '351 821 161#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '359 638 417#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '819 909 337#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '626 888 590#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '236 260 981#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '189 207 437#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '378 248 015#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '834 840 0#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '492 370 398#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '195 469 29#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '675 588 912#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '809 699 083#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '395 811 676#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '110 747 199#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '610 513 968#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '288 647 256#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '733 578 918#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '415 747 599#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '888 634 360#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '134 890 397#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '791 926 760#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '996 571 359#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '177 313 286#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '497 678 373#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '152 514 259#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '813 559 320#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '489 688 979#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '596 356 94#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '762 036 631#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '677 668 511#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '688 414 349#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '332 911 056#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '398 971 87#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '332 315 693#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '494 797 67#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '267 177 390#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '181 266 727#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '918 111 650#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '861 725 610#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '459 885 972#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '621 449 645#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '316 696 618#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '964 208 631#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '861 361 733#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '428 622 687#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '814 427 626#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '670 037 357#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '418 849 187#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '524 209 157#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '504 560 498#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '692 805 20#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '237 730 953#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '821 560 396#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '347 660 252#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '652 794 347#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '129 059 476#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '904 612 629#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '851 615 665#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '506 939 743#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '776 861 695#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '921 591 964#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '715 080 283#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '513 827 80#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '404 326 078#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '426 281 508#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '113 775 176#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '362 684 889#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '429 121 746#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '175 789 708#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '942 554 837#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '969 689 940#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '571 759 120#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '121 554 124#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '482 862 171#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '860 280 578#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '596 634 377#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '262 852 895#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '866 428 62#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '450 095 994#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '540 013 22#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '609 169 979#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '580 405 774#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '878 670 781#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '974 111 253#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '671 901 338#
2025');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '943 917 072#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '928 390 94#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '807 472 273#');
INSERT INTO ms_teams_links (region, conference_id) VALUES ('pp_amalgamated', '555 412 024#
2025');

-- ============================================
-- VERIFY IMPORT
-- ============================================

SELECT 'courts' as table_name, COUNT(*) as record_count FROM courts
UNION ALL SELECT 'police_cells', COUNT(*) FROM police_cells
UNION ALL SELECT 'correctional_facilities', COUNT(*) FROM correctional_facilities
UNION ALL SELECT 'bail_contacts', COUNT(*) FROM bail_contacts
UNION ALL SELECT 'bail_coordinators', COUNT(*) FROM bail_coordinators
UNION ALL SELECT 'crown_contacts', COUNT(*) FROM crown_contacts
UNION ALL SELECT 'labc_offices', COUNT(*) FROM labc_offices
UNION ALL SELECT 'labc_navigators', COUNT(*) FROM labc_navigators
UNION ALL SELECT 'duty_counsel_lawyers', COUNT(*) FROM duty_counsel_lawyers
UNION ALL SELECT 'forensic_clinics', COUNT(*) FROM forensic_clinics
UNION ALL SELECT 'indigenous_justice_centres', COUNT(*) FROM indigenous_justice_centres
UNION ALL SELECT 'ms_teams_links', COUNT(*) FROM ms_teams_links
UNION ALL SELECT 'programs', COUNT(*) FROM programs
UNION ALL SELECT 'access_codes', COUNT(*) FROM access_codes
UNION ALL SELECT 'circuit_courts', COUNT(*) FROM circuit_courts
ORDER BY table_name;
