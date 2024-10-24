INSERT INTO branch (branch_name, address) VALUES
('Adams LLC', '9810 Parsons Walk, Reynoldsville, MN 26202'),
('Gonzales-Turner', '03833 Jones Bridge Apt. 094, South Kennethside, NY 46680'),
('Horne-Cooper', '507 Guzman Station Apt. 211, East Sarahfurt, WI 67667'),
('Mcpherson Group', 'Unit 7765 Box 4753, DPO AP 95036'),
('Brooks-Dawson', '253 Jessica Mills Suite 887, New Michael, NJ 96689');

INSERT INTO department (department_name, budget) VALUES
('Occupational', 364823.37),
('Advertising', 280320.40),
('Solicitor,', 184059.88),
('Horticultural', 363913.22),
('Armed', 450457.84);

INSERT INTO job_title (job_title, department_name) VALUES
('Print production planner', 'Horticultural'),
('Therapist, sports', 'Solicitor,'),
('Research scientist (life sciences)', 'Advertising'),
('Dramatherapist', 'Armed'),
('Armed forces training and education officer', 'Armed'),
('Producer, television/film/video', 'Advertising'),
('Building control surveyor', 'Solicitor,'),
('Chief Operating Officer', 'Solicitor,'),
('Merchandiser, retail', 'Occupational'),
('Mining engineer', 'Occupational');

INSERT INTO pay_grade (pay_grade, basic_salary) VALUES
('PG001', 56221.11),
('PG002', 128866.27),
('PG003', 83235.56),
('PG004', 122056.05),
('PG005', 117814.44),
('PG006', 101243.48),
('PG007', 105983.42),
('PG008', 133402.26),
('PG009', 101530.10),
('PG010', 98885.54);

INSERT INTO leave_count (pay_grade, annual, casual, maternity, no_pay) VALUES
('PG001', 50, 50, 50, 50),
('PG002', 50, 50, 50, 50),
('PG003', 50, 50, 50, 50),
('PG004', 50, 50, 50, 50),
('PG005', 50, 50, 50, 50),
('PG006', 50, 50, 50, 50),
('PG007', 50, 50, 50, 50),
('PG008', 50, 50, 50, 50),
('PG009', 50, 50, 50, 50),
('PG010', 50, 50, 50, 50);


