--                                                     SECTION 1
-- ************************************************ CREATE DATABASE AND USE IT!!! ********************************************
-- ****************************This script creates and populates the COVID-related database***********************************

DROP DATABASE IF EXISTS Project_CSCI2141;       
CREATE DATABASE Project_CSCI2141;               
USE Project_CSCI2141;

-- ************************************************ CREATE TABLES!!! ********************************************************

-- Drop tables if they already exist to allow clean re-runs, did drop tables for all the tables before!!
DROP TABLE IF EXISTS Survivors;
DROP TABLE IF EXISTS Vaccine;
DROP TABLE IF EXISTS Country;
DROP TABLE IF EXISTS Continent;
DROP TABLE IF EXISTS Income_Class;

-- Create Income_Class table
-- these tables are created according using the part 1, for more details about it please see project part 1!!
CREATE TABLE Income_Class (
    Income_Class_ID INT PRIMARY KEY,          -- Primary key for income class
    Income_Class_Name VARCHAR(50) NOT NULL,   -- Name of the income class
    Total_Deaths INT                          -- Total deaths in this income class
);

-- Create Continent table
CREATE TABLE Continent (
    Continent_ID INT PRIMARY KEY,             -- Primary key for continent
    Continent_Name VARCHAR(50) NOT NULL,     -- Name of the continent
    Total_Deaths INT                          -- Total deaths in this continent
);

-- Create Country table
CREATE TABLE Country (
    Country_ID INT PRIMARY KEY,               -- Primary key for country
    Country_Name VARCHAR(50) NOT NULL,        -- Name of the country
    Total_Death BIGINT,                       -- Total deaths in the country
    First_Case_Death DATE,                    -- Date of the first case death
    Last_Case_Death DATE,                     -- Date of the last case death
    Total_Cases BIGINT,                       -- Total cases in the country
    Continent_ID INT,                         -- Foreign key referencing Continent
    Income_Class_ID INT,                      -- Foreign key referencing Income_Class
    FOREIGN KEY (Continent_ID) REFERENCES Continent(Continent_ID),
    FOREIGN KEY (Income_Class_ID) REFERENCES Income_Class(Income_Class_ID)
);

-- Create Vaccine table
CREATE TABLE Vaccine (
    Vaccine_ID INT AUTO_INCREMENT PRIMARY KEY,	-- Primary key for vaccine
    Vaccine_Name VARCHAR(50) NOT NULL,        	-- Name of the vaccine
    Total_Deaths INT,                        	-- Total deaths in the continent where the vaccine is used
    Continent_ID INT,                         	-- Foreign key referencing Continent
    FOREIGN KEY (Continent_ID) REFERENCES Continent(Continent_ID)
);

-- Create Survivors table
CREATE TABLE Survivors (
    No_of_Survivors BIGINT,                   -- Number of survivors
    Vaccine_ID INT,                           -- Foreign key referencing Vaccine
    Country_ID INT,                           -- Foreign key referencing Country
    FOREIGN KEY (Vaccine_ID) REFERENCES Vaccine(Vaccine_ID),
    FOREIGN KEY (Country_ID) REFERENCES Country(Country_ID)
);

-- *********************************** INSERT INTO VALUES STATEMENTS!! ******************************************************

-- Income_Class, Total rows: 4, Columns: 3
INSERT INTO Income_Class (Income_Class_ID, Income_Class_Name, Total_Deaths)
VALUES (1, 'High Income', 100000),
(2, 'Upper Middle Income', 200000),
(3, 'Lower Middle Income', 300000),
(4, 'Low Income', 400000);

-- Continent, Total rows: 6, Columns: 3
INSERT INTO Continent (Continent_ID, Continent_Name, Total_Deaths)
VALUES (1, 'Asia', 500000),
(2, 'Europe', 300000),
(3, 'North America', 200000),
(4, 'South America', 150000),
(5, 'Africa', 400000),
(6, 'Australia', 50000);


