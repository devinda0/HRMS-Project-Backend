CREATE VIEW employee_total_leave_count AS
    SELECT employee_id, Annual, Casual, Maternity, No_pay
    FROM employee JOIN leave_count ON employee.pay_grade = leave_count.pay_grade;

CREATE VIEW supervisor_subordinate AS
    SELECT e1.employee_id AS supervisor , e2.employee_id AS subordinate
    FROM employee AS e1
        LEFT JOIN employee AS e2 ON e1.employee_id = e2.supervisor;

CREATE VIEW employee_details AS
    SELECT 
        e.employee_id, 
        e.name, e.email, 
        e.address, 
        e.birthday, 
        e.marital_status, 
        e.supervisor, 
        e.pay_grade, 
        j.job_title,
        j.department_name, 
        b.branch_name,
        e.employment_status,
        u.username
    FROM employee AS e 
        JOIN job_title AS j ON e.job_title_id = j.job_title_id
        JOIN branch AS b ON e.branch_id = b.branch_id
        LEFT JOIN user AS u ON e.employee_id = u.employee_id;