INSERT INTO employee (name, email, address, birthday, marital_status, supervisor, job_title_id, pay_grade, employment_status, branch_id) VALUES
('Aaron Mooney', 'curtisisaiah@ramirez-baker.com', '4974 Smith Via, East Jefferyville, AK 03022', '1974-12-23', 'Married', NULL, 'JT0006', 'PG009', 'Permanent', 'BR003'),
('Kathleen Williams', 'vwhite@gmail.com', '9419 Martin Trail Apt. 690, Lanestad, NC 90407', '1975-04-27', 'Single', 'EMP000001', 'JT0004', 'PG004', 'Contract_Parttime', 'BR002'),
('Joseph Nguyen', 'danachavez@noble.net', '302 Francis Flats Apt. 266, South Louis, GA 25118', '1994-09-03', 'Single', 'EMP000002', 'JT0010', 'PG007', 'Contract_Fulltime', 'BR002'),
('Brian Tran', 'alexandriahatfield@yahoo.com', '83177 Reed Lake Apt. 480, Alexandertown, IA 56524', '1997-04-23', 'Single', 'EMP000001', 'JT0009', 'PG003', 'Intern_Fulltime', 'BR001'),
('Tammy Wood', 'clifford65@hotmail.com', '78853 Mason Bypass, Gloverside, KY 92778', '1974-04-25', 'Married', 'EMP000001', 'JT0009', 'PG008', 'Contract_Parttime', 'BR003'),
('Anthony Valencia', 'robert81@ortiz.com', '635 Dean Springs, Porterborough, FL 60247', '2003-08-26', 'Divorced', 'EMP000005', 'JT0005', 'PG004', 'Intern_Parttime', 'BR003'),
('Daisy Herman', 'morriskimberly@thomas.com', '05482 Cynthia Flats Suite 185, Griffinland, DC 97248', '1973-01-20', 'Married', 'EMP000003', 'JT0001', 'PG002', 'Freelance', 'BR005'),
('Nicholas George', 'amber10@gmail.com', '24891 Virginia Crest Apt. 461, Port Kristen, MS 33276', '2002-06-06', 'Divorced', 'EMP000004', 'JT0007', 'PG005', 'Intern_Parttime', 'BR002'),
('Rodney Mcdaniel', 'seanmathis@erickson.info', '566 Robert Lake Suite 772, North Desireefurt, MS 90096', '1976-12-25', 'Single', 'EMP000005', 'JT0002', 'PG010', 'Contract_Fulltime', 'BR005'),
('Jeffrey Parker', 'darleneayala@gmail.com', '27904 Amy Alley, Hillmouth, WY 07536', '1986-12-18', 'Married', 'EMP000009', 'JT0005', 'PG003', 'Contract_Fulltime', 'BR001'),
('Theresa Garcia', 'gabrielle84@weber.info', '581 Megan Brooks Apt. 370, South Matthewfort, NC 76379', '1982-01-14', 'Divorced', 'EMP000007', 'JT0007', 'PG002', 'Contract_Fulltime', 'BR002'),
('Ronald Johnson', 'lauren86@eaton.com', '16277 David Lights Suite 491, West Alexandra, MT 11428', '1991-12-11', 'Married', 'EMP000009', 'JT0009', 'PG001', 'Permanent', 'BR004'),
('Ann Lopez', 'gguzman@yahoo.com', '5192 Stewart Creek, Jasonchester, RI 75358', '1983-04-25', 'Single', 'EMP000010', 'JT0001', 'PG005', 'Intern_Fulltime', 'BR001'),
('Patricia Brooks', 'sandramartin@cook.net', '114 Garcia Crest Apt. 193, South Mallory, OR 06617', '1974-05-30', 'Married', 'EMP000013', 'JT0006', 'PG006', 'Permanent', 'BR003'),
('Shawn Smith', 'amanda51@dunn.com', '500 Michelle Course, Vincentburgh, TX 14139', '1984-08-08', 'Single', 'EMP000011', 'JT0003', 'PG005', 'Freelance', 'BR005'),
('Debra Washington', 'theresa52@schneider.com', '2155 Warren Ford, Scottland, FL 95034', '1992-02-01', 'Single', 'EMP000010', 'JT0002', 'PG002', 'Freelance', 'BR005'),
('Barbara Wood', 'fhall@yahoo.com', '862 Elizabeth Bypass, North Johnfurt, UT 81147', '1993-01-13', 'Married', 'EMP000015', 'JT0006', 'PG007', 'Permanent', 'BR003'),
('Donna Bailey', 'hollowaydavid@edwards.com', '7495 Dillon Isle, Rhodesstad, OH 81504', '1976-04-06', 'Divorced', 'EMP000009', 'JT0003', 'PG003', 'Contract_Fulltime', 'BR001'),
('Matthew Stewart', 'brian09@hotmail.com', '332 Nathaniel Tunnel Apt. 392, Lake Jasonland, AZ 54793', '1979-11-16', 'Married', 'EMP000017', 'JT0006', 'PG010', 'Permanent', 'BR003'),
('Richard Rivera', 'richard.rogers@gmail.com', '160 Morales Knoll Apt. 841, Leonardland, VA 27883', '1990-06-20', 'Single', 'EMP000014', 'JT0008', 'PG007', 'Permanent', 'BR001'),
('Joshua Bryant', 'lisajones@parker.org', '454 Carrillo Shore Suite 725, Lake Frankchester, WA 20296', '1992-01-29', 'Single', 'EMP000003', 'JT0009', 'PG003', 'Freelance', 'BR001'),
('Stephen Foster', 'lauren78@gmail.com', '40840 Lee Rue, Mariafurt, NM 96535', '1977-07-22', 'Divorced', 'EMP000020', 'JT0003', 'PG007', 'Intern_Fulltime', 'BR005'),
('David Davis', 'williamschristina@bennett.net', '10927 Schwartz Fields, West Maryport, ND 40411', '1983-07-12', 'Single', 'EMP000011', 'JT0008', 'PG006', 'Freelance', 'BR005'),
('Linda Murphy', 'donnie75@yahoo.com', '36138 Marshall Flat, North Matthew, ME 97038', '1971-05-27', 'Married', 'EMP000008', 'JT0006', 'PG009', 'Freelance', 'BR004'),
('Kevin Cooper', 'rsnyder@powell.net', '01022 West Brooks Suite 641, Thomashaven, MD 32493', '1988-10-18', 'Single', 'EMP000005', 'JT0008', 'PG010', 'Freelance', 'BR004'),
('Mark Torres', 'evelynvaughn@kelley.com', '3886 Miller Forks Apt. 382, Davidside, IL 54147', '1984-12-12', 'Married', 'EMP000013', 'JT0001', 'PG001', 'Intern_Fulltime', 'BR004'),
('Charles Ward', 'mariamendoza@yahoo.com', '7412 Frye Stream Apt. 420, Port Williamport, SC 42655', '1980-09-26', 'Divorced', 'EMP000022', 'JT0008', 'PG005', 'Freelance', 'BR003'),
('James Cook', 'christian21@craig.com', '440 Ashley Crescent, East Alexistown, MI 04092', '1975-01-05', 'Married', 'EMP000014', 'JT0001', 'PG003', 'Permanent', 'BR001'),
('Timothy King', 'katrina81@bennett.com', '31863 Taylor Ranch, New Briannafort, MO 35491', '1984-10-19', 'Single', 'EMP000027', 'JT0002', 'PG010', 'Freelance', 'BR002'),
('Nancy Price', 'seancurtis@hotmail.com', '9872 Shannon Plains, Port Rachelchester, SD 49601', '1977-09-02', 'Single', 'EMP000026', 'JT0009', 'PG004', 'Contract_Fulltime', 'BR005'),
('Michael Hill', 'michaelhill@example.com', '850 Hilltop Heights, Samtown, AK 84055', '1991-03-01', 'Single', 'EMP000010', 'JT0007', 'PG006', 'Permanent', 'BR003'),
('Mary Alexander', 'maryalexander@samplemail.com', '321 Green Crescent, Silverlake, CA 42155', '1988-12-10', 'Divorced', 'EMP000031', 'JT0006', 'PG005', 'Permanent', 'BR004'),
('Daniel Harris', 'danielharris@newmail.com', '7556 Maple View, Woodland City, MT 95830', '1990-11-07', 'Married', 'EMP000014', 'JT0002', 'PG002', 'Freelance', 'BR005'),
('Kimberly Edwards', 'kimedwards@companymail.com', '9787 Valley Road, North Creek, CO 80977', '1995-08-21', 'Single', 'EMP000020', 'JT0005', 'PG004', 'Permanent', 'BR002'),
('Eric Stewart', 'ericstewart@webmail.com', '563 Lakeview Lane, Sandlake, WV 23641', '1979-06-28', 'Married', 'EMP000017', 'JT0008', 'PG009', 'Permanent', 'BR003'),
('Shirley Holmes', 'shirleyholmes@example.net', '8475 Sunset Ave, Skycity, OR 70914', '1985-03-14', 'Single', 'EMP000019', 'JT0006', 'PG010', 'Freelance', 'BR001'),
('Johnny Ford', 'johnnyford@randommail.com', '678 Oak Street, Pinewood, OK 72211', '1982-07-24', 'Divorced', 'EMP000031', 'JT0009', 'PG006', 'Permanent', 'BR002'),
('Cynthia Jenkins', 'cynthiajenkins@randommail.com', '3541 Riverbend, Woodtown, KY 40564', '1976-02-29', 'Single', 'EMP000025', 'JT0007', 'PG007', 'Permanent', 'BR005'),
('Jason Adams', 'jasonadams@example.net', '4322 Meadow Court, Elmwood, NJ 45821', '1990-09-16', 'Single', 'EMP000033', 'JT0003', 'PG009', 'Permanent', 'BR003'),
('Angela Lee', 'angelalee@samplemail.com', '5563 Bridge Street, Rivertown, NE 80566', '1993-05-19', 'Single', 'EMP000027', 'JT0006', 'PG008', 'Contract_Fulltime', 'BR002'),
('Jennifer Brown', 'jenniferbrown@samplemail.com', '9654 Mountain Road, Forestcity, AR 96428', '1989-10-25', 'Married', 'EMP000036', 'JT0008', 'PG005', 'Freelance', 'BR001'),
('David Clark', 'davidclark@samplemail.com', '243 Sunset Blvd, Seaside, LA 92246', '1986-04-29', 'Divorced', 'EMP000014', 'JT0005', 'PG010', 'Permanent', 'BR003'),
('Michelle Martin', 'michellemartin@example.com', '7581 Greenhill Drive, Clearwater, ND 90673', '1998-09-03', 'Single', 'EMP000039', 'JT0002', 'PG002', 'Contract_Parttime', 'BR005'),
('Brandon King', 'brandonking@webmail.com', '314 Forest Avenue, Maplewood, DE 80518', '1977-06-12', 'Single', 'EMP000017', 'JT0007', 'PG007', 'Freelance', 'BR004'),
('Laura Gonzalez', 'lauragonzalez@webmail.com', '6499 High Street, Clearcity, VA 53692', '1990-08-11', 'Single', 'EMP000042', 'JT0003', 'PG008', 'Freelance', 'BR002'),
('Jessica Robinson', 'jessicarobinson@samplemail.com', '157 River View, Stonybrook, AL 30214', '1983-05-22', 'Single', 'EMP000039', 'JT0006', 'PG007', 'Permanent', 'BR003'),
('Ethan Young', 'ethanyoung@example.com', '2541 Silverstone Way, Wooddale, NH 60983', '1994-02-14', 'Single', 'EMP000021', 'JT0001', 'PG006', 'Permanent', 'BR004'),
('Emily Moore', 'emilymoore@samplemail.com', '8959 Eastwood Blvd, Sunnydale, IL 50629', '1975-12-19', 'Divorced', 'EMP000013', 'JT0004', 'PG004', 'Contract_Fulltime', 'BR005'),
('Keith Mitchell', 'keithmitchell@samplemail.com', '6592 Valley Blvd, Riverland, AZ 70762', '1992-07-07', 'Single', 'EMP000031', 'JT0009', 'PG009', 'Permanent', 'BR003'),
('Beth Manning', 'bethmanning@example.com', '306 Everett Corner Apt. 719, Raymondmouth, OH 15486', '2001-11-17', 'Divorced', 'EMP000001', 'JT0010', 'PG010', 'Permanent', 'BR005');


