-- Populate branch table
INSERT INTO branch (branch_id, branch_name, address) VALUES
('B0001', 'Colombo Main Branch', '123 Galle Road, Colombo 03, Sri Lanka'),
('B0002', 'Kandy Branch', '45 Peradeniya Road, Kandy, Sri Lanka'),
('B0003', 'Galle Branch', '78 Matara Road, Galle, Sri Lanka'),
('B0004', 'Dhaka Branch', '56 Gulshan Avenue, Dhaka 1212, Bangladesh'),
('B0005', 'Chittagong Branch', '34 Agrabad Commercial Area, Chittagong 4100, Bangladesh'),
('B0006', 'Karachi Branch', '90 Shahrah-e-Faisal, Karachi 75350, Pakistan'),
('B0007', 'Lahore Branch', '12 Mall Road, Lahore 54000, Pakistan');

-- Populate department table
INSERT INTO department (department_name, budget) VALUES
('Human Resources', 5000000.00),
('Finance', 7500000.00),
('Information Technology', 10000000.00),
('Marketing', 8000000.00),
('Operations', 12000000.00),
('Sales', 9000000.00),
('Customer Service', 6000000.00),
('Research and Development', 11000000.00),
('Legal', 5500000.00);

-- Populate job_title table
INSERT INTO job_title (job_title_id, job_title, department_name) VALUES
('JT0001', 'HR Manager', 'Human Resources'),
('JT0002', 'HR Assistant', 'Human Resources'),
('JT0003', 'Financial Analyst', 'Finance'),
('JT0004', 'Accountant', 'Finance'),
('JT0005', 'Software Engineer', 'Information Technology'),
('JT0006', 'System Administrator', 'Information Technology'),
('JT0007', 'Marketing Specialist', 'Marketing'),
('JT0008', 'Sales Representative', 'Sales'),
('JT0009', 'Operations Manager', 'Operations'),
('JT0010', 'Logistics Coordinator', 'Operations'),
('JT0011', 'Customer Service Representative', 'Customer Service'),
('JT0012', 'Research Scientist', 'Research and Development'),
('JT0013', 'Legal Counsel', 'Legal'),
('JT0014', 'Procurement Officer', 'Procurement'),
('JT0015', 'Data Analyst', 'Information Technology');

-- Updated pay_grade table
INSERT INTO pay_grade (pay_grade, basic_salary) VALUES
('Level-1', 35000.00),
('Level-2', 50000.00),
('Managerial', 75000.00),
('Senior Managerial', 100000.00),
('Executive', 150000.00);

-- Update leave_count table
INSERT INTO leave_count (pay_grade, Annual, Casual, Maternity, No_pay) VALUES
('Level-1', 14, 7, 84, 50),
('Level-2', 21, 7, 84, 50),
('Managerial', 21, 10, 84, 50),
('Senior Managerial', 28, 10, 84, 50),
('Executive', 28, 14, 84, 50);


