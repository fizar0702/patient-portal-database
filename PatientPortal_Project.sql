-- =============================================================================
-- Patient Chart Portal Database
-- Group: The Last Of Us
-- Apollo E Payne, Callista H Martin, Christopher Peters, Fiza B Rahman
-- =============================================================================

-- STEP 1: SCHEMA CREATION AND DATA POPULATION
-- Purpose:
-- This section creates all database tables and populates them
-- with realistic sample data for the Patient Portal system.
-- It demonstrates:
-- - Proper table structure
-- - Primary and foreign key relationships
-- - Data integrity constraints
-- =========================================================
-- drops any existing schema to avoid conflicts
-- creates new schema for the patient portal system
-- set the active database
DROP SCHEMA IF EXISTS PatientPortal;
CREATE SCHEMA PatientPortal;
USE PatientPortal;

-- Table: PortalAccount
-- Purpose:
-- Stores login credentials and account activity for users.
-- Each account is linked to exactly one patient.
CREATE TABLE PortalAccount (
    AccountID     INT          NOT NULL AUTO_INCREMENT,
    Username      VARCHAR(60)  NOT NULL UNIQUE,
    PasswordHash  VARCHAR(255) NOT NULL,
    CreatedAt     DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    LastLogin     DATETIME,
    PRIMARY KEY (AccountID)
);
-- Table: Doctor
-- Purpose:
-- Stores doctor information including specialty and contact details.
CREATE TABLE Doctor (
    DoctorID      INT          NOT NULL AUTO_INCREMENT,
    FirstName     VARCHAR(50)  NOT NULL,
    LastName      VARCHAR(50)  NOT NULL,
    Specialty     VARCHAR(80)  NOT NULL,
    Phone         VARCHAR(20)  NOT NULL,
    Email         VARCHAR(100) NOT NULL UNIQUE,
    OfficeAddress VARCHAR(200) NOT NULL,
    PRIMARY KEY (DoctorID)
);
-- Table: Patient
-- Purpose:
-- Stores patient demographic and contact information.
-- Each patient is linked to:
-- - One PortalAccount (login)
-- - One primary doctor
CREATE TABLE Patient (
    PatientID             INT          NOT NULL AUTO_INCREMENT,
    FirstName             VARCHAR(50)  NOT NULL,
    LastName              VARCHAR(50)  NOT NULL,
    DOB                   DATE         NOT NULL,
    BloodType             VARCHAR(5),
    Allergies             TEXT,
    Ethnicity             VARCHAR(80),
    Religion              VARCHAR(80),
    ReligiousRestrictions TEXT,
    Pronouns              VARCHAR(30),
    Phone                 VARCHAR(20)  NOT NULL,
    Email                 VARCHAR(100) NOT NULL UNIQUE,
    AccountID             INT          NOT NULL UNIQUE,
    PrimaryDoctorID       INT          NOT NULL,
    PRIMARY KEY (PatientID),
    FOREIGN KEY (AccountID)       REFERENCES PortalAccount(AccountID),
    FOREIGN KEY (PrimaryDoctorID) REFERENCES Doctor(DoctorID)
);
-- Table: Appointment
-- Purpose:
-- Stores appointment details for patients.
-- Ensures no duplicate appointments using a UNIQUE constraint.
CREATE TABLE Appointment (
    AppointmentID   INT          NOT NULL AUTO_INCREMENT,
    PatientID       INT          NOT NULL,
    AppointmentDate DATE         NOT NULL,
    AppointmentTime TIME         NOT NULL,
    DurationMinutes INT          NOT NULL DEFAULT 30,
    Reason          VARCHAR(255),
    Status          VARCHAR(20)  NOT NULL DEFAULT 'Scheduled',
    PRIMARY KEY (AppointmentID),
    UNIQUE (PatientID, AppointmentDate, AppointmentTime),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);
-- Table: AppointmentDoctor
-- Purpose:
-- Bridge table linking appointments and doctors.
-- Allows multiple doctors per appointment.
CREATE TABLE AppointmentDoctor (
    AppointmentID INT NOT NULL,
    DoctorID      INT NOT NULL,
    PRIMARY KEY (AppointmentID, DoctorID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID),
    FOREIGN KEY (DoctorID)      REFERENCES Doctor(DoctorID)
);
-- Table: MedicalRecord
-- Purpose:
-- Stores a master medical record for each patient.
-- Tracks creation and last update timestamps.
CREATE TABLE MedicalRecord (
    RecordID    INT      NOT NULL AUTO_INCREMENT,
    PatientID   INT      NOT NULL UNIQUE,
    CreatedAt   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    LastUpdated DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (RecordID),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);
