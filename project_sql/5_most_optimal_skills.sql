/*
Question- What are the most optimal skills based on salary with remote positions only?
*/

WITH skills_demand AS(
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.job_id) as demand_count
FROM 
    job_postings_fact
INNER JOIN 
    skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Business Analyst'
    AND
    salary_year_avg is not NULL
    AND
    job_work_from_home = TRUE
GROUP BY 
    skills_dim.skill_id
)
/*Select *
FROm skills_demand
*/
,
average_salary AS 
(
SELECT
    skills_job_dim.skill_id,
   ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM 
    job_postings_fact
INNER JOIN 
    skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Business Analyst'
    AND
    salary_year_avg is not NULL
    AND
    job_work_from_home = TRUE
GROUP BY 
    skills_job_dim.skill_id
)


SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary
    ON  skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count>8

ORDER BY 
    avg_salary DESC,
    demand_count DESC


------CONCISE CODE

SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) as demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) as avg_salary
FROM    
    job_postings_fact
INNER JOIN 
    skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Business Analyst'
    AND
    salary_year_avg is not NULL
    AND
    job_work_from_home = TRUE
GROUP BY 
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id)>8
ORDER BY 
    avg_salary DESC,
    demand_count DESC