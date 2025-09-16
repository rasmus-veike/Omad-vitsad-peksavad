-- ========================
-- MySQL DDL for Praktikaportaali
-- ========================

-- Student
CREATE TABLE Student (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pin VARCHAR(20) NOT NULL UNIQUE,
    phone VARCHAR(20),
    group_name VARCHAR(50)
);

-- Student_Grade
CREATE TABLE Student_Grade (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    subject VARCHAR(255) NOT NULL,
    grade VARCHAR(255) NOT NULL,
    INDEX(student_id),
    FOREIGN KEY (student_id) REFERENCES Student(id) ON DELETE CASCADE
);

-- Company
CREATE TABLE Company (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    regnr VARCHAR(50) NOT NULL UNIQUE,
    contact_first_name VARCHAR(100),
    contact_last_name VARCHAR(100),
    contact_phone VARCHAR(20),
    contact_email VARCHAR(100),
    logo VARCHAR(255)
);

-- Contract
CREATE TABLE Contract (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    company_id INT NOT NULL,
    file_ext VARCHAR(10),
    start_date DATE,
    end_date DATE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX(student_id),
    INDEX(company_id),
    FOREIGN KEY (student_id) REFERENCES Student(id) ON DELETE CASCADE,
    FOREIGN KEY (company_id) REFERENCES Company(id) ON DELETE CASCADE
);

-- Job_Offer
CREATE TABLE Job_Offer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    company_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    deadline DATETIME,
    poster VARCHAR(255),
    tags VARCHAR(255),
    speciality ENUM('IT','Finance','Engineering','Marketing','Other'),
    INDEX(company_id),
    FOREIGN KEY (company_id) REFERENCES Company(id) ON DELETE CASCADE
);

-- Student_Job_Offer
CREATE TABLE Student_Job_Offer (
    student_id INT NOT NULL,
    job_offer_id INT NOT NULL,
    accepted_at DATETIME,
    accepted_by INT,
    rejected_at DATETIME,
    rejected_by INT,
    rejected_comment TEXT,
    PRIMARY KEY(student_id, job_offer_id),
    INDEX(accepted_by),
    INDEX(rejected_by),
    FOREIGN KEY (student_id) REFERENCES Student(id) ON DELETE CASCADE,
    FOREIGN KEY (job_offer_id) REFERENCES Job_Offer(id) ON DELETE CASCADE
);

-- User
CREATE TABLE User (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

-- Role
CREATE TABLE Role (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Permission
CREATE TABLE Permission (
    id VARCHAR(50) PRIMARY KEY
);

-- Role_Permission
CREATE TABLE Role_Permission (
    role_id INT NOT NULL,
    permission_id VARCHAR(50) NOT NULL,
    PRIMARY KEY(role_id, permission_id),
    FOREIGN KEY(role_id) REFERENCES Role(id) ON DELETE CASCADE,
    FOREIGN KEY(permission_id) REFERENCES Permission(id) ON DELETE CASCADE
);

-- User_Permission
CREATE TABLE User_Permission (
    user_id INT NOT NULL,
    permission_id VARCHAR(50) NOT NULL,
    PRIMARY KEY(user_id, permission_id),
    FOREIGN KEY(user_id) REFERENCES User(id) ON DELETE CASCADE,
    FOREIGN KEY(permission_id) REFERENCES Permission(id) ON DELETE CASCADE
);

-- User_Role
CREATE TABLE User_Role (
    user_id INT NOT NULL,
    role_id INT NOT NULL,
    PRIMARY KEY(user_id, role_id),
    FOREIGN KEY(user_id) REFERENCES User(id) ON DELETE CASCADE,
    FOREIGN KEY(role_id) REFERENCES Role(id) ON DELETE CASCADE
);

-- Company_User
CREATE TABLE Company_User (
    user_id INT NOT NULL,
    company_id INT NOT NULL,
    PRIMARY KEY(user_id, company_id),
    FOREIGN KEY(user_id) REFERENCES User(id) ON DELETE CASCADE,
    FOREIGN KEY(company_id) REFERENCES Company(id) ON DELETE CASCADE
);
