/* Data Exploration of Mass shootings in USA from 2018 to 2022

Skills Used: Joins, Aggregate Functions, Creating Views, Altering Tables

*/

ALTER TABLE project.shootings_2018
ADD Year int NOT NULL DEFAULT 2018;
SELECT * FROM project.shootings_2018;

ALTER TABLE project.shootings_2019
ADD Year int NOT NULL DEFAULT 2019;
SELECT * FROM project.shootings_2019;

ALTER TABLE project.shootings_2020
ADD Year int NOT NULL DEFAULT 2020;
SELECT * FROM project.shootings_2020;

ALTER TABLE project.shootings_2021
ADD Year int NOT NULL DEFAULT 2021;
SELECT * FROM project.shootings_2021;

ALTER TABLE project.shootings_2022
ADD Year int NOT NULL DEFAULT 2022;
SELECT * FROM project.shootings_2022;

-- Creating view to store data for later use
-- Combining all tables
CREATE VIEW project.all_shootings AS
select * from project.shootings_2018
union all
select * from project.shootings_2019
union all
select * from project.shootings_2020
union all
select * from project.shootings_2021
union all
select * from project.shootings_2022
order by date asc;

-- Total shootings by each state 
SELECT State, sum(Total)
FROM project.all_shootings
GROUP BY state
ORDER BY sum(Total) DESC;
-- The state which have highest number of shootings overall is Illinois, california, texas,florida, louisiana etc;

-- Total shootings by month
SELECT MONTHNAME(`DATE`) AS `MonthName`,  sum(total)
FROM project.all_shootings
GROUP BY monthname
ORDER BY sum(Total) DESC;
-- Highest number of deaths occured in June, july, aug, may, oct etc; in the following order respectively

-- Total shootings by year
SELECT year,  sum(total)
FROM project.all_shootings
GROUP BY year
ORDER BY sum(Total) DESC;
-- more number of shootings were occured in 2021, 2020, 2019, 2018, 2022. We could see a gradual increase in the number of shootings.

-- Shootings by day of the week
SELECT dayofweek(`DATE`) AS `dayofweek`,  sum(total)
FROM project.all_shootings
GROUP BY dayofweek
ORDER BY sum(Total) DESC;
-- Maximum number of shootings happened on sun, sat,fri,mon etc in the following order respectively

-- Shows the percentage of people died in each year by total number of cases.
SELECT year, (sum(dead)/sum(total))*100 as deathpercentage
FROM project.all_shootings
GROUP BY year
ORDER BY deathpercentage DESC;

-- Number of people died on average in a month
SELECT MONTHNAME(`DATE`) AS `MonthName`,  avg(dead), avg(injured)
FROM project.all_shootings
GROUP BY monthname
ORDER BY avg(dead) DESC;
