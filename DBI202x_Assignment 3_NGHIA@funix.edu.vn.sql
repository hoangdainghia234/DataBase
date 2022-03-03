1.-- Weather Observation Station 5
      SELECT * FROM (SELECT DISTINCT city, LENGTH(city) FROM station ORDER BY LENGTH(city) ASC, city ASC) WHERE ROWNUM = 1   
      UNION  
      SELECT * FROM (SELECT DISTINCT city, LENGTH(city) FROM station ORDER BY LENGTH(city) DESC, city ASC) WHERE ROWNUM = 1;  

-- 2.Binary Tree Nodes
      SELECT CASE
        WHEN P IS NULL THEN CONCAT(N, ' Root')
        WHEN N IN (SELECT DISTINCT P FROM BST) THEN CONCAT(N, ' Inner')
        ELSE CONCAT(N, ' Leaf')
        END
      FROM BST
      ORDER BY N ASC

-- 3.New Companies
    SELECT c.Company_Code, c.founder, count(Distinct e.Lead_Manager_Code), 
    count(distinct e.Senior_Manager_Code), count(distinct e.Manager_Code), 
    count(distinct e.employee_Code) FROM Company c 
    JOIN Employee e ON c.Company_Code = e.Company_Code GROUP BY c.Company_Code, c.Founder ORDER BY c.COMpany_Code;

-- 4.Top Earners
    SELECT * FROM (SELECT  months*salary, COUNT(*) FROM employee GROUP BY months*salary ORDER BY months*salary DESC) WHERE ROWNUM = 1;

-- 5.Weather Observation Station 15
    SELECT ROUND(LONG_W,4)
    FROM STATION
    WHERE LAT_N = (SELECT MAX(LAT_N) FROM STATION WHERE LAT_N < 137.2345);
-- 6.Weather Observation Station 17
    SELECT ROUND(LONG_W, 4) FROM STATION WHERE LAT_N = (SELECT  MIN(LAT_N) FROM STATION WHERE LAT_N> 38.7780);
-- 7.Weather Observation Station 20
    SELECT ROUND(MEDIAN(lat_n), 4) FROM STATION;

-- 8.Population Census
    SELECT SUM(City.population)
    FROM Country
    INNER JOIN City
        ON Country.Code = City.CountryCode
    WHERE Country.Continent='Asia';

-- 9.African Cities
    SELECT City.Name 
    FROM City, Country 
    WHERE City.CountryCode = Country.Code AND Continent = 'Africa' ;

-- 10.Average Population of Each Continent
    SELECT Country.Continent, FLOOR(AVG(City.Population))
    FROM Country, City 
    WHERE Country.Code = City.CountryCode 
    GROUP BY Country.Continent ;

-- 11.The Report
    SELECT 
    CASE WHEN grd.grade < 8 THEN NULL 
    WHEN grd.grade >= 8 THEN std.name END,
    grd.grade, std.marks FROM students std, grades grd
    WHERE std.marks BETWEEN grd.min_mark AND grd.max_mark
    ORDER BY grd.grade DESC, std.name ASC;

-- 12.Ollivander's Inventory
    SELECT aa.id, bb.age, aa.coins_needed, aa.power
    FROM WANDS AS aa
    JOIN WANDS_PROPERTY AS bb ON aa.CODE = bb.CODE
    JOIN (SELECT age AS AG, MIN(coins_needed) AS MCN, power AS PW
    FROM WANDS AS A
    JOIN WANDS_PROPERTY AS B ON A.CODE = B.CODE
    WHERE IS_EVIL = 0
    GROUP BY power, age) AS Q ON bb.age = AG AND aa.coins_needed = MCN AND aa.power = PW
    ORDER BY aa.power DESC, bb.age DESC

-- 13.Challenges
      SELECT
          h.hacker_id, h.name,
          COUNT(h.hacker_id) AS challenges_created
      FROM 
          Hackers h INNER JOIN Challenges c ON h.hacker_id = c.hacker_id
      GROUP BY
          h.hacker_id, h.name
      HAVING
          challenges_created = (SELECT MAX(t1.cnts)
                              FROM (SELECT COUNT(*) as cnts
                                    FROM Challenges
                                    GROUP BY hacker_id) t1)
          OR
          challenges_created IN (SELECT t.cnts
                                FROM (SELECT COUNT(*) AS cnts
                                      FROM Challenges
                                      GROUP BY hacker_id) t
                                GROUP BY t.cnts
                                HAVING COUNT(t.cnts) = 1)
      ORDER BY
          challenges_created DESC,
          h.hacker_id

-- 14.Contest Leaderboard
        SELECT H.hacker_id, H.name, SUM(M.max_score) AS total_score
        FROM (
            SELECT S.hacker_id, S.challenge_id, max(S.score) as max_score
            FROM Submissions S GROUP BY S.hacker_id, S.challenge_id
            ) M
        JOIN Hackers H ON H.hacker_id = M.hacker_id
        GROUP BY H.hacker_id, H.name
        HAVING total_score > 0
        ORDER BY total_score DESC, H.hacker_id ASC;


