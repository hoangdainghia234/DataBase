-- 1.Type of Triangle
        SELECT 
        CASE 
        WHEN A + B <= C OR A + C <= B OR B + C <= A THEN 'Not A Triangle'
                WHEN A = B AND B = C THEN 'Equilateral'
                WHEN A = B OR B = C OR A = C THEN 'Isosceles'
                ELSE 'Scalene'
        END
        FROM TRIANGLES

-- 2.The PADS
        SELECT (name || '(' || SUBSTR(occupation,1,1) || ')') FROM occupations ORDER BY name;
-- 3.Occupations
        SELECT ('There are a total of ' || COUNT(occupation) || ' ' || LOWER(occupation) || 's' || '.') FROM occupations GROUP BY occupation ORDER BY COUNT(occupation), occupation ASC;
-- 4.Revising Aggregations - The Sum Function
        SELECT SUM(POPULATION) FROM CITY WHERE DISTRICT = "California";
-- 5.Revising Aggregations - The Count Function
        SELECT COUNT(POPULATION) FROM CITY WHERE POPULATION > 100000;
-- 6.Revising Aggregations - Averages
        SELECT AVG (population ) FROM CITY WHERE District = 'California';
-- 7.Average Population
        SELECT ROUND( AVG(population), 0 ) FROM CITY;
-- 8.Japan Population
        SELECT SUM(POPULATION) FROM CITY WHERE COUNTRYCODE='JPN';
-- 9.Population Density Difference
        SELECT MAX(POPULATION) - MIN(POPULATION) FROM CITY 

-- 10.The Blunder
        SELECT CEIL(AVG (Salary) -AVG(REPLACE(Salary,'0','')) )FROM EMPLOYEES 
-- 11.Weather Observation Station 2
        SELECT 
                ROUND(SUM(LAT_N), 2), 
                ROUND(SUM(LONG_W), 2)
        FROM 
                STATION;
-- 12.Weather Observation Station 13
        SELECT ROUND(SUM(LAT_N), 4) FROM STATION WHERE LAT_N BETWEEN 38.7880 and 137.2345 
-- 13.Weather Observation Station 14
        SELECT TRUNCATE(MAX(LAT_N), 4) FROM STATION WHERE LAT_N < 137.2345
-- 14.Weather Observation Station 16
        SELECT ROUND(MIN(LAT_N), 4) FROM STATION WHERE LAT_N > 38.7780;
-- 15.Weather Observation Station 18.
        SELECT ROUND(ABS(MIN(LAT_N) - MAX(LAT_N)) + ABS(MAX(LONG_W) - MIN(LONG_W)),4) FROM STATION
-- 16.Weather Observation Station 19
        SELECT ROUND(SQRT(POW(MAX(LAT_N)-MIN(LAT_N),2) + POW(MAX(LONG_W)-MIN(LONG_W),2)), 4) FROM station;
        
-- 17.Top Competitors
        SELECT h.hacker_id , h.name
        FROM submissions s
                INNER JOIN hackers h on h.hacker_id = s.hacker_id
                INNER JOIN challenges c on c.challenge_id = s.challenge_id
                INNER JOIN difficulty d on d.difficulty_level = c.difficulty_level

        WHERE s.score = d.score AND c.difficulty_level = d.difficulty_level
                           
        GROUP BY h.hacker_id ,h.name
        HAVING COUNT(s.submission_id) > 1
        ORDER BY COUNT(s.submission_id) DESC, h.hacker_id ASC
-- 18.Placements
        select temp1.sn
        from (select S.ID si,S.Name sn,P.Salary ps from Students S join Packages P on S.ID=P.ID) temp1 join (select FF.ID fi,FF.Friend_ID fd,PP.Salary pps from Friends FF join Packages PP on FF.Friend_ID=pp.ID) temp2 on temp1.si=temp2.fi and temp1.ps<temp2.pps
        order by temp2.pps asc;