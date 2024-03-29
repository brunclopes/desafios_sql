SELECT 
ID, 
NAME,
COUNTRYCODE,
DISTRICT,
POPULATION
FROM CITY 
WHERE COUNTRYCODE = 'USA'
AND POPULATION > 100000;


SELECT 
NAME 
FROM CITY 
WHERE COUNTRYCODE = 'USA'
AND POPULATION > 120000;


SELECT * 
FROM CITY;


SELECT * 
FROM 
CITY 
WHERE ID = 1661;


SELECT * FROM CITY
WHERE COUNTRYCODE = 'JPN';


SELECT
ID,
NAME,
COUNTRYCODE,
DISTRICT,
POPULATION
FROM CITY WHERE COUNTRYCODE = 'JPN';


SELECT
NAME
FROM CITY WHERE COUNTRYCODE = "JPN";


SELECT DISTINCT CITY 
FROM STATION 
WHERE ID%2=0 ORDER BY CITY ASC;       


SELECT CITY,LENGTH(CITY) 
FROM STATION 
ORDER BY LENGHT(CITY) ASC, 
CITY LIMIT 1; 


SELECT CITY,LENGTH(CITY) 
FROM STATION 
ORDER BY LENGHT(CITY) DESC, 
CITY LIMIT 1; 


SELECT 
DISTINCT CITY 
FROM STATION
WHERE LEFT(CITY, 1) IN ('a', 'e', 'i', 'o', 'u')


SELECT 
DISTINCT CITY 
FROM STATION
WHERE RIGHT(CITY, 1) IN ('a', 'e', 'i', 'o', 'u');


SELECT 
DISTINCT CITY 
FROM STATION
WHERE LEFT(CITY, 1) IN ('a', 'e', 'i', 'o', 'u')
AND RIGHT(CITY, 1) IN ('a', 'e', 'i', 'o', 'u');


SELECT 
DISTINCT CITY 
FROM STATION
WHERE LEFT(CITY, 1) NOT IN ('a', 'e', 'i', 'o', 'u');


SELECT 
DISTINCT CITY 
FROM STATION
WHERE RIGHT(CITY, 1) NOT IN ('a', 'e', 'i', 'o', 'u');


SELECT 
DISTINCT CITY 
FROM STATION
WHERE LEFT(CITY, 1) NOT IN ('a', 'e', 'i', 'o', 'u')
OR RIGHT(CITY, 1) NOT IN ('a', 'e', 'i', 'o', 'u');


SELECT 
DISTINCT CITY 
FROM STATION
WHERE LEFT(CITY, 1) NOT IN ('a', 'e', 'i', 'o', 'u')
AND RIGHT(CITY, 1) NOT IN ('a', 'e', 'i', 'o', 'u');


SELECT 
NAME
FROM 
EMPLOYEE
ORDER BY NAME ASC;


SELECT 
NAME 
FROM EMPLOYEE
WHERE SALARY > 2000
AND MONTHS < 10
ORDER BY EMPLOYEE_ID ASC;


SELECT NAME
FROM STUDENTS
WHERE MARKS > 75
ORDER BY SUBSTRING(name, len(name)-2, LEN(name)), id;


SELECT 
CITY.NAME
FROM CITY AS CITY
INNER JOIN COUNTRY AS COUNTRY
ON CITY.COUNTRYCODE = COUNTRY.CODE
WHERE COUNTRY.CONTINENT = 'Africa';


SELECT
COUNT(NAME) 
FROM CITY
WHERE POPULATION > 100000;


SELECT 
SUM(POPULATION)
FROM CITY
WHERE DISTRICT = 'California';


SELECT 
AVG(POPULATION)
FROM CITY
WHERE DISTRICT = 'California';


SELECT 
ROUND(AVG(POPULATION), 0)
FROM CITY;


SELECT
SUM(POPULATION)
FROM CITY 
WHERE COUNTRYCODE = 'JPN';


SELECT 
MAX(POPULATION) - MIN(POPULATION)
FROM CITY;


SELECT 
COUNTRY.CONTINENT,
ROUND(AVG(CITY.POPULATION),0)
FROM CITY AS CITY
INNER JOIN COUNTRY AS COUNTRY
ON CITY.COUNTRYCODE = COUNTRY.CODE
GROUP BY COUNTRY.CONTINENT;


SELECT 
COUNTRY.CITY,
SUM(CITY.POPULATION)
FROM CITY AS CITY
INNER JOIN COUNTRY AS COUNTRY
ON CITY.COUNTRYCODE = COUNTRY.CODE
WHERE CONTINENT = 'Asia'
GROUP BY COUNTRY.CITY;