-- Table: MedicalRecordEntry
-- Purpose:
-- Stores individual visit/entry details within a medical record.
-- Includes notes, vitals, and diagnosis context.
CREATE TABLE MedicalRecordEntry (
    EntryID        INT          NOT NULL AUTO_INCREMENT,
    RecordID       INT          NOT NULL,
    DoctorID       INT          NOT NULL,
    AppointmentID  INT,
    EntryDate      DATE         NOT NULL,
    ChiefComplaint VARCHAR(255),
    VitalSigns     TEXT,
    ClinicalNotes  TEXT,
    Prognosis      VARCHAR(255),
    PRIMARY KEY (EntryID),
    FOREIGN KEY (RecordID)      REFERENCES MedicalRecord(RecordID),
    FOREIGN KEY (DoctorID)      REFERENCES Doctor(DoctorID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
);
-- Table: Diagnosis
-- Purpose:
-- Stores diagnoses linked to a medical record entry.
-- Includes ICD codes and status (Active, Chronic, etc.).
CREATE TABLE Diagnosis (
    DiagnosisID   INT          NOT NULL AUTO_INCREMENT,
    EntryID       INT          NOT NULL,
    ICD10Code     VARCHAR(10),
    DiagnosisName VARCHAR(200) NOT NULL,
    DiagnosisDate DATE         NOT NULL,
    Status        VARCHAR(30)  NOT NULL DEFAULT 'Active',
    PRIMARY KEY (DiagnosisID),
    FOREIGN KEY (EntryID) REFERENCES MedicalRecordEntry(EntryID)
);
-- Table: Prescription
-- Purpose:
-- Stores medication prescriptions for patients.
-- Linked to medical record entries.
CREATE TABLE Prescription (
    PrescriptionID INT          NOT NULL AUTO_INCREMENT,
    EntryID        INT          NOT NULL,
    DrugName       VARCHAR(100) NOT NULL,
    Dosage         VARCHAR(50)  NOT NULL,
    Frequency      VARCHAR(50)  NOT NULL,
    StartDate      DATE         NOT NULL,
    EndDate        DATE,
    RefillsAllowed INT          NOT NULL DEFAULT 0,
    Notes          TEXT,
    PRIMARY KEY (PrescriptionID),
    FOREIGN KEY (EntryID) REFERENCES MedicalRecordEntry(EntryID)
);
-- Table: MedicalChart
-- Purpose:
-- Stores summarized patient health information including:
-- - Current and past conditions
-- - Treatments and prognosis
CREATE TABLE MedicalChart (
    ChartID            INT      NOT NULL AUTO_INCREMENT,
    RecordID           INT      NOT NULL UNIQUE,
    CurrentAfflictions TEXT,
    PastAfflictions    TEXT,
    CurrentTreatments  TEXT,
    PastTreatments     TEXT,
    Prognosis          TEXT,
    LastUpdated        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (ChartID),
    FOREIGN KEY (RecordID) REFERENCES MedicalRecord(RecordID)
);
-- Table: AuditLog
-- Purpose:
-- Stores logs of database changes (INSERT, UPDATE, DELETE).
-- Used for tracking and auditing system activity.
CREATE TABLE AuditLog (
    LogID      INT         NOT NULL AUTO_INCREMENT,
    TableName  VARCHAR(60) NOT NULL,
    Action     VARCHAR(10) NOT NULL,
    RecordID   INT,
    ChangeTime DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Details    TEXT,
    PRIMARY KEY (LogID)
);

-- Insert sample account data
-- Provides realistic login and activity timestamps
INSERT INTO PortalAccount (Username, PasswordHash, CreatedAt, LastLogin) VALUES
('ssmith_patient', 'hashed_pw_001', '2023-01-10 08:00:00', '2024-11-01 09:15:00'),
('mwilliams_p',    'hashed_pw_002', '2023-02-14 10:30:00', '2024-10-20 14:00:00'),
('rjohnson_p',     'hashed_pw_003', '2023-03-01 09:00:00', '2024-11-02 11:00:00'),
('agarcia_p',      'hashed_pw_004', '2023-04-05 07:45:00', '2024-11-05 08:30:00'),
('lbelcher_p',    'hashed_pw_005', '2023-05-18 13:00:00', '2024-09-15 16:00:00'),
('jmiller_p',       'hashed_pw_006', '2023-06-22 11:15:00', '2024-10-28 10:45:00'),
('djones_p',       'hashed_pw_007', '2023-07-30 08:30:00', '2024-11-03 09:00:00'),
('tdavis_p',       'hashed_pw_008', '2023-08-14 14:00:00', '2024-10-15 12:00:00'),
('swilson_p',      'hashed_pw_009', '2023-09-09 09:45:00', '2024-11-06 08:00:00'),
('bgriffin_p',       'hashed_pw_010', '2023-10-03 10:00:00', '2024-10-30 13:30:00'),
('ctaylor_p',      'hashed_pw_011', '2023-10-17 15:30:00', '2024-11-01 14:00:00'),
('pwalker_p',    'hashed_pw_012', '2023-11-08 08:15:00', '2024-10-22 09:30:00'),
('ewatson_p',      'hashed_pw_013', '2023-11-25 11:00:00', '2024-11-04 10:15:00'),
('ojackson_p',     'hashed_pw_014', '2023-12-01 07:30:00', '2024-11-02 08:45:00'),
('wwhite_p',       'hashed_pw_015', '2024-01-10 13:15:00', '2024-10-18 15:00:00'),
('khalris_p',      'hashed_pw_016', '2024-01-20 09:00:00', '2024-11-05 10:00:00'),
('nmartin_p',      'hashed_pw_017', '2024-02-05 10:30:00', '2024-10-25 11:30:00'),
('ythompson_p',    'hashed_pw_018', '2024-02-18 08:45:00', '2024-11-03 09:45:00'),
('liwakura_p',      'hashed_pw_019', '2024-03-12 14:00:00', '2024-10-29 14:30:00'),
('zmartinez_p',    'hashed_pw_020', '2024-03-28 11:30:00', '2024-11-06 07:30:00'),
('bhancock_p',         'hashed_pw_021', '2024-04-15 09:15:00', '2024-10-20 12:00:00'),
('ckent_p',       'hashed_pw_022', '2024-04-28 10:00:00', '2024-11-01 11:00:00'),
('jlewis_p',       'hashed_pw_023', '2024-05-10 07:45:00', '2024-10-27 08:15:00'),
('krobin_p',       'hashed_pw_024', '2024-05-22 13:30:00', '2024-10-31 13:00:00'),
('yforger_p',      'hashed_pw_025', '2024-06-07 08:00:00', '2024-11-04 09:00:00'),
('lmiguel_p',        'hashed_pw_026', '2024-06-19 11:00:00', '2024-11-05 10:30:00');
-- Insert sample doctor data
-- Includes multiple specialties for diverse queries
-- doctor's email, phone# and officeaddress will be displayed later in the project
INSERT INTO Doctor (FirstName, LastName, Specialty, Phone, Email, OfficeAddress) VALUES
('Kenzo', 'Tenma',      'Internal Medicine',       '210-555-0101', 'k.tenma@clinic.org',      '100 Medical Plaza, San Antonio, TX'),
('Marcus',  'Fenix',    'Family Medicine',         '210-555-0102', 'm.fenix@clinic.org',    '100 Medical Plaza, San Antonio, TX'),
('Leon',   'Kennedy',      'Cardiology',              '210-555-0103', 'l.kennedy@clinic.org',      '200 Heart Center Dr, San Antonio, TX'),
('Edward',   'Elric',  'Endocrinology',           '210-555-0104', 'e.elric@clinic.org',  '100 Medical Plaza, San Antonio, TX'),
('Tony',  'Chopper',      'Pulmonology',             '210-555-0105', 't.chopper@clinic.org',      '300 Lung & Allergy Blvd, San Antonio, TX'),
('Light',  'Yagami',        'Neurology',               '210-555-0106', 'l.yagami@clinic.org', '400 Neuro Wing, San Antonio, TX'),
('Yuji',    'Itadori',    'Pediatrics',              '210-555-0107', 'y.itadori@clinic.org',    '500 Childrens Way, San Antonio, TX'),
('Hinata',   'Hyuga',    'Obstetrics & Gynecology', '210-555-0108', 'h.hyuga@clinic.org',    '600 Womens Health Ave, San Antonio, TX');
-- Insert sample patient data
-- Demonstrates relationships with accounts and doctors
-- Currently, some values will not be displayed yet. They are the patient's DOB, Bloodtype, allergies, ethnicity, religion, religionRestrictions, pronouns, phone, and the email later in the project.
INSERT INTO Patient (FirstName, LastName, DOB, BloodType, Allergies, Ethnicity, Religion, ReligiousRestrictions, Pronouns, Phone, Email, AccountID, PrimaryDoctorID) VALUES
('Stan',  'Smith',    '1975-04-12', 'O+',  'Penicillin',     'Caucasian',        'Christian',  NULL,                            'He/Him',  '210-555-1001', 'ssmith@email.com',    1,  1),
('Magaret',  'Williams', '1988-07-23', 'A+',  'Sulfa',          'Hispanic',         'Catholic',   NULL,                         'She/Her', '210-555-1002', 'mwilliams@email.com', 2,  2),
('Roger', 'Johnson',  '1962-11-05', 'B-',   'Latex',           'African American', 'Baptist',    NULL,                           'He/Him',  '210-555-1003', 'rjohnson@email.com',  3,  3),
('Angelica','Garcia',   '1995-03-18', 'AB+', 'None',     'Hispanic',         'Catholic',   NULL,                       'She/Her', '210-555-1004', 'agarcia@email.com',   4,  2),
('Linda',  'Belcher', '1980-09-30', 'O-',  'Aspirin',        'Caucasian',         'Catholic',   'No blood transfusions',        'She/Her', '210-555-1005', 'lbelcher@email.com', 5,  1),
('Joel',  'Miller',    '1971-06-14', 'A-',  'Codeine',        'Caucasian',        'Protestant', NULL,                          'He/Him',  '210-555-1006', 'jmiller@email.com',    6,  6),
('Davey',  'Jones',    '1990-12-01', 'B+',  'Ibuprofen',      'Caucasian',        'None',       NULL,                           'She/Her', '210-555-1007', 'djones@email.com',    7,  5),
('Thomas', 'Davis',    '1955-02-28', 'O+',  'Shellfish',      'African American', 'Methodist',  NULL,                           'He/Him',  '210-555-1008', 'tdavis@email.com',    8,  3),
('Susan',  'Wilson',   '1983-08-09', 'A+',  'None',             'Asian',            'Buddhist',   'No pork derivatives',          'She/Her', '210-555-1009', 'swilson@email.com',   9,  6),
('Brian',  'Griffin',    '1967-05-20', 'AB-', 'Morphine',       'Caucasian',        'agnostic',   NULL,                           'He/Him',  '210-555-1010', 'bgriffin@email.com',    10, 4),
('Carol',  'Taylor',   '1992-10-17', 'O+',  'Amoxicillin',    'Hispanic',         'Catholic',   NULL,                           'She/Her', '210-555-1011', 'ctaylor@email.com',   11, 8),
('Paul',   'Walker', '1958-01-07', 'A+',  'Tetracycline',   'Caucasian',        'Lutheran',   NULL,                           'He/Him',  '210-555-1012', 'pwalker@email.com', 12, 3),
('Emma',   'watson',   '2001-07-15', 'B+',  'Peanuts',        'Caucasian',        'None',       NULL,                           'She/Her', '210-555-1013', 'ewatson@email.com',   13, 7),
('Omar',   'Jackson',  '1977-03-23', 'O-',  'None',           'African American', 'Muslim',     'Halal medications preferred',  'He/Him',  '210-555-1014', 'ojackson@email.com',  14, 1),
('Walter',  'White',    '1985-11-11', 'A-',  'Cephalosporins', 'Caucasian',        'Agnostic',   NULL,                           'He/Him', '210-555-1015', 'wwhite@email.com',    15, 5),
('Kevin',  'Harris',   '1969-04-04', 'B-',  'Iodine',         'African American', 'Baptist',    NULL,                           'He/Him',  '210-555-1016', 'khalris@email.com',   16, 4),
('Nina',   'Martin',   '1997-09-25', 'O+',  'Latex',          'Hispanic',         'Catholic',   NULL,                           'She/Her', '210-555-1017', 'nmartin@email.com',   17, 8),
('Yusuf',  'Thompson', '1948-12-30', 'A+',  'NSAIDs',         'African American', 'Muslim',     'Halal medications preferred',  'He/Him',  '210-555-1018', 'ythompson@email.com', 18, 3),
('Lain',  'Iwakura',   '1993-06-06', 'AB+', 'None',           'Asian',         'Catholic',   NULL,                           'She/Her', '210-555-1019', 'liwakura@email.com',   19, 2),
('Zach',   'Martinez', '2003-02-14', 'O+',  'Bee stings',     'Hispanic',         'Catholic',   NULL,                           'He/Him',  '210-555-1020', 'zmartinez@email.com', 20, 7),
('Boa',     'Hancock',      '1986-08-08', 'B+',  'Penicillin',     'Asian',            'None',       NULL,                           'She/Her', '210-555-1021', 'bhancock@email.com',      21, 6),
('Clark',    'Kent',    '1972-05-19', 'A-',  'Codeine',        'Caucasian',        'Protestant', NULL,                          'He/Him',  '210-555-1022', 'ckent@email.com',    22, 1),
('Julia',  'Lewis',    '1991-03-27', 'O+',  'Sulfa',          'Caucasian',        'None',       NULL,                           'She/Her', '210-555-1023', 'jlewis@email.com',    23, 8),
('Kevin',  'Robinson', '1965-10-10', 'AB+', 'None',           'African American', 'Baptist',    NULL,                           'He/Him',  '210-555-1024', 'krobin@email.com',    24, 2),
('Yor',  'Forger',   '2000-01-22', 'A+',  'Amoxicillin',    'Caucasian',        'Agnostic',   NULL,                          'She/Her', '210-555-1025', 'yforger@email.com',   25, 5),
('Luis', 'Miguel',     '1979-07-07', 'O-',  'None',           'Hispanic',         'Catholic',   NULL,                           'He/Him',  '210-555-1026', 'lmiguel@email.com',     26, 1);
-- Insert sample appointment data
-- Includes different statuses (Completed, Scheduled, Cancelled)
INSERT INTO Appointment (PatientID, AppointmentDate, AppointmentTime, DurationMinutes, Reason, Status) VALUES
(1,  '2024-09-05', '09:00:00', 30, 'Annual physical',            'Completed'),
(2,  '2024-09-06', '10:00:00', 30, 'Follow up hypertension',     'Completed'),
(3,  '2024-09-09', '11:00:00', 45, 'Chest pain evaluation',      'Completed'),
(4,  '2024-09-10', '09:30:00', 30, 'Birth control consult',      'Completed'),
(5,  '2024-09-11', '14:00:00', 30, 'Asthma check',               'Completed'),
(6,  '2024-09-12', '08:00:00', 45, 'Head Trauma',                'Completed'),
(7,  '2024-09-13', '13:00:00', 30, 'Respiratory infection',      'Completed'),
(8,  '2024-09-16', '10:30:00', 60, 'Cardiac stress test',        'Completed'),
(9,  '2024-09-17', '09:00:00', 30, 'Headache evaluation',               'Completed'),
(10, '2024-09-18', '11:00:00', 45, 'Thyroid follow up',                 'Completed'),
(11, '2024-09-19', '14:30:00', 30, 'Prenatal visit',                    'Completed'),
(12, '2024-09-20', '08:30:00', 60, 'Post operation cardiac check',      'Completed'),
(13, '2024-09-23', '09:00:00', 30, 'Pediatric well-child visit',        'Completed'),
(14, '2024-09-24', '10:00:00', 30, 'Annual physical',            'Completed'),
(15, '2024-09-25', '11:30:00', 30, 'Pulmonary function test',    'Completed'),
(16, '2024-09-26', '09:00:00', 45, 'Endocrine consult',          'Completed'),
(17, '2024-09-27', '13:00:00', 30, 'OB prenatal check',          'Completed'),
(18, '2024-09-30', '10:00:00', 60, 'Cardiac review',                    'Completed'),
(19, '2024-10-01', '09:30:00', 30, 'Routine check-up',                  'Completed'),
(20, '2024-10-02', '11:00:00', 30, 'Allergy review',                    'Completed'),
(21, '2024-10-03', '14:00:00', 30, 'Migraine management',               'Completed'),
(22, '2024-10-04', '09:00:00', 30, 'Annual physical',                   'Completed'),
(23, '2024-10-07', '10:30:00', 30, 'Prenatal visit',                    'Completed'),
(24, '2024-10-08', '08:30:00', 45, 'Hypertension follow up',            'Completed'),
(25, '2024-10-09', '13:00:00', 30, 'Asthma management',          'Completed'),
(26, '2024-10-10', '09:00:00', 30, 'Annual physical',            'Completed'),
(1,  '2024-11-05', '10:00:00', 30, 'Lab results review',         'Scheduled'),
(3,  '2024-11-06', '11:00:00', 45, 'Cardiology follow up',       'Scheduled'),
(6,  '2024-11-07', '09:00:00', 45, 'Diabetes management',        'Scheduled'),
(8,  '2024-11-08', '14:00:00', 60, 'Cardiac consultation',       'Cancelled');
-- Insert data linking doctors to appointments
-- Demonstrates many-to-many relationships
INSERT INTO AppointmentDoctor (AppointmentID, DoctorID) VALUES
(1,1),(2,2),(3,3),(4,2),(5,5),(6,6),(7,5),(8,3),(9,6),(10,4),
(11,8),(12,3),(13,7),(14,1),(15,5),(16,4),(17,8),(18,3),(19,2),(20,7),
(21,6),(22,1),(23,8),(24,2),(25,5),(26,1),(27,1),(28,3),(29,4),(30,3),
(3,1),(8,1),(12,5),(18,5);
-- Create one medical record per patient
-- Ensures full coverage of patient data
INSERT INTO MedicalRecord (PatientID) VALUES
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),
(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),
(21),(22),(23),(24),(25),(26);