-- Populate employee table with at least 50 records
INSERT INTO employee (employee_id, name, email, address, birthday, marital_status, supervisor, job_title_id, pay_grade, employment_status, branch_id) VALUES
('EMP000001', 'Dimuth Hasaranga', 'dimuth.hasaranga@jupyter.com', '45 Temple Road, Colombo 05, Sri Lanka', '1985-03-15', 'Married', NULL, 'JT0001', 'Executive', 'Permanent', 'B0001'),
('EMP000002', 'Tenil Rukshan', 'tenil.rukshan@jupyter.com', '23 Lake Drive, Kandy, Sri Lanka', '1988-07-22', 'Single', 'EMP000001', 'JT0005', 'Level-2', 'Permanent', 'B0002'),
('EMP000003', 'Nethmi Oshadi', 'nethmi.oshadi@jupyter.com', '78 Beach Road, Galle, Sri Lanka', '1990-11-30', 'Married', 'EMP000001', 'JT0003', 'Managerial', 'Permanent', 'B0003'),
('EMP000004', 'Rahul Karim', 'rahul.karim@jupyter.com', '12 Green Road, Dhaka 1205, Bangladesh', '1987-05-18', 'Married', 'EMP000001', 'JT0009', 'Senior Managerial', 'Permanent', 'B0004'),
('EMP000005', 'Fatima Zahra', 'fatima.zahra@jupyter.com', '56 Jinnah Avenue, Karachi 75530, Pakistan', '1992-09-03', 'Single', 'EMP000001', 'JT0007', 'Managerial', 'Permanent', 'B0006'),
('EMP000006', 'Chamathka Lakmali', 'chamathka.lakmali@jupyter.com', '34 Hill Street, Kandy, Sri Lanka', '1991-02-14', 'Married', 'EMP000002', 'JT0006', 'Level-2', 'Contract_Fulltime', 'B0002'),
('EMP000007', 'Nuwan Pradeep', 'nuwan.pradeep@jupyter.com', '89 Marine Drive, Colombo 03, Sri Lanka', '1986-10-31', 'Divorced', 'EMP000001', 'JT0004', 'Managerial', 'Permanent', 'B0001'),
('EMP000008', 'Ayesha Begum', 'ayesha.begum@jupyter.com', '23 Station Road, Chittagong 4000, Bangladesh', '1993-07-07', 'Single', 'EMP000004', 'JT0011', 'Level-1', 'Permanent', 'B0005'),
('EMP000009', 'Muhammad Imran', 'muhammad.imran@jupyter.com', '78 The Mall, Lahore 54000, Pakistan', '1989-12-25', 'Married', 'EMP000005', 'JT0008', 'Level-2', 'Permanent', 'B0007'),
('EMP000010', 'Sachini Nisansala', 'sachini.nisansala@jupyter.com', '56 Galle Face Terrace, Colombo 03, Sri Lanka', '1994-04-19', 'Single', 'EMP000001', 'JT0002', 'Level-1', 'Intern_Fulltime', 'B0001'),
('EMP000011', 'Asanka Gurusinha', 'asanka.gurusinha@jupyter.com', '78 Park Street, Colombo 02, Sri Lanka', '1990-08-12', 'Single', 'EMP000007', 'JT0010', 'Level-1', 'Permanent', 'B0001'),
('EMP000012', 'Nusrat Jahan', 'nusrat.jahan@jupyter.com', '34 Banani Road, Dhaka 1213, Bangladesh', '1992-05-20', 'Married', 'EMP000004', 'JT0012', 'Level-2', 'Permanent', 'B0004'),
('EMP000013', 'Ahmed Raza', 'ahmed.raza@jupyter.com', '56 Clifton Road, Karachi 75600, Pakistan', '1988-11-15', 'Married', 'EMP000005', 'JT0013', 'Level-2', 'Permanent', 'B0006'),
('EMP000014', 'Ramani Perera', 'ramani.perera@jupyter.com', '90 Galle Road, Colombo 04, Sri Lanka', '1991-03-25', 'Single', 'EMP000003', 'JT0014', 'Level-1', 'Contract_Fulltime', 'B0001'),
('EMP000015', 'Farhan Ahmed', 'farhan.ahmed@jupyter.com', '23 Dhanmondi Road, Dhaka 1209, Bangladesh', '1989-07-30', 'Married', 'EMP000004', 'JT0015', 'Level-2', 'Permanent', 'B0005'),
('EMP000016', 'Sana Malik', 'sana.malik@jupyter.com', '45 Gulberg Road, Lahore 54660, Pakistan', '1993-01-05', 'Single', 'EMP000009', 'JT0016', 'Level-1', 'Permanent', 'B0007'),
('EMP000017', 'Dilshan Fernando', 'dilshan.fernando@jupyter.com', '67 Negombo Road, Negombo, Sri Lanka', '1987-09-18', 'Married', 'EMP000007', 'JT0017', 'Level-2', 'Permanent', 'B0001'),
('EMP000018', 'Tahmina Akter', 'tahmina.akter@jupyter.com', '89 Uttara Sector 4, Dhaka 1230, Bangladesh', '1994-04-22', 'Single', 'EMP000012', 'JT0018', 'Level-1', 'Intern_Fulltime', 'B0004'),
('EMP000019', 'Usman Tariq', 'usman.tariq@jupyter.com', '12 DHA Phase 5, Karachi 75500, Pakistan', '1990-12-10', 'Married', 'EMP000013', 'JT0019', 'Level-2', 'Permanent', 'B0006'),
('EMP000020', 'Ishara Madushani', 'ishara.madushani@jupyter.com', '34 Kandy Road, Peradeniya, Sri Lanka', '1992-06-15', 'Single', 'EMP000002', 'JT0020', 'Level-1', 'Permanent', 'B0002'),
('EMP000021', 'Zubair Hasan', 'zubair.hasan@jupyter.com', '56 Mirpur Road, Dhaka 1216, Bangladesh', '1988-02-28', 'Married', 'EMP000004', 'JT0021', 'Level-2', 'Permanent', 'B0004'),
('EMP000022', 'Amna Riaz', 'amna.riaz@jupyter.com', '78 Model Town, Lahore 54700, Pakistan', '1991-10-05', 'Single', 'EMP000009', 'JT0022', 'Level-1', 'Contract_Fulltime', 'B0007'),
('EMP000023', 'Chaminda Vaas', 'chaminda.vaas@jupyter.com', '90 Marine Drive, Galle, Sri Lanka', '1987-04-12', 'Married', 'EMP000003', 'JT0023', 'Level-2', 'Permanent', 'B0003'),
('EMP000024', 'Nasreen Akhtar', 'nasreen.akhtar@jupyter.com', '23 Gulshan Circle 2, Dhaka 1212, Bangladesh', '1993-08-20', 'Single', 'EMP000012', 'JT0024', 'Level-1', 'Permanent', 'B0004'),
('EMP000025', 'Imran Butt', 'imran.butt@jupyter.com', '45 Faisal Town, Lahore 54000, Pakistan', '1989-11-30', 'Married', 'EMP000013', 'JT0025', 'Level-2', 'Permanent', 'B0007'),
('EMP000026', 'Nilushi Cooray', 'nilushi.cooray@jupyter.com', '67 Batticaloa Road, Trincomalee, Sri Lanka', '1992-03-15', 'Single', 'EMP000007', 'JT0026', 'Level-1', 'Permanent', 'B0001'),
('EMP000027', 'Rahim Uddin', 'rahim.uddin@jupyter.com', '89 Baridhara DOHS, Dhaka 1206, Bangladesh', '1990-07-25', 'Married', 'EMP000004', 'JT0027', 'Level-2', 'Permanent', 'B0005'),
('EMP000028', 'Sadia Nawaz', 'sadia.nawaz@jupyter.com', '12 Johar Town, Lahore 54782, Pakistan', '1994-01-10', 'Single', 'EMP000009', 'JT0028', 'Level-1', 'Intern_Fulltime', 'B0007'),
('EMP000029', 'Tharanga Paranavitana', 'tharanga.paranavitana@jupyter.com', '34 Matale Road, Kandy, Sri Lanka', '1988-05-18', 'Married', 'EMP000002', 'JT0029', 'Level-2', 'Permanent', 'B0002'),
('EMP000030', 'Farhana Islam', 'farhana.islam@jupyter.com', '56 Mohammadpur, Dhaka 1207, Bangladesh', '1991-09-22', 'Single', 'EMP000012', 'JT0030', 'Level-1', 'Permanent', 'B0004'),
('EMP000031', 'Yasir Shah', 'yasir.shah@jupyter.com', '78 Bahria Town, Karachi 75340, Pakistan', '1987-12-05', 'Married', 'EMP000005', 'JT0031', 'Level-2', 'Permanent', 'B0006'),
('EMP000032', 'Sanduni Abeywickrama', 'sanduni.abeywickrama@jupyter.com', '90 Matara Road, Hambantota, Sri Lanka', '1993-04-30', 'Single', 'EMP000003', 'JT0032', 'Level-1', 'Contract_Fulltime', 'B0003'),
('EMP000033', 'Kamal Hossain', 'kamal.hossain@jupyter.com', '23 Uttara Sector 7, Dhaka 1230, Bangladesh', '1989-08-15', 'Married', 'EMP000004', 'JT0033', 'Level-2', 'Permanent', 'B0004'),
('EMP000034', 'Asma Khalid', 'asma.khalid@jupyter.com', '45 Cantt Area, Lahore 54810, Pakistan', '1992-02-20', 'Single', 'EMP000013', 'JT0034', 'Level-1', 'Permanent', 'B0007'),
('EMP000035', 'Rangana Herath', 'rangana.herath@jupyter.com', '67 Nuwara Eliya Road, Badulla, Sri Lanka', '1988-06-25', 'Married', 'EMP000007', 'JT0035', 'Level-2', 'Permanent', 'B0001'),
('EMP000036', 'Shabnam Akter', 'shabnam.akter@jupyter.com', '89 Bashundhara R/A, Dhaka 1229, Bangladesh', '1994-10-12', 'Single', 'EMP000012', 'JT0036', 'Level-1', 'Intern_Fulltime', 'B0005'),
('EMP000037', 'Saad Ahmed', 'saad.ahmed@jupyter.com', '12 Askari Housing, Karachi 75100, Pakistan', '1990-01-30', 'Married', 'EMP000005', 'JT0037', 'Level-2', 'Permanent', 'B0006'),
('EMP000038', 'Hansini Edirisinghe', 'hansini.edirisinghe@jupyter.com', '34 Kurunegala Road, Chilaw, Sri Lanka', '1991-05-05', 'Single', 'EMP000003', 'JT0038', 'Level-1', 'Permanent', 'B0001'),
('EMP000039', 'Mahbub Alam', 'mahbub.alam@jupyter.com', '56 Khilgaon, Dhaka 1219, Bangladesh', '1987-09-10', 'Married', 'EMP000004', 'JT0039', 'Level-2', 'Permanent', 'B0004'),
('EMP000040', 'Saba Qamar', 'saba.qamar@jupyter.com', '78 Wapda Town, Lahore 54000, Pakistan', '1993-03-15', 'Single', 'EMP000009', 'JT0040', 'Level-1', 'Contract_Fulltime', 'B0007'),
('EMP000041', 'Lasith Malinga', 'lasith.malinga@jupyter.com', '90 Galle Face Road, Colombo 01, Sri Lanka', '1989-07-20', 'Married', 'EMP000001', 'JT0041', 'Level-2', 'Permanent', 'B0001'),
('EMP000042', 'Sabina Yasmin', 'sabina.yasmin@jupyter.com', '23 Motijheel, Dhaka 1000, Bangladesh', '1992-11-25', 'Single', 'EMP000004', 'JT0042', 'Level-1', 'Permanent', 'B0004'),
('EMP000043', 'Fawad Khan', 'fawad.khan@jupyter.com', '45 DHA Phase 1, Lahore 54792, Pakistan', '1988-04-30', 'Married', 'EMP000005', 'JT0043', 'Level-2', 'Permanent', 'B0006'),
('EMP000044', 'Sheshadri Priyasad', 'sheshadri.priyasad@jupyter.com', '67 Anuradhapura Road, Polonnaruwa, Sri Lanka', '1994-08-05', 'Single', 'EMP000003', 'JT0044', 'Level-1', 'Intern_Fulltime', 'B0003'),
('EMP000045', 'Najmul Hossain', 'najmul.hossain@jupyter.com', '89 Dhanmondi 32, Dhaka 1209, Bangladesh', '1990-12-10', 'Married', 'EMP000012', 'JT0045', 'Level-2', 'Permanent', 'B0005'),
('EMP000046', 'Hira Mani', 'hira.mani@jupyter.com', '12 Gulshan-e-Iqbal, Karachi 75300, Pakistan', '1991-02-15', 'Single', 'EMP000013', 'JT0046', 'Level-1', 'Permanent', 'B0006'),
('EMP000047', 'Kusal Mendis', 'kusal.mendis@jupyter.com', '34 Ratnapura Road, Embilipitiya, Sri Lanka', '1987-06-20', 'Married', 'EMP000007', 'JT0047', 'Level-2', 'Permanent', 'B0001'),
('EMP000048', 'Nusrat Imroz', 'nusrat.imroz@jupyter.com', '56 Mirpur DOHS, Dhaka 1216, Bangladesh', '1993-10-25', 'Single', 'EMP000004', 'JT0048', 'Level-1', 'Contract_Fulltime', 'B0004'),
('EMP000049', 'Mahira Khan', 'mahira.khan@jupyter.com', '78 Valencia Town, Lahore 54000, Pakistan', '1989-01-30', 'Married', 'EMP000009', 'JT0049', 'Level-2', 'Permanent', 'B0007'),
('EMP000050', 'Dinesh Chandimal', 'dinesh.chandimal@jupyter.com', '90 Katugastota Road, Kandy, Sri Lanka', '1992-05-05', 'Single', 'EMP000002', 'JT0050', 'Level-1', 'Permanent', 'B0002');

