-- Write your SQL code here


----------------- A Procedure to calculate and compare cumulative repair costs vs replacement costs for equipment -----------
DELIMITER $$
CREATE PROCEDURE PROC_GenerateCostBenefitReport(IN equipmentID VARCHAR(50), IN lifespan INT, OUT recommendation VARCHAR(100))
BEGIN
    DECLARE cumulativeRepairCost DECIMAL(10,2);
    DECLARE replacementCost DECIMAL(10,2);
    
    -- cumulative repair cost for the equipment
    SELECT SUM(repairCost) INTO cumulativeRepairCost 
    FROM Finance_Record fr
    JOIN Downtime dt ON fr.downtimeID = dt.downtimeID
    WHERE dt.equipmentID = equipmentID;

    
    SET replacementCost = 10000; 
    
    -- Compare costs and provide recommendation
    IF cumulativeRepairCost < replacementCost THEN
        SET recommendation = 'Repair';
    ELSE
        SET recommendation = 'Replace';
    END IF;
    
    -- Output the recommendation
    SELECT equipmentID, cumulativeRepairCost, replacementCost, recommendation;
END$$
DELIMITER ;

DELIMITER //


---------------- A Procedure to generate a report of upcoming maintenance for equipment  ----------------
DELIMITER $$
CREATE PROCEDURE PROC_GenerateUpcomingMaintenanceReport()
BEGIN
    -- Retrieve equipment due for maintenance in the next 30 days or overdue
    SELECT m.equipmentID, e.manufacturer, e.status, m.scheduleDate, m.actualDate,
           CASE 
               WHEN m.actualDate IS NULL THEN DATEDIFF(m.scheduleDate, CURDATE())
               ELSE NULL
           END AS DaysUntilMaintenance,
           CASE
               WHEN m.scheduleDate < CURDATE() AND m.actualDate IS NULL THEN 'Overdue'
               ELSE 'Upcoming'
           END AS MaintenanceStatus
    FROM Maintenance m
    JOIN Equipment e ON m.equipmentID = e.equipmentID
    WHERE (m.scheduleDate BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY))
       OR (m.scheduleDate < CURDATE() AND m.actualDate IS NULL);
END$$
DELIMITER ;

