
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

DELIMITER //
    CREATE PROCEDURE ADD_USER_ACCOUNT(
        IN username VARCHAR(100),
        IN password VARCHAR(100),
        IN role ENUM('Admin', 'Manager', 'Employee_lvl1', 'Employee_lvl2'),
        IN employee_id CHAR(9)
    )
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;

            INSERT INTO user (username, password, role, employee_id) VALUES
                (username, password, role, employee_id);

        COMMIT;
    END;
//
DELIMITER ;



----------------------------------PROCEDURES FOR Report MODULE--------------------------------------

-- STORED PROCEDURE FOR GETTING EMPLOYEES BY DEPARTMENT
DELIMITER //

CREATE PROCEDURE GET_EMPLOYEES_BY_DEPARTMENT(
    IN p_department_name VARCHAR(100)
)
BEGIN
    SELECT 
        e.employee_id,
        e.name,
        e.email,
        e.address,
        e.birthday,
        e.marital_status,
        e.supervisor,
        jt.job_title,
        pg.pay_grade,
        e.employment_status,
        b.branch_name
    FROM employee e
    JOIN job_title jt ON e.job_title_id = jt.job_title_id
    JOIN pay_grade pg ON e.pay_grade = pg.pay_grade
    JOIN branch b ON e.branch_id = b.branch_id
    JOIN department d ON jt.department_name = d.department_name
    WHERE d.department_name = p_department_name;
END;
//

DELIMITER ;

-- STORED PROCEDURE FOR GETTING TOTAL LEAVES BY DEPARTMENT AND PERIOD
DELIMITER //

