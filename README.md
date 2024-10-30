# HRMS Project Backend

## Table of Contents
- [Introduction](#introduction)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Configuration](#configuration)
- [Database Setup](#database-setup)
- [Running the Application](#running-the-application)
- [API Endpoints](#api-endpoints)
- [Contributing](#contributing)
- [License](#license)

## Introduction

The **HRMS Project Backend** is the server-side component of the Human Resource Management System. It is built using Node.js and Express.js, interfacing with a MySQL database to manage and process employee data, authentication, leave management, and reporting functionalities.

## Features

- **Authentication:** Secure login system using JWT for role-based access control.
- **Employee Management:** CRUD operations for employee data, including dependents and emergency contacts.
- **Leave Management:** Submit, approve, and track leaves with various statuses.
- **Reporting:** Generate reports based on employee data and leave records.
- **Security:** Implements best practices for password hashing and data protection.
- **Middleware:** Custom middleware for token authentication and role authorization.

## Technologies Used

- **Node.js & Express.js:** For building the server and handling HTTP requests.
- **MySQL:** Database management system for storing all HR-related data.
- **JWT (jsonwebtoken):** For secure authentication.
- **bcrypt:** For hashing passwords.
- **Sequelize ORM:** For database interactions.
- **Cors & Cookie-Parser:** For handling cross-origin requests and parsing cookies.
- **Nodemon:** For automatic server restarts during development.

## Installation

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/devinda0/HRMS-Project-Backend.git
   ```
2. **Navigate to the Project Directory:**
   ```bash
   cd HRMS-Project-Backend
   ```
3. **Install Dependencies:**
   ```bash
   npm install
   ```

## Configuration

1. **Environment Variables:**
   
   Create a `.env` file in the root directory and add the following:
   ```env
   # Server Port
   PORT=8080
   
   # Database Configuration
   DB_HOST=your_database_host
   DB_USER=your_database_user
   DB_PASSWORD=your_database_password
   DB_NAME=your_database_name
   
   # Mail Server Configuration
   MAIL_HOST=your_mail_host
   MAIL_PORT=your_mail_port
   MAIL_USER=your_email_address
   MAIL_PASSWORD=your_email_password
   
   # Authentication Secrets
   ACCESS_TOKEN_SECRET=your_access_token_secret
   REFRESH_TOKEN_SECRET=your_refresh_token_secret
   ```

## Database Setup

1. **Install MySQL:**
   
   Ensure that MySQL is installed and running on your machine.

2. **Create Database and Tables:**
   
   Import the SQL files located in the `database` directory.

   ```bash
   mysql -u your_db_user -p < database/Tables.sql
   mysql -u your_db_user -p < database/Indexing.sql
   mysql -u your_db_user -p < database/Views.sql
   mysql -u your_db_user -p < database/data.sql
   mysql -u your_db_user -p < database/Table_data.sql
   ```

3. **Verify Database:**
   
   Ensure that all tables, indexes, and views are created successfully.

## Running the Application

### Development Mode

The backend uses Nodemon for automatic server restarts.
```bash
npm run dev
```

### Production Mode
```bash
npm start
```

The server will run on `http://localhost:8080` by default.

## API Endpoints

### User Authentication

- **POST /user/signup:** Register a new user.
- **POST /user/login:** Authenticate a user and receive a JWT token.

### Employee Management

- **GET /pim/employees:** Retrieve all employees.
- **POST /pim/employees/dependents:** Add a dependent to an employee.
- **POST /pim/employees/contacts:** Add an emergency contact.
- **PUT /pim/employees/contacts:** Update an emergency contact.

### Leave Management

- **POST /absence/leaves:** Submit a new leave application.
- **GET /absence/leaves/status/:leave_status:** Retrieve leaves based on status.
- **GET /absence/leaves/subordinates/:leave_status:** Get subordinate leaves based on status.
- **PUT /absence/leaves/approve/:leave_id:** Approve a leave application.

### Reporting

- **GET /reports/employees:** Generate employee overview reports.
- **GET /reports/leaves:** Generate leave summary reports.

## Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
