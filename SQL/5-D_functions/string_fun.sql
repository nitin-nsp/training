--  1 concat
select
    concat('nitin', 'singh');

select
    concat('1', '2');

select
    concat('nsp', '.nitinsingh', '@gmail.com') -- concat +
SELECT
    'nitin' + 'singh'
SELECT
    '1' + '2'
SELECT
    'nsp' + '.nitinsingh' + '@gmail.com' --CONCAT_WS
SELECT
    CONCAT_WS('.', 'nsp', 'nitinsingh', 'com');

--DATALENGTH
/* number of bytes  leading + trailing */
SELECT
    DATALENGTH('    nsp     ');

SELECT
    DATALENGTH('nsp     ');

SELECT
    DATALENGTH('   nsp');

--PATINDEX
SELECT
    PATINDEX('%i%', 'nitin');

SELECT
    PATINDEX('%[ti]%', 'nitin');

SELECT
    PATINDEX('%[^ti]%', 'nitin');

SELECT
    QUOTENAME('abcdef', '{}');

SELECT
    QUOTENAME('abcdef');

--defualt []
SELECT
    REPLACE('nitin tutale', 'Tut', 'M');

SELECT
    REPLICATE('nsp. ', 5);

SELECT
    REVERSE('nsp');

SELECT
    RIGHT('SQL Tutorial', 3) AS ExtractString;

-- space 
SELECT
    SPACE(10);

--str
SELECT
    STR(185.4);

--get round 
SELECT
    STR(185.4, 2);

-- re
SELECT
    STR(185.4, 5, 2);

SELECT
    STUFF('SQL Tutorial', 1, 5, 'HTM');

SELECT
    STUFF('SQL Tutorial', 1, 3, 'HTML');

--SUBSTRING(string, start, length)
SELECT
    SUBSTRING('SQL Tutorial', 1, 3) AS ExtractString;

SELECT
    SUBSTRING('SQL Tutorial', 1, 100) AS ExtractString;

--TRANSLATE(string, characters, translations)
SELECT
    TRANSLATE('3*[2+1]/{8-4}', '[]{}', '()()');

-- length should be equal 
--// Results in 3*(2+1)/(8-4)
-- TRIM([characters FROM ]string)
SELECT
    TRIM(
        '#!'
        FROM
            '    #SQL Tutorial!    '
    ) AS TrimmedString;

SELECT
    TRIM(
        '#! '
        FROM
            '    #SQL Tutorial!    '
    ) AS TrimmedString;