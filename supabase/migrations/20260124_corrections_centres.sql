-- =============================================================================
-- BC CORRECTIONS CENTRES - TABLE AND SEED DATA
-- =============================================================================

-- Create corrections_centres table
CREATE TABLE IF NOT EXISTS corrections_centres (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  short_name TEXT,
  region_id INTEGER NOT NULL REFERENCES regions(id),
  city TEXT NOT NULL,
  address TEXT NOT NULL,
  mailing_address TEXT,
  phone TEXT NOT NULL,
  visit_phone TEXT,
  visit_notes TEXT,
  security_level TEXT DEFAULT 'mixed' CHECK (security_level IN ('secure', 'medium', 'open', 'mixed')),
  is_pretrial BOOLEAN DEFAULT FALSE,
  is_women_only BOOLEAN DEFAULT FALSE,
  gender TEXT DEFAULT 'all' CHECK (gender IN ('men', 'women', 'all')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable RLS
ALTER TABLE corrections_centres ENABLE ROW LEVEL SECURITY;

-- Create policy for public read access
CREATE POLICY "Allow public read access" ON corrections_centres
  FOR SELECT USING (true);

-- Insert seed data for 10 BC Corrections Centres
INSERT INTO corrections_centres (name, short_name, region_id, city, address, mailing_address, phone, visit_phone, visit_notes, security_level, is_pretrial, is_women_only, gender) VALUES

-- Fraser Region (R3)
('Alouette Correctional Centre for Women', 'Alouette', 3, 'Maple Ridge', '24800 Alouette Road, Maple Ridge, BC', 'PO Box 1000, Maple Ridge, BC V2X 7G4', '604-476-2660', '604-476-2660', NULL, 'mixed', false, true, 'women'),

('Ford Mountain Correctional Centre', 'Ford Mountain', 3, 'Chilliwack', '57657 Chilliwack Lake Road, Chilliwack, BC V4Z 1A7', 'P.O. Box 1500, Maple Ridge, BC V2X 7G3', '604-824-5350', '604-824-5373', NULL, 'mixed', false, false, 'men'),

('Fraser Regional Correctional Centre', 'Fraser Regional', 3, 'Maple Ridge', '13777 256th Street, Maple Ridge, BC V2X 0L7', 'PO Box 1500, Maple Ridge, BC V2X 7G3', '604-462-9313', '604-462-8865', 'To book a visit, contact us between 8:00 am and 3:00 pm Monday to Friday.', 'mixed', false, false, 'men'),

('North Fraser Pretrial Centre', 'North Fraser', 3, 'Port Coquitlam', '1451 Kingsway Avenue, Port Coquitlam, BC V3C 1S2', '1451 Kingsway Avenue, Port Coquitlam, BC V3C 1S2', '604-468-3500', '604-468-3566', NULL, 'secure', true, false, 'all'),

('Surrey Pretrial Services Centre', 'Surrey Pretrial', 3, 'Surrey', '14323 57th Avenue, Surrey, BC V3X 1B1', '14323 57th Avenue, Surrey, BC V3X 1B1', '604-599-4110', '604-572-2103', NULL, 'secure', true, false, 'all'),

-- Interior Region (R4)
('Kamloops Regional Correctional Centre', 'Kamloops', 4, 'Kamloops', '2250 W. Trans Canada Highway, Kamloops, BC V2C 5M9', 'PO Box 820, Kamloops, BC V2C 5M9', '250-571-2200', NULL, NULL, 'mixed', false, false, 'all'),

('Okanagan Correctional Centre', 'Okanagan', 4, 'Oliver', '200 Enterprise Way, Oliver, BC V0H 1T2', '200 Enterprise Way, Oliver, BC V0H 1T2', '236-216-2000', '236-216-2000', 'To book a visit, call and press 4.', 'mixed', false, false, 'men'),

-- Island Region (R1)
('Nanaimo Correctional Centre', 'Nanaimo', 1, 'Nanaimo', '3945 Biggs Road, Nanaimo, BC V9R 5N3', 'Bag 4000, Nanaimo, BC V9R 5N3', '250-756-3300', '250-729-7721', 'Visits are only permitted on weekends and must be booked in advance. To book a visit, contact us between 10 am and 12 noon Tuesday, Wednesday and Thursday only.', 'open', false, false, 'men'),

('Vancouver Island Regional Correctional Centre', 'VIRCC', 1, 'Victoria', '4216 Wilkinson Road, Victoria, BC V8Z 5B2', 'P.O. Box 9224 Stn Prov Govt, Victoria, BC V8W 9J1', '250-953-4400', '250-953-4433', NULL, 'mixed', false, false, 'all'),

-- Northern Region (R5)
('Prince George Regional Correctional Centre', 'Prince George', 5, 'Prince George', '795 Highway 16 East, Prince George, BC V2L 5J9', 'PO Box 4300, Prince George, BC V2L 5J9', '250-960-3001', '250-564-0465', NULL, 'mixed', false, false, 'all');

-- Create index for faster queries
CREATE INDEX IF NOT EXISTS idx_corrections_centres_region ON corrections_centres(region_id);
CREATE INDEX IF NOT EXISTS idx_corrections_centres_name ON corrections_centres(name);
