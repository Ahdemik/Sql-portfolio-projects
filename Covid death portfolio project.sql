-- SQL Queries for COVID-19 Data Analysis
-- Organized by Adeyemi Michael

-- 1. Overview of COVID-19 Deaths Table
SELECT *
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY location, date;

-- 2. Overview of COVID-19 Vaccinations Table
SELECT *
FROM Covidvaccinations
ORDER BY location, date;

-- 3. Country-specific COVID-19 Cases and Deaths
SELECT location, total_cases, date, new_cases, total_cases, total_deaths, population
FROM CovidDeaths
WHERE continent IS NOT NULL
ORDER BY location, date;

-- 4. COVID-19 Death Rate in Nigeria
SELECT location, total_cases, date, total_deaths, 
       (total_deaths / total_cases) * 100 AS DeathRate
FROM CovidDeaths
WHERE location LIKE 'Nigeria' AND continent IS NOT NULL
ORDER BY date;

-- 5. COVID-19 Cases vs Population in Nigeria
SELECT location, date, total_cases, population, 
       (total_cases / population) * 100 AS Percentage_Cases_Recorded
FROM CovidDeaths
WHERE location LIKE 'Nigeria' AND continent IS NOT NULL
ORDER BY date;

-- 6. Countries with the Highest Infection Rate (Cases vs Population)
SELECT location, population, MAX(total_cases) AS TotalCases, 
       MAX((total_cases / population) * 100) AS Percentage_Cases_Recorded
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY Percentage_Cases_Recorded DESC;

-- 7. Countries with the Highest Number of Cases
SELECT location, MAX(CAST(total_cases AS INT)) AS TotalCases
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalCases DESC;

-- 8. Countries with the Highest Number of Deaths
SELECT location, MAX(CAST(total_deaths AS INT)) AS TotalDeathsCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathsCount DESC;

-- 9. Continents with the Highest Number of Deaths
SELECT continent, MAX(CAST(total_deaths AS INT)) AS TotalDeathsCount
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathsCount DESC;

-- 10. Global Daily COVID-19 Numbers (Cases, Deaths, Death Percentage)
SELECT date, SUM(new_cases) AS Total_Cases, 
       SUM(CAST(new_deaths AS INT)) AS Total_Deaths, 
       (SUM(CAST(new_deaths AS INT)) / SUM(new_cases)) * 100 AS Death_Percentage
FROM CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;

-- 11. Global Aggregated COVID-19 Numbers
SELECT SUM(new_cases) AS Total_Cases, 
       SUM(CAST(new_deaths AS INT)) AS Total_Deaths, 
       (SUM(CAST(new_deaths AS INT)) / SUM(new_cases)) * 100 AS Death_Percentage
FROM CovidDeaths
WHERE continent IS NOT NULL;

-- 12. Joining COVID-19 Deaths and Vaccinations Tables
SELECT *
FROM CovidDeaths Death
JOIN Covidvaccinations Vac
  ON Death.location = Vac.location
 AND Death.date = Vac.date;

-- 13. Total Vaccinations Worldwide
SELECT SUM(population) AS Total_Population, 
       SUM(CAST(new_vaccinations AS INT)) AS Total_Vaccinations
FROM CovidDeaths Death
JOIN Covidvaccinations Vac
  ON Death.location = Vac.location
 AND Death.date = Vac.date
WHERE Death.continent IS NOT NULL;

-- 14. Country-wise Vaccinations vs Population
SELECT Death.continent, Death.location, Death.date, Death.population, 
       Vac.new_vaccinations, 
       SUM(CAST(Vac.new_vaccinations AS INT)) OVER (PARTITION BY Death.location, Death.date) AS RollingPeopleVaccinated
FROM CovidDeaths Death
JOIN Covidvaccinations Vac
  ON Death.location = Vac.location
 AND Death.date = Vac.date
WHERE Death.continent IS NOT NULL
ORDER BY Death.location, Death.date;

-- 15. Population Vaccinated (Using CTE)
WITH PopVsVac AS (
    SELECT Death.continent, Death.location, Death.date, Death.population, 
           Vac.new_vaccinations, 
           SUM(CAST(Vac.new_vaccinations AS INT)) OVER (PARTITION BY Death.location, Death.date) AS RollingPeopleVaccinated
    FROM CovidDeaths Death
    JOIN Covidvaccinations Vac
      ON Death.location = Vac.location
     AND Death.date = Vac.date
    WHERE Death.continent IS NOT NULL
)
SELECT *, (RollingPeopleVaccinated / Population) * 100 AS Percentage_Vaccinated
FROM PopVsVac;

-- 16. Population Vaccinated (Using Temporary Table)
CREATE TABLE #PercentagePopulationVaccinated (
    Continent VARCHAR(50),
    Location VARCHAR(50),
    Date DATETIME,
    Population NUMERIC,
    New_Vaccinations NUMERIC,
    RollingPeopleVaccinated NUMERIC
);

INSERT INTO #PercentagePopulationVaccinated
SELECT Death.continent, Death.location, Death.date, Death.population, 
       Vac.new_vaccinations, 
       SUM(CAST(Vac.new_vaccinations AS INT)) OVER (PARTITION BY Death.location, Death.date) AS RollingPeopleVaccinated
FROM CovidDeaths Death
JOIN Covidvaccinations Vac
  ON Death.location = Vac.location
 AND Death.date = Vac.date
WHERE Death.continent IS NOT NULL;

SELECT *, (RollingPeopleVaccinated / Population) * 100 AS Percentage_Vaccinated
FROM #PercentagePopulationVaccinated;

-- 17. Creating a View for Vaccination Data
CREATE VIEW PercentPopulationVaccinated AS
SELECT Death.continent, Death.location, Death.date, Death.population, 
       Vac.new_vaccinations, 
       SUM(CAST(Vac.new_vaccinations AS INT)) OVER (PARTITION BY Death.location, Death.date) AS RollingPeopleVaccinated
FROM CovidDeaths Death
JOIN Covidvaccinations Vac
  ON Death.location = Vac.location
 AND Death.date = Vac.date
WHERE Death.continent IS NOT NULL;

SELECT *
FROM PercentPopulationVaccinated;