-- Country, Total rows: 100, Columns: 8
INSERT INTO Country (Country_ID, Country_Name, Total_Death, First_Case_Death, Last_Case_Death, Total_Cases, Continent_ID, Income_Class_ID)
VALUES 
(1, 'United States', 1000000, '2020-03-01', '2023-01-01', 50000000, 3, 1),
(2, 'India', 500000, '2020-01-30', '2023-01-01', 40000000, 1, 3),
(3, 'Brazil', 300000, '2020-02-26', '2023-01-01', 30000000, 4, 2),
(4, 'China', 200000, '2020-01-15', '2023-01-01', 20000000, 1, 2),
(5, 'Russia', 150000, '2020-03-10', '2023-01-01', 10000000, 2, 2),
(6, 'Germany', 100000, '2020-02-28', '2023-01-01', 8000000, 2, 1),
(7, 'France', 120000, '2020-02-25', '2023-01-01', 9000000, 2, 1),
(8, 'United Kingdom', 130000, '2020-02-20', '2023-01-01', 8500000, 2, 1),
(9, 'Italy', 140000, '2020-02-22', '2023-01-01', 7000000, 2, 1),
(10, 'Spain', 110000, '2020-02-24', '2023-01-01', 7500000, 2, 1),
(11, 'Canada', 30000, '2020-03-05', '2023-01-01', 4000000, 3, 1),
(12, 'Mexico', 80000, '2020-03-15', '2023-01-01', 6000000, 4, 2),
(13, 'Argentina', 70000, '2020-03-20', '2023-01-01', 5000000, 4, 2),
(14, 'South Africa', 90000, '2020-03-18', '2023-01-01', 4000000, 5, 3),
(15, 'Nigeria', 50000, '2020-03-22', '2023-01-01', 3000000, 5, 4),
(16, 'Australia', 10000, '2020-03-01', '2023-01-01', 2000000, 6, 1),
(17, 'Japan', 20000, '2020-02-15', '2023-01-01', 1000000, 1, 1),
(18, 'South Korea', 15000, '2020-02-20', '2023-01-01', 1200000, 1, 1),
(19, 'Indonesia', 120000, '2020-03-02', '2023-01-01', 8000000, 1, 3),
(20, 'Pakistan', 80000, '2020-03-10', '2023-01-01', 6000000, 1, 4),
(21, 'Bangladesh', 70000, '2020-03-12', '2023-01-01', 5000000, 1, 4),
(22, 'Turkey', 60000, '2020-03-11', '2023-01-01', 4000000, 2, 2),
(23, 'Iran', 90000, '2020-02-19', '2023-01-01', 7000000, 1, 2),
(24, 'Egypt', 40000, '2020-03-08', '2023-01-01', 3000000, 5, 3),
(25, 'Vietnam', 10000, '2020-03-06', '2023-01-01', 1000000, 1, 3),
(26, 'Thailand', 8000, '2020-03-07', '2023-01-01', 800000, 1, 2),
(27, 'Philippines', 30000, '2020-03-09', '2023-01-01', 2000000, 1, 3),
(28, 'Malaysia', 20000, '2020-03-13', '2023-01-01', 1500000, 1, 2),
(29, 'Singapore', 5000, '2020-03-14', '2023-01-01', 500000, 1, 1),
(30, 'New Zealand', 1000, '2020-03-16', '2023-01-01', 200000, 6, 1),
(31, 'Saudi Arabia', 30000, '2020-03-17', '2023-01-01', 2000000, 1, 1),
(32, 'Iraq', 20000, '2020-03-19', '2023-01-01', 1500000, 1, 3),
(33, 'Afghanistan', 10000, '2020-03-21', '2023-01-01', 1000000, 1, 4),
(34, 'Ethiopia', 15000, '2020-03-23', '2023-01-01', 1200000, 5, 4),
(35, 'Kenya', 12000, '2020-03-24', '2023-01-01', 1000000, 5, 4),
(36, 'Uganda', 8000, '2020-03-25', '2023-01-01', 600000, 5, 4),
(37, 'Tanzania', 7000, '2020-03-26', '2023-01-01', 500000, 5, 4),
(38, 'Ghana', 6000, '2020-03-27', '2023-01-01', 400000, 5, 3),
(39, 'Morocco', 10000, '2020-03-28', '2023-01-01', 800000, 5, 3),
(40, 'Algeria', 9000, '2020-03-29', '2023-01-01', 700000, 5, 3),
(41, 'Angola', 5000, '2020-03-30', '2023-01-01', 400000, 5, 4),
(42, 'Cameroon', 4000, '2020-03-31', '2023-01-01', 300000, 5, 4),
(43, 'Cote dIvoire', 3000, '2020-04-01', '2023-01-01', 200000, 5, 4),
(44, 'Senegal', 2000, '2020-04-02', '2023-01-01', 150000, 5, 3),
(45, 'Zambia', 1500, '2020-04-03', '2023-01-01', 100000, 5, 4),
(46, 'Zimbabwe', 1000, '2020-04-04', '2023-01-01', 80000, 5, 4),
(47, 'Malawi', 800, '2020-04-05', '2023-01-01', 60000, 5, 4),
(48, 'Mozambique', 700, '2020-04-06', '2023-01-01', 50000, 5, 4),
(49, 'Madagascar', 600, '2020-04-07', '2023-01-01', 40000, 5, 4),
(50, 'Namibia', 500, '2020-04-08', '2023-01-01', 30000, 5, 3),
(51, 'Botswana', 400, '2020-04-09', '2023-01-01', 20000, 5, 3),
(52, 'Lesotho', 300, '2020-04-10', '2023-01-01', 15000, 5, 4),
(53, 'Eswatini', 200, '2020-04-11', '2023-01-01', 10000, 5, 4),
(54, 'Mauritius', 100, '2020-04-12', '2023-01-01', 8000, 5, 3),
(55, 'Comoros', 80, '2020-04-13', '2023-01-01', 6000, 5, 4),
(56, 'Seychelles', 50, '2020-04-14', '2023-01-01', 4000, 5, 3),
(57, 'Chad', 2000, '2020-04-15', '2023-01-01', 150000, 5, 4),
(58, 'Niger', 1500, '2020-04-16', '2023-01-01', 100000, 5, 4),
(59, 'Mali', 1200, '2020-04-17', '2023-01-01', 80000, 5, 4),
(60, 'Burkina Faso', 1000, '2020-04-18', '2023-01-01', 60000, 5, 4),
(61, 'Benin', 800, '2020-04-19', '2023-01-01', 50000, 5, 4),
(62, 'Togo', 600, '2020-04-20', '2023-01-01', 40000, 5, 4),
(63, 'Sierra Leone', 500, '2020-04-21', '2023-01-01', 30000, 5, 4),
(64, 'Liberia', 400, '2020-04-22', '2023-01-01', 20000, 5, 4),
(65, 'Guinea', 300, '2020-04-23', '2023-01-01', 15000, 5, 4),
(66, 'Guinea-Bissau', 200, '2020-04-24', '2023-01-01', 10000, 5, 4),
(67, 'Gambia', 100, '2020-04-25', '2023-01-01', 8000, 5, 4),
(68, 'Cape Verde', 80, '2020-04-26', '2023-01-01', 6000, 5, 3),
(69, 'Sao Tome and Principe', 50, '2020-04-27', '2023-01-01', 4000, 5, 4),
(70, 'Equatorial Guinea', 40, '2020-04-28', '2023-01-01', 3000, 5, 3),
(71, 'Gabon', 30, '2020-04-29', '2023-01-01', 2000, 5, 3),
(72, 'Congo', 20, '2020-04-30', '2023-01-01', 1500, 5, 4),
(73, 'DR Congo', 1000, '2020-05-01', '2023-01-01', 80000, 5, 4),
(74, 'Central African Republic', 800, '2020-05-02', '2023-01-01', 60000, 5, 4),
(75, 'South Sudan', 600, '2020-05-03', '2023-01-01', 40000, 5, 4),
(76, 'Eritrea', 400, '2020-05-04', '2023-01-01', 30000, 5, 4),
(77, 'Djibouti', 300, '2020-05-05', '2023-01-01', 20000, 5, 4),
(78, 'Somalia', 200, '2020-05-06', '2023-01-01', 15000, 5, 4),
(79, 'Burundi', 100, '2020-05-07', '2023-01-01', 10000, 5, 4),
(80, 'Rwanda', 80, '2020-05-08', '2023-01-01', 8000, 5, 4),
(81, 'Uganda', 60, '2020-05-09', '2023-01-01', 6000, 5, 4),
(82, 'Tanzania', 40, '2020-05-10', '2023-01-01', 4000, 5, 4),
(83, 'Malawi', 20, '2020-05-11', '2023-01-01', 2000, 5, 4),
(84, 'Zambia', 10, '2020-05-12', '2023-01-01', 1000, 5, 4),
(85, 'Zimbabwe', 5, '2020-05-13', '2023-01-01', 500, 5, 4),
(86, 'Mozambique', 3, '2020-05-14', '2023-01-01', 300, 5, 4),
(87, 'Madagascar', 2, '2020-05-15', '2023-01-01', 200, 5, 4),
(88, 'Namibia', 1, '2020-05-16', '2023-01-01', 100, 5, 3),
(89, 'Botswana', 1, '2020-05-17', '2023-01-01', 100, 5, 3),
(90, 'Lesotho', 1, '2020-05-18', '2023-01-01', 100, 5, 4),
(91, 'Eswatini', 1, '2020-05-19', '2023-01-01', 100, 5, 4),
(92, 'Mauritius', 1, '2020-05-20', '2023-01-01', 100, 5, 3),
(93, 'Comoros', 1, '2020-05-21', '2023-01-01', 100, 5, 4),
(94, 'Seychelles', 1, '2020-05-22', '2023-01-01', 100, 5, 3),
(95, 'Chad', 1, '2020-05-23', '2023-01-01', 100, 5, 4),
(96, 'Niger', 1, '2020-05-24', '2023-01-01', 100, 5, 4),
(97, 'Mali', 1, '2020-05-25', '2023-01-01', 100, 5, 4),
(98, 'Burkina Faso', 1, '2020-05-26', '2023-01-01', 100, 5, 4),
(99, 'Benin', 1, '2020-05-27', '2023-01-01', 100, 5, 4),
(100, 'Togo', 1, '2020-05-28', '2023-01-01', 100, 5, 4);

