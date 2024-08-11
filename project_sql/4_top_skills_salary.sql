/*
Question - What are the top skills based on salary?
*/

SELECT
    skills,
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
GROUP BY 
    skills
ORDER BY 
    avg_salary DESC
Limit 25