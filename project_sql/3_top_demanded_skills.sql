/* 
Questions - What are the in demand skills for the Data analyst roles?
*/

SELECT
    *
FROM 
    job_postings_fact
INNER JOIN 
    skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN 
    skills_dim on skills_job_dim.skill_id = skills_dim.skill_id