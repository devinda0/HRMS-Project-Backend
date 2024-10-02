
-- TRIGGER FOR GENERATE EMPLOYEE ID FOR NEWLY ADDED EMPLOYEE
DELIMITER //

CREATE TRIGGER employee_insert
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
	DECLARE next_id INT;
    
    SELECT (COALESCE(MAX(CAST(SUBSTRING(employee_id, 4) AS UNSIGNED)), 0) + 1) INTO next_int
    FROM employee;
    
    SET NEW.employee_id = CONCAT('EMP', LPAD(next_id, 6, '0'));
    
END;
//

DELIMITER ;


-- TRIGGER FOR GENERATE DEPENDANT ID FOR NEWLY ADDED DEPENDANT
DELIMITER //

CREATE TRIGGER dependant_insert
BEFORE INSERT ON dependant
FOR EACH ROW
BEGIN
	DECLARE next_id INT;
    
    SELECT (COALESCE(MAX(CAST(SUBSTRING(dependant_id, 4) AS UNSIGNED)), 0) + 1) INTO next_int
    FROM dependant;
    
    SET NEW.dependant_id = CONCAT('DEP', LPAD(next_id, 6, '0'));
    
END;
//

DELIMITER ;


-- TRIGGER FOR GENERATE BRANCH ID FOR NEWLY ADDED BRANCH
DELIMITER //

CREATE TRIGGER branch_insert
BEFORE INSERT ON branch
FOR EACH ROW
BEGIN
	DECLARE next_id INT;
    
    SELECT (COALESCE(MAX(CAST(SUBSTRING(branch_id, 4) AS UNSIGNED)), 0) + 1) INTO next_int
    FROM branch;
    
    SET NEW.branch_id = CONCAT('BR', LPAD(next_id, 3, '0'));
    
END;
//

DELIMITER ;


-- TRIGGER FOR GENERATE ATTRIBUTE ID FOR NEWLY ADDED EMPLOYEE
DELIMITER //

CREATE TRIGGER attribute_insert
BEFORE INSERT ON employee_attribute
FOR EACH ROW
BEGIN
	DECLARE next_id INT;
    
    SELECT (COALESCE(MAX(CAST(SUBSTRING(attribute_id, 4) AS UNSIGNED)), 0) + 1) INTO next_int
    FROM employee_attribute;
    
    SET NEW.attribute_id = CONCAT('ATB', LPAD(next_id, 2, '0'));
    
END;
//

DELIMITER ;


-- TRIGGER FOR RESTRICTING orgnazation TABLE TO HAVE ONLY ONE ROW
DELIMITER //

CREATE TRIGGER singleton_organization
BEFORE INSERT ON organization
FOR EACH ROW
BEGIN
	DECLARE row_count INT;
    
    SELECT COUNT(*) INTO row_count
    FROM organization;
    
    IF row_count >= 1 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The system can have only one organization.';
	END IF;
END;
//

DELIMITER ;