-- Create one medical record per patient
-- Ensures full coverage of patient data
INSERT INTO MedicalRecordEntry (RecordID, DoctorID, AppointmentID, EntryDate, ChiefComplaint, VitalSigns, ClinicalNotes, Prognosis) VALUES
(1,  1, 1,  '2024-09-05', 'Annual physical',         'BP 118/76, HR 72, SpO2 99%',  'Patient healthy; mild hyperlipidemia noted.',               'Good'),
(2,  2, 2,  '2024-09-06', 'Elevated blood pressure', 'BP 148/92, HR 80, SpO2 98%',  'Hypertension not well controlled; medication adjusted.',    'Stable with treatment'),
(3,  3, 3,  '2024-09-09', 'Chest pain',              'BP 155/95, HR 88, SpO2 96%',  'Atypical chest pain; ECG changes noted.',                   'Guarded'),
(4,  2, 4,  '2024-09-10', 'Contraception review',    'BP 112/70, HR 68, SpO2 100%', 'Patient counseled on options; OCP prescribed.',             'Good'),
(5,  5, 5,  '2024-09-11', 'Asthma flare',            'BP 120/78, HR 76, SpO2 95%',  'Mild asthma exacerbation; inhaler technique reviewed.',     'Stable'),
(6,  6, 6,  '2024-09-12', 'Headaches',               'BP 132/84, HR 74, SpO2 98%',  'Tension-type headaches; lifestyle modification advised.',   'Chronic, managed'),
(7,  5, 7,  '2024-09-13', 'Respiratory symptoms',    'BP 116/74, HR 82, SpO2 97%',  'Community-acquired pneumonia; antibiotics started.',        'Expected full recovery'),
(8,  3, 8,  '2024-09-16', 'Cardiac evaluation',      'BP 145/90, HR 86, SpO2 97%',  'Stress test mildly abnormal; cath lab referral placed.',    'Guarded pending cath'),
(9,  6, 9,  '2024-09-17', 'Headaches',               'BP 122/78, HR 70, SpO2 99%',  'Tension-type headaches; lifestyle modification advised.',   'Good'),
(10, 4, 10, '2024-09-18', 'Thyroid check',           'BP 128/80, HR 68, SpO2 99%',  'Hypothyroidism, levothyroxine dose adjusted.',              'Stable'),
(11, 8, 11, '2024-09-19', 'Prenatal visit',          'BP 110/68, HR 74, SpO2 100%', '20-week anatomy scan normal, iron supplements added.',      'Good'),
(12, 3, 12, '2024-09-20', 'Post op cardiac check',   'BP 138/86, HR 80, SpO2 98%',  'Six-week post CABG; healing well, EF 50%.',                 'Improving'),
(13, 7, 13, '2024-09-23', 'Well child visit',        'BP 100/62, HR 84, SpO2 100%', 'Growth and development normal, vaccines up to date.',       'Good'),
(14, 1, 14, '2024-09-24', 'Annual physical',         'BP 120/78, HR 72, SpO2 100%', 'Healthy adult; advised weight management.',                 'Good'),
(15, 5, 15, '2024-09-25', 'Shortness of breath',     'BP 126/80, HR 78, SpO2 94%',  'FEV1 reduced; COPD moderate severity confirmed.',           'Chronic, managed'),
(16, 4, 16, '2024-09-26', 'Hormone concerns',        'BP 134/88, HR 76, SpO2 99%',  'Type 2 DM and hyperlipidemia; statin therapy initiated.',   'Stable'),
(17, 8, 17, '2024-09-27', 'Prenatal check',          'BP 108/66, HR 72, SpO2 100%', '28-week visit; glucose challenge test ordered.',            'Good'),
(18, 3, 18, '2024-09-30', 'Cardiac review',          'BP 142/88, HR 84, SpO2 97%',  'CHF NYHA Class II; diuretic adjusted.',                     'Stable, chronic'),
(19, 2, 19, '2024-10-01', 'Routine check-up',        'BP 114/72, HR 70, SpO2 100%', 'Healthy; Somewhat Schizo.',                                 'Good'),
(20, 7, 20, '2024-10-02', 'Allergy concerns',        'BP 102/64, HR 80, SpO2 100%', 'Seasonal allergies; antihistamine prescribed.',             'Good'),
(21, 6, 21, '2024-10-03', 'Migraine',                'BP 118/76, HR 68, SpO2 99%',  'Chronic migraine with aura; topiramate started.',           'Managed'),
(22, 1, 22, '2024-10-04', 'Annual physical',         'BP 122/78, HR 72, SpO2 99%',  'Mild GERD noted; PPI trial started.',                       'Good'),
(23, 8, 23, '2024-10-07', 'Prenatal visit',          'BP 106/64, HR 76, SpO2 100%', '32-week visit; fetal growth appropriate.',                  'Good'),
(24, 2, 24, '2024-10-08', 'Hypertension follow-up',  'BP 150/96, HR 82, SpO2 98%',  'BP still elevated; second antihypertensive added.',         'Guarded'),
(25, 5, 25, '2024-10-09', 'Asthma management',       'BP 116/72, HR 76, SpO2 96%',  'Persistent asthma; controller inhaler prescribed.',         'Stable'),
(26, 1, 26, '2024-10-10', 'Annual physical',         'BP 124/80, HR 74, SpO2 100%', 'Healthy; lab work ordered.',                                'Good');
-- Insert diagnosis data
-- Includes multiple diagnoses per patient for aggregation queries
INSERT INTO Diagnosis (EntryID, ICD10Code, DiagnosisName, DiagnosisDate, Status) VALUES
(1,  'E78.5',   'Hyperlipidemia',                    '2024-09-05', 'Active'),
(2,  'I10',     'Essential Hypertension',             '2024-09-06', 'Chronic'),
(3,  'R07.9',   'Chest pain, unspecified',            '2024-09-09', 'Active'),
(3,  'I25.10',  'Coronary artery disease',            '2024-09-09', 'Suspected'),
(5,  'J45.20',  'Mild intermittent asthma',           '2024-09-11', 'Chronic'),
(6,  'E11.9',   'Head Trauma',           '2024-09-12', 'Chronic'),
(7,  'J18.9',   'Community-acquired pneumonia',       '2024-09-13', 'Active'),
(8,  'I25.10',  'Coronary artery disease',            '2024-09-16', 'Active'),
(9,  'G44.20',  'Tension-type headache',              '2024-09-17', 'Active'),
(10, 'E03.9',   'Hypothyroidism',                    '2024-09-18', 'Chronic'),
(12, 'I50.9',   'Heart failure',                     '2024-09-20', 'Chronic'),
(14, 'E66.01',  'Morbid obesity',                    '2024-09-24', 'Active'),
(15, 'J44.1',   'COPD with acute exacerbation',      '2024-09-25', 'Chronic'),
(16, 'E11.9',   'Type 2 diabetes mellitus',           '2024-09-26', 'Chronic'),
(16, 'E78.5',   'Hyperlipidemia',                    '2024-09-26', 'Active'),
(18, 'I50.9',   'Congestive heart failure',           '2024-09-30', 'Chronic'),
(21, 'G43.109', 'Migraine with aura',                '2024-10-03', 'Chronic'),
(22, 'K21.0',   'GERD with esophagitis',             '2024-10-04', 'Active'),
(24, 'I10',     'Essential Hypertension',             '2024-10-08', 'Chronic'),
(25, 'J45.30',  'Mild persistent asthma',            '2024-10-09', 'Chronic'),
(2,  'E78.5',   'Hyperlipidemia',                    '2024-09-06', 'Active'),
(6,  'E78.5',   'Hyperlipidemia',                    '2024-09-12', 'Active'),
(8,  'I10',     'Essential Hypertension',             '2024-09-16', 'Chronic'),
(10, 'E78.5',   'Hyperlipidemia',                    '2024-09-18', 'Active'),
(15, 'J96.00',  'Acute respiratory failure',         '2024-09-25', 'Resolved'),
(18, 'I10',     'Essential Hypertension',             '2024-09-30', 'Chronic'),
(7,  'J22',     'Acute lower respiratory infection', '2024-09-13', 'Resolved'),
(1,  'Z00.00',  'Encounter for adult health exam',   '2024-09-05', 'Resolved');
-- Insert prescription data
-- Demonstrates active and past medications
INSERT INTO Prescription (EntryID, DrugName, Dosage, Frequency, StartDate, EndDate, RefillsAllowed, Notes) VALUES
(1,  'Atorvastatin',       '20 mg',   'Once daily at bedtime',       '2024-09-05', NULL,         6,  'Monitor liver enzymes in 3 months'),
(2,  'Lisinopril',         '10 mg',   'Once daily',                  '2024-09-06', NULL,         6,  'Monitor potassium and creatinine'),
(2,  'Amlodipine',         '5 mg',    'Once daily',                  '2024-09-06', NULL,         6,  'May cause ankle edema'),
(4,  'Ortho Tri-Cyclen',   '28 tabs', 'Once daily',                  '2024-09-10', '2025-09-10', 11, 'Take at same time each day'),
(5,  'Albuterol',          '90 mcg',  'Every 4-6 hrs as needed',     '2024-09-11', NULL,         3,  'Rescue inhaler; carry at all times'),
(6,  'Ibuprofen',          '400 mg', 'Every 6 hrs as needed',        '2024-09-12', NULL,       6,  'Take with food; monitor for headache relief'),
(7,  'Azithromycin',       '500 mg',  'Once daily for 5 days',       '2024-09-13', '2024-09-18', 0,  'Complete full course'),
(9,  'Ibuprofen',          '400 mg',  'Every 6 hrs as needed',       '2024-09-17', '2024-10-17', 1,  'Take with food'),
(10, 'Levothyroxine',      '75 mcg',  'Once daily fasting',          '2024-09-18', NULL,         6,  'Take 30 min before breakfast'),
(12, 'Carvedilol',         '6.25 mg', 'Twice daily',                 '2024-09-20', NULL,         6,  'Do not stop abruptly'),
(12, 'Furosemide',         '40 mg',   'Once daily in morning',       '2024-09-20', NULL,         6,  'Monitor electrolytes'),
(15, 'Tiotropium',         '18 mcg',  'Once daily inhaled',          '2024-09-25', NULL,         3,  'COPD maintenance inhaler'),
(15, 'Prednisone',         '40 mg',   'Once daily for 5 days',       '2024-09-25', '2024-09-30', 0,  'Taper as directed'),
(16, 'Metformin',          '500 mg',  'Once daily with dinner',      '2024-09-26', NULL,         6,  'Titrate up as tolerated'),
(16, 'Rosuvastatin',       '10 mg',   'Once daily at bedtime',       '2024-09-26', NULL,         6,  'Check CK if muscle pain'),
(18, 'Lisinopril',         '20 mg',   'Once daily',                  '2024-09-30', NULL,         6,  'CHF management'),
(18, 'Spironolactone',     '25 mg',   'Once daily',                  '2024-09-30', NULL,         6,  'Monitor potassium'),
(21, 'Topiramate',         '25 mg',   'Once daily increasing',       '2024-10-03', NULL,         3,  'Increase to 50 mg after 2 weeks'),
(22, 'Omeprazole',         '20 mg',   'Once daily before breakfast', '2024-10-04', NULL,         3,  '8-week trial'),
(24, 'Losartan',           '50 mg',   'Once daily',                  '2024-10-08', NULL,         6,  'Second agent for BP control'),
(25, 'Fluticasone',        '44 mcg',  'Twice daily inhaled',         '2024-10-09', NULL,         3,  'Controller inhaler; rinse mouth after use'),
(2,  'Hydrochlorothiazide','25 mg',   'Once daily in morning',       '2024-09-06', NULL,         6,  'Monitor sodium and potassium'),
(6,  'Atorvastatin',       '40 mg',   'Once daily at bedtime',       '2024-09-12', NULL,         6,  'Combined hyperlipidemia management'),
(8,  'Nitroglycerin',      '0.4 mg',  'PRN for chest pain SL',       '2024-09-16', NULL,         2,  'Call 911 if no relief after 3 doses'),
(10, 'Vitamin D3',         '2000 IU', 'Once daily with meal',        '2024-09-18', NULL,         6,  'Supplement for hypothyroid patients');

