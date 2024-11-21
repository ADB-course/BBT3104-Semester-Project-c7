-- Write your SQL code here

CREATE INDEX idx_finance_downtimeID ON Finance_Record(downtimeID);


CREATE INDEX idx_production_sectionName ON Production_section(sectionName);


CREATE INDEX idx_equipment_status ON Equipment(status);
CREATE INDEX idx_equipment_manufacturer ON Equipment(manufacturer);


CREATE INDEX idx_maintenance_equipmentID ON Maintenance(equipmentID);
CREATE INDEX idx_maintenance_scheduleDate ON Maintenance(scheduleDate);
CREATE INDEX idx_maintenance_actualDate ON Maintenance(actualDate);


CREATE INDEX idx_spareparts_equipmentID ON Spare_Parts_Cost(equipmentID);
CREATE INDEX idx_spareparts_sparename ON Spare_Parts_Cost(SpareName);


CREATE INDEX idx_downtime_equipmentID ON Downtime(equipmentID);
CREATE INDEX idx_downtime_date ON Downtime(downtimeDate);


CREATE INDEX idx_prodsection_downtime_sectionID ON Production_section_downtime(sectionID);
CREATE INDEX idx_prodsection_downtime_downtimeID ON Production_section_downtime(downtimeID);
