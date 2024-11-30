CREATE DATABASE mysql_oop;
USE mysql_oop;

-- Patient Table
CREATE TABLE patient (
    Patient_ID VARCHAR(50) PRIMARY KEY,
    Patient_Name VARCHAR(255),
    Password VARCHAR(255),
    Birthdate DATE,
    Place_of_Birth VARCHAR(255),
    Gender VARCHAR(20),
    Email VARCHAR(255),
    Contact_No VARCHAR(255),
    Emergency_No VARCHAR(255),
    Address VARCHAR(255),
    Province VARCHAR(255),
    City VARCHAR(255),
    Barangay VARCHAR(255),
    Nationality VARCHAR(255),
    Marital_Status VARCHAR(255),
    Allergy VARCHAR(255),
    Past VARCHAR(255),
    Bloodtype VARCHAR(50),
    Is_Vaccinated BOOLEAN,
    Has_Disability BOOLEAN,
    Disability_Details VARCHAR(255)
);

-- Doctor Table
CREATE TABLE doctor (
    Doctor_ID VARCHAR(50) PRIMARY KEY,
    Doctor_Name VARCHAR(255) NOT NULL,
    Department_ID INT,
    FOREIGN KEY (Department_ID) REFERENCES department(Department_ID) ON DELETE SET NULL
);

-- Department Table
CREATE TABLE department (
    Department_ID INT AUTO_INCREMENT PRIMARY KEY,
    Department_Name VARCHAR(255) NOT NULL,
    is_active TINYINT(1) DEFAULT 1 -- 1 for active, 0 for inactive
);

-- Available Time Slot of Doctor Table
CREATE TABLE available_times (
    AvailableTimeSlot_ID INT AUTO_INCREMENT PRIMARY KEY,
    Doctor_ID VARCHAR(50) NOT NULL,
    Available_Time VARCHAR (255),
    Is_Available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (Doctor_ID) REFERENCES doctor(Doctor_ID) ON DELETE CASCADE
);

-- Appointments Table
CREATE TABLE appointments (
    Appointment_ID INT AUTO_INCREMENT PRIMARY KEY,
    Doctor_ID VARCHAR(50) NOT NULL,
    Patient_ID VARCHAR(50) NOT NULL,
    Department_ID INT,
    Appointment_Time VARCHAR(255) NOT NULL,
    Medical_Condition VARCHAR(255),
    Diagnosis VARCHAR(255) DEFAULT 'pending',
    Status ENUM('Scheduled', 'Completed', 'Canceled') DEFAULT 'scheduled', -- ENUM for controlled statuses
    FOREIGN KEY (Doctor_ID) REFERENCES doctor(Doctor_ID),
    FOREIGN KEY (Patient_ID) REFERENCES patient(Patient_ID),
    FOREIGN KEY (Department_ID) REFERENCES department(Department_ID)
);

-- Canceled Appointments Table
CREATE TABLE canceled_appointments (
    CanceledAppointment_ID INT AUTO_INCREMENT PRIMARY KEY,
    Appointment_ID INT NOT NULL,
    Doctor_ID VARCHAR(50) NOT NULL,
    Patient_ID VARCHAR(50) NOT NULL,
    Department_ID INT,
    Cancel_Reason VARCHAR(255),
    FOREIGN KEY (Doctor_ID) REFERENCES doctor(Doctor_ID),
    FOREIGN KEY (Patient_ID) REFERENCES patient(Patient_ID),
    FOREIGN KEY (Department_ID) REFERENCES department(Department_ID),
    FOREIGN KEY (Appointment_ID) REFERENCES appointments(Appointment_ID)
);

-- Medical History of Patients Table
CREATE TABLE medical_history (
    MedicalHistory_ID INT AUTO_INCREMENT PRIMARY KEY,
    Patient_ID VARCHAR(50) NOT NULL,
    Doctor_ID VARCHAR(50) NOT NULL,
    Department_ID INT,
    Appointment_ID INT NOT NULL,
    Medical_Condition VARCHAR(255),
    Diagnosis VARCHAR(255),
    FOREIGN KEY (Patient_ID) REFERENCES patient(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES doctor(Doctor_ID),
    FOREIGN KEY (Appointment_ID) REFERENCES appointments(Appointment_ID),
    FOREIGN KEY (Department_ID) REFERENCES department(Department_ID)
);

-- Add Departments into Departments Table
INSERT INTO department (Department_Name, is_active) VALUES 
('Cardiology', 1),
('Neurology', 1),
('Pediatrics', 1);

-- SELECT * FROM patient;
-- SELECT * FROM doctor;
-- SELECT * FROM department;
-- SELECT * FROM available_times;
-- SELECT * FROM appointments;
-- SELECT * FROM canceled_appointments;
-- SELECT * FROM medical_history;