-- Insert summarized medical chart data
-- Provides high-level patient health overview
INSERT INTO MedicalChart (RecordID, CurrentAfflictions, PastAfflictions, CurrentTreatments, PastTreatments, Prognosis) VALUES
(1,  'Hyperlipidemia',                        'None significant',    'Atorvastatin 20mg',                          'None',               'Good; annual follow-up'),
(2,  'Hypertension, Hyperlipidemia',          'None significant',    'Lisinopril, Amlodipine, HCTZ, Atorvastatin', 'None',               'Stable with medication'),
(3,  'Coronary artery disease, Hypertension', 'Appendectomy 2005',   'Nitroglycerin PRN, cardiac monitoring',      'Aspirin',            'Guarded; pending catheterization'),
(4,  'None active',                           'None',                'OCP Ortho Tri-Cyclen',                       'None',               'Good'),
(5,  'Asthma',                                'None',                'Albuterol inhaler PRN',                      'Oral steroids 2022', 'Stable'),
(6,  'Type 2 DM, Hyperlipidemia',             'None',                'Metformin, Atorvastatin',                    'None',               'Chronic, managed'),
(7,  'Community-acquired pneumonia (resolved)','None',               'Completed azithromycin',                     'None',               'Full recovery'),
(8,  'Coronary artery disease, Heart failure','MI 2019, CABG 2024',  'Carvedilol, Furosemide',                    'Aspirin (completed)', 'Stable post-CABG'),
(9,  'Tension headaches',                     'None',                'Ibuprofen PRN',                              'None',               'Good'),
(10, 'Hypothyroidism, Hyperlipidemia',        'None',                'Levothyroxine, Vitamin D3, Atorvastatin',    'None',               'Stable'),
(11, 'Pregnancy (G1P0)',                      'None',                'Iron supplements, prenatal vitamins',        'None',               'Good; uncomplicated'),
(12, 'Heart failure, CAD',                    'CABG 2024',           'Carvedilol, Furosemide, Lisinopril',         'None',               'Improving'),
(13, 'None',                                  'None',                'Up to date on vaccines',                     'None',               'Good'),
(14, 'Morbid obesity',                        'None',                'Dietary counseling',                         'None',               'Good with intervention'),
(15, 'COPD',                                  'Pneumonia 2021',      'Tiotropium inhaler',                         'Oral steroids',       'Chronic, managed'),
(16, 'Type 2 DM, Hyperlipidemia',             'None',                'Metformin, Rosuvastatin',                    'None',               'Stable'),
(17, 'Pregnancy (G2P1)',                      'None',                'Prenatal vitamins',                          'None',               'Good'),
(18, 'CHF, Hypertension',                     'None',                'Lisinopril, Spironolactone',                 'Furosemide 2022',    'Stable, chronic'),
(19, 'None',                                  'None',                'None',                                       'None',               'Good'),
(20, 'Seasonal allergies',                    'None',                'Antihistamine PRN',                          'None',               'Good'),
(21, 'Chronic migraine',                      'None',                'Topiramate',                                 'None',               'Managed'),
(22, 'GERD',                                  'None',                'Omeprazole',                                 'Antacids',           'Good'),
(23, 'Pregnancy (G1P0)',                      'None',                'Prenatal vitamins',                          'None',               'Good'),
(24, 'Hypertension',                          'None',                'Lisinopril, Losartan',                       'HCTZ',               'Guarded'),
(25, 'Asthma',                                'None',                'Fluticasone inhaler',                        'Albuterol PRN',      'Stable'),
(26, 'None',                                  'None',                'None',                                       'None',               'Good; labs pending');