SELECT 
SUM(CITY.POPULATION)
FROM CITY 
INNER JOIN COUNTRY
ON  CITY.COUNTRYCODE = COUNTRY.CODE
WHERE COUNTRY.CONTINENT = 'Asia';


SELECT 
CONCAT(NAME, '(', LEFT(OCCUPATION, 1), ')') 
FROM OCCUPATIONS
ORDER BY NAME;

SELECT
CONCAT('There are a total of ', ' ', COUNT(OCCUPATION), ' ', LOWER(OCCUPATION), 's', '.')
FROM OCCUPATIONS
GROUP BY OCCUPATION
ORDER BY COUNT(OCCUPATION) ASC, OCCUPATION ASC;


SELECT 
ROUND(SUM(LAT_N),  2) AS lat,
ROUND(SUM(LONG_W), 2) AS lon
FROM STATION;


SELECT 
ROUND(SUM(LAT_N),  2) AS lat,
ROUND(SUM(LONG_W), 2) AS lon
FROM STATION;


SELECT
ROUND(SUM(LAT_N), 4) 
FROM STATION
WHERE LAT_N BETWEEN 38.7880 AND 137.2345;


SELECT 
ROUND(MAX(LAT_N), 4)
FROM STATION
WHERE LAT_N < 137.2345;


SELECT ROUND(LONG_W,4)
FROM STATION
WHERE LAT_N = 
(SELECT MAX(LAT_N) FROM STATION WHERE LAT_N < 137.2345);


SELECT 
ROUND(MIN(LAT_N), 4)
FROM STATION
WHERE LAT_N > 38.7780;


SELECT
ROUND((LONG_W), 4)
FROM STATION
WHERE LAT_N = 
(SELECT MIN(LAT_N) FROM STATION WHERE LAT_N > 38.7780);


SELECT
ROUND(ABS(MAX(LAT_N) - MIN(LAT_N)) + ABS(MAX(LONG_W) - MIN(LONG_W)), 4) FROM STATION;


SELECT CASE
WHEN A + B <= C OR A + C <= B OR B + C <= A THEN 'Not A Triangle'
WHEN A = B AND B = C THEN 'Equilateral'
WHEN A = B OR B = C OR A = C THEN 'Isosceles'
ELSE 'Scalene'
END
FROM TRIANGLES; -- Não Consegui Resolver


SELECT TOP 1 
(MONTHS * SALARY), 
COUNT(*) 
FROM EMPLOYEE GROUP BY (MONTHS * SALARY) 
ORDER BY (MONTHS * salary) DESC;


select round(sqrt(power(max(LAT_N) - min(LAT_N), 2) + power(max(LONG_W) - min(LONG_W), 2)), 4) -- Não consegui Resolver
FROM STATION;


SELECT 
COUNT(CITY)- COUNT(DISTINCT CITY) 
FROM STATION


SELECT CEIL(AVG(SALARY) - AVG(REPLACE(SALARY, '0', ''))) --MySQL (Não consegui Resolver)
FROM EMPLOYEES;


select
    Doctor,
    Professor,
    Singer,
    Actor
from (
    select
        NameOrder,
        max(case Occupation when 'Doctor' then Name end) as Doctor,
        max(case Occupation when 'Professor' then Name end) as Professor,
        max(case Occupation when 'Singer' then Name end) as Singer,
        max(case Occupation when 'Actor' then Name end) as Actor
    from (
            select
                Occupation,
                Name,
                row_number() over(partition by Occupation order by Name ASC) as NameOrder
            from Occupations
         ) as NameLists
    group by NameOrder
    ) as Names 				-- Não consegui Resolver


CERTIFICATE BASIC - 

SELECT
ROLL_NUMBER,
NAME 
FROM 
STUDENT_INFORMATION AS STUDENT
INNER JOIN FACULTY_INFORMATION AS FACULTY 
ON STUDENT.ADVISOR = FACULTY.EMPLOYEE_ID
WHERE
(FACULTY.GENDER = 'M' AND FACULTY.SALARY > 15000)
OR (FACULTY.GENDER = 'F' AND FACULTY.SALARY > 20000) 


SELECT 
STUDENT.ROLL_NUMBER,
STUDENT.NAME
FROM STUDENT_INFORMATION AS STUDENT
INNER JOIN EXAMINATION_MARKS AS EXAM
ON STUDENT.ROLL_NUMBER = EXAM.ROLL_NUMBER
GROUP BY EXAM.ROLL_NUMBER
HAVING SUM(EXAM.SUBJECT_ONE + EXAM.SUBJECT_TWO + EXAM.SUBJECT_THREE) < 100