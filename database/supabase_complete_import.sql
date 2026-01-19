-- BC Legal Reference Database - Complete Data Import (UPDATED)
-- Generated: 2025-01-19
-- Total Records: 907+
-- 
-- HOW TO USE:
-- 1. Go to your Supabase Dashboard: https://supabase.com/dashboard
-- 2. Click on "SQL Editor" in the left sidebar
-- 3. Create a new query
-- 4. Paste this entire file
-- 5. Click "Run" to execute

-- ============================================
-- ENABLE EXTENSIONS
-- ============================================
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- ============================================
-- DROP AND RECREATE TABLES
-- ============================================

-- Bail Offices (NEW)
DROP TABLE IF EXISTS bail_offices CASCADE;
CREATE TABLE bail_offices (
    id SERIAL PRIMARY KEY,
    region VARCHAR(10),
    location VARCHAR(255),
    email VARCHAR(255),
    type VARCHAR(50),
    hours TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Federal Crown Contacts (NEW)
DROP TABLE IF EXISTS federal_crown_contacts CASCADE;
CREATE TABLE federal_crown_contacts (
    id SERIAL PRIMARY KEY,
    region VARCHAR(10),
    area TEXT,
    firm VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Evening Crown Contacts (NEW)
DROP TABLE IF EXISTS evening_crown_contacts CASCADE;
CREATE TABLE evening_crown_contacts (
    id SERIAL PRIMARY KEY,
    region VARCHAR(10),
    name VARCHAR(255),
    role VARCHAR(100),
    email VARCHAR(255),
    phone VARCHAR(50),
    mobile VARCHAR(50),
    type VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Crown Offices (NEW)
DROP TABLE IF EXISTS crown_offices CASCADE;
CREATE TABLE crown_offices (
    id SERIAL PRIMARY KEY,
    region VARCHAR(10),
    courtroom VARCHAR(20),
    location VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Sheriff Cells Access (NEW)
DROP TABLE IF EXISTS sheriff_cells_access CASCADE;
CREATE TABLE sheriff_cells_access (
    id SERIAL PRIMARY KEY,
    region VARCHAR(10),
    location VARCHAR(255),
    phone VARCHAR(100),
    access TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Registry Contacts (NEW)
DROP TABLE IF EXISTS registry_contacts CASCADE;
CREATE TABLE registry_contacts (
    id SERIAL PRIMARY KEY,
    region VARCHAR(10),
    court VARCHAR(255),
    code VARCHAR(10),
    email VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Justice Centre Links (NEW)
DROP TABLE IF EXISTS justice_centre_links CASCADE;
CREATE TABLE justice_centre_links (
    id SERIAL PRIMARY KEY,
    region VARCHAR(20),
    name VARCHAR(255),
    conference_id VARCHAR(50),
    phone VARCHAR(50),
    toll_free VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW()
);

-- VB Triage Links (NEW)
DROP TABLE IF EXISTS vb_triage_links CASCADE;
CREATE TABLE vb_triage_links (
    id SERIAL PRIMARY KEY,
    region VARCHAR(10),
    location VARCHAR(255),
    conference_id VARCHAR(50),
    phone VARCHAR(50),
    toll_free VARCHAR(50),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Courts
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

-- Bail Coordinators
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
    created_at TIMESTAMP DEFAULT NOW()
);

-- LABC Navigators
CREATE TABLE IF NOT EXISTS labc_navigators (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(50),
    email VARCHAR(255),
    courts TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Forensic Clinics
CREATE TABLE IF NOT EXISTS forensic_clinics (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address TEXT,
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
    created_at TIMESTAMP DEFAULT NOW()
);

-- ============================================
-- INSERT DATA
-- ============================================


-- BAIL OFFICES (17 records)
TRUNCATE TABLE bail_offices RESTART IDENTITY CASCADE;
INSERT INTO bail_offices (region, location, email, type, hours) VALUES ('R3', 'Abbotsford', 'Abbotsford.VirtualBail@gov.bc.ca', 'daytime', 'Weekday daytime');
INSERT INTO bail_offices (region, location, email, type, hours) VALUES ('R3', 'Chilliwack', 'Chilliwack.VirtualBail@gov.bc.ca', 'daytime', 'Weekday daytime');
INSERT INTO bail_offices (region, location, email, type, hours) VALUES ('R3', 'New Westminster', 'NewWestProv.VirtualBail@gov.bc.ca', 'daytime', 'Weekday daytime');
INSERT INTO bail_offices (region, location, email, type, hours) VALUES ('R3', 'Port Coquitlam', 'PoCo.VirtualBail@gov.bc.ca', 'daytime', 'Weekday daytime');
INSERT INTO bail_offices (region, location, email, type, hours) VALUES ('R3', 'Surrey', 'Surrey.VirtualBail@gov.bc.ca', 'daytime', 'Weekday daytime');
INSERT INTO bail_offices (region, location, email, type, hours) VALUES ('R3', 'Fraser After-Hours', 'Surrey.VirtualBail@gov.bc.ca', 'after_hours', 'Evenings, weekends, holidays');
INSERT INTO bail_offices (region, location, email, type, hours) VALUES ('R4', 'Interior Daytime', 'Region4.VirtualBail@gov.bc.ca', 'daytime', 'Weekday daytime');
INSERT INTO bail_offices (region, location, email, type, hours) VALUES ('R4', 'Interior After-Hours', 'AGBCPSReg4BailKelownaGen@gov.bc.ca', 'after_hours', 'Evenings, weekends, holidays');
INSERT INTO bail_offices (region, location, email, type, hours) VALUES ('R1', 'Island Daytime', 'Region1.VirtualBail@gov.bc.ca', 'daytime', 'Weekday daytime');
INSERT INTO bail_offices (region, location, email, type, hours) VALUES ('R1', 'Island After-Hours', 'VictoriaCrown.Public@gov.bc.ca', 'after_hours', 'Evenings, weekends, holidays');
INSERT INTO bail_offices (region, location, email, type, hours) VALUES ('R5', 'North All Hours', 'Region5.VirtualBail@gov.bc.ca', 'all_hours', 'All bail matters');
INSERT INTO bail_offices (region, location, email, type, hours) VALUES ('R2', '222 Main/DCC', '222MainCrownBail@gov.bc.ca', 'daytime', 'Weekday daytime');
INSERT INTO bail_offices (region, location, email, type, hours) VALUES ('R2', 'North Vancouver', 'NorthVanCrown@gov.bc.ca', 'daytime', 'Weekday daytime');
INSERT INTO bail_offices (region, location, email, type, hours) VALUES ('R2', 'Richmond', 'RichmondCrown@gov.bc.ca', 'daytime', 'Weekday daytime');
INSERT INTO bail_offices (region, location, email, type, hours) VALUES ('R2', 'Sechelt', 'SecheltCrown@gov.bc.ca', 'daytime', 'Weekday daytime');
INSERT INTO bail_offices (region, location, email, type, hours) VALUES ('R2', 'Vancouver Youth', 'VancouverYouthCrown@gov.bc.ca', 'daytime', 'Weekday daytime');
INSERT INTO bail_offices (region, location, email, type, hours) VALUES ('R2', 'Vancouver Coastal After-Hours', '222MainCrownBail@gov.bc.ca', 'after_hours', 'Evenings, weekends, holidays');

-- FEDERAL CROWN CONTACTS (13 records)
TRUNCATE TABLE federal_crown_contacts RESTART IDENTITY CASCADE;
INSERT INTO federal_crown_contacts (region, area, firm, email, phone) VALUES ('R1', 'Victoria & Colwood', 'Jones & Co', 'Vicinfo@joneslaw.ca', '250-220-6942');
INSERT INTO federal_crown_contacts (region, area, firm, email, phone) VALUES ('R1', 'Nanaimo & Duncan', 'Jones & Co', 'Naninfo@joneslaw.ca', '250-714-1113');
INSERT INTO federal_crown_contacts (region, area, firm, email, phone) VALUES ('R1', 'Campbell River, Courtenay, Port Alberni, Port Hardy, Tofino', 'Jones & Co', 'Naninfo@joneslaw.ca', '250-714-1113');
INSERT INTO federal_crown_contacts (region, area, firm, email, phone) VALUES ('R3', 'Surrey, Langley, Delta, White Rock', 'PPSC Surrey Office', 'PPSC.SurreyInCustody-EnDetentionSurrey.SPPC@ppsc-sppc.gc.ca', '236-456-0015');
INSERT INTO federal_crown_contacts (region, area, firm, email, phone) VALUES ('R3', 'Port Coquitlam & New Westminster', 'MTC Law', 'pbachra@mtclaw.ca', '604-590-8855');
INSERT INTO federal_crown_contacts (region, area, firm, email, phone) VALUES ('R3', 'Chilliwack & Abbotsford', 'JM LeDressay & Associates', 'jir@jmldlaw.com', '604-514-8203');
INSERT INTO federal_crown_contacts (region, area, firm, email, phone) VALUES ('R4', 'Kamloops, Ashcroft, Chase, Clearwater, Lillooet, Lytton, Merritt, Salmon Arm', 'MTC Law', 'pbachra@mtclaw.ca', '604-590-8855');
INSERT INTO federal_crown_contacts (region, area, firm, email, phone) VALUES ('R4', 'Kelowna, Penticton, Oliver, Osoyoos, Summerland, Princeton, Vernon', 'JM LeDressay & Associates', 'jir@jmldlaw.com', '604-514-8203');
INSERT INTO federal_crown_contacts (region, area, firm, email, phone) VALUES ('R4', 'Kootenays (Castlegar, Cranbrook, Creston, Fernie, Golden, Grand Forks, Invermere, Nakusp, Nelson, Rossland, Trail)', 'PPSC Surrey Office', 'VAN.Detention.VAN@ppsc-sppc.gc.ca', '604-354-9146');
INSERT INTO federal_crown_contacts (region, area, firm, email, phone) VALUES ('R5', 'Prince George, Smithers, Terrace, Burns Lake, Vanderhoof, Hazelton, Houston, Kitimat', 'Yalowsky Sudeyko Lucky', 'Richard@luckylaw.ca', '250-562-2316');
INSERT INTO federal_crown_contacts (region, area, firm, email, phone) VALUES ('R5', 'Peace Region (Dawson Creek, Fort Nelson, Fort St. John, Chetwynd)', 'PPSC Main Street', 'VAN.Detention.VAN@ppsc-sppc.gc.ca', '604-666-2141');
INSERT INTO federal_crown_contacts (region, area, firm, email, phone) VALUES ('R5', 'Masset, Queen Charlotte', 'PPSC BCRO', 'Adrienne.Switzer@ppsc-sppc.gc.ca', '604-230-8632');
INSERT INTO federal_crown_contacts (region, area, firm, email, phone) VALUES ('R5', '100 Mile House, McBride, Valemount, Williams Lake', 'MTC Law', 'pbachra@mtclaw.ca', '604-590-8855');

-- EVENING CROWN CONTACTS (9 records)
TRUNCATE TABLE evening_crown_contacts RESTART IDENTITY CASCADE;
INSERT INTO evening_crown_contacts (region, name, role, email, phone, mobile, type) VALUES ('R1', 'Island Evening Team', NULL, 'VictoriaCrown.Public@gov.bc.ca', NULL, NULL, 'team_email');
INSERT INTO evening_crown_contacts (region, name, role, email, phone, mobile, type) VALUES ('R1', 'Megan Saben', 'Legal Assistant', 'Megan.saben@gov.bc.ca', '236-748-1481', NULL, NULL);
INSERT INTO evening_crown_contacts (region, name, role, email, phone, mobile, type) VALUES ('R1', 'Jillian Pawlow', 'Crown Counsel', 'Jillian.Pawlow@gov.bc.ca', '236-478-3732', NULL, NULL);
INSERT INTO evening_crown_contacts (region, name, role, email, phone, mobile, type) VALUES ('R1', 'Mark Halston', 'Crown Counsel (Backup)', 'Mark.Halston@gov.bc.ca', '778-405-1775', '250-507-9104', NULL);
INSERT INTO evening_crown_contacts (region, name, role, email, phone, mobile, type) VALUES ('R4', 'Interior Evening Team', NULL, 'AGBCPSReg4BailKelownaGen@gov.bc.ca', NULL, NULL, 'team_email');
INSERT INTO evening_crown_contacts (region, name, role, email, phone, mobile, type) VALUES ('R4', 'Izabel Bonilla', 'Legal Assistant', 'izabel.bonilla@gov.bc.ca', '778-943-7129', NULL, NULL);
INSERT INTO evening_crown_contacts (region, name, role, email, phone, mobile, type) VALUES ('R4', 'Traci Denman', 'Legal Assistant (Backup)', 'Traci.denman@gov.bc.ca', '778-943-0176', NULL, NULL);
INSERT INTO evening_crown_contacts (region, name, role, email, phone, mobile, type) VALUES ('R4', 'Sheron O''Connor', 'Crown Counsel', 'Sheron.oconnor@gov.bc.ca', '250-645-9160', '250-570-1422', NULL);
INSERT INTO evening_crown_contacts (region, name, role, email, phone, mobile, type) VALUES ('R4', 'Bill Hilderman', 'Crown Counsel (Backup)', 'Bill.hilderman@gov.bc.ca', '778-824-0097', NULL, NULL);

-- CROWN OFFICES (26 records)
TRUNCATE TABLE crown_offices RESTART IDENTITY CASCADE;
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R1', 'VR9', 'Campbell River', 'CampbellRiver.CrownSchedule@gov.bc.ca', '250-286-7544');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R1', 'VR9', 'Courtenay', 'Courtenay.CrownSchedule@gov.bc.ca', '250-334-1120');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R1', 'VR9', 'Nanaimo', 'Nanaimo.CrownSchedule@gov.bc.ca', '250-741-3711');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R1', 'VR9', 'Port Alberni', 'PtAlberni.CrownSchedule@gov.bc.ca', '250-720-2433');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R1', 'VR9', 'Port Hardy', 'PortHardy.CrownSchedule@gov.bc.ca', '250-949-8644');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R1', 'VR9', 'Powell River', 'PowellRiver.Crown@gov.bc.ca', '604-485-3645');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R1', 'VR8', 'Colwood', 'Colwood.Crown@gov.bc.ca', '250-391-2866');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R1', 'VR8', 'Duncan', 'BCPS.Duncan.Reception@gov.bc.ca', '250-746-1229');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R1', 'VR8', 'Victoria', 'VictoriaCrown.Public@gov.bc.ca', '250-387-4481');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R4', 'VR3', 'Kelowna', 'BCPS.KelownaGen@gov.bc.ca', '250-470-6822');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R4', 'VR3', 'Cranbrook', 'BCPS.CranbrookGen@gov.bc.ca', '250-426-1525');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R4', 'VR3', 'Nelson', 'BCPS.NelsonGen@gov.bc.ca', '250-354-6511');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R4', 'VR3', 'Penticton', 'BCPS.PentictonGen@gov.bc.ca', '250-487-4455');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R4', 'VR4', 'Kamloops', 'BCPS.KamloopsGen@gov.bc.ca', '250-828-4021');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R4', 'VR4', 'Salmon Arm', 'BCPS.SalmonArmGen@gov.bc.ca', '250-832-1651');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R4', 'VR4', 'Vernon', 'BCPS.VernonGen@gov.bc.ca', '250-503-3643');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R5', 'VR1', 'Prince George', 'PrGeorge.Crown@gov.bc.ca', '250-614-2601');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R5', 'VR1', 'Quesnel', 'Quesnel.Crown@gov.bc.ca', '250-992-4262');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R5', 'VR1', 'Vanderhoof', 'Vanderhoof.Crown@gov.bc.ca', '250-567-6835');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R5', 'VR1', 'Williams Lake', 'WilliamsLake.Crown@gov.bc.ca', '250-398-4473');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R5', 'VR2', 'Dawson Creek', 'DawsonCreek.CrownCounsel@gov.bc.ca', '250-784-2290');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R5', 'VR2', 'Fort Nelson', 'FortNelson.Crown@gov.bc.ca', '250-774-5984');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R5', 'VR2', 'Fort St. John', 'FtStJohn.Crown@gov.bc.ca', '250-787-3276');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R5', 'VR2', 'Prince Rupert', 'PrinceRupert.Crown@gov.bc.ca', '250-624-7440');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R5', 'VR2', 'Smithers', 'Smithers.Crown@gov.bc.ca', '250-847-7364');
INSERT INTO crown_offices (region, courtroom, location, email, phone) VALUES ('R5', 'VR2', 'Terrace', 'Terrace.Crown@gov.bc.ca', '250-638-2131');

-- SHERIFF CELLS ACCESS (8 records)
TRUNCATE TABLE sheriff_cells_access RESTART IDENTITY CASCADE;
INSERT INTO sheriff_cells_access (region, location, phone, access) VALUES ('R3', 'Abbotsford', '604-855-3239', 'Virtual, In-person, Telephone');
INSERT INTO sheriff_cells_access (region, location, phone, access) VALUES ('R3', 'Chilliwack', '604-795-8328', 'Virtual, In-person, Telephone');
INSERT INTO sheriff_cells_access (region, location, phone, access) VALUES ('R3', 'New Westminster', '604-660-8545', 'Virtual, In-person, Telephone');
INSERT INTO sheriff_cells_access (region, location, phone, access) VALUES ('R3', 'Port Coquitlam', '604-927-2195', 'Virtual, In-person, Telephone');
INSERT INTO sheriff_cells_access (region, location, phone, access) VALUES ('R3', 'Surrey', '236-455-1797 or 604-572-2194', 'Virtual, In-person, Telephone');
INSERT INTO sheriff_cells_access (region, location, phone, access) VALUES ('R2', 'Vancouver Provincial (Level 0)', '604-775-2522', 'Virtual, In-person, Telephone');
INSERT INTO sheriff_cells_access (region, location, phone, access) VALUES ('R2', 'North Vancouver', '604-981-0236', 'Virtual, In-person, Telephone');
INSERT INTO sheriff_cells_access (region, location, phone, access) VALUES ('R2', 'Richmond', '604-660-7769 (QB) or 604-660-3467', 'Virtual, In-person, Telephone');

-- REGISTRY CONTACTS (33 records)
TRUNCATE TABLE registry_contacts RESTART IDENTITY CASCADE;
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Prince George Provincial Court', 'PG', 'csbpg.criminalregistry@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Anahim Lake Provincial Court', 'AL', 'Office15231@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', '100 Mile House Law Courts', 'OMH', 'Office15231@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Fort St James Provincial Court', 'FSJ', 'csbpg.criminalregistry@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Fraser Lake Provincial Court', 'FL', 'csbpg.criminalregistry@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Kwadacha Provincial Court', 'KWA', 'Office15216@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Mackenzie Provincial Court', 'MAC', 'Office15216@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'McBride Provincial Court', 'MCB', 'Office15215@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Quesnel Law Courts', 'QUE', 'Office15230@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Tsay Keh Dene Provincial Court', 'TKD', 'csbpg.criminalregistry@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Valemount Provincial Court', 'VAL', 'Office15215@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Vanderhoof Law Courts', 'VHF', 'csbpg.criminalregistry@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Williams Lake Law Courts', 'WL', 'Office15231@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Atlin Provincial Court', 'ATL', 'Office15228@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Burns Lake Provincial Court', 'BL', 'Office15219@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Dease Lake Provincial Court', 'DL', 'Office15222@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Good Hope Lake Provincial Court', 'GHL', 'Office15228@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Hazelton Provincial Court', 'HAZ', 'Office15224@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Houston Provincial Court', 'HOU', 'Office15224@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Kitimat Law Courts', 'KIT', 'Office15222@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Lower Post Provincial Court', 'LP', 'Office15228@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Masset Provincial Court', 'MAS', 'VCMassetCrt@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'New Aiyansh Provincial Court', 'NEA', 'Office15222@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Prince Rupert Law Courts', 'PR', 'Office15220@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Queen Charlotte Provincial Court', 'QCC', 'Office15220@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Smithers Law Courts', 'SMI', 'Office15224@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Stewart Law Courts', 'STE', 'Office15222@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Terrace Law Courts', 'TER', 'Office15222@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Chetwynd Provincial Court', 'CHE', 'Office15226@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Dawson Creek Law Courts', 'DC', 'Office15226@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Fort Nelson Law Courts', 'FN', 'Office15229@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Fort St John Law Courts', 'FOS', 'Office15228@gov.bc.ca');
INSERT INTO registry_contacts (region, court, code, email) VALUES ('R5', 'Tumbler Ridge Provincial Court', 'TR', 'Office15226@gov.bc.ca');

-- JUSTICE CENTRE LINKS (7 records)
TRUNCATE TABLE justice_centre_links RESTART IDENTITY CASCADE;
INSERT INTO justice_centre_links (region, name, conference_id, phone, toll_free) VALUES ('R2', 'Vancouver Coastal Evening & Weekend', '732 076 358', '+1 778-725-6348', '(844) 636-7837');
INSERT INTO justice_centre_links (region, name, conference_id, phone, toll_free) VALUES ('R5', 'Northern Region Evening & Weekend', '365 751 988', '+1 778-725-6348', '(844) 636-7837');
INSERT INTO justice_centre_links (region, name, conference_id, phone, toll_free) VALUES ('R3', 'Surrey Region Evening & Weekend', '618 706 537', '+1 778-725-6348', '(844) 636-7837');
INSERT INTO justice_centre_links (region, name, conference_id, phone, toll_free) VALUES ('R4', 'Interior Region Evening & Weekend', '453 417 829', '+1 778-725-6348', '(844) 636-7837');
INSERT INTO justice_centre_links (region, name, conference_id, phone, toll_free) VALUES ('R3', 'Fraser Region Evening & Weekend', '938 770 945', '+1 778-725-6348', '(844) 636-7837');
INSERT INTO justice_centre_links (region, name, conference_id, phone, toll_free) VALUES ('R1', 'Island Region Evening & Weekend', '210 409 821', '+1 778-725-6348', '(844) 636-7837');
INSERT INTO justice_centre_links (region, name, conference_id, phone, toll_free) VALUES ('Federal', 'Federal 24 Hours', '634 183 845', '+1 778-725-6348', '(844) 636-7837');

-- VB TRIAGE LINKS (16 records)
TRUNCATE TABLE vb_triage_links RESTART IDENTITY CASCADE;
INSERT INTO vb_triage_links (region, location, conference_id, phone, toll_free) VALUES ('R3', 'Abbotsford Triage', '414 202 059', '+1 778-725-6348', '(844) 636-7837');
INSERT INTO vb_triage_links (region, location, conference_id, phone, toll_free) VALUES ('R3', 'Abbotsford CR204', '342 802 541', '+1 778-725-6348', '(844) 636-7837');
INSERT INTO vb_triage_links (region, location, conference_id, phone, toll_free) VALUES ('R3', 'Port Coquitlam Triage', '131 566 11', '+1 778-725-6348', '(844) 636-7837');
INSERT INTO vb_triage_links (region, location, conference_id, phone, toll_free) VALUES ('R3', 'Port Coquitlam CR001', '679 788 260', '+1 778-725-6348', '(844) 636-7837');
INSERT INTO vb_triage_links (region, location, conference_id, phone, toll_free) VALUES ('R3', 'Surrey Triage', '136 442 754', '+1 778-725-6348', '(844) 636-7837');
INSERT INTO vb_triage_links (region, location, conference_id, phone, toll_free) VALUES ('R3', 'Surrey CR108', '409 841 398', '+1 778-725-6348', '(844) 636-7837');
INSERT INTO vb_triage_links (region, location, conference_id, phone, toll_free) VALUES ('R2', 'Vancouver Provincial Triage', '157 117 369', '+1 778-725-6348', '(844) 636-7837');
INSERT INTO vb_triage_links (region, location, conference_id, phone, toll_free) VALUES ('R2', 'Vancouver Provincial CR101', '181 066 25', '+1 778-725-6348', '(844) 636-7837');
INSERT INTO vb_triage_links (region, location, conference_id, phone, toll_free) VALUES ('R2', 'North Vancouver Triage', '657 198 089', '+1 778-725-6348', '(844) 636-7837');
INSERT INTO vb_triage_links (region, location, conference_id, phone, toll_free) VALUES ('R2', 'North Vancouver CR1', '698 136 48', '+1 778-725-6348', '(844) 636-7837');
INSERT INTO vb_triage_links (region, location, conference_id, phone, toll_free) VALUES ('R2', 'Richmond Triage', '300 911 530', '+1 778-725-6348', '(844) 636-7837');
INSERT INTO vb_triage_links (region, location, conference_id, phone, toll_free) VALUES ('R2', 'Richmond CR107', '438 499 544', '+1 778-725-6348', '(844) 636-7837');
INSERT INTO vb_triage_links (region, location, conference_id, phone, toll_free) VALUES ('R4', 'VR3 (Kelowna, Penticton, Kootenays)', '787 097 137', '+1 778-725-6348', '(844) 636-7837');
INSERT INTO vb_triage_links (region, location, conference_id, phone, toll_free) VALUES ('R4', 'VR4 (Kamloops, Vernon, Salmon Arm)', '450 095 994', '+1 778-725-6348', '(844) 636-7837');
INSERT INTO vb_triage_links (region, location, conference_id, phone, toll_free) VALUES ('R1', 'VR8 (South Island - Victoria, Duncan)', '929 176 188', '+1 778-725-6348', '(844) 636-7837');
INSERT INTO vb_triage_links (region, location, conference_id, phone, toll_free) VALUES ('R1', 'VR9 (Nanaimo, North Island)', '893 653 923', '+1 778-725-6348', '(844) 636-7837');

