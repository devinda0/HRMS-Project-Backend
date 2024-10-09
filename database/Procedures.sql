
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


-- STORED PROCEDURE FOR GETTING EMPLOYEE LEAVES BY ID AND STATUS
DELIMITER //

    CREATE PROCEDURE GET_EMPLOYEE_LEAVES(
        IN employee_id CHAR(9),
        IN leave_status ENUM('Pending', 'Accepted', 'Rejected')
    )
    BEGIN
        SELECT * FROM leaves WHERE employee_id = employee_id AND leave_status = leave_status;
    END;

//
DELIMITER ;


-- STORED PROCEDURE FOR UPDATING LEAVE STATUS
DELIMITER //

    CREATE PROCEDURE UPDATE_LEAVE_STATUS(
        IN leave_id CHAR(36),
        IN leave_status ENUM('Pending', 'Accepted', 'Rejected')
    )
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;

            UPDATE leaves SET leave_status = leave_status WHERE leave_id = leave_id;

        COMMIT;
    END;

//
DELIMITER ;


-- STORED PROCEDURE FOR GETTING LEAVE COUNT BY EMPLOYEE ID
DELIMITER //

    CREATE PROCEDURE GET_LEAVE_COUNT(
        IN employee_id CHAR(9)
    )
    BEGIN
        SELECT leave_type, COUNT(*) AS count FROM leaves WHERE employee_id = employee_id GROUP BY leave_type;
    END;

//
DELIMITER ;


-- STORED PROCEDURE FOR GETTING EMPLOYEE TOTAL LEAVE COUNT BY EMPLOYEE ID
DELIMITER //

    CREATE PROCEDURE GET_TOTAL_LEAVE_COUNT(
        IN employee_id CHAR(9)
    )
    BEGIN
        SELECT * FROM leave_count WHERE pay_grade IN (SELECT pay_grade FROM employee WHERE employee_id = employee_id);
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
        SELECT * FROM user WHERE username = username;
    END;
//
DELIMITER ;










