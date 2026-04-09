
DROP TABLE IF EXISTS clinic_sales;
DROP TABLE IF EXISTS expenses;
DROP TABLE IF EXISTS clinics;
DROP TABLE IF EXISTS customer;

--- TABLE: clinics ---

CREATE TABLE clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    country VARCHAR(100) NOT NULL
);

--- TABLE : customer ---

CREATE TABLE customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    mobile VARCHAR(20)
);

--- TABLE: clinic_sales ---

CREATE TABLE clinic_sales (
 oid VARCHAR(50) PRIMARY KEY,
 uid VARCHAR(50) NOT NULL,
 cid VARCHAR(50) NOT NULL,
 amount DECIMAL(12,2) NOT NULL,
 datetime DATETIME NOT NULL,
 sales_channel VARCHAR(50) NOT NULL,
 FOREIGN KEY (uid) REFERENCES customer(uid),
 FOREIGN KEY (cid) REFERENCES clinics(cid)
);

--- TABLE: EXPENSES ---

CREATE TABLE expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50) NOT NULL,
    description VARCHAR(200),
    amount DECIMAL(12,2) NOT NULL,
    datetime DATETIME NOT NULL,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

--- SAMPLE DATA ---

INSERT INTO clinics (cid, clinic_name, city, state, country) VALUES
('cnc-0100001', 'XYZ Clinic',    'Mumbai',    'Maharashtra', 'India'),
('cnc-0100002', 'ABC Health',    'Pune',      'Maharashtra', 'India'),
('cnc-0100003', 'PQR Wellness',  'Delhi',     'Delhi',       'India'),
('cnc-0100004', 'LMN Care',      'Noida',     'UP',          'India'),
('cnc-0100005', 'EFG MedCenter', 'Chennai',   'Tamil Nadu',  'India'),
('cnc-0100006', 'UVW Clinic',    'Bangalore', 'Karnataka',   'India');
 
INSERT INTO customer (uid, name, mobile) VALUES
('cust-001', 'Jon Doe',    '9700000001'),
('cust-002', 'Anita Rao',  '9700000002'),
('cust-003', 'Ravi Kumar', '9700000003'),
('cust-004', 'Sita Patel', '9700000004'),
('cust-005', 'Mohan Lal',  '9700000005');
 
INSERT INTO clinic_sales (oid, uid, cid, amount, datetime, sales_channel) VALUES
-- Jan 2021
('ord-001', 'cust-001', 'cnc-0100001', 24999, '2021-01-05 10:00:00', 'online'),
('ord-002', 'cust-002', 'cnc-0100001', 15000, '2021-01-12 11:00:00', 'walk-in'),
('ord-003', 'cust-003', 'cnc-0100002', 8000,  '2021-01-15 09:30:00', 'online'),
('ord-004', 'cust-004', 'cnc-0100003', 32000, '2021-01-20 14:00:00', 'referral'),
('ord-005', 'cust-005', 'cnc-0100004', 5000,  '2021-01-25 16:00:00', 'walk-in'),
-- Feb 2021
('ord-006', 'cust-001', 'cnc-0100001', 18000, '2021-02-03 10:00:00', 'online'),
('ord-007', 'cust-002', 'cnc-0100002', 12000, '2021-02-10 12:00:00', 'referral'),
('ord-008', 'cust-003', 'cnc-0100003', 9500,  '2021-02-14 15:00:00', 'walk-in'),
('ord-009', 'cust-004', 'cnc-0100004', 22000, '2021-02-18 09:00:00', 'online'),
('ord-010', 'cust-005', 'cnc-0100005', 7500,  '2021-02-22 11:00:00', 'referral'),
-- Mar 2021
('ord-011', 'cust-001', 'cnc-0100002', 30000, '2021-03-05 13:00:00', 'online'),
('ord-012', 'cust-002', 'cnc-0100003', 11000, '2021-03-12 10:00:00', 'walk-in'),
('ord-013', 'cust-003', 'cnc-0100004', 16000, '2021-03-18 14:00:00', 'referral'),
('ord-014', 'cust-004', 'cnc-0100005', 9000,  '2021-03-22 09:30:00', 'online'),
('ord-015', 'cust-005', 'cnc-0100006', 25000, '2021-03-28 16:00:00', 'walk-in'),
-- Sep 2021 (matching the schema sample)
('ord-016', 'cust-001', 'cnc-0100001', 24999, '2021-09-23 12:03:22', 'sodat'),
('ord-017', 'cust-002', 'cnc-0100001', 19000, '2021-09-25 10:00:00', 'online'),
('ord-018', 'cust-003', 'cnc-0100002', 14500, '2021-09-27 11:00:00', 'walk-in');
 
INSERT INTO expenses (eid, cid, description, amount, datetime) VALUES
-- Jan 2021
('exp-001', 'cnc-0100001', 'first-aid supplies',  557,   '2021-01-05 07:36:48'),
('exp-002', 'cnc-0100001', 'staff salary',         25000, '2021-01-31 09:00:00'),
('exp-003', 'cnc-0100002', 'rent',                 8000,  '2021-01-01 09:00:00'),
('exp-004', 'cnc-0100003', 'equipment maintenance',3500,  '2021-01-10 10:00:00'),
('exp-005', 'cnc-0100004', 'utilities',            2000,  '2021-01-15 09:00:00'),
-- Feb 2021
('exp-006', 'cnc-0100001', 'staff salary',         25000, '2021-02-28 09:00:00'),
('exp-007', 'cnc-0100002', 'rent',                 8000,  '2021-02-01 09:00:00'),
('exp-008', 'cnc-0100003', 'medicines restock',    6000,  '2021-02-12 11:00:00'),
('exp-009', 'cnc-0100004', 'utilities',            1800,  '2021-02-18 09:00:00'),
('exp-010', 'cnc-0100005', 'admin expenses',       3000,  '2021-02-20 10:00:00'),
-- Mar 2021
('exp-011', 'cnc-0100001', 'staff salary',         25000, '2021-03-31 09:00:00'),
('exp-012', 'cnc-0100002', 'rent',                 8000,  '2021-03-01 09:00:00'),
('exp-013', 'cnc-0100003', 'equipment purchase',   15000, '2021-03-05 09:00:00'),
('exp-014', 'cnc-0100004', 'utilities',            2100,  '2021-03-15 09:00:00'),
('exp-015', 'cnc-0100005', 'admin expenses',       2500,  '2021-03-25 10:00:00'),
('exp-016', 'cnc-0100006', 'rent',                 12000, '2021-03-01 09:00:00'),
-- Sep 2021
('exp-017', 'cnc-0100001', 'first-aid supplies',   557,   '2021-09-23 07:36:48'),
('exp-018', 'cnc-0100001', 'staff salary',          25000, '2021-09-30 09:00:00'),
('exp-019', 'cnc-0100002', 'rent',                  8000,  '2021-09-01 09:00:00');


