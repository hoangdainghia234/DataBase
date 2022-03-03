-- PHẦN TRUY VẤN - LẤY DỮ LIỆU RA
-- 1.Revising the Select Query I:HIỂN THỊ TẤT CẢ CITY CÓ population lớn hơn 100000 và CountryCode là USA
    SELECT * FROM CITY WHERE population > 100000 AND CountryCode = "USA",
-- 2.Revising the Select Query II: HIỂN THỊ TẤT CẢ NAME CÁC CITY có population > 120000 and Countrycode = "USA"
	SELECT NAME FROM CITY WHERE population > 120000 AND CountryCode = "USA"
-- 3.Query all columns (attributes) for every row in the CITY table. Hiển thị tất table CITY
	SELECT * FROM CITY
-- 4.Select By ID.hIỂN THỊ CITY CÓ ID = 1661
	SELECT *  FROM CITY WHERE ID = "1661"
-- 5.Japanese Cities' Attributes.HIỂN THỊ CÁC CITY có countrycode = "JPA"
	SELECT * FROM CITY WHERE COUNTRYCODE = "JPN"
-- 6.Japanese Cities' Names.HIỂN THỊ NAME CITY CÓ countrycode = "JPA"
	SELECT NAME FROM CITY Where COUNTRYCODE = "JPN"
-- 7.Weather Observation Station 1:HIỂN THỊ DANH SÁCH CITY AND STATE của table STATION
	SELECT CITY, STATE FROM STATION 
-- 8.Weather Observation Station 3: HIỂN THỊ DANH SÁCH CÁC CITY CÓ ID CÓ SỐ CHẴN.Danh sách phải đc sắp xếp theo thứ tự chữ cái
	SELECT DISTINCT CITY FROM STATION WHERE MOD(ID,2)=0 ORDER BY CITY ASC; 
-- 8.Weather Observation Station 4: Tìm sự khác biệt giữa tổng số mục nhập CITY trong bảng và số mục nhập CITY riêng biệt trong bảng.
	SELECT COUNT(CITY) - COUNT(DISTINCT CITY)  FROM STATION
-- 9.Weather Observation Station 6: HIỂN THỊ DANH SÁCH NAME riêng biệt của CITY trong table STATION bắt đầu bằng chữ a, e, i, o or u.Kết quả ko đc trùng lặp.
	SELECT DISTINCT(CITY) FROM STATION WHERE CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' 
    OR CITY LIKE 'U%' ORDER BY CITY ASC; 
-- 10.Weather Observation Station 7
	SELECT DISTINCT (CITY) FROM STATION WHERE CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i'OR CITY LIKE '%o' OR CITY LIKE '%u';
-- 11.Weather Observation Station 8
	SELECT DISTINCT CITY FROM STATION WHERE (CITY LIKE 'A%' OR CITY LIKE 'E%' OR CITY LIKE 'I%' OR CITY LIKE 'O%' OR CITY LIKE 'U%') AND (CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u' OR CITY LIKE '%u') order by city
-- 12.Weather Observation Station 9.HIỂN THỊ NAME CITY TỪ TABLE STATION không bắt đầu = nguyên âm
   SELECT DISTINCT CITY FROM STATION WHERE UPPER(SUBSTR(CITY,1,1)) NOT IN ('A','E','I','O','U') AND LOWER(SUBSTR(CITY,1,1)) NOT IN('a','e','i','o','u');
-- 13.Weather Observation Station 10.HIỂN THỊ NAME CITY TỪ TABLE STATION không kết thúc = nguyên âm.
    SELECT DISTINCT CITY FROM STATION WHERE UPPER(SUBSTR(CITY, LENGTH(CITY), 1)) NOT IN ('A','E','I','O','U') AND LOWER(SUBSTR(CITY, LENGTH(CITY),1)) NOT IN ('a','e','i','o','u');  
-- 14.Weather Observation Station 11.Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates
	SELECT DISTINCT CITY FROM STATION WHERE LOWER(SUBSTR(CITY,1,1)) NOT IN ('a','e','i','o','u') OR LOWER(SUBSTR(CITY, LENGTH(CITY),1)) NOT IN ('a','e','i','o','u');   
-- 15.Weather Observation Station 12:HIỂN THỊ TÊN riêng của các CITY từ bảng STATION không được bắt đầu và kết thúc bằng nguyên âm (u, e, o, a, i).	
	SELECT DISTINCT CITY FROM STATION WHERE LOWER(SUBSTR(CITY,1,1)) NOT IN ('a','e','i','o','u') AND LOWER(SUBSTR(CITY,LENGTH(CITY),1)) NOT IN ('a','e','i','o','u');    
-- 16.Higher Than 75 Marks.
	SELECT NAME FROM STUDENTS WHERE Marks > 75 ORDER BY SUBSTR(NAME, LENGTH(NAME)-2, 3), ID;
-- 17.Employee Names
	SELECT NAME FROM Employee ORDER BY NAME;
-- 18.Employee Salaries
	SELECT NAME FROM Employee WHERE salary > 2000 AND MONTHS < 10 ORDER BY EMPLOYEE_ID;  