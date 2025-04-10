-- @Duren Gouda
--                                                     SECTION 2
-- ************************************************ STORED PROCEDURES!!! ********************************************
-- ****************************This script has 2 procedures as required in the project*******************************

-- 													NOTE:
-- If running the script using Ctrl-Shift-Enter, do it one more time cause while I was doing it showed:
-- "Error Code: 2014 Commands out of sync; you can't run this command now", but after running again it was working
-- so please consider using Ctrl-Shift-Enter again, if error shows, I am suing again the Database, so need to be synced first!!!!!	



USE Project_CSCI2141; -- comment this if needed, up to you, but if doesn't run uncomment it!!

DELIMITER //

-- Drop if already exists, this is because I was syncing and cheching it again and again!!
DROP PROCEDURE IF EXISTS AddVaccineAndUpdateCountries;
DROP PROCEDURE IF EXISTS DeleteLowImpactCountry;

-- Procedure 1: Add a new vaccine and increase total_death of countries in the same continent
CREATE PROCEDURE AddVaccineAndUpdateCountries (
    IN v_name VARCHAR(100),
    IN death_inc INT,
    IN cont_id INT,
    OUT new_vaccine_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    -- Insert new vaccine into Vaccine table
    INSERT INTO Vaccine (Vaccine_Name, Total_Deaths, Continent_ID)
    VALUES (v_name, death_inc, cont_id);

    -- Get the new Vaccine_ID
    SET new_vaccine_id = LAST_INSERT_ID();

    -- Update total death in all countries in the same continent
    UPDATE Country
    SET Total_Death = Total_Death + death_inc
    WHERE Continent_ID = cont_id;

    COMMIT;
END;
//

-- Procedure 2: Delete country if deaths fall below a threshold value and remove it from Survivors
CREATE PROCEDURE DeleteLowImpactCountry (
    IN c_id INT,
    IN threshold INT,
    OUT result_msg VARCHAR(255)
)
BEGIN
    DECLARE c_deaths BIGINT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
    END;

    START TRANSACTION;

    -- Get total death from Country
    SELECT Total_Death INTO c_deaths
    FROM Country
    WHERE Country_ID = c_id;

    IF c_deaths < threshold THEN
        -- Delete related Survivors
        DELETE FROM Survivors
        WHERE Country_ID = c_id;

        -- Delete country
        DELETE FROM Country
        WHERE Country_ID = c_id;

        SET result_msg = CONCAT('Country ID ', c_id, ' deleted due to low death count.');
    ELSE
        SET result_msg = CONCAT('Country ID ', c_id, ' not deleted: death count too high.');
    END IF;

    COMMIT;
END;
//

DELIMITER ;

-- Add vaccine "SafeGuard" to continent 3 and update related countries
SET @v_id = 0;
CALL AddVaccineAndUpdateCountries('SafeGuard', 1500, 3, @v_id);
SELECT @v_id AS NewVaccineID; -- in this table, Vaccine_ID is shown in the row!!, after that check in Vaccine table as well you can see the 21st vaccine!!

-- Deleting country ID 45 if death count < 10000
SET @message = '';
CALL DeleteLowImpactCountry(45, 10000, @message);
SELECT @message AS ActionResult;