-- 15.SQL Project Planning
        SELECT START_DATE, MIN(END_DATE)
        FROM
          (SELECT START_DATE
          FROM PROJECTS
          WHERE START_DATE NOT IN
              (SELECT END_DATE
                FROM PROJECTS)) A,
          (SELECT END_DATE
          FROM PROJECTS
          WHERE END_DATE NOT IN
              (SELECT START_DATE
                FROM PROJECTS)) B
        WHERE START_DATE < END_DATE
        GROUP BY START_DATE
        ORDER BY (MIN(END_DATE) - START_DATE), START_DATE;

-- 16.Symmetric Pairs
      SELECT X, Y FROM (
      SELECT X, Y FROM Functions WHERE X=Y GROUP BY X, Y HAVING COUNT(*)=2
      UNION
      SELECT f1.X, f1.Y FROM Functions f1, Functions f2 
      WHERE f1.X < f1.Y 
      AND f1.X=f2.Y 
      AND f2.X=f1.Y
      )t
      ORDER BY X, Y;

-- 17.Interviews
      SELECT CON.CONTEST_ID,
            CON.HACKER_ID,
            CON.NAME,
            SUM(TOTAL_SUBMISSIONS),
            SUM(TOTAL_ACCEPTED_SUBMISSIONS),
            SUM(TOTAL_VIEWS),
            SUM(TOTAL_UNIQUE_VIEWS)
      FROM CONTESTS CON
      JOIN COLLEGES COL ON CON.CONTEST_ID = COL.CONTEST_ID
      JOIN CHALLENGES CHA ON COL.COLLEGE_ID = CHA.COLLEGE_ID
      LEFT JOIN
        (SELECT CHALLENGE_ID,
                SUM(TOTAL_VIEWS) AS TOTAL_VIEWS,
                SUM(TOTAL_UNIQUE_VIEWS) AS TOTAL_UNIQUE_VIEWS
        FROM VIEW_STATS
        GROUP BY CHALLENGE_ID) VS ON CHA.CHALLENGE_ID = VS.CHALLENGE_ID
      LEFT JOIN
        (SELECT CHALLENGE_ID,
                SUM(TOTAL_SUBMISSIONS) AS TOTAL_SUBMISSIONS,
                SUM(TOTAL_ACCEPTED_SUBMISSIONS) AS TOTAL_ACCEPTED_SUBMISSIONS
        FROM SUBMISSION_STATS
        GROUP BY CHALLENGE_ID) SS ON CHA.CHALLENGE_ID = SS.CHALLENGE_ID
      GROUP BY CON.CONTEST_ID,
              CON.HACKER_ID,
              CON.NAME
      HAVING SUM(TOTAL_SUBMISSIONS) != 0
      OR SUM(TOTAL_ACCEPTED_SUBMISSIONS) != 0
      OR SUM(TOTAL_VIEWS) != 0
      OR SUM(TOTAL_UNIQUE_VIEWS) != 0
      ORDER BY CONTEST_ID;


-- 18.Days of Learning SQL
      SELECT t1.submission_date, hkr_cnt, t2.hacker_id, name
      FROM (SELECT p1.submission_date, 
                  COUNT(DISTINCT p1.hacker_id) AS hkr_cnt
            FROM (SELECT submission_date, hacker_id, 
                        @h_rnk := CASE WHEN @h_grp != hacker_id THEN 1 ELSE @h_rnk+1 END AS hacker_rank,
                        @h_grp := hacker_id AS hacker_group
                  FROM (SELECT DISTINCT submission_date, hacker_id 
                        FROM submissions
                        ORDER BY hacker_id, submission_date) AS a, 
                      (SELECT @h_rnk := 1, @h_grp := 0) AS r) AS p1
            JOIN (SELECT submission_date, 
                        @d_rnk := @d_rnk + 1 AS date_rank
                  FROM (SELECT DISTINCT submission_date
                        FROM submissions 
                        ORDER BY submission_date) AS b, 
                      (SELECT @d_rnk := 0) r) AS p2
            ON p1.submission_date = p2.submission_date 
              AND hacker_rank = date_rank
            GROUP BY p1.submission_Date) AS t1
      JOIN (SELECT submission_date, hacker_id, sub_cnt,
                  @s_rnk := CASE WHEN @d_grp != submission_date THEN 1 ELSE @s_rnk+1 END AS max_rnk,
                  @d_grp := submission_date AS date_group
            FROM (SELECT submission_date, hacker_id, COUNT(*) AS sub_cnt
                  FROM submissions AS s
                  GROUP BY submission_date, hacker_id
                  ORDER BY submission_date, sub_cnt DESC, hacker_id) AS c,
                (SELECT @s_rnk := 1, @d_grp := 0) AS r) AS t2                            
      ON t1.submission_date = t2.submission_date AND max_rnk = 1
      JOIN hackers AS h ON h.hacker_id = t2.hacker_id            
      ORDER BY t1.submission_date