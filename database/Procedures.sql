
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
        SELECT leave_type, SUM(DATEDIFF(end_date, start_date) + 1) AS count 
        FROM leaves 
        WHERE leaves.employee_id = employee_id AND leaves.leave_status = 'Approved'
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

-- STORED PROCEDURE FOR GETTING SUBORDINATE COUNT BY EMPLOYEE ID
DELIMITER //
    CREATE PROCEDURE GET_SUBORDINATES_COUNT(
        IN employee_id CHAR(9)
    )
    BEGIN
        SELECT COUNT(*) AS count FROM employee WHERE employee.supervisor = employee_id;
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
        IN department_name VARCHAR(100)
    )
    BEGIN
        SELECT * FROM employee_details WHERE employee_details.department_name = department_name;
    END;
//
DELIMITER ;

-- STORED PROCEDURE FOR GETTING EMPLOYEES BY JOB TITLE
DELIMITER //
    CREATE PROCEDURE GET_EMPLOYEES_BY_JOB_TITLE(
        IN job_title VARCHAR(100)
    )
    BEGIN
        SELECT * FROM employee_details WHERE employee_details.job_title = job_title;
    END;
//
DELIMITER ;

-- STORED PROCEDURE FOR GETTING EMPLOYEES BY PAY GRADE
DELIMITER //
    CREATE PROCEDURE GET_EMPLOYEES_BY_PAY_GRADE(
        IN pay_grade VARCHAR(100)
    )
    BEGIN
        SELECT * FROM employee_details WHERE employee_details.pay_grade = pay_grade;
    END;
//
DELIMITER ;

-- STORED PROCEDURE FOR GETTING EMPLOYEES BY BRANCH
DELIMITER //
    CREATE PROCEDURE GET_EMPLOYEES_BY_BRANCH(
        IN branch_name VARCHAR(100)
    )
    BEGIN
        SELECT * FROM employee_details WHERE employee_details.branch_name = branch_name;
    END;
//
DELIMITER ;

-- STORED PROCEDURE FOR GETTING EMPLOYEES BY EMPLOYMENT STATUS
DELIMITER //
    CREATE PROCEDURE GET_EMPLOYEES_BY_EMPLOYMENT_STATUS(
        IN employment_status ENUM('Intern_Fulltime', 'Intern_Parttime', 'Contract_Fulltime', 'Contract_Parttime', 'Permanent', 'Freelance')
    )
    BEGIN
        SELECT * FROM employee_details WHERE employee_details.employment_status = employment_status;
    END;
//
DELIMITER ;


-- STORED PROCEDURE FOR GETTING LEAVE COUNT BY DEPARTMENT
DELIMITER //
    CREATE PROCEDURE GET_LEAVE_COUNT_BY_DEPARTMENT(
        IN fromDate DATE,
        IN toDate DATE
    )
    BEGIN
        SELECT
            e.department_name,
            SUM(DATEDIFF(l.end_date, l.start_date) + 1) AS count
        FROM leaves l
            JOIN employee_details e ON l.employee_id = e.employee_id
        WHERE l.leave_status = 'Approved' AND l.start_date >= fromDate AND l.end_date <= toDate
        GROUP BY e.department_name;
    END;
//
DELIMITER ;

-- STORED PROCEDURE FOR GETTING LEAVE COUNT BY JOB TITLE
DELIMITER //
    CREATE PROCEDURE GET_LEAVE_COUNT_BY_JOB_TITLE(
        IN fromDate DATE,
        IN toDate DATE
    )
    BEGIN
        SELECT
            e.job_title,
            SUM(DATEDIFF(l.end_date, l.start_date) + 1) AS count
        FROM leaves l
            JOIN employee_details e ON l.employee_id = e.employee_id
        WHERE l.leave_status = 'Approved' AND l.start_date >= fromDate AND l.end_date <= toDate
        GROUP BY e.job_title;
    END;
//
DELIMITER ;

