-- Write your SQL code here


-------------------------------------------- Table Creation Without Check Conctraints--------------------------------------------

-- Finance Record table
CREATE TABLE Finance_Record (
    recordID VARCHAR(50),
    downtimeID VARCHAR(50),
    downtimeCost DECIMAL(10,2),
    repairCost DECIMAL(10,2)
) ENGINE=InnoDB;


-- Production section table
CREATE TABLE Production_section (
    sectionID VARCHAR(50),
    sectionName VARCHAR(100),
    expectedOutput DECIMAL(10,2)
) ENGINE=InnoDB;


-- Equipment table
CREATE TABLE Equipment (
    equipmentID VARCHAR(50),
    manufacturer VARCHAR(100),
    purchaseDate DATE,
    lifespan INT,
    status VARCHAR(50)
) ENGINE=InnoDB;


-- Maintenance table
CREATE TABLE Maintenance (
    SessionID VARCHAR(50),
    equipmentID VARCHAR(50),
    scheduleDate DATE,
    actualDate DATE
) ENGINE=InnoDB;


-- Spare Parts Cost table
CREATE TABLE Spare_Parts_Cost (
    partID VARCHAR(50),
    equipmentID VARCHAR(50),
    SpareName VARCHAR(100),
    StockNumber INT,
    partCost DECIMAL(10,2)
) ENGINE=InnoDB;


-- Downtime table
CREATE TABLE Downtime (
    downtimeID VARCHAR(50),
    equipmentID VARCHAR(50),
    downtimeDate DATE,
    duration DECIMAL(10,2),
    description TEXT
) ENGINE=InnoDB;


-- Production section downtime table
CREATE TABLE Production_section_downtime (
    sectionID VARCHAR(50),
    downtimeID VARCHAR(50),
    downtimeOutput DECIMAL(10,2)
) ENGINE=InnoDB;
