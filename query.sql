--Select all products with brand Cacti Plus
SELECT *
FROM   product
WHERE  brand = 'Cacti Plus'

--Count of total products with product category=Skin Care
SELECT Count (*)
FROM   product
WHERE  category = 'Skin Care'

--Count of total products with MRP more than 100
SELECT Count (*)
FROM   product
WHERE  mrp > 100

--Count of total products with product category=Skin Care and MRP more than 100
SELECT Count (*)
FROM   product
WHERE  category = 'Skin Care'
       AND mrp > 100

--Brandwise product count
SELECT product.brand,
       Count (product.product_id)
FROM   product
GROUP  BY brand

--Brandwise as well as Active/Inactive Status wise product count
SELECT product.brand,
       Sum(CASE
             WHEN active = 'Y' THEN 1
             ELSE 0
           END) AS active,
       Sum(CASE
             WHEN active = 'N' THEN 1
             ELSE 0
           END) AS inactive,
       Count(*) AS totals
FROM   product
GROUP  BY brand

--Display all columns with Product category in Skin Care or Hair Care
SELECT *
FROM   product
WHERE  category = 'Skin Care'
        OR category = 'Hair Care'

--Display   all   columns   with   Product   category=Skin   Care   and Brand=Pondy, and MRP more than 100
SELECT *
FROM   product
WHERE  mrp > 100
       AND ( category = 'Skin Care'
             AND brand = 'Pondy' );

--Display   all   columns   with   Product   category   ="Skin   Care"   or Brand=Pondy, and MRP more than 100
SELECT *
FROM   product
WHERE  mrp > 100
       AND ( category = 'Skin Care'
              OR brand = 'Pondy' );

--Display all product names only with names starting from letter P
SELECT *
FROM   product
WHERE  product_name LIKE 'P%'

--Display  all product  names only with names Having letters Bar  in Between
SELECT *
FROM   product
WHERE  product_name LIKE '%Bar%'

SELECT *
FROM   sales

--Sales of those products which have been sold in more than two quantity in a bill
SELECT *
FROM   sales
WHERE  qty > 2

--Sales of those products which have been sold in more than two quantity throughout the bill
SELECT product_id,
       Sum(qty) quantity
FROM   sales
GROUP  BY product_id
HAVING Sum(qty) > 2

/*
Create a new table with columns username and birthday, and dump data from dates file. Convert it to .csv format if required.
After populating the data, find no of people sharing
Birth date
Birth month
Weekday
Find the current age of all people
*/


-- file path problem
BULK INSERT dbo.people
  FROM ''
  WITH
    (
      firstrow = 2,
      fieldterminator = ',',
      rowterminator = '\n'
    )
--no of people sharing Birth date
SELECT Count(NAME)
FROM   birthday
WHERE  birthdate IN (SELECT birthdate
                     FROM   birthday
                     GROUP  BY birthdate
                     HAVING Count(birthdate) > 1)

SELECT birthdate,
       Month(birthdate) birthmonth
FROM   birthday

SELECT Count(NAME),
       Datename(weekday, Getdate()) AS WEEKDAY
FROM   birthday

SELECT *,
       Datediff(year, birthdate, Getdate()) Age
FROM   birthday 