-- Continue with more employee records up to EMP000050

-- Populate dependant table
INSERT INTO dependant (dependant_id, name, employee_id, birthday, relation, gender) VALUES
('DEP000001', 'Kavya Hasaranga', 'EMP000001', '2012-06-18', 'Daughter', 'FEMALE'),
('DEP000002', 'Sahan Hasaranga', 'EMP000001', '2015-09-25', 'Son', 'MALE'),
('DEP000003', 'Hiruni Oshadi', 'EMP000003', '2018-04-10', 'Daughter', 'FEMALE'),
('DEP000004', 'Aryan Karim', 'EMP000004', '2016-11-30', 'Son', 'MALE'),
('DEP000005', 'Zainab Imran', 'EMP000009', '2019-02-14', 'Daughter', 'FEMALE'),
('DEP000006', 'Lakmal Pradeep', 'EMP000007', '2014-08-22', 'Son', 'MALE'),
('DEP000007', 'Amaya Pradeep', 'EMP000007', '2017-03-11', 'Daughter', 'FEMALE'),
('DEP000008', 'Anika Gurusinha', 'EMP000011', '2020-03-15', 'Daughter', 'FEMALE'),
('DEP000009', 'Rafid Jahan', 'EMP000012', '2018-09-20', 'Son', 'MALE'),
('DEP000010', 'Zara Raza', 'EMP000013', '2019-07-10', 'Daughter', 'FEMALE'),
('DEP000011', 'Amaya Fernando', 'EMP000017', '2019-05-12', 'Daughter', 'FEMALE'),
('DEP000012', 'Rayhaan Uddin', 'EMP000027', '2020-11-03', 'Son', 'MALE'),
('DEP000013', 'Ayesha Nawaz', 'EMP000028', '2018-07-22', 'Daughter', 'FEMALE'),
('DEP000014', 'Mithun Paranavitana', 'EMP000029', '2017-09-14', 'Son', 'MALE'),
('DEP000015', 'Farah Shah', 'EMP000031', '2021-01-30', 'Daughter', 'FEMALE'),
('DEP000016', 'Kasun Hossain', 'EMP000033', '2019-12-05', 'Son', 'MALE'),
('DEP000017', 'Zara Herath', 'EMP000035', '2020-08-17', 'Daughter', 'FEMALE'),
('DEP000018', 'Ibrahim Ahmed', 'EMP000037', '2018-03-25', 'Son', 'MALE'),
('DEP000019', 'Sameera Alam', 'EMP000039', '2021-06-11', 'Daughter', 'FEMALE'),
('DEP000020', 'Aisha Malinga', 'EMP000041', '2019-10-08', 'Daughter', 'FEMALE'),
('DEP000021', 'Rahul Khan', 'EMP000043', '2020-04-19', 'Son', 'MALE'),
('DEP000022', 'Nadia Hossain', 'EMP000045', '2018-12-01', 'Daughter', 'FEMALE'),
('DEP000023', 'Arjun Mendis', 'EMP000047', '2021-02-14', 'Son', 'MALE'),
('DEP000024', 'Zainab Khan', 'EMP000049', '2019-08-27', 'Daughter', 'FEMALE'),
('DEP000025', 'Anjali Cooray', 'EMP000026', '2020-07-15', 'Daughter', 'FEMALE'),
('DEP000026', 'Taufiq Uddin', 'EMP000027', '2019-03-22', 'Son', 'MALE'),
('DEP000027', 'Sana Abeywickrama', 'EMP000032', '2021-01-08', 'Daughter', 'FEMALE'),
('DEP000028', 'Hamza Hossain', 'EMP000033', '2018-11-30', 'Son', 'MALE'),
('DEP000029', 'Noor Herath', 'EMP000035', '2019-09-12', 'Daughter', 'FEMALE'),
('DEP000030', 'Aryan Ahmed', 'EMP000037', '2020-05-25', 'Son', 'MALE'),
('DEP000031', 'Riya Alam', 'EMP000039', '2018-08-17', 'Daughter', 'FEMALE'),
('DEP000032', 'Tharindu Malinga', 'EMP000041', '2021-04-03', 'Son', 'MALE'),
('DEP000033', 'Amira Khan', 'EMP000043', '2019-12-20', 'Daughter', 'FEMALE'),
('DEP000034', 'Farhan Hossain', 'EMP000045', '2020-02-14', 'Son', 'MALE'),
('DEP000035', 'Sanaya Mendis', 'EMP000047', '2018-10-09', 'Daughter', 'FEMALE'),
('DEP000036', 'Zain Khan', 'EMP000049', '2021-06-28', 'Son', 'MALE');

