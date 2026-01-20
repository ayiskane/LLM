-- ============================================================
-- BC Courts Database - Clean Schema
-- ============================================================

-- Drop existing
DROP VIEW IF EXISTS circuit_courts_view CASCADE;
DROP VIEW IF EXISTS staffed_courts CASCADE;
DROP VIEW IF EXISTS courts_full CASCADE;
DROP VIEW IF EXISTS provincial_courts CASCADE;
DROP VIEW IF EXISTS supreme_courts CASCADE;
DROP TABLE IF EXISTS court_contacts CASCADE;
DROP TABLE IF EXISTS courts CASCADE;
DROP TABLE IF EXISTS court_types CASCADE;
DROP TABLE IF EXISTS regions CASCADE;

-- ============================================================
-- REGIONS TABLE
-- ============================================================
CREATE TABLE regions (
    id SERIAL PRIMARY KEY,
    code VARCHAR(5) UNIQUE NOT NULL,
    name VARCHAR(50) NOT NULL
);

INSERT INTO regions (code, name) VALUES
    ('R1', 'Vancouver Island'),
    ('R2', 'Vancouver Coastal'),
    ('R3', 'Fraser'),
    ('R4', 'Interior'),
    ('R5', 'Northern');

-- ============================================================
-- COURTS TABLE
-- ============================================================
CREATE TABLE courts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    region_id INTEGER REFERENCES regions(id),
    
    -- Court type flags (not mutually exclusive except circuit)
    has_provincial BOOLEAN DEFAULT FALSE,
    has_supreme BOOLEAN DEFAULT FALSE,
    is_circuit BOOLEAN DEFAULT FALSE,
    
    -- For Provincial-only courts that can FILE Supreme docs (e.g., Fort Nelson)
    -- If has_supreme = TRUE, this is assumed TRUE and ignored
    has_supreme_filing BOOLEAN DEFAULT FALSE,
    
    -- Staffing
    is_staffed BOOLEAN DEFAULT FALSE,
    contact_hub VARCHAR(100),
    
    -- Location & General Contact
    address TEXT,
    phone VARCHAR(50),
    fax VARCHAR(50),
    civil_fax VARCHAR(50),
    criminal_fax VARCHAR(50),
    sheriff_phone VARCHAR(50),
    
    -- Supreme Court Scheduling (from BC Courts PDF)
    supreme_scheduling_phone VARCHAR(50),
    supreme_scheduling_fax VARCHAR(50),
    supreme_toll_free VARCHAR(50),
    supreme_fax_filing VARCHAR(50),
    
    -- Access & Notes
    access_code VARCHAR(20),
    access_code_notes TEXT,
    notes TEXT,
    
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================
-- COURT CONTACTS TABLE
-- ============================================================
CREATE TABLE court_contacts (
    id SERIAL PRIMARY KEY,
    court_id INTEGER REFERENCES courts(id) ON DELETE CASCADE,
    contact_type VARCHAR(50) NOT NULL,
    email VARCHAR(200),
    phone VARCHAR(50),
    fax VARCHAR(50),
    notes TEXT,
    UNIQUE(court_id, contact_type)
);

-- Contact types: crown, jcm_scheduling, supreme_scheduling, court_registry, 
--                criminal_registry, bail_crown, bail_jcm, interpreter

-- ============================================================
-- INSERT COURTS
-- ============================================================

