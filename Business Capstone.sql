## Data Wrangling
-- Creating DABASE
-- DROP DATABASE IF EXISTS Covid_Project;
CREATE DATABASE Business_Capstone;
USE Business_Capstone;

-- Imported data by right clicking on each table and selecting Table Data Import Wizard

# covid_vaccinations
SELECT * FROM covid_vaccinations;
SELECT COUNT(*) FROM covid_vaccinations;

# covid_variables    
-- DROP TABLE IF EXISTS covid_variables;
SELECT * FROM covid_variables;
SELECT COUNT(*) FROM covid_variables;

-- date column in both datasets is in text data type, let's get it in the right format.
UPDATE covid_variables SET date = str_to_date(date, "%m/%d/%Y");
UPDATE covid_vaccinations SET date = str_to_date(date, "%m/%d/%Y");

-- Checking coviddeaths dataset
SELECT *
FROM covid_variables
ORDER BY 4
DESC;

## Data Analysis
-- Selecting data that will be used in this analysis
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM covid_variables
ORDER BY 1;

SELECT location, population
FROM covid_variables
;

-- Total Cases Vs. Total Deaths -> Likelihood of dying if contract covid in Brazil
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM covid_variables
WHERE Location = "Brazil"
ORDER BY 2;

-- Total Cases Vs. Population -> The percentage of population who were infected.
SELECT Location, date, population, total_cases, (total_cases/population)*100 as Infection_Rate
FROM covid_variables
WHERE Location = "Brazil"
ORDER BY 3;

-- Total Cases Vs. Population -> Countries with the highest Infection_Rate.
SELECT Location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 as Infection_Rate
FROM covid_variables
GROUP BY Location, population
ORDER BY Infection_Rate DESC;