-- Continue with more dependant records

-- Populate employee_attribute table
INSERT INTO employee_attribute (attribute_id, attribute_name) VALUES
('EA001', 'Blood Type'),
('EA002', 'Special Skills'),
('EA003', 'Experience');

-- Populate attribute_value table
INSERT INTO attribute_value (employee_id, attribute_id, value) VALUES
('EMP000001', 'EA001', 'A+'),
('EMP000001', 'EA002', 'Leadership, Strategic Planning'),
('EMP000001', 'EA003', '15 years in HR Management'),
('EMP000002', 'EA001', 'B-'),
('EMP000002', 'EA002', 'Java, Python, Machine Learning'),
('EMP000002', 'EA003', '7 years in Software Development'),
('EMP000003', 'EA001', 'O+'),
('EMP000003', 'EA002', 'Financial Analysis, Risk Management'),
('EMP000003', 'EA003', '5 years in Finance'),
('EMP000004', 'EA001', 'AB-'),
('EMP000004', 'EA002', 'Operations Management, Lean Six Sigma'),
('EMP000004', 'EA003', '10 years in Operations'),
('EMP000005', 'EA001', 'B+'),
('EMP000005', 'EA002', 'Digital Marketing, SEO, Content Strategy'),
('EMP000005', 'EA003', '8 years in Marketing'),
('EMP000006', 'EA001', 'A+'),
('EMP000006', 'EA002', 'Project Management, Agile Methodologies'),
('EMP000006', 'EA003', '6 years in Project Management'),
('EMP000007', 'EA001', 'AB+'),
('EMP000007', 'EA002', 'Customer Service Excellence, Call Center Management'),
('EMP000007', 'EA003', '12 years in Customer Service'),
('EMP000008', 'EA001', 'O-'),
('EMP000008', 'EA002', 'Data Analysis, SQL, Tableau'),
('EMP000011', 'EA001', 'O-'),
('EMP000011', 'EA002', 'Project Management, Agile Methodologies'),
('EMP000011', 'EA003', '6 years in IT Project Management'),
('EMP000012', 'EA001', 'A+'),
('EMP000012', 'EA002', 'Data Analysis, Statistical Modeling'),
('EMP000012', 'EA003', '4 years in Data Science'),
('EMP000013', 'EA001', 'B+'),
('EMP000013', 'EA002', 'Supply Chain Management, Logistics'),
('EMP000013', 'EA003', '7 years in Supply Chain'),
('EMP000014', 'EA001', 'AB+'),
('EMP000014', 'EA002', 'Customer Service, Conflict Resolution'),
('EMP000014', 'EA003', '5 years in Customer Relations'),
('EMP000015', 'EA001', 'B-'),
('EMP000015', 'EA002', 'Sales Strategy, Negotiation'),
('EMP000015', 'EA003', '8 years in Sales Management'),
('EMP000016', 'EA001', 'A-'),
('EMP000016', 'EA002', 'Graphic Design, UI/UX'),
('EMP000016', 'EA003', '4 years in Design'),
('EMP000017', 'EA001', 'O+'),
('EMP000017', 'EA002', 'Software Development, Agile Methodologies'),
('EMP000017', 'EA003', '7 years in Software Engineering'),
('EMP000018', 'EA001', 'A+'),
('EMP000018', 'EA002', 'Data Entry, MS Office Suite'),
('EMP000018', 'EA003', '2 years in Administrative Support'),
('EMP000019', 'EA001', 'B-'),
('EMP000019', 'EA002', 'Inventory Management, Supply Chain Optimization'),
('EMP000019', 'EA003', '6 years in Logistics'),
('EMP000020', 'EA001', 'O-'),
('EMP000020', 'EA002', 'Customer Service, Problem Solving'),
('EMP000020', 'EA003', '3 years in Call Center Operations'),
('EMP000021', 'EA001', 'AB+'),
('EMP000021', 'EA002', 'Financial Modeling, Risk Analysis'),
('EMP000021', 'EA003', '5 years in Investment Banking'),
('EMP000022', 'EA001', 'A-'),
('EMP000022', 'EA002', 'Content Writing, SEO'),
('EMP000022', 'EA003', '4 years in Digital Marketing'),
('EMP000023', 'EA001', 'B+'),
('EMP000023', 'EA002', 'Quality Control, Six Sigma'),
('EMP000023', 'EA003', '7 years in Manufacturing'),
('EMP000024', 'EA001', 'O+'),
('EMP000024', 'EA002', 'Recruitment, Employee Relations'),
('EMP000024', 'EA003', '5 years in Human Resources'),
('EMP000025', 'EA001', 'AB-'),
('EMP000025', 'EA002', 'Sales Forecasting, CRM Systems'),
('EMP000025', 'EA003', '8 years in Sales Management'),
('EMP000026', 'EA001', 'A+'),
('EMP000026', 'EA002', 'Graphic Design, Adobe Creative Suite'),
('EMP000026', 'EA003', '4 years in Marketing Design'),
('EMP000027', 'EA001', 'B-'),
('EMP000027', 'EA002', 'Network Security, Firewall Management'),
('EMP000027', 'EA003', '6 years in IT Security'),
('EMP000028', 'EA001', 'O-'),
('EMP000028', 'EA002', 'Social Media Marketing, Content Strategy'),
('EMP000028', 'EA003', '3 years in Digital Marketing'),
('EMP000029', 'EA001', 'AB+'),
('EMP000029', 'EA002', 'Product Development, Agile Methodologies'),
('EMP000029', 'EA003', '7 years in Product Management'),
('EMP000030', 'EA001', 'A-'),
('EMP000030', 'EA002', 'Financial Reporting, Auditing'),
('EMP000030', 'EA003', '5 years in Accounting'),
('EMP000031', 'EA001', 'B+'),
('EMP000031', 'EA002', 'Supply Chain Optimization, Inventory Control'),
('EMP000031', 'EA003', '6 years in Logistics Management'),
('EMP000032', 'EA001', 'O+'),
('EMP000032', 'EA002', 'Customer Experience, Service Design'),
('EMP000032', 'EA003', '4 years in Customer Success'),
('EMP000033', 'EA001', 'AB-'),
('EMP000033', 'EA002', 'Business Analysis, Process Improvement'),
('EMP000033', 'EA003', '5 years in Operations'),
('EMP000034', 'EA001', 'A+'),
('EMP000034', 'EA002', 'Content Creation, Video Editing'),
('EMP000034', 'EA003', '3 years in Multimedia Production'),
('EMP000035', 'EA001', 'B-'),
('EMP000035', 'EA002', 'Machine Learning, Data Visualization'),
('EMP000035', 'EA003', '6 years in Data Science'),
('EMP000036', 'EA001', 'O-'),
('EMP000036', 'EA002', 'UI/UX Design, Prototyping'),
('EMP000036', 'EA003', '2 years in Product Design'),
('EMP000037', 'EA001', 'AB+'),
('EMP000037', 'EA002', 'Project Planning, Risk Management'),
('EMP000037', 'EA003', '7 years in Project Management'),
('EMP000038', 'EA001', 'A-'),
('EMP000038', 'EA002', 'Legal Research, Contract Drafting'),
('EMP000038', 'EA003', '4 years in Corporate Law'),
('EMP000039', 'EA001', 'B+'),
('EMP000039', 'EA002', 'Database Administration, SQL'),
('EMP000039', 'EA003', '5 years in IT Infrastructure'),
('EMP000040', 'EA001', 'O+'),
('EMP000040', 'EA002', 'Public Relations, Crisis Management'),
('EMP000040', 'EA003', '6 years in Corporate Communications'),
('EMP000041', 'EA001', 'AB-'),
('EMP000041', 'EA002', 'Agile Coaching, Scrum Master'),
('EMP000041', 'EA003', '8 years in Software Development'),
('EMP000042', 'EA001', 'A+'),
('EMP000042', 'EA002', 'Market Research, Data Analysis'),
('EMP000042', 'EA003', '4 years in Marketing Analytics'),
('EMP000043', 'EA001', 'B-'),
('EMP000043', 'EA002', 'Financial Planning, Investment Strategy'),
('EMP000043', 'EA003', '7 years in Wealth Management'),
('EMP000044', 'EA001', 'O-'),
('EMP000044', 'EA002', 'Event Planning, Vendor Management'),
('EMP000044', 'EA003', '3 years in Corporate Events'),
('EMP000045', 'EA001', 'AB+'),
('EMP000045', 'EA002', 'Quality Assurance, Test Automation'),
('EMP000045', 'EA003', '5 years in Software Testing'),
('EMP000046', 'EA001', 'A-'),
('EMP000046', 'EA002', 'Technical Writing, Documentation'),
('EMP000046', 'EA003', '4 years in Product Documentation'),
('EMP000047', 'EA001', 'B+'),
('EMP000047', 'EA002', 'Business Development, Partnership Management'),
('EMP000047', 'EA003', '6 years in Sales and Partnerships'),
('EMP000048', 'EA001', 'O+'),
('EMP000048', 'EA002', 'Employee Training, Learning Management Systems'),
('EMP000048', 'EA003', '5 years in Learning and Development'),
('EMP000049', 'EA001', 'AB-'),
('EMP000049', 'EA002', 'Brand Strategy, Market Positioning'),
('EMP000049', 'EA003', '7 years in Brand Management'),
('EMP000050', 'EA001', 'AB-'),
('EMP000050', 'EA002', 'Financial Analysis, Risk Assessment'),
('EMP000050', 'EA003', '6 years in Finance');

