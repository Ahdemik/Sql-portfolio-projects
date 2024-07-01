--select *
--from CovidDeaths
--where continent is not null
--order by 3,4 

--select *
--from Covidvaccinations
--order by 3,4


--select location,total_cases,date,new_cases,total_cases,total_deaths,population
--from CovidDeaths
--where continent is not null
--order by 1,3

--Covid Death rate in Nigeria(Total_cases vs Total_death)

----select location,total_cases,date,total_deaths, (total_deaths/total_cases)*100 as Deathrate
----from CovidDeaths
----where location like 'Nigeria' 
--and continent is not null
----order by 1,3

--Total covid cases against Population in Nigeria

----select location,date,total_cases,population, (total_cases/population) as Percentage_Cases_Recorded
----from CovidDeaths
----where location like 'Nigeria'
--and continent is not null
----order by 1,2

--Countries with the highest infection rate compared to population

----select Location,Population, max(total_cases) as TotalCases, max((total_cases/population)*100) as Percentage_Cases_Recorded
----from CovidDeaths 
--where continent is not null
----group by Location, Population
----order by Percentage_Cases_Recorded DESC

--Countries with the highest infection rate compared 

--select Location, max(cast(total_cases as int)) as TotalCases
--from CovidDeaths 
--where continent is not null
--group by Location
--order by TotalCases DESC


--Countries with the highest death rate 

--select Location, max(cast(total_deaths as int)) as TotalDeathsCount
--from CovidDeaths
--where continent is not null
--group by Location
--order by TotalDeathsCount DESC

--Continents with the highest death rate 

--select Continent, max(cast(total_deaths as int)) as TotalDeathsCount
--from CovidDeaths
--where continent is not null
--group by continent
--order by TotalDeathsCount DESC

--Global Numbers (Total cases, Total deaths and death percentage per day)

--select Date, sum(new_cases) as Total_Cases, sum(cast(new_deaths as int)) as Total_Deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as Death_percentage
--from CovidDeaths
--where continent is not null
--group by date
--order by 1,2

-- Global Numbers (Total cases,Total deaths and death percentage)

--select sum(new_cases) as Total_Cases, sum(cast(new_deaths as int)) as Total_Deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as Death_percentage
--from CovidDeaths
--where continent is not null
--order by 1,2

--Joining the both table
--select *
--from CovidDeaths Death
--join Covidvaccinations Vac
--on Death.location = Vac.location
--and Death.date = Vac.date


--Total number of people vacinnated
----select sum(population) as Total_population, sum(cast(new_vaccinations as int)) as Total_Vaccinations
----from CovidDeaths Death
----join Covidvaccinations Vac
----on Death.location = Vac.location
----and Death.date = Vac.date
----where death.continent is not null


--Total number of people vacinnated in each country(Total Population vs Vaccinations)

--select death.continent, Death.location, death.date, Death.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as int)) over (partition by death.location,death.Date) as RollingPeopleVaccinated
--from CovidDeaths Death
--join Covidvaccinations Vac
--on Death.location = Vac.location
--and Death.date = Vac.date
--where death.continent is not null 
--order by 2,3

--Using CTE so we can use the RollingPeopleVaccinnated column for calculation

--With PopVsVac (Continent,Location,Date,Population,New_vaccinations,RollingPeopleVaccinated)
--as
--(
--select death.continent, Death.location, death.date, Death.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as int)) over (partition by death.location,death.Date) as RollingPeopleVaccinated
--from CovidDeaths Death
--join Covidvaccinations Vac
--on Death.location = Vac.location
--and Death.date = Vac.date
--where death.continent is not null 
--)
--select*, (RollingPeopleVaccinated/Population)*100
--from PopVsVac

--Using Temp Table

--Create Table #PercentagePopulationVaccinated
--(
--Continent varchar(50),
--Location varchar(50),
--Date datetime,
--Population numeric,
--New_Vaccinations numeric,
--RollingPeopleVaccinated numeric
--)

--insert into #PercentagePopulationVaccinated
--select death.continent, Death.location, death.date, Death.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as int)) over (partition by death.location,death.Date) as RollingPeopleVaccinated
--from CovidDeaths Death
--join Covidvaccinations Vac
--on Death.location = Vac.location
--and Death.date = Vac.date
--where death.continent is not null 


--select*, (RollingPeopleVaccinated/Population)*100
--from #PercentagePopulationVaccinated

--Creating view to store data for later visualizations

create view PercentPopulationVaccinated as
select death.continent, Death.location, death.date, Death.population, vac.new_vaccinations, sum(cast(vac.new_vaccinations as int)) over (partition by death.location,death.Date) as RollingPeopleVaccinated
from CovidDeaths Death
join Covidvaccinations Vac
on Death.location = Vac.location
and Death.date = Vac.date
where death.continent is not null

select *
from PercentPopulationVaccinated


 