-- COURTS (82 records)
TRUNCATE TABLE courts RESTART IDENTITY CASCADE;
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('100 Mile House', 'WilliamsLake.Crown@gov.bc.ca', 'Cariboo.Scheduling@provincialcourt.bc.ca', 'Office15231@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Abbotsford (Provincial)', 'BCPS.Abbotsford.Reception@gov.bc.ca', 'Abbotsford.CriminalScheduling@provincialcourt.bc.ca', '', 'AbbotsfordCriminalRegistry@gov.bc.ca', 'Abbotsford.VirtualBail@gov.bc.ca', 'Abbotsford.VirtualHybridBail@provincialcourt.bc.ca', 'Tina.Nguyen@gov.bc.ca
Sheila.Hedd@gov.bc.ca
Damaris.Stanciu@gov.bc.ca');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Abbotsford (Supreme)', '', 'sc.scheduling_ab@bccourts.ca', '', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Burns Lake (Provincial)', 'Smithers.Crown@gov.bc.ca', 'Smithers.Scheduling@provincialcourt.bc.ca', 'Office15219@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Campbell River (Provincial)', 'CampbellRiver.CrownSchedule@gov.bc.ca', 'CampbellRiver.Scheduling@provincialcourt.bc.ca', 'CampbellRiverRegistry@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Campbell River (Supreme)', '', 'sc.scheduling_na@bccourts.ca', '', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Cariboo', '', 'Cariboo.Scheduling@provincialcourt.bc.ca', '', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Chilliwack (Provincial)', 'BCPS.Chilliwack.Reception@gov.bc.ca', 'Chilliwack.Scheduling@provincialcourt.bc.ca', '', 'CSBChilliwackCriminalRegistry@gov.bc.ca', 'Chilliwack.VirtualBail@gov.bc.ca', 'Abbotsford.VirtualHybridBail@provincialcourt.bc.ca', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Chilliwack (Supreme)', '', 'sc.scheduling_cw@bccourts.ca', '[Fax Filing: 604-795-8397]', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Colwood/Western Communities', 'Colwood.Crown@gov.bc.ca', 'WestComm.CriminalScheduling@provincialcourt.bc.ca', 'wccregistry@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Courtenay (Provincial)', 'Courtenay.CrownSchedule@gov.bc.ca', 'Courtenay.Scheduling@provincialcourt.bc.ca', 'CourtenayRegistry@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Courtenay (Supreme)', '', 'sc.scheduling_na@bccourts.ca', '', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Cranbrook (Provincial)', 'BCPS.CranbrookGen@gov.bc.ca', 'EKootenays.Scheduling@provincialcourt.bc.ca', 'cranbrookcourtregistry@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Cranbrook (Supreme)', '', 'sc.scheduling_ka@bccourts.ca', '[Fax Filing: 250-426-1498]', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Criminal Appeals & Special Prosecutions', 'BCPS.CASPGen@gov.bc.ca', '', '', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Dawson Creek (Provincial)', 'DawsonCreek.CrownCounsel@gov.bc.ca', 'PeaceDistrict.CriminalScheduling@provincialcourt.bc.ca', 'office15226@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Dawson Creek (Supreme)', '', 'sc.scheduling_pg@bccourts.ca', '[Fax Filing: 250-784-2218]', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Duncan (Provincial)', 'BCPS.Duncan.Reception@gov.bc.ca', 'Dun.Scheduling@provincialcourt.bc.ca', 'JAGCSBDuncanCourtScheduling@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Duncan (Supreme)', '', 'sc.scheduling_na@bccourts.ca', '', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('East Kootenays', '', 'EKootenays.Scheduling@provincialcourt.bc.ca', '', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Federal Crown (General)', 'VAN.Detention.VAN@ppsc-sppc.gc.ca', '', '', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Federal Crown (Prince George)', 'susan@luckylaw.ca', '', '', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('First Nations Court (New West)', 'Lena.DalSanto@gov.bc.ca', '', '', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Fort Nelson', 'FortNelson.Crown@gov.bc.ca', 'Terrace.CriminalScheduling@provincialcourt.bc.ca', 'Office15229@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Fort St. John (Provincial)', 'FtStJohn.Crown@gov.bc.ca', 'PeaceDistrict.CriminalScheduling@provincialcourt.bc.ca', 'Office15228@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Fort St. John (Supreme)', '', 'sc.scheduling_pg@BCCourts.ca', '', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Golden (Provincial)', 'BCPS.CranbrookGen@gov.bc.ca', 'EKootenays.Scheduling@provincialcourt.bc.ca', 'GoldenCourtRegistry@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Golden (Supreme)', '', 'sc.scheduling_ka@bccourts.ca', '', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Kamloops (Provincial)', 'BCPS.KamloopsGen@gov.bc.ca', 'Kamloops.Scheduling@provincialcourt.bc.ca', 'KamloopsCourtRegistry@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Kamloops (Supreme)', '', 'sc.scheduling_ka@bccourts.ca', '[Fax Filing: 250-828-4345]', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Kelowna (Provincial)', 'KelownaCrown@gov.bc.ca', 'Kelowna.CriminalScheduling@provincialcourt.bc.ca', 'KelownaCourtRegistry@gov.bc.ca', 'CSB.KelownaCriminal@gov.bc.ca', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Kelowna (Supreme)', '', 'sc.scheduling_ok@bccourts.ca', '[Fax Filing: 250-979-6768]', 'CSB.KelownaSupreme@gov.bc.ca', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('MacKenzie', '', '', 'Office15216@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Nanaimo (Provincial)', 'Nanaimo.CrownSchedule@gov.bc.ca', 'Nanaimo.Scheduling@provincialcourt.bc.ca', '', 'crimreg.nanaimo@gov.bc.ca', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Nanaimo (Supreme)', '', 'sc.scheduling_na@bccourts.ca', '', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Nelson (Provincial)', 'BCPS.NelsonGen@gov.bc.ca', 'WKootenays.Scheduling@provincialcourt.bc.ca', 'NelsonCourtRegistry@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Nelson (Supreme)', '', 'sc.scheduling_ka@bccourts.ca', '[Fax Filing: 250-354-6133]', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('New Westminster (Provincial)', 'NewWestminsterProvincial@gov.bc.ca', 'NewWest.Scheduling@provincialcourt.bc.ca', 'JAGCSBNWestminsterCourtScheduling@gov.bc.ca', '', 'NewWestProv.VirtualBail@gov.bc.ca', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('New Westminster (Supreme)', 'CJB.NewWestRegionalCrown@gov.bc.ca', 'sc.scheduling_nw@BCCourts.ca', '', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('North Vancouver', 'NorthVanCrown@gov.bc.ca', 'NVan.Scheduling@provincialcourt.bc.ca', 'NorthVancouverRegistry@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Peace District', '', 'Peace.District.Scheduling@provincialcourt.bc.ca', '', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Penticton (Provincial)', 'BCPS.PentictonGen@gov.bc.ca', 'Penticton.Scheduling@provincialcourt.bc.ca', 'PentictonCourtRegistry@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Penticton (Supreme)', '', 'sc.scheduling_ok@bccourts.ca', '[Fax Filing: 250-492-1290]', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Port Alberni (Provincial)', 'PtAlberni.CrownSchedule@gov.bc.ca', 'PortAlberni.Scheduling@provincialcourt.bc.ca', 'PortAlberniRegistry@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Port Alberni (Supreme)', '', 'sc.scheduling_na@bccourts.ca', '', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Port Coquitlam (Provincial)', 'Poco.Crown@gov.bc.ca', 'PoCo.Scheduling@provincialcourt.bc.ca', '', 'csb.portcoquitlamprovcriminal@gov.bc.ca', 'Poco.VirtualBail@gov.bc.ca', 'Poco.VirtualHybridBail@provincialcourt.bc.ca', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Port Coquitlam (Supreme)', '', 'sc.scheduling_pc@bccourts.ca', '', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Port Hardy', 'PortHardy.CrownSchedule@gov.bc.ca', 'PortHardy.Scheduling@provincialcourt.bc.ca', 'porthardycourtregistry@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Powell River (Provincial)', 'PowellRiver.CrownSchedule@gov.bc.ca', 'PowellRiver.Scheduling@provincialcourt.bc.ca', 'powellriverregistry@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Powell River (Supreme)', '', 'sc.scheduling_na@bccourts.ca', '', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Prince George (Provincial)', 'PrGeorge.crown@gov.bc.ca', 'PG.Scheduling@provincialcourt.bc.ca', '', 'csbpg.criminalregistry@gov.bc.ca', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Prince George (Supreme)', '', 'sc.scheduling_pg@bccourts.ca', '[Fax Filing: 250-614-7923]', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Prince Rupert (Provincial)', 'PrinceRupert.Crown@gov.bc.ca', 'PrinceRupert.Scheduling@provincialcourt.bc.ca', 'Office15220@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Prince Rupert (Supreme)', '', 'sc.scheduling_pg@bccourts.ca', '', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Quesnel (Provincial)', 'Quesnel.Crown@gov.bc.ca', 'Cariboo.Scheduling@provincialcourt.bc.ca', 'Office15230@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Quesnel (Supreme)', '', 'sc.scheduling_pg@bccourts.ca', '', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Revelstoke (Supreme)', 'BCPS.SalmonArmGen@gov.bc.ca', 'sc.scheduling_ka@bccourts.ca', '', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Richmond (Provincial)', 'RichmondCrown@gov.bc.ca', 'Richmond.Scheduling@provincialcourt.bc.ca', 'RichmondCourtRegistry@gov.bc.ca', '', '', '', 'AGCSBRichmondInterpreters@gov.bc.ca');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Richmond (Federal)', 'ppscsupportstaff@mtclaw.ca', '', '', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Rossland (Provincial)', 'BCPS.NelsonGen@gov.bc.ca', 'WKootenays.Scheduling@provincialcourt.bc.ca', 'VCRosslandCrt@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Rossland (Supreme)', '', 'sc.scheduling_ka@bccourts.ca', '[Fax Filing: 250-362-7321]', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Salmon Arm (Provincial)', 'BCPS.SalmonArmGen@gov.bc.ca', 'SalmonArm.Scheduling@provincialcourt.bc.ca', 'SalmonArmRegistry@gov.bc.ca', 'JAGCSBSalmonArmScheduling@gov.bc.ca', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Salmon Arm (Supreme)', '', 'sc.scheduling_ka@bccourts.ca', '[Fax Filing: 250-833-7401]', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Sechelt', 'SecheltCrown@gov.bc.ca', 'NVan.Scheduling@provincialcourt.bc.ca', 'SecheltRegistry@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Smithers (Provincial)', 'Smithers.Crown@gov.bc.ca', 'Smithers.Scheduling@provincialcourt.bc.ca', 'Office15224@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Smithers (Supreme)', '', 'sc.scheduling_pg@bccourts.ca', '[Fax Filing: 250-847-7344]', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Surrey', 'Surrey.Intake@gov.bc.ca', 'Surrey.Scheduling@provincialcourt.bc.ca', '', 'CSBSurreyProvincialCourt.CriminalRegistry@gov.bc.ca', 'Surrey.VirtualBail@gov.bc.ca', 'Surrey.CriminalScheduling@provincialcourt.bc.ca', 'CSBSurreyProvincialCourt.AccountingandInterpreters@gov.bc.ca');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Surrey (Federal)', 'ppsc.surreyincustody-endetentionsurrey.sppc@ppsc-sppc.gc.ca', '', '', '', 'PPSC.SurreyInCustody-EnDetentionSurrey.SPPC@ppsc-sppc.gc.ca', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Terrace (Provincial)', 'Terrace.Crown@gov.bc.ca', 'Terrace.Scheduling@provincialcourt.bc.ca', 'Office15222@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Terrace (Supreme)', '', 'sc.scheduling_pg@bccourts.ca', '[Fax Filing: 250-638-2143]', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Valemount', 'PrGeorge.crown@gov.bc.ca', 'PG.Scheduling@provincialcourt.bc.ca', 'Office15215@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Vancouver 222 Main Street & DCC', '222MainCrownGeneral@gov.bc.ca', 'Van.Scheduling@provincialcourt.bc.ca', '222MainCS@gov.bc.ca
222MainTranscripts@gov.bc.ca', '', '', '', 'CSB222.InterpreterRequests@gov.bc.ca');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Vancouver Law Courts (Supreme)', 'VancouverRegionalCrown@gov.bc.ca', 'sc.criminal_va@BCcourts.ca', 'VancouverLawCourtsRegistry@gov.bc.ca', 'Vlc.criminal@gov.bc.ca', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Vancouver Youth (Robson)', 'VancouverYouthCrown@gov.bc.ca', 'Robson.Scheduling@provincialcourt.bc.ca', 'CSBRCS@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Vanderhoof', 'Vanderhoof.Crown@gov.bc.ca', 'PG.Scheduling@provincialcourt.bc.ca', '', 'csbpg.criminalregistry@gov.bc.ca', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Vernon (Provincial)', 'BCPS.VernonGen@gov.bc.ca', 'Vernon.Scheduling@provincialcourt.bc.ca', 'VernonRegistry@gov.bc.ca', 'JAGCSBVernonScheduling@gov.bc.ca', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Vernon (Supreme)', '', 'sc.scheduling_ok@bccourts.ca', '[Fax Filing: 250-549-5461]', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Victoria (Provincial)', 'VictoriaCrown.Public@gov.bc.ca', 'Vic.Scheduling@provincialcourt.bc.ca', '', 'vicprovincialreg@gov.bc.ca', '', '', 'victoria.finance@gov.bc.ca');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Victoria (Supreme)', '', 'sc.scheduling_vi@bccourts.ca', '', 'vicsupremereg@gov.bc.ca', '', '', 'victoria.finance@gov.bc.ca');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('West Kootenays', '', 'WKootenays.Scheduling@provincialcourt.bc.ca', '', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Williams Lake (Provincial)', 'WilliamsLake.Crown@gov.bc.ca', 'Cariboo.Scheduling@provincialcourt.bc.ca', 'Office15231@gov.bc.ca', '', '', '', '');
INSERT INTO courts (name, crown_email, jcm_scheduling_email, court_registry_email, criminal_registry_email, bail_crown_email, bail_jcm_email, interpreter_request_email) VALUES ('Williams Lake (Supreme)', '', 'sc.scheduling_pg@bccourts.ca', '[Fax Filing: 250-398-4264]', '', '', '', '');

-- POLICE CELLS (106 records)
TRUNCATE TABLE police_cells RESTART IDENTITY CASCADE;
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('100 Mile House RCMP', '7783329565.0', '7783329520.0', '2503952456.0', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Abbotsford CH', '6048553239.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Abbotsford PD', '6048644773.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Agassiz RCMP', '6047961618.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Alexis Creek RCMP', '2503944632.0', '2503944683.0', '2503944211.0', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Anahim Lake RCMP', '2507423214.0', '2507423509.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Armstrong RCMP', '2505463822.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Ashcroft RCMP', '2504532217.0', '2504532216.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Atlin RCMP', '2506517511.0', '2506517693.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Barriere RCMP', '2506729919.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Bella Bella RCMP', '2509572389.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Bella Coola RCMP', '2507995374.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Burnaby RCMP', '6046469633.0', '6046469986.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Burnaby YDC', '7784522050.0', '7784522051.0', '7784522110.0', '7784522111.0');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Burns Lake RCMP', '2506927171.0', '2506923905.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Castlegar RCMP', '2503653272.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Chase RCMP', '2506793912.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Chetwynd RCMP', '2507888181.0', '2507889221.0', '2507889111.0', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Chilliwack CH', '6047958328.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Chilliwack RCMP', '6047024199.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Clearwater RCMP', '2506742100.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Clinton RCMP', '2504592203.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Columbia Valley RCMP', '2503426266.0', '2503426769.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Coquitlam RCMP', '6049451565.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Cranbrook RCMP', '2504174207.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Creston RCMP', '2504280960.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Dawson Creek RCMP', '2507843715.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Dease Lake RCMP', '2507714603.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Duncan RCMP', '2507462109.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Elk Valley (Elkford, Fernie, Sparwood) RCMP', '2504252296.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Enderby RCMP', '2508389397.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Federal Crown In-Custody Clerk', '6046662141.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Federal Crown Office', '6046663033.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Fort Nelson RCMP', '2507744980.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Fort St. James RCMP', '2509968269.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Fort St. John RCMP', '2507878124.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Fraser Lake RCMP', '2506996215.0', '2506997777.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Golden RCMP', '2503444000.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Grand Forks RCMP', '2504423919.0', '2504428566.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Houston RCMP', '2508452868.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Hudson’s Hope RCMP', '2507835242.0', '2507839480.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Justice Centre', '6046604134.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Kamloops RCMP', '2508283094.0', '2508283270.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Kaslo RCMP', '2503532242.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Kelowna CH', '2504706841.0', '2504706816.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Kelowna RCMP', '2504706297.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Keremeos RCMP', '2504992500.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Kitimat RCMP', '2506392115.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Klemtu RCMP', '2508391247.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Langley RCMP', '6045323202.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Lillooet RCMP', '2502564722.0', '2502564244.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Lisims/Nass Valley RCMP', '2506332230.0', '2506332222.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Logan Lake RCMP', '2505236222.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Mackenzie RCMP', '2509973447.0', '2506263991.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Masset RCMP', '2506263697.0', '2506263991.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('McBride RCMP', '2505692255.0', '2505692260.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Merritt RCMP', '2503154623.0', '2503784262.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Midway RCMP', '2504428566.0', '2504423919.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Mission RCMP', '6048203543.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('New Hazelton RCMP', '2508424835.0', '2508425244.0', '2508426351.0', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('New West CH', '6046608545.0', '6046608543.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('New Westminster PD', '6045292469.0', '6045292470.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('North Vancouver CH', '6049810236.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('North Vancouver RCMP', '6049697487.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Pemberton RCMP', '6048946127.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Penticton RCMP', '2507704719.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('POCO CH', '6049272195.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('POCO RCMP', '6049451565.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Port Moody PD', '6049371325.0', '6049371333.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Prince George CH', '2367650633.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Prince George RCMP', '2502778950.0', '2505613300.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Prince Rupert RCMP', '2506270755.0', '2506270700.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Queen Charlotte RCMP', '2505594421.0', '2505594268.0', '2505594785.0', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Quesnel/Wells RCMP', '2509920500.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Richmond CH', '6046603467.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Richmond RCMP', '6042074894.0', '6042074785.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Ridge Meadows RCMP', '6044677680.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Saanich RCMP', '2504754270.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Smithers RCMP', '2508473233.0', '2508470238.0', '2508764034.0', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Squamish RCMP', '6048926124.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Stewart RCMP', '2506362865.0', '2508764034.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Sunshine Coast RCMP', '6047403204.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Surrey CH', '6045722270.0', '6045722156.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Surrey RCMP', '6045997765.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Takla Landing RCMP', '2509968574.0', '2509967847.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Terrace CH', '2506382121.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Terrace RCMP', '2506387431.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Tsay Keh Dene RCMP', '2509930000.0', '2509930001.0', '2509932185.0', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Tumbler Ridge RCMP', '2502425648.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('UFVRD/Hope/Boston Bar RCMP', '6048697772.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('University RCMP', '6042246981.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Valemount RCMP', '2505664457.0', '2505664466.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Vancouver 222 Cr 101', '6047752506.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Vancouver 222 Cr 102', '6047752508.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Vancouver 222 Sheriffs', '6047752522.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Vancouver PD', '6047179966.0', '6047173958.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Vancouver Youth', '6046608870.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Vanderhoof RCMP', '2505679228.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Vernon CH', '2502607185.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Victoria CH', '2503876571.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Victoria/Sechelt RCMP', '2504754321.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Watson Lake, Yukon Territory/Lower Post BC', '8675362677.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('West Vancouver PD', '6049277308.0', '6049257306.0', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Whistler RCMP', '6048946127.0', '6049051966.0', '6049320568.0', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('White Rock RCMP', '7785454780.0', '', '', '');
INSERT INTO police_cells (name, phone1, phone2, phone3, phone4) VALUES ('Williams Lake RCMP', '2503928728.0', '2503928737.0', '', '');

-- CORRECTIONAL FACILITIES (44 records)
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

-- BAIL CONTACTS (7 records)
TRUNCATE TABLE bail_contacts RESTART IDENTITY CASCADE;
INSERT INTO bail_contacts (region, name, email, type, notes) VALUES ('R1', 'Region 1 Virtual Bail', 'Region1.virtualbail@gov.bc.ca', 'daytime', NULL);
INSERT INTO bail_contacts (region, name, email, type, notes) VALUES ('R1', 'Victoria Crown', 'VictoriaCrown.Public@gov.bc.ca', 'evening', NULL);
INSERT INTO bail_contacts (region, name, email, type, notes) VALUES ('R2', '222 Main Crown Bail', '222MainCrownBail@gov.bc.ca', 'daytime', NULL);
INSERT INTO bail_contacts (region, name, email, type, notes) VALUES ('R3', 'Abbotsford Virtual Bail', 'Abbotsford.VirtualBail@gov.bc.ca', 'daytime', NULL);
INSERT INTO bail_contacts (region, name, email, type, notes) VALUES ('R3', 'Chilliwack Virtual Bail', 'Chilliwack.VirtualBail@gov.bc.ca', 'daytime', NULL);
INSERT INTO bail_contacts (region, name, email, type, notes) VALUES ('R4', 'Region 4 Virtual Bail', 'Region4.virtualbail@gov.bc.ca', 'daytime', NULL);
INSERT INTO bail_contacts (region, name, email, type, notes) VALUES ('R5', 'Region 5 Virtual Bail', 'Region5.virtualbail@gov.bc.ca', 'all_hours', NULL);

-- BAIL COORDINATORS (4 records)
TRUNCATE TABLE bail_coordinators RESTART IDENTITY CASCADE;
INSERT INTO bail_coordinators (name, region, email, phone, is_backup) VALUES ('Chloe Rathjen', 'R1 Island', 'chloe.rathjen@gov.bc.ca', '250-940-8522', FALSE);
INSERT INTO bail_coordinators (name, region, email, phone, is_backup) VALUES ('Pamela Robertson', 'R4 Interior', 'pamela.robertson@gov.bc.ca', '778-940-0050', FALSE);
INSERT INTO bail_coordinators (name, region, email, phone, is_backup) VALUES ('Angie Fryer', 'R4 Interior (Backup)', 'angie.fryer@gov.bc.ca', '250-312-511', FALSE);
INSERT INTO bail_coordinators (name, region, email, phone, is_backup) VALUES ('Jacqueline Ettinger', 'R5 North', 'jacqueline.ettinger@gov.bc.ca', '250-570-0422', FALSE);

-- CROWN CONTACTS (10 records)
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

-- LABC OFFICES (11 records)
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

-- LABC NAVIGATORS (8 records)
TRUNCATE TABLE labc_navigators RESTART IDENTITY CASCADE;
INSERT INTO labc_navigators (name, phone, email, courts) VALUES ('Conor', '236-333-1260', 'conor.navigator@legalaid.bc.ca', 'Victoria, Nanaimo, VR8, VR9');
INSERT INTO labc_navigators (name, phone, email, courts) VALUES ('Courtney', '236-788-7372', 'courtney.navigator@legalaid.bc.ca', 'Surrey');
INSERT INTO labc_navigators (name, phone, email, courts) VALUES ('Hana', '604-364-6541', 'hana.navigator@legalaid.bc.ca', 'VR4, VR2, Kamloops');
INSERT INTO labc_navigators (name, phone, email, courts) VALUES ('Imtaj', '236-818-7616', 'imtaj.navigator@legalaid.bc.ca', 'North Vancouver, Richmond');
INSERT INTO labc_navigators (name, phone, email, courts) VALUES ('Jennifer', '236-788-5291', 'jennifer.navigator@legalaid.bc.ca', 'Vancouver, DCC');
INSERT INTO labc_navigators (name, phone, email, courts) VALUES ('Naomi', '604-364-5873', 'naomi.navigator@legalaid.bc.ca', 'VR3, Penticton');
INSERT INTO labc_navigators (name, phone, email, courts) VALUES ('Navneet', '236-808-8931', 'navneet.navigator@legalaid.bc.ca', 'Abbotsford, Chilliwack');
INSERT INTO labc_navigators (name, phone, email, courts) VALUES ('Shewaye', '236-788-9268', 'shewaye.navigator@legalaid.bc.ca', 'PoCo, New Westminster');

-- FORENSIC CLINICS (7 records)
TRUNCATE TABLE forensic_clinics RESTART IDENTITY CASCADE;
INSERT INTO forensic_clinics (name, address, phone, email) VALUES ('Kamloops Forensic Regional Clinic', '5-1315 Summit Drive, Kamloops, BC V2C 5R9', '250-377-2660', 'KamloopsAdmitting@phsa.ca');
INSERT INTO forensic_clinics (name, address, phone, email) VALUES ('Kelowna Forensic Regional Clinic', '#115-1835 Gordon Drive, Kelowna, BC V1Y 3H5', '778-940-2100', 'KelownaAdmitting@phsa.ca');
INSERT INTO forensic_clinics (name, address, phone, email) VALUES ('Nanaimo Forensic Regional Clinic', '101-190 Wallace Street, Nanaimo, BC V9R 5B1', '250-739-5000', 'NanaimoAdmitting@phsa.ca');
INSERT INTO forensic_clinics (name, address, phone, email) VALUES ('Prince George Forensic Regional Clinic', '2nd Floor, 1584 7th Avenue, Prince George, BC V2L 3P4', '250-561-8060', 'PrinceGeorgeAdmitting@phsa.ca');
INSERT INTO forensic_clinics (name, address, phone, email) VALUES ('Surrey Forensic Regional Clinic', '10022 King George Boulevard, Surrey, BC V3T 2W4', '604-529-3300', 'SurreyAdmitting@phsa.ca');
INSERT INTO forensic_clinics (name, address, phone, email) VALUES ('Vancouver Forensic Regional Clinic', '300-307 West Broadway, Vancouver, BC V5Y 1P9', '604-529-3350', 'VancouverAdmitting@phsa.ca');
INSERT INTO forensic_clinics (name, address, phone, email) VALUES ('Victoria Forensic Regional Clinic', '2840 Nanaimo Street, Victoria, BC V8T 4W9', '250-213-4500', 'VictoriaAdmitting@phsa.ca');

-- INDIGENOUS JUSTICE CENTRES (10 records)
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

-- PROGRAMS (18 records)
TRUNCATE TABLE programs RESTART IDENTITY CASCADE;
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Talitha Koum', 'Coquitlam', '6044923393.0', 'All', FALSE, FALSE, 'Phone Call', '');
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Glory House', 'Mission', '6043803665.0', '', FALSE, FALSE, 'Phone Call', '');
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Lydia Home', 'Mission', '6042533323.0', '', FALSE, FALSE, 'Phone Call', '');
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Hannah House', 'Maple Ridge', '8664664215.0', '', FALSE, FALSE, 'Phone Call', '');
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Night & Day', 'Surrey', '7783174673.0', '', FALSE, FALSE, 'Phone Call', '');
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Vision Quest Hart House', 'Surrey', '6049461841.0', '', FALSE, FALSE, 'Phone Call', 'Will take people with SA records');
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Stepping Stone', 'Courtenay', '2508970360.0', '', FALSE, FALSE, 'Written', '');
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Amethyst', 'Campbell River', '2508702570.0', '', FALSE, FALSE, 'Written', '');
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('The Farm', 'Port Alberni', '', '', FALSE, FALSE, 'Written', '');
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Sancta Marie', 'Vancouver', '6047315550.0', '', FALSE, FALSE, 'Written', '');
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Turning Point (North Van)', 'North Van', '6049710111.0', '', FALSE, FALSE, 'Written', '');
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Turning Point (Van)', 'Vancouver', '6048751710.0', '', FALSE, FALSE, 'Written', '');
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Back On Track', 'Surrey', '7783162625.0', '', FALSE, FALSE, 'Phone Call', '');
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Raven’s Moon', 'Abbotsford', '', '', FALSE, TRUE, 'Phone Call', 'Jeanette 6047514631
Tina 6043081767');
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Ann Elmore House', 'Campbell River', '2502863666.0', '', FALSE, TRUE, 'Phone Call', '');
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('STAR Program', 'Pre-Treatment', '', '', FALSE, FALSE, 'Written', '');
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Riceblock', 'Post Treatment', '6042532553.0', '', FALSE, FALSE, 'Phone Call', '');
INSERT INTO programs (name, location, phone, gender, indigenous_only, in_residence, application_by, notes) VALUES ('Phoenix', '', '', '', FALSE, FALSE, '', 'Will take people with SA records');

-- ACCESS CODES (18 records)
TRUNCATE TABLE access_codes RESTART IDENTITY CASCADE;
INSERT INTO access_codes (court, code, notes) VALUES ('Chilliwack', '512.0', '');
INSERT INTO access_codes (court, code, notes) VALUES ('Court of Appeal', '', '');
INSERT INTO access_codes (court, code, notes) VALUES ('Cranbrook', '', '');
INSERT INTO access_codes (court, code, notes) VALUES ('Duncan', '', '');
INSERT INTO access_codes (court, code, notes) VALUES ('Fort St. John', '2&4, 3', '2 & 4 together🤘then 3 🖕');
INSERT INTO access_codes (court, code, notes) VALUES ('Nanaimo', '3179#', '');
INSERT INTO access_codes (court, code, notes) VALUES ('North Vancouver', '2355.0', '');
INSERT INTO access_codes (court, code, notes) VALUES ('Penticton', '', '');
INSERT INTO access_codes (court, code, notes) VALUES ('Port Coquitlam (Library)', '1379.0', '');
INSERT INTO access_codes (court, code, notes) VALUES ('Prince George (1st Floor)', '9588*', '');
INSERT INTO access_codes (court, code, notes) VALUES ('Prince Rupert', '266266.0', '');
INSERT INTO access_codes (court, code, notes) VALUES ('Richmond', '235#', '');
INSERT INTO access_codes (court, code, notes) VALUES ('Robson Square', '35.0', '');
INSERT INTO access_codes (court, code, notes) VALUES ('Sechelt', '36.0', 'BC Sport Fishing Reg paper on the window');
INSERT INTO access_codes (court, code, notes) VALUES ('Smithers', '', '');
INSERT INTO access_codes (court, code, notes) VALUES ('Terrace (Library and Lounge)', '254.0', '');
INSERT INTO access_codes (court, code, notes) VALUES ('Vancouver 222 Main', '235.0', '');
INSERT INTO access_codes (court, code, notes) VALUES ('Vancouver Supreme', '314.0', '');

-- CIRCUIT COURTS (48 records)
TRUNCATE TABLE circuit_courts RESTART IDENTITY CASCADE;
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('100 Mile House', '', 'Williams Lake');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Ahousaht', 'R1 - Island', 'Port Alberni');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Alexis Creek', '', 'Williams Lake');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Anahim Lake', '', 'Williams Lake');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Ashcroft', 'R4 - Interior', 'Kamloops');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Atlin', '', 'Fort St. John');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Bella Bella', '', 'Vancouver 222');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Bella Coola', '', 'Vancouver 222');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Castlegar', 'R4 - Interior', 'Nelson');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Chase', 'R4 - Interior', 'Kamloops');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Chetwynd', '', 'Dawson Creek');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Clearwater', 'R4 - Interior', 'Kamloops');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Creston', 'R4 - Interior', 'Cranbrook');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Daajing Giids/Queen Charlotte', '', 'Prince Rupert');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Dease Lake', '', 'Terrace');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Fernie', 'R4 - Interior', 'Cranbrook');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Fort St. James', '', 'Prince George');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Fraser Lake', '', 'Prince George');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Ganges', 'R1 - Island', 'Duncan');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Gold River', '', 'Campbell River');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Good Hope Lake', '', 'Fort St. John');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Grand Forks', '', 'Rossland');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Hazelton', '', 'Smithers');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Houston', '', 'Smithers');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Hudson''s Hope', '', 'Fort St. John');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Invermere', 'R4 - Interior', 'Cranbrook');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Kitimat', '', 'Terrace');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Klemtu', '', 'Vancouver 222');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Kwadacha/Fort Ware', '', 'Prince George');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Lillooet', 'R4 - Interior', 'Kamloops');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Lower Post', '', 'Fort St. John');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Masset', '', 'Prince Rupert');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('McBride', '', 'Valemount');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Merritt', 'R4 - Interior', 'Kamloops');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Nakusp', 'R4 - Interior', 'Nelson');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('New Aiyansh', '', 'Terrace');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Pemberton', '', 'North Vancouver');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Princeton', 'R4 - Interior', 'Penticton');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Revelstoke', 'R4 - Interior', 'Salmon Arm');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Sidney', 'R1 - Island', 'Victoria');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Sparwood', 'R4 - Interior', 'Cranbrook');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Stewart', '', 'Terrace');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Tahsis', 'R1 - Island', 'Campbell River');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Tofino', 'R1 - Island', 'Port Alberni');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Tsay Keh Dene (Ingenika)', '', 'Prince George');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Tumbler Ridge', '', 'Dawson Creek');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Ucluelet', 'R1 - Island', 'Port Alberni');
INSERT INTO circuit_courts (name, region, contact_hub) VALUES ('Vanderhoof', '', 'Prince George');

-- ============================================
-- CREATE INDEXES
-- ============================================

CREATE INDEX IF NOT EXISTS idx_courts_name_trgm ON courts USING gin (name gin_trgm_ops);
CREATE INDEX IF NOT EXISTS idx_police_cells_name_trgm ON police_cells USING gin (name gin_trgm_ops);
CREATE INDEX IF NOT EXISTS idx_crown_offices_location_trgm ON crown_offices USING gin (location gin_trgm_ops);

-- ============================================
-- VERIFY IMPORT
-- ============================================


-- ============================================
-- FNHA MENTAL HEALTH PROVIDERS (2135 records)
-- ============================================