-- Continue with more attribute value records

-- Populate emergency_contact table
INSERT INTO emergency_contact (employee_id, contact_no, relationship, contact_name) VALUES
('EMP000001', 771234567, 'Spouse', 'Mihiri Hasaranga'),
('EMP000002', 772345678, 'Parent', 'Anura Rukshan'),
('EMP000003', 773456789, 'Spouse', 'Kasun Perera'),
('EMP000004', 1812345678, 'Sibling', 'Priya Karim'),
('EMP000005', 3001234567, 'Parent', 'Ahmed Zahra'),
('EMP000006', 774567890, 'Spouse', 'Ranjan Lakmali'),
('EMP000007', 775678901, 'Sibling', 'Ishara Pradeep'),
('EMP000008', 1823456789, 'Parent', 'Abdul Begum'),
('EMP000009', 3112345678, 'Spouse', 'Fatima Imran'),
('EMP000010', 776789012, 'Parent', 'Kumari Nisansala'),
('EMP000011', 777890123, 'Sibling', 'Chamara Gurusinha'),
('EMP000012', 1834567890, 'Spouse', 'Rashid Khan'),
('EMP000013', 3123456789, 'Parent', 'Fatima Raza'),
('EMP000014', 778901234, 'Sibling', 'Samantha Perera'),
('EMP000015', 1845678901, 'Spouse', 'Nasreen Ahmed'),
('EMP000016', 3134567890, 'Parent', 'Imran Malik'),
('EMP000017', 779012345, 'Spouse', 'Chamathka Fernando'),
('EMP000018', 1856789012, 'Parent', 'Mohammad Akter'),
('EMP000019', 3145678901, 'Sibling', 'Ali Tariq'),
('EMP000020', 770123456, 'Parent', 'Lalith Madushani'),
('EMP000021', 1867890123, 'Spouse', 'Fariha Hasan'),
('EMP000022', 3156789012, 'Parent', 'Tariq Riaz'),
('EMP000023', 771234567, 'Sibling', 'Chamathka Vaas'),
('EMP000024', 1878901234, 'Spouse', 'Imran Akhtar'),
('EMP000025', 3167890123, 'Parent', 'Amina Butt'),
('EMP000026', 773456789, 'Parent', 'Rohan Cooray'),
('EMP000027', 1889012345, 'Spouse', 'Sabina Uddin'),
('EMP000028', 3178901234, 'Sibling', 'Asad Nawaz'),
('EMP000029', 774567890, 'Parent', 'Kumari Paranavitana'),
('EMP000030', 1890123456, 'Spouse', 'Mahmud Islam'),
('EMP000031', 3189012345, 'Sibling', 'Amir Shah'),
('EMP000032', 775678901, 'Parent', 'Nishanth Abeywickrama'),
('EMP000033', 1801234567, 'Spouse', 'Fatima Hossain'),
('EMP000034', 3190123456, 'Sibling', 'Imran Khalid'),
('EMP000035', 776789012, 'Parent', 'Chaminda Herath'),
('EMP000036', 1812345678, 'Spouse', 'Farzana Akter'),
('EMP000037', 3101234567, 'Sibling', 'Omar Ahmed'),
('EMP000038', 777890123, 'Parent', 'Lakshmi Edirisinghe'),
('EMP000039', 1823456789, 'Spouse', 'Nasreen Alam'),
('EMP000040', 3112345678, 'Sibling', 'Ali Qamar'),
('EMP000041', 778901234, 'Parent', 'Sanjaya Malinga'),
('EMP000042', 1834567890, 'Spouse', 'Rashid Yasmin'),
('EMP000043', 3123456789, 'Sibling', 'Saira Khan'),
('EMP000044', 779012345, 'Parent', 'Upul Priyasad'),
('EMP000045', 1845678901, 'Spouse', 'Tahmina Hossain'),
('EMP000046', 3134567890, 'Sibling', 'Asif Mani'),
('EMP000047', 770123456, 'Parent', 'Nimal Mendis'),
('EMP000048', 1856789012, 'Spouse', 'Farid Imroz'),
('EMP000049', 3145678901, 'Sibling', 'Sadia Khan'),
('EMP000050', 772345678, 'Spouse', 'Mihiri Chandimal');