-- =========================================================
-- STEP 2: QUERIES TO DEMONSTRATE DATABASE FUNCTIONALITY
-- Purpose:
-- These queries demonstrate meaningful use of the Patient Portal
-- database through joins, aggregation, sorting, DISTINCT,
-- string concatenation, and a subquery.
-- Each query answers a realistic question someone might ask.
-- =========================================================
-- Query 1:
-- Count the number of appointments by status.
-- Demonstrates:
-- COUNT, GROUP BY, ORDER BY
SELECT Status, COUNT(*) AS AppointmentCount
FROM Appointment
GROUP BY Status
ORDER BY AppointmentCount DESC;
-- Query 2:
-- Show each doctor and how many patients are assigned to them
-- as their primary doctor.
-- Demonstrates:
-- LEFT JOIN, COUNT, GROUP BY, ORDER BY
-- Count how many patients each doctor has
SELECT 
    d.DoctorID,
    d.FirstName,
    d.LastName,
    d.Specialty,
    COUNT(p.PatientID) AS PatientCount
FROM Doctor d
LEFT JOIN Patient p 
    ON p.PrimaryDoctorID = d.DoctorID
GROUP BY 
    d.DoctorID, d.FirstName, d.LastName, d.Specialty
ORDER BY PatientCount DESC;
-- Query 3:
-- List all appointments with patient name, doctor name,
-- appointment details, and status.
-- Demonstrates:
-- Multiple JOINs, string concatenation using CONCAT, ORDER BY
SELECT
    a.AppointmentID,
    a.AppointmentDate,
    a.AppointmentTime,
    CONCAT(p.FirstName, ' ', p.LastName) AS PatientName,
    CONCAT(d.FirstName, ' ', d.LastName) AS DoctorName,
    a.Reason,
    a.Status
