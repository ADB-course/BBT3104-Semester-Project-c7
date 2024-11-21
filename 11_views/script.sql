-- Write your SQL code here

------------- View 1: Maintenance History ----------------
CREATE VIEW maintenance_history AS
SELECT
    m.SessionID,
    m.equipmentID,
    m.scheduleDate,
    m.actualDate,
    f.downtimeID,
    f.downtimeDate,
    f.duration,
    f.description,
    s.SpareName,
    s.StockNumber,
    s.partCost
FROM Maintenance m
JOIN Finance_Record f ON m.equipmentID = f.equipmentID
JOIN Spare_Parts_Cost s ON f.equipmentID = s.equipmentID


------------- View 2: Equipment cost analysis. ----------------
CREATE VIEW equipment_cost_analysis AS
SELECT
    e.equipmentID,
    e.manufacturer,
    e.purchaseDate,
    e.lifespan,
    e.status,
    SUM(f.downtimeCost) AS total_downtime_cost,
    SUM(f.repairCost) AS total_repair_cost,
    (SUM(f.downtimeCost) + SUM(f.repairCost)) AS total_equipment_cost,
    p.sectionID,
    p.expectedOutput,
    p.downtimeOutput
FROM Equipment e
JOIN Finance_Record f ON e.equipmentID = f.equipmentID
JOIN Production_section p ON f.equipmentID = p.equipmentID
GROUP BY e.equipmentID
