# Medical Analytics SQL Project

## Overview

This project demonstrates applied SQL using a real-world healthcare database structure inspired by the OpenMRS electronic medical record system. The objective is to extract, clean, transform, and analyze patient encounter data to generate meaningful clinical insights.

The project includes creating analytical queries, resolving schema relationships, working with entity relationships, performing joins, data cleaning, and producing structured reporting outputs.

---

## Problem Statement

Healthcare organizations store large volumes of patient details, clinical encounters, diagnoses, and demographic information across normalized relational tables. A common challenge is to consolidate this scattered information into structured analytical reports.

The goal of this project was to:

* Understand schema layout and table relationships
* Explore patient demographics and encounters
* Produce analytical reports joining multiple tables
* Handle missing, inconsistent, or duplicated values

---

## Database Tables Used

| Table                                        | Purpose                                                  |
| -------------------------------------------- | -------------------------------------------------------- |
| `patient`                                    | Stores patient records                                   |
| `patient_identifier`                         | Contains OpenMRS ID values for patients                  |
| `person`                                     | Core demographics (gender, birthdate, person_id mapping) |
| `person_name`                                | Stores first and last names                              |
| `person_attribute` & `person_attribute_type` | Extra demographic details (Caste, Education, etc.)       |

---

## Key SQL Skills Demonstrated

* Schema understanding & relationship mapping
* INNER JOIN vs LEFT JOIN usage
* Data cleaning and deduplication
* Conditional aggregation using `CASE WHEN`
* Grouping and summarizing results
* Building analytical queries producing 1 row per patient

---

## Main Query Output Goal

Generate a single consolidated report containing:

```
patient_id | openmrs_id | first_name | last_name | gender | birthdate | caste | education
```
---

## Output Example

| patient_id | openmrs_id | first_name | last_name | gender | birthdate  | caste | education |
| ---------- | ---------- | ---------- | --------- | ------ | ---------- | ----- | --------- |
| 1053       | 8AH23832   | Arjun      | Patil     | M      | 1994-07-11 | OBC   | Graduate  |

---

## Skills Demonstrated

* Real-world healthcare data analytics
* Database normalization & joins
* Optimized SQL query authoring
* Reporting & aggregation

---

## Next Steps (Future Enhancements)

* Visualize results using PowerBI / Tableau / Python
* Automate report generation via stored procedures
* Create encounter & diagnosis dashboards

---

## How to Use

Clone repository and run SQL file inside MySQL Workbench / PostgreSQL / DBeaver environment to reproduce results.

---
