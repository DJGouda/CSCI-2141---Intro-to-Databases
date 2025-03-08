--                                                     SECTION 2
-- ************************************************ CREATE TABLES!!! ********************************************

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
    Vaccine_ID INT PRIMARY KEY,               -- Primary key for vaccine
    Vaccine_Name VARCHAR(50) NOT NULL,        -- Name of the vaccine
    Total_Deaths INT,                         -- Total deaths in the continent where the vaccine is used
    Continent_ID INT,                         -- Foreign key referencing Continent
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

-- *********************************** INSERT INTO VALUES STATEMENTS!! ************************************

-- Income_Class, Total rows: 4, Columns: 3
INSERT INTO Income_Class (Income_Class_ID, Income_Class_Name, Total_Deaths)
VALUES (1, 'High Income', 100000);

-- Continent, Total rows: 6, Columns: 3
INSERT INTO Continent (Continent_ID, Continent_Name, Total_Deaths)
VALUES (1, 'Asia', 500000);

-- Country, Total rows: 100, Columns: 8
INSERT INTO Country (Country_ID, Country_Name, Total_Death, First_Case_Death, Last_Case_Death, Total_Cases, Continent_ID, Income_Class_ID)
VALUES 
(1, 'United States', 1000000, '2020-03-01', '2023-01-01', 50000000, 3, 1);

--  Vaccine, Total rows: 20, Columns: 4
INSERT INTO Vaccine (Vaccine_ID, Vaccine_Name, Total_Deaths, Continent_ID)
VALUES 
(1, 'Pfizer', 10000, 2);

--  Survivors, Total rows: 100, Columns: 3
INSERT INTO Survivors (No_of_Survivors, Vaccine_ID, Country_ID)
VALUES 
(5000000, 1, 1);


--                                                      SECTION 3

-- QUERY 1: 
/* According to query 1, this selects data from the Country table, filter countries with > 100,000 total deaths.
 It also calculates Death_Rate as the ratio of total deaths to total cases */

-- Total rows: 10, Columns: 4

SELECT 
    Country_Name, 
    Total_Death, 
    Total_Cases, 
    (Total_Death / Total_Cases) * 100 AS Death_Rate
FROM 
    Country
WHERE 
    Total_Death > 100000;
    
-- Query 2:
/*This query performs an INNER JOIN between the Country and Continent tables to display
 the country name, total deaths, and the corresponding continent name */
 
-- Total rows: 5, Columns: 3
 
SELECT 
    Country.Country_Name, 
    Country.Total_Death, 
    Continent.Continent_Name
FROM 
    Country
INNER JOIN 
    Continent ON Country.Continent_ID = Continent.Continent_ID
LIMIT 5;

-- Query 3:
/*This query uses a GROUP BY statement to calculate the total number of survivors vaccine wiht an INNER JOIN as well.
It joins the Survivors and Vaccine tables to display the vaccine name and the total number of survivors */

-- Total rows: 3, Columns: 2

SELECT 
    Vaccine.Vaccine_Name, 
    SUM(Survivors.No_of_Survivors) AS Total_Survivors
FROM 
    Survivors
INNER JOIN 
    Vaccine ON Survivors.Vaccine_ID = Vaccine.Vaccine_ID
GROUP BY 
    Vaccine.Vaccine_Name;