FROM Appointment a
JOIN Patient p            ON p.PatientID     = a.PatientID
JOIN AppointmentDoctor ad ON ad.AppointmentID = a.AppointmentID
JOIN Doctor d             ON d.DoctorID      = ad.DoctorID
ORDER BY a.AppointmentDate, a.AppointmentTime;

-- Query 4:
-- Show a distinct list of patients who have at least one
-- prescription recorded in the system.
-- Demonstrates:
-- DISTINCT, JOINs, string concatenation, ORDER BY
SELECT DISTINCT p.PatientID, CONCAT(p.FirstName, ' ', p.LastName) AS PatientName, p.LastName, p.Email
FROM Patient p
JOIN MedicalRecord mr     ON mr.PatientID = p.PatientID
JOIN MedicalRecordEntry e ON e.RecordID   = mr.RecordID
JOIN Prescription rx      ON rx.EntryID   = e.EntryID
ORDER BY p.LastName;
-- Query 5:
-- Find patients who have more than one distinct diagnosis.
-- Demonstrates:
-- Subquery, COUNT(DISTINCT ...), JOIN, HAVING, ORDER BY
SELECT p.PatientID, p.FirstName, p.LastName, diag_count.TotalDiagnoses
FROM Patient p
JOIN (
    SELECT mr.PatientID, COUNT(DISTINCT d.DiagnosisName) AS TotalDiagnoses
    FROM MedicalRecord mr
    JOIN MedicalRecordEntry e ON e.RecordID = mr.RecordID
    JOIN Diagnosis d          ON d.EntryID  = e.EntryID
    GROUP BY mr.PatientID
    HAVING COUNT(DISTINCT d.DiagnosisName) > 1
) AS diag_count ON diag_count.PatientID = p.PatientID
ORDER BY diag_count.TotalDiagnoses DESC;
-- Query 6:
-- Show the top prescribed medications and how many times each
-- was prescribed, along with how many unique patients received it.
-- Demonstrates:
-- COUNT, GROUP BY, ORDER BY, LIMIT
SELECT rx.DrugName, COUNT(*) AS TimesPrescribed, COUNT(DISTINCT e.RecordID) AS UniquePatients
FROM Prescription rx
JOIN MedicalRecordEntry e ON e.EntryID = rx.EntryID
GROUP BY rx.DrugName
ORDER BY TimesPrescribed DESC
LIMIT 10;
-- Query 7:
-- Show patients with active or chronic diagnoses and the doctor
-- associated with the medical record entry.
-- Demonstrates:
-- Multiple JOINs, filtering with WHERE, ORDER BY
SELECT p.FirstName, p.LastName, diag.DiagnosisName, diag.Status, doc.FirstName AS DoctorFirst, doc.LastName AS DoctorLast, doc.Specialty
FROM Diagnosis diag
JOIN MedicalRecordEntry e ON e.EntryID    = diag.EntryID
JOIN MedicalRecord mr     ON mr.RecordID  = e.RecordID
JOIN Patient p            ON p.PatientID  = mr.PatientID
JOIN Doctor doc           ON doc.DoctorID = e.DoctorID
WHERE diag.Status IN ('Chronic', 'Active')
ORDER BY p.LastName, diag.DiagnosisName;
-- Query 8:
-- Show the minimum, maximum, and average number of prescriptions
-- per patient.
-- Demonstrates:
-- MIN, MAX, AVG, ROUND, subquery, aggregation
SELECT
    MIN(rx_count)           AS MinPrescriptions,
    MAX(rx_count)           AS MaxPrescriptions,
    ROUND(AVG(rx_count), 2) AS AvgPrescriptions
