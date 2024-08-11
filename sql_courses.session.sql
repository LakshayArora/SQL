-- Create a new table for job postings in January
CREATE TABLE jan_jobs AS
SELECT * 
FROM job_postings_fact 
WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- Create a new table for job postings in February
CREATE TABLE feb_jobs AS
SELECT * 
FROM job_postings_fact 
WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- Create a new table for job postings in March
CREATE TABLE mar_jobs AS
SELECT * 
FROM job_postings_fact 
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

 
SELECT 
    count(job_title_short) as title,
    
    CASE
        WHEN salary_year_avg BETWEEN 0 AND 90000 THEN 'LOW'
        WHEN salary_year_avg BETWEEN 90000 AND 180000 THEN 'MEDIUM'
        ELSE 'HIGH'
    END AS salary_category  -- Renamed location_category to salary_category for clarity

FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY salary_category;


select 
    name,company_id
from company_dim
where company_id in
(
select 
    company_id
FROM
    job_postings_fact
WHERE
    job_no_degree_mention = true
)
order by company_id;

WITH company_count AS (
    SELECT 
        company_id,
        COUNT(*) AS total_job
    FROM
        job_postings_fact
    GROUP BY    
        company_id
)
SELECT * FROM company_count;


select  
      company_dim.name as name,
      company_count.total_job
from
    company_dim,company_count
left join company_count 
    on
          company_count.company_id = company_dim.company_id
order by total_job DESC;

with remote_job as(
select
    skills_to_job.skill_id,
    COUNT(*) AS skill_count
from   
    skills_job_dim as skills_to_job
    
INNER join job_postings_fact as job_postings 
    on
           job_postings.job_id = skills_to_job.job_id
WHERE 
    job_postings.job_work_from_home = TRUE 
GROUP BY
    skill_id
)
SELECT * FROM remote_job;
