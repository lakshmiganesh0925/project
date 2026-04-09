

DROP TABLE IF EXISTS booking_commercials;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS users;


--- TABLE users ----

CREATE TABLE users(
    user_id VARCHAR(50) PRIMARY KEY;
    name VARCHAR(100) NOT NULL;
    phone_number VARCHAR(20),
    mail_id VARCHAR(100),
    billing_address TEXT
);


--- TABLE ITEMS ---

CREATE TABLE items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    item_rate DECIMAL(10,2) NOT NULL
);

--- TABLE BOOKINGS ---

CREATE TABLE bookings(
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME NOT NULL,
    room_no VARCHAR(50) NOT NULL,
    user_id VARCHAR(50) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


--- TABLE booking_commercials ---

CREATE TABLE booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50) NOT NULL,
    bill_id VARCHAR(50) NOT NULL,
    bill_date DATETIME NOT NULL,
    item_id VARCHAR(50) NOT NULL,
    item_quantity DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

--- SAMPLE DATA ---



INSERT INTO users (user_id, name, phone_number, mail_id, billing_address) VALUES
('21wrcxuy-67erfn', 'John Doe',   '9700000001', 'john.doe@example.com',   '10, Street A, Mumbai'),
('u2-abcdef-00002', 'Jane Smith', '9700000002', 'jane.smith@example.com', '22, Street B, Delhi'),
('u3-abcdef-00003', 'Raj Kumar',  '9700000003', 'raj.kumar@example.com',  '33, Street C, Pune'),
('u4-abcdef-00004', 'Priya Nair', '9700000004', 'priya.nair@example.com', '44, Street D, Chennai'),
('u5-abcdef-00005', 'Amit Shah',  '9700000005', 'amit.shah@example.com',  '55, Street E, Bangalore');
 
INSERT INTO items (item_id, item_name, item_rate) VALUES
('itm-a9e8-q8fu',  'Tawa Paratha',    18.00),
('itm-a07vh-aer8', 'Mix Veg',         89.00),
('itm-w978-23u4',  'Paneer Butter',  145.00),
('itm-x001-bbq1',  'Dal Tadka',       75.00),
('itm-x002-bbq2',  'Butter Chicken', 180.00),
('itm-x003-bbq3',  'Naan',            30.00),
('itm-x004-bbq4',  'Jeera Rice',      60.00),
('itm-x005-bbq5',  'Cold Coffee',     85.00);
 
INSERT INTO bookings (booking_id, booking_date, room_no, user_id) VALUES
('bk-09f3e-95hj',  '2021-09-23 07:36:48', 'rm-bhf9-aerjn', '21wrcxuy-67erfn'),
('bk-q034-q4o',    '2021-09-23 07:40:00', 'rm-cc01-xyz01', 'u2-abcdef-00002'),
('bk-oct1-0001',   '2021-10-05 09:00:00', 'rm-dd02-xyz02', 'u3-abcdef-00003'),
('bk-oct2-0002',   '2021-10-18 14:00:00', 'rm-ee03-xyz03', 'u4-abcdef-00004'),
('bk-nov1-0001',   '2021-11-02 08:00:00', 'rm-ff04-xyz04', 'u5-abcdef-00005'),
('bk-nov2-0002',   '2021-11-15 10:00:00', 'rm-gg05-xyz05', '21wrcxuy-67erfn'),
('bk-nov3-0003',   '2021-11-28 11:00:00', 'rm-hh06-xyz06', 'u2-abcdef-00002'),
('bk-dec1-0001',   '2021-12-10 09:30:00', 'rm-ii07-xyz07', 'u3-abcdef-00003'),
('bk-dec2-0002',   '2021-12-20 13:00:00', 'rm-jj08-xyz08', '21wrcxuy-67erfn');
 
INSERT INTO booking_commercials (id, booking_id, bill_id, bill_date, item_id, item_quantity) VALUES
-- September bills
('bc-001', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a9e8-q8fu',  3),
('bc-002', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a07vh-aer8', 1),
('bc-003', 'bk-q034-q4o',   'bl-34qhd-r7h8', '2021-09-23 12:05:37', 'itm-w978-23u4',  0.5),
('bc-004', 'bk-q034-q4o',   'bl-34qhd-r7h8', '2021-09-23 12:05:37', 'itm-x001-bbq1',  2),
-- October bills
('bc-005', 'bk-oct1-0001',  'bl-oct1-b001',  '2021-10-05 13:00:00', 'itm-x002-bbq2',  4),
('bc-006', 'bk-oct1-0001',  'bl-oct1-b001',  '2021-10-05 13:00:00', 'itm-x003-bbq3',  6),
('bc-007', 'bk-oct2-0002',  'bl-oct2-b002',  '2021-10-18 15:00:00', 'itm-x004-bbq4',  3),
('bc-008', 'bk-oct2-0002',  'bl-oct2-b002',  '2021-10-18 15:00:00', 'itm-x005-bbq5',  2),
('bc-009', 'bk-oct2-0002',  'bl-oct2-b002',  '2021-10-18 15:00:00', 'itm-a9e8-q8fu',  5),
-- November bills
('bc-010', 'bk-nov1-0001',  'bl-nov1-b001',  '2021-11-02 09:00:00', 'itm-x002-bbq2',  2),
('bc-011', 'bk-nov1-0001',  'bl-nov1-b001',  '2021-11-02 09:00:00', 'itm-x003-bbq3',  4),
('bc-012', 'bk-nov2-0002',  'bl-nov2-b002',  '2021-11-15 11:00:00', 'itm-a07vh-aer8', 3),
('bc-013', 'bk-nov2-0002',  'bl-nov2-b002',  '2021-11-15 11:00:00', 'itm-w978-23u4',  2),
('bc-014', 'bk-nov3-0003',  'bl-nov3-b003',  '2021-11-28 12:00:00', 'itm-x004-bbq4',  5),
('bc-015', 'bk-nov3-0003',  'bl-nov3-b003',  '2021-11-28 12:00:00', 'itm-x001-bbq1',  4),
-- December bills
('bc-016', 'bk-dec1-0001',  'bl-dec1-b001',  '2021-12-10 10:00:00', 'itm-x002-bbq2',  3),
('bc-017', 'bk-dec1-0001',  'bl-dec1-b001',  '2021-12-10 10:00:00', 'itm-x005-bbq5',  2),
('bc-018', 'bk-dec2-0002',  'bl-dec2-b002',  '2021-12-20 14:00:00', 'itm-a07vh-aer8', 6),
('bc-019', 'bk-dec2-0002',  'bl-dec2-b002',  '2021-12-20 14:00:00', 'itm-x003-bbq3',  8);
 