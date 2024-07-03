CREATE TABLE YearlyIncrement (
    employee_id NUMBER PRIMARY KEY,
    year1 NUMBER,
    year2 NUMBER,
    year3 NUMBER,
    year4 NUMBER
);

BEGIN FOR i IN 100..150 LOOP
INSERT INTO
    YearlyIncrement (employee_id, year1, year2, year3, year4)
VALUES
    (
        i,
        ROUND(DBMS_RANDOM.VALUE(500, 1000)),
        ROUND(DBMS_RANDOM.VALUE(1000, 2000)),
        ROUND(DBMS_RANDOM.VALUE(1000, 2500)),
        ROUND(DBMS_RANDOM.VALUE(1000, 3000))
    );

END LOOP;

COMMIT;

END;