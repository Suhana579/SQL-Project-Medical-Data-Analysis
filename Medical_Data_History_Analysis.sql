use project_medical_data_history;

-- 1. Show first name, last name, and gender of patients who's gender is 'M'
select first_name, last_name, gender
from patients
where gender like 'M%';

-- 2. Show first name and last name of patients who does not have allergies.
select first_name , last_name, allergies
from patients
where allergies is null;

-- 3. Show first name of patients that start with the letter 'C'
select first_name
from patients
where first_name like 'C%';

-- 4. Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
select first_name, last_name
from patients
where weight between 100 and 120;

-- 5. Update the patients table for the allergies column. 
-- If the patient's allergies is null then replace it with 'NKA'.
update patients 
set allergies = 'NKA'
where allergies is null;

-- 6. Show first name and last name concatenated into one column to show their full name.
select 
concat(first_name, ' ' ,last_name) as full_name
from patients;

-- 7. Show first name, last name, and the full province name of each patient.
select p.first_name, p.last_name, s.province_name
from patients p
join province_names s on p.province_id=s.province_id;

-- 8. Show how many patients have a birth_date with 2010 as the birth year.
select count(*) as patient_count
from patients
where year(birth_date)=2010;

-- 9. Show the first_name, last_name, and height of the patient with the greatest height.
select first_name, last_name, height
from patients
order by height desc limit 1;

-- 10. Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
select * 
from patients
where patient_id in(1,45,534,879,1000);

-- 11. Show the total number of admissions
select count(*) as total_admissions
from admissions;

-- 12. Show all the columns from admissions where the patient was admitted and discharged on the same day.
select * 
from admissions
where admission_date=discharge_date;

-- 13. Show the total number of admissions for patient_id 579.
select patient_id,count(patient_id)
from admissions 
where patient_id=579;

-- 14. Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
select distinct city
from patients
where province_id='NS';

-- 15. Write a query to find the first_name, last name and birth date of patients 
-- who have height more than 160 and weight more than 70
select first_name, last_name, birth_date, height, weight
from patients
where height>160 and weight>70;

-- 16. Show unique birth years from patients and order them by ascending.
select distinct year(birth_date) as birth_year
from patients 
order by birth_year asc;

-- 17. Show unique first names from the patients table which only occurs once in the list.
select first_name
from patients
group by first_name
having count(first_name)=1;

-- 18. Show patient_id and first_name from patients where their first_name start and ends with 's' 
-- and is at least 6 characters long.
select patient_id, first_name
from patients
where first_name like "s____%s";

-- 19. Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.   
-- Primary diagnosis is stored in the admissions table.
select a.patient_id, p.first_name, p.last_name
from patients p
join admissions a 
on a.patient_id=p.patient_id
where diagnosis='dementia';

-- 20. Display every patient's first_name. 
-- Order the list by the length of each name and then by alphbetically.
select first_name
from patients
order by length(first_name), first_name;

-- 21.Show the total amount of male patients and the total amount of female patients in the patients table. 
-- Display the two results in the same row.
select 
count(case when gender='M' then 1 end) as total_male,
count(case when gender='F' then 1 end ) as total_female
from patients;

-- 22. Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.
select 
count(case when gender='M' then 1 end) as total_male,
count(case when gender='F' then 1 end ) as total_female
from patients;

-- 23. Show patient_id, diagnosis from admissions.
-- Find patients admitted multiple times for the same diagnosis.
select patient_id, diagnosis
from admissions
group by patient_id, diagnosis
having count(*)>1;

-- 24. Show the city and the total number of patients in the city. 
-- Order from most to least patients and then by city name ascending.
select city, count(*) as total_patient
from patients
group by city
order by total_patient desc, city asc;

-- 25. Show first name, last name and role of every person that is either patient or doctor.
-- The roles are either "Patient" or "Doctor"
SELECT first_name, last_name, 'patient' AS role
FROM patients
UNION all
SELECT first_name, last_name, 'doctor' AS role
FROM doctors;

-- 26. Show all allergies ordered by popularity. Remove NULL values from query.
select allergies, count(*) as total_diagnosis
from patients
where allergies is not null
group by allergies
order by total_diagnosis desc;

-- 27. Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. 
-- Sort the list starting from the earliest birth_date.
select first_name, last_name, birth_date
from patients
where birth_date BETWEEN '1970-01-01' AND '1979-12-31'
order by birth_date asc;

-- 28. We want to display each patients full name in a single column. 
-- Their last_name in all upper letters must appear first, then first_name in all lower case letters. 
-- Separate the last_name and first_name with a comma. Order the list by the first_name in decending order    
-- EX: SMITH,jane
select concat(upper(last_name), ',', lower(first_name)) as full_name
from patients
order by lower(first_name) desc;

-- 29. Show the province_id(s), sum of height; 
-- where the total sum of its patient's height is greater than or equal to 7,000.
select province_id, sum(height) as total_height
from patients
group by province_id
having sum(height)>=7000;

-- 30. Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
select max(weight) - min(weight) as weight_difference 
from patients
where last_name = 'Maroni';

-- 31. Show all of the days of the month (1-31) and how many admission_dates occurred on that day. 
-- Sort by the day with most admissions to least admissions.
select day(admission_date) as day_of_month,
count(*) as admission_count
from admissions
group by day(admission_date)
order by admission_count desc;

-- 32. Show all of the patients grouped into weight groups. 
-- Show the total amount of patients in each weight group. 
-- Order the list by the weight group decending. 
-- e.g. if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.
SELECT FLOOR(weight / 10) * 10 AS weight_group,
COUNT(*) AS total_patients
FROM patients
GROUP BY weight_group
ORDER BY weight_group DESC;

-- 33. Show patient_id, weight, height, isObese from the patients table. 
-- Display isObese as a boolean 0 or 1. Obese is defined as weight(kg)/(height(m). 
-- Weight is in units kg. Height is in units cm.
SELECT patient_id, weight, height,
CASE WHEN (weight / POWER(height / 100, 2)) >= 30 THEN 1
ELSE 0 END AS isObese
FROM patients;

-- 34. Show patient_id, first_name, last_name, and attending doctor's specialty. 
-- Show only the patients who has a diagnosis as 'Epilepsy' and the doctors first name is'Lisa'.
-- Check patients, admissions, and doctors tables for required information.
select p.patient_id, p.first_name, p.last_name,d.specialty  from patients p
inner join admissions a on p.patient_id = a.patient_id
inner join doctors d on a.attending_doctor_id = d.doctor_id  where a.diagnosis = 'Epilepsy'and d.first_name = 'Lisa';


-- 35. All patients who have gone through admissions, can see their medical documents on our site. 
-- Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.
-- The password must be the following, in order:
   --  - patient_id
   -- - the numerical length of patient's last_name
   --  - year of patient's birth_date
select distinct p.patient_id, concat(a.patient_id,  length(p.last_name), year(p.birth_date))
as temp_password  from patients p
inner join admissions a on p.patient_id = a.patient_id;




