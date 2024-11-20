-- Write your SQL code here
DELIMITER $$

CREATE TRIGGER before_insert_maintenance
BEFORE INSERT ON Maintenance
FOR EACH ROW
BEGIN
    DECLARE weekday INT;

    -- Get the day of the week for the scheduleDate (1 = Sunday, 7 = Saturday)
    SET weekday = DAYOFWEEK(NEW.scheduleDate);

    -- If the day is between Monday (2) and Saturday (7), adjust to the following Monday
    IF weekday BETWEEN 2 AND 7 THEN
        SET NEW.scheduleDate = DATE_ADD(NEW.scheduleDate, INTERVAL (9 - weekday) DAY);
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER after_update_equipment_status
AFTER UPDATE ON Equipment
FOR EACH ROW
BEGIN
    -- Check if the status changed to "Not Operational"
    IF NEW.status = 'Not Operational' AND OLD.status != 'Not Operational' THEN
        -- Insert a new record into the Downtime table
        INSERT INTO Downtime (downtimeID, equipmentID, downtimeDate, duration, description)
        VALUES (
            UUID(), -- Generate a unique downtimeID
            NEW.equipmentID,
            NOW(), -- Log the current time as the downtime start date
            NULL,  -- Duration will be updated later when the equipment becomes operational
            'Equipment status changed to Not Operational'
        );
    END IF;

    -- Check if the status changed to a value other than "Not Operational"
    IF NEW.status != 'Not Operational' AND OLD.status = 'Not Operational' THEN
        -- Update the corresponding downtime record with the duration
        UPDATE Downtime
        SET duration = TIMESTAMPDIFF(HOUR, downtimeDate, NOW()) / 24, -- Compute downtime in days
            description = CONCAT(description, '; Downtime resolved on ', NOW())
        WHERE equipmentID = NEW.equipmentID
          AND duration IS NULL; -- Ensure we only update unresolved downtimes
    END IF;
END$$

DELIMITER ;
