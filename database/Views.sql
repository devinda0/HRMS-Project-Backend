CREATE VIEW employee_total_leave_count AS
    SELECT employee_id, Annual, Casual, Maternity, No_pay
    FROM employee JOIN leave_count ON employee.pay_grade = leave_count.pay_grade;

CREATE VIEW supervisor_subordinate AS
    SELECT e1.employee_id AS supervisor , e2.employee_id AS subordinate
    FROM employee AS e1
        LEFT JOIN employee AS e2 ON e1.employee_id = e2.supervisor;
