-- Equipment Table (5 rows)
INSERT INTO Equipment (equipmentID, manufacturer, purchaseDate, lifespan, status) VALUES 
('EQ001', 'Krauss-Maffei', '2020-03-15', '10 years', 'Operational'),
('EQ002', 'Engel', '2019-11-22', '12 years', 'Scheduled for maintenance'),
('EQ003', 'Battenfeld', '2018-06-10', '15 years', 'Operational'),
('EQ004', 'Cincinnati', '2021-01-30', '8 years', 'Not operational'),
('EQ005', 'Sumitomo', '2017-09-05', '10 years', 'Operational');

-- Maintenance Table
INSERT INTO Maintenance (sessionID, equipmentID, scheduledDate, actualDate) VALUES 
('M001', 'EQ001', '2024-02-15 09:00:00', '2024-02-15 10:30:00'),
('M002', 'EQ002', '2024-03-20 14:00:00', NULL),
('M003', 'EQ003', '2024-01-10 11:00:00', '2024-01-10 12:15:00'),
('M004', 'EQ004', '2024-04-05 10:00:00', NULL),
('M005', 'EQ005', '2024-02-28 13:00:00', '2024-02-28 14:45:00');

-- Spare Parts Table
INSERT INTO SpareParts (partID, partName, manufacturer, quantity, partCost, equipmentID) VALUES 
('SP001', 'Injection Screw', 'Krauss-Maffei', 5, 1250.50, 'EQ001'),
('SP002', 'Heating Element', 'Engel', 8, 750.25, 'EQ002'),
('SP003', 'Mold Clamp', 'Battenfeld', 3, 2500.75, 'EQ003'),
('SP004', 'Control Board', 'Cincinnati', 2, 1800.00, 'EQ004'),
('SP005', 'Hydraulic Pump', 'Sumitomo', 4, 3200.50, 'EQ005');

-- Downtime Table
INSERT INTO Downtime (equipmentID, duration, failureDescription) VALUES 
('EQ001', '02:30:00', 'Hydraulic system pressure drop'),
('EQ002', '01:45:00', 'Temperature control malfunction'),
('EQ003', '03:15:00', 'Mold alignment issue'),
('EQ004', '04:00:00', 'Complete electrical system failure'),
('EQ005', '01:20:00', 'Lubrication system blockage');

-- Finance Record Table
INSERT INTO FinanceRecord (recordID, downtimeID, maintenanceCost, downtimeCost) VALUES 
('FR001', 1, 1500.50, 3200.75),
('FR002', 2, 1200.25, 2750.60),
('FR003', 3, 1800.75, 4100.25),
('FR004', 4, 2500.00, 5600.50),
('FR005', 5, 1000.50, 2300.75);