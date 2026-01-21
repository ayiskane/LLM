-- =============================================
-- RCC SUPPORT CONTACTS SCHEMA
-- =============================================

-- Drop existing tables if they exist
DROP TABLE IF EXISTS rcc_support_contacts CASCADE;
DROP TABLE IF EXISTS rcc_support_contact_centres CASCADE;
DROP TABLE IF EXISTS rcc_support_roles CASCADE;
DROP TABLE IF EXISTS rcc_support_organizations CASCADE;
DROP TABLE IF EXISTS rcc_constants CASCADE;

-- =============================================
-- SUPPORT ROLES
-- =============================================
CREATE TABLE rcc_support_roles (
    id SERIAL PRIMARY KEY,
    code VARCHAR(10) NOT NULL UNIQUE,              -- e.g., 'CTT', 'CR', 'CIW'
    name VARCHAR(100) NOT NULL,                    -- e.g., 'Community Transition Team'
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

INSERT INTO rcc_support_roles (code, name, description) VALUES
('CTT', 'Community Transition Team', 'PHSA-run teams providing mental health and substance use support for up to 90 days post-release'),
('CR', 'Community Reintegration', 'Release planning, housing, ID, employment support'),
('CIW', 'Community Integration Worker', 'Community society workers assisting with release planning and reintegration'),
('ITRP', 'Integrated Transitional Release Planning', 'BC Corrections release planning program for high-risk individuals'),
('ICL', 'Indigenous Cultural Liaison', 'Cultural support and connection to Indigenous services and communities'),
('RPO', 'Release Planning Officer', 'BC Corrections staff coordinating release plans'),
('CDC', 'Concurrent Disorder Counsellor', 'Healthcare staff for mental health and substance use');

-- =============================================
-- SUPPORT ORGANIZATIONS
-- =============================================
CREATE TABLE rcc_support_organizations (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    short_name VARCHAR(50),
    website VARCHAR(255),
    general_email VARCHAR(255),
    general_phone VARCHAR(50),
    notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

INSERT INTO rcc_support_organizations (name, short_name, website, general_email, general_phone, notes) VALUES
('Provincial Health Services Authority', 'PHSA', 'https://www.bcmhsus.ca/correctional-health-services', 'CommunityTransitionTeams@phsa.ca', '1-855-524-7733', 'Operates CTT teams at all 10 provincial centres'),
('Connective Support Society', 'Connective', 'https://connective.ca', NULL, NULL, 'Serves NFPC, FRCC'),
('Elizabeth Fry Society', 'E Fry', 'https://www.elizabethfry.com', NULL, NULL, 'Serves ACCW (women''s centre)'),
('Pacific Women''s Society', 'PWS', NULL, NULL, NULL, 'Serves SPSC'),
('John Howard Society of BC', 'JHS', 'https://johnhowardbc.ca', NULL, NULL, 'Various correctional support services'),
('BC Corrections', 'BCC', 'https://www2.gov.bc.ca/gov/content/justice/criminal-justice/corrections', NULL, NULL, 'Provincial corrections branch');

-- =============================================
-- SUPPORT CONTACTS
-- =============================================
CREATE TABLE rcc_support_contacts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,                    -- Contact name or office name
    is_individual BOOLEAN DEFAULT TRUE,           -- TRUE for person, FALSE for office/department
    role_id INTEGER REFERENCES rcc_support_roles(id),
    organization_id INTEGER REFERENCES rcc_support_organizations(id),
    
    -- Contact info
    email VARCHAR(255),
    email_secondary VARCHAR(255),                  -- Some have gov + org email
    phone VARCHAR(50),
    
    notes TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- =============================================
-- CONTACT TO CENTRE MAPPING (Many-to-Many)
-- centre_id matches id from lib/constants/correctional-centres.ts
-- =============================================
CREATE TABLE rcc_support_contact_centres (
    id SERIAL PRIMARY KEY,
    contact_id INTEGER NOT NULL REFERENCES rcc_support_contacts(id) ON DELETE CASCADE,
    centre_id INTEGER NOT NULL,                    -- Matches id in correctional-centres.ts constants
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(contact_id, centre_id)
);

-- Reference for centre_id values (from lib/constants/correctional-centres.ts):
-- Provincial:
--   1 = VIRCC (Victoria)
--   2 = NCC (Nanaimo)
--   3 = OCC (Oliver)
--   4 = KRCC (Kamloops)
--   5 = PGRCC (Prince George)
--   6 = SPSC (Surrey)
--   7 = NFPC (Port Coquitlam)
--   8 = FRCC (Maple Ridge)
--   9 = ACCW (Maple Ridge)
--   10 = FMCC (Chilliwack)
-- Federal:
--   11 = FVI (Abbotsford)
--   12 = KENT (Agassiz)
--   13 = MATSQUI (Abbotsford)
--   14 = MISSION-MED (Mission)
--   15 = MISSION-MIN (Mission)
--   16 = MOUNTAIN (Agassiz)
--   17 = PACIFIC (Abbotsford)
--   18 = WILLIAM-HEAD (Victoria)

-- Indexes
CREATE INDEX idx_rcc_contacts_role ON rcc_support_contacts(role_id);
CREATE INDEX idx_rcc_contacts_org ON rcc_support_contacts(organization_id);
CREATE INDEX idx_rcc_contacts_active ON rcc_support_contacts(is_active);
CREATE INDEX idx_rcc_contact_centres_contact ON rcc_support_contact_centres(contact_id);
CREATE INDEX idx_rcc_contact_centres_centre ON rcc_support_contact_centres(centre_id);

-- =============================================
-- INSERT CONTACTS FROM CHEATSHEET
-- =============================================

-- Maeve O'Sullivan - CTT at ACCW
INSERT INTO rcc_support_contacts (name, is_individual, role_id, organization_id, email)
VALUES ('Maeve O''Sullivan', TRUE, 
    (SELECT id FROM rcc_support_roles WHERE code = 'CTT'),
    (SELECT id FROM rcc_support_organizations WHERE short_name = 'PHSA'),
    'Maeve.osullivan@phsa.ca');
INSERT INTO rcc_support_contact_centres (contact_id, centre_id)
VALUES ((SELECT id FROM rcc_support_contacts WHERE name = 'Maeve O''Sullivan'), 9); -- ACCW

-- Laura Burkholder - CTT at NFPC
INSERT INTO rcc_support_contacts (name, is_individual, role_id, organization_id, email)
VALUES ('Laura Burkholder', TRUE,
    (SELECT id FROM rcc_support_roles WHERE code = 'CTT'),
    (SELECT id FROM rcc_support_organizations WHERE short_name = 'PHSA'),
    'Laura.Burkholder@phsa.ca');
INSERT INTO rcc_support_contact_centres (contact_id, centre_id)
VALUES ((SELECT id FROM rcc_support_contacts WHERE name = 'Laura Burkholder'), 7); -- NFPC

-- Ashley Lafortune - CTT at SPSC
INSERT INTO rcc_support_contacts (name, is_individual, role_id, organization_id, email, phone)
VALUES ('Ashley Lafortune', TRUE,
    (SELECT id FROM rcc_support_roles WHERE code = 'CTT'),
    (SELECT id FROM rcc_support_organizations WHERE short_name = 'PHSA'),
    'ashley.lafortune@phsa.ca', '236-994-7733');
INSERT INTO rcc_support_contact_centres (contact_id, centre_id)
VALUES ((SELECT id FROM rcc_support_contacts WHERE name = 'Ashley Lafortune'), 6); -- SPSC

-- Sean Perry - CR at SPSC and NFPC (serves multiple)
INSERT INTO rcc_support_contacts (name, is_individual, role_id, organization_id, email, email_secondary, phone)
VALUES ('Sean Perry', TRUE,
    (SELECT id FROM rcc_support_roles WHERE code = 'CR'),
    (SELECT id FROM rcc_support_organizations WHERE short_name = 'Connective'),
    'sean.perry@connective.ca', 'Sean.Perry@gov.bc.ca', '604-468-3406');
INSERT INTO rcc_support_contact_centres (contact_id, centre_id)
VALUES 
    ((SELECT id FROM rcc_support_contacts WHERE name = 'Sean Perry'), 6), -- SPSC
    ((SELECT id FROM rcc_support_contacts WHERE name = 'Sean Perry'), 7); -- NFPC

-- SPSC Community Reintegration Office
INSERT INTO rcc_support_contacts (name, is_individual, role_id, organization_id, email, phone)
VALUES ('SPSC Community Reintegration Office', FALSE,
    (SELECT id FROM rcc_support_roles WHERE code = 'CR'),
    (SELECT id FROM rcc_support_organizations WHERE short_name = 'BCC'),
    'SPSC.Reintegration@gov.bc.ca', '604-572-2170');
INSERT INTO rcc_support_contact_centres (contact_id, centre_id)
VALUES ((SELECT id FROM rcc_support_contacts WHERE name = 'SPSC Community Reintegration Office'), 6); -- SPSC

-- =============================================
-- SYSTEM-WIDE RCC CONSTANTS
-- =============================================
CREATE TABLE rcc_constants (
    id SERIAL PRIMARY KEY,
    key VARCHAR(100) NOT NULL UNIQUE,
    value VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

INSERT INTO rcc_constants (key, value, description) VALUES
('ctt_general_email', 'CommunityTransitionTeams@phsa.ca', 'General CTT inquiries email'),
('ctt_toll_free_voicemail', '1-855-524-7733', 'CTT toll-free voicemail'),
('correctional_health_services_phone', '604-829-8657', 'Correctional Health Services administration'),
('bc_corrections_family_line', '1-888-952-7968', 'BC Corrections family message line');

-- =============================================
-- HELPFUL VIEWS
-- =============================================

-- View: Contacts with role, org names, and centre IDs
CREATE OR REPLACE VIEW rcc_contacts_full AS
SELECT 
    c.id,
    c.name,
    c.is_individual,
    r.code AS role_code,
    r.name AS role_name,
    o.name AS organization_name,
    o.short_name AS organization_short_name,
    c.email,
    c.email_secondary,
    c.phone,
    ARRAY_AGG(cc.centre_id ORDER BY cc.centre_id) AS centre_ids,
    c.notes,
    c.is_active
FROM rcc_support_contacts c
LEFT JOIN rcc_support_roles r ON c.role_id = r.id
LEFT JOIN rcc_support_organizations o ON c.organization_id = o.id
LEFT JOIN rcc_support_contact_centres cc ON c.id = cc.contact_id
WHERE c.is_active = TRUE
GROUP BY c.id, c.name, c.is_individual, r.code, r.name, o.name, o.short_name, 
         c.email, c.email_secondary, c.phone, c.notes, c.is_active;

-- =============================================
-- VERIFY DATA
-- =============================================
SELECT 'Roles' as table_name, COUNT(*) as count FROM rcc_support_roles
UNION ALL
SELECT 'Organizations', COUNT(*) FROM rcc_support_organizations
UNION ALL
SELECT 'Contacts', COUNT(*) FROM rcc_support_contacts
UNION ALL
SELECT 'Contact-Centre Links', COUNT(*) FROM rcc_support_contact_centres;

-- Show all contacts with their centres
SELECT * FROM rcc_contacts_full;