FROM (
    SELECT mr.PatientID, COUNT(rx.PrescriptionID) AS rx_count
    FROM MedicalRecord mr
    JOIN MedicalRecordEntry e ON e.RecordID = mr.RecordID
    LEFT JOIN Prescription rx ON rx.EntryID = e.EntryID
    GROUP BY mr.PatientID
) AS counts;

-- =========================================================
-- STEP 3: IMPLEMENT AUTOMATION USING TRIGGERS,
-- A STORED PROCEDURE, AND A FUNCTION
-- Purpose:
-- This section demonstrates automation and enforcement of
-- business rules in the Patient Portal database.
-- It includes:
-- 1 INSERT trigger
-- 1 UPDATE trigger
-- 1 DELETE trigger
-- 1 stored procedure
-- 1 user-defined function
-- =========================================================

DELIMITER $$

-- INSERT TRIGGER: after_appointment_insert
-- Purpose:
-- Automatically logs every new appointment added to the
-- Appointment table into the AuditLog table.
-- This supports auditing and tracking of new records.
-- Fires:
-- AFTER INSERT on Appointment

CREATE TRIGGER after_appointment_insert
AFTER INSERT ON Appointment
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (TableName, Action, RecordID, Details)
    VALUES (
        'Appointment',
        'INSERT',
        NEW.AppointmentID,
        CONCAT('New appointment for PatientID ', NEW.PatientID,
               ' on ', NEW.AppointmentDate,
               ' at ', NEW.AppointmentTime,
               ' | Status: ', NEW.Status)
    );