--  Vaccine, Total rows: 20, Columns: 4
INSERT INTO Vaccine (Vaccine_ID, Vaccine_Name, Total_Deaths, Continent_ID)
VALUES 
(1, 'Pfizer', 10000, 2),
(2, 'Moderna', 5000, 3),
(3, 'AstraZeneca', 20000, 1),
(4, 'Johnson & Johnson', 15000, 3),
(5, 'Sputnik V', 12000, 2),
(6, 'Sinopharm', 18000, 1),
(7, 'Sinovac', 17000, 1),
(8, 'Covaxin', 10000, 1),
(9, 'Novavax', 8000, 3),
(10, 'CanSino', 7000, 1),
(11, 'CoronaVac', 9000, 1),
(12, 'EpiVacCorona', 6000, 2),
(13, 'ZyCoV-D', 5000, 1),
(14, 'Abdala', 4000, 4),
(15, 'Soberana', 3000, 4),
(16, 'MVC-COV1901', 2000, 1),
(17, 'COVIran Barekat', 1000, 1),
(18, 'RBD-Dimer', 500, 1),
(19, 'ZF2001', 300, 1),
(20, 'NVX-CoV2373', 200, 3);

--  Survivors, Total rows: 100, Columns: 3
INSERT INTO Survivors (No_of_Survivors, Vaccine_ID, Country_ID)
VALUES 
(5000000, 1, 1),
(3000000, 2, 2),
(2000000, 3, 3),
(1500000, 4, 4),
(1000000, 5, 5),
(800000, 6, 6),
(700000, 7, 7),
(600000, 8, 8),
(500000, 9, 9),
(400000, 10, 10),
(350000, 11, 11),
(300000, 12, 12),
(250000, 13, 13),
(200000, 14, 14),
(150000, 15, 15),
(100000, 16, 16),
(90000, 17, 17),
(80000, 18, 18),
(70000, 19, 19),
(60000, 20, 20),
(50000, 1, 21),
(40000, 2, 22),
(30000, 3, 23),
(20000, 4, 24),
(15000, 5, 25),
(10000, 6, 26),
(9000, 7, 27),
(8000, 8, 28),
(7000, 9, 29),
(6000, 10, 30),
(5000, 11, 31),
(4000, 12, 32),
(3000, 13, 33),
(2000, 14, 34),
(1500, 15, 35),
(1000, 16, 36),
(900, 17, 37),
(800, 18, 38),
(700, 19, 39),
(600, 20, 40),
(500, 1, 41),
(400, 2, 42),
(300, 3, 43),
(200, 4, 44),
(150, 5, 45),
(100, 6, 46),
(90, 7, 47),
(80, 8, 48),
(70, 9, 49),
(60, 10, 50),
(50, 11, 51),
(40, 12, 52),
(30, 13, 53),
(20, 14, 54),
(15, 15, 55),
(10, 16, 56),
(9, 17, 57),
(8, 18, 58),
(7, 19, 59),
(6, 20, 60),
(5, 1, 61),
(4, 2, 62),
(3, 3, 63),
(2, 4, 64),
(1, 5, 65),
(500000, 6, 66),
(400000, 7, 67),
(300000, 8, 68),
(200000, 9, 69),
(100000, 10, 70),
(90000, 11, 71),
(80000, 12, 72),
(70000, 13, 73),
(60000, 14, 74),
(50000, 15, 75),
(40000, 16, 76),
(30000, 17, 77),
(20000, 18, 78),
(15000, 19, 79),
(10000, 20, 80),
(9000, 1, 81),
(8000, 2, 82),
(7000, 3, 83),
(6000, 4, 84),
(5000, 5, 85),
(4000, 6, 86),
(3000, 7, 87),
(2000, 8, 88),
(1500, 9, 89),
(1000, 10, 90),
(900, 11, 91),
(800, 12, 92),
(700, 13, 93),
(600, 14, 94),
(500, 15, 95),
(400, 16, 96),
(300, 17, 97),
(200, 18, 98),
(150, 19, 99),
(100, 20, 100);