DROP TABLE IF EXISTS fnha_mental_health_providers CASCADE;
CREATE TABLE fnha_mental_health_providers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    designation VARCHAR(50),
    region VARCHAR(50),
    phone VARCHAR(50),
    virtual_care BOOLEAN DEFAULT FALSE,
    availability VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Berry, Jenna', 'RSW', 'Fraser', '(403) 561-3198', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Fernyhough, Lynda', 'CCC', 'Fraser', '(604) 999-7927', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Heer, Harjinder Kaur', 'RCC', 'Fraser', '(778) 899-3174', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Hildebrand, Kassidy', 'RCC', 'Fraser', '(604) 853-8916', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Keeling, Nat', 'RSW', 'Fraser', '(604) 803-9051', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Littlejohn , Janet', 'RCC', 'Fraser', '(604) 799-7573', TRUE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Long, Camille', 'RSW', 'Fraser', '(604) 217-7134', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Peterson, Irene', 'RCC', 'Fraser', '(604) 897-1462', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Welsh, Debbie', 'RSW', 'Fraser', '(604) 850-3774', TRUE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Wong , Abigail', 'RCC', 'Multiple', '(778) 899-3802', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Yawney, Ruta', 'RCC', 'Vancouver', '(604) 928-0883', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Alexander, Carol', 'RCC', 'Fraser', '(604) 551-3365', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Flynn, Alexis', 'RSW', 'Fraser', '(604) 729-6227', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Greensmyth, Ashley', 'RCC', 'Fraser', '(604) 836-6043', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Grunbaum, Cameron', 'CCC', 'Fraser', '(778) 902-8595', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Ma , Davina', 'RCSW', 'Fraser', '(778) 960-6015', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Suehn, Megan', 'Psychologist', 'Fraser', '(778) 229-8531', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cheng, Michael', 'RCC', 'Fraser', '(604) 961-6173', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Mackey, Dana', 'RCC', 'Multiple', '(250) 327-1095', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Pickering, Ricardo', 'CCC', 'Interior', '(250) 842-8552', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Luis, Vanessa', 'CCC', 'Interior', '(613) 986-6703', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Brett Mason', 'RSW', 'Vancouver', '(236) 844-2423', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Mussell, Jennifer', 'RCC', 'Fraser', '(604) 793-4160', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Bains, Ruby', 'RCC', 'Fraser', '(604) 220-6572', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Graham, Kirsten', 'RCC', 'Fraser', '(604) 220-6572', TRUE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Larush, Jen', 'Psychologist', 'Fraser', '(604) 997-0303', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Mckenzie, Terresa', 'RCSW', 'Fraser', '(604) 819-9828', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Rallings, Amanda', 'CCC', 'Fraser', '(604) 755-1906', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Yoo, Jae Sun', 'CCC', 'Multiple', '(778) 858-9773', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Perraton, Ava', 'RCC', 'Interior', '(250) 674-7072', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Ingram, Dulcie', 'CCC', 'Vancouver', '(250) 888-7408', TRUE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Correia, Fatima', 'RCC', 'Vancouver', '(250) 941-1555', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kenzie, Andrew', 'RCC', 'Vancouver', '(250) 897-5000', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Ahani, Behi', 'RSW', 'Fraser', '(778) 240-2923', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Amaral, Priscilla', 'RCC', 'Fraser', '(672) 671-9473', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Bahreini, Sahar', 'RCC', 'Fraser', '(778) 706-4224', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Moulton, Jennifer', 'CCC', 'Fraser', '(778) 251-6527', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Westra, Leona', 'RCC', 'Fraser', '(236) 995-2728', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Seeley, Debra', 'RSW', 'Vancouver', '(236) 514-3975', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Yip, Rosanna', 'RSW', 'Multiple', '(877) 797-8384', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Hagel,Daye', 'CCC', 'Vancouver', '(604) 754-9632', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vellet, Sonya', 'Psychologist', 'Vancouver', '(778) 879-6449', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Wakarchuk, Victor', 'RSW', 'Vancouver', '(877) 542-8727', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Watt, Thesa', 'RCC', 'Interior', '(403) 550-9873', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Katinic, Josipa', 'RCC', 'Fraser', '(778) 838-4581', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Williams, Tina', 'RSW', 'Vancouver', '(250) 723-7789', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Parker, Jeff', 'RCC', 'Vancouver', '(250) 661-7997', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Sorsdahl, Michael', 'Psychologist', 'Vancouver', '(778) 455-5040', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Hilton, Doug', 'RCC', 'Vancouver', '(250) 217-8854', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Erickson, Stephanie', 'RCC', 'Northern', '(250) 301-3542', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Carpenter, Vanessa', 'RCC', 'Northern', '(250) 552-8126', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Peloquin, Danielle', 'RCC', 'Northern', '(778) 722-2282', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cameron, Lynn', 'RCC', 'Vancouver', '(250) 325-5306', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Dodd, Nadina', 'RCC', 'Vancouver', '(778) 861-7566', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Hine, Shelley', 'RCC', 'Vancouver', '(604) 916-1374', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Alf Brady', 'CCC', 'Northern', '(250) 842-5888', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('De Roo, Monica', 'RCC', 'Fraser', '(604) 440-7349', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Davison, Tracy', 'RSW', 'Interior', '(778) 586-6365', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Rhodes, Laura', 'RCC', 'Interior', '(250) 462-9425', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Thompson, Karla', 'RCC', 'Interior', '(250) 320-2835', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Alexander, Wade', 'CCC', 'Interior', '(778) 472-0388', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Andersen, Heather', 'CCC', 'Interior', '(250) 314-0377', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Blair, Shelley', 'RCC', 'Interior', '(250) 819-1685', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Carnegie, Gina', 'RCC', 'Interior', '(250) 879-0234', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kimmons , Nina', 'CCC', 'Interior', '(250) 819-2011', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Innis, Leita', 'RSW', 'Interior', '(672) 999-7969', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Ritchie, Shannon', 'RCC', 'Interior', '(250) 819-1902', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Shirley, Dallas', 'RCC', 'Interior', '(778) 694-9988', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Brooker, Anya', 'CCC', 'Interior', '(613) 217-0964', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Feller, Kylie-Anne', 'CCC', 'Interior', '(604) 679-1350', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Klassen, Tara', 'RSW', 'Interior', '(250) 212-4201', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lamont, Cynthia', 'CCC', 'Interior', '(403) 606-5503', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Thompson, Janine', 'RSW', 'Interior', '(778) 716-8919', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Wright, Julie', 'RCC', 'Interior', '(250) 317-4346', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Watt, Kim', 'RCC', 'Fraser', '(778) 686-9494', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Fleury, Julie', 'RCC', 'Fraser', '(778) 772-4631', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Rempel, Geri-Lynn', 'RCC', 'Fraser', '(604) 532-5340', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Weibelzahl, Patrice', 'RCC', 'Fraser', '(604) 530-3966', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Wilkes, Faith', 'RCC', 'Fraser', '(778) 322-9132', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Wondim, Eden', 'CCC', 'Fraser', '(778) 953-1929', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Valerio, Kristen', 'RCC', 'Vancouver', '(250) 619-0901', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Berube , Danielle', 'RSW', 'Vancouver', '(343) 364-9155', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Erenli, Alicia', 'RCC', 'Fraser', '(778) 838-5332', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Sutcliffe, Carmela', 'RCC', 'Fraser', '(778) 928-3875', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Dustin, Jennifer', 'RSW', 'Interior', '(778) 639-0107', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Brohart, Tessa', 'CCC', 'Vancouver', '(250) 816-6393', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Fairweather, Rebecca', 'RCC', 'Vancouver', '(250) 616-2882', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Olson, Zoe', 'RCC', 'Vancouver', '(250) 463-3760', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Webber, Natalie', 'RSW', 'Vancouver', '(807) 790-2867', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kunkle, Liz', 'RCSW', 'Interior', '(780) 267-4737', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Murphy, Janice', 'RCSW', 'Fraser', '(250) 308-9956', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Johnston, Elizabeth', 'RSW', 'Fraser', '(778) 389-5850', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Sheppard, Lawrence', 'RCC', 'Vancouver', '(778) 898-4634', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cardoso, Christopher', 'Psychologist', 'Vancouver', '(604) 770-2881', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Charette, Brie', 'RSW', 'Vancouver', '(604) 971-0359', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Douhan, Paul', 'RSW', 'Vancouver', '(778) 869-6945', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Hedzelek, Dorota', 'CCC', 'Vancouver', '(604) 782-3335', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Khan, Shereen', 'RCC', 'Vancouver', '(604) 813-1321', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Pearl, Tamara', 'RCC', 'Vancouver', '(604) 925-0861', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Ross, Jesse', 'RCC', 'Vancouver', '(778) 846-1713', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Taylor, Melissa', 'RSW', 'Vancouver', '(778) 533-4963', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Buxbaum, Jessica', 'RCC', 'Vancouver', '(604) 512-2297', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Reeves,Allison', 'RCC', 'Vancouver', '(250) 927-6548', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cholewa, Tymarah', 'RCC', 'Vancouver', '(604) 314-1254', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Paterson-Welsh, Anne', 'RCC', 'Vancouver', '(250) 248-6772', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Peter, Stephanie', 'RCC', 'Vancouver', '(250) 937-1223', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Roberts, Joanne', 'Psychologist', 'Vancouver', '(250) 586-3334', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Carus, Ursula', 'RCC', 'Vancouver', '(604) 966-4090', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Balisky, Keith', 'RCC', 'Interior', '(780) 289-4538', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Atkinson, Leanne', 'RCC', 'Fraser', '(672) 886-1157', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Ohm, Phyllis', 'RCC', 'Fraser', '(604) 916-7827', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Graham, June', 'RCC', 'Vancouver', '(250) 720-3511', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Mcconnell, Jess', 'RCC', 'Vancouver', '(250) 726-6643', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Bove , Carrie', 'RCC', 'Fraser', '(604) 417-7710', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Seitz, Bonnie', 'RCC', 'Fraser', '(604) 314-7607', TRUE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Garfield, Jasmine', 'RCC', 'Fraser', '(604) 704-7469', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Macgillivray, Bethany', 'CCC', 'Fraser', '(778) 776-4068', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Beyers, Joanna', 'RSW', 'Vancouver', '(778) 363-5930', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vaughan, Amy', 'CCC', 'Vancouver', '(604) 314-7576', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Gagnon, Michelle', 'CCC', 'Northern', '(778) 675-1300', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Koon, Rena', 'RCC', 'Northern', '(250) 970-0096', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kristinsson, Patricia', 'RCC', 'Northern', '(250) 617-5259', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Claskey, Matt', 'RCC', 'Northern', '(778) 387-4233', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Jaques, Marlaina', 'RCC', 'Northern', '(250) 615-2220', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Isbister, Brad', 'RCC', 'Vancouver', '(250) 752-6386', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelly, Matthew', 'RCC', 'Vancouver', '(250) 204-7664', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chahal, Jagdeep', 'RSW', 'Vancouver', '(604) 259-6807', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Romano, Shannon', 'RSW', 'Interior', '(778) 761-0485', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Graham, Shirley', 'Psychologist', 'Vancouver', '(250) 537-9795', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Watters, Tara', 'RSW', 'Vancouver', '(250) 221-2468', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chang, Ming Huey', 'RCSW', 'Vancouver', '(778) 883-2238', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Laurie, Benjamin', 'RSW', 'Northern', '(250) 842-3383', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Schipper, Matt', 'RCC', 'Northern', '(250) 876-8800', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vido, Heather', 'RCC', 'Vancouver', '(250) 888-7408', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Sandilands, Kate', 'RSW', 'Vancouver', '(604) 218-2055', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Becker, Jenna', 'RSW', 'Vancouver', '(604) 345-4040', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Honce, Jade', 'CCC', 'Vancouver', '(604) 849-2949', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Mindy Kollman', 'RCC', 'Interior', '(604) 613-1444', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Macalpine, Sharon', 'RCC', 'Fraser', '(604) 753-2058', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Pickrell, Laura', 'RCC', 'Fraser', '(604) 800-0702', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Bell, Cyndi', 'RCC', 'Fraser', '(604) 377-0114', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Doglas, Leah', 'RCSW', 'Fraser', '(604) 626-6005', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Hwi, Henry', 'CCC', 'Fraser', '(604) 500-8954', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Matos, Paulo', 'Psychologist', 'Fraser', '(604) 789-5046', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Monier-Williams, Lindsay', 'RCC', 'Fraser', '(604) 531-4544', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Plourde, Margaret', 'RCC', 'Fraser', '(604) 726-0884', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Sandhu, Gurmit', 'RSW', 'Fraser', '(604) 364-6220', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Leona Westra', 'RCC', 'Vancouver', '(236) 995-2728', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Pewtress, Victoria', 'CCC', 'Fraser', '(604) 657-9765', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Poltorasky, Lacey', 'CCC', 'Northern', '(250) 668-2966', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Thacker, Sophie', 'CCC', 'Interior', '(604) 305-2508', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Altar, Ted', 'Psychologist', 'Northern', '(250) 641-9000', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kiernan, Joelle', 'RSW', 'Northern', '(250) 635-6707', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kim, Coneitia', 'RCC', 'Vancouver', '(604) 901-7741', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Mongrain, Norissa', 'RSW', 'Vancouver', '(604) 353-0431', TRUE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Palomino-Meraz, Olivia', 'RSW', 'Vancouver', '(604) 256-5850', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Power, Lynn', 'RCC', 'Vancouver', '(778) 319-8311', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Bellehumeur, Nikki Lee', 'RCC', 'Vancouver', '(604) 358-5852', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Amanda Rose', 'RSW', 'Vancouver', '(604) 256-5850', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Aulak, Ravin', 'RCC', 'Vancouver', '(778) 995-9525', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chen, Donna', 'RCC', 'Vancouver', '(604) 773-1578', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Fenton, Christina', 'RCC', 'Vancouver', '(236) 333-4275', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Fisher, Lexi', 'RSW', 'Vancouver', '(778) 688-4532', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Arber, Crystal', 'RSW', 'Vancouver', '(604) 340-4529', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Barron, Ramona', 'RCC', 'Vancouver', '(604) 657-8691', TRUE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chau, Fung Ming', 'CCC', 'Vancouver', '(604) 250-8405', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cook, Ainslie', 'RSW', 'Vancouver', '(604) 616-7161', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Corrigan, Kelli', 'RSW', 'Vancouver', '(604) 240-9907', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coupland, Sarah', 'Psychologist', 'Vancouver', '(604) 871-0490', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Demichelis, Hiroko', 'RCC', 'Vancouver', '(604) 290-6926', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Doolan, Brenna', 'RCC', 'Vancouver', '(604) 256-5850', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Favaro, Julia', 'RSW', 'Vancouver', '(604) 256-5850', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Heaslip, Sean', 'RCC', 'Vancouver', '(778) 776-5375', TRUE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Hsu, Hsuan Fang Jenny', 'RCC', 'Vancouver', '(778) 776-2601', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Jassal, Amandeep', 'RSW', 'Vancouver', '(604) 603-6062', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Johnson, Sheri', 'RSW', 'Vancouver', '(604) 337-8577', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kaplan, Sam', 'RCC', 'Vancouver', '(604) 657-0960', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lajoie, Janele', 'RCC', 'Vancouver', '(778) 222-9972', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lin, Tzu-Hsuan', 'CCC', 'Vancouver', '(778) 885-8874', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Link Jr, Ernest', 'RSW', 'Vancouver', '(604) 256-5850', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Magtoto, Joanne', 'RSW', 'Vancouver', '(604) 715-3230', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Malcolm, Jasmine', 'RSW', 'Vancouver', '(604) 704-9706', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Markan, Premila', 'CCC', 'Vancouver', '(778) 806-2203', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Martinez, Katherine', 'Psychologist', 'Vancouver', '(778) 709-3172', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Maxwell, Simone', 'RSW', 'Vancouver', '(778) 822-9123', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Mcleod, Christy', 'RCC', 'Vancouver', '(778) 720-6362', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Merasty, Angela', 'RSW', 'Vancouver', '(604) 256-5850', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nicol, Christopher', 'RCC', 'Vancouver', '(236) 858-5285', TRUE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Palomino Meraz, Olivia', 'RSW', 'Vancouver', '(778) 668-4532', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Pereira-Imm, Gorette', 'RCC', 'Vancouver', '(778) 899-1195', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Rostad, Faith', 'Psychologist', 'Vancouver', '(604) 765-7303', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Rush, Sarah', 'RSW', 'Vancouver', '(604) 256-5850', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Sessoms, Clayre', 'RCC', 'Vancouver', '(778) 302-3187', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Seyed Emami, Mehran', 'CCC', 'Vancouver', '(604) 312-4008', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Siddiqui, Sarah', 'RSW', 'Vancouver', '(778) 681-0981', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Slaunwhite , Hal', 'RSW', 'Vancouver', '(902) 830-2152', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Turnbrook, Jennifer', 'RCC', 'Vancouver', '(778) 899-1195', TRUE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Velasco, Taciana', 'RSW', 'Vancouver', '(604) 256-5850', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Weisbart, Cindy', 'Psychologist', 'Vancouver', '(778) 232-5939', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Wilbur, Rosie', 'RCC', 'Vancouver', '(604) 773-0296', TRUE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Williams, Brian Dean', 'CCC', 'Vancouver', '(778) 320-8586', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Wing, Michelle', 'RSW', 'Vancouver', '(604) 720-6794', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nevdoff, Pamela', 'RCC', 'Interior', '(250) 803-2695', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Riemer, River', 'RSW', 'Interior', '(778) 760-3854', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Maccarl, Morgan', 'RCC', 'Interior', '(250) 858-9722', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Rose, Kathryn', 'RCC', 'Vancouver', '(250) 857-6017', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Jamieson, Cynthia', 'RSW', 'Vancouver', '(778) 977-5593', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Mathews, Darlene', 'RCC', 'Vancouver', '(250) 893-7170', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Whillans, Penny', 'Psychologist', 'Vancouver', '(250) 385-9192', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Aberdeen, Sheryl', 'RCC', 'Vancouver', '(250) 858-2366', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Berry, Jane', 'RSW', 'Vancouver', '(780) 905-4992', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Bryant, Charity', 'RCC', 'Vancouver', '(778) 732-2578', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Byers, April', 'Psychologist', 'Vancouver', '(778) 440-4040', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Frender, Jesse', 'RCC', 'Vancouver', '(604) 329-2904', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Freudenreich, Monica', 'RSW', 'Vancouver', '(604) 837-5085', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Genlik, Ken', 'RSW', 'Vancouver', '(250) 920-6689', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Grant, Shelaine', 'RSW', 'Vancouver', '(780) 907-0261', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Jones, Deborah', 'RCSW', 'Vancouver', '(250) 882-5014', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('King-Harris, Charlotte', 'RSW', 'Vancouver', '(250) 986-7359', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Louie, Marcena', 'RCC', 'Vancouver', '(250) 857-9134', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Paquette, Yvonne', 'RSW', 'Vancouver', '(778) 868-3666', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Smart, Colette', 'Psychologist', 'Vancouver', '(250) 580-6387', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Trotter, Beth', 'RCC', 'Vancouver', '(250) 386-7805', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cready, Irene', 'RSW', 'Vancouver', '(604) 561-6866', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Ekman, Shani', 'RCC', 'Interior', '(250) 486-1223', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Thygesen, Christine', 'RCC', 'Interior', '(250) 863-9434', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Evans, Brooke', 'RSW', 'Vancouver', '(604) 781-3987', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Keevil, Demill', 'CCC', 'Vancouver', '(778) 846-6504', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Hamilton, Kristen', 'RCC', 'Fraser', '(778) 995-7395', TRUE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Opacic Lunot, Lola', 'RSW', 'Fraser', '(236) 516-2983', TRUE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lamothe , Chantal', 'RCC', 'Interior', '(250) 267-1179', TRUE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Mile House Boyce, Lorelei', 'RCC', 'Unknown', '(250) 644-6869', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Mile House Kisyel, Kim', 'RCC', 'Unknown', '(250) 706-5009', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Mile House Thain, Andrea', 'CCC', 'Unknown', '(250) 706-2561', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Vickruck, Ashley', 'RCC', 'Fraser', '(604) 746-7200', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Forbes, Sharon', 'RCC', 'Fraser', '(604) 855-8322', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Heer, Raji', 'RSW', 'Fraser', '(604) 807-9759', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Ivy Huang', 'CCC', 'Fraser', '(604) 853-8916', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Jennifer Larush', 'Psychologist', 'Fraser', '(604) 997-0303', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Johnson, Katie', 'RSW', 'Fraser', '(236) 458-0269', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Kaler,Vicky', 'RSW', 'Fraser', '(778) 240-3196', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Kuechler, Anastasia', 'RSW', 'Fraser', '(604) 854-0802', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Agberotimi, James', 'RCC', 'Fraser', '(604) 226-6218', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Allen, Nicole', 'CCC', 'Fraser', '(604) 217-1513', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Arpink, Jennifer', 'Psychologist', 'Fraser', '(604) 425-1550', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Aujla, Inderjit', 'RCC', 'Fraser', '(604) 615-9472', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Bhattacharya , Lipika', 'RCC', 'Fraser', '(604) 226-6218', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Bocskey, Jenna', 'RCC', 'Fraser', '(778) 344-5483', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Boudin, Jonathan', 'RCC', 'Fraser', '(604) 788-1710', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Braun-Kauffman, Danielle', 'RCC', 'Fraser', '(604) 807-1874', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Brink, Kristi', 'RSW', 'Fraser', '(604) 854-0802', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Ceballos, Alycia', 'RCC', 'Fraser', '(604) 626-6808', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Clarke, Linda', 'RCC', 'Fraser', '(604) 226-6218', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Collins, Shanda', 'RCC', 'Fraser', '(604) 783-9514', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Conway-Brown, Jennifer', 'RSW', 'Fraser', '(604) 746-2025', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Drader, Gillian', 'RCC', 'Fraser', '(604) 625-7852', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Dykstra, Sandra', 'CCC', 'Fraser', '(604) 835-8575', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Ediger, Lorie', 'RCC', 'Fraser', '(778) 344-2163', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford French, Maureen', 'RCC', 'Fraser', '(604) 302-5487', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Gazlay, Jamie', 'RSW', 'Fraser', '(778) 344-0570', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Gheorghe, Alexandra', 'RSW', 'Fraser', '(604) 219-7805', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Goldsmith, Kaitlyn', 'Psychologist', 'Fraser', '(604) 504-5444', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Hargreaves, Kirsten', 'RCC', 'Fraser', '(778) 982-8529', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Herman, Matthew', 'CCC', 'Fraser', '(778) 552-6145', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Holtjer, Danielle Mecha Marie', 'RCC', 'Fraser', '(778) 899-3802', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Hundal, Jasbir', 'RSW', 'Fraser', '(604) 961-2060', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Hyde, Ross', 'RCC', 'Fraser', '(604) 853-8916', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Ibraham, Viana', 'RSW', 'Fraser', '(604) 855-8040', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Kaushal, Sunita', 'RCC', 'Fraser', '(877) 748-0825', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Kavin, Danielle', 'Psychologist', 'Fraser', '(604) 506-2848', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Larush, Jennifer', 'Psychologist', 'Fraser', '(604) 997-0303', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Lawson, Kadie', 'RCC', 'Fraser', '(604) 226-8082', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Leighton, Shawna', 'RSW', 'Fraser', '(604) 746-2025', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Mannella, Cecilia', 'RSW', 'Fraser', '(604) 746-2025', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Martin, Ginny', 'RCC', 'Fraser', '(604) 226-6218', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Mckay, Sarah', 'RCC', 'Fraser', '(604) 746-2025', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Mcveigh, Kali', 'RSW', 'Fraser', '(604) 746-2025', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Ngugi-Wiebe, Joyce', 'RCC', 'Fraser', '(604) 557-3532', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Penner, Marlayne', 'CCC', 'Fraser', '(604) 859-7681', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Reardon, Caleb', 'RCC', 'Fraser', '(604) 853-8916', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Redekop, Melissa', 'RCC', 'Fraser', '(604) 859-1462', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Reglin, Faye', 'RSW', 'Fraser', '(604) 217-0165', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Robinson, Charlaine', 'RCC', 'Fraser', '(604) 807-9759', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Sangha, Charn', 'RCC', 'Fraser', '(604) 854-0702', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Sanya, Michael', 'RCC', 'Fraser', '(604) 807-8035', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Schatz, Rebecca', 'RCC', 'Fraser', '(604) 853-8916', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Schembri, Lorraine', 'RCC', 'Fraser', '(778) 899-3802', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Schultz, Tammy', 'RCC', 'Fraser', '(778) 551-0107', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Schulz, Laurie', 'RSW', 'Fraser', '(604) 795-6855', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Sean, Tatiana', 'CCC', 'Fraser', '(604) 250-1611', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Strating, Jacqueline', 'RCC', 'Fraser', '(778) 689-9529', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Traber, Janelle', 'RCC', 'Fraser', '(604) 309-7981', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Tull, Cara', 'RCC', 'Fraser', '(778) 344-2564', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Vair, Angelique', 'RCC', 'Fraser', '(604) 825-4783', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Warkentin, Julie', 'RCC', 'Fraser', '(778) 246-3120', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Weller, Jordan', 'RCC', 'Fraser', '(236) 380-2541', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Wild , Kayla', 'RSW', 'Fraser', '(604) 746-2025', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Wolff, Kimberley', 'Psychologist', 'Fraser', '(604) 768-5268', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Wong, Allison', 'RCC', 'Fraser', '(604) 746-2025', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Hooiveld, Jill', 'RSW', 'Interior', '(604) 309-0908', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Abbotsford Hope, Natalie', 'RCC', 'Vancouver', '(604) 833-3707', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Colwood Carriere, Audrey', 'RCC', 'Fraser', '(250) 888-7408', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Andres, Clayton', 'RCC', 'Multiple', '(778) 899-3802', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Arner, Scott', 'RCC', 'Multiple', '(778) 899-3802', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Barrett, Carter', 'RCC', 'Multiple', '(778) 899-3802', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Deans, Heather', 'RCC', 'Multiple', '(778) 899-3802', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Gill, Jasmine', 'RCC', 'Multiple', '(778) 899-3802', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Laurie , Hollingdrake', 'CCC', 'Multiple', '(778) 899-3802', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Rampal, Karina', 'RCC', 'Multiple', '(778) 899-3802', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Rupinder, Sidhu', 'RCC', 'Multiple', '(778) 899-3802', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Agassiz Crossen, Marique', 'RSW', 'Fraser', '(604) 491-8889', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Agassiz Edwards, Helen', 'RCC', 'Fraser', '(604) 491-8889', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Aggasiz Hoogendiijk, Stephan', 'RCC', 'Fraser', '(604) 491-8889', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Aldergrove Ngo, Susan', 'RCC', 'Fraser', '(778) 628-7894', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Aldergrove Van Woudenberg, Deanna', 'RCC', 'Fraser', '(604) 308-8289', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Alert Bay Peterson, Ruby', 'CCC', 'Vancouver', '(250) 974-5260', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Armstrong Day, Kate', 'RCC', 'Interior', '(250) 859-4444', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Ashcroft Gibson, Christina', 'CCC', 'Interior', '(250) 462-0360', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Barriere Matthew, Sharnelle', 'RCC', 'Interior', '(250) 320-5100', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Bella Coola Boulier, Kirsten', 'RCSW', 'Vancouver', '(604) 209-1741', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Bella Coola Ming Ma', 'RSW', 'Vancouver', '(250) 799-0025', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Black Creek Mowatt, Gina', 'RCC', 'Vancouver', '(250) 688-5545', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Black Creek Laliberte, Julie', 'RCC', 'Vancouver', '(250) 634-1589', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Black Creek Treissman , Candace', 'RCC', 'Vancouver', '(250) 205-1277', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Blind Bay Green, Amy', 'Psychologist', 'Interior', '(250) 253-9297', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Bowen Island Carchrae, Michelle', 'RCC', 'Vancouver', '(604) 947-2270', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Bowen Island Shatzky , Lisa', 'RCC', 'Vancouver', '(778) 837-7040', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Palma, Harriet', 'RCC', 'Fraser', '(778) 322-4329', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Sands, Chantelle', 'RCC', 'Fraser', '(778) 839-6048', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Roth, Clay', 'RCC', 'Fraser', '(236) 979-5230', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Zeng, Clover', 'RCC', 'Fraser', '(778) 358-2626', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Jenkins, Greg', 'RCC', 'Fraser', '(604) 362-4561', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Lee, Will', 'RCC', 'Fraser', '(778) 889-1698', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Leporace,Pino', 'RCC', 'Fraser', '(778) 680-9347', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Susanne Leach', 'RSW', 'Fraser', '(604) 229-2230', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Wang, Bessie', 'RCC', 'Fraser', '(604) 448-2416', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Xu Wang', 'RCC', 'Fraser', '(604) 612-2101', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Abramyk, Wylie', 'RCC', 'Fraser', '(604) 210-5642', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Brown, Tiffany', 'CCC', 'Fraser', '(778) 554-0487', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Cahill, Anna', 'RSW', 'Fraser', '(604) 723-9772', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Chan, Louise', 'RCC', 'Fraser', '(778) 889-1698', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Chan, Veralyn', 'RCC', 'Fraser', '(778) 840-0865', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Charkhandeh, Mansoureh', 'CCC', 'Fraser', '(604) 545-0991', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Dent, Grace', 'RCC', 'Fraser', '(604) 671-1555', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Federico, Sarah', 'RSW', 'Fraser', '(519) 694-7544', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Doolan, Brenna', 'RCC', 'Fraser', '(778) 987-7699', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Emam, Bari', 'RCC', 'Fraser', '(604) 773-6241', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Greensmyth, Ashley', 'RCC', 'Fraser', '(604) 836-6043', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Idoo, Zafreen', 'RSW', 'Fraser', '(778) 358-2626', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Inne , Kori', 'RCC', 'Fraser', '(778) 775-5373', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Johannson, Melanie', 'RCC', 'Fraser', '(604) 802-2145', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Karimiha, Gelareh', 'Psychologist', 'Fraser', '(604) 430-1303', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Klein, Klaus', 'RCC', 'Fraser', '(604) 786-0709', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Lee, Dorcas', 'RSW', 'Fraser', '(604) 726-4410', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Leung, Erica', 'RCC', 'Fraser', '(778) 725-0092', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Loong, Oralie', 'RCC', 'Fraser', '(604) 785-8339', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Lum, Amber', 'RCC', 'Fraser', '(778) 889-1698', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Marshall, Tara', 'RCC', 'Fraser', '(778) 846-9902', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Mccuish, Kaitlan', 'RCC', 'Fraser', '(604) 626-8220', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Powers, Keeley', 'RSW', 'Fraser', '(778) 987-2358', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Sandhu, Vishavjit', 'RCC', 'Fraser', '(236) 880-1416', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Schweighofer, Anton', 'Psychologist', 'Fraser', '(604) 786-3073', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Sharma, Krishna', 'RCC', 'Fraser', '(604) 671-0815', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Sivorot, Krystle', 'RCC', 'Fraser', '(604) 786-7833', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Szeto, Nelson', 'RCC', 'Fraser', '(604) 352-1705', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Ukwu, Tamara', 'RSW', 'Fraser', '(604) 690-5476', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Vaisman, Ofir', 'RCC', 'Fraser', '(778) 998-3327', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Wang, Jue', 'CCC', 'Fraser', '(604) 638-3113', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Wiebe, Shalom', 'RSW', 'Fraser', '(778) 835-7109', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Wong, Pui Sze Patsy', 'RCC', 'Fraser', '(604) 448-2416', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Yeung, Betty', 'CCC', 'Fraser', '(604) 600-7985', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Zahar, Loretta', 'CCC', 'Fraser', '(778) 838-9666', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Zettl, Lynne', 'Psychologist', 'Interior', '(250) 860-8860', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burnaby Linzel, Matthew', 'RCC', 'Vancouver', '(604) 430-1303', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Morgan, Clara', 'RSW', 'Fraser', '(604) 203-7667', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Ho, Victoria', 'RCC', 'Fraser', '(604) 716-0631', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Morgan, Nooshin', 'RSW', 'Fraser', '(604) 719-8855', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Wong, Joseph', 'RCC', 'Multiple', '(778) 928-9550', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Burns Lake Poschwatta, Gordon', 'RSW', 'Northern', '(778) 669-0099', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Campbell River Chamberlin, Tasha', 'RSW', 'Vancouver', '(250) 202-5675', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Campbell River Johnston, Tanille', 'RSW', 'Vancouver', '(250) 896-6113', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Campbell River Payne, Mamie', 'RCSW', 'Vancouver', '(250) 202-5528', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Campbell River Baine, Kelsi', 'CCC', 'Vancouver', '(250) 287-2266', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Campbell River Boivin, Carole', 'CCC', 'Vancouver', '(819) 731-0820', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Campbell River Broadhurst, Trevor', 'RCC', 'Vancouver', '(250) 204-2652', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Campbell River Brown, Amy', 'CCC', 'Vancouver', '(250) 287-3325', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Campbell River Chant, Roderick', 'RCSW', 'Vancouver', '(250) 202-0891', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Campbell River Close, Cheryl', 'CCC', 'Vancouver', '(250) 287-2266', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Campbell River Collard, Tammy', 'RSW', 'Vancouver', '(250) 202-8264', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Campbell River Crawford, Natalie', 'RSW', 'Vancouver', '(250) 204-1721', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Campbell River Kleban, Holly', 'CCC', 'Vancouver', '(250) 287-2266', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Campbell River Longeway, Leanne', 'CCC', 'Vancouver', '(778) 608-3895', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Campbell River Monteith, Rosalind', 'Psychologist', 'Vancouver', '(250) 914-1901', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Campbell River Morton, Lindsey', 'RCC', 'Vancouver', '(250) 203-1370', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Campbell River Park, Hanhy', 'RSW', 'Vancouver', '(250) 202-8271', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Campbell River Prince, Maria', 'RCC', 'Vancouver', '(250) 287-3325', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Campbell River Smiley , Kelly-Ann', 'RCC', 'Vancouver', '(250) 830-2551', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Jean, Katie', 'RSW', 'Vancouver', '(250) 412-5104', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Campbell River Swanson, Drew', 'RCC', 'Vancouver', '(250) 204-9448', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Campbell River Taute, Lynette', 'RCC', 'Vancouver', '(250) 287-3325', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Campbell River Trego, Hazel', 'RCC', 'Vancouver', '(250) 203-1720', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Campbell River Ursuliak, Anika', 'RSW', 'Vancouver', '(250) 634-1838', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Campbell River Walker, Graham', 'RCC', 'Vancouver', '(250) 287-2266', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Castlegar Kozak, Leanna', 'RSW', 'Interior', '(250) 365-5402', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Castlegar Kuiper, Tracy', 'CCC', 'Interior', '(250) 687-8155', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Castlegar Lychowyd, Leah', 'RCC', 'Interior', '(250) 509-0295', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Castlegar Zabel, Emily', 'RCC', 'Interior', '(250) 608-2453', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Silverton Spink, Erica', 'RCC', 'Interior', '(613) 532-8523', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chase Clark, Natalie', 'RSW', 'Interior', '(250) 377-1736', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chase Anderson, Jolene', 'RSW', 'Interior', '(236) 313-1533', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chase Steves, Susan', 'RSW', 'Interior', '(250) 804-8581', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chase Tilstra, Lorraine', 'RSW', 'Interior', '(423) 443-6453', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chemainus Walterhouse, Christine', 'Psychologist', 'Vancouver', '(250) 881-4610', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lain, Lynne', 'RSW', 'Northern', '(250) 263-5890', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Commodore, Laura', 'RCC', 'Fraser', '(604) 819-0365', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Sawatzky, Jenny', 'RCC', 'Fraser', '(604) 791-0551', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Bhushan,Bel', 'RSW', 'Fraser', '(604) 615-2659', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Geurtsen, Jan', 'RCC', 'Fraser', '(604) 798-4411', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Jessy Parmar', 'RCC', 'Fraser', '(604) 997-6926', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Anderson, Courtney', 'RCC', 'Fraser', '(236) 999-7510', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Auffray, Pamela', 'RCC', 'Fraser', '(778) 608-5584', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Ayers, Mike', 'RCC', 'Fraser', '(604) 798-3646', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Bains, Amandeep', 'RCC', 'Fraser', '(604) 220-6572', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Blair, Trudy', 'RCC', 'Fraser', '(778) 878-0411', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Borgen, Roberta', 'CCC', 'Fraser', '(604) 856-2386', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Braich Mcrae, Jenna', 'RCC', 'Fraser', '(604) 615-5070', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Christiansen, Carey', 'RCC', 'Fraser', '(604) 824-4545', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Depow , Larry', 'RSW', 'Fraser', '(604) 705-4000', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Dhaliwal, Devinder', 'RSW', 'Fraser', '(778) 704-0621', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Dumais, Ariel', 'RCC', 'Fraser', '(604) 785-0677', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Fabijan, Rosemarie', 'RSW', 'Fraser', '(604) 793-8042', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Faris, Barbara', 'RCC', 'Fraser', '(604) 860-0507', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Hall, Jill', 'RCC', 'Fraser', '(604) 703-1633', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Hartt, Vicki', 'RCC', 'Fraser', '(604) 302-5543', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Hildebrand, Kassidy', 'CCC', 'Fraser', '(778) 538-8425', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Hilton, Jessica', 'RCC', 'Fraser', '(604) 790-5971', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Hupton, Luke', 'RCC', 'Fraser', '(236) 985-1025', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Joy, Joice', 'RSW', 'Fraser', '(306) 450-7783', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Karr, Nicole', 'RCC', 'Fraser', '(778) 873-6326', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Kesteven, Pauline', 'CCC', 'Fraser', '(604) 795-7284', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Klix, Nicole', 'RCC', 'Fraser', '(604) 220-6572', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Kristy, Richard', 'RCC', 'Fraser', '(604) 799-3080', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Kurucz, Jessica', 'RSW', 'Fraser', '(236) 516-2747', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Lanteigne, Leila', 'RCC', 'Fraser', '(604) 798-5483', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Paris, Faye', 'RCC', 'Fraser', '(604) 845-0941', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Percher, Dawn', 'CCC', 'Fraser', '(604) 799-1691', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Perkes, Erin', 'RCC', 'Fraser', '(604) 705-4000', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Pesut, Katelyn', 'RSW', 'Fraser', '(604) 220-6572', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Pilkey, Dean', 'RCC', 'Fraser', '(604) 819-9828', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Reardon, Caleb', 'RCC', 'Fraser', '(778) 779-0381', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Reglin, Faye', 'RSW', 'Fraser', '(604) 220-6572', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Renaud, Austen', 'CCC', 'Fraser', '(604) 828-2459', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Sarich, Amanda', 'CCC', 'Fraser', '(604) 378-4522', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Scholes, Beth', 'RCC', 'Fraser', '(604) 705-4000', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Skalbeck, Corrin', 'CCC', 'Fraser', '(604) 836-8521', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Smith, Stephanie', 'RSW', 'Fraser', '(604) 819-5578', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Sudermann, Jenny', 'RSW', 'Fraser', '(604) 701-5703', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Thomason, Julie', 'RCC', 'Fraser', '(604) 703-5656', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Togeretz, Joshua', 'RCC', 'Fraser', '(604) 670-0082', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack Tontsch, Hannah', 'RSW', 'Fraser', '(604) 220-6572', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Chilliwack White, Sarah', 'RCC', 'Fraser', '(604) 819-4247', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Maple Ridge Petovello, Shannon', 'RCC', 'Fraser', '(604) 220-6572', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Maple Ridge Tantrum , Tracey', 'RSW', 'Fraser', '(604) 220-6572', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Colwood Giroux, Julie', 'RCC', 'Vancouver', '(778) 587-5808', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Colwood Mcphee, Jacob', 'RSW', 'Vancouver', '(647) 780-5535', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Colwood Storry, Lola', 'RCC', 'Vancouver', '(778) 721-0961', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Sooke Fairfield, Patricia Jean', 'RCC', 'Vancouver', '(250) 888-7408', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Sooke Hamel, Marie Eliane', 'RCC', 'Vancouver', '(250) 888-7408', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Elroy, Michelle', 'RCC', 'Vancouver', '(250) 888-7408', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Munro, Tara', 'RCC', 'Vancouver', '(250) 888-7408', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Rayner Thorn, Janet', 'RSW', 'Vancouver', '(250) 888-7408', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Downie, Anna', 'CCC', 'Vancouver', '(250) 888-7408', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Renfrew Frigon, Jessica', 'RSW', 'Vancouver', '(250) 888-7408', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Comox Baskier, Diana', 'RSW', 'Vancouver', '(250) 703-6292', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Comox Larissa Szlavik', 'RSW', 'Vancouver', '(250) 650-9624', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Comox Bell, Kallista', 'Psychologist', 'Vancouver', '(250) 999-8849', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Comox Bisson, Carrie', 'RSW', 'Vancouver', '(250) 650-9335', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Comox Bullock, Rachel', 'RCC', 'Vancouver', '(778) 585-9389', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Comox Devries, Michaela', 'CCC', 'Vancouver', '(587) 926-0851', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Comox Diewert, Sue', 'RCC', 'Vancouver', '(250) 240-3361', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Comox Durupt, Gabrielle', 'CCC', 'Vancouver', '(250) 897-6828', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Comox Gaskill, Heather', 'RSW', 'Vancouver', '(236) 655-4252', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Comox Godfrey, Basira', 'RCC', 'Vancouver', '(250) 941-1555', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Comox Grunberg, Monika', 'RCC', 'Vancouver', '(250) 941-1555', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Comox Hancocks, Montana', 'RSW', 'Vancouver', '(250) 984-8928', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Comox Mansell, Jennifer', 'RSW', 'Vancouver', '(250) 339-4141', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Comox Martin, Myrna', 'RCC', 'Vancouver', '(250) 509-1033', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Comox Patterson, Serena', 'Psychologist', 'Vancouver', '(250) 941-1555', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Comox Sherman, Joelle', 'RCC', 'Vancouver', '(250) 309-1399', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Comox Thiessen, Mandy', 'RCC', 'Vancouver', '(250) 412-5079', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Comox Whitehead, Georgette', 'RSW', 'Vancouver', '(250) 218-1138', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Ledwidge, Sandra', 'RCC', 'Vancouver', '(250) 650-6777', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Foslett, Cheri-Lynn', 'RCC', 'Fraser', '(604) 928-5770', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Fiddler, Rebecca', 'RSW', 'Fraser', '(778) 960-4089', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Patrick, Carole', 'RCC', 'Fraser', '(604) 813-1513', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Adiele, Getrude', 'RSW', 'Fraser', '(506) 251-3929', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Armstrong, Robert', 'RCC', 'Fraser', '(604) 832-6792', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Azfar, Ayesha', 'RCC', 'Fraser', '(604) 861-9912', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Bazinet, Jean-Claude', 'RCC', 'Fraser', '(604) 816-4622', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Bedard , Michele', 'RSW', 'Fraser', '(877) 797-8384', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Bedard, Michele', 'RSW', 'Fraser', '(855) 453-5530', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Beveridge, Heather', 'RSW', 'Fraser', '(877) 797-8384', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Beveridge, Heather Lynn', 'RSW', 'Fraser', '(855) 453-5530', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Brussell, Diane', 'RCC', 'Fraser', '(877) 797-8483', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Daulat, Sofia', 'RCC', 'Fraser', '(778) 720-0719', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Esmaeilpour, Niloufar', 'RCC', 'Fraser', '(778) 862-2770', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Estranero, Candice', 'RSW', 'Fraser', '(604) 862-8763', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Harpin, Sapphire', 'RCC', 'Fraser', '(604) 916-7352', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Hasan, Mobina', 'RCSW', 'Fraser', '(855) 453-5530', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Howell, Teresa', 'Psychologist', 'Fraser', '(604) 319-4534', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Hyman, Rolando', 'CCC', 'Fraser', '(855) 453-5530', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Jantzen, Jennifer', 'RSW', 'Fraser', '(778) 389-3858', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Jaswal, Beena', 'RCC', 'Fraser', '(778) 772-8527', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Kim, Hong Goo', 'RCC', 'Fraser', '(604) 786-8752', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam La Madrid Carpena, Gisella', 'RCC', 'Fraser', '(604) 862-8763', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Lakhani, Reshma', 'RSW', 'Fraser', '(855) 453-5530', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Michel, Nancy', 'Psychologist', 'Fraser', '(604) 931-7211', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Norton, Mikaela', 'CCC', 'Fraser', '(855) 453-5530', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Paukunnen, Veronika', 'RCC', 'Fraser', '(604) 862-8763', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Plywaczewski, Jasmine', 'RSW', 'Fraser', '(403) 978-5838', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Sam, Hilda', 'RCC', 'Fraser', '(604) 773-2089', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Smith, Rebecca', 'RSW', 'Fraser', '(778) 858-2190', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Symonds, Shala', 'RSW', 'Fraser', '(604) 754-9998', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Tremblay, Cathy', 'RCC', 'Fraser', '(778) 688-1664', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Coquitlam Vahanvaty, Husain', 'RCC', 'Fraser', '(778) 999-2376', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Mejin, Cordelia', 'CCC', 'Multiple', '(778) 775-5238', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Napastiuk, Paulina', 'RSW', 'Fraser', '(604) 805-5348', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Hossein-Pour, Bahareh', 'CCC', 'Multiple', '(604) 679-3191', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Lakhani, Reshma', 'RSW', 'Multiple', '(877) 797-8384', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Ki Speer', 'RSW', 'Vancouver', '(250) 207-3848', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Boer, Elly', 'RCC', 'Vancouver', '(250) 777-3844', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Mel Devine', 'RCC', 'Vancouver', '(250) 650-4785', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Sokil, Kazimea', 'RCC', 'Vancouver', '(250) 650-3738', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Andrew, Keenan', 'RCC', 'Vancouver', '(250) 703-3003', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Baron, Tatiana', 'RCC', 'Vancouver', '(778) 996-4181', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Boyle, Carly', 'RCC', 'Vancouver', '(250) 871-3929', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Bradfield, Caroline', 'RCC', 'Vancouver', '(250) 703-1558', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Briggs, Erica', 'RSW', 'Vancouver', '(250) 871-3929', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Brocklesby, Alaina', 'RSW', 'Vancouver', '(250) 871-3929', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Brussell, Diane', 'RCC', 'Vancouver', '(250) 732-6823', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Burgess, Nicole', 'RCC', 'Vancouver', '(250) 465-2064', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Cherewyk, Jacqueline', 'RSW', 'Vancouver', '(250) 871-3929', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Clarke-Watts, Arianna', 'RCC', 'Vancouver', '(250) 334-6841', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Compton, Simone', 'CCC', 'Vancouver', '(250) 703-3003', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Doncaster, Erinn', 'RSW', 'Vancouver', '(250) 538-8777', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Forseth, Laura', 'CCC', 'Vancouver', '(250) 507-5007', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Helle, Tanya', 'RSW', 'Vancouver', '(250) 504-0595', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Holmes, Sherina', 'RSW', 'Vancouver', '(250) 650-4033', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Hunt, Samantha', 'RSW', 'Vancouver', '(250) 871-3929', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Hunter, Paula', 'RSW', 'Vancouver', '(250) 552-8212', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Hutchinson, Emma', 'RSW', 'Vancouver', '(250) 871-1184', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Kelly, Amy', 'RCC', 'Vancouver', '(250) 650-9222', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Fleur, Rebecca', 'RCC', 'Vancouver', '(250) 338-2700', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Lambrecht, Danielle', 'RSW', 'Vancouver', '(250) 898-9847', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Laval, Celia', 'RCC', 'Vancouver', '(250) 702-9129', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Lawrence, Sarah', 'RCC', 'Vancouver', '(250) 701-8480', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Mason, Karen', 'RCC', 'Vancouver', '(250) 898-3335', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Mcgill, Christina', 'RCC', 'Vancouver', '(778) 793-5683', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Michaluk, Becky', 'RCC', 'Vancouver', '(250) 334-7235', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Montgomery, Gretal', 'RCC', 'Vancouver', '(778) 883-8527', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Northcott, Chad', 'CCC', 'Vancouver', '(250) 871-3929', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Padilla, Rebeca', 'RCC', 'Vancouver', '(778) 957-5060', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Pinsonneault, Kate', 'RCC', 'Vancouver', '(250) 218-4394', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Pratt, Michael', 'RCC', 'Vancouver', '(250) 338-0311', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Rushforth, John', 'RCC', 'Vancouver', '(250) 650-6497', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Shillington, Jennifer', 'RCC', 'Vancouver', '(250) 531-0933', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Courtenay Williams, Lara', 'RCC', 'Vancouver', '(250) 331-1480', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cowichan Bay Waterland, Elizabeth', 'RCC', 'Vancouver', '(604) 741-3520', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cowichan Bay Tully, Darlene', 'CCC', 'Vancouver', '(236) 989-4500', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cranbrook Josh Lockhart', 'CCC', 'Interior', '(250) 427-6190', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cranbrook Beck, Laurie', 'RSW', 'Interior', '(250) 464-0655', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cranbrook Carr, Julie', 'RCC', 'Interior', '(250) 464-4241', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cranbrook Greenard-Smith, Cherylynne', 'RSW', 'Interior', '(250) 489-9795', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cranbrook Haley, Wendy', 'RSW', 'Interior', '(250) 919-8737', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cranbrook Kemperman, Angela', 'CCC', 'Interior', '(778) 687-3980', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cranbrook Ladriere, Crystal', 'CCC', 'Interior', '(778) 822-2865', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cranbrook Lamb, Allison', 'RCC', 'Interior', '(778) 687-4122', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cranbrook Nicholson, William Dean', 'RCC', 'Interior', '(250) 464-5543', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cranbrook Popoff, Emily', 'RCC', 'Interior', '(778) 687-4122', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cranbrook Reid, Mikayla', 'RCC', 'Interior', '(604) 464-5055', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cranbrook Siemens, Jeremy', 'Psychologist', 'Interior', '(250) 581-2226', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cranbrook Sobocinski, Michael', 'Psychologist', 'Interior', '(250) 421-9693', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cranbrook Stanyer, Kimberly', 'RSW', 'Interior', '(778) 517-5005', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cranbrook Taylor, John David', 'RCC', 'Interior', '(604) 989-7337', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cranbrook Walls, Kathleen', 'Psychologist', 'Interior', '(250) 489-9420', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Creston Hiscoe, Lynn', 'RCC', 'Interior', '(250) 878-1634', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Creston Loughran, Bryce', 'RCC', 'Interior', '(250) 977-5619', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Creston Taylor, John', 'RCC', 'Interior', '(250) 878-1634', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Crofton Pederson, Peter', 'RCC', 'Vancouver', '(250) 252-2177', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cultus Lake Doyle, Janit', 'RSW', 'Fraser', '(604) 819-1526', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Daajinggiids Davie, Jenna', 'CCC', 'Northern', '(250) 639-1304', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Dawson Creek Logan, Tabitha', 'RSW', 'Interior', '(250) 784-8167', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Dawson Creek Key Craig, Vanessa', 'RSW', 'Northern', '(587) 873-5082', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Dawson Creek Kurka, Kira', 'RCC', 'Northern', '(250) 782-6795', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Delta Squitti, Sherry-Lynn', 'RCC', 'Fraser', '(604) 437-7713', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Delta Ateah, Carol', 'RCC', 'Fraser', '(604) 880-0406', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Delta Bablitz, John', 'RCC', 'Fraser', '(604) 283-7827', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Delta Barkowsky, Deborah', 'RCC', 'Fraser', '(604) 360-4012', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Delta Farnell, Rebecca', 'RCC', 'Fraser', '(778) 549-0751', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Delta Grewal, Deshpal', 'RCC', 'Fraser', '(778) 384-3571', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Delta Kilback, Katie', 'RCC', 'Fraser', '(604) 283-7827', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Delta Malik, Mohua', 'CCC', 'Fraser', '(604) 805-9020', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Delta Moitoso, Marcia', 'RCC', 'Fraser', '(604) 283-7827', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Delta Munro, Jeri-Lyn', 'RCC', 'Fraser', '(778) 241-5292', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Delta Ranasuriya , Swetha', 'RCC', 'Fraser', '(604) 767-4265', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Delta Sandhu, Gurjit', 'RCC', 'Fraser', '(604) 354-0661', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Delta Sangha, Amar', 'RCC', 'Fraser', '(604) 842-7340', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Delta Shaw, Annekatrin', 'RCC', 'Fraser', '(604) 593-3522', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Delta Verma, Rahul', 'RCC', 'Fraser', '(925) 323-1409', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Kaur, Sandeep', 'RCC', 'Fraser', '(604) 370-4746', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Somerset, Richard', 'RCC', 'Multiple', '(604) 250-9869', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Wright, Nicalla', 'RCC', 'Interior', '(250) 510-8811', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Harman, Lyla', 'RSW', 'Vancouver', '(250) 748-1592', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Cao, Trien', 'RCC', 'Vancouver', '(250) 709-8368', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kinley', 'RCC', 'Vancouver', '(250) 715-5990', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cullough, Kim', 'RCC', 'Vancouver', '(250) 732-5054', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Bolo, Jann', 'RSW', 'Vancouver', '(250) 715-5360', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Campbell, Clayton', 'RSW', 'Vancouver', '(250) 510-7042', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Cardinal, Chelsea', 'RSW', 'Vancouver', '(778) 402-4233', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Christofferson, Rebecca', 'RCC', 'Vancouver', '(250) 815-0961', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Duncan, Sarah', 'RCC', 'Vancouver', '(250) 510-5298', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Ferris, Heather', 'CCC', 'Vancouver', '(250) 937-1289', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Field, Denae', 'RCC', 'Vancouver', '(250) 732-8220', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Findlay, Alistair', 'RCC', 'Vancouver', '(250) 746-3600', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Franke, Bernadette', 'RCC', 'Vancouver', '(250) 715-8954', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Gintowt, Michael', 'RCC', 'Vancouver', '(250) 815-5428', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Groenewold, Frank', 'RCC', 'Vancouver', '(250) 710-0921', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Hamilton, Lydia', 'RCC', 'Vancouver', '(250) 732-6445', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Hammell, Angela', 'RSW', 'Vancouver', '(250) 858-7766', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Haven, Sonder', 'RCC', 'Vancouver', '(778) 400-6352', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Jedwab, Franya', 'RCC', 'Vancouver', '(250) 710-2264', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Jorgenson, Ron', 'RCC', 'Vancouver', '(250) 737-5143', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Kapela, Erin', 'RCC', 'Vancouver', '(778) 847-3746', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Mansell, Denise', 'RSW', 'Vancouver', '(250) 709-8825', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Mccaffery, Tara', 'RCC', 'Vancouver', '(250) 709-4846', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Meerdink, Amy', 'RSW', 'Vancouver', '(250) 732-0946', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Moon, Kerry', 'RCC', 'Vancouver', '(250) 710-2292', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Nelson, Nadeane', 'CCC', 'Vancouver', '(250) 710-3403', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Paterson, Georjeana', 'RCC', 'Vancouver', '(250) 510-5226', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Pederson , Peter', 'RCC', 'Vancouver', '(250) 858-7766', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Raison, Shannon', 'RCC', 'Vancouver', '(250) 886-9395', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Sanderson, April', 'RSW', 'Vancouver', '(250) 732-1247', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Schiebel, Alex', 'RCC', 'Vancouver', '(250) 589-4631', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Serea, Doina', 'CCC', 'Vancouver', '(250) 210-1980', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Sibley, Dana', 'RCC', 'Vancouver', '(250) 510-5226', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Smith, Bronwen', 'RCC', 'Vancouver', '(250) 661-0039', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Stewart, Leslie', 'RCC', 'Vancouver', '(250) 709-1772', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Duncan Williams, Susan', 'RCSW', 'Vancouver', '(250) 597-7456', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langford Koontz, Tensley', 'RCC', 'Vancouver', '(250) 896-9197', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Walker, Anna', 'CCC', 'Vancouver', '(250) 210-3337', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Saanich Campbell, Joanna', 'CCC', 'Vancouver', '(250) 709-0118', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Strom, Jodi', 'RCC', 'Vancouver', '(250) 702-4583', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Woods, Trina', 'RSW', 'Vancouver', '(250) 732-1680', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Esquimalt Herbinson, Kat', 'RCC', 'Vancouver', '(250) 532-0579', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Esquimalt Mooney, Maggie', 'RCC', 'Vancouver', '(604) 318-4213', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Esquimalt Sholinder , Kim', 'RCC', 'Vancouver', '(250) 857-4190', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Fanny Bay Carruthers, Megan', 'RCC', 'Vancouver', '(604) 418-7716', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Fernie Roche, Tammy-Lynne', 'RSW', 'Interior', '(250) 278-6577', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Fernie Charbonneau, Tyla', 'Psychologist', 'Interior', '(250) 423-8656', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Fernie Vlasschaert, Jordan', 'RCC', 'Interior', '(250) 946-7547', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Fernie Walker, Karen', 'CCC', 'Interior', '(250) 430-7740', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Fort Langley Ancora Counselling Services', 'RCC', 'Fraser', '(778) 242-2911', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Fort Langley Dereus,Katie', 'RCC', 'Fraser', '(604) 771-0424', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Fort Langley Antoniuk, Tricia', 'RSW', 'Fraser', '(778) 378-2633', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('James French , Sara', 'CCC', 'Northern', '(604) 657-0630', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('John Anielewicz, Crystal', 'CCC', 'Northern', '(250) 263-1593', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('John Antoniak, Michelle', 'RCC', 'Northern', '(250) 793-5993', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('John Best, Heather', 'RCC', 'Northern', '(250) 262-6865', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('John Shamalla, Masitsa', 'RCC', 'Northern', '(250) 329-7696', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('John Tebulte, Amy', 'RCC', 'Northern', '(250) 262-4326', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('John Wrixon, Lezli', 'RCC', 'Northern', '(250) 793-7676', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Gabriola Island Sanderson, Leslie', 'RCC', 'Vancouver', '(250) 325-0272', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Garden Bay Sumner, Jennifer', 'RCC', 'Vancouver', '(604) 365-6019', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Garden Bay Teigen, Suvi', 'RSW', 'Vancouver', '(778) 558-8498', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Gibsons Cust, Sylvia', 'RCC', 'Vancouver', '(604) 886-4845', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Gibsons Will Dow', 'CCC', 'Vancouver', '(604) 763-5692', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Gibsons Jackman, Rhonda', 'RCSW', 'Vancouver', '(604) 865-1655', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Gibsons Miki, Jody', 'RCC', 'Vancouver', '(604) 740-7058', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Gibsons Simmons, Melissa', 'RSW', 'Vancouver', '(778) 686-1153', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Silver, Dawna', 'RCC', 'Vancouver', '(778) 885-1950', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Gitsegulka Schulz, Andreanna', 'CCC', 'Northern', '(250) 842-0135', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Grand Forks Allan, Amy', 'RCC', 'Interior', '(250) 442-7197', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Grand Forks Schiesser, Tamara', 'RCC', 'Interior', '(250) 588-0374', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Grindrod Lansdowne, Robb', 'RCC', 'Interior', '(250) 803-2401', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Halfmoon Bay Pagels, Leah', 'RSW', 'Vancouver', '(604) 354-1929', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Halfmoon Bay Snitz, Neora', 'RSW', 'Vancouver', '(604) 828-0680', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Hanceville Francis, Michelle', 'RCC', 'Interior', '(778) 267-6041', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Heriot Bay Stewart, Petra', 'RSW', 'Vancouver', '(250) 203-3439', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Hope Relland, Bruce', 'RCC', 'Fraser', '(604) 860-5699', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Hope Relland, Ruth', 'RCC', 'Fraser', '(604) 860-3483', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Houston Crucil, Courtenay', 'RCC', 'Northern', '(250) 816-7062', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Houston Hestad, Gillian', 'RCSW', 'Northern', '(778) 203-6767', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Invermere Cory, Victoria', 'RCC', 'Interior', '(623) 277-9501', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Invermere Gillies-Bradley, Susan', 'CCC', 'Interior', '(778) 526-0095', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Invermere Sovereign, Karly', 'CCC', 'Interior', '(825) 797-0659', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kaleden Clements, Sheila', 'RCSW', 'Interior', '(250) 809-7082', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kaleden Ohori, David', 'RCC', 'Interior', '(250) 617-1865', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Broadfoot, Ashley', 'CCC', 'Interior', '(778) 220-2836', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Clarke, Joyce', 'CCC', 'Interior', '(250) 320-1905', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Davis, Angela', 'RCC', 'Interior', '(778) 990-6232', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Draney, Marilee', 'RSW', 'Interior', '(778) 257-2433', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Fletcher, Joan', 'RSW', 'Interior', '(250) 828-2698', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Green, Hilda', 'CCC', 'Interior', '(250) 299-1617', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Strain, Ferne', 'RSW', 'Interior', '(778) 220-6788', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Todd, Sharon', 'RSW', 'Interior', '(250) 320-8615', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Daley, Kym', 'RCC', 'Interior', '(236) 852-1431', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Freeze, Dave', 'RCC', 'Interior', '(250) 318-1099', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Jamie Holloway', 'RSW', 'Interior', '(250) 293-6492', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Rasmussen-Merz, Bobbie', 'RSW', 'Interior', '(250) 879-2244', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Robbyn Bennett', 'RCC', 'Interior', '(778) 779-7376', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Anderberg, Marian', 'RSW', 'Interior', '(250) 851-5155', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Befurt, Nicole', 'RCC', 'Interior', '(250) 319-8596', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Bezanson, Sherry', 'RCC', 'Interior', '(250) 514-1570', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Booy, Angela', 'RCC', 'Interior', '(778) 765-3171', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Calhoun, Shawna', 'CCC', 'Interior', '(778) 257-4092', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Campbell, Andrea', 'RCC', 'Interior', '(250) 554-4747', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Cane, Jennifer', 'RSW', 'Interior', '(250) 314-0298', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Conners, Jeff', 'RSW', 'Interior', '(250) 819-0316', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Corea , Elaine', 'RCC', 'Interior', '(250) 554-4747', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Currell, Catherine', 'Psychologist', 'Interior', '(604) 788-7288', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Dikaryeva, Tatyana', 'RCC', 'Interior', '(250) 554-4747', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Dolson, Robert', 'RCC', 'Interior', '(250) 319-0101', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Elliott, Christine', 'RSW', 'Interior', '(705) 208-8977', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Engen-Johnson, Robin', 'RCC', 'Interior', '(778) 586-5348', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Ezedebego, Chiduzie', 'RCC', 'Interior', '(250) 614-8113', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Ezedebego, Leanne', 'RCC', 'Interior', '(250) 314-0377', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Farnell, Vicki', 'RCC', 'Interior', '(250) 828-2698', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Friend, Jennifer', 'RSW', 'Interior', '(250) 299-8731', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Gardiner , Jennifer', 'RCC', 'Interior', '(250) 433-1988', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Geoghegan, Kim', 'CCC', 'Interior', '(250) 571-4048', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Goodrich, Jeff', 'RCC', 'Interior', '(250) 640-6487', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Gosselin, Alexis', 'RCC', 'Interior', '(250) 666-0039', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Grimm, Kelsey', 'RCC', 'Interior', '(778) 860-3120', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Grinberg, Pete', 'RCC', 'Interior', '(250) 318-9455', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Gulley, Katherine', 'CCC', 'Interior', '(250) 819-2989', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Haw, Sierra', 'RCC', 'Interior', '(250) 819-6333', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Huculak, Adele', 'RCC', 'Interior', '(250) 554-4747', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Hum, Christopher', 'CCC', 'Interior', '(250) 572-2234', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Jain, Rahul', 'RCSW', 'Interior', '(250) 876-8704', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Jones, Darren', 'RCC', 'Interior', '(250) 819-3336', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Juergensen, Patricia', 'CCC', 'Interior', '(778) 860-3120', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Kioka, Fran', 'RCC', 'Interior', '(250) 318-8701', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Kreis, Isabella', 'RSW', 'Interior', '(250) 305-7692', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Lapeyre, Betty', 'RCC', 'Interior', '(250) 320-4877', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Lindsey, Jolene', 'RSW', 'Interior', '(250) 554-4747', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Manuel South , Shelly', 'RSW', 'Interior', '(778) 694-1108', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Mathews, Nadine', 'RSW', 'Interior', '(250) 314-0298', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Cabe, Suzanne', 'RSW', 'Interior', '(250) 318-6268', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Intosh, Kalie', 'RCC', 'Interior', '(250) 574-1426', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lean, Matt', 'RCC', 'Interior', '(250) 320-0846', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Mohammed , Dionne', 'RSW', 'Interior', '(250) 819-8368', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Moilliet, Adam', 'RSW', 'Interior', '(236) 597-7800', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Moody, Mark', 'RSW', 'Interior', '(250) 899-5278', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Munegatto, Crystal', 'RSW', 'Interior', '(250) 819-0234', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Neufeld, Rissa', 'CCC', 'Interior', '(844) 472-5473', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Pasemko, Rachael', 'RSW', 'Interior', '(250) 828-2698', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Peterson, Jason', 'RCC', 'Interior', '(250) 571-9825', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Peterson, Katherine', 'RCC', 'Interior', '(778) 489-5630', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Peterson, Susan', 'RSW', 'Interior', '(250) 319-5317', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Pratt, Anita', 'CCC', 'Interior', '(250) 571-4605', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Redl, Heidi', 'RCC', 'Interior', '(250) 554-4747', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Reiter, Barry', 'CCC', 'Interior', '(250) 319-7775', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Rouleau, Emily', 'RCC', 'Interior', '(250) 819-2380', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Sadhra, Sandip', 'RCC', 'Interior', '(778) 257-0480', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Sanford, Rebecca', 'RSW', 'Interior', '(250) 574-7664', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Seeley, Lori', 'RSW', 'Interior', '(778) 220-7707', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Serown, Narinder', 'RCC', 'Interior', '(250) 682-1074', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Sharif, Usman', 'RCC', 'Interior', '(778) 220-2361', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Tornyai, Magdalena', 'CCC', 'Interior', '(250) 554-6663', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Tourangeau, Nicole', 'RSW', 'Interior', '(250) 981-2960', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Tyler, Alexa', 'RCSW', 'Interior', '(250) 819-0212', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Umphress, Megan', 'RSW', 'Interior', '(778) 257-4253', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Van Zyl, Christa', 'RCC', 'Interior', '(250) 320-2747', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Vandepeear, Kimberly', 'RCC', 'Interior', '(778) 586-5348', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Vossel, Charlotte', 'RCC', 'Interior', '(778) 299-2532', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Welch, Patrick', 'Psychologist', 'Interior', '(778) 586-6414', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops White, Patricia', 'CCC', 'Interior', '(833) 630-2010', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Whitehead, Cheryl', 'RCSW', 'Interior', '(250) 819-2738', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Widmer, Mary', 'RSW', 'Interior', '(250) 376-1594', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Widmer, Sarah', 'RSW', 'Interior', '(250) 554-4747', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Wingerak, Viviane', 'RCC', 'Interior', '(250) 314-0298', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Zawadzka, Urszula', 'RCC', 'Interior', '(250) 377-5433', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kamloops Mulgrew, Kendra', 'RCC', 'Vancouver', '(604) 312-4371', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Knight, Ashleigh', 'RCC', 'Multiple', '(877) 325-7484', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Koopmans, Lolina', 'RCC', 'Multiple', '(604) 312-4371', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Mariona-Flor, Randine', 'RSW', 'Multiple', '(778) 360-2605', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Lansall, Melanie', 'RSW', 'Northern', '(250) 961-3239', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Paice, Avril', 'RSW', 'Fraser', '(778) 215-2061', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Clegg, Daniel', 'Psychologist', 'Interior', '(250) 762-2525', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Manerikar, Shaylen', 'RSW', 'Interior', '(403) 831-6554', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Malewicz,Ania', 'RSW', 'Interior', '(250) 718-9291', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Melissa July', 'RSW', 'Interior', '(250) 470-8174', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Reid, Emerick', 'RSW', 'Interior', '(250) 681-3308', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Atkins, Tracy', 'RCC', 'Interior', '(250) 255-1640', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Bailey, Debra', 'RSW', 'Interior', '(250) 718-9291', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Bekar , Glenn', 'RCC', 'Interior', '(250) 718-9291', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Berg, Ashley', 'RSW', 'Interior', '(250) 317-2303', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Born, Doris', 'Psychologist', 'Interior', '(778) 984-3674', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Brown , Georgia', 'RCC', 'Interior', '(250) 801-7462', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Bush, Alicia', 'RCC', 'Interior', '(778) 846-2874', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Campos, Melissa', 'RSW', 'Interior', '(226) 977-7654', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Chebib, Dania', 'RCC', 'Interior', '(778) 363-3374', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Cocquyt, Bree', 'RCC', 'Interior', '(778) 619-2202', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Cook, Katelyn', 'RSW', 'Interior', '(263) 620-0031', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Crockford, Chrystelle', 'RCC', 'Interior', '(250) 300-6860', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Den Haan , Janna', 'RCC', 'Interior', '(250) 718-9291', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Donaher, Olivia', 'RCC', 'Interior', '(250) 718-9291', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Downes, John', 'RCC', 'Interior', '(250) 860-3181', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Eng, Joyce', 'RCC', 'Interior', '(250) 860-3181', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Gill, Rubina', 'RCC', 'Interior', '(250) 718-9291', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Graham, Sheri', 'CCC', 'Interior', '(250) 878-5967', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Greenwood, Stephanie', 'RSW', 'Interior', '(250) 718-9291', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Hamilton, Simon', 'RCC', 'Interior', '(778) 821-2068', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Hamm, Linda', 'RCSW', 'Interior', '(250) 878-3959', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Harrington, Suzanne', 'RCC', 'Interior', '(250) 860-3181', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Hedstrom-Beblow, Nola', 'RCC', 'Interior', '(250) 801-0645', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Hennessey, Trixie', 'RSW', 'Interior', '(250) 762-2525', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Holtslander, Jessica', 'RCC', 'Interior', '(250) 808-9424', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Howard, Brian', 'RCC', 'Interior', '(250) 870-6182', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Howard, James', 'RCC', 'Interior', '(250) 718-9291', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Huey, Davina', 'CCC', 'Interior', '(250) 801-1831', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Huggins, Donna', 'RCC', 'Interior', '(250) 861-4343', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Hutchinson, Beverly', 'CCC', 'Interior', '(250) 650-0286', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Jaeger, Erle', 'RCC', 'Interior', '(778) 281-1287', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Jamieson, Megan', 'RCC', 'Interior', '(778) 484-5600', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Jordan, Sebastien', 'RCC', 'Interior', '(250) 808-6789', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Kent, Brooklyn', 'RSW', 'Interior', '(403) 795-5410', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Khangura, Jasmin', 'RSW', 'Interior', '(778) 686-4860', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Kniewasser, Lauren', 'RCC', 'Interior', '(613) 888-7764', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Lindquist, Fiona', 'RCC', 'Interior', '(250) 765-7085', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Madeira, Courtney', 'RSW', 'Interior', '(250) 300-6860', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Malhi, Harpal', 'RSW', 'Interior', '(250) 718-9291', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Manroop, Sohal', 'RCC', 'Interior', '(250) 300-6860', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Martini, Natasha', 'RCC', 'Interior', '(250) 421-0886', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Mathison, Paige', 'RCC', 'Interior', '(250) 469-2116', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Mills, Lauren', 'RCC', 'Interior', '(306) 361-6928', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Mishchenko, Marcia', 'RCC', 'Interior', '(604) 575-9375', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Moore, Katrina', 'RSW', 'Interior', '(604) 354-6151', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Moseley, Teresa', 'RCC', 'Interior', '(778) 222-7778', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Neukom, Zara', 'RCC', 'Interior', '(250) 718-9291', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Nigh, Cassidy', 'RCC', 'Interior', '(780) 781-8651', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Nordlof, Lindsay', 'RCC', 'Interior', '(250) 857-2655', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Palmer, Rebecca', 'RCC', 'Interior', '(250) 718-9291', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Patterson, Dana', 'RCC', 'Interior', '(778) 478-0548', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Paynter, Shauna', 'RCC', 'Interior', '(250) 681-1100', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Pereversoff, Lisa', 'CCC', 'Interior', '(250) 300-6860', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Plant , Zoe', 'CCC', 'Interior', '(250) 826-3164', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Poon, Gabrielle', 'Psychologist', 'Interior', '(250) 870-5257', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Price-Draper, Shelley', 'RSW', 'Interior', '(250) 717-7019', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Reimer, Sam', 'RCC', 'Interior', '(250) 868-2338', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Robertson, Jim', 'CCC', 'Interior', '(250) 718-9291', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Robinson, Samantha', 'RCC', 'Interior', '(250) 899-9855', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Rowshan, Arthur', 'RCC', 'Interior', '(236) 361-0043', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Shevkenek, Linda', 'CCC', 'Interior', '(778) 721-0557', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Sinnott, Marlee', 'RCC', 'Interior', '(604) 619-6133', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Smith, Susan', 'CCC', 'Interior', '(236) 420-1154', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Snider, Lucy', 'RCC', 'Interior', '(250) 762-2525', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Straub, Donald', 'CCC', 'Interior', '(250) 718-9291', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Tarasenco, Irina', 'Psychologist', 'Interior', '(778) 760-3363', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Taylor, Shaunna', 'CCC', 'Interior', '(250) 808-2491', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Teagle , Verity', 'RSW', 'Interior', '(250) 863-7745', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Towers, Michael', 'RCC', 'Interior', '(250) 215-4155', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Turner, Gaylene', 'RCC', 'Interior', '(778) 222-7778', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Twidale, Emma', 'RSW', 'Interior', '(250) 650-7589', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Van Aller, Roxie', 'RCC', 'Interior', '(250) 860-3181', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Van Horne, Rhiannan', 'RSW', 'Interior', '(250) 763-7414', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Wachla, Martin', 'RCC', 'Interior', '(236) 562-5620', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Watson, Jocelyn', 'RCC', 'Interior', '(250) 808-5283', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Wilson, Roger', 'RCC', 'Interior', '(250) 718-1144', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Young , Ryan', 'RCC', 'Interior', '(250) 300-1700', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Yung , Bonny', 'RCC', 'Interior', '(250) 300-6860', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kelowna Zalewski, Izabella', 'RCC', 'Interior', '(250) 808-0905', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lake Country Hahn, Pearce', 'CCC', 'Interior', '(250) 826-4002', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lake Country Splett, Leora', 'RCC', 'Interior', '(250) 860-6661', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Morgan, Robin', 'RSW', 'Interior', '(250) 863-7863', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Green, Renate', 'RCC', 'Interior', '(250) 878-0602', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Ward, Jadon', 'CCC', 'Interior', '(250) 859-5653', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('West Kelowna Harbour, Val', 'RCC', 'Interior', '(250) 718-9291', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('West Kelowna Alderliesten, Jessica', 'RSW', 'Interior', '(250) 826-5377', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('West Kelowna Arends, Jessica', 'RCC', 'Interior', '(250) 469-6787', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('West Kelowna Fenske, Christina', 'RSW', 'Interior', '(236) 361-0043', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('West Kelowna Hajzer, Alexandra', 'RCC', 'Interior', '(250) 212-5096', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('West Kelowna Hirschfeld, Erica', 'RCC', 'Interior', '(236) 361-0043', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('West Kelowna Zalewski, Izabella', 'RCC', 'Interior', '(250) 808-0905', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kimberley Bennett, Kyle', 'RSW', 'Interior', '(403) 835-1461', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kimberley Hagen, Jennifer', 'RSW', 'Interior', '(250) 432-9266', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Ladysmith Mathias, Cedar', 'RCC', 'Vancouver', '(250) 880-6148', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Ladysmith Pal, Shweta', 'RCC', 'Vancouver', '(250) 885-2353', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Ladysmith Priest, Sharon', 'RCC', 'Vancouver', '(250) 642-3221', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Ladysmith Toth, Tricia', 'RCC', 'Vancouver', '(250) 755-6331', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lake Country Sam Hinter', 'RCC', 'Interior', '(250) 303-0304', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lake Country Grams, Shaunna', 'RCC', 'Interior', '(250) 317-9667', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lake Country Hansen, Lois', 'CCC', 'Interior', '(250) 487-0236', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lake Country Loewen, Laura', 'RCC', 'Interior', '(778) 581-4357', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lake Country Waites, Shailyn', 'RSW', 'Interior', '(519) 324-7333', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lake Country Warner, Shannon', 'RSW', 'Interior', '(250) 766-3433', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lake Cowichan Lucas, Brenda', 'RCC', 'Vancouver', '(250) 749-0115', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lake Cowichan Sawatzky, Amanda', 'CCC', 'Vancouver', '(250) 732-2227', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lake Errock Snowdon, Louise', 'CCC', 'Fraser', '(250) 830-4926', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langford Espinosa Ordaz, Gerardo', 'RCC', 'Vancouver', '(250) 886-8331', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langford Harding, Rhiannon', 'RCC', 'Vancouver', '(250) 389-2819', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langford Leippi, Deanna', 'CCC', 'Vancouver', '(250) 217-6773', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langford Sivak, Tessa', 'CCC', 'Vancouver', '(778) 433-7630', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langford Whelen, Heather', 'Psychologist', 'Vancouver', '(250) 389-2819', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Vickruck, Ashley', 'RCC', 'Fraser', '(778) 814-8425', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley White , John', 'RCC', 'Fraser', '(778) 242-5924', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Miller Schumann, Erin', 'RCC', 'Fraser', '(604) 313-6818', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Zamen, Shameela', 'RSW', 'Fraser', '(778) 839-0505', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Armstrong, Matt', 'RCC', 'Fraser', '(604) 315-6801', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Bartel, Tammy', 'RCC', 'Fraser', '(604) 616-6023', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Alsheri, Saleha', 'CCC', 'Fraser', '(204) 698-8383', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Bate, Brandon', 'CCC', 'Fraser', '(604) 262-8806', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Baturin Matechuk, Nancy', 'RCC', 'Fraser', '(778) 837-9639', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Baty-Thomas, Tara', 'RCC', 'Fraser', '(604) 888-0836', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Beck, Simon', 'RCC', 'Fraser', '(604) 761-2197', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Chu, Esther', 'RCC', 'Fraser', '(604) 312-2989', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Cooper, Darcee', 'RSW', 'Fraser', '(604) 300-2633', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Craven, Jill', 'RCC', 'Fraser', '(778) 686-2123', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Cruikshank, Donna', 'RCC', 'Fraser', '(778) 886-4357', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Dadson, Michael', 'CCC', 'Fraser', '(778) 554-0174', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley De Little, Madeleine', 'CCC', 'Fraser', '(604) 626-9671', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Dutt, Brinita', 'CCC', 'Fraser', '(604) 836-5173', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley English, Hannah', 'RCC', 'Fraser', '(604) 537-2317', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Eshleman, Mark', 'RCC', 'Fraser', '(604) 262-8806', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Harvey, Keri', 'RCC', 'Fraser', '(604) 262-8806', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Hossmann, Sonya', 'RSW', 'Fraser', '(604) 996-5105', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Jarman, Lindsay', 'RCC', 'Fraser', '(778) 240-4447', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Kim, Kyung Hyun Tammy', 'CCC', 'Fraser', '(778) 980-3683', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Lee, Angela', 'RCC', 'Fraser', '(604) 262-8806', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Low , Lisa', 'RCC', 'Fraser', '(778) 552-8007', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Massaquoi, Leo', 'CCC', 'Fraser', '(604) 700-5174', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Mccabe, Vicki', 'RCC', 'Fraser', '(778) 798-3783', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Rae, Marisol', 'Psychologist', 'Fraser', '(604) 589-9566', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Meister, Nicole', 'RSW', 'Fraser', '(604) 807-7600', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Michaud, Jennifer', 'RCC', 'Fraser', '(604) 230-5475', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Mooney, Helen', 'RSW', 'Fraser', '(604) 518-1933', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Moudahi, Jennifer', 'CCC', 'Fraser', '(604) 999-0566', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Murphy, Amanda', 'RCC', 'Fraser', '(604) 371-4145', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Nizher, Parminder', 'RSW', 'Fraser', '(604) 307-3512', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Parasad, Edric', 'RCC', 'Fraser', '(604) 328-9672', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Park, Veronica', 'RCC', 'Fraser', '(604) 442-8927', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Pellatt, Kelly', 'RSW', 'Fraser', '(604) 613-6947', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Phillips-Hing, Martin', 'Psychologist', 'Fraser', '(604) 850-3774', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Piprah, Bernard', 'RCC', 'Fraser', '(604) 375-2369', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Regehr, Renae', 'RCC', 'Fraser', '(604) 309-5309', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Rennie, Cristina', 'RCC', 'Fraser', '(604) 859-7474', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Rensch, Christian', 'RCC', 'Fraser', '(778) 298-9555', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Sai, Neeta', 'RCC', 'Fraser', '(604) 283-4030', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Sangha, Gurleen', 'RCC', 'Fraser', '(604) 655-4586', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Schindel, Kai', 'CCC', 'Fraser', '(778) 549-8268', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Shimonek, Karren', 'RCC', 'Fraser', '(778) 839-0068', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Sidhu, Nimrit', 'RSW', 'Fraser', '(604) 723-0197', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Steven, Shinnie', 'RCC', 'Fraser', '(647) 673-8423', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Taverner, Neale', 'RSW', 'Fraser', '(604) 427-2574', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Taylor, Robert', 'RCC', 'Fraser', '(778) 242-2320', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Thandi, Pardeep', 'RCC', 'Fraser', '(604) 725-8474', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Torrie, Alexandra', 'CCC', 'Fraser', '(604) 371-4145', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Ukwu, Tamara', 'RSW', 'Fraser', '(604) 690-5476', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Vlasic, Matthew', 'RCC', 'Fraser', '(604) 805-3365', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Walsh, Angie', 'RSW', 'Fraser', '(604) 655-2123', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Weenk, Leanne', 'RCC', 'Fraser', '(778) 808-8187', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('James', 'RCC', 'Fraser', '(604) 530-3966', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley White, John', 'RCC', 'Fraser', '(778) 242-5924', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Langley Wong , Allison', 'RCC', 'Fraser', '(604) 313-4128', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Maple Ridge Carr, Janette', 'RSW', 'Fraser', '(604) 857-1267', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Thompson, Maggie', 'RCC', 'Multiple', '(604) 371-4145', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lantzville Fowler, Autumn', 'CCC', 'Vancouver', '(250) 514-0103', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lantzville Gasparotto, Megan', 'RSW', 'Vancouver', '(250) 619-0901', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lantzville Rana, Gul-E', 'RSW', 'Vancouver', '(250) 619-0901', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Drummond,Josh', 'RSW', 'Vancouver', '(250) 816-9625', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lillooet Kane, Brandy', 'RCSW', 'Interior', '(604) 728-1574', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lillooet Casper, Lorrinda', 'RSW', 'Interior', '(250) 256-9126', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lillooet Hall, Yolanda', 'RCSW', 'Interior', '(778) 554-2332', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lillooet Warren, Joanne', 'RCC', 'Interior', '(250) 256-4906', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lillooet Woodland, Alanah', 'RSW', 'Interior', '(778) 209-0956', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Whistler Leslie, Alex', 'RCSW', 'Multiple', '(604) 757-0342', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Neely, Carrie', 'RCSW', 'Interior', '(250) 819-0268', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lone Butte Nyman, Sheila', 'RSW', 'Interior', '(250) 618-6247', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lumby Warner, Shannon', 'RSW', 'Interior', '(250) 309-4101', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Mackenzie Knight, Bobbi', 'RCC', 'Northern', '(250) 640-1167', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Maple Ridge Timbrell, Roseanne', 'RCC', 'Fraser', '(604) 442-5550', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Maple Ridge Blackwell, Julia', 'RCC', 'Fraser', '(604) 440-8256', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Maple Ridge Court, Elisa', 'RSW', 'Fraser', '(604) 562-0066', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Maple Ridge Cowen, Brittany', 'RCC', 'Fraser', '(716) 512-9478', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Maple Ridge Kennedy, Samara', 'RCC', 'Fraser', '(604) 226-6961', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Maple Ridge Laity, Deanna', 'RCC', 'Fraser', '(604) 362-0636', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Maple Ridge Ndiom, Michel', 'RSW', 'Fraser', '(604) 317-4252', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Maple Ridge Njuitchou Ngounou, Viviane L''Or', 'RSW', 'Fraser', '(604) 377-7854', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Maple Ridge Stanwood, Mary', 'RCC', 'Fraser', '(604) 283-6318', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Maple Ridge Weenk, Leanne', 'RCC', 'Fraser', '(778) 588-5471', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Masset Murphy, Traci', 'RCC', 'Northern', '(250) 626-7718', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Mayne Island Chan, Louise', 'RCC', 'Vancouver', '(236) 999-7510', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Merritt Bishop, Sheri', 'RSW', 'Interior', '(250) 378-9222', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Merritt Giesbrecht, Kiya', 'RCC', 'Interior', '(250) 280-2779', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Mill Bay Mandorla, Wendy', 'RSW', 'Interior', '(778) 535-2030', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Mill Bay Nowshadi, Cheryl', 'RCC', 'Vancouver', '(250) 727-1672', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Mission White, Jordan', 'RCC', 'Fraser', '(604) 226-1599', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Mission Bev Redekop', 'RCC', 'Fraser', '(778) 808-9955', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Mission Buckley, Dawn', 'RCC', 'Fraser', '(778) 873-2800', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Mission Burke, Heather', 'Psychologist', 'Fraser', '(604) 862-6223', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Mission Burns-Thomson, Shauna', 'RCC', 'Fraser', '(236) 380-1126', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Mission Douglas, Mark', 'RCC', 'Fraser', '(604) 820-7020', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Mission Harris , Melanie', 'RCC', 'Fraser', '(778) 987-8262', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Mission Schuurmans, Kayla', 'RCC', 'Fraser', '(604) 832-4098', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Mission Sunga , Melissa', 'RCC', 'Fraser', '(604) 217-3628', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Williams, Suzanne', 'RCC', 'Multiple', '(604) 833-7760', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nakusp Maxinuk,Maddy', 'RCC', 'Interior', '(250) 505-6703', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nakusp Johnston, Richelle', 'RCC', 'Interior', '(343) 338-4626', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Denice', 'RCC', 'Interior', '(250) 265-8892', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Lacasse , Emily', 'RCC', 'Interior', '(226) 234-4352', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Johnson, Paula', 'RCC', 'Vancouver', '(250) 585-5515', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Klaws, Diane', 'RSW', 'Vancouver', '(778) 269-4673', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Laviolette, Dean', 'RCC', 'Vancouver', '(250) 616-0625', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Littlechild, Kary-L', 'CCC', 'Vancouver', '(250) 754-9988', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Consulting', 'RCC', 'Vancouver', '(236) 463-3005', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Lurline Raposo', 'RCC', 'Vancouver', '(250) 753-0363', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Stephenson, Brooke', 'RCC', 'Vancouver', '(250) 729-6380', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Aebig, Lauren Mariko', 'CCC', 'Vancouver', '(250) 616-2621', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Atkinson, Kathryn', 'RCC', 'Vancouver', '(250) 797-7087', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Atnikov, Ken', 'RSW', 'Vancouver', '(250) 616-3579', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Atwal, Jasmin', 'RCC', 'Vancouver', '(778) 269-4673', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Barnett, Janina', 'RCC', 'Vancouver', '(250) 758-3359', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Bat El, Tamar', 'Psychologist', 'Vancouver', '(250) 661-8560', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Bell, Janice', 'RCC', 'Vancouver', '(250) 244-2929', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Bertram, Andrew', 'RCC', 'Vancouver', '(250) 616-3579', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Berube, Danielle', 'RSW', 'Vancouver', '(250) 619-0901', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Bogue, Robyn', 'RCC', 'Vancouver', '(250) 304-5793', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Botterill, Shelley', 'RCC', 'Vancouver', '(250) 740-1632', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Bruns, Anna', 'CCC', 'Vancouver', '(778) 269-4634', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Butler, Krista', 'RCC', 'Vancouver', '(604) 369-6769', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Bylsma, Lisa', 'RCC', 'Vancouver', '(250) 755-9563', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Cerson, Jemma', 'RSW', 'Vancouver', '(250) 616-7537', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Charles, Martine', 'RCSW', 'Vancouver', '(250) 740-0244', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Depner, Ron', 'RCC', 'Vancouver', '(250) 616-3579', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Digney, Melanie', 'RCC', 'Vancouver', '(250) 758-3359', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Dratva, Eden', 'RSW', 'Vancouver', '(519) 897-1819', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Drummond, Joshua', 'RSW', 'Vancouver', '(250) 327-4157', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Gage, Patricia', 'RCC', 'Vancouver', '(250) 758-3359', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Geraldine , Potter', 'CCC', 'Vancouver', '(250) 734-3863', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Gilligan, Michelle', 'RCC', 'Vancouver', '(250) 797-5358', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Goh, Pauline', 'RCC', 'Vancouver', '(778) 441-5150', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Gohier, Francine', 'RCC', 'Vancouver', '(250) 668-2047', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Goltes, Kristy', 'RCC', 'Vancouver', '(250) 268-3077', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Hall, Christine', 'RCC', 'Vancouver', '(250) 667-2228', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Harris, Stephanie', 'RCC', 'Vancouver', '(778) 995-4795', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Harris, Veronica', 'RCC', 'Vancouver', '(250) 824-5013', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Hawkes, Meghan', 'RCC', 'Vancouver', '(250) 507-6525', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Hesketh, Brittany', 'RCC', 'Vancouver', '(250) 616-0631', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Holroyd, Ann', 'RCC', 'Vancouver', '(250) 729-5356', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Iberg, Shelley', 'CCC', 'Vancouver', '(250) 739-0953', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Jacobsen, Marissa', 'RCC', 'Vancouver', '(778) 838-6626', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo James, Christina', 'CCC', 'Vancouver', '(250) 268-0135', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Janzen, Gina', 'Psychologist', 'Vancouver', '(250) 739-3666', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Jolly, Katen', 'RSW', 'Vancouver', '(604) 202-5596', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Knodel-Moser, Amy', 'Psychologist', 'Vancouver', '(250) 933-4884', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Kopperson, Caitlin', 'RCC', 'Vancouver', '(250) 758-3359', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Lacasse, Emily', 'RCC', 'Vancouver', '(226) 234-4352', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Larkin-Boyle, Laurie', 'RCC', 'Vancouver', '(867) 335-0372', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Lindsay, Ashley', 'RCC', 'Vancouver', '(250) 933-4884', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Liske, Carrie', 'RCC', 'Vancouver', '(250) 585-8086', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Loudon, Elizabeth', 'RCC', 'Vancouver', '(778) 268-0008', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Lush, Katherine', 'RCC', 'Vancouver', '(250) 802-3536', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Mackay, Jessica', 'RCC', 'Vancouver', '(236) 833-8144', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Martinflatt, Ashleigh', 'RSW', 'Vancouver', '(250) 739-3241', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Martinflatt, Joel', 'RSW', 'Vancouver', '(250) 616-1262', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Max, Karen', 'RCC', 'Vancouver', '(250) 619-5999', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Auley, Linda', 'RCC', 'Vancouver', '(250) 933-4884', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Mccune, Stephanie', 'RCC', 'Vancouver', '(250) 713-7853', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kerracher, Amanda', 'Psychologist', 'Vancouver', '(250) 933-4884', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Michieli, Janice', 'RCC', 'Vancouver', '(250) 667-1462', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Miles , Holly', 'CCC', 'Vancouver', '(250) 758-3359', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Morland, Shawna', 'RCC', 'Vancouver', '(250) 616-1006', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Mowbray, Paige', 'RSW', 'Vancouver', '(604) 848-4587', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Myers, Tracy', 'RCC', 'Vancouver', '(250) 327-1444', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo O''Keefe Skates, Maura', 'RSW', 'Vancouver', '(250) 999-3343', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Passarelli, Lisa-Marie', 'RCC', 'Vancouver', '(604) 723-6935', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Pinder, Clifton', 'CCC', 'Vancouver', '(250) 740-1304', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Pinder, Ladona', 'RSW', 'Vancouver', '(250) 753-0363', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Poirier, Mia', 'RCC', 'Vancouver', '(250) 714-2497', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Puckering, Nicole', 'RCC', 'Vancouver', '(250) 753-0363', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Reimer, Noelle', 'RCC', 'Vancouver', '(778) 269-4673', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Ross, Lindsay', 'RCC', 'Vancouver', '(250) 752-5717', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Saraceno, Johanne', 'RCC', 'Vancouver', '(250) 816-0924', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Schafer, Cole', 'RCC', 'Vancouver', '(250) 616-2254', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Scott, Rebecca', 'RCC', 'Vancouver', '(250) 268-2468', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Scott, Susan', 'RCC', 'Vancouver', '(778) 269-4673', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Seabrook, Jade', 'RCC', 'Vancouver', '(778) 269-4673', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Shannon, Leann', 'RCC', 'Vancouver', '(250) 739-5506', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Shedletzky, Faye', 'CCC', 'Vancouver', '(778) 732-5039', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Skeeles, Mila', 'CCC', 'Vancouver', '(250) 740-0818', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Slobodian, Ryan', 'RCC', 'Vancouver', '(250) 802-9501', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Smith, Barbara', 'RCC', 'Vancouver', '(778) 269-1838', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Smith, Jodie', 'RCC', 'Vancouver', '(250) 268-3579', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Stark , Monica', 'CCC', 'Vancouver', '(250) 252-5138', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Sutherland, Gillian', 'RCC', 'Vancouver', '(250) 714-8940', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Sutton, Linda', 'RCC', 'Vancouver', '(250) 758-9386', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Taylor, John', 'RCC', 'Vancouver', '(250) 618-0216', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Trew, Jennifer', 'Psychologist', 'Vancouver', '(604) 985-3939', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Unrau, Trishia', 'RCC', 'Vancouver', '(587) 968-3853', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Walker, Chris', 'CCC', 'Vancouver', '(250) 591-1640', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Walker, Janet', 'RCC', 'Vancouver', '(604) 812-5554', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Wilkin, Leslie', 'RSW', 'Vancouver', '(604) 353-9474', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Wilson, Jenifer', 'RSW', 'Vancouver', '(250) 824-5017', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Woodruff, Marilyn', 'RCC', 'Vancouver', '(250) 616-4227', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Woychuk, John', 'CCC', 'Vancouver', '(250) 667-1975', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Wyness, Katelin', 'RCC', 'Vancouver', '(250) 758-3359', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanaimo Zdrazilova, Lenka', 'Psychologist', 'Vancouver', '(250) 802-2199', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Parksville Caldwell, Mary Margaret', 'CCC', 'Vancouver', '(250) 927-3095', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Alberni Devine, Lindy', 'RCC', 'Vancouver', '(250) 668-4315', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanoose Bay Redenbach, Lynn', 'RCC', 'Vancouver', '(250) 927-5099', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nanoose Bay Reid, Linda', 'RCC', 'Vancouver', '(604) 317-0598', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nelson Brown,Alix', 'RCC', 'Interior', '(250) 509-0366', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nelson Phillips, Alexis', 'RCC', 'Interior', '(250) 509-0368', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nelson Binnie, Michelle', 'CCC', 'Interior', '(250) 354-3494', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nelson Clapperton, Christina', 'RSW', 'Interior', '(250) 899-8030', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nelson Eriksen, Shauna', 'Psychologist', 'Interior', '(780) 817-4772', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nelson Flesaker, Keri', 'Psychologist', 'Interior', '(250) 505-5873', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nelson Friend, Alan', 'RCC', 'Interior', '(250) 551-1272', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nelson Gerlitz, Julia', 'RCC', 'Interior', '(312) 522-9089', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nelson Haley, Maggie', 'RCSW', 'Interior', '(250) 551-3042', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nelson Iannone, Sarah', 'RCC', 'Interior', '(604) 500-2591', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nelson Luscombe, Roger', 'RCC', 'Interior', '(250) 354-5305', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nelson Moore, Katrina', 'RSW', 'Interior', '(604) 354-6151', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nelson Moore, Malorie', 'RSW', 'Interior', '(514) 883-8936', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nelson O''Meara, Tami', 'RCC', 'Interior', '(250) 718-9291', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nelson Porter, Esta', 'RCC', 'Interior', '(250) 354-0200', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nelson Williams, Catherine', 'RCSW', 'Interior', '(250) 352-0122', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Wolbert, Katherine', 'RCC', 'Multiple', '(250) 509-1692', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Hazelton Mathews, Darlene', 'RCC', 'Northern', '(250) 842-8087', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Hazelton Hockin, David', 'RCC', 'Northern', '(250) 842-6031', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Hazelton Tyrer, Wendy', 'RCC', 'Vancouver', '(250) 830-3285', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Westminster English, Hannah', 'RCC', 'Fraser', '(604) 537-2317', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Westminster Sauriol, Courtenay', 'RSW', 'Fraser', '(604) 819-1285', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Westminster Green Fisher, Sarah', 'RCC', 'Fraser', '(778) 792-0899', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Westminster Capote, Karyna', 'RCC', 'Fraser', '(778) 891-3307', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Westminster Clayton, Julie', 'RCC', 'Fraser', '(778) 251-6527', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Westminster Danielson, Kent', 'RSW', 'Fraser', '(604) 377-0857', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Westminster Dehoney, Jennifer', 'RCC', 'Fraser', '(604) 671-8652', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Westminster Fuller, Colleen', 'RCC', 'Fraser', '(778) 877-4383', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Westminster Gupta, Anika', 'RCC', 'Fraser', '(604) 553-9800', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Westminster Hartney, Elizabeth', 'Psychologist', 'Fraser', '(778) 350-6384', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Westminster Hartwell, Debra', 'CCC', 'Fraser', '(604) 318-2351', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Westminster Ivany, Joshua', 'RCC', 'Fraser', '(778) 251-6527', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Westminster Joensuu, Eleonora', 'RCC', 'Fraser', '(604) 799-0379', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Westminster Johnson, Andrea', 'RSW', 'Fraser', '(604) 200-8391', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Westminster Longworth, Mary', 'RCC', 'Fraser', '(604) 948-3262', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Westminster Martinez Tafolla, Daniel', 'RCC', 'Fraser', '(236) 867-9965', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Westminster Mowbray, Paige', 'RSW', 'Fraser', '(604) 848-4587', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Westminster Mrinal, Shriti Mitra', 'RCC', 'Fraser', '(236) 991-1025', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Westminster Mukesh, Aditi', 'RCC', 'Fraser', '(604) 704-6986', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Westminster Shi , Yifo', 'CCC', 'Fraser', '(236) 777-8883', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Westminster Tanya, Elez', 'Psychologist', 'Fraser', '(604) 805-4690', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('New Westminster Toth , Kailey', 'RSW', 'Fraser', '(604) 724-5815', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Ortiz, Radha', 'RCC', 'Vancouver', '(604) 782-5475', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Pirani, Yassie', 'RCC', 'Vancouver', '(604) 782-5475', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Saanich Clarence, Dianne', 'RCC', 'Vancouver', '(250) 667-8978', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Saanich Ingram, Talia', 'RCC', 'Vancouver', '(250) 886-6863', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Saanich Liberatore, Tasha', 'RCC', 'Vancouver', '(250) 893-0734', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Saanich Starkiewicz, Nancy', 'RSW', 'Vancouver', '(250) 655-0087', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Mahal, Paneet', 'RSW', 'Multiple', '(778) 860-3120', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Blanchette, Jodi', 'RCC', 'Vancouver', '(604) 984-8447', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Dr Duanita G Eleniak', 'RCSW', 'Vancouver', '(604) 988-5689', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Lee Burton, Margo', 'RSW', 'Vancouver', '(647) 284-1959', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Sarah Panofsky', 'RCC', 'Vancouver', '(604) 213-8701', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Ackhurst, Suli', 'RCC', 'Vancouver', '(604) 306-3616', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Afshar Zanjani, Hamed', 'RCC', 'Vancouver', '(604) 861-2358', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Amouzgar, Dina', 'RCC', 'Vancouver', '(604) 626-6495', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Bagheri, Roja', 'RCC', 'Vancouver', '(604) 805-9562', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Baker, Rodney', 'RCC', 'Vancouver', '(778) 999-7200', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Billows, Shandelle', 'RSW', 'Vancouver', '(604) 723-0807', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Buthmann, Deborah', 'CCC', 'Vancouver', '(778) 601-6680', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Carter, Denise', 'RSW', 'Vancouver', '(236) 515-0789', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Champion, Lauren', 'RCC', 'Vancouver', '(604) 842-3329', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Clarkson, Peggy', 'RCC', 'Vancouver', '(778) 323-5314', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Drewlo, Margaret', 'Psychologist', 'Vancouver', '(778) 881-6945', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Dube, John', 'RCC', 'Vancouver', '(604) 988-5281', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Evans, Cassandra', 'RCC', 'Vancouver', '(604) 317-4549', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Ghaemi, Nima', 'RCC', 'Vancouver', '(604) 771-6565', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Grandinetti, Teresa', 'RCC', 'Vancouver', '(778) 400-1308', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Gresham, Roxanne', 'RCC', 'Vancouver', '(778) 837-6212', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Harpin, Sapphire', 'RCC', 'Vancouver', '(778) 508-8875', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Howard, Ashley', 'RCC', 'Vancouver', '(604) 505-0898', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Kingdon, Danielle', 'Psychologist', 'Vancouver', '(604) 770-2881', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Meyer, Kirsten', 'RCC', 'Vancouver', '(778) 882-2240', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Mills, Maryam', 'RCC', 'Vancouver', '(604) 362-3240', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Moore, Catherine', 'RCC', 'Vancouver', '(604) 368-6374', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Mowbray, Paige', 'RSW', 'Vancouver', '(778) 860-3120', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Northey, Tracy Anne', 'RSW', 'Vancouver', '(604) 376-6598', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Pappajohn, Paula', 'RCC', 'Vancouver', '(604) 908-9918', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Parker, Allison', 'RCC', 'Vancouver', '(236) 514-0366', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Patrich, Gabriel', 'RCC', 'Vancouver', '(604) 671-3476', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Schaubel, Shawn', 'RSW', 'Vancouver', '(604) 807-6279', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Speak, Margaret-Anne', 'CCC', 'Vancouver', '(604) 761-3440', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('North Vancouver Vardy, Suzanne', 'RCC', 'Vancouver', '(604) 733-8409', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Richmond, Pamela', 'RCC', 'Multiple', '(604) 362-7339', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Abtahi, Zari', 'RCC', 'Vancouver', '(778) 892-5537', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Oak Bay Elmhurst, Katie', 'RCSW', 'Vancouver', '(250) 208-6949', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Osoyoos Calder, Lisa', 'RSW', 'Interior', '(250) 485-8902', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Osoyoos Herd, Angela', 'RCC', 'Interior', '(778) 888-4660', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Parksville Spencer, Christopher', 'RSW', 'Vancouver', '(604) 561-3669', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Parksville Bimala Spencer', 'RCC', 'Vancouver', '(604) 561-3669', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Parksville Mia James Lewis', 'RCC', 'Vancouver', '(250) 228-1033', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Parksville Roach, Kate', 'RCC', 'Vancouver', '(604) 329-1245', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Parksville Esson, Maryann', 'RCC', 'Vancouver', '(250) 753-6578', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Parksville Hancox, Diane', 'CCC', 'Vancouver', '(250) 586-7380', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Parksville Hebb, David', 'RSW', 'Vancouver', '(250) 819-5998', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Parksville Ishioka, Mina', 'RCC', 'Vancouver', '(250) 240-1396', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Parksville Saltel, Linnea', 'RCC', 'Vancouver', '(604) 396-2296', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Alberni Rutter, Bronwen', 'RCC', 'Vancouver', '(250) 210-8936', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Qualicum Beach Wright, Courtney', 'RSW', 'Vancouver', '(250) 947-1310', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Peachland Zuest, Kristen', 'RCC', 'Interior', '(604) 768-7552', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Pemberton Quamme, Heather', 'RCC', 'Vancouver', '(604) 240-9166', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Pender Island Falck, Elina', 'RCC', 'Vancouver', '(250) 515-2123', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Pender Island Knight, Leslie', 'RSW', 'Vancouver', '(867) 334-6246', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Bysterveld, Lindsay', 'RCC', 'Interior', '(250) 462-5055', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Simon, Tamara', 'RSW', 'Interior', '(250) 486-4440', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Liberado, Poe', 'RSW', 'Interior', '(778) 200-3189', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Kollman, Mindy', 'RCC', 'Interior', '(250) 492-0400', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Balisky, Keith', 'CCC', 'Interior', '(250) 486-1868', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Bibbs, Lucinda', 'RCC', 'Interior', '(604) 347-5316', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Bogyo, Grant', 'Psychologist', 'Interior', '(250) 488-0684', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Brady, Irene', 'CCC', 'Interior', '(250) 490-7956', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Carey-Barkley, Maureen', 'RCC', 'Interior', '(250) 770-3121', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Charvin, Vanessa', 'RCC', 'Interior', '(250) 328-8961', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Friesen, Staci', 'RSW', 'Interior', '(250) 486-1868', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Gale, Melanie', 'RSW', 'Interior', '(250) 490-7658', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Ireland, Jocelan', 'RSW', 'Interior', '(306) 930-6993', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Kast, Susan', 'RSW', 'Interior', '(250) 487-9857', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton King, Stephen', 'RCC', 'Interior', '(250) 492-0400', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Kinman, Christopher', 'RCC', 'Interior', '(604) 347-5316', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Konynenberg, Melanie', 'RCC', 'Interior', '(250) 486-1868', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Markus-Pawliuk, Erica', 'RCC', 'Interior', '(250) 462-7307', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Mcalister, Stephanie', 'RCC', 'Interior', '(519) 359-7763', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Mcdonald , Lyn', 'RCC', 'Interior', '(250) 486-1543', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Mitchell, Christel', 'RCC', 'Interior', '(250) 868-7345', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Ohori, David', 'RCC', 'Interior', '(250) 617-1865', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Oliver, Haley', 'Psychologist', 'Interior', '(778) 531-2786', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Povoledo, Jennifer', 'RSW', 'Interior', '(250) 488-4697', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Redivo, Rhea', 'RSW', 'Interior', '(250) 488-5939', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Schwarz, Christine', 'RSW', 'Interior', '(250) 588-5330', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Sullivan, Olivia', 'RSW', 'Interior', '(250) 487-0195', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Thain, Amy', 'RCC', 'Interior', '(604) 347-5316', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Totten, Alicia', 'RSW', 'Interior', '(250) 492-0400', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Turpin, Natalie', 'RCC', 'Interior', '(250) 486-1868', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Vasquez, Chizor', 'RSW', 'Interior', '(604) 347-5316', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Warner , Katherine', 'RCC', 'Interior', '(250) 258-4856', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Wilson, Steven', 'RCC', 'Interior', '(250) 488-4661', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Penticton Zakrzewska , Izabela', 'RCC', 'Interior', '(250) 486-1868', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Alberni Casavant, Tooie', 'CCC', 'Vancouver', '(250) 730-0186', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Alberni Karlsen, Sandra', 'RSW', 'Vancouver', '(250) 735-8140', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Alberni Severinson, Amber', 'RSW', 'Vancouver', '(236) 544-0464', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Alberni Davis, Tanya', 'RSW', 'Vancouver', '(250) 702-3572', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Alberni Allder, Darcy', 'RCSW', 'Vancouver', '(250) 818-0419', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Alberni Ana, Pamela', 'CCC', 'Vancouver', '(250) 723-9818', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Alberni Bordeleau, Shayleen', 'RCC', 'Vancouver', '(250) 720-5633', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Alberni Burnett, Tehani', 'RCSW', 'Vancouver', '(250) 667-5617', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Alberni Cowan, James', 'RCC', 'Vancouver', '(250) 735-8822', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Alberni Ducheck, Daniel', 'RCC', 'Vancouver', '(778) 716-7040', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Alberni Krzton, Thomas', 'RSW', 'Vancouver', '(647) 962-2804', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Alberni Le Normand, Laurel', 'RCC', 'Vancouver', '(250) 724-0125', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Alberni Minard, Jennifer', 'RCC', 'Vancouver', '(250) 724-0125', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Alberni Moore, Maryjane', 'RCC', 'Vancouver', '(250) 724-0125', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Alberni Potter, Laurie', 'RCC', 'Vancouver', '(250) 855-8780', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Alberni Rader, Toby', 'RSW', 'Vancouver', '(250) 720-5646', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Alberni Robertson , Stephanie', 'RCC', 'Vancouver', '(250) 724-0125', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Alberni Roubaud , Natalia', 'RSW', 'Vancouver', '(250) 723-7789', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Alberni Rutter , Bronwen', 'RCC', 'Vancouver', '(778) 421-8809', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Alberni Ulloa, Emy', 'RSW', 'Vancouver', '(403) 909-8475', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Alberni Weis, Deborah', 'RCC', 'Vancouver', '(250) 731-8144', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Alberni Zryd, David', 'RCC', 'Vancouver', '(250) 724-7104', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Coquitlam Archibald , Lauralee', 'RSW', 'Fraser', '(613) 692-3337', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Coquitlam Avery, Siobhan', 'CCC', 'Fraser', '(778) 791-1763', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Coquitlam Chakraborti, Esha', 'RCC', 'Fraser', '(604) 653-3309', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Coquitlam Chung, Chi Chuen', 'RCC', 'Fraser', '(778) 835-7648', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Coquitlam Clarke, Kimberly', 'RCSW', 'Fraser', '(778) 988-9395', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Coquitlam Harris, Kelsey', 'RCC', 'Fraser', '(204) 396-5894', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Coquitlam Huang, Wendy Wan Yi', 'RCC', 'Fraser', '(604) 710-8616', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Coquitlam Hundle , Perminder', 'RCC', 'Fraser', '(604) 754-9240', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Coquitlam Hyslop, Dorothy', 'RCC', 'Fraser', '(604) 765-1039', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Coquitlam Jasra, Aditi', 'CCC', 'Fraser', '(604) 317-9267', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Coquitlam O''Quinn, Jillian', 'RCC', 'Fraser', '(778) 938-1627', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Coquitlam Queenan, Hannah', 'RCC', 'Fraser', '(778) 879-1144', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Coquitlam Saunders, Keith', 'Psychologist', 'Fraser', '(604) 802-5202', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Coquitlam Unaegbu, Ruth', 'RCC', 'Fraser', '(604) 265-9280', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Coquitlam Von Chorus, Nicole', 'RCC', 'Fraser', '(604) 828-7612', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Davidson , Tasha', 'RCC', 'Fraser', '(780) 691-4857', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Sechelt Banton, Operine', 'RCC', 'Multiple', '(604) 552-3612', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Hardy Hanuse, Noelle', 'CCC', 'Vancouver', '(778) 227-4448', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Hardy Sedgemore, Maggie', 'RCC', 'Vancouver', '(250) 949-0176', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lennan, Sarah', 'CCC', 'Vancouver', '(250) 949-0376', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Hardy Van Borek, Alexander', 'RSW', 'Vancouver', '(250) 949-1175', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Aguila, Dina', 'CCC', 'Fraser', '(778) 883-1434', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Arnold, Sharon', 'Psychologist', 'Fraser', '(604) 492-1699', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Boyal, Parveen', 'RCC', 'Fraser', '(778) 775-7504', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Britton, Annaruth', 'RSW', 'Fraser', '(778) 231-7827', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Damon, Lori', 'RCC', 'Fraser', '(604) 512-3266', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Lam, Jason', 'RSW', 'Fraser', '(604) 373-4677', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Latifpour, Sonja', 'RSW', 'Fraser', '(604) 492-2884', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Lei, Julianna', 'RCC', 'Fraser', '(778) 775-7504', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Lupetin-Cindric, Caroline', 'RCC', 'Fraser', '(604) 720-8359', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Macinnes, Hunter', 'RCC', 'Fraser', '(778) 697-5913', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Magri, Lori', 'RCC', 'Fraser', '(604) 760-5140', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Mitchinson, Jaclyn', 'RCC', 'Fraser', '(778) 888-5277', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Mitchinson , Karen', 'RCC', 'Fraser', '(604) 315-6697', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Moore, Sherry', 'RSW', 'Fraser', '(604) 313-8512', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Negreiros, Juliana', 'Psychologist', 'Fraser', '(604) 200-3812', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Ng, Ashley', 'RCC', 'Fraser', '(587) 800-0634', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Nicol, Claire', 'RCC', 'Fraser', '(778) 840-2192', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Pittman, Natasha', 'RCC', 'Fraser', '(604) 313-7950', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Rabb, Lara', 'RCC', 'Fraser', '(604) 455-8399', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Saikia, Gayatri', 'RCC', 'Fraser', '(604) 724-5184', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Sheere, Mina', 'RCC', 'Fraser', '(604) 366-1264', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Slykhuis, Dawn', 'RSW', 'Fraser', '(778) 883-4933', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Susswein, Sarah', 'RCC', 'Fraser', '(778) 837-5422', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Vinson, Katy', 'RCC', 'Fraser', '(778) 991-4876', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Whitlaw, Jane', 'RCC', 'Fraser', '(604) 704-7469', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Yasumiishi, Katherine Rie', 'RSW', 'Fraser', '(778) 991-2273', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Port Moody Nash, Caitlin', 'RCC', 'Vancouver', '(647) 982-6585', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Powell River Thrasher, Heather', 'CCC', 'Vancouver', '(604) 414-6558', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Powell River Berghauser, Rick', 'CCC', 'Vancouver', '(604) 223-2717', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Powell River Bourguignon, Diane', 'RCC', 'Vancouver', '(604) 414-9956', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Powell River Cameron, Ron', 'RCSW', 'Vancouver', '(604) 223-4780', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Powell River Cocksedge, Laura', 'RCC', 'Vancouver', '(604) 413-7095', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Powell River Edwards, Maureen', 'CCC', 'Vancouver', '(604) 344-0077', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Powell River Fogwell, Kara', 'RSW', 'Vancouver', '(604) 578-8135', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Powell River Jackson, Shona', 'RCC', 'Vancouver', '(604) 223-7927', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Powell River Lee, Sheena', 'RCC', 'Vancouver', '(604) 413-7095', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Powell River Lundgren, Jill', 'CCC', 'Vancouver', '(403) 860-5865', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Powell River Muirhead, Susanne', 'RCC', 'Vancouver', '(250) 961-6307', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Powell River Parra, John-Michael', 'RCC', 'Vancouver', '(604) 670-8354', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Powell River Rosenfeld, Alana', 'RCC', 'Vancouver', '(604) 413-7095', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Powell River Schwabach, Jon', 'RCC', 'Vancouver', '(604) 487-0633', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Powell River Walford, Chris', 'RCC', 'Vancouver', '(604) 223-4415', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Powell River Whitford, Kirstin', 'RSW', 'Vancouver', '(604) 223-9918', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Kirkland, Tanya', 'CCC', 'Northern', '(250) 882-1542', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Mandy Rowe', 'RSW', 'Northern', '(250) 981-1349', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Neary, Gaylene', 'RCC', 'Northern', '(250) 692-6271', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Deveau, Bradley', 'RCC', 'Northern', '(236) 423-4646', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Sawin, Nicole', 'RSW', 'Northern', '(250) 649-9955', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Fraser, Chuck', 'RSW', 'Northern', '(250) 640-2706', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Okigbo,Stephanie', 'RSW', 'Northern', '(250) 565-8379', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Akeh, Mac Henry', 'RCC', 'Northern', '(250) 552-2521', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Alleman, Ida', 'RCC', 'Northern', '(236) 331-6106', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Boiragi, Louis', 'RSW', 'Northern', '(250) 617-5588', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Brown, Kimberly', 'RCC', 'Northern', '(250) 649-6950', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Creyke, Wyatt', 'RCC', 'Northern', '(250) 962-2415', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Daigle, Kelly', 'RSW', 'Northern', '(672) 983-1483', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Felker, Elsa', 'RSW', 'Northern', '(250) 640-4028', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Finger, Melissa', 'RCC', 'Northern', '(250) 649-5620', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Forsythe, Joyce', 'RCC', 'Northern', '(250) 640-7549', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Francis, Kristi', 'RCC', 'Northern', '(250) 614-2261', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Gable, Katie', 'RSW', 'Northern', '(250) 562-1800', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Ghuman, Ishnoor Singh', 'RCC', 'Northern', '(236) 331-6106', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Goerz, Brent', 'RSW', 'Northern', '(250) 961-7463', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Goudsward, Sage', 'RCC', 'Northern', '(250) 961-8035', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Grattan, Miranda', 'RSW', 'Northern', '(250) 564-3034', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Handford, Chelsea', 'RCC', 'Northern', '(236) 423-4646', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Hawkins , Courtney', 'RCC', 'Northern', '(236) 423-4646', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Henkel, Karyn', 'RSW', 'Northern', '(250) 563-2119', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Hogan, Sean', 'CCC', 'Northern', '(250) 961-3362', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Hunt-Sundman, Whitney', 'RCC', 'Northern', '(250) 962-2415', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Jaggassar, Kathleen', 'CCC', 'Northern', '(250) 962-2415', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Jaswal, Savita', 'RSW', 'Northern', '(236) 331-6106', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Kaseweter, Heidi', 'CCC', 'Northern', '(250) 552-1816', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Kathuria, Parul', 'CCC', 'Northern', '(250) 899-7474', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Laity, Sara', 'RCC', 'Northern', '(250) 564-3034', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Larson, Tracy', 'RCC', 'Northern', '(250) 961-6170', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Lentz, Tim', 'RCC', 'Northern', '(250) 617-2005', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Macdonald, Mary', 'RSW', 'Northern', '(250) 564-2286', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Macdonald, Sue', 'CCC', 'Northern', '(250) 564-9892', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Mcewen, Olivia', 'RCC', 'Northern', '(604) 832-8096', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Mkango, Maria', 'RSW', 'Northern', '(236) 792-4540', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Morrow, Olga', 'RCC', 'Northern', '(250) 562-1800', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Niki, Robichaud', 'RCC', 'Northern', '(236) 423-0077', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Page, Victoria', 'RSW', 'Northern', '(250) 613-7696', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Scully, David', 'RCSW', 'Northern', '(250) 962-2415', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Steinbach, Cayla', 'RCC', 'Northern', '(778) 349-9950', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Stubley, Tammy', 'RCSW', 'Northern', '(250) 614-2261', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Turner, Jessica', 'RCC', 'Northern', '(236) 331-6106', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George West, Cindy', 'RSW', 'Northern', '(672) 983-1483', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince George Zukowski, Simon', 'RCC', 'Northern', '(250) 885-5200', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince Rupert Morven, Frank', 'RCC', 'Northern', '(250) 600-7598', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince Rupert Hoffman, Diana', 'CCC', 'Northern', '(778) 884-5854', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince Rupert Johnson, Melody', 'RSW', 'Northern', '(250) 609-2561', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince Rupert Watkins, Stephanie', 'RCC', 'Northern', '(250) 600-3200', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Prince Rupert Elgert , Shannon', 'CCC', 'Vancouver', '(778) 884-0830', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Princeton Nielsen, Melissa', 'RCC', 'Interior', '(250) 295-3988', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Qualicum Beach Osborn, David', 'RCC', 'Vancouver', '(250) 951-5211', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Queen Charlotte George, Karen', 'CCC', 'Northern', '(778) 361-0179', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Quesnel Anderson, Sheila', 'RSW', 'Northern', '(250) 255-9526', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Quesnel Balaski, Kirsten', 'RCC', 'Northern', '(250) 255-8684', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Quesnel Herrett, Jocelyn', 'RSW', 'Northern', '(778) 638-0525', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Revelstoke Harris, Lindsey', 'RCC', 'Interior', '(250) 837-0810', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Revelstoke Camozzi, Talia', 'RCC', 'Interior', '(250) 683-9647', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Revelstoke Keates, Jean', 'Psychologist', 'Interior', '(204) 218-4677', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Revelstoke Stovel, Krista', 'RCC', 'Interior', '(778) 252-4357', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Richmond Behr, Shelley', 'RSW', 'Vancouver', '(604) 866-5949', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Picku Multani', 'RCSW', 'Vancouver', '(250) 572-7895', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Richmond Rojas, Carolina', 'RCC', 'Vancouver', '(778) 860-4910', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Richmond Babecoff-Kimhi, Talia', 'RCC', 'Vancouver', '(604) 616-1358', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Richmond Bath, Manj', 'RCC', 'Vancouver', '(604) 369-3890', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Richmond Cheng, Hoi Pan', 'RSW', 'Vancouver', '(250) 300-3758', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Richmond Dey, Annelisa', 'CCC', 'Vancouver', '(604) 256-5850', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Richmond Dey Thomas, Annelisa', 'CCC', 'Vancouver', '(604) 644-5246', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Richmond Fialkow, Jonah', 'RCC', 'Vancouver', '(604) 368-1084', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Richmond Lee, Allan', 'RCC', 'Vancouver', '(604) 897-3414', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Richmond Ma, Ronald', 'Psychologist', 'Vancouver', '(604) 279-8992', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Richmond Naguiat, Lianne', 'RCC', 'Vancouver', '(604) 207-1984', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Richmond Sahota, Ajay', 'RCC', 'Vancouver', '(604) 248-2456', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Low, Kevan', 'RCC', 'Vancouver', '(604) 369-3890', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Roberts Creek Cannon, Allison', 'RCC', 'Multiple', '(236) 991-7772', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Roberts Creek Jane Osborne', 'CCC', 'Vancouver', '(604) 740-7862', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Roberts Creek Houle, Viviane', 'RSW', 'Vancouver', '(604) 886-3811', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Roberts Creek Simpson, Grant', 'RCC', 'Vancouver', '(604) 740-6307', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Roberts Creek Voth, Lisa', 'RCC', 'Vancouver', '(778) 319-5928', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Roberts Creek Whippy , Amanda', 'RCC', 'Vancouver', '(604) 379-8646', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Rossland Daoust, Michelle', 'CCC', 'Interior', '(250) 245-3457', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Saanich Bebb, Emily-May', 'RCC', 'Vancouver', '(250) 208-4874', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Saanich Miciano, Mary Trisha', 'CCC', 'Vancouver', '(236) 458-3392', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Saanich Nevin, Richard', 'RCC', 'Vancouver', '(250) 888-0670', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Salmo Laurence, Jessica', 'CCC', 'Interior', '(250) 808-5408', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Salmon Arm Berezan, Mary Jane', 'CCC', 'Interior', '(250) 558-9018', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Salmon Arm Calhoun, Shawna', 'CCC', 'Interior', '(778) 257-4092', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Salmon Arm Cooper, Roseanne', 'RCC', 'Interior', '(250) 804-8666', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Salmon Arm Dessaulles, Valerie', 'RCC', 'Interior', '(778) 824-1168', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Salmon Arm Gatien, Bria', 'RCC', 'Interior', '(250) 319-5510', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Salmon Arm Ginter, Brett', 'Psychologist', 'Interior', '(250) 804-5326', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Salmon Arm Irvine, Kathleen', 'Psychologist', 'Interior', '(250) 515-1370', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Salmon Arm Johnson, Jehane', 'CCC', 'Interior', '(250) 253-0254', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Salmon Arm Kieft, Kendra', 'RCC', 'Interior', '(250) 515-1003', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Salmon Arm Miege, Caroline', 'CCC', 'Interior', '(250) 253-0243', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Salmon Arm Nadeau, Alison', 'RCC', 'Interior', '(250) 833-4335', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Salmon Arm Rothwell, Shawna', 'RSW', 'Interior', '(250) 804-3929', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Salmon Arm Thielman, Tammy', 'RSW', 'Interior', '(250) 253-4945', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Salmon Arm Voth, Merel', 'RSW', 'Interior', '(250) 253-3813', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Salmon Arm Young, Lisa Marie', 'RCC', 'Interior', '(778) 489-5630', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('White Rock Rawn, Akeiko', 'RCC', 'Multiple', '(778) 899-8735', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Salt Spring Island Ahmed, Isma', 'RSW', 'Vancouver', '(778) 533-4762', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Salt Spring Island Ashley-Martz, Gillian', 'RSW', 'Vancouver', '(604) 418-0767', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Salt Spring Island Burton, Marcia', 'RCC', 'Vancouver', '(250) 930-4541', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Salt Spring Island Fry, Margaret Larisa', 'CCC', 'Vancouver', '(905) 932-4656', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Eadie, David', 'RCC', 'Vancouver', '(250) 888-7408', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Saturna Island Bird, Noele', 'RCC', 'Vancouver', '(778) 232-8272', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Sechelt Baker, Dianne', 'CCC', 'Vancouver', '(604) 989-8424', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Sechelt Barnes, Laura', 'RCC', 'Vancouver', '(604) 657-7292', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Sechelt Charters, Wendy', 'RCC', 'Vancouver', '(604) 741-1376', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Sechelt Hibbard, Jennifer', 'RCC', 'Vancouver', '(604) 399-8181', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Sechelt Massar, Anne', 'RCC', 'Vancouver', '(604) 753-8485', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Sechelt Perry, Sue', 'CCC', 'Vancouver', '(604) 740-2791', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Sechelt Pierce, Tulani', 'RCC', 'Vancouver', '(778) 645-0557', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Sidney Mackenzie, Michael', 'RCC', 'Vancouver', '(604) 774-6900', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Skidegate Byrne-Wissink, Jennifer', 'RCC', 'Northern', '(250) 637-1863', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Smithers Chan, Laura', 'RCC', 'Northern', '(250) 643-8562', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Smithers Jones, Patricia', 'CCC', 'Northern', '(604) 706-2229', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Smithers Morgan, Kirsten', 'RSW', 'Northern', '(250) 877-0794', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Smithers Murdoch, Ruth', 'CCC', 'Northern', '(250) 847-4989', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Smithers Nadeau, Andra', 'RCSW', 'Northern', '(778) 400-6364', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Smithers Wenzel, David', 'RCC', 'Northern', '(778) 281-1394', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Smithers Williams, Erin', 'CCC', 'Northern', '(250) 651-0535', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Sooke Ferrara, Alexandra', 'RCC', 'Interior', '(250) 642-5152', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Sooke Bates, Lorraine', 'RCC', 'Vancouver', '(250) 888-7408', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Sooke Glidden, Kirsten', 'CCC', 'Vancouver', '(236) 508-7327', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Sooke Squitti, Sherry-Lynn', 'RCC', 'Vancouver', '(250) 888-7408', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Kirkwood, Sandy', 'RCC', 'Vancouver', '(250) 888-7408', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Haug, Sally-Anne', 'RCC', 'Vancouver', '(250) 888-7408', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Sparwood Lyall, Jennifer', 'RCC', 'Interior', '(250) 433-6929', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Squamish Edden, Tom', 'RCSW', 'Vancouver', '(778) 895-1500', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Squamish Allen, Caitlin', 'RCC', 'Vancouver', '(604) 360-0795', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Squamish Baker, Carlee', 'RCC', 'Vancouver', '(604) 815-3661', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Squamish Berman, Danielle', 'RCSW', 'Vancouver', '(289) 684-9341', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Squamish Beynon, Helen', 'RCC', 'Vancouver', '(778) 999-3614', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Squamish Byrne, Samantha', 'CCC', 'Vancouver', '(778) 878-6302', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Squamish Costigan, Ashley', 'RSW', 'Vancouver', '(403) 608-9924', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Squamish David , Riley', 'RSW', 'Vancouver', '(604) 802-1607', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Squamish Dickson, Jon', 'CCC', 'Vancouver', '(604) 787-8605', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Squamish Dyck, Bonnie', 'RCC', 'Vancouver', '(250) 885-0275', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Squamish Miller, Julie', 'RSW', 'Vancouver', '(604) 377-0682', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Squamish Milstein, Stephen', 'Psychologist', 'Vancouver', '(604) 938-3511', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Squamish Mueller, Bernd', 'RSW', 'Vancouver', '(604) 849-3824', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Squamish Ozeke, Begum', 'RCC', 'Vancouver', '(778) 802-4229', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Squamish Paquette, Julie', 'RCC', 'Vancouver', '(604) 848-1188', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Squamish Sentesy, Andrea', 'RCC', 'Vancouver', '(604) 848-4147', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Squamish Trotter, Kristin', 'RCC', 'Vancouver', '(604) 848-4076', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Squamish Turczyk, Katrin', 'RCC', 'Vancouver', '(778) 707-5288', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Whistler Craig, Helen', 'RCC', 'Vancouver', '(604) 910-6598', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Summerland Hamel, Sylvie', 'RCC', 'Interior', '(250) 328-4252', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Sun Peaks Lara, Karen', 'CCC', 'Interior', '(250) 299-8543', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Kenny, Ruth', 'RSW', 'Fraser', '(778) 223-1574', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Pellatt, Natashia', 'RCC', 'Fraser', '(604) 345-0202', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Reandy, Jennifer', 'RCC', 'Fraser', '(604) 250-1813', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Crow, Karina', 'RSW', 'Fraser', '(778) 901-6261', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Vaugeois, Alma', 'RCC', 'Fraser', '(604) 538-2232', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Chhokar, Bel', 'RSW', 'Fraser', '(778) 723-2968', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Johansen, Camila', 'CCC', 'Fraser', '(778) 987-1710', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Mann,Vijay', 'RCC', 'Fraser', '(778) 552-5250', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Alexandrovich, Dmitry', 'CCC', 'Fraser', '(587) 679-5974', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Andhi Bilkhu, Sonia', 'RSW', 'Fraser', '(604) 307-8796', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Archibald, Lauralee', 'RSW', 'Fraser', '(778) 872-1034', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Arthur, Judi', 'RCC', 'Fraser', '(604) 897-1460', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Atwal, Jasmin', 'RCC', 'Fraser', '(778) 999-8974', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Balaj, Rodica', 'RCC', 'Fraser', '(604) 290-1051', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Belter, Wendy', 'CCC', 'Fraser', '(778) 688-4483', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Berry, Adele', 'RCC', 'Fraser', '(604) 838-4022', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Bird, Jasmine', 'RCC', 'Fraser', '(604) 398-5383', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Birk, Simrit', 'RCC', 'Fraser', '(778) 903-5661', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Bjurling, Camilla', 'RCC', 'Fraser', '(778) 808-3039', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Black, Paula', 'RCC', 'Fraser', '(604) 417-8308', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Boileau, Karen', 'CCC', 'Fraser', '(604) 542-7597', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Braid, Khalida', 'RSW', 'Fraser', '(403) 690-9470', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Brienza, Melissa', 'RCC', 'Fraser', '(604) 764-7902', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Cahuas, Alexander', 'RSW', 'Fraser', '(416) 710-4603', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Chatwin, Andrea', 'CCC', 'Fraser', '(604) 562-8308', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Collins, Alexandra', 'CCC', 'Fraser', '(604) 536-9611', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Curry, Robin', 'RCC', 'Fraser', '(778) 919-6434', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Davison, Heidi', 'CCC', 'Fraser', '(604) 866-1522', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Dawson, Spencer Margaret', 'RCC', 'Fraser', '(604) 815-7989', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vries, Nancy', 'RCC', 'Fraser', '(778) 668-8602', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Dsouza, Audrey', 'RCC', 'Fraser', '(236) 987-1104', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Edwards, Charlotte', 'RCC', 'Fraser', '(604) 726-0884', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Enriquez Escobar, Maria Fernanda', 'RCC', 'Fraser', '(604) 404-5357', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Fayese, Anthony', 'RSW', 'Fraser', '(604) 349-6393', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Francis, Nissa', 'RSW', 'Fraser', '(778) 872-1034', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Freeman, Jodi', 'RCC', 'Fraser', '(604) 226-6218', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Gabriel, Michael', 'RCC', 'Fraser', '(604) 883-1300', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Gill, Jessica', 'RCC', 'Fraser', '(778) 881-7298', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Henneberry, Lauren', 'RCC', 'Fraser', '(778) 877-8401', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Hunniford, Natalie', 'RCC', 'Fraser', '(604) 728-9646', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Hunting Keen, Rebecca', 'RCC', 'Fraser', '(604) 808-0400', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Jacobs, Rhea', 'RCC', 'Fraser', '(604) 377-6033', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Jammal, Collins', 'RSW', 'Fraser', '(778) 927-6744', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Karimiha, Gelareh', 'Psychologist', 'Fraser', '(604) 584-3450', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Kelly, Colleen', 'RCC', 'Fraser', '(604) 590-5440', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Kemp, Jermaine', 'RCC', 'Fraser', '(604) 363-6695', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Khan-Jamal, Amrin', 'RSW', 'Fraser', '(778) 388-4952', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Kim, Dan', 'RSW', 'Fraser', '(604) 505-6729', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Mackenzie , Tracey', 'CCC', 'Fraser', '(604) 763-2124', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Makkar, Meena', 'RCC', 'Fraser', '(778) 997-5463', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Malone, Ciara', 'RCC', 'Fraser', '(604) 803-5651', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Mann, Manjot', 'RCC', 'Fraser', '(778) 895-8097', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Mann, Parminder', 'RCC', 'Fraser', '(604) 512-7220', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Maxwell, Simone', 'RSW', 'Fraser', '(604) 541-4827', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Nichols, Chipo', 'Psychologist', 'Fraser', '(778) 823-0865', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Miki, Melanie', 'RCC', 'Fraser', '(604) 868-4264', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Millar, Connie', 'RCC', 'Fraser', '(604) 366-0147', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Mirza-Agha, Melody', 'RCC', 'Fraser', '(604) 589-1868', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Mohan, Rejoe', 'RCC', 'Fraser', '(604) 716-9979', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Mooney, Helen', 'RSW', 'Fraser', '(604) 536-9611', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Mori, Dave', 'RCC', 'Fraser', '(250) 416-7594', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Murray, Sophia', 'RCC', 'Fraser', '(604) 589-1868', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Neary, Sinead', 'RCC', 'Fraser', '(778) 389-6028', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Newman, Ryan', 'RCC', 'Fraser', '(604) 542-2501', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Ofori, Esther', 'RCC', 'Fraser', '(778) 927-5241', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey O''Keeffe, Anne Marie', 'RSW', 'Fraser', '(672) 572-1726', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Olson, Trevor', 'Psychologist', 'Fraser', '(778) 828-0853', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Opacic Lunot , Lola', 'RSW', 'Fraser', '(778) 288-8361', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Orzeck, Tricia', 'Psychologist', 'Fraser', '(604) 378-4249', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Pangli, Jai-Inder Kaur', 'RSW', 'Fraser', '(604) 825-5264', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Parmar, Japneet', 'RSW', 'Fraser', '(604) 725-6151', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Patta, Ruth', 'RCC', 'Fraser', '(604) 589-5560', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Pybus, Kimberly', 'RSW', 'Fraser', '(604) 512-4810', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Rahman , Raheel', 'RCC', 'Fraser', '(778) 883-4417', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Rai, Parminder', 'RCC', 'Fraser', '(778) 322-6410', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Rajendran, Suresh', 'RCC', 'Fraser', '(604) 584-3450', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Redpath, Ivania', 'RCC', 'Fraser', '(604) 512-1606', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Serban, Diana', 'RSW', 'Fraser', '(778) 885-7621', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Shakdher Menon, Naina', 'RCC', 'Fraser', '(604) 541-4827', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Sihota, Parveen', 'RSW', 'Fraser', '(604) 808-3014', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Silvers, Devon', 'RCC', 'Fraser', '(604) 916-8997', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Sodhi, Sabina', 'RSW', 'Fraser', '(778) 839-8963', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Sohal, Kristina', 'RCC', 'Fraser', '(604) 619-9992', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Jean, Sean', 'RSW', 'Fraser', '(604) 315-7782', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Stevens, Alison', 'Psychologist', 'Fraser', '(604) 719-7744', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Stewart, Cory', 'RCC', 'Fraser', '(778) 807-2412', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Sylvester, Anne-Marie', 'RCC', 'Fraser', '(604) 424-8280', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Tien , Laurel', 'RCC', 'Fraser', '(604) 612-6906', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Trivedi, Foram Hitesh', 'RCC', 'Fraser', '(604) 541-4827', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Undurraga, Maria', 'Psychologist', 'Fraser', '(604) 809-9681', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Velasco, Taciana', 'RSW', 'Fraser', '(604) 360-7742', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Verheyden, Cheryl', 'RCC', 'Fraser', '(236) 788-6992', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Vijayan, Asha', 'RSW', 'Fraser', '(778) 872-1034', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Walker, Shannon', 'RCC', 'Fraser', '(604) 788-1034', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey West, Douglas', 'RCC', 'Fraser', '(604) 771-1344', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Surrey Wong, Vermonte', 'RCC', 'Fraser', '(778) 775-3027', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Sackey, Ayesha', 'RSW', 'Multiple', '(778) 938-5749', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('White Rock Hayer, Gagan', 'RCC', 'Fraser', '(604) 783-7593', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Terrace Pollitt, Devin', 'RSW', 'Interior', '(250) 615-6512', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Terrace Capar, Asta', 'CCC', 'Northern', '(250) 638-8311', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Terrace Conlon, Sandra', 'RCC', 'Northern', '(250) 615-2241', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Terrace Mann, Teresa', 'RCC', 'Northern', '(250) 641-1118', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Terrace Sanderson, Rowan', 'CCC', 'Northern', '(250) 641-8394', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Terrace Smith, Katharine', 'CCC', 'Northern', '(250) 631-6194', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Terrace Vendittelli, Jennifer', 'RCC', 'Northern', '(250) 922-4200', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Terrace Viveiros, Susan', 'CCC', 'Northern', '(250) 615-7532', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Thornhill Doody, Carolyn Ann', 'CCC', 'Northern', '(250) 641-3705', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Tlell Rigg, Janet', 'CCC', 'Northern', '(778) 828-9597', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Tofino Fleishman, Alyssa', 'RSW', 'Vancouver', '(778) 893-3677', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Tofino Kostashuk, Erin', 'CCC', 'Vancouver', '(250) 266-1476', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Tofino Souch, Tara', 'CCC', 'Vancouver', '(250) 650-4835', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Tofino Zobel, Marcel', 'RCC', 'Vancouver', '(250) 726-4089', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Trail Swanson, Lori', 'RSW', 'Interior', '(250) 231-1529', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Trail Clarke, Christine', 'RCC', 'Interior', '(250) 726-3742', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Trail Devlin, Cori', 'RCC', 'Interior', '(250) 215-1835', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Tulameen Robic, Lisa', 'RSW', 'Interior', '(250) 438-0024', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Ucluelet Bird, Margaret', 'RCC', 'Vancouver', '(250) 726-8142', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Ucluelet Cameron, Amanda', 'RCC', 'Vancouver', '(250) 726-3841', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Ucluelet Hagar, Sarah', 'RCC', 'Vancouver', '(250) 726-4074', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Ucluelet Richmond, Elena', 'RCC', 'Vancouver', '(604) 396-7082', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Valemount Whalen, Heather', 'RSW', 'Northern', '(709) 214-1297', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Mcintyre, Imogen', 'RSW', 'Fraser', '(250) 714-3321', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Bath,Gabby', 'RCC', 'Vancouver', '(778) 242-5778', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Fisher, Lexi', 'RSW', 'Vancouver', '(604) 256-5850', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Bath, Gabriella', 'RCC', 'Vancouver', '(778) 242-5778', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Gowans, Maura', 'RSW', 'Vancouver', '(604) 374-4344', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Nightbird, Marie', 'RCSW', 'Vancouver', '(604) 737-2020', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Sinclair, Anne', 'RCC', 'Vancouver', '(604) 728-5877', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Stewart, Colleen', 'RSW', 'Vancouver', '(236) 998-9435', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Sumner, Darren', 'RSW', 'Vancouver', '(604) 602-6607', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Koble, Jennifer-Lee', 'RSW', 'Vancouver', '(604) 322-6227', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Stewart, Leah', 'RCC', 'Vancouver', '(778) 200-3201', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Karina, Czyzewski', 'RSW', 'Vancouver', '(604) 842-1408', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Woitas, Rod', 'RCC', 'Vancouver', '(604) 267-7008', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Eaton, Ashleigh', 'RCC', 'Vancouver', '(778) 866-1753', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Rathwell, Jessica', 'RCC', 'Vancouver', '(604) 657-0960', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver D''Silva, Rachel', 'RCC', 'Vancouver', '(236) 558-7825', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Kraatz, Kaitlyn', 'CCC', 'Vancouver', '(604) 657-0960', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Wong, Maryanne', 'RSW', 'Vancouver', '(604) 657-0960', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Chung, Kelvin', 'RCC', 'Vancouver', '(778) 835-7648', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Golbabai, Paul', 'RCC', 'Vancouver', '(647) 870-9027', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Jessie Dhaliwal', 'RCC', 'Vancouver', '(604) 292-7043', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Lazar,Joelle', 'RCC', 'Vancouver', '(604) 788-2804', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Mik Turje', 'RSW', 'Vancouver', '(604) 682-7325', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Miners, Rick', 'Psychologist', 'Vancouver', '(605) 336-2844', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Mondlak, Avi', 'RCC', 'Vancouver', '(604) 644-9133', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Montgomery, Gwen', 'RCC', 'Vancouver', '(604) 488-0326', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Motha, Manisha', 'RSW', 'Vancouver', '(778) 772-2682', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Sharon Van Volkingburgh', 'RCSW', 'Vancouver', '(604) 209-7165', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Vickram,Pam', 'RSW', 'Vancouver', '(778) 321-5433', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Yeung, Victoria', 'RCC', 'Vancouver', '(236) 868-2302', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Abdipour, Maryam', 'RCC', 'Vancouver', '(604) 732-3930', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Abrami, Deborah', 'Psychologist', 'Vancouver', '(604) 224-0221', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Abrams, Ellen', 'RCC', 'Vancouver', '(778) 846-5244', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Adamsons, Melanie', 'RCC', 'Vancouver', '(778) 899-1195', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Agarwal, Kirti', 'RCC', 'Vancouver', '(581) 221-5422', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Agarwal, Shivani', 'RCC', 'Vancouver', '(604) 379-5648', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Ahn, Sookyung', 'RCC', 'Vancouver', '(604) 352-7024', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Allen, Jennifer', 'RSW', 'Vancouver', '(647) 693-7520', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Allison, Colleen', 'Psychologist', 'Vancouver', '(778) 999-7394', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Almost, David', 'RCC', 'Vancouver', '(604) 876-7600', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Alvarez, Melanie', 'RCC', 'Vancouver', '(604) 713-6708', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Anderson, Amie', 'RSW', 'Vancouver', '(604) 250-8792', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Antifaeff, Kelsey', 'RCSW', 'Vancouver', '(604) 398-4956', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Araujo, Andrea', 'RCC', 'Vancouver', '(604) 367-1324', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Aref Nazari, Masoud', 'RCC', 'Vancouver', '(604) 336-2844', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Arvidson, Cristina', 'RCC', 'Vancouver', '(604) 738-3625', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Arya, Nidhi', 'RSW', 'Vancouver', '(604) 704-2376', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Assier , Sonia', 'RCC', 'Vancouver', '(514) 247-6004', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Atnikov, Jessica', 'RCC', 'Vancouver', '(778) 222-7778', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Atwijiyor, Helen', 'RCC', 'Vancouver', '(647) 855-2990', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Bader, Deanna', 'RCC', 'Vancouver', '(778) 926-2645', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Badial, Jessica', 'RSW', 'Vancouver', '(778) 222-7778', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Bal, Robert', 'RCC', 'Vancouver', '(604) 655-1511', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Baracaldo, Laura', 'RSW', 'Vancouver', '(306) 880-1763', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Barber, Elise', 'RSW', 'Vancouver', '(604) 657-0960', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Batta, Millie', 'RCC', 'Vancouver', '(604) 653-0200', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Battersby, Karen', 'CCC', 'Vancouver', '(604) 614-0645', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Bayer, Kimberley', 'RCC', 'Vancouver', '(604) 253-7440', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Bear, Yvette', 'RSW', 'Vancouver', '(778) 375-2363', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Begg, Jessica', 'RCC', 'Vancouver', '(604) 202-3149', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Benbassat Ali, Karen', 'RCC', 'Vancouver', '(604) 732-3930', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Berkal Sarbit, Sophie', 'RSW', 'Vancouver', '(604) 337-8577', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Bernard, Chantal', 'CCC', 'Vancouver', '(778) 320-7194', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Bevan, Gwen', 'RSW', 'Vancouver', '(604) 790-5338', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Bheaumont, Daeniela', 'Psychologist', 'Vancouver', '(604) 261-4045', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Blackmore, Kathleen', 'RSW', 'Vancouver', '(604) 670-8332', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Blandino, Stephany', 'RCC', 'Vancouver', '(604) 726-6073', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Boerner, Katelynn', 'Psychologist', 'Vancouver', '(604) 808-5559', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Boland , Lori', 'RSW', 'Vancouver', '(604) 619-7693', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Bouchard, Nicolas', 'RCC', 'Vancouver', '(778) 837-2067', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Boundy, Jennifer', 'RSW', 'Vancouver', '(604) 373-2217', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Bowlsby, Nicole', 'RCC', 'Vancouver', '(604) 732-3930', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Boyle, Sarah', 'RCC', 'Vancouver', '(604) 315-7608', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Braund, Rachel', 'RSW', 'Vancouver', '(778) 400-8157', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Bright , Vicki', 'RSW', 'Vancouver', '(778) 836-5038', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Brodie , Karen', 'RCC', 'Vancouver', '(778) 836-5721', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Brotherton, Jay', 'CCC', 'Vancouver', '(250) 552-0025', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Buck, Rachelle', 'RCC', 'Vancouver', '(604) 338-2501', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Budd, Carla', 'RCC', 'Vancouver', '(778) 897-5871', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Buthmann, Deborah', 'RCC', 'Vancouver', '(604) 732-3930', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Campbell, Shoshanna', 'CCC', 'Vancouver', '(778) 712-0513', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Chan, Corey', 'RCC', 'Vancouver', '(778) 323-5797', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Chan , Nicole', 'RCC', 'Vancouver', '(604) 259-1235', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Chang, Julie', 'RCC', 'Vancouver', '(778) 784-7036', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Chen, Min Chi', 'RCC', 'Vancouver', '(236) 994-0520', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Chin, Pamela', 'RCC', 'Vancouver', '(604) 868-0497', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Ching, Stephen', 'CCC', 'Vancouver', '(604) 218-3672', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Christianne , Zamorano', 'RSW', 'Vancouver', '(778) 288-8361', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Christiansen, Aisha', 'Psychologist', 'Vancouver', '(604) 828-2480', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Chung , Mina', 'RCC', 'Vancouver', '(236) 514-1605', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Coady, Vanessa', 'RCC', 'Vancouver', '(604) 368-8799', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Cook, Audrey', 'RCC', 'Vancouver', '(604) 875-9096', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Cope, Alexandra', 'RCC', 'Vancouver', '(604) 417-0446', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Cowie , Julie', 'RCC', 'Vancouver', '(604) 868-6041', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Crawford, Lee', 'RCC', 'Vancouver', '(604) 875-9957', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Dangaltcheva, Antonia', 'Psychologist', 'Vancouver', '(778) 907-6010', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Davis, Sasha', 'Psychologist', 'Vancouver', '(604) 630-3071', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Defant, Randal', 'RSW', 'Vancouver', '(416) 778-8053', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Dhoot , Amrita', 'RCC', 'Vancouver', '(778) 387-8070', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Diaz Bahamon, Susana', 'CCC', 'Vancouver', '(604) 732-3930', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Dinur, Sharon', 'RCC', 'Vancouver', '(604) 732-3930', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Donya , Jalali', 'RSW', 'Vancouver', '(778) 386-4266', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Duarte, Linda', 'RCC', 'Vancouver', '(604) 800-2199', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Dumond, Camille', 'RCC', 'Vancouver', '(778) 870-5411', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Dupuis-Rossi, Riel', 'RSW', 'Vancouver', '(604) 689-8450', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Ellison, Jolie', 'RSW', 'Vancouver', '(604) 992-2843', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver English, Deborah', 'RCC', 'Vancouver', '(778) 242-1124', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Evans, Jason', 'RCC', 'Vancouver', '(604) 874-6264', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Evans Anderson, Gabriella', 'CCC', 'Vancouver', '(236) 866-2220', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Farzaneh, Babak', 'RCC', 'Vancouver', '(604) 837-0194', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Finkelstein , Isaiah', 'RSW', 'Vancouver', '(236) 259-3499', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Finley, Calla', 'RSW', 'Vancouver', '(604) 874-2938', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Fox Tree-Mcgrath , Cheyenne Amber', 'RSW', 'Vancouver', '(778) 723-5535', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Franco Yamin, Diana', 'CCC', 'Vancouver', '(604) 440-9889', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Freed, Galina', 'RCC', 'Vancouver', '(604) 399-5463', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Garfinkel , Michael', 'RSW', 'Vancouver', '(604) 367-6963', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Giffin, Catherine', 'CCC', 'Vancouver', '(604) 620-5010', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Giles, Susan', 'RCC', 'Vancouver', '(604) 687-7171', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Gill, Priya', 'RCC', 'Vancouver', '(604) 727-2087', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Gillingham, Stephanie', 'RSW', 'Vancouver', '(778) 668-0706', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Gonzalez Palomino, Alberto', 'RSW', 'Vancouver', '(604) 256-5850', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Goodacre, Alyse', 'CCC', 'Vancouver', '(249) 702-3702', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Grech, Theresa', 'CCC', 'Vancouver', '(604) 312-7059', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Griffin, April', 'RSW', 'Vancouver', '(236) 412-2539', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Hails , Jay', 'CCC', 'Vancouver', '(604) 834-4367', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Hakami, Rana', 'RCC', 'Vancouver', '(236) 855-8682', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Hamman, Jennifer', 'RCC', 'Vancouver', '(604) 876-7600', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Hanazawa Root, Heidi', 'RCC', 'Vancouver', '(604) 809-6471', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Hassenbein, Heather', 'RCC', 'Vancouver', '(604) 446-3064', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Haywood, Janisha', 'RCC', 'Vancouver', '(249) 315-5889', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Hill, Alexandra', 'RCC', 'Vancouver', '(778) 401-4423', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Hille, Amanda', 'RCC', 'Vancouver', '(604) 250-1624', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Hodgson, Raelene', 'RCC', 'Vancouver', '(604) 682-7325', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Holland, Alison', 'RSW', 'Vancouver', '(604) 315-5848', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Hollinshead, Jennifer', 'CCC', 'Vancouver', '(604) 682-7325', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Horcasitas Ruiz, Denisse', 'CCC', 'Vancouver', '(709) 501-8392', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Howard , Ashley', 'RCC', 'Vancouver', '(604) 505-0898', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Hsu, Pin-Han', 'RCC', 'Vancouver', '(604) 657-0960', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Hukam, Meena', 'RSW', 'Vancouver', '(604) 687-7171', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Hunt , Samantha', 'RSW', 'Vancouver', '(647) 825-9347', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Irving , Sarah', 'RSW', 'Vancouver', '(604) 250-8792', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Jacob, Brittany', 'RCC', 'Vancouver', '(604) 670-1019', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver James, Kate', 'CCC', 'Vancouver', '(604) 206-6879', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Jans, Nadine', 'RCC', 'Vancouver', '(604) 724-8972', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Jardine, Thea', 'RCC', 'Vancouver', '(604) 842-8443', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Joensuu, Eleonora', 'RCC', 'Vancouver', '(778) 344-9644', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Kalantar, Seyedmohammad', 'RCC', 'Vancouver', '(604) 909-3437', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Kambolis, Michele', 'RCC', 'Vancouver', '(604) 689-9116', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Kano, Tamaki', 'CCC', 'Vancouver', '(778) 775-8565', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Keist, Duncan', 'RCC', 'Vancouver', '(778) 899-1195', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Kennedy, Meghan', 'RSW', 'Vancouver', '(604) 732-3930', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Kiesser, Andrea', 'RSW', 'Vancouver', '(778) 887-0543', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Kirk, Jade-Elise', 'CCC', 'Vancouver', '(604) 732-3930', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Kobelt, Amy', 'RCC', 'Vancouver', '(778) 847-7232', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Koch, Elizabeth', 'RCC', 'Vancouver', '(778) 257-5696', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Kolinsky, Naomi', 'RCC', 'Vancouver', '(604) 258-6393', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Kolochuk, Stefani', 'RSW', 'Vancouver', '(204) 296-8782', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Kuo, Elaine', 'RCC', 'Vancouver', '(778) 886-0958', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Kuppers, Kelly', 'RCC', 'Vancouver', '(604) 833-2064', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Kwa, Lydia', 'Psychologist', 'Vancouver', '(604) 682-5818', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Lajoie, Janele', 'RCC', 'Vancouver', '(604) 379-5648', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Larsson, Katarina', 'RCC', 'Vancouver', '(604) 910-2726', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Latimer, Rhiannon', 'RCC', 'Vancouver', '(778) 899-1195', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Lautzenhiser, Aaron', 'Psychologist', 'Vancouver', '(604) 730-0808', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Lawrence, Natascha', 'RCC', 'Vancouver', '(604) 800-9001', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Lee, Sky', 'RSW', 'Vancouver', '(506) 704-5094', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Lee, Sun', 'RCC', 'Vancouver', '(604) 780-4275', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Lefebvre, Lindsay', 'RCC', 'Vancouver', '(778) 814-1622', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Legere, Lauren', 'RCC', 'Vancouver', '(778) 899-1195', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Lenihan, Jessica', 'RSW', 'Vancouver', '(778) 318-6408', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Lige, David', 'RCC', 'Vancouver', '(604) 913-5767', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Lim, Otto', 'RCSW', 'Vancouver', '(604) 762-8182', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Little, Justine', 'RSW', 'Vancouver', '(604) 347-7012', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Locht, Joyce', 'RCC', 'Vancouver', '(604) 614-9915', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Lofquist, Stephanie', 'RCC', 'Vancouver', '(778) 867-0642', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Lorne, Korman', 'Psychologist', 'Vancouver', '(604) 558-2115', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Lyon, Geoffrey', 'RCC', 'Vancouver', '(604) 732-3930', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Lyons, Myriame', 'CCC', 'Vancouver', '(604) 364-2014', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Mackinnon, Joanne', 'Psychologist', 'Vancouver', '(604) 254-9004', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Mahal , Paneet', 'RSW', 'Vancouver', '(647) 693-7520', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Maisonneuve, Claire', 'RCC', 'Vancouver', '(604) 732-3930', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Malcolm, Jennifer', 'RCC', 'Vancouver', '(604) 620-4010', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Marquez, Richard', 'RSW', 'Vancouver', '(604) 687-7171', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Marsh, Adrienne', 'RCC', 'Vancouver', '(604) 734-1511', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Martin, Ginny', 'RCC', 'Vancouver', '(604) 830-1364', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Masse, Allison', 'RCC', 'Vancouver', '(780) 964-9650', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Mccoll, Barbara', 'RCC', 'Vancouver', '(604) 704-3471', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Culloch, Loraine', 'Psychologist', 'Vancouver', '(604) 732-9393', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Evoy, Maureen', 'RCC', 'Vancouver', '(604) 873-3278', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Medina, Elizabeth', 'RCC', 'Vancouver', '(778) 899-3802', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Medine , Sacha', 'RCC', 'Vancouver', '(778) 318-8084', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Mehra, Preetika', 'RSW', 'Vancouver', '(778) 231-4567', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Meissenheimer, Julia', 'CCC', 'Vancouver', '(604) 732-3930', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Miles , Alyssa', 'RCC', 'Vancouver', '(604) 366-9926', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Minor, David', 'RSW', 'Vancouver', '(604) 364-8408', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Moghadami, Nazanin', 'RCC', 'Vancouver', '(604) 551-7591', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Mordell, Sarah', 'Psychologist', 'Vancouver', '(604) 900-8266', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Morgan, Diana', 'RCC', 'Vancouver', '(604) 719-2049', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Morrison, Megan', 'RSW', 'Vancouver', '(604) 828-5919', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Munro, Aaron', 'RCC', 'Vancouver', '(236) 985-0299', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Murphy, Mary', 'RCC', 'Vancouver', '(604) 812-4403', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Myers, Chloe', 'RCC', 'Vancouver', '(604) 788-1286', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Na, Jennifer Jiwon', 'Psychologist', 'Vancouver', '(604) 558-2115', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Nahri, Sara', 'RCC', 'Vancouver', '(604) 732-3930', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Napier, Jennifer', 'RCC', 'Vancouver', '(604) 330-1636', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Nichele, Zoe', 'RCC', 'Vancouver', '(778) 386-2710', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Norkowski, Mich', 'RCC', 'Vancouver', '(604) 657-0960', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver O, Sho Sho', 'CCC', 'Vancouver', '(604) 786-8193', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Oberth, Carla', 'Psychologist', 'Vancouver', '(604) 353-4301', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Olds, Rebecca', 'RCC', 'Vancouver', '(604) 537-0931', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver O''Loughlin, Julia', 'RCC', 'Vancouver', '(778) 847-7472', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Olson, Martin', 'RCC', 'Vancouver', '(604) 260-1964', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Ospina, Luisa', 'RCC', 'Vancouver', '(604) 330-1636', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Ouellette, Kathleen', 'RCC', 'Vancouver', '(604) 826-0654', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Packwood , Sonia', 'Psychologist', 'Vancouver', '(647) 693-7520', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Paling, Orli', 'RCC', 'Vancouver', '(604) 817-8723', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Papaei, Homa', 'RCC', 'Vancouver', '(604) 719-1809', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Paton, Shannon', 'RCC', 'Vancouver', '(604) 449-8483', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Patterson, Kathryn', 'RCC', 'Vancouver', '(604) 812-4210', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Pattria , Angela', 'RCC', 'Vancouver', '(778) 899-3802', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Pecnikova, Lucia', 'RCC', 'Vancouver', '(778) 806-2052', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Petrovic, Ljudmila', 'RCC', 'Vancouver', '(604) 398-8455', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Phung , Natalie', 'RSW', 'Vancouver', '(604) 677-1606', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Power, Nirmal', 'RCC', 'Vancouver', '(778) 321-3133', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Rafael, Rebecca', 'RSW', 'Vancouver', '(778) 991-7984', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Rafizadeh, Lily', 'RCC', 'Vancouver', '(604) 762-4883', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Rappaport, Amy', 'RSW', 'Vancouver', '(604) 914-2172', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Rathlin, Islai', 'RSW', 'Vancouver', '(604) 679-6634', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Ravn, Ferma', 'RSW', 'Vancouver', '(604) 704-5247', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Read, Tara', 'RCC', 'Vancouver', '(604) 732-3930', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Renaud, David', 'RSW', 'Vancouver', '(604) 317-4899', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Robertson, Elspeth', 'RCC', 'Vancouver', '(778) 300-8295', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Sangha , Harkamal', 'RCC', 'Vancouver', '(604) 338-2407', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Sangwan, Nisha', 'RCC', 'Vancouver', '(604) 732-3930', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Santini , Tatiana', 'RCC', 'Vancouver', '(604) 566-9101', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Sao, Krista', 'RCC', 'Vancouver', '(672) 377-8789', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Sasaki, Naoko', 'RCC', 'Vancouver', '(604) 781-0205', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Scott, Heather', 'RCC', 'Vancouver', '(778) 988-2421', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Scully, Sarah', 'RCC', 'Vancouver', '(604) 354-9479', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Segui, John', 'RSW', 'Vancouver', '(604) 961-9298', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Sehrbrock, Joachim', 'Psychologist', 'Vancouver', '(604) 366-3112', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Sengsouvanh, Vilayvanh', 'RCC', 'Vancouver', '(778) 379-9803', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Seyed Sadr, Emad', 'RCC', 'Vancouver', '(778) 952-5406', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Shankar, Ashley', 'RCSW', 'Vancouver', '(604) 561-5807', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Shay, Lauren', 'RSW', 'Vancouver', '(604) 341-4467', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Shergill, Nimrat', 'RCC', 'Vancouver', '(778) 847-3003', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Siddiqui, Areej', 'RCC', 'Vancouver', '(604) 731-4466', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Silverman, Anna', 'RCC', 'Vancouver', '(778) 319-9438', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Simpson, Jayne', 'RSW', 'Vancouver', '(604) 449-8354', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Simpson, Jenny', 'RCC', 'Vancouver', '(778) 228-8750', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Simpson, Jenny Lynn', 'RCC', 'Vancouver', '(778) 228-8750', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Simundic, Joanna', 'RCSW', 'Vancouver', '(778) 778-7012', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Sivak, Katya', 'RCC', 'Vancouver', '(604) 417-3315', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Snodgrass, Shelbi', 'CCC', 'Vancouver', '(778) 819-2488', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Spence, Tommy', 'RSW', 'Vancouver', '(778) 995-2803', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Stacey, Marcia', 'RCC', 'Vancouver', '(778) 385-4495', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Stainton, Rebekkah', 'RCC', 'Vancouver', '(778) 872-5749', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Stefani, Lisa', 'RCC', 'Vancouver', '(604) 732-3930', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Stewart, Ruth Ann', 'RCSW', 'Vancouver', '(604) 687-7171', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Su, Tina', 'Psychologist', 'Vancouver', '(604) 568-8108', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Sukkau, Angel', 'RCC', 'Vancouver', '(604) 657-0960', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Suleyman, Maria', 'RCC', 'Vancouver', '(604) 428-8671', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Sweetable, Jill', 'RCC', 'Vancouver', '(778) 899-1185', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Takara, Shalene', 'RCC', 'Vancouver', '(604) 440-2105', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Tallman, Karen', 'Psychologist', 'Vancouver', '(604) 315-2161', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Tennock, Karen', 'RSW', 'Vancouver', '(604) 687-7171', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Tilma, Nadine', 'RCC', 'Vancouver', '(778) 863-4225', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Tully, Shannon', 'RCC', 'Vancouver', '(778) 242-4006', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Turner-Alexander, Mikah', 'RCC', 'Vancouver', '(604) 816-5764', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Twynstra, Theresa', 'RCC', 'Vancouver', '(604) 910-4336', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Vergel De Dios , Celina', 'RCC', 'Vancouver', '(604) 379-5648', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Vintila , Anda', 'RCC', 'Vancouver', '(236) 863-6649', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Virk, Karin', 'CCC', 'Vancouver', '(604) 726-3807', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Wagg, Jillian', 'RCC', 'Vancouver', '(604) 364-2014', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Wall, Andrea', 'RCC', 'Vancouver', '(604) 621-6975', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Walsh, Jeffrey', 'RSW', 'Vancouver', '(778) 776-4108', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Webb, Rebecca', 'RCSW', 'Vancouver', '(604) 393-5993', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Williams, Jay', 'RSW', 'Vancouver', '(250) 575-9385', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Wong, Kady', 'RCC', 'Vancouver', '(778) 899-3802', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Wong, Keturah', 'CCC', 'Vancouver', '(416) 705-3998', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Woolley, Meredith', 'RCC', 'Vancouver', '(604) 727-7503', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Wu, Tiffany', 'RCC', 'Vancouver', '(778) 385-1842', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Wynne, Lindsay', 'RCC', 'Vancouver', '(778) 601-6655', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Yaroshuk, Angela', 'RCC', 'Vancouver', '(604) 377-3686', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Zelichowska, Joanna', 'RCC', 'Vancouver', '(604) 727-5114', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Zeng , Yun', 'RCC', 'Vancouver', '(672) 881-0806', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Zhang, Junjie', 'RCC', 'Vancouver', '(778) 807-1801', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Zherka, Edon', 'RCC', 'Vancouver', '(778) 788-0173', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vancouver Burk, Julie', 'RSW', 'Vancouver', '(778) 552-4684', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vanderhoof Ferguson, Nick', 'RCC', 'Northern', '(250) 570-1591', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Dalgleish, Holly', 'RSW', 'Interior', '(250) 938-7209', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Desjardins, Mirrell Dawn', 'CCC', 'Interior', '(250) 983-4489', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Genaille, Rennie', 'RSW', 'Interior', '(778) 475-4750', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Duquette, Gisele', 'RSW', 'Interior', '(250) 899-0171', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Enridge,Brent', 'RSW', 'Interior', '(250) 550-7172', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Noelle, Hellmut', 'CCC', 'Interior', '(250) 540-9471', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Bacchus, Natashia', 'RCC', 'Interior', '(250) 550-1811', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Casperson, Kerry', 'RCC', 'Interior', '(250) 309-6850', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Cebuliak, Maria', 'RCC', 'Interior', '(250) 549-6976', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Charlton, John', 'RCC', 'Interior', '(250) 307-1889', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Clingo, Mitch', 'RCC', 'Interior', '(250) 307-2030', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Cyr, Cara', 'RCC', 'Interior', '(236) 873-2079', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Desimone, Megan', 'RSW', 'Interior', '(250) 308-1262', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Fedy, Ross', 'RCC', 'Interior', '(250) 558-5726', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Forgo, Heidi', 'CCC', 'Interior', '(778) 212-9898', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Frankenberger, Sara', 'CCC', 'Interior', '(778) 801-6182', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Hanson, Kelli', 'RCC', 'Interior', '(250) 351-6487', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Hladik, Carolyn', 'RSW', 'Interior', '(250) 351-9961', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Hladik, Scott', 'RSW', 'Interior', '(250) 306-4128', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Johnson, Geoff', 'RSW', 'Interior', '(250) 308-7287', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Knight, Niki', 'RSW', 'Interior', '(250) 545-0103', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Krahn, Jodi', 'RCC', 'Interior', '(250) 307-6465', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Lanaway, Lisa', 'RCC', 'Interior', '(778) 932-1210', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Leer, Sandra', 'RCC', 'Interior', '(250) 788-5192', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Magner, Sara', 'RCC', 'Interior', '(250) 306-9283', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Donagh, Ciaran', 'RCC', 'Interior', '(250) 550-8596', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Pelletier, Elaine', 'RCC', 'Interior', '(250) 938-5971', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Pitino, Kimberly', 'RSW', 'Interior', '(250) 307-6628', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Plant, Zoe', 'CCC', 'Interior', '(250) 826-3164', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Ponto, Caitlyn', 'RCC', 'Interior', '(250) 253-3687', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Rezanson, Liz', 'RSW', 'Interior', '(250) 540-6769', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Richardson, Bonnie', 'RSW', 'Interior', '(250) 540-2910', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Ross, Bonnie', 'RCC', 'Interior', '(250) 558-8469', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Rossberg-Gempton, Irene', 'RCC', 'Interior', '(250) 542-9682', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Silke-Anderson, Erin', 'RCC', 'Interior', '(778) 692-0616', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Smith, Tara', 'RCC', 'Interior', '(250) 808-5144', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Soukeroff, Deon', 'RCC', 'Interior', '(250) 308-2101', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Thomas, Shannon', 'RSW', 'Interior', '(250) 870-2226', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Waldman, Grant', 'CCC', 'Interior', '(250) 896-0376', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Wenger, Kimberly', 'RCC', 'Interior', '(250) 308-6928', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Vernon Yadernuk, Stefanie', 'CCC', 'Interior', '(778) 943-2112', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Bihari, Joanne', 'Psychologist', 'Vancouver', '(250) 933-4884', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Sahara, Loren', 'RSW', 'Vancouver', '(778) 676-7844', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Kinyewakan, Nancy', 'RCC', 'Vancouver', '(250) 661-5552', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Moen, Kelly', 'RCC', 'Vancouver', '(778) 677-5873', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Roberts, Stephen', 'RCC', 'Vancouver', '(250) 370-0358', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Scott, Angela', 'RCC', 'Vancouver', '(250) 920-9576', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Khromova, Anastasia', 'RCC', 'Vancouver', '(778) 235-3151', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Ronaghan, Beckham', 'RSW', 'Vancouver', '(250) 884-8981', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Walker, Mattie', 'RCC', 'Vancouver', '(250) 217-9320', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Wilson, Sarah', 'RCC', 'Vancouver', '(778) 533-9117', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Connell, Ellen', 'RCC', 'Vancouver', '(250) 812-1568', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Lei Chen', 'RCC', 'Vancouver', '(250) 797-9735', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Mach, Phil', 'RSW', 'Vancouver', '(778) 557-3744', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Roxy Humphrey', 'RCC', 'Vancouver', '(604) 538-4420', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Talbot, Jeff', 'RCSW', 'Vancouver', '(250) 961-1927', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Taylor,Elana', 'RCC', 'Vancouver', '(250) 419-2366', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Adams, Cheryl', 'RCC', 'Vancouver', '(250) 818-3763', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Alevizakis, Christine', 'CCC', 'Vancouver', '(416) 835-7628', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Alexander, Nicole', 'CCC', 'Vancouver', '(250) 818-9817', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Allen, Brandi', 'RCC', 'Vancouver', '(778) 678-0709', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Allen-Neman, Jordie', 'RCC', 'Vancouver', '(250) 588-0275', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Anderson, Carmen', 'RCC', 'Vancouver', '(778) 966-4700', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Barnard, Niall', 'RSW', 'Vancouver', '(778) 678-2293', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Bentley-Taylor, Brenden', 'RCC', 'Vancouver', '(250) 389-2819', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Boden, Alan', 'RCC', 'Vancouver', '(250) 686-9912', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Breault, Brigitte', 'Psychologist', 'Vancouver', '(250) 208-1470', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Button, Sebastien', 'CCC', 'Vancouver', '(250) 381-6367', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Cameron, Scott', 'RCC', 'Vancouver', '(250) 558-6710', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Caplan, Alan', 'CCC', 'Vancouver', '(250) 753-3706', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Carlson , Adrienne', 'RSW', 'Vancouver', '(250) 580-5752', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Causton, Sarah', 'RSW', 'Vancouver', '(250) 812-6026', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Chadwick, Anna', 'RCC', 'Vancouver', '(250) 389-2819', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Cook, Daniel', 'RCC', 'Vancouver', '(250) 508-2223', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Corman, Susan', 'RSW', 'Vancouver', '(250) 744-8428', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Cottell, Sylvie', 'RCC', 'Vancouver', '(250) 508-1042', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Creighton, Caroline', 'RCC', 'Vancouver', '(778) 677-5099', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Crichton, Joel', 'CCC', 'Vancouver', '(780) 934-9646', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Dach, Victoria', 'RCC', 'Vancouver', '(778) 352-3121', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Dalley, Jordan', 'RCC', 'Vancouver', '(250) 880-3488', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Davies, Gwendolyn', 'RCC', 'Vancouver', '(250) 385-7410', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Davoren, Jill', 'RCSW', 'Vancouver', '(250) 415-7575', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Delroy, Sarah', 'RCC', 'Vancouver', '(250) 885-0275', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Doidge-Sidhu, Heather', 'CCC', 'Vancouver', '(778) 288-7082', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Doyle, Sarah', 'RSW', 'Vancouver', '(905) 875-6632', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Duarte, Linda', 'RCC', 'Vancouver', '(250) 370-5525', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Durkovic, Joel', 'RCC', 'Vancouver', '(250) 479-9912', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Eisenhauer, Carmen', 'RCC', 'Vancouver', '(250) 857-8069', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Ens, Flori', 'RCC', 'Vancouver', '(778) 977-2308', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Evans, Julie', 'RCC', 'Vancouver', '(778) 922-0635', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Farley, Erin', 'RCC', 'Vancouver', '(250) 483-6220', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Farr, Susan', 'RCC', 'Vancouver', '(250) 381-6367', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Ford, Eugene', 'RCC', 'Vancouver', '(250) 661-3864', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Frizelle, Sarah', 'RCC', 'Vancouver', '(250) 812-2903', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Gay, Michelle', 'CCC', 'Vancouver', '(250) 412-5921', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Gilchrist , Elise', 'RCC', 'Vancouver', '(778) 553-1166', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Gillett, Joy', 'RCC', 'Vancouver', '(250) 479-9912', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Graham, Ariel', 'RCC', 'Vancouver', '(250) 598-0544', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Green, Paula', 'RCC', 'Vancouver', '(250) 813-3256', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Hahn, Pearce', 'CCC', 'Vancouver', '(250) 381-6367', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Hanson, Vanya', 'CCC', 'Vancouver', '(250) 389-2819', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Harber, Madelaine', 'RSW', 'Vancouver', '(250) 668-4330', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Hart, Inka', 'RCC', 'Vancouver', '(778) 350-4652', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Harte-Osberg, Ciara', 'RCC', 'Vancouver', '(778) 765-0775', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Hartwick, Lisa', 'RCC', 'Vancouver', '(778) 870-7233', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Harvey, Irvine', 'RCC', 'Vancouver', '(250) 419-4802', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Hayashi, John', 'RCC', 'Vancouver', '(250) 818-1228', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Henry, Venetta', 'RCC', 'Vancouver', '(250) 896-4226', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Hermoso, Carmelle', 'RCC', 'Vancouver', '(250) 896-0961', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Hiebert, Myrna', 'Psychologist', 'Vancouver', '(250) 999-2182', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Jaunzems, Allison', 'RCC', 'Vancouver', '(250) 813-1917', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Jenkinson, Sarah', 'RCC', 'Vancouver', '(250) 881-3583', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Kapil, Meg', 'CCC', 'Vancouver', '(250) 858-5353', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Kauffman, Theresa', 'RCC', 'Vancouver', '(250) 588-1078', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Kaur, Ruby-Mandeep', 'RCC', 'Vancouver', '(647) 765-0328', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Kelm, Joanna', 'Psychologist', 'Vancouver', '(250) 580-0909', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Kerr, Judith', 'RCC', 'Vancouver', '(250) 208-1187', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Kinloch, Frances', 'RCC', 'Vancouver', '(250) 558-7793', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Kirby, Carli', 'RCC', 'Vancouver', '(250) 704-4427', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Koechling, Ulrike', 'Psychologist', 'Vancouver', '(250) 213-2331', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Kouri, Scott', 'RCC', 'Vancouver', '(778) 584-0583', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Kroeker, Joel', 'RCC', 'Vancouver', '(250) 884-3812', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Lampard, Tyler', 'RCC', 'Vancouver', '(778) 700-4357', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Laporte, Vanya', 'RCC', 'Vancouver', '(250) 530-9898', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Law, Hanna', 'RSW', 'Vancouver', '(778) 676-5287', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Liberatore, Tasha', 'RCC', 'Vancouver', '(250) 370-0358', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Lowey, Eileen', 'RCC', 'Vancouver', '(250) 590-7050', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Kay, Laurel', 'CCC', 'Vancouver', '(778) 535-5338', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lennan, Jacqueline', 'RSW', 'Vancouver', '(250) 208-2008', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Macleod, Fiona', 'RSW', 'Vancouver', '(250) 812-4192', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Marrion, Leslie', 'Psychologist', 'Vancouver', '(250) 477-8326', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Bride, Hillary', 'Psychologist', 'Vancouver', '(604) 833-4574', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Mcknight, Baylie', 'RSW', 'Vancouver', '(250) 986-2673', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Mcloughlin St Amour, Cheryl', 'CCC', 'Vancouver', '(250) 842-3039', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Luskie, Carolyn', 'RCC', 'Vancouver', '(250) 634-3861', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Meikle, Jennifer', 'RCC', 'Vancouver', '(250) 661-6163', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Miciano, Mary Trisha', 'CCC', 'Vancouver', '(250) 475-1522', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Mickelson, Alice', 'RSW', 'Vancouver', '(250) 389-2819', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Mitchell, Lisa', 'RCC', 'Vancouver', '(778) 700-1283', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Moniz, Laurie', 'RCC', 'Vancouver', '(250) 532-7891', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Monkhouse, Bruce', 'Psychologist', 'Vancouver', '(250) 721-4929', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Morelle, Elizabeth', 'RCC', 'Vancouver', '(250) 210-1496', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Morrison, Joanna', 'RCC', 'Vancouver', '(250) 816-4716', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Moser, Kathy', 'RCSW', 'Vancouver', '(250) 727-9273', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Moslehi, Massoud', 'CCC', 'Vancouver', '(250) 532-1341', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Munro, Jennifer', 'RSW', 'Vancouver', '(250) 514-6097', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Murdock, Marilyn', 'RCC', 'Vancouver', '(250) 216-6771', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Nasmyth, Patricia', 'RCC', 'Vancouver', '(250) 360-7714', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Niesluchowska, Patrycja', 'CCC', 'Vancouver', '(604) 716-5784', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Oakes, Michael', 'RCC', 'Vancouver', '(250) 319-3660', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Pagan , Flora', 'RSW', 'Vancouver', '(250) 381-3679', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Pagan, Flora', 'RSW', 'Vancouver', '(250) 507-3124', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Parker, Jill', 'RSW', 'Vancouver', '(250) 818-9194', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Piche, Indrus', 'RCC', 'Vancouver', '(250) 888-2599', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Plewa , Sonia', 'RCC', 'Vancouver', '(778) 927-1219', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Pybus, Kathryn', 'RCC', 'Vancouver', '(604) 220-0350', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Radford, Sara', 'RCC', 'Vancouver', '(250) 418-0478', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Rambold, Jody', 'RCC', 'Vancouver', '(250) 217-5597', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Read, Linette', 'RCC', 'Vancouver', '(778) 535-4063', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Reilly, John', 'RSW', 'Vancouver', '(250) 386-0667', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Rice, Alan', 'RCC', 'Vancouver', '(250) 884-9657', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Richardson, Pamela', 'RCC', 'Vancouver', '(778) 922-3292', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Riendeau, Daniele', 'RCC', 'Vancouver', '(250) 589-4408', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Russell, Simon', 'RCC', 'Vancouver', '(250) 381-6367', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Santiago, Charis', 'RCC', 'Vancouver', '(778) 678-5570', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Sather, Dawn', 'RSW', 'Vancouver', '(250) 880-6230', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Scheunhage, John', 'RCC', 'Vancouver', '(250) 580-2150', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Schmalz, Mike', 'CCC', 'Vancouver', '(778) 677-6453', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Scott, Sean', 'RCC', 'Vancouver', '(250) 880-0473', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Segal, David', 'RCC', 'Vancouver', '(250) 588-7214', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Shortt, Jennifer', 'RCC', 'Vancouver', '(250) 514-2694', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Siebert, Melanie', 'RSW', 'Vancouver', '(250) 598-0581', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Simoncicova, Lucia', 'RCC', 'Vancouver', '(778) 231-9009', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Simone, Duff', 'RCC', 'Vancouver', '(778) 819-2488', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Simpson, Lorri', 'RCSW', 'Vancouver', '(250) 212-6775', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Smith, Caron', 'RSW', 'Vancouver', '(250) 885-1610', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Smith, Trudi', 'RCC', 'Vancouver', '(236) 638-1038', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Spencer, Michele', 'CCC', 'Vancouver', '(250) 634-4375', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Stassen , Michelle', 'RSW', 'Vancouver', '(416) 737-0775', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Stevenson, Renae Marlaine', 'RCC', 'Vancouver', '(778) 809-6094', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Stocks, Mary', 'RSW', 'Vancouver', '(250) 385-7410', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Stone , Kendra', 'RCC', 'Vancouver', '(250) 886-1400', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Stretch, Beverly', 'CCC', 'Vancouver', '(250) 715-7437', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Taylor, Lucinda', 'RCSW', 'Vancouver', '(778) 676-9207', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Taylor, Roderick', 'RCSW', 'Vancouver', '(250) 896-4482', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Teahen, Corinne', 'RSW', 'Vancouver', '(250) 885-9644', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Tiplady, Oona', 'Psychologist', 'Vancouver', '(226) 268-2259', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Toba, Cerasela', 'RCC', 'Vancouver', '(250) 385-7410', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Toba , Cerasela', 'RCC', 'Vancouver', '(778) 268-1408', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Tompkins, Diane', 'RCC', 'Vancouver', '(250) 507-0528', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Turner, Cheryl', 'RSW', 'Vancouver', '(858) 361-2021', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Van Bruggen, Lisa', 'Psychologist', 'Vancouver', '(250) 580-0909', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Van Den Bussche, Gill', 'CCC', 'Vancouver', '(250) 381-6367', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Van Der Boom-Bebb, Bernadette', 'RCC', 'Vancouver', '(250) 590-8344', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Van Spronsen, Shari', 'RCC', 'Vancouver', '(778) 808-8262', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Williams, Geoff', 'RCSW', 'Vancouver', '(250) 418-8500', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Victoria Winship, Katy', 'RCC', 'Vancouver', '(250) 885-0275', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('West Kelowna Beckner, Courtney', 'RSW', 'Interior', '(250) 718-9291', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('West Kelowna Christie, Jane', 'CCC', 'Interior', '(250) 718-9291', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('West Kelowna Ferch, Christine', 'RCC', 'Interior', '(778) 994-8165', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('West Kelowna Hanson, David', 'RCC', 'Interior', '(250) 717-7104', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('West Kelowna Mortimer, Richard', 'CCC', 'Interior', '(250) 878-3413', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('West Kelowna Moseley, Teresa', 'RCC', 'Interior', '(236) 795-2607', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('West Kelowna Renaud, Danielle', 'RCC', 'Interior', '(250) 731-5472', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('West Kelowna Turner, Gaylene', 'RCC', 'Interior', '(250) 858-4039', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('West Kelowna Nasseri, Yeganeh', 'RCC', 'Vancouver', '(778) 805-9892', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('West Vancouver Bodnarchuk, Mark', 'Psychologist', 'Vancouver', '(778) 839-8292', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('West Vancouver Giustra, Marianne', 'RCC', 'Vancouver', '(778) 805-6653', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Gregor, Barbara', 'RCC', 'Vancouver', '(778) 227-3931', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('West Vancouver Merasty, Angela', 'RSW', 'Vancouver', '(604) 369-5924', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('West Vancouver Poregbal, Poran', 'RCC', 'Vancouver', '(778) 883-0591', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('West Vancouver Rochard, Jolie', 'RCC', 'Vancouver', '(778) 869-2114', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('West Vancouver Wilson, Robert', 'Psychologist', 'Vancouver', '(604) 831-7792', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('West Vancouver Syrette, Chantelle', 'RCC', 'Vancouver', '(705) 257-1668', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Westbank Goodwill Ferguson, Alanaise', 'Psychologist', 'Fraser', '(604) 316-1976', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Whistler Hall, Natalie', 'RCSW', 'Vancouver', '(604) 907-5104', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Donnell, Greg', 'RCC', 'Vancouver', '(604) 935-0968', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Whistler Suter, Christine', 'RCC', 'Vancouver', '(604) 932-0788', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('White Rock Elchehimi, Amanee', 'RCC', 'Fraser', '(604) 366-6700', FALSE, 'Unknown');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('White Rock Farah, Lana', 'RCC', 'Fraser', '(647) 637-8765', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('White Rock Larmour, Maxine', 'RCC', 'Fraser', '(604) 803-3637', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Lean, Spencer', 'RCC', 'Fraser', '(778) 580-8344', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('White Rock Nardella, Elizabeth', 'RSW', 'Fraser', '(778) 512-7300', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('White Rock Powers, Heather', 'RSW', 'Fraser', '(519) 573-9518', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('White Rock Ray, Janine', 'RCC', 'Fraser', '(778) 928-0741', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('White Rock Shah, Aroon', 'RCC', 'Fraser', '(604) 671-3584', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Williams Lake Hird, Harriet', 'RCC', 'Interior', '(250) 267-1693', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Williams Lake Hanson, Jennifer', 'RCC', 'Interior', '(604) 866-6585', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Williams Lake Kaur, Parminder', 'RCC', 'Interior', '(250) 706-9454', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Williams Lake Macklin, Toby', 'RCC', 'Interior', '(250) 247-7554', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Ginnis, William', 'RCC', 'Interior', '(250) 267-3034', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Williams Lake Rogers-Calabrese, Kendra', 'RCC', 'Interior', '(250) 398-6378', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Williams Lake Stahl , Sheri', 'RCC', 'Interior', '(778) 267-4141', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Youbou Leischner, Christine', 'RSW', 'Vancouver', '(250) 710-3624', FALSE, 'Accepting new clients');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Larson, Jenn', 'RCC', 'Interior', '(778) 977-5366', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Romano - Inglis , Soroya', 'RCC', 'Vancouver', '(604) 928-4588', FALSE, 'Waitlist');
INSERT INTO fnha_mental_health_providers (name, designation, region, phone, virtual_care, availability) VALUES ('Sweetgrass, Magdalena', 'RSW', 'Vancouver', '(604) 360-6530', FALSE, 'Accepting new clients');

-- ============================================
-- INDIGENOUS RESOURCES (229 records)
-- ============================================

DROP TABLE IF EXISTS indigenous_resources CASCADE;
CREATE TABLE indigenous_resources (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    region VARCHAR(50),
    location VARCHAR(255),
    phone VARCHAR(50),
    email VARCHAR(255),
    website TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Penticton BC Ooknakane Friendship Centre', 'Interior', 'Penticton', '250-490-3504', 'balance@friendshipcentre.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Penticton Aboriginal Friendship Centre Society Location', 'Interior', 'Penticton', '250-490-3504', 'balance@friendshipcentre.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Ooknakane Friendship Centre front desk', 'Interior', NULL, '250-493-6822', NULL, 'http://accesscentre.org/services/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Vancouver Aboriginal Friendship Centre Society', 'Vancouver Coastal', NULL, '604-251-4844', 'info@vafcs.org', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Page Additional programs at Vancouver Aboriginal Friendship Centre Society', 'Vancouver Coastal', '520 Richards Street Vancouver', '604-251-4844', 'info@vafcs.org', 'www.vafcs.org');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Tillicum Lelum Aboriginal Friendship Centre', 'Vancouver Island', 'Lantzville, Vancouver Island', '250-746-0183', NULL, 'http://www.csets.com/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Nation and the Victoria Native Friendship Centre', 'Vancouver Island', 'Lantzville, Vancouver Island', '250-746-0183', NULL, 'http://www.csets.com/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Within a network of Friendship Centres across Canada', 'Vancouver Island', NULL, '250-753-4417', NULL, 'http://www.tillicumlelum.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Dawson Creek BC Nawican Friendship Centre', 'Northern', 'Dawson Creek', '250-782-5202', 'nfced@nawican.ca', 'https://www.facebook.com/pages/category/Community/Nawican-Friendship-');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Friendship Centre is a hub for community connection', 'Northern', 'Dawson Creek', '250-782-5202', 'nfced@nawican.ca', 'https://www.facebook.com/pages/category/Community/Nawican-Friendship-');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Prince George Native Friendship Centre', 'Northern', NULL, '250-562-2538', 'kjames@pgnfc.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Prince George Prince George Native Friendship Centre Emergency Resource Program', 'Northern', NULL, '250-564-3568', 'efaulkner@pgnfc.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Ki-Low-Na Friendship Society', 'Interior', NULL, '236-420-2992', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Cariboo Friendship Society expanded its mandate into permanent residential housing in', 'Interior', NULL, '250-398-6831', 'admin@cfswl.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('John Friendship Society Location', 'Northern', 'Fort St. John', '250-785-8566', NULL, 'https://www.facebook.com/Fort-St-John-Friendship-Center-220929864594344/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Alcohol and Drug Treatment Centre', 'Interior', NULL, '250-546-8848', 'intake@roundlake.bc.ca', 'http://roundlaketreatmentcentre.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Indigenous Treatment Centres require six completed appointments before we can put in a referral', 'Vancouver Island', NULL, '250-384-3211', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Kamloops Urban Aboriginal Health Centre', 'Interior', NULL, '250-376-1991', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Vancouver BC Raven Song Community Health Centre Location', 'Vancouver Coastal', 'Vancouver', '604-709-6400', NULL, 'http://www.vch.ca/locations-services/result');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Raven Song Community Health Centre offers a range of health care services for people of all ages', 'Vancouver Coastal', 'Vancouver Downtown Eastside', '604-709-6400', NULL, 'http://www.vch.ca/locations-services/result');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Williams Lake BC Three Corners Health Services Society Description', 'Interior', NULL, '250-398-9814', NULL, 'http://threecornershealth.org/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Kamloops Native Housing Society Location', 'Interior', 'Kamloops', '250-374-1728', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Kamloops Native Housing Society manages', 'Interior', 'Kamloops', '250-374-1728', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Page Vernon Native Housing Society Location', 'Interior', 'Vernon', '250-542-2834', 'reception@vernonnativehousing.ca', 'http://www.vernonnativehousing.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Vernon Native Housing Society', 'Interior', NULL, '250-542-2834', 'reception@vernonnativehousing.ca', 'http://www.vernonnativehousing.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Qweesome Housing Society manages', 'Fraser', NULL, '604-820-3324', 'reception@mqhs.ca', 'http://www.mqhs.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Native Housing Society at least fifty percent', 'Vancouver Coastal', NULL, '604-876-0811', NULL, 'http://lnhs.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Native Housing Society is proud to present Community Voice Mail in Canada', 'Vancouver Coastal', 'Vancouver', '604-876-0811', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Dawson Creek BC Dawson Creek Native Housing Society Location', 'Northern', 'Dawson Creek', '250-782-1598', 'dcnhs.office@telus.net', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Dawson Creek Native Housing Society provides', 'Northern', 'Dease Lake (Sub Office) and Telegraph Creek (Main Office)', '250-782-1598', 'dcnhs.office@telus.net', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('John Native Housing Society Location', 'Northern', 'Fort St. John', NULL, 'acowger@pris.bc.ca', 'http://treaty8.bc.ca/housing-2/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('John Native Housing Society is a program that provides Aboriginal families with housing needs', 'Northern', NULL, '250-785-4900', 'acowger@pris.bc.ca', 'http://treaty8.bc.ca/housing-2/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Aboriginal Housing Society of Prince George', 'Northern', NULL, '250-564-9794', 'info@ahspg.ca', 'http://ahspg.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Nicola Valley Aboriginal Community Justice Program and The Nicola Valley Indigenous Court Program', 'Interior', 'Merritt', '250-378-9632', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Tsilhqot''in Community Justice Program serves the Tsilqhot''in and Southern Carrier Nations', 'Interior', NULL, '778-412-9536', 'executivedirector@punkylake.com', 'www.punkylake.com/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Haida Gwaii Restorative Justice Program provides community justice services for all of Haida Gwaii', 'Northern', 'New Aiyansh / Nisga''a Lisims Government', '250-639-5781', 'success@haidanation.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Indigenous Justice Program can be made by the Community', 'Northern', NULL, '250-648-3212', 'ron.winser@tlazten.bc.ca', 'http://tlaztennation.ca/justice/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Williams Lake Community Council for Restorative Justice', 'Interior', 'Esk’etemc / Alkali Lake', '778-267-8283', 'justice@esketemc.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Lytton Restorative Justice', 'Interior', NULL, '250-455-0477', 'p.munro@lfn.band', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Indigenous Justice Worker & Restorative Justice Coordinator Phone', 'Vancouver Island', 'Victoria', '778-426-2997', 'vanessaramsdale@siws.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Wilp-based Restorative Justice & Peacemaking Circles', 'Northern', NULL, '250-633-3070', 'faitht@nisgaa.net', 'https://www.nisgaanation.ca/services-0');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Native Courtworker Cell', 'Interior', 'Cranbrook', '250-420-7137', 'claroche@nccabc.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Native Courtworker Phone', 'Interior', 'Penticton', '877-811-1190', 'wpooler@nccabc.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Native Courtworkers Phone', 'Fraser', 'Many offices are located in Surrey however please note that FRAFCA offices and', '604-985-5355', 'd.louie@nccabc.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Native Courtworkers and Counselling Association of BC', 'Vancouver Coastal', 'Bella Cool', '250-957-2213', 'mary.brown@heiltsuk.ca', 'http://www.heiltsuknation.ca/departments/justice-department/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Native Courtworker Toll-free', 'Vancouver Coastal', NULL, '855-221-6152', '222main-street@nccabc.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Youth Native Courtworker', 'Vancouver Coastal', 'Vancouver', '604-985-5355', 'fraynes@nccabc.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Clients who are in conflict with the law are connect individuals with our Native Courtworkers', 'Vancouver Coastal', NULL, '604-628-1143', NULL, 'https://nccabc.ca/health/aboriginal-detox-support-workers-program/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Native Courtworker', 'Vancouver Island', 'Courtenay', '855-221-1180', 'amilwid@nccabc.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Native Courtworker Email', 'Vancouver Island', 'Courtenay', '855-221-1180', 'gcolclough@nccabc.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Native Courtworker and Counselling Association of BC', 'Vancouver Island', 'Victoria', '778-426-2997', 'vanessaramsdale@siws.ca', 'http://www.siws.ca/siws-services-restorative-justice.html');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Native Courtworkers Toll free', 'Northern', 'Terrace', '877-811-1190', 'ltaylor@nccabc.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Native Courtworker & Counselling Association of BC', 'Northern', NULL, '250-648-3212', 'ron.winser@tlazten.bc.ca', 'http://tlaztennation.ca/justice/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Kamloops BC Legal Services Society', 'Interior', 'Kamloops', '250-374-1728', NULL, 'https://aboriginal.legalaid.bc.ca/courts-criminal-cases/first-nations-court');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Youth Criminal Justice - Aboriginal Criminal Justice - General Criminal Law Legal Services Society', 'Northern', NULL, '877-842-5218', 'Sandra.Hazelton@lss.bc.ca', 'http://www.usclas.com/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Legal Services Society', 'Northern', NULL, '604-408-2172', NULL, 'https://aboriginal.legalaid.bc.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Parents Legal Centre Legal Services Society of B', 'Northern', NULL, '866-577-2525', NULL, 'https://familylaw.lss.bc.ca/visit/parents-legal-centre');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Anderson Lodge Healing Centre for Women also accepts self-referrals', 'Vancouver Coastal', NULL, '604-874-1246', NULL, 'https://circleofeagles.com/anderson-lodge/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Gya'' Wa'' Tlaab Healing Centre offers this Early Recovery', 'Northern', 'Kitwanga, located between Hazelton and Terrace (Land-based)', '250-639-9817', 'intake@gyawatlaab.ca', 'https://www.gyawatlaab.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Kelowna Mental Health Program', 'Interior', NULL, '250-763-4905', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Programs & Services Mental Health and Addictions Program', 'Interior', NULL, '250-490-3504', 'balance@friendshipcentre.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Family Outreach and Community Youth Mental Health', 'Interior', NULL, '250-490-3504', 'reception@friendshipcentre.ca', 'https://www.friendshipcentre.ca/services/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Aboriginal Addictions and Mental Health Outreach', 'Interior', NULL, '250-398-6831', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Aboriginal Child and Youth Mental Health Program', 'Interior', NULL, '250-267-2377', NULL, 'http://cariboofriendshipsociety.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Mental Health Liaison is available to all people', 'Vancouver Island', NULL, '250-384-3211', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Programs & Services Mental Health & Addictions Counsellor', 'Northern', NULL, '250-788-2996', 'addictions@tansifcs.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Mental Health Clinician provides service to individuals with mental health concerns', 'Northern', NULL, '250-992-8347', 'adele.lilienweiss@qnfc.bc.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('QUESST and Quesnel Mental Health and Addictions', 'Northern', NULL, '250-992-8347', 'lynn.peterson@qnfc.bc.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Youth Program generally receives four intakes per year', 'Interior', NULL, '250-989-0301', 'sbusch@nenqayni.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('MCFD Youth Program Referral Form', 'Vancouver Coastal', 'Vancouver', '604-868-0632', 'mentorship@unya.bc.ca', 'https://unya.bc.ca/programs/mentorship-program/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('My Way Youth Program Contact', 'Northern', NULL, '250-564-3568', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('ATEC - Aboriginal Training & Employment Centre', 'Interior', NULL, '250-453-0093', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Student Employment Placement', 'Fraser', 'Mission', '604-858-3691', 'info@saset.ca', 'www.saset.ca');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('MIBEmploymentandTraining', 'Vancouver Coastal', 'Tsleil-Waututh Nation, North Vancouver', '604-269-3461', 'employassist@musqueam.bc.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('SNEmploymentTraining', 'Vancouver Coastal', 'Powell River & Tla''amin Nation (formerly Sliammon First Nation)', '604-985-7711', 'lacey_baker@squamish.net', 'https://www.squamish.net/government/departments/service-delivery/employment-');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Programs & Services Employment Assistance', 'Vancouver Coastal', NULL, '604-251-7955', NULL, 'http://eas.accessfutures.com/contact/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('ACCESS has four Employment Assistance Service offices located across Metro Vancouver', 'Vancouver Coastal', NULL, '604-251-7955', NULL, 'http://eas.accessfutures.com/contact/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('ACCESS Employment Assistance Service offices include', 'Vancouver Coastal', NULL, '604-251-7955', NULL, 'http://eas.accessfutures.com/contact/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Career and Employment Training Program', 'Vancouver Island', NULL, '250-753-4417', NULL, 'http://www.tillicumlelum.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Steps to Success Training for Employment', 'Vancouver Island', NULL, '250-723-8281', NULL, 'https://pafriendshipcenter.com/welcome-port-alberni-friendship-center');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Indigenous Model for Delivering Employment and Economic Success', 'Vancouver Island', NULL, '250-384-3211', NULL, 'http://www.vnfc.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Page Employment Assistance', 'Northern', NULL, '250-788-2996', 'employment@tansifcs.com', 'https://tansifcs.com/tansi/Home');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Training to Employment Coordinator', 'Northern', 'Daws', '250-788-2996', 'employment@tansifcs.com', 'https://tansifcs.com/tansi/Home');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Training to Employment Coordinator Phone', 'Northern', 'Dawson Creek / Peace River Country (Land-based)', '250-788-2996', 'employment@tansifcs.com', 'https://tansifcs.com/tansi/Home');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Training and Employment Outreach', 'Northern', 'Fort St. John', '250-785-8566', NULL, 'https://www.facebook.com/Fort-St-John-Friendship-Center-220929864594344/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Housing - Employment Standards - Human Rights - Complaints to the Ombudsman - I', 'Northern', 'Haisla (near Kitimat)', '877-842-5218', 'Sandra.Hazelton@lss.bc.ca', 'http://www.usclas.com/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Pathways Pre- Employment Training', 'Northern', NULL, '844-633-2210', 'info@nisgaaworks.ca', 'http://nisgaaworks.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Prince George Nechako Aboriginal Employment and Training Association and Prince George M', 'Northern', NULL, '250-564-3568', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Nation British Columbia Employment & Training', 'Northern', NULL, '250-564-3568', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Cariboo Chilcotin Aboriginal Training Employment Centre Society', 'Northern', NULL, '250-992-8347', 'karima.beaucage@qnfc.bc.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Our Employment Coordinator provides supportive assistance to new clients', 'Northern', NULL, '250-992-8347', 'karima.beaucage@qnfc.bc.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Centre of Employment', 'Northern', 'Vanderhoof (office), Land-based (Ormond Lake / Nadleh Whut’en territory), Northe', '250-847-5211', 'info@dzelkant.com', 'http://www.dzelkant.com/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Financial Support & Current Training Programs', 'Interior', 'Cranbrook & Aq’am (ʔaq''am) Community (formerly Saint Mary’s Indian Band)', '250-417-3305', 'sdesjarlais@mnbc.ca', 'https://www.mnbc.ca/directory/view/342-ministry-of-employment-training');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Current Training Programs', 'Interior', NULL, '250-769-1977', 'karen@otdc.org', 'www.otdc.org');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Employment and Training', 'Interior', 'Vernon', '250-542-1247', 'info@fnfc.ca', 'https://www.vernonfirstnationsfriendshipcentre.com/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Education & Training', 'Fraser', NULL, '604-858-3691', 'info@saset.ca', 'www.saset.ca');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Current Training Programs & Service Area', 'Vancouver Coastal', 'Tsleil-Waututh Nation, North Vancouver', '604-269-3461', 'employassist@musqueam.bc.ca', 'https://www.musqueam.bc.ca/departments/community-services/employment-and-');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Employment and Training Administrative Assistant Phone', 'Vancouver Coastal', 'Tsleil-Waututh Nation, North Vancouver', '604-269-3461', 'employassist@musqueam.bc.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Life-skills Training Program', 'Vancouver Coastal', 'Vancouver', '604-874-6629', 'reception@hsls.ca', 'https://hsls.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Industry Training Authority', 'Vancouver Coastal', 'Vancouver', '604-696-9026', 'info@have-cafe.ca', 'https://www.have-cafe.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('ACCESS Trades works closely with the Industry Training Authority', 'Vancouver Coastal', NULL, '604-922-4077', NULL, 'http://accesstrades.accessfutures.com/contact/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Employment and Training Competency', 'Vancouver Coastal', NULL, '604-922-4077', NULL, 'http://accesstrades.accessfutures.com/contact/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Employment and Training Services', 'Vancouver Island', NULL, '250-748-2242', 'ArleneSam@hofduncan.org', 'https://www.hofduncan.org/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Group Training', 'Northern', NULL, '844-633-2210', 'info@nisgaaworks.ca', 'http://nisgaaworks.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Workplace Training', 'Northern', NULL, '844-633-2210', 'info@nisgaaworks.ca', 'http://nisgaaworks.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Trades Training', 'Northern', NULL, '844-633-2210', 'info@nisgaaworks.ca', 'http://nisgaaworks.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Workplace Essential Skills Trades Training', 'Northern', NULL, '250-624-3535', 'tmazurek@tricorp.ca', 'www.tricorp.ca');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Kelowna Addictions Counselling', 'Interior', NULL, '250-859-1025', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Our Addictions Services Program provides various options to the Lillooet Community', 'Interior', NULL, '250-256-4146', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Mental Health and Addictions Phone', 'Interior', NULL, '250-490-3504', 'balance@friendshipcentre.ca', 'http://acc');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Mental Health and Addictions Program', 'Interior', 'Vernon', '250-542-1247', 'info@fnfc.ca', 'https://www.vernonfirstnationsfriendshipcentre.com/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('First Response Youth Addictions Outreach Program', 'Fraser', NULL, '604-595-1170', 'kyla.bains@frafca.org', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Page Programs & Services Addictions Program', 'Vancouver Island', NULL, '250-748-2242', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Mental Health & Addictions Counsellor Phone', 'Vancouver Island', NULL, '250-723-8281', 'bgibson@pafriendshipcenter.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Youth Support Workers and Youth Addictions Worker', 'Vancouver Island', NULL, '250-384-3211', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Mental Health & Addictions Counsellor Email', 'Northern', NULL, '250-788-2996', 'addictions@tansifcs.com', 'https://tansifcs.com/tansi/Home');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Mental Health and Addictions Counsellor', 'Northern', 'Dawson Creek', '250-782-5202', 'nfced@nawican.ca', 'https://www.facebook.com/pages/category/Community/Nawican-Friendship-');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Mental Health and Addictions', 'Northern', 'Fort St. John', '250-785-8566', NULL, 'https://www.facebook.com/Fort-St-John-Friendship-Center-220929864594344/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Page Connection to Health and Wellness Resources', 'Interior', 'Lillooet', '250-256-7393', 'statimcrj@gmail.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Vernon BC Williams Lake Nenqayni Wellness Centre First Nations Health Authority', 'Interior', 'Williams Lake (we are located on the Soda Creek Reserve 21 kilometers north of', '250-989-0301', 'jevans@nenqayni.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('All referrals to Nenqayni Wellness Centre', 'Interior', 'Williams Lake', '250-989-0301', NULL, 'https://nenqayni.com/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Aboriginal Child and Youth Wellness team will work with', 'Interior', NULL, '250-267-2377', 'admin@cfswl.ca', 'http://cariboofriendshipsociety.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Family Wellness Program', 'Interior', 'Williams Lake / Kamloops', '250-392-6500', NULL, 'http://www.denisiqi.org/Programs.aspx');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Indigenous Health and Wellness Clinic', 'Fraser', 'A101-10095 Whalley Blvd, Surrey and 100-10233 153 Street, Surrey', '604-283-3293', 'IPHWH@fraserhealth.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Health and Wellness Promotion', 'Fraser', 'Surrey', '604-595-1170', 'reception@frafca.org', 'www.frafca.or');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('At the Native Youth Health and Wellness Centre', 'Vancouver Coastal', NULL, '604-253-5885', 'nativeyouthwellness@unya.bc.ca', 'https://unya.bc.ca/programs/native-youth-health-wellness-centre/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Men''s Wellness Program', 'Vancouver Island', NULL, '250-753-8291', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Health and Wellness Worker', 'Vancouver Island', NULL, '250-902-0552', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Aboriginal Child & Youth Wellness Program', 'Northern', NULL, '250-564-3568', 'info@pgnfc.com', 'http://www.pgnfc.com/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Mental Wellness Clinician Phone', 'Northern', NULL, '250-992-8347', 'adele.lilienweiss@qnfc.bc.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Gladue Writers Society at info', 'Unknown', NULL, NULL, 'info@gladuesociety.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Families are also required to be willing to work with MCFD and the Ki-Low-Na Friendship Society', 'Interior', 'Kelown', '250-859-1060', 'reception@kfs.bc.ca', 'http://www.kfs.bc.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Society operates three programs', 'Interior', 'Merritt', '250-378-9632', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Law Advocate is provided through the Penticton Access Centre Society', 'Interior', NULL, '250-490-3504', NULL, 'http://accesscentre.org/services/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('In partnership with Pacific Community Resources Society', 'Fraser', NULL, '604-595-1170', 'kyla.bains@frafca.org', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Vancouver Aboriginal Transformative Justice Service Society', 'Vancouver Coastal', NULL, '604-251-7200', 'administration@vatjss.com', 'http://vatjss.com/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Helping Spirit Lodge Society', 'Vancouver Coastal', NULL, '604-251-4844', 'programdirector1@vafcs.org', 'www.vafcs.org');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('VancouverAboriginalFriendshipCentreSociety', 'Vancouver Coastal', '520 Richards Street Vancouver', '604-251-4844', 'info@vafcs.org', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Aboriginal Mother Centre Society Transformational Housing Program offers', 'Vancouver Coastal', 'Vancouver', '604-558-2627', 'info@aboriginalmothercentre.ca', 'http://www.aboriginalmothercentre.ca/home.html');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Vancouver BC Circle of Eagles Lodge Society', 'Vancouver Coastal', 'Vancouver', '604-428-7963', 'admin@circleofeagles.com', 'http://circleofeagles.com/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Aboriginal Front Door Society is a culturally safe', 'Vancouver Coastal', NULL, '604-697-5662', 'info@abfrontdoor.com', 'http://www.abfrontdoor.com/home');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('See the Pacific Community Resources Society website', 'Vancouver Coastal', 'Vancouver', '604-709-5720', NULL, 'https://pcrs.ca/service-types/housing/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Warriors-Against-Violence-Society-', 'Vancouver Coastal', 'Vancouver Downtown Eastside', '604-255-3240', 'warriors@kiwassa.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Vancouver Txamiks Society is a society which is a corporate entity under provincial law', 'Vancouver Coastal', NULL, '604-646-4944', NULL, 'https://www.nisgaanation.ca/vancouver-nisgaa-urban-local');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Housing Society selects tenants from the Housing Registry', 'Vancouver Island', NULL, '800-257-7756', 'affordablerent@makola.bc.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Housing Society advertises current vacancies when they become available', 'Vancouver Island', NULL, '877-384-1423', 'affordablerent@makola.bc.ca', 'http://makola.bc.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Society', 'Northern', 'Fort St. James / Nak’adzli Whut’en', '250-774-2993', 'fnafs@northwestel.net', 'https://fnafs.org/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('NorthEastNativeAdvancingSocietyNenas', 'Northern', 'Prince George, Fort Ware & Kwadacha Nation territory (Land-based)', '250-785-0887', 'nenas@nenas.org', 'http://www.nenas.org/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('North Coast Transition Society', 'Northern', NULL, '250-627-1717', NULL, 'https://friendshiphouse.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Quesnel Tillicum Society teams with CCATEC', 'Northern', NULL, '250-992-8347', 'karima.beaucage@qnfc.bc.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Terrace Society', 'Northern', 'Tl’azt’en Nation / Tachie', '250-635-8050', NULL, 'https://www.nisgaanation.ca/terrace-nisgaa-urban-local');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Legal Services Society of B', 'Northern', NULL, '604-408-2172', NULL, 'https://aboriginal.legalaid.bc.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Aboriginal Housing Management Association', 'Interior', NULL, '236-420-2992', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Tribal Association', 'Northern', 'Fort St John (Region 7)', '250-785-4900', 'acowger@pris.bc.ca', 'http://treaty8.bc.ca/housing-2/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Ktunaxa Kinbasket Justice Services work with youth and adults who are in need of legal assistance', 'Interior', NULL, '250-489-4563', 'hporter@ktunaxa.org', 'http://www.ktunaxa.org/justice-services/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Programs & Services', 'Interior', NULL, '250-489-4563', 'hporter@ktunaxa.org', 'http://www.ktunaxa.org/justice-services/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Programs & Services Alcohol & Drug Program', 'Interior', NULL, '250-376-1296', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Wellness Services', 'Interior', 'Kamloops', '250-376-1296', NULL, 'https://www.kafs.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Kamloops BC Lii Michif Otipemisiwak Family and Community Services Location', 'Interior', 'Kamloops', '250-554-9486', NULL, 'https://lmofcs.ca');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Lii-Michif-Otipemisiwak-Family-and-Community- Services-', 'Interior', 'Kamloops (Region 3)', '250-554-9486', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Employment Services', 'Interior', 'Kelowna', '250-763-4905', 'reception@kfs.bc.ca', 'http://www.kfs.bc.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Programs & Services Subsidized Units', 'Interior', NULL, '250-763-7747', 'omahs@telus.net', 'http://omahs.ca/faq_1');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Safe Home & Trauma Counselling Services', 'Interior', NULL, '250-256-4146', 'info@lfcs.ca', 'http://www.lfcs.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Victim Services', 'Interior', 'Merritt', '250-280-8642', 'nvicliaison@gmail.com', 'https://www.nvcjss.com/programs/nicola-valley-indigenous-court-program/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Programs & Services Aboriginal Family Group Conferencing Program', 'Interior', NULL, '250-542-1247', 'executive_secretary@fnfc.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Programs & Services Family Alcohol and Drug Program', 'Interior', NULL, '250-989-0301', 'jevans@nenqayni.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Programs & Services Low- & Medium-Income Housing', 'Interior', NULL, '250-398-6831', 'admin@cfswl.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Shelter Services', 'Interior', NULL, '250-398-6831', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Programs & Services The Homeless Prevention Program', 'Fraser', NULL, '604-824-0939', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Programs & Services Outreach Worker', 'Fraser', NULL, '604-826-1281', NULL, 'https://missionfriendshipcentresociety.com/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Program Services include', 'Fraser', NULL, '604-595-1170', 'marissa.mcintyre@frafca.org', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Heiltsuk Kaxla Child and Family Services', 'Vancouver Coastal', NULL, '250-957-2213', 'mary.brown@heiltsuk.ca', 'http://www.heiltsuknation.ca/departments/justice-department/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Additional Programs & Services monitoring of youth and adults on probation', 'Vancouver Coastal', NULL, '250-799-5809', 'restorative@nuxalknation.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Additional Programs & Services Personal tax service', 'Vancouver Coastal', NULL, '604-251-7200', 'administration@vatjss.com', 'http://vatjss.com/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Withdrawal Management Services', 'Vancouver Coastal', 'Vancouver', '604-628-1143', NULL, 'https://nccabc.ca/health/aboriginal-detox-support-workers-program/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Vancouver BC Additional Programs & Services We offer a variety of weekly groups', 'Vancouver Coastal', 'Vancouver', '604-628-1143', NULL, 'www.nccabc.ca');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Drop-In Services Centre and', 'Vancouver Coastal', '1138 Burrard Street (Downtown Vancouver, across from St. Paul’s Hospital)', '604-633-1472', 'directions@fsgv.ca', 'https://www.directionsyouthservices.ca/youth-services-centre');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Programs & Services Crabtree Corner Transitional Housing', 'Vancouver Coastal', NULL, '604-216-1652', NULL, 'https://ywcavan.org/programs/crabtree-corner');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Programs & Services Family Support and Social Worker Program', 'Vancouver Island', NULL, '250-753-6578', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Youth Services Team', 'Vancouver Island', NULL, '250-384-3211', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Community-Based Victim Services Program Worker Phone', 'Northern', 'Fort Nelson', '250-771-5577', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('John Programs & Services', 'Northern', 'Fort St. John', '250-785-8566', NULL, 'https://www.facebook.com/Fort-St-John-Friendship-Center-220929864594344/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Additional Programs & Services', 'Northern', NULL, '250-563-4161', 'chris.tyler@kwadacha.com', 'http://www.kwadacha.com/portfolio');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Family Relations Act - Child and Family Community Services Act Advocacy and Poverty Law Services', 'Northern', NULL, '877-842-5218', 'Sandra.Hazelton@lss.bc.ca', 'http://www.usclas.com/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Victims Services', 'Northern', NULL, '250-633-3070', 'faitht@nisgaa.net', 'https://www.nisgaanation.ca/services-0');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Victim Services Worker Phone', 'Northern', NULL, '250-633-3012', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('See above Programs & Services', 'Northern', 'Prince George', '250-562-7928', 'vblinn@pguajs.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Youth Services Team Leader Phone', 'Northern', NULL, '250-563-5085', 'srennie@pgnfc.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Outreach Services', 'Northern', NULL, '250-563-1982', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Outreach Services are provided through the Aboriginal Homeless Outreach and Homeless Outreach teams', 'Northern', NULL, '250-563-1982', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Page Services provided', 'Northern', NULL, '250-562-2538', 'kjames@pgnfc.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Outreach Services initiates integrated case management to determine the best plan of care for youth', 'Northern', NULL, '250-562-2538', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Reconnect Youth Village also provides Street Outreach Services', 'Northern', NULL, '250-562-2538', 'kjames@pgnfc.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Programs & Services - Individual employment counselling', 'Northern', NULL, '250-564-3568', 'selgie@pgnfc.com', 'http://www.pgnfc.com/programs_services.html');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Victim Services Program', 'Northern', NULL, '250-564-3568', 'info@pgnfc.com', 'http://www.pgnfc.com/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Employment Assistance Services', 'Northern', NULL, '250-564-3568', 'info@pgnfc.com', 'http://www.pgnfc.com/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Programs & Services Youth Probation Outreach Worker', 'Northern', NULL, '250-992-8347', 'maynard.bara@qnfc.bc.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Children and Family Services', 'Northern', NULL, '250-992-8347', 'cindy.lepetich@qnfc.bc.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Ministry of Children and Family Services', 'Northern', NULL, '250-992-8347', 'lynn.peterson@qnfc.bc.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Programs & Services People First Adult Program', 'Northern', NULL, '250-635-4906', 'emcmillan@kermodefriendship.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Programs & Services Alcohol and Drug Counselling The Alcohol and Drug Counsellor provides one-on-one', 'Northern', NULL, '250-847-5211', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Nicola Valley Indigenous Court', 'Interior', 'Kamloops', '250-299-6519', 'bkeeper@nccabc.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Elders Justice Council is an active part of the Indigenous Court process', 'Interior', 'Kamloops', '250-828-4344', NULL, 'https://www.provincialcourt.bc.ca/court-');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('New Westminster support is provided for non-NWLC Indigenous Court matters only', 'Fraser', 'Many offices are located in Surrey however please note that FRAFCA offices and', '604-985-5355', 'd.louie@nccabc.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Costs are usually covered by the First Nations Health Authority', 'Interior', NULL, '250-546-8848', 'intake@roundlake.bc.ca', 'http://roundlaketreatmentcentre.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Please note that there is no First Nations Health Authority coverage at this time', 'Interior', 'Kamloops / Whispering Pines / Clinton Indian Band', '250-440-5651', NULL, 'https://www.esketemc.ca/letwilc-ren-semec-centre/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('BCNWA provides financial support to First Nations', 'Interior', NULL, '250-554-4556', NULL, 'http://bcnwa.weebly.com/asets.html');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Nooaitch and Shackan First Nations', 'Interior', 'Merritt', '250-378-5010', 'nvacjp@uniserve.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Sylix Nation First Nations', 'Interior', NULL, '250-542-1247', 'executive_secretary@fnfc.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Xeni Gwet''in First Nations Government', 'Interior', NULL, '250-392-2510', 'j.harry@ccatec.com', 'http://www.ccatec.com/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Operated in partnership with Fraser Health Aboriginal Health and First Nations Health Authority', 'Fraser', 'A101-10095 Whalley Blvd, Surrey and 100-10233 153 Street, Surrey', '604-283-3293', 'IPHWH@fraserhealth.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('MCFNTS will provide access to all First Nations people regardless of place of origin', 'Vancouver Coastal', NULL, '250-957-2225', 'mcfnts@gmail.com', 'http://www.mcfnts.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('This includes First Nations', 'Vancouver Coastal', NULL, '604-876-0811', NULL, 'http://lnhs.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Costs are covered by First Nations Health Authority', 'Vancouver Island', NULL, '250-974-5522', 'sonny.voyageur@namgis.bc.ca', 'http://www.namgis.bc.ca/health-services/treatment-centre/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Most of the First Nations are of the Kwakiutl Nation', 'Vancouver Island', NULL, '250-974-2908', 'sherry.simms@niviats.com', 'http://www.nviats.com/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Duncan First Nations Court', 'Vancouver Island', NULL, '236-800-4023', NULL, 'www.cowichantribes.com/member-services/community-justice/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Our program also partners with First Nations and Indigenous communities and leadership', 'Vancouver Island', NULL, '778-426-2997', 'vanessaramsdale@siws.ca', 'http://www.siws.ca/siws-services-restorative-justice.html');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Southern Island First Nations communities', 'Vancouver Island', 'Victoria (Head Office)', '250-386-6717', 'sjohnson@nccabc.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Costs are usually covered by First Nations Health Authority', 'Northern', 'Dawson Creek', '250-843-6977', 'intake@northwindwc.ca', 'https://northwindwellnesscentre.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Our mandate is to serve primarily First Nations', 'Northern', 'Dawson Creek', '250-843-6977', 'intake@northwindwc.ca', 'https://northwindwellnesscentre.ca/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Drug and Alcohol Counsellor promotes the integration of First Nations people in all communities', 'Northern', NULL, '250-992-8347', 'lynn.peterson@qnfc.bc.ca', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Native and non-Native people', 'Interior', NULL, '250-763-7747', 'omahs@telus.net', 'http://omahs.ca/faq_1');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Native and non-Native people may apply', 'Interior', 'Kelowna (Head Office) & offices throughout the Okanagan.', '250-763-7747', 'omahs@telus.net', 'http://omahs.ca/faq_1');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('program is open to both Native and non-Native people and is provided free of charge', 'Interior', NULL, '250-256-4146', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Families and single parents of Native ancestry', 'Interior', NULL, '250-378-5107', NULL, NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('National Native Alcohol and Drug Abuse Program Location', 'Interior', 'Williams Lake (we are located on the Soda Creek Reserve 21 kilometers north of', '250-989-0301', 'jevans@nenqayni.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Native and non- Native people either coming to', 'Northern', NULL, '250-788-2996', 'addictions@tansifcs.com', NULL);
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Urban Native Housing Program', 'Northern', NULL, '250-992-3306', 'reception@dqchs.org', 'https://www.dqchs.org/');
INSERT INTO indigenous_resources (name, region, location, phone, email, website) VALUES ('Rural and Native Housing Program', 'Northern', NULL, '250-992-3306', 'reception@dqchs.org', 'https://www.dqchs.org/');

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_fnha_name_trgm ON fnha_mental_health_providers USING gin (name gin_trgm_ops);
CREATE INDEX IF NOT EXISTS idx_fnha_region ON fnha_mental_health_providers(region);
CREATE INDEX IF NOT EXISTS idx_indig_name_trgm ON indigenous_resources USING gin (name gin_trgm_ops);
CREATE INDEX IF NOT EXISTS idx_indig_region ON indigenous_resources(region);

-- Verify
SELECT 'fnha_mental_health_providers' as table_name, COUNT(*) as records FROM fnha_mental_health_providers
UNION ALL SELECT 'indigenous_resources', COUNT(*) FROM indigenous_resources;