CREATE PROCEDURE GET_TOTAL_LEAVES_BY_DEPARTMENT_PERIOD(
    IN p_department_name VARCHAR(100),
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN
    SELECT 
        l.leave_type,
        COUNT(l.leave_id) AS total_leaves
    FROM leaves l
    JOIN employee e ON l.employee_id = e.employee_id
    JOIN job_title jt ON e.job_title_id = jt.job_title_id
    WHERE jt.department_name = p_department_name
      AND l.start_date >= p_start_date
      AND l.end_date <= p_end_date
      AND l.leave_status IN ('Approved', 'Pending') -- Considering only relevant statuses
    GROUP BY l.leave_type;
END;
//


-- STORED PROCEDURE FOR GETTING EMPLOYEE REPORTS GROUPED BY JOB TITLE, DEPARTMENT, AND PAY GRADE
DELIMITER //

CREATE PROCEDURE GET_EMPLOYEE_REPORTS_GROUPED()
BEGIN
    SELECT 
        d.department_name,
        jt.job_title,
        pg.pay_grade,
        COUNT(e.employee_id) AS total_employees,
        AVG(pg.basic_salary) AS average_salary,
        SUM(CASE WHEN e.employment_status = 'Permanent' THEN 1 ELSE 0 END) AS permanent_employees,
        SUM(CASE WHEN e.employment_status LIKE 'Contract%' THEN 1 ELSE 0 END) AS contract_employees
    FROM employee e
    JOIN job_title jt ON e.job_title_id = jt.job_title_id
    JOIN department d ON jt.department_name = d.department_name
    JOIN pay_grade pg ON e.pay_grade = pg.pay_grade
    GROUP BY d.department_name, jt.job_title, pg.pay_grade
    ORDER BY d.department_name, jt.job_title, pg.pay_grade;
END;
//

DELIMITER ;


-- STORED PROCEDURE FOR GETTING EMPLOYEES WITH PAST EXPERIENCE
DELIMITER //

CREATE PROCEDURE GET_EMPLOYEES_WITH_PAST_EXPERIENCE()
BEGIN
    SELECT 
        e.employee_id,
        e.name,
        e.email,
        jt.job_title,
        pg.pay_grade,
        e.employment_status,
        b.branch_name,
        av.value AS experience
    FROM employee e
    JOIN job_title jt ON e.job_title_id = jt.job_title_id
    JOIN pay_grade pg ON e.pay_grade = pg.pay_grade
    JOIN branch b ON e.branch_id = b.branch_id
    JOIN attribute_value av ON e.employee_id = av.employee_id
    JOIN employee_attribute ea ON av.attribute_id = ea.attribute_id
    WHERE ea.attribute_name = 'Experience'
      AND av.value IS NOT NULL
      AND TRIM(av.value) <> '';
END;
//

DELIMITER ;

-----------------------------------PROCEDURES FOR EMPLOYEE MODULE--------------------------------------

-- PROCEDURE FOR ADDING EMPLOYEE
DELIMITER //
    CREATE PROCEDURE ADD_EMPLOYEE(
        IN name VARCHAR(100),
        IN email VARCHAR(100),
        address VARCHAR(255),
        birthday DATE,
        marital_status ENUM('Married', 'Single', 'Divorced'),
        supervisor CHAR(9),
        job_title_id CHAR(6),
        pay_grade VARCHAR(100),
        employment_status ENUM('Intern_Fulltime', 'Intern_Parttime', 'Contract_Fulltime', 'Contract_Parttime', 'Permanent', 'Freelance'),
        branch_id CHAR(5)
    )
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;


            INSERT INTO employee (name, email, address, birthday, marital_status, supervisor, job_title_id, pay_grade, employment_status, branch_id) VALUES
                (name, email, address, birthday, marital_status, supervisor, job_title_id, pay_grade, employment_status, branch_id);

        COMMIT;
    END;

//
DELIMITER ;

-- PROCEDURE FOR GETTING ALL EMPLOYEES
DELIMITER //
    CREATE PROCEDURE GET_ALL_EMPLOYEES()
    BEGIN
        SELECT * FROM employee;
    END;
//
DELIMITER ;

-- PROCEDURE FOR GETTING EMPLOYEE BY ID
DELIMITER //
    CREATE PROCEDURE GET_EMPLOYEE_BY_ID(
        IN employee_id CHAR(9)
    )
    BEGIN
        SELECT * FROM employee WHERE employee.employee_id = employee_id;
    END;
//
DELIMITER ;

-- PROCEDURE FOR UPDATE EMPLOYEE BY ID
DELIMITER //
    CREATE PROCEDURE UPDATE_EMPLOYEE_BY_ID(
        IN employee_id CHAR(9),
        IN name VARCHAR(100),
        IN email VARCHAR(100),
        IN address VARCHAR(255),
        IN birthday DATE,
        IN marital_status ENUM('Married', 'Single', 'Divorced'),
        IN supervisor CHAR(9),
        IN job_title_id CHAR(6),
        IN pay_grade VARCHAR(100),
        IN employment_status ENUM('Intern_Fulltime', 'Intern_Parttime', 'Contract_Fulltime', 'Contract_Parttime', 'Permanent', 'Freelance'),
        IN branch_id CHAR(5)
    )
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;

            UPDATE employee SET 
                employee.name = name,
                employee.email = email,
                employee.address = address,
                employee.birthday = birthday,
                employee.marital_status = marital_status,
                employee.supervisor = supervisor,
                employee.job_title_id = job_title_id,
                employee.pay_grade = pay_grade,
                employee.employment_status = employment_status,
                employee.branch_id = branch_id
            WHERE employee.employee_id = employee_id;
            
        COMMIT;
    END;    
//
DELIMITER ;


-- PROCEDURE FOR GETTING DEPENDANTS BY EMPLOYEE ID
DELIMITER //
    CREATE PROCEDURE GET_DEPENDANTS_BY_EMPLOYEE_ID(
        IN employee_id CHAR(9)
    )
    BEGIN
        SELECT * FROM dependant WHERE dependant.employee_id = employee_id;
    END;
//
DELIMITER ;

-- PROCEDURE FOR ADDING DEPENDANT BY EMPLOYEE ID
DELIMITER //
    CREATE PROCEDURE ADD_DEPENDANT(
        IN name VARCHAR(100),
        IN employee_id CHAR(9),
        IN birthday DATE,
        IN relation VARCHAR(255),
        IN gender ENUM('MALE','FEMALE')
    )
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;

            INSERT INTO dependant (name, employee_id, birthday, relation, gender) VALUES
                (name, employee_id, birthday, relation, gender);
        
        COMMIT;
    END;
//
DELIMITER ;

-- PROCEDURE FOR GETTING EMPLOYEE ATTRIBUTE BY EMPLOYEE ID
DELIMITER //
    CREATE PROCEDURE GET_EMPLOYEE_ATTRIBUTE_BY_EMPLOYEE_ID(
        IN employee_id CHAR(9)
    )
    BEGIN
        SELECT employee_attribute.attribute_name, attribute_value.value
        FROM attribute_value JOIN employee_attribute ON attribute_value.attribute_id = employee_attribute.attribute_id
        WHERE attribute_value.employee_id = employee_id;
    END;
//
DELIMITER ;

-- PROCEDURE FOR ADDING EMPLOYEE ATTRIBUTE BY EMPLOYEE ID
DELIMITER //
    CREATE PROCEDURE ADD_EMPLOYEE_ATTRIBUTE(
        IN employee_id CHAR(9),
        IN attribute_id CHAR(5),
        IN value VARCHAR(255)
    )
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;

            INSERT INTO attribute_value (employee_id, attribute_id, value) VALUES
                (employee_id, attribute_id, value);
        
        COMMIT;
    END;
//
DELIMITER ;

-- PROCEDURE FOR UPDATING EMPLOYEE ATTRIBUTE BY EMPLOYEE ID
DELIMITER // 
    CREATE PROCEDURE UPDATE_EMPLOYEE_ATTRIBUTE(
        IN employee_id CHAR(9),
        IN attribute_id CHAR(5),
        IN value VARCHAR(255)
    )
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;

            UPDATE attribute_value SET attribute_value.value = value WHERE attribute_value.employee_id = employee_id AND attribute_value.attribute_id = attribute_id;
        
        COMMIT;
    END;
//
DELIMITER ;

-- PROCEDURE FOR GETTING CUSTOM ATTRIBUTE
DELIMITER //
    CREATE PROCEDURE GET_CUSTOM_ATTRIBUTE()
    BEGIN
        SELECT * FROM employee_attribute;
    END;
//
DELIMITER ;

-- PROCEDURE FOR ADDING CUSTOM ATTRIBUTE
DELIMITER //
    CREATE PROCEDURE ADD_CUSTOM_ATTRIBUTE(
        IN attribute_name VARCHAR(100)
    )
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;

            INSERT INTO employee_attribute (attribute_name) VALUES
                (attribute_name);
        
        COMMIT;
    END;

//
DELIMITER ;

-- PROCEDURE FOR DELETING CUSTOM ATTRIBUTE
DELIMITER //
    CREATE PROCEDURE DELETE_CUSTOM_ATTRIBUTE(
        IN attribute_id CHAR(5)
    )
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;

            DELETE FROM employee_attribute WHERE employee_attribute.attribute_id = attribute_id;
        
        COMMIT;
    END;
//
DELIMITER ;

-- PROCEDURE FOR GETTING EMERGENCY CONTACT BY EMPLOYEE ID
DELIMITER //
    CREATE PROCEDURE GET_EMERGENCY_CONTACT_BY_EMPLOYEE_ID(
        IN employee_id CHAR(9)
    )
    BEGIN
        SELECT * FROM emergency_contact WHERE emergency_contact.employee_id = employee_id;
    END;
//
DELIMITER ;

-- PROCEDURE FOR ADDING EMERGENCY CONTACT BY EMPLOYEE ID
DELIMITER //
    CREATE PROCEDURE ADD_EMERGENCY_CONTACT(
        IN employee_id CHAR(9),
        IN relation VARCHAR(100),
        IN contact_no INT
    )
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;

            INSERT INTO emergency_contact (employee_id, relation, contact_no) VALUES
                (employee_id, relation, contact_no);
        
        COMMIT;
    END;
//
DELIMITER ;

-- PROCEDURE FOR UPDATING EMERGENCY CONTACT
DELIMITER //
    CREATE PROCEDURE UPDATE_EMERGENCY_CONTACT(
        IN employee_id CHAR(9),
        IN new_relation VARCHAR(100),
        IN old_contact_no INT,
        IN new_contact_no INT
    )
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;

            DELETE FROM emergency_contact WHERE emergency_contact.employee_id = employee_id AND emergency_contact.contact_no = old_contact_no;

            INSERT INTO emergency_contact (employee_id, relation, contact_no) VALUES
                (employee_id, new_relation, new_contact_no);
        
        COMMIT;
    END;
//

DELIMITER ;

-- PROCEDURE FOR UPDATE EMPLOYEE DEPENDANT INFORMATION
DELIMITER //

CREATE PROCEDURE UPDATE_DEPENDANT_INFO(
    IN p_dependant_id CHAR(9),
    IN p_name VARCHAR(100),
    IN p_employee_id CHAR(9),
    IN p_birthday DATE,
    IN p_relation VARCHAR(255),
    IN p_gender ENUM('MALE', 'FEMALE')
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

        DELETE FROM dependant 
        WHERE dependant.dependant_id = p_dependant_id;

        INSERT INTO dependant (dependant_id, name, employee_id, birthday, relation, gender)
        VALUES (p_dependant_id, p_name, p_employee_id, p_birthday, p_relation, p_gender);
    
    COMMIT;
END //

DELIMITER ;



