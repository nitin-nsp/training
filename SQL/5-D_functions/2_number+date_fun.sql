-- abs
SELECT Abs(-243.5) AS AbsNum;

--  avg
SELECT AVG(Price) AS AveragePrice FROM Products;


-- ceiling 
SELECT FLOOR(25.75) AS FloorValue;


-- DATEADD(interval, number, date)
SELECT DATEADD(ww, 4, '2017/08/25') AS DateAdd;
SELECT DATEADD(hh, 4, '2017/08/25') AS DateAdd;

-- DATEFROMPARTS(year, month, day)
SELECT DATENAME(year, '2017/08/25') AS DatePartString;


--cast CAST(expression AS datatype(length))
SELECT CAST(25.65 AS int);
SELECT CAST('2017-08-25' AS datetime);



-- COALESCE(val1, val2, ...., val_n) first not-null value
SELECT COALESCE(NULL, NULL, NULL, 'W3Schools.com', NULL, 'Example.com');


-- CONVERT(data_type(length), expression, style)
SELECT CONVERT(Real(16),1234.6789,2)