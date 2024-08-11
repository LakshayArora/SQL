/* 
Questions - What are the in demand skills for the Business analyst roles(remote)?
*/

SELECT
    skills,
    count(skills_job_dim.job_id) as demand_count
FROM 
    job_postings_fact
INNER JOIN 
    skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Business Analyst' 
GROUP BY 
    skills
ORDER BY
    demand_count DESC
Limit 5