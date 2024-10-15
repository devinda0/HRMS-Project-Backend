
-----------------------------------PROCEDURES FOR ABSENCE MODULE--------------------------------------

-- STORED PROCEDURE FOR ADDING LEAVE
DELIMITER //

    CREATE PROCEDURE ADD_LEAVE(
        IN start_date DATE,
        IN end_date DATE,
        IN leave_type ENUM('Annual', 'Casual', 'Maternity', 'No-pay'),
        IN employee_id CHAR(9),
        IN reason VARCHAR(255)
    )
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;

            IF (start_date > end_date) THEN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Start date cannot be greater than end date';
            END IF;

            INSERT INTO leaves (start_date, end_date, leave_type, employee_id, reason, leave_status) VALUES
                (start_date, end_date, leave_type, employee_id, reason, 'Pending');

        COMMIT;
    END;

//
DELIMITER ;

-- STORED PROCEDURE FOR GETTING LEAVE BY ID
DELIMITER //

    CREATE PROCEDURE GET_LEAVE_BY_ID(
        IN leave_id CHAR(36)
    )   
    BEGIN
        SELECT leaves.leave_id, leaves.start_date, leaves.end_date, leaves.leave_type, leaves.leave_status, leaves.reason, employee.employee_id, employee.name, employee.supervisor as supervisor_id
        FROM leaves JOIN employee ON leaves.employee_id = employee.employee_id
        WHERE leaves.leave_id = leave_id;
    END;

//
DELIMITER ;

-- STORED PROCEDURE FOR DELETE LEAVE BY ID
DELIMITER //

    CREATE PROCEDURE DELETE_LEAVE_BY_ID(
        IN leave_id CHAR(36)
    )
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;

            DELETE FROM leaves WHERE leaves.leave_id = leave_id;

        COMMIT;
    END;

//
DELIMITER ;

-- STORED PROCEDURE FOR GETTING EMPLOYEE LEAVES BY ID AND STATUS
DELIMITER //

    CREATE PROCEDURE GET_EMPLOYEE_LEAVES(
        IN employee_id CHAR(9),
        IN leave_status ENUM('Pending', 'Approved', 'Declined', 'Cancelled')
    )
    BEGIN
        SELECT leaves.leave_id, leaves.start_date, leaves.end_date, leaves.leave_type, leaves.leave_status, leaves.reason, employee.employee_id, employee.name, employee.supervisor as supervisor_id
        FROM leaves JOIN employee ON leaves.employee_id = employee.employee_id
        WHERE leaves.employee_id = employee_id AND leaves.leave_status = leave_status;
    END;

//
DELIMITER ;


-- STORED PROCEDURE FOR UPDATING LEAVE STATUS
DELIMITER //

    CREATE PROCEDURE UPDATE_LEAVE_STATUS(
        IN leave_id CHAR(36),
        IN leave_status ENUM('Pending', 'Approved', 'Declined', 'Cancelled')
    )
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;

            UPDATE leaves SET leaves.leave_status = leave_status WHERE leaves.leave_id = leave_id;

        COMMIT;
    END;

//
DELIMITER ;

-- STORED PROCEDURE FOR GETTING SUBORDINATE LEAVES BY SUPERVISOR ID AND STATUS
DELIMITER //

    CREATE PROCEDURE GET_SUBORDINATES_LEAVES(
        IN supervisor_id CHAR(9),
        IN leave_status ENUM('Pending', 'Approved', 'Declined', 'Cancelled')
    )
    BEGIN
        SELECT leaves.leave_id, leaves.start_date, leaves.end_date, leaves.leave_type, leaves.leave_status, leaves.reason, employee.employee_id, employee.name, employee.supervisor as supervisor_id
        FROM leaves JOIN employee ON leaves.employee_id = employee.employee_id
        WHERE employee.supervisor = supervisor_id AND leaves.leave_status = leave_status;
    END;

//
DELIMITER ;


-- STORED PROCEDURE FOR GETTING LEAVE COUNT BY EMPLOYEE ID
DELIMITER //

    CREATE PROCEDURE GET_LEAVE_COUNT(
        IN employee_id CHAR(9)
    )
    BEGIN
        SELECT leave_type, COUNT(*) AS count 
        FROM leaves 
        WHERE leaves.employee_id = employee_id AND (leaves.leave_status = 'Pending' OR leaves.leave_status = 'Approved') 
        GROUP BY leave_type;
    END;

//
DELIMITER ;


-- STORED PROCEDURE FOR GETTING EMPLOYEE TOTAL LEAVE COUNT BY EMPLOYEE ID
DELIMITER //

    CREATE PROCEDURE GET_TOTAL_LEAVE_COUNT(
        IN employee_id CHAR(9)
    )
    BEGIN
        SELECT Annual, Casual, Maternity, No_pay AS 'No-pay' FROM employee_total_leave_count AS leave_count WHERE leave_count.employee_id = employee_id;
    END;

//
DELIMITER ;



-----------------------------------PROCEDURES FOR USER MODULE--------------------------------------

-- PROCEDURE FOR GETTING USER BY USERNAME
DELIMITER //
    CREATE PROCEDURE GET_USER_BY_USERNAME(
        IN username VARCHAR(100)
    )
    BEGIN
        SELECT * FROM user WHERE user.username = username;
    END;
//
DELIMITER ;










