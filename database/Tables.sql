CREATE DATABASE hrms;

USE hrms;

CREATE TABLE branch(
	branch_id CHAR(5),
    branch_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL,
    primary key (branch_id)
);

CREATE TABLE department(
	department_name VARCHAR(100),
    budget NUMERIC(10,2),
    primary key (department_name)
);

CREATE TABLE job_title(
	job_title_id CHAR(6),
    job_title VARCHAR(100) NOT NULL,
    department_name VARCHAR(100),
    primary key(job_title_id),
    foreign key (department_name) references department(department_name)
);


CREATE TABLE pay_grade(
	pay_grade VARCHAR(100),
    basic_salary NUMERIC(10,2) NOT NULL,
    primary key (pay_grade)
);

CREATE TABLE leave_count(
	pay_grade VARCHAR(100),
    Annual INT NOT NULL,
    Casual INT NOT NULL,
    Maternity INT NOT NULL, 
    No_pay INT NOT NULL,
    primary key (pay_grade),
    foreign key (pay_grade) references pay_grade(pay_grade)
);

CREATE TABLE employee(
	employee_id CHAR(9),
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL,
    birthday DATE NOT NULL,
    marital_status ENUM('Married', 'Single', 'Divorced') NOT NULL,
    gender ENUM('Male', 'Female' , 'Other') NOT NULL,
    supervisor CHAR(9),
    job_title_id CHAR(6) NOT NULL,
    pay_grade VARCHAR(100) NOT NULL,
    employment_status ENUM('Intern_Fulltime', 'Intern_Parttime', 'Contract_Fulltime', 'Contract_Parttime', 'Permanent', 'Freelance') NOT NULL,
    branch_id CHAR(5) NOT NULL,
    primary key (employee_id),
    foreign key (supervisor) references employee(employee_id),
    foreign key (pay_grade) references pay_grade(pay_grade),
    foreign key (job_title_id) references job_title(job_title_id),
    foreign key (branch_id) references branch(branch_id)
);

CREATE TABLE dependant(
	dependant_id CHAR(9),
    name VARCHAR(100) NOT NULL,
    employee_id CHAR(9) NOT NULL,
    birthday DATE NOT NULL,
    relation VARCHAR(255) NOT NULL,
    gender ENUM('MALE','FEMALE') NOT NULL,
    primary key (dependant_id),
    foreign key (employee_id) references employee(employee_id)
);

CREATE TABLE employee_attribute(
	attribute_id CHAR(5),
    attribute_name VARCHAR(100),
    primary key (attribute_id)
);

CREATE TABLE attribute_value(
	employee_id CHAR(9),
    attribute_id CHAR(5),
    value VARCHAR(255) NOT NULL,
    primary key (employee_id, attribute_id),
    foreign key (employee_id) references employee(employee_id),
    foreign key (attribute_id) references employee_attribute(attribute_id)
);


CREATE TABLE emergency_contact(
	employee_id CHAR(9),
    contact_no INT,
    relationship VARCHAR(100),
    contact_name VARCHAR(100) NOT NULL,
    primary key (employee_id, contact_no),
    foreign key (employee_id) references employee(employee_id)
);

CREATE TABLE leaves (
	leave_id CHAR(36),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    leave_type ENUM('Annual', 'Casual', 'Maternity', 'No-pay') NOT NULL,
    employee_id CHAR(9) NOT NULL,
    leave_status ENUM('Pending', 'Approved', 'Declined', 'Cancelled') NOT NULL,
    reason VARCHAR(255),
    primary key (leave_id),
    foreign key (employee_id) references employee(employee_id)
);

CREATE TABLE organization (
	id INT,
    name VARCHAR(100) NOT NULL,
    reg_no VARCHAR(100) NOT NULL,
    main_branch CHAR(5) NOT NULL,
    ceo CHAR(9) NOT NULL,
    primary key (id),
    foreign key (main_branch) references branch(branch_id),
    foreign key (ceo) references employee(employee_id)
);

CREATE TABLE user (
	employee_id CHAR(9),
	username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'Manager', 'Employee_lvl1', 'Employee_lvl2') NOT NULL,
    primary key (employee_id),
    foreign key (employee_id) references employee(employee_id)
);



