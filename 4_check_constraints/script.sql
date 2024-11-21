-- Write your SQL code here
------------- Equipment Table ----------------
CREATE TABLE Equipment (
    equipmentID VARCHAR(25) PRIMARY KEY,
    manufacturer VARCHAR(50),
    purchaseDate DATE CHECK (purchaseDate <= CURRENT_DATE)    lifespan VARCHAR(50),
    status CHAR(20) CHECK (status IN ('Operational', 'Not operational', 'Scheduled for maintenance', 'Decommissioned')) 
) ENGINE=InnoDB; 
CREATE INDEX idx_status ON Equipment(status);

---------------- Maintenance table ----------------
CREATE TABLE Maintenance (
    sessionID VARCHAR(25) PRIMARY KEY, 
    equipmentID VARCHAR(25),
    scheduledDate TIMESTAMP CHECK (scheduledDate >= CURRENT_TIMESTAMP),     actualDate TIMESTAMP,
    FOREIGN KEY (equipmentID) REFERENCES Equipment(equipmentID)
) ENGINE=InnoDB;
CREATE INDEX idx_equipment ON Maintenance(equipmentID);

---------------- Spare Parts Table ----------------
CREATE TABLE SpareParts (
    partID VARCHAR(25) PRIMARY KEY, 
    partName VARCHAR(50),
    manufacturer VARCHAR(50),
    quantity INT UNSIGNED CHECK (quantity >= 0),
    partCost DECIMAL(10, 2) CHECK (partCost > 0), 
    equipmentID VARCHAR(25),
    FOREIGN KEY (equipmentID) REFERENCES Equipment(equipmentID)
) ENGINE=MyISAM;
CREATE INDEX idx_manufacturer ON SpareParts(manufacturer);

---------------- Downtime Table ----------------
CREATE TABLE Downtime (
    downtimeID INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    equipmentID VARCHAR(25),
    downtimeDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    duration TIME CHECK (duration > '00:00:00'), 
    failureDescription VARCHAR(100) CHECK (LENGTH(failureDescription) <= 100)
    FOREIGN KEY (equipmentID) REFERENCES Equipment(equipmentID)
) ENGINE=InnoDB;
CREATE INDEX idx_downtime ON Downtime(equipmentID, downtimeDate);

---------------- Finance Records Table ----------------
CREATE TABLE FinanceRecord (
    recordID VARCHAR(25) PRIMARY KEY,
    downtimeID INT,
    maintenanceCost DECIMAL(10, 2) CHECK (maintenanceCost >= 0)
    downtimeCost DECIMAL(10, 2) CHECK (downtimeCost >= 0),
    FOREIGN KEY (downtimeID) REFERENCES Downtime(downtimeID)
) ENGINE=InnoDB;
CREATE INDEX idx_downtime_id ON FinanceRecord(downtimeID);


