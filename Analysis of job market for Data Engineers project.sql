---- Query 1: Top 10 High Paying Data Engineer Job Postings

--select top 10
--	job_id,
--	job_title,
--	company_dim.name as company,
--	job_schedule_type,
--	salary_year_avg,
--	cast(job_posted_date as Date) as date
--from job_postings_fact
--left join company_dim on job_postings_fact.company_id = company_dim.company_id 
--where 
--	job_title_short = 'Data Engineer' 
--	and name is not null
--	and job_location = 'Anywhere' 
--	and salary_year_avg <> 0
--order by salary_year_avg desc;

---- Query 2: Top 10 High Paying Data Engineer Job Postings with Skills

--with top_paying_role as (
--	select  
--		job_id,
--		job_title,
--		name as company,
--		salary_year_avg
--	from job_postings_fact
--	left join company_dim on job_postings_fact.company_id = company_dim.company_id 
--	where 
--		job_title_short = 'Data Engineer' 
--		and job_location = 'Anywhere' 
--		and salary_year_avg <> 0
--		and name is not null
--)
--select top 10
--	top_paying_role.*,
--	skills
--from top_paying_role
--inner join Skill_job_dim on top_paying_role.job_id = Skill_job_dim.job_id 
--inner join skills_dim on Skill_job_dim.skill_id = skills_dim.skill_id
--order by salary_year_avg desc;

---- Query 3: Top 10 Most In-Demand Skills for Data Engineer Roles

--select top 10 
--	skills,
--	count(skills_dim.skill_id) as demand_count
--from job_postings_fact
--inner join Skill_job_dim on job_postings_fact.job_id = Skill_job_dim.job_id 
--inner join skills_dim on Skill_job_dim.skill_id = skills_dim.skill_id
--where job_title_short = 'Data Engineer'
--group by skills
--order by demand_count desc;

---- Query 4: Top 20 Skills by Average Salary for Data Engineer Roles
--select top 20 
--	skills,
--	ceiling(avg(salary_year_avg)) as avg_salary
--from job_postings_fact
--inner join Skill_job_dim on job_postings_fact.job_id = Skill_job_dim.job_id 
--inner join skills_dim on Skill_job_dim.skill_id = skills_dim.skill_id
--where job_title_short = 'Data Engineer' and salary_year_avg <> 0
--group by skills 
--order by avg_salary desc;

---- Query 5: Top 25 In-Demand Skills with Average Salary and Demand Count for Data Engineer Roles

--select top 25
--	skills,
--	count(skills_dim.skill_id) as demand_count,
--	ceiling(avg(salary_year_avg)) as total_salary
--from job_postings_fact
--inner join Skill_job_dim on job_postings_fact.job_id = Skill_job_dim.job_id 
--inner join skills_dim on Skill_job_dim.skill_id = skills_dim.skill_id
--where job_title_short = 'Data Engineer' and salary_year_avg <> 0 
--group by skills 
--having count(skills_dim.skill_id) > 10
--order by total_salary desc;