INSERT INTO dependant (name, employee_id, birthday, relation, gender) VALUES
('Stacy Williams', 'EMP000021', '2012-12-26', 'Parent', 'MALE'),
('Daniel Bentley', 'EMP000010', '2010-06-02', 'Spouse', 'MALE'),
('Darrell Sharp', 'EMP000001', '2009-07-24', 'Spouse', 'MALE'),
('Rachel Norton', 'EMP000008', '2022-07-02', 'Child', 'MALE'),
('Jeffrey Jensen', 'EMP000012', '2003-11-12', 'Parent', 'MALE');


INSERT INTO emergency_contact (employee_id, contact_no, relationship, contact_name)
VALUES 
('EMP000001', 9876543210, 'Father', 'John Doe'),
('EMP000001', 9123456789, 'Mother', 'Jane Doe'),
('EMP000002', 9871234560, 'Spouse', 'Emily Smith'),
('EMP000002', 9987654321, 'Brother', 'Michael Smith'),
('EMP000003', 9876541234, 'Sister', 'Sophia Johnson'),
('EMP000003', 9123123123, 'Friend', 'Lucas Brown'),
('EMP000004', 8888888888, 'Father', 'David Clark'),
('EMP000005', 7777777777, 'Spouse', 'Sarah Clark'),
('EMP000006', 6666666666, 'Mother', 'Emma White'),
('EMP000007', 9999999999, 'Uncle', 'Jacob Wilson');