-- STORED PROCEDURE FOR GETTING LEAVE COUNT BY PAY GRADE
DELIMITER //
    CREATE PROCEDURE GET_LEAVE_COUNT_BY_PAY_GRADE(
        IN fromDate DATE,
        IN toDate DATE
    )
    BEGIN
        SELECT
            e.pay_grade,
            SUM(DATEDIFF(l.end_date, l.start_date) + 1) AS count
        FROM leaves l
            JOIN employee_details e ON l.employee_id = e.employee_id
        WHERE l.leave_status = 'Approved' AND l.start_date >= fromDate AND l.end_date <= toDate
        GROUP BY e.pay_grade;
    END;
//
DELIMITER ;

-- STORED PROCEDURE FOR GETTING LEAVE COUNT BY BRANCH
DELIMITER //
    CREATE PROCEDURE GET_LEAVE_COUNT_BY_BRANCH(
        IN fromDate DATE,
        IN toDate DATE
    )
    BEGIN
        SELECT
            e.branch_name,
            SUM(DATEDIFF(l.end_date, l.start_date) + 1) AS count
        FROM leaves l
            JOIN employee_details e ON l.employee_id = e.employee_id
        WHERE l.leave_status = 'Approved' AND l.start_date >= fromDate AND l.end_date <= toDate
        GROUP BY e.branch_name;
    END;
//
DELIMITER ;

-- STORED PROCEDURE FOR GETTING LEAVE COUNT BY EMPLOYMENT STATUS
DELIMITER //
    CREATE PROCEDURE GET_LEAVE_COUNT_BY_EMPLOYMENT_STATUS(
        IN fromDate DATE,
        IN toDate DATE
    )
    BEGIN
        SELECT
            e.employment_status,
            SUM(DATEDIFF(l.end_date, l.start_date) + 1) AS count
        FROM leaves l
            JOIN employee_details e ON l.employee_id = e.employee_id
        WHERE l.leave_status = 'Approved' AND l.start_date >= fromDate AND l.end_date <= toDate
        GROUP BY e.employment_status;
    END;
//
DELIMITER ;

-- STORED PROCEDURE FOR GETTING ALL BRANCHES
DELIMITER //
    CREATE PROCEDURE GET_ALL_BRANCHES()
    BEGIN
        SELECT * FROM branch;
    END;
//
DELIMITER ;

-- STORED PROCEDURE FOR GETTING ALL DEPARTMENTS
DELIMITER //
    CREATE PROCEDURE GET_ALL_DEPARTMENTS()
    BEGIN
        SELECT * FROM department;
    END;
//
DELIMITER ;

-- STORED PROCEDURE FOR GETTING ALL JOB TITLES
DELIMITER //
    CREATE PROCEDURE GET_ALL_JOB_TITLES()
    BEGIN
        SELECT * FROM job_title;
    END;
//
DELIMITER ;

-- STORED PROCEDURE FOR GETTING ALL PAY GRADES
DELIMITER //
    CREATE PROCEDURE GET_ALL_PAY_GRADES()
    BEGIN
        SELECT * FROM pay_grade;
    END;
//
DELIMITER ;


-----------------------------------PROCEDURES FOR PIM MODULE--------------------------------------

