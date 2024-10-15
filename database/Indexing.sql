CREATE INDEX employee_supervisor_index ON employee(supervisor);
CREATE INDEX employee_job_title_index ON employee(job_title_id);
CREATE INDEX employee_pay_grade_index ON employee(pay_grade);
CREATE INDEX employee_branch_index ON employee(branch_id);
CREATE INDEX dependant_employee_index ON dependant(employee_id);
CREATE INDEX attribute_value_employee_index ON attribute_value(employee_id);
CREATE INDEX emergency_contact_employee_index ON emergency_contact(employee_id);
CREATE INDEX leaves_employee_index ON leaves(employee_id);
CREATE INDEX user_username_index ON user(username);
