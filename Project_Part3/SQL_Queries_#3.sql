-- @Duren Gouda
--                                                     SECTION 3
-- ************************************************ SQL QUERIES!!! ********************************************
-- ****************************This script has 5 sql queries as required in the project************************


-- Query 1: Select from a single table with WHERE clause and derived attribute
SELECT 
    Country_Name,
    Total_Death / Total_Cases AS Deaths_Per_Case
FROM 
    Country
WHERE 
    Total_Cases > 10000;
    
    
-- Query 2: INNER JOIN between Vaccine and Continent
SELECT 
    Vaccine.Vaccine_Name,
    Continent.Continent_Name
FROM 
    Vaccine
INNER JOIN 
    Continent
    ON Vaccine.Continent_ID = Continent.Continent_ID;
    
    
-- Query 3: GROUP BY on Income_Class_Name with total deaths
SELECT 
    Income_Class.Income_Class_Name,
    SUM(Country.Total_Death) AS Total_Deaths
FROM 
    Income_Class
JOIN 
    Country 
    ON Income_Class.Income_Class_ID = Country.Income_Class_ID
GROUP BY 
    Income_Class.Income_Class_Name;
    

-- Query 4: Subquery in the FROM clause to select countries with deaths above average
SELECT 
    Country_Name,
    Total_Death
FROM 
    Country
WHERE 
    Total_Death > (SELECT AVG(Total_Death) FROM Country);
    
    
-- Query 5: Create a VIEW, select from the view, modify underlying table, and re-run SELECT

-- Here I dropped the existing view if it exists because I was running it again and again to check!!!
DROP VIEW IF EXISTS Vaccine_Continent_View;

-- Creates a VIEW from two or more tables, including derived attributes
CREATE VIEW Vaccine_Continent_View AS
SELECT
    Vaccine.Vaccine_Name,
    Continent.Continent_Name,
    Vaccine.Total_Deaths AS Vaccine_Deaths,
    Continent.Total_Deaths AS Continent_Deaths,
    (Vaccine.Total_Deaths / Continent.Total_Deaths) AS Deaths_Per_Continent
FROM Vaccine
JOIN Continent ON Vaccine.Continent_ID = Continent.Continent_ID;

-- Runs a SELECT query on the view
SELECT * FROM Vaccine_Continent_View;

-- Modifies one of the underlying tables (e.g, Vaccine)
UPDATE Vaccine
JOIN (SELECT Vaccine_ID FROM Vaccine WHERE Vaccine_Name = 'SafeGuard') AS subquery
    ON Vaccine.Vaccine_ID = subquery.Vaccine_ID
SET Vaccine.Total_Deaths = 50000; -- change of values!!

-- Re-runs the SELECT query on the view, reflecting changes in the underlying tables and the derived attributes
SELECT * FROM Vaccine_Continent_View;
