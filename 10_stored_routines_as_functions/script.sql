-- Write your SQL code here

------------- a function to calculate the total downtime cost for a specific equipment within a date range ----------------
DELIMITER $$
CREATE FUNCTION FUNC_CALCULATE_DOWNTIME_COST(equipment_id VARCHAR(50), start_date DATE, end_date DATE) 
RETURNS DECIMAL(10,2) 
DETERMINISTIC
BEGIN
  DECLARE total_downtime_cost DECIMAL(10,2);

  -- Sum up the downtime costs for the specified equipment and date range
  SELECT COALESCE(SUM(f.downtimeCost), 0) INTO total_downtime_cost
  FROM Finance_Record f
  JOIN Downtime d ON f.downtimeID = d.downtimeID
  WHERE d.equipmentID = equipment_id
    AND d.downtimeDate BETWEEN start_date AND end_date;

  RETURN total_downtime_cost;
END$$
DELIMITER ;




---------------  a function to predict the next maintenance date for a specific equipment ---------------
DELIMITER $$
CREATE FUNCTION FUNC_PREDICT_MAINTENANCE_DATE(equipment_id VARCHAR(50)) 
RETURNS DATE 
DETERMINISTIC
BEGIN
  DECLARE avg_days_between_maintenance INT;
  DECLARE last_maintenance_date DATE;
  DECLARE predicted_next_date DATE;

  -- calculate the average days between maintenance sessions for specific equipment
  SELECT COALESCE(AVG(DATEDIFF(m2.scheduleDate, m1.scheduleDate)), 0) INTO avg_days_between_maintenance
  FROM Maintenance m1
  JOIN Maintenance m2 ON m1.equipmentID = m2.equipmentID
  WHERE m1.equipmentID = equipment_id AND m2.scheduleDate > m1.scheduleDate;


  SELECT MAX(scheduleDate) INTO last_maintenance_date -- get the last maintenance date
  FROM Maintenance
  WHERE equipmentID = equipment_id;

  -- predict the next maintenance date using the average interval
  SET predicted_next_date = DATE_ADD(last_maintenance_date, INTERVAL avg_days_between_maintenance DAY);

  RETURN predicted_next_date;
END$$
DELIMITER ;
