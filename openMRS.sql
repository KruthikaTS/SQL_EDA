-- OpenMRS SQL Exploration & Reporting Project

-- 1. View all tables in schema
SHOW TABLES;

-- 2. Inspect columns across schema
SELECT table_name, column_name
FROM information_schema.columns
WHERE table_schema = 'intele'
ORDER BY table_name;

-- 3. Sample row previews
SELECT * FROM patient LIMIT 10;
SELECT * FROM person LIMIT 10;
SELECT * FROM person_name LIMIT 10;
SELECT * FROM patient_identifier LIMIT 10;
SELECT * FROM encounter LIMIT 10;
SELECT * FROM obs LIMIT 10;

-- 4. Table row counts
SELECT COUNT(*) AS total_patients FROM patient;
SELECT COUNT(*) AS total_persons FROM person;
SELECT COUNT(*) AS total_encounters FROM encounter;
SELECT COUNT(*) AS total_obs FROM obs;

-- 5. Patient + Encounter relationship example
SELECT p.patient_id, e.encounter_id, e.encounter_datetime
FROM patient p
LEFT JOIN encounter e ON p.patient_id = e.patient_id
ORDER BY p.patient_id
LIMIT 20;

-- 6. Count encounters per patient
SELECT p.patient_id, COUNT(e.encounter_id) AS encounter_count
FROM patient p
LEFT JOIN encounter e ON p.patient_id = e.patient_id
GROUP BY p.patient_id
ORDER BY encounter_count DESC
LIMIT 20;

-- 7. Identify attribute names available
SELECT DISTINCT name FROM person_attribute_type;

-- 8. Get caste and education values sample
SELECT pa.person_id, pat.name, pa.value
FROM person_attribute pa
JOIN person_attribute_type pat
ON pa.person_attribute_type_id = pat.person_attribute_type_id
WHERE pat.name IN ('Caste', 'Education')
LIMIT 20;

-- 9. Final consolidated Patient Profile Report
-- Required Columns: patient_id, openmrs_id, firstName, lastName, gender, birthdate, caste, education

SELECT p.patient_id,
       pi.identifier AS openmrs_id,
       pn.given_name AS first_name,
       pn.family_name AS last_name,
       per.gender,
       per.birthdate,
       MAX(CASE WHEN pat.name = 'Caste' THEN pa.value END) AS caste,
       MAX(CASE WHEN pat.name = 'Education' THEN pa.value END) AS education
FROM patient p
JOIN patient_identifier pi ON p.patient_id = pi.patient_id
JOIN person per ON p.patient_id = per.person_id
JOIN person_name pn ON per.person_id = pn.person_id
LEFT JOIN person_attribute pa ON per.person_id = pa.person_id
LEFT JOIN person_attribute_type pat ON pa.person_attribute_type_id = pat.person_attribute_type_id
GROUP BY p.patient_id, pi.identifier, pn.given_name, pn.family_name, per.gender, per.birthdate
ORDER BY p.patient_id;

---
### ER Relationships Summary
Person → Patient → Visit → Encounter → Obs, with side tables for name, identifiers & attributes.

### 🛠 Create SQL View for Final Patient Report
CREATE OR REPLACE VIEW patient_profile_report AS
SELECT p.patient_id,
       pi.identifier AS openmrs_id,
       pn.given_name AS first_name,
       pn.family_name AS last_name,
       per.gender,
       per.birthdate,
       MAX(CASE WHEN pat.name = 'Caste' THEN pa.value END) AS caste,
       MAX(CASE WHEN pat.name = 'Education' THEN pa.value END) AS education
FROM patient p
JOIN patient_identifier pi ON p.patient_id = pi.patient_id
JOIN person per ON p.patient_id = per.person_id
JOIN person_name pn ON per.person_id = pn.person_id
LEFT JOIN person_attribute pa ON per.person_id = pa.person_id
LEFT JOIN person_attribute_type pat ON pa.person_attribute_type_id = pat.person_attribute_type_id
GROUP BY p.patient_id, pi.identifier, pn.given_name, pn.family_name, per.gender, per.birthdate
ORDER BY p.patient_id;

### Export Final Report to CSV
SELECT * FROM patient_profile_report
INTO OUTFILE '/var/lib/mysql-files/patient_profile_report.csv'
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '
';
