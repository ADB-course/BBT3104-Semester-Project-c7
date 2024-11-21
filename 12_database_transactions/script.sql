-- Write your SQL code here

-- Transaction 1: Schedule a preventive maintenance


START TRANSACTION;


SELECT e.equipmentID, e.lifespan, e.status, 
       f.downtimeDate, f.duration
FROM Equipment e
LEFT JOIN Finance_Record f ON e.equipmentID = f.equipmentID
WHERE (e.lifespan - DATEDIFF(CURRENT_DATE, e.purchaseDate)) < (5*365) -- Within 5 year of expected lifespan
   OR f.downtimeDate >= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH) -- Downtime within the last 6 months
ORDER BY e.lifespan ASC, f.downtimeDate DESC;

INSERT INTO Maintenance (SessionID, equipmentID, scheduleDate)
VALUES (<new_session_id>, <equipment_id_here>, <schedule_date>);

INSERT INTO Preventive (maintenanceID, scheduledDate, actualDate)
VALUES (<new_session_id>, <schedule_date>, NULL);

UPDATE Equipment
SET status = 'Scheduled For Maintenance'
WHERE equipmentID = <equipment_id_here>;

COMMIT;


-- Transaction 2: Update Equipment Status


START TRANSACTION;

SELECT e.equipmentID, e.lifespan, e.purchaseDate, e.status, 
       COUNT(m.SessionID) AS maintenance_count,
       DATEDIFF(CURRENT_DATE, e.purchaseDate) AS days_in_use
FROM Equipment e
LEFT JOIN Maintenance m ON e.equipmentID = m.equipmentID
GROUP BY e.equipmentID
HAVING (DATEDIFF(CURRENT_DATE, e.purchaseDate) > e.lifespan) -- Exceeded expected lifespan
   OR (COUNT(m.SessionID) > 4) -- More than 4 maintenance sessions
;

UPDATE Equipment
SET status = 'Needs Replacement'
WHERE equipmentID IN (
  SELECT equipmentID
  FROM (
    SELECT e.equipmentID, e.lifespan, e.purchaseDate, e.status, 
           COUNT(m.SessionID) AS maintenance_count,
           DATEDIFF(CURRENT_DATE, e.purchaseDate) AS days_in_use
    FROM Equipment e
    LEFT JOIN Maintenance m ON e.equipmentID = m.equipmentID
    GROUP BY e.equipmentID
    HAVING (DATEDIFF(CURRENT_DATE, e.purchaseDate) > e.lifespan)
       OR (COUNT(m.SessionID) > 4)
  ) AS subquery
);

COMMIT