-- Continue with more emergency contact records

-- Populate leaves table
INSERT INTO leaves (leave_id, start_date, end_date, leave_type, employee_id, leave_status, reason) VALUES
(UUID(), '2024-04-10', '2024-04-15', 'Annual', 'EMP000001', 'Approved', 'Family vacation'),
(UUID(), '2024-05-05', '2024-05-05', 'Casual', 'EMP000002', 'Approved', 'Personal errands'),
(UUID(), '2024-06-20', '2024-09-19', 'Maternity', 'EMP000003', 'Approved', 'Maternity leave'),
(UUID(), '2024-07-01', '2024-07-03', 'Annual', 'EMP000004', 'Pending', 'Wedding anniversary'),
(UUID(), '2024-08-15', '2024-08-15', 'Casual', 'EMP000005', 'Approved', 'Medical appointment'),
(UUID(), '2024-09-10', '2024-09-14', 'Annual', 'EMP000006', 'Approved', 'Family event'),
(UUID(), '2024-10-20', '2024-10-20', 'Casual', 'EMP000007', 'Pending', 'House moving'),
(UUID(), '2024-11-05', '2024-11-07', 'Annual', 'EMP000008', 'Approved', 'Personal development seminar'),
(UUID(), '2024-12-25', '2024-12-26', 'Annual', 'EMP000009', 'Approved', 'Christmas holidays'),
(UUID(), '2025-01-10', '2025-01-10', 'Casual', 'EMP000010', 'Pending', 'Visa appointment');