-- PROCEDURE FOR ADDING EMPLOYEE
DELIMITER //
    CREATE PROCEDURE ADD_EMPLOYEE(
        IN name VARCHAR(100),
        IN email VARCHAR(100),
        IN address VARCHAR(255),
        IN gender ENUM('MALE', 'FEMALE'),
        IN birthday DATE,
        IN phone CHAR(10),
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


            INSERT INTO employee (name, email, address, gender, birthday, phone, marital_status, supervisor, job_title_id, pay_grade, employment_status, branch_id) VALUES
                (name, email, address, gender, birthday, phone, marital_status, supervisor, job_title_id, pay_grade, employment_status, branch_id);

        COMMIT;
    END;

//
DELIMITER ;

-- PROCEDURE FOR GETTING ALL EMPLOYEES
DELIMITER //
    CREATE PROCEDURE GET_ALL_EMPLOYEES(
        IN limit_start INT,
        IN record_count INT
    )
    BEGIN
        SELECT * 
        FROM employee_details
        LIMIT record_count
        OFFSET limit_start;
    END;
//
DELIMITER ;

-- PROCEDURE FOR GETTING EMPLOYEE COUNT
DELIMITER //
    CREATE PROCEDURE GET_EMPLOYEE_COUNT()
    BEGIN
        SELECT COUNT(*) AS count FROM employee;
    END;
//
DELIMITER ;

-- PROCEDURE FOR GETTING EMPLOYEE BY ID
DELIMITER //
    CREATE PROCEDURE GET_EMPLOYEE_BY_ID(
        IN employee_id CHAR(9)
    )
    BEGIN
        SELECT * FROM employee_details e WHERE e.employee_id = employee_id;
    END;
//
DELIMITER ;

DELIMITER //
    CREATE PROCEDURE GET_EMPLOYEE_BRIEF_BY_ID(
        IN employee_id CHAR(9)
    )
    BEGIN
        SELECT *
        FROM employee
        WHERE employee.employee_id = employee_id;
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
        IN gender ENUM('MALE', 'FEMALE'),
        IN birthday DATE,
        IN phone CHAR(10),
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
                employee.gender = gender,
                employee.birthday = birthday,
                employee.phone = phone,
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

-- PROCEDURE FOR UPDATING DEPENDANT BY DEPENDANT ID
DELIMITER //
    CREATE PROCEDURE UPDATE_DEPENDANT(
        IN dependant_id CHAR(36),
        IN name VARCHAR(100),
        IN birthday DATE,
        IN relation VARCHAR(255),
        IN gender ENUM('MALE', 'FEMALE')
    )
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;

            UPDATE dependant SET 
                dependant.name = name,
                dependant.birthday = birthday,
                dependant.relation = relation,
                dependant.gender = gender
            WHERE dependant.dependant_id = dependant_id;
        
        COMMIT;
    END;
//
DELIMITER ;

-- PROCEDURE FOR DELETING DEPENDANT BY DEPENDANT ID
DELIMITER //
    CREATE PROCEDURE DELETE_DEPENDANT(
        IN dependant_id CHAR(36)
    )
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;

            DELETE FROM dependant WHERE dependant.dependant_id = dependant_id;
        
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
        IN attributes JSON
    )
    BEGIN
        DECLARE attribute_id CHAR(5);
        DECLARE value VARCHAR(255);

        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;

            DELETE FROM attribute_value WHERE attribute_value.employee_id = employee_id;

            WHILE JSON_LENGTH(attributes) > 0 DO
                SET attribute_id = JSON_UNQUOTE(JSON_EXTRACT(attributes, '$[0].attribute_id'));
                SET value = JSON_UNQUOTE(JSON_EXTRACT(attributes, '$[0].value'));

                INSERT INTO attribute_value (employee_id, attribute_id, value) VALUES
                    (employee_id, attribute_id, value);

                SET attributes = JSON_REMOVE(attributes, '$[0]');
            END WHILE;
        
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
        IN contact_name VARCHAR(100),
        IN relationship VARCHAR(100),
        IN contact_no INT
    )
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;

            INSERT INTO emergency_contact (employee_id, contact_name , relationship, contact_no) VALUES
                (employee_id, contact_name, relationship, contact_no);
        
        COMMIT;
    END;
//
DELIMITER ;

-- PROCEDURE FOR UPDATING EMERGENCY CONTACT
DELIMITER //
    CREATE PROCEDURE UPDATE_EMERGENCY_CONTACT(
        IN employee_id CHAR(9),
        IN old_contact_no INT,
        IN new_contact_no INT,
        IN relationship VARCHAR(100),
        IN contact_name VARCHAR(100)
    )
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;

            DELETE FROM emergency_contact WHERE emergency_contact.employee_id = employee_id AND emergency_contact.contact_no = old_contact_no;

            INSERT INTO emergency_contact (employee_id, contact_no, relationship, contact_name) VALUES
                (employee_id, new_contact_no, relationship, contact_name);
        
        COMMIT;
    END;
//
DELIMITER ;

-- PROCEDURE FOR DELETING EMERGENCY CONTACT
DELIMITER //
    CREATE PROCEDURE DELETE_EMERGENCY_CONTACT(
        IN employee_id CHAR(9),
        IN contact_no INT
    )
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            RESIGNAL;
        END;

        START TRANSACTION;

            DELETE FROM emergency_contact WHERE emergency_contact.employee_id = employee_id AND emergency_contact.contact_no = contact_no;
        
        COMMIT;
    END;
//
DELIMITER ;