END$$

-- UPDATE TRIGGER: after_entry_update
-- Purpose:
-- Updates the LastUpdated field in the MedicalRecord table
-- whenever a related MedicalRecordEntry is updated.
-- This keeps the medical record current when notes change.
-- Fires:
-- AFTER UPDATE on MedicalRecordEntry

CREATE TRIGGER after_entry_update
AFTER UPDATE ON MedicalRecordEntry
FOR EACH ROW
BEGIN
    UPDATE MedicalRecord
    SET LastUpdated = NOW()
    WHERE RecordID = NEW.RecordID;
END$$

-- DELETE TRIGGER: before_patient_delete
-- Purpose:
-- Prevents a patient from being deleted if they still have
-- scheduled appointments in the system.
-- This enforces a business rule and protects data integrity.
-- Fires:
-- BEFORE DELETE on Patient

CREATE TRIGGER before_patient_delete
BEFORE DELETE ON Patient
FOR EACH ROW
BEGIN
    DECLARE future_count INT;
    SELECT COUNT(*) INTO future_count
    FROM Appointment
    WHERE PatientID = OLD.PatientID
      AND Status = 'Scheduled';
    IF future_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete patient: they have upcoming scheduled appointments.';
    END IF;
END$$

-- STORED PROCEDURE: generate_patient_summary
-- Input:
--   p_patient_id INT
-- Purpose:
-- Returns a patient summary that includes:
--   1. Active and chronic diagnoses
--   2. Current prescriptions with no end date
-- This procedure simplifies a common reporting task.

CREATE PROCEDURE generate_patient_summary(IN p_patient_id INT)
BEGIN
    SELECT p.FirstName, p.LastName, diag.DiagnosisName, diag.Status, diag.DiagnosisDate
    FROM Diagnosis diag
    JOIN MedicalRecordEntry e ON e.EntryID   = diag.EntryID
    JOIN MedicalRecord mr     ON mr.RecordID  = e.RecordID
    JOIN Patient p            ON p.PatientID  = mr.PatientID
    WHERE p.PatientID = p_patient_id
      AND diag.Status IN ('Active', 'Chronic')
    ORDER BY diag.DiagnosisDate;

    SELECT rx.DrugName, rx.Dosage, rx.Frequency, rx.StartDate, rx.RefillsAllowed
    FROM Prescription rx
    JOIN MedicalRecordEntry e ON e.EntryID   = rx.EntryID
    JOIN MedicalRecord mr     ON mr.RecordID  = e.RecordID
    WHERE mr.PatientID = p_patient_id
      AND rx.EndDate IS NULL
    ORDER BY rx.StartDate;
END$$

-- FUNCTION: fn_full_name
-- Input:
--   first_name VARCHAR(50)
--   last_name VARCHAR(50)
-- Returns:
--   A formatted full name as "LastName, FirstName"
-- Purpose:
-- Standardizes how names are displayed in query results.

CREATE FUNCTION fn_full_name(first_name VARCHAR(50), last_name VARCHAR(50))
RETURNS VARCHAR(105)
DETERMINISTIC
BEGIN
    RETURN CONCAT(TRIM(last_name), ', ', TRIM(first_name));
END$$

DELIMITER ;

-- DEMONSTRATION OF AUTOMATION FEATURES
-- These statements show each trigger, procedure,
-- and function working in the database.

INSERT INTO Appointment (PatientID, AppointmentDate, AppointmentTime, Reason, Status)
VALUES (5, '2024-12-01', '10:00:00', 'Asthma follow-up', 'Scheduled');

SELECT * FROM AuditLog WHERE TableName = 'Appointment' AND Action = 'INSERT';

UPDATE MedicalRecordEntry
SET ClinicalNotes = CONCAT(ClinicalNotes, ' [Addendum: follow-up labs ordered]')
WHERE EntryID = 1;

SELECT RecordID, LastUpdated FROM MedicalRecord WHERE RecordID = 1;

DELETE FROM Patient WHERE PatientID = 1;

CALL generate_patient_summary(3);

SELECT PatientID, fn_full_name(FirstName, LastName) AS FormattedName, DOB, BloodType
FROM Patient
ORDER BY LastName, FirstName;