-- Insert courts
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Victoria', 1, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, '850 Burdett Avenue, Victoria, BC V8W 9J2', '250-356-1478', NULL, '250-387-3061', '250-356-6279', '250-387-6811', '250.356.1450', '250.952.6824', NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Western Communities', 1, TRUE, FALSE, FALSE, FALSE, TRUE, NULL, '1756 Island Hwy, Victoria, BC V8W 9J5', '250-391-2888', '250-391-2877', NULL, NULL, '250-391-2873', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Duncan', 1, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, '238 Government Street, Duncan, BC V9L 1A5', '250-746-1258', '250-746-1244', NULL, NULL, '250-746-1233', '250.741.5851', '250.952.6824', NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Nanaimo', 1, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, '35 Front Street, Nanaimo, BC V9R 5J1', '250-716-5918', '250-716-5911', NULL, NULL, '250-716-5926', '250.741.5860', '250.741.5872', NULL, NULL, '3179#', NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Port Alberni', 1, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, '2999 - 4th Avenue, Port Alberni, BC V9Y 8A5', '250-720-2424', '250-720-2419', NULL, NULL, '250-720-2415', '250.741.5860', '250.741.5872', '1.877.741.3820', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Courtenay', 1, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, 'Rm. 100, 420 Cumberland Road, Courtenay, BC V9N 2C4', '250-334-1115', '250-334-1191', NULL, NULL, '250-334-1135', '250.741.5860', '250.741.5872', '1.877.741.3820', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Campbell River', 1, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, '500 - 13th Avenue, Campbell River, BC V9W 6P1', '250-286-7510', '250-286-7512', NULL, NULL, '250-286-7518', '250.741.5860', '250.741.5872', '1.877.741.3820', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Port Hardy', 1, TRUE, FALSE, FALSE, FALSE, TRUE, NULL, 'Box 279, 9300 Trustee Road, Port Hardy, BC V0N 2P0', '250-949-6122', '250-949-9283', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Powell River', 1, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, 'Rm. 103, 6953 Alberni Street, Powell River, BC V8A 2B8', '604-485-3630', '604-485-3637', NULL, NULL, '604-485-3641', '250.741.5860', '250.741.5872', '1.877.741.3820', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Vancouver Supreme Court', 2, FALSE, TRUE, FALSE, FALSE, TRUE, NULL, 'Law Courts, 800 Smithe Street, Vancouver, BC V6Z 2E1', '604-660-2847', '604-660-2420', NULL, NULL, '604-660-2601', '604.660.2853', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Vancouver Provincial Court', 2, TRUE, FALSE, FALSE, FALSE, TRUE, NULL, '222 Main Street, Vancouver, BC V6A 2S8', '604-660-4200', '604-775-1134', NULL, NULL, '604-660-4200', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Robson Square Provincial Court', 2, TRUE, FALSE, FALSE, FALSE, TRUE, NULL, 'Box 21, 800 Hornby Street, Vancouver, BC V6Z 2C5', '604-660-8989', '604-660-8950', NULL, NULL, '604-660-7810', NULL, NULL, NULL, NULL, NULL, NULL, 'Small claims, family, youth, traffic');
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Downtown Community Court', 2, TRUE, FALSE, FALSE, FALSE, TRUE, NULL, '211 Gore Avenue, Vancouver, BC V6A 0B6', '604-660-8754', '604-660-9714', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('North Vancouver', 2, TRUE, FALSE, FALSE, FALSE, TRUE, NULL, '200 East 23rd Street, North Vancouver, BC V7L 4R4', '604-981-0200', '604-981-0234', NULL, NULL, '604-981-0232', NULL, NULL, NULL, NULL, '2355', NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Richmond', 2, TRUE, FALSE, FALSE, FALSE, TRUE, NULL, '7577 Elmbridge Way, Richmond, BC V6X 4J2', '604-660-6900', '604-660-1797', NULL, NULL, '604-660-3467', NULL, NULL, NULL, NULL, '235#', NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Sechelt', 2, TRUE, FALSE, FALSE, FALSE, TRUE, NULL, 'Box 160, 5480 Shorncliffe Avenue, Sechelt, BC V0N 3A0', '604-740-8929', '604-740-8924', NULL, NULL, '604-740-8933', NULL, NULL, NULL, NULL, '36', 'BC Sport Fishing Reg paper on the window', NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('New Westminster', 3, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, 'Law Courts, Begbie Square, 651 Carnarvon Street, New Westminster, BC V3M 1C9', '604-660-8522', NULL, '604-515-4280', '604-660-8512', '604-660-8538', '604.660.8551', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Surrey', 3, TRUE, FALSE, FALSE, FALSE, TRUE, NULL, '14340 - 57 Avenue, Surrey, BC V3X 1B2', '604-572-2200', '604-572-2280', NULL, NULL, '604-572-2242', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Port Coquitlam', 3, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, 'Unit A, 2620 Mary Hill Road, Port Coquitlam, BC V3C 3B2', '604-927-2100', '604-927-2222', NULL, NULL, '604-927-2120', '604.927.2255', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Abbotsford', 3, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, '32375 Veteran''s Way, Abbotsford, BC V2T 0K1', '604-855-3200', '604-855-3232', NULL, NULL, '604-855-3222', '604.425.3711', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Chilliwack', 3, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, '46085 Yale Road, Chilliwack, BC V2P 2L8', '604-795-8350', NULL, '604-795-8345', '604-795-8393', '604-795-8207', '604.795.8349', NULL, NULL, '604.795.8397', '512', NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Kamloops', 4, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, 'Rm. 223, 455 Columbia Street, Kamloops, BC V2C 6K4', '250-828-4344', '250-828-4332', NULL, NULL, '250-828-4328', '250.828.4351', '250.828.4332', NULL, '250.828.4345', NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Kelowna', 4, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, '1 - 1355 Water Street, Kelowna, BC V1Y 9R3', '250-470-6900', '250-470-6939', NULL, NULL, '250-470-6846', '250.470.6935', NULL, NULL, '250.979.6768', NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Vernon', 4, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, '3001 - 27 Street, Vernon, BC V1T 4W5', '250-549-5422', '250-549-5621', NULL, NULL, '250-549-5410', '250.470.6935', '250.979.6783', '1.888.526.8555', '250.549.5461', NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Penticton', 4, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, '100 Main Street, Penticton, BC V2A 5A5', '250-492-1231', '250-492-1378', NULL, NULL, '250-492-1234', '250.470.6935', '250.979.6783', '1.888.526.8555', '250.492.1290', NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Salmon Arm', 4, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, 'PO Box 100 Station Main, #550 - 2nd Avenue NE, Salmon Arm, BC V1E 4S4', '250-832-1610', '250-832-1749', NULL, NULL, '250-832-1615', '250.828.4351', '250.828.4332', '1.888.828.4351', '250.833.7401', NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Nelson', 4, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, '320 Ward Street, Nelson, BC V1L 1S6', '250-354-6165', '250-354-6539', NULL, NULL, '250-354-6155', '250.828.4351', '250.828.4332', '1.888.828.4351', '250.354.6133', NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Rossland', 4, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, 'Box 639, 2288 Columbia Avenue, Rossland, BC V0G 1Y0', '250-362-7368', '250-362-9632', NULL, NULL, '250-362-7368', '250.828.4351', '250.828.4332', '1.888.828.4351', '250.362.7321', NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Cranbrook', 4, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, 'Rm. 147, 102 - 11 Avenue South, Cranbrook, BC V1C 2P3', '250-426-1234', '250-426-1352', NULL, NULL, '250-426-1212', '250.828.4351', '250.828.4332', NULL, '250.426.1498', NULL, NULL, 'Mountain Time');
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Golden', 4, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, 'Box 1500, 837 Park Drive, Golden, BC V0A 1H0 (Temp: 1104 9th St. South)', '250-344-7581', '250-344-7715', NULL, NULL, NULL, '250.828.4351', NULL, NULL, NULL, NULL, NULL, 'Mountain Time');
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Prince George', 5, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, 'J.O. Wilson Square, 250 George Street, Prince George, BC V2L 5S2', '250-614-2700', '250-614-2717', NULL, NULL, '250-614-2741', '250.614.2750', NULL, NULL, '250.614.7923', NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Quesnel', 5, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, '350 Barlow Avenue, Quesnel, BC V2J 2C2', '250-992-4256', '250-992-4171', NULL, NULL, '250-992-4236', '250.614.2750', '250.614.2791', '1.866.614.2750', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Williams Lake', 5, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, '540 Borland Street, Williams Lake, BC V2G 1R8', '250-398-4301', '250-398-4459', NULL, NULL, '250-398-4292', '250.614.2750', '250.614.2791', '1.866.614.2750', '250.398.4264', NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Smithers', 5, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, '#40 Bag 5000, 3793 Alfred Street, Smithers, BC V0J 2N0', '250-847-7376', '250-847-7710', NULL, NULL, '250-847-7372', '250.614.2644', NULL, NULL, '250.847.7344', NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Terrace', 5, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, '3408 Kalum Street, Terrace, BC V8G 2N6', '250-638-2111', '250-638-2123', NULL, NULL, '250-638-2121', '250.614.2750', NULL, NULL, '250.638.2143', NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Prince Rupert', 5, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, '100 Market Place, Prince Rupert, BC V8J 1B8', '250-624-7525', '250-624-7538', NULL, NULL, '250-624-7528', '250.614.2750', NULL, NULL, NULL, '266266', NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Burns Lake', 5, TRUE, FALSE, FALSE, FALSE, TRUE, NULL, 'PO Box 251, 508 Yellowhead Hwy, Burns Lake, BC V0J 1E0', '250-692-7711', '250-692-7150', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Fort Nelson', 5, TRUE, FALSE, TRUE, FALSE, TRUE, NULL, 'Bag 1000, 5431 Airport Drive, Fort Nelson, BC V0C 1R0', '250-774-5999', '250-774-6904', NULL, NULL, NULL, '250.614.2750', '250.614.2791', '1.866.614.2750', NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Fort St. John', 5, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, '10600 - 100 Street, Fort St. John, BC V1J 4L6', '250-787-3231', '250-787-3518', NULL, NULL, '250-787-3272', '250.614.2750', '250.614.2791', '1.866.614.2750', NULL, '2&4, 3', '2 & 4 together🤘then 3 🖕', NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Dawson Creek', 5, TRUE, TRUE, FALSE, FALSE, TRUE, NULL, '1201 - 103 Avenue, Dawson Creek, BC V1G 4J2', '250-784-2278', '250-784-2339', NULL, NULL, '250-784-2266', '250.614.2750', '250.614.2791', '1.866.614.2750', '250.784.2218', NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Mackenzie', 5, TRUE, FALSE, FALSE, FALSE, TRUE, NULL, 'Box 2050, 64 Centennial Drive, Mackenzie, BC V0J 2C0', '250-997-3377', '250-997-5617', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Valemount', 5, TRUE, FALSE, FALSE, FALSE, TRUE, NULL, '1300 - 4th Avenue, P.O Box 125, Valemount, BC V0E 2Z0', '250-566-4652', '250-566-4620', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Ahousaht', 1, FALSE, FALSE, FALSE, TRUE, FALSE, 'Port Alberni', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Ganges', 1, FALSE, FALSE, FALSE, TRUE, FALSE, 'Duncan', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Gold River', 1, FALSE, FALSE, FALSE, TRUE, FALSE, 'Campbell River', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Sidney', 1, FALSE, FALSE, FALSE, TRUE, FALSE, 'Victoria', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Tahsis', 1, FALSE, FALSE, FALSE, TRUE, FALSE, 'Campbell River', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Tofino', 1, FALSE, FALSE, FALSE, TRUE, FALSE, 'Port Alberni', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Ucluelet', 1, FALSE, FALSE, FALSE, TRUE, FALSE, 'Port Alberni', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Bella Bella', 2, FALSE, FALSE, FALSE, TRUE, FALSE, 'Vancouver Provincial', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Criminal: Vancouver Provincial, Family: Robson Square');
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Bella Coola', 2, FALSE, FALSE, FALSE, TRUE, FALSE, 'Vancouver Provincial', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Criminal: Vancouver Provincial, Family: Robson Square');
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Klemtu', 2, FALSE, FALSE, FALSE, TRUE, FALSE, 'Vancouver Provincial', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Criminal: Vancouver Provincial, Family: Robson Square');
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Pemberton', 2, FALSE, FALSE, FALSE, TRUE, FALSE, 'North Vancouver', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Ashcroft', 4, FALSE, FALSE, FALSE, TRUE, FALSE, 'Kamloops', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Castlegar', 4, FALSE, FALSE, FALSE, TRUE, FALSE, 'Nelson', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Chase', 4, FALSE, FALSE, FALSE, TRUE, FALSE, 'Kamloops', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Clearwater', 4, FALSE, FALSE, FALSE, TRUE, FALSE, 'Kamloops', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Creston', 4, FALSE, FALSE, FALSE, TRUE, FALSE, 'Cranbrook', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Fernie', 4, FALSE, FALSE, FALSE, TRUE, FALSE, 'Cranbrook', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Grand Forks', 4, FALSE, FALSE, FALSE, TRUE, FALSE, 'Rossland', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Invermere', 4, FALSE, FALSE, FALSE, TRUE, FALSE, 'Cranbrook', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Lillooet', 4, FALSE, FALSE, FALSE, TRUE, FALSE, 'Kamloops', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Merritt', 4, FALSE, FALSE, FALSE, TRUE, FALSE, 'Kamloops', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Nakusp', 4, FALSE, FALSE, FALSE, TRUE, FALSE, 'Nelson', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Princeton', 4, FALSE, FALSE, FALSE, TRUE, FALSE, 'Penticton', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Revelstoke', 4, FALSE, FALSE, FALSE, TRUE, FALSE, 'Salmon Arm', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Sparwood', 4, FALSE, FALSE, FALSE, TRUE, FALSE, 'Cranbrook', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('100 Mile House', 5, FALSE, FALSE, FALSE, TRUE, FALSE, 'Williams Lake', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Alexis Creek', 5, FALSE, FALSE, FALSE, TRUE, FALSE, 'Williams Lake', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Anahim Lake', 5, FALSE, FALSE, FALSE, TRUE, FALSE, 'Williams Lake', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Atlin', 5, FALSE, FALSE, FALSE, TRUE, FALSE, 'Fort St. John', 'PO Box 100, 170 3rd St., Atlin, BC V0W 1A0', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Chetwynd', 5, FALSE, FALSE, FALSE, TRUE, FALSE, 'Dawson Creek', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Daajing Giids', 5, FALSE, FALSE, FALSE, TRUE, FALSE, 'Prince Rupert', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Formerly Queen Charlotte');
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Dease Lake', 5, FALSE, FALSE, FALSE, TRUE, FALSE, 'Terrace', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Fort St. James', 5, FALSE, FALSE, FALSE, TRUE, FALSE, 'Prince George', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Fraser Lake', 5, FALSE, FALSE, FALSE, TRUE, FALSE, 'Prince George', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Good Hope Lake', 5, FALSE, FALSE, FALSE, TRUE, FALSE, 'Fort St. John', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Hazelton', 5, FALSE, FALSE, FALSE, TRUE, FALSE, 'Smithers', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Houston', 5, FALSE, FALSE, FALSE, TRUE, FALSE, 'Smithers', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Hudson''s Hope', 5, FALSE, FALSE, FALSE, TRUE, FALSE, 'Fort St. John', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Kitimat', 5, FALSE, FALSE, FALSE, TRUE, FALSE, 'Terrace', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Kwadacha', 5, FALSE, FALSE, FALSE, TRUE, FALSE, 'Prince George', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Formerly Fort Ware');
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Lower Post', 5, FALSE, FALSE, FALSE, TRUE, FALSE, 'Fort St. John', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Masset', 5, FALSE, FALSE, FALSE, TRUE, FALSE, 'Prince Rupert', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('McBride', 5, FALSE, FALSE, FALSE, TRUE, FALSE, 'Valemount', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('New Aiyansh', 5, FALSE, FALSE, FALSE, TRUE, FALSE, 'Terrace', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Stewart', 5, FALSE, FALSE, FALSE, TRUE, FALSE, 'Terrace', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Tsay Keh Dene', 5, FALSE, FALSE, FALSE, TRUE, FALSE, 'Prince George', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Formerly Ingenika');
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Tumbler Ridge', 5, FALSE, FALSE, FALSE, TRUE, FALSE, 'Dawson Creek', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO courts (name, region_id, has_provincial, has_supreme, has_supreme_filing, is_circuit, is_staffed, contact_hub, address, phone, fax, civil_fax, criminal_fax, sheriff_phone, supreme_scheduling_phone, supreme_scheduling_fax, supreme_toll_free, supreme_fax_filing, access_code, access_code_notes, notes)
VALUES ('Vanderhoof', 5, FALSE, FALSE, FALSE, TRUE, FALSE, 'Prince George', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


-- Insert court contacts
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'VictoriaCrown.Public@gov.bc.ca' FROM courts WHERE name = 'Victoria';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'Vic.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Victoria';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_vi@bccourts.ca' FROM courts WHERE name = 'Victoria';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'criminal_registry', 'vicprovincialreg@gov.bc.ca' FROM courts WHERE name = 'Victoria';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'interpreter', 'victoria.finance@gov.bc.ca' FROM courts WHERE name = 'Victoria';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'BCPS.Duncan.Reception@gov.bc.ca' FROM courts WHERE name = 'Duncan';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'Dun.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Duncan';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_na@bccourts.ca' FROM courts WHERE name = 'Duncan';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'JAGCSBDuncanCourtScheduling@gov.bc.ca' FROM courts WHERE name = 'Duncan';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'Nanaimo.CrownSchedule@gov.bc.ca' FROM courts WHERE name = 'Nanaimo';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'Nanaimo.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Nanaimo';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_na@bccourts.ca' FROM courts WHERE name = 'Nanaimo';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'criminal_registry', 'crimreg.nanaimo@gov.bc.ca' FROM courts WHERE name = 'Nanaimo';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'PtAlberni.CrownSchedule@gov.bc.ca' FROM courts WHERE name = 'Port Alberni';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'PortAlberni.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Port Alberni';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_na@bccourts.ca' FROM courts WHERE name = 'Port Alberni';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'PortAlberniRegistry@gov.bc.ca' FROM courts WHERE name = 'Port Alberni';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'Courtenay.CrownSchedule@gov.bc.ca' FROM courts WHERE name = 'Courtenay';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'Courtenay.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Courtenay';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_na@bccourts.ca' FROM courts WHERE name = 'Courtenay';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'CourtenayRegistry@gov.bc.ca' FROM courts WHERE name = 'Courtenay';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'CampbellRiver.CrownSchedule@gov.bc.ca' FROM courts WHERE name = 'Campbell River';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'CampbellRiver.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Campbell River';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_na@bccourts.ca' FROM courts WHERE name = 'Campbell River';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'CampbellRiverRegistry@gov.bc.ca' FROM courts WHERE name = 'Campbell River';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'PortHardy.CrownSchedule@gov.bc.ca' FROM courts WHERE name = 'Port Hardy';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'PortHardy.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Port Hardy';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'porthardycourtregistry@gov.bc.ca' FROM courts WHERE name = 'Port Hardy';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'PowellRiver.CrownSchedule@gov.bc.ca' FROM courts WHERE name = 'Powell River';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'PowellRiver.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Powell River';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_na@bccourts.ca' FROM courts WHERE name = 'Powell River';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'powellriverregistry@gov.bc.ca' FROM courts WHERE name = 'Powell River';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'NorthVanCrown@gov.bc.ca' FROM courts WHERE name = 'North Vancouver';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'NVan.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'North Vancouver';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'NorthVancouverRegistry@gov.bc.ca' FROM courts WHERE name = 'North Vancouver';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'RichmondCrown@gov.bc.ca' FROM courts WHERE name = 'Richmond';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'Richmond.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Richmond';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'RichmondCourtRegistry@gov.bc.ca' FROM courts WHERE name = 'Richmond';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'interpreter', 'AGCSBRichmondInterpreters@gov.bc.ca' FROM courts WHERE name = 'Richmond';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'SecheltCrown@gov.bc.ca' FROM courts WHERE name = 'Sechelt';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'NVan.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Sechelt';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'SecheltRegistry@gov.bc.ca' FROM courts WHERE name = 'Sechelt';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'NewWestminsterProvincial@gov.bc.ca' FROM courts WHERE name = 'New Westminster';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'NewWest.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'New Westminster';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_nw@BCCourts.ca' FROM courts WHERE name = 'New Westminster';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'JAGCSBNWestminsterCourtScheduling@gov.bc.ca' FROM courts WHERE name = 'New Westminster';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'bail_crown', 'NewWestProv.VirtualBail@gov.bc.ca' FROM courts WHERE name = 'New Westminster';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'Surrey.Intake@gov.bc.ca' FROM courts WHERE name = 'Surrey';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'Surrey.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Surrey';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'criminal_registry', 'CSBSurreyProvincialCourt.CriminalRegistry@gov.bc.ca' FROM courts WHERE name = 'Surrey';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'bail_crown', 'Surrey.VirtualBail@gov.bc.ca' FROM courts WHERE name = 'Surrey';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'bail_jcm', 'Surrey.CriminalScheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Surrey';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'interpreter', 'CSBSurreyProvincialCourt.AccountingandInterpreters@gov.bc.ca' FROM courts WHERE name = 'Surrey';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'Poco.Crown@gov.bc.ca' FROM courts WHERE name = 'Port Coquitlam';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'PoCo.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Port Coquitlam';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_pc@bccourts.ca' FROM courts WHERE name = 'Port Coquitlam';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'criminal_registry', 'csb.portcoquitlamprovcriminal@gov.bc.ca' FROM courts WHERE name = 'Port Coquitlam';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'bail_crown', 'Poco.VirtualBail@gov.bc.ca' FROM courts WHERE name = 'Port Coquitlam';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'bail_jcm', 'Poco.VirtualHybridBail@provincialcourt.bc.ca' FROM courts WHERE name = 'Port Coquitlam';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'BCPS.Abbotsford.Reception@gov.bc.ca' FROM courts WHERE name = 'Abbotsford';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'Abbotsford.CriminalScheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Abbotsford';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_ab@bccourts.ca' FROM courts WHERE name = 'Abbotsford';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'criminal_registry', 'AbbotsfordCriminalRegistry@gov.bc.ca' FROM courts WHERE name = 'Abbotsford';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'bail_crown', 'Abbotsford.VirtualBail@gov.bc.ca' FROM courts WHERE name = 'Abbotsford';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'bail_jcm', 'Abbotsford.VirtualHybridBail@provincialcourt.bc.ca' FROM courts WHERE name = 'Abbotsford';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'interpreter', 'Tina.Nguyen@gov.bc.ca
Sheila.Hedd@gov.bc.ca
Damaris.Stanciu@gov.bc.ca' FROM courts WHERE name = 'Abbotsford';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'BCPS.Chilliwack.Reception@gov.bc.ca' FROM courts WHERE name = 'Chilliwack';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'Chilliwack.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Chilliwack';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_cw@bccourts.ca' FROM courts WHERE name = 'Chilliwack';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', '[Fax Filing: 604-795-8397]' FROM courts WHERE name = 'Chilliwack';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'criminal_registry', 'CSBChilliwackCriminalRegistry@gov.bc.ca' FROM courts WHERE name = 'Chilliwack';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'bail_crown', 'Chilliwack.VirtualBail@gov.bc.ca' FROM courts WHERE name = 'Chilliwack';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'bail_jcm', 'Abbotsford.VirtualHybridBail@provincialcourt.bc.ca' FROM courts WHERE name = 'Chilliwack';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'BCPS.KamloopsGen@gov.bc.ca' FROM courts WHERE name = 'Kamloops';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'Kamloops.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Kamloops';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_ka@bccourts.ca' FROM courts WHERE name = 'Kamloops';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'KamloopsCourtRegistry@gov.bc.ca' FROM courts WHERE name = 'Kamloops';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'KelownaCrown@gov.bc.ca' FROM courts WHERE name = 'Kelowna';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'Kelowna.CriminalScheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Kelowna';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_ok@bccourts.ca' FROM courts WHERE name = 'Kelowna';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'KelownaCourtRegistry@gov.bc.ca' FROM courts WHERE name = 'Kelowna';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'criminal_registry', 'CSB.KelownaCriminal@gov.bc.ca' FROM courts WHERE name = 'Kelowna';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'BCPS.VernonGen@gov.bc.ca' FROM courts WHERE name = 'Vernon';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'Vernon.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Vernon';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_ok@bccourts.ca' FROM courts WHERE name = 'Vernon';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'VernonRegistry@gov.bc.ca' FROM courts WHERE name = 'Vernon';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'criminal_registry', 'JAGCSBVernonScheduling@gov.bc.ca' FROM courts WHERE name = 'Vernon';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'BCPS.PentictonGen@gov.bc.ca' FROM courts WHERE name = 'Penticton';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'Penticton.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Penticton';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_ok@bccourts.ca' FROM courts WHERE name = 'Penticton';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'PentictonCourtRegistry@gov.bc.ca' FROM courts WHERE name = 'Penticton';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'BCPS.SalmonArmGen@gov.bc.ca' FROM courts WHERE name = 'Salmon Arm';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'SalmonArm.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Salmon Arm';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_ka@bccourts.ca' FROM courts WHERE name = 'Salmon Arm';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'SalmonArmRegistry@gov.bc.ca' FROM courts WHERE name = 'Salmon Arm';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'criminal_registry', 'JAGCSBSalmonArmScheduling@gov.bc.ca' FROM courts WHERE name = 'Salmon Arm';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'BCPS.NelsonGen@gov.bc.ca' FROM courts WHERE name = 'Nelson';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'WKootenays.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Nelson';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_ka@bccourts.ca' FROM courts WHERE name = 'Nelson';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'NelsonCourtRegistry@gov.bc.ca' FROM courts WHERE name = 'Nelson';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'BCPS.NelsonGen@gov.bc.ca' FROM courts WHERE name = 'Rossland';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'WKootenays.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Rossland';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_ka@bccourts.ca' FROM courts WHERE name = 'Rossland';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'VCRosslandCrt@gov.bc.ca' FROM courts WHERE name = 'Rossland';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'BCPS.CranbrookGen@gov.bc.ca' FROM courts WHERE name = 'Cranbrook';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'EKootenays.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Cranbrook';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_ka@bccourts.ca' FROM courts WHERE name = 'Cranbrook';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'cranbrookcourtregistry@gov.bc.ca' FROM courts WHERE name = 'Cranbrook';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'BCPS.CranbrookGen@gov.bc.ca' FROM courts WHERE name = 'Golden';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'EKootenays.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Golden';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_ka@bccourts.ca' FROM courts WHERE name = 'Golden';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'GoldenCourtRegistry@gov.bc.ca' FROM courts WHERE name = 'Golden';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'PrGeorge.crown@gov.bc.ca' FROM courts WHERE name = 'Prince George';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'PG.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Prince George';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_pg@bccourts.ca' FROM courts WHERE name = 'Prince George';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', '[Fax Filing: 250-614-7923]' FROM courts WHERE name = 'Prince George';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'criminal_registry', 'csbpg.criminalregistry@gov.bc.ca' FROM courts WHERE name = 'Prince George';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'Quesnel.Crown@gov.bc.ca' FROM courts WHERE name = 'Quesnel';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'Cariboo.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Quesnel';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_pg@bccourts.ca' FROM courts WHERE name = 'Quesnel';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'Office15230@gov.bc.ca' FROM courts WHERE name = 'Quesnel';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'WilliamsLake.Crown@gov.bc.ca' FROM courts WHERE name = 'Williams Lake';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'Cariboo.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Williams Lake';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_pg@bccourts.ca' FROM courts WHERE name = 'Williams Lake';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'Office15231@gov.bc.ca' FROM courts WHERE name = 'Williams Lake';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'Smithers.Crown@gov.bc.ca' FROM courts WHERE name = 'Smithers';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'Smithers.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Smithers';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_pg@bccourts.ca' FROM courts WHERE name = 'Smithers';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'Office15224@gov.bc.ca' FROM courts WHERE name = 'Smithers';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'Terrace.Crown@gov.bc.ca' FROM courts WHERE name = 'Terrace';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'Terrace.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Terrace';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_pg@bccourts.ca' FROM courts WHERE name = 'Terrace';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'Office15222@gov.bc.ca' FROM courts WHERE name = 'Terrace';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'PrinceRupert.Crown@gov.bc.ca' FROM courts WHERE name = 'Prince Rupert';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'PrinceRupert.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Prince Rupert';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_pg@bccourts.ca' FROM courts WHERE name = 'Prince Rupert';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'Office15220@gov.bc.ca' FROM courts WHERE name = 'Prince Rupert';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'Smithers.Crown@gov.bc.ca' FROM courts WHERE name = 'Burns Lake';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'Smithers.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Burns Lake';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'Office15219@gov.bc.ca' FROM courts WHERE name = 'Burns Lake';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'FortNelson.Crown@gov.bc.ca' FROM courts WHERE name = 'Fort Nelson';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'Terrace.CriminalScheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Fort Nelson';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'Office15229@gov.bc.ca' FROM courts WHERE name = 'Fort Nelson';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'FtStJohn.Crown@gov.bc.ca' FROM courts WHERE name = 'Fort St. John';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'PeaceDistrict.CriminalScheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Fort St. John';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_pg@BCCourts.ca' FROM courts WHERE name = 'Fort St. John';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'Office15228@gov.bc.ca' FROM courts WHERE name = 'Fort St. John';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'DawsonCreek.CrownCounsel@gov.bc.ca' FROM courts WHERE name = 'Dawson Creek';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'PeaceDistrict.CriminalScheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Dawson Creek';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'supreme_scheduling', 'sc.scheduling_pg@bccourts.ca' FROM courts WHERE name = 'Dawson Creek';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'office15226@gov.bc.ca' FROM courts WHERE name = 'Dawson Creek';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'PrGeorge.crown@gov.bc.ca' FROM courts WHERE name = 'Valemount';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'PG.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Valemount';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'Office15215@gov.bc.ca' FROM courts WHERE name = 'Valemount';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'BCPS.SalmonArmGen@gov.bc.ca' FROM courts WHERE name = 'Revelstoke';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'sc.scheduling_ka@bccourts.ca' FROM courts WHERE name = 'Revelstoke';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'WilliamsLake.Crown@gov.bc.ca' FROM courts WHERE name = '100 Mile House';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'Cariboo.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = '100 Mile House';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'court_registry', 'Office15231@gov.bc.ca' FROM courts WHERE name = '100 Mile House';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'crown', 'Vanderhoof.Crown@gov.bc.ca' FROM courts WHERE name = 'Vanderhoof';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'jcm_scheduling', 'PG.Scheduling@provincialcourt.bc.ca' FROM courts WHERE name = 'Vanderhoof';
INSERT INTO court_contacts (court_id, contact_type, email)
SELECT id, 'criminal_registry', 'csbpg.criminalregistry@gov.bc.ca' FROM courts WHERE name = 'Vanderhoof';


-- ============================================================
-- VIEWS
-- ============================================================

CREATE OR REPLACE VIEW courts_full AS
SELECT 
    c.*,
    r.code as region_code,
    r.name as region_name,
    (SELECT email FROM court_contacts WHERE court_id = c.id AND contact_type = 'crown') as crown_email,
    (SELECT email FROM court_contacts WHERE court_id = c.id AND contact_type = 'jcm_scheduling') as jcm_scheduling_email,
    (SELECT email FROM court_contacts WHERE court_id = c.id AND contact_type = 'supreme_scheduling') as supreme_scheduling_email,
    (SELECT email FROM court_contacts WHERE court_id = c.id AND contact_type = 'court_registry') as court_registry_email,
    (SELECT email FROM court_contacts WHERE court_id = c.id AND contact_type = 'criminal_registry') as criminal_registry_email,
    (SELECT email FROM court_contacts WHERE court_id = c.id AND contact_type = 'bail_crown') as bail_crown_email,
    (SELECT email FROM court_contacts WHERE court_id = c.id AND contact_type = 'bail_jcm') as bail_jcm_email,
    (SELECT email FROM court_contacts WHERE court_id = c.id AND contact_type = 'interpreter') as interpreter_email
FROM courts c
LEFT JOIN regions r ON c.region_id = r.id
ORDER BY r.code, c.name;

CREATE OR REPLACE VIEW staffed_courts AS SELECT * FROM courts_full WHERE is_staffed = TRUE;
CREATE OR REPLACE VIEW circuit_courts_view AS SELECT * FROM courts_full WHERE is_circuit = TRUE;
CREATE OR REPLACE VIEW provincial_courts AS SELECT * FROM courts_full WHERE has_provincial = TRUE;
CREATE OR REPLACE VIEW supreme_courts AS SELECT * FROM courts_full WHERE has_supreme = TRUE;

-- ============================================================
-- INDEXES
-- ============================================================
CREATE INDEX idx_courts_region ON courts(region_id);
CREATE INDEX idx_courts_provincial ON courts(has_provincial);
CREATE INDEX idx_courts_supreme ON courts(has_supreme);
CREATE INDEX idx_courts_circuit ON courts(is_circuit);
CREATE INDEX idx_court_contacts_court ON court_contacts(court_id);

-- ============================================================
-- VERIFY
-- ============================================================
SELECT 'Total Courts' as metric, COUNT(*) as count FROM courts
UNION ALL SELECT 'Staffed', COUNT(*) FROM courts WHERE is_staffed = TRUE
UNION ALL SELECT 'Circuit', COUNT(*) FROM courts WHERE is_circuit = TRUE
UNION ALL SELECT 'Has Provincial', COUNT(*) FROM courts WHERE has_provincial = TRUE
UNION ALL SELECT 'Has Supreme', COUNT(*) FROM courts WHERE has_supreme = TRUE
UNION ALL SELECT 'Has Supreme Filing Only', COUNT(*) FROM courts WHERE has_supreme_filing = TRUE AND has_supreme = FALSE;
