select *
from PortfolioProject..CovidDeaths$
order by 3,4

select location,date,total_cases,new_cases,total_deaths,population
from PortfolioProject..CovidDeaths$
order by 1,2

select location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as death_percantage
from PortfolioProject..CovidDeaths$
where location = 'india'
order by 1,2
select location,date,total_cases,population, (total_cases/population)*100
from PortfolioProject..CovidDeaths$
where location = 'india'
order by 1,2

select location,max(total_cases) as highest_infection,population,max(total_cases/population)*100 as infection_rate
from PortfolioProject..CovidDeaths$
group by location,population
order by 4 desc

select location,max(total_deaths) as total_deats,population,max(total_cases/population)*100 as infection_rate
from PortfolioProject..CovidDeaths$
group by location,population
order by 4 desc
select location,max(cast(total_deaths as int)) as death_count
from PortfolioProject..CovidDeaths$
where continent is not null
group by location
order by 2 desc

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths$
--Where location like '%states%'
Where continent is not null 
Group by continent
order by TotalDeathCount desc

select location,max(cast(total_deaths as int)) as death_count
from PortfolioProject..CovidDeaths$
where continent is null
group by location
order by 2 desc

select *
from PortfolioProject..CovidDeaths$
join PortfolioProject..[covid vaccination]
on CovidDeaths$.location = [covid vaccination].location
and CovidDeaths$.date = [covid vaccination].date

select CovidDeaths$.location,CovidDeaths$.continent,CovidDeaths$.date,CovidDeaths$.population,[covid vaccination].new_vaccinations
from PortfolioProject..CovidDeaths$
join PortfolioProject..[covid vaccination]
on CovidDeaths$.location = [covid vaccination].location
and CovidDeaths$.date = [covid vaccination].date
order by 1,2,3

select CovidDeaths$.location,CovidDeaths$.continent,CovidDeaths$.date,CovidDeaths$.population,[covid vaccination].new_vaccinations,
SUM(cast ([covid vaccination].new_vaccinations as int)) over (partition by CovidDeaths$.location order by CovidDeaths$.location,CovidDeaths$.date ) as rolling_vaccination
from PortfolioProject..CovidDeaths$
join PortfolioProject..[covid vaccination]
on CovidDeaths$.location = [covid vaccination].location
and CovidDeaths$.date = [covid vaccination].date
where CovidDeaths$.continent is not null
order by 1,3

with PopvsVac(contient,location,date,population,new_vaccination,rolling_vaccination)
as(
select CovidDeaths$.location,CovidDeaths$.continent,CovidDeaths$.date,CovidDeaths$.population,[covid vaccination].new_vaccinations,
SUM(cast ([covid vaccination].new_vaccinations as int)) over (partition by CovidDeaths$.location order by CovidDeaths$.location,CovidDeaths$.date ) as rolling_vaccination
from PortfolioProject..CovidDeaths$
join PortfolioProject..[covid vaccination]
on CovidDeaths$.location = [covid vaccination].location
and CovidDeaths$.date = [covid vaccination].date
where CovidDeaths$.continent is not null
)
select *, (rolling_vaccination/population)*100 as percent_vaccinated
from PopvsVac
 
 create view people_vaccinated as
 select CovidDeaths$.location,CovidDeaths$.continent,CovidDeaths$.date,CovidDeaths$.population,[covid vaccination].new_vaccinations,
SUM(cast ([covid vaccination].new_vaccinations as int)) over (partition by CovidDeaths$.location order by CovidDeaths$.location,CovidDeaths$.date ) as rolling_vaccination
from PortfolioProject..CovidDeaths$
join PortfolioProject..[covid vaccination]
on CovidDeaths$.location = [covid vaccination].location
and CovidDeaths$.date = [covid vaccination].date
where CovidDeaths$.continent is not null

select * 
from people_vaccinated