-- Continue with more leave records

-- Populate organization table
INSERT INTO organization (id, name, reg_no, main_branch, ceo) VALUES
(1, 'Jupyter Apparel', 'REG12345', 'B0001', 'EMP000001');

-- Populate user table
INSERT INTO user (employee_id, username, password, role) VALUES
('EMP000001', 'dimuth.hasaranga', SHA2('password123', 256), 'Admin'),
('EMP000002', 'tenil.rukshan', SHA2('password456', 256), 'Employee_lvl2'),
('EMP000003', 'nethmi.oshadi', SHA2('password789', 256), 'Manager'),
('EMP000004', 'rahul.karim', SHA2('passwordabc', 256), 'Manager'),
('EMP000005', 'fatima.zahra', SHA2('passworddef', 256), 'Manager'),
('EMP000006', 'chamathka.lakmali', SHA2('passwordghi', 256), 'Employee_lvl2'),
('EMP000007', 'nuwan.pradeep', SHA2('passwordjkl', 256), 'Manager'),
('EMP000008', 'ayesha.begum', SHA2('passwordmno', 256), 'Employee_lvl1'),
('EMP000009', 'muhammad.imran', SHA2('passwordpqr', 256), 'Employee_lvl2'),
('EMP000010', 'sachini.nisansala', SHA2('passwordstu', 256), 'Employee_lvl1'),
('EMP000011', 'asanka.gurusinha', SHA2('passwordvwx', 256), 'Employee_lvl1'),
('EMP000012', 'nusrat.jahan', SHA2('passwordyz1', 256), 'Employee_lvl2'),
('EMP000013', 'ahmed.raza', SHA2('password234', 256), 'Employee_lvl2'),
('EMP000014', 'ramani.perera', SHA2('password567', 256), 'Employee_lvl1'),
('EMP000015', 'farhan.ahmed', SHA2('password890', 256), 'Employee_lvl2'),
('EMP000016', 'sana.malik', SHA2('passwordabc', 256), 'Employee_lvl1'),
('EMP000017', 'dilshan.fernando', SHA2('passworddef', 256), 'Employee_lvl2'),
('EMP000018', 'tahmina.akter', SHA2('passwordghi', 256), 'Employee_lvl1'),
('EMP000019', 'usman.tariq', SHA2('passwordjkl', 256), 'Employee_lvl2'),
('EMP000020', 'ishara.madushani', SHA2('passwordmno', 256), 'Employee_lvl1'),
('EMP000021', 'zubair.hasan', SHA2('passwordpqr', 256), 'Employee_lvl2'),
('EMP000022', 'amna.riaz', SHA2('passwordstu', 256), 'Employee_lvl1'),
('EMP000023', 'chaminda.vaas', SHA2('passwordvwx', 256), 'Employee_lvl2'),
('EMP000024', 'nasreen.akhtar', SHA2('passwordyz2', 256), 'Employee_lvl1'),
('EMP000025', 'imran.butt', SHA2('password345', 256), 'Employee_lvl2'),
('EMP000026', 'nilushi.cooray', SHA2('password678', 256), 'Employee_lvl1'),
('EMP000027', 'rahim.uddin', SHA2('password901', 256), 'Employee_lvl2'),
('EMP000028', 'sadia.nawaz', SHA2('passwordbcd', 256), 'Employee_lvl1'),
('EMP000029', 'tharanga.paranavitana', SHA2('passwordefg', 256), 'Employee_lvl2'),
('EMP000030', 'farhana.islam', SHA2('passwordhij', 256), 'Employee_lvl1'),
('EMP000031', 'yasir.shah', SHA2('passwordklm', 256), 'Employee_lvl2'),
('EMP000032', 'sanduni.abeywickrama', SHA2('passwordnop', 256), 'Employee_lvl1'),
('EMP000033', 'kamal.hossain', SHA2('passwordqrs', 256), 'Employee_lvl2'),
('EMP000034', 'asma.khalid', SHA2('passwordtuv', 256), 'Employee_lvl1'),
('EMP000035', 'rangana.herath', SHA2('passwordwxy', 256), 'Employee_lvl2'),
('EMP000036', 'shabnam.akter', SHA2('passwordz12', 256), 'Employee_lvl1'),
('EMP000037', 'saad.ahmed', SHA2('password456', 256), 'Employee_lvl2'),
('EMP000038', 'hansini.edirisinghe', SHA2('password789', 256), 'Employee_lvl1'),
('EMP000039', 'mahbub.alam', SHA2('password012', 256), 'Employee_lvl2'),
('EMP000040', 'saba.qamar', SHA2('passwordcde', 256), 'Employee_lvl1'),
('EMP000041', 'lasith.malinga', SHA2('passwordfgh', 256), 'Employee_lvl2'),
('EMP000042', 'sabina.yasmin', SHA2('passwordijk', 256), 'Employee_lvl1'),
('EMP000043', 'fawad.khan', SHA2('passwordlmn', 256), 'Employee_lvl2'),
('EMP000044', 'sheshadri.priyasad', SHA2('passwordopq', 256), 'Employee_lvl1'),
('EMP000045', 'najmul.hossain', SHA2('passwordrst', 256), 'Employee_lvl2'),
('EMP000046', 'hira.mani', SHA2('passworduvw', 256), 'Employee_lvl1'),
('EMP000047', 'kusal.mendis', SHA2('passwordxyz', 256), 'Employee_lvl2'),
('EMP000048', 'nusrat.imroz', SHA2('password123', 256), 'Employee_lvl1'),
('EMP000049', 'mahira.khan', SHA2('password234', 256), 'Employee_lvl2'),
('EMP000050', 'dinesh.chandimal', SHA2('password345', 256), 'Employee_lvl1');
