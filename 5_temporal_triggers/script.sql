-- Write your SQL code here

Daily Maintenance Trigger
CREATE EVENT daily_schedule_maintenance
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    INSERT INTO Maintenance (sessionID, equipmentID, scheduledDate, status)
    SELECT CONCAT('M', equipmentID), equipmentID, CURRENT_DATE, 'Pending'
    FROM Equipment
    WHERE status = 'Operational' AND TIMESTAMPDIFF(DAY, purchaseDate, CURRENT_DATE) % 30 = 0;
END;
Monthly cost Trigger
CREATE EVENT monthly_cost_report
ON SCHEDULE EVERY 1 MONTH
DO
BEGIN
    INSERT INTO MonthlyReports (reportDate, totalMaintenanceCost, totalDowntimeCost)
    SELECT CURRENT_DATE, SUM(maintenanceCost), SUM(downtimeCost)
    FROM FinanceRecord;
END;
