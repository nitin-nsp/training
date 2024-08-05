--1. Create a PL/SQL program that declares a nested table of integers, populates it with values (e.g., 10, 20, 30), and then displays the elements of the nested table.
 declare 
 type Int_table is table of Integer;
 v_number Int_table;
 
 begin 
 v_number:=Int_table();
 v_number.EXTEND(3);
 v_numbers(1) := 10;
  v_numbers(2) := 20;
  v_numbers(3) := 30;
  
  FOR i IN 1 .. v_numbers.COUNT LOOP
    dbms_output.put_line('number ' || i || ': ' || v_numbers(i));
  END LOOP;
 end;
--2. Create a PL/SQL program that declares a varray of characters with a fixed size of 5. 
--Implement a loop to take input from the user for all five elements of the varray and then display the contents of the varray.

declare 
type charVArray is varray(5) of varchar2(1);
v_chars charVArray;
v_in char(1);
begin 
v_chars:=charVArray();

for i in 1.. v_chars.limit loop

v_in:=chr(64+i);
v_chars(i):=v_in;
 dbms_output.put(' at pos  ' || i || ': '|| v_chars(i));

end loop;
end;

--3. Create a PL/SQL program that declares an associative array (index-by table) of student names and their respective scores in a test. 
--Populate the array with at least five records and then display the student names along with their scores.
set serverout on ;

DECLARE
  TYPE StudentScores IS TABLE OF NUMBER INDEX BY VARCHAR2(50);
  stu_scores STUDENTSCORES;
  counter VARCHAR2(50);
BEGIN

  STU_SCORES('nitin') := 85;
  stu_scores('singh') := 92;


  COUNTER:=STU_SCORES.FIRST;
  WHILE COUNTER IS NOT NULL LOOP
  DBMS_OUTPUT.PUT_LINE('couter => '|| COUNTER ||' ' || STU_SCORES(COUNTER) );
  counter:=stu_scores.next(counter);
  END LOOP;
  

END;
/

DECLARE
 
  TYPE StudentRecord IS RECORD (
    NAME VARCHAR2(50),
    SCORE NUMBER
  );
  
 
  TYPE StudentScores IS TABLE OF StudentRecord INDEX BY BINARY_INTEGER;
  
 
  STU_SCORES STUDENTSCORES := STUDENTSCORES(
    1 => StudentRecord('nitin', 45),
    2 => StudentRecord('singh', 92)
  );
BEGIN
  
  FOR i IN 1 .. stu_scores.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Student ' || i || ': ' || stu_scores(i).NAME || ' - Score: ' || stu_scores(i).SCORE);
  END LOOP;
END;
/

set serveroutput on;
DECLARE

  TYPE StudentRecord IS RECORD (
    NAME VARCHAR2(50),
    SCORE NUMBER
  );
  

  TYPE StudentScores IS TABLE OF StudentRecord INDEX BY BINARY_INTEGER;
  

  stu_scores StudentScores;
BEGIN

  stu_scores(1).NAME := 'John';
  stu_scores(1).SCORE := 45;
  
  stu_scores(2).NAME := 'Alice';
  stu_scores(2).SCORE := 92;
  

  FOR i IN 1 .. stu_scores.COUNT LOOP
    DBMS_OUTPUT.PUT_LINE('Student ' || i || ': ' || stu_scores(i).NAME || ' - Score: ' || stu_scores(i).SCORE);
  END LOOP;
END;
/


--4. Write a PL/SQL program that uses an associative array of question 3. Calculate the average of all the values of the scores in the array.


--5. Create a PL/SQL program that declares a nested table of timestamps. 
--Implement a loop to populate the collection with timestamps representing different dates and times, 
--AND THEN DISPLAY THE TIMESTAMPS IN CHRONOLOGICAL ORDER.
DECLARE
 
  TYPE TimestampTable IS TABLE OF TIMESTAMP;

 
  v_timestamps TimestampTable;

BEGIN
  
  v_timestamps := TimestampTable();

 
  v_timestamps.EXTEND(5);
  v_timestamps(1) := TIMESTAMP '2024-07-30 10:30:00';
  v_timestamps(2) := TIMESTAMP '2024-07-29 08:15:00';
  v_timestamps(3) := TIMESTAMP '2024-07-31 12:45:00';
  v_timestamps(4) := TIMESTAMP '2024-07-30 09:00:00';
  v_timestamps(5) := TIMESTAMP '2024-07-30 14:20:00';

  
  CREATE GLOBAL TEMPORARY TABLE temp_timestamps (
    ts TIMESTAMP
  ) ON COMMIT DELETE ROWS;

 
  FOR i IN 1 .. v_timestamps.COUNT LOOP
    INSERT INTO temp_timestamps (ts) VALUES (v_timestamps(i));
  END LOOP;

  
  FOR rec IN (SELECT ts FROM temp_timestamps ORDER BY ts) LOOP
    dbms_output.put_line('Timestamp: ' || rec.ts);
  END LOOP;

 
  EXECUTE IMMEDIATE 'DROP TABLE temp_timestamps';

EXCEPTION
  WHEN OTHERS THEN
    dbms_output.put_line('Error: ' || SQLERRM);
   
    BEGIN
      EXECUTE IMMEDIATE 'DROP TABLE temp_timestamps';
    EXCEPTION
      WHEN OTHERS THEN
        NULL; 
    END;
END;
/

--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--
--/* docs by oracle */
--
--
--/*
--
--DECLARE
--   TYPE NumList IS TABLE OF NUMBER;
--   n NumList := NumList(1,3,5,7);
--   counter INTEGER;
--BEGIN
--   dbms_output.put_line('N''s first subscript is ' || n.FIRST);
--   dbms_output.put_line('N''s last subscript is ' || n.LAST);
--
---- When the subscripts are consecutive starting at 1, it's simple to loop through them.
--   FOR i IN n.FIRST .. n.LAST
--   LOOP
--      dbms_output.put_line('Element #' || i || ' = ' || n(i));
--   END LOOP;
--
--   n.DELETE(2); -- Delete second element.
---- When the subscripts have gaps or the collection might be uninitialized,
---- the loop logic is more extensive. We start at the first element, and
---- keep looking for the next element until there are no more.
--   IF n IS NOT NULL THEN
--      counter := n.FIRST;
--      WHILE counter IS NOT NULL
--      LOOP
--         dbms_output.put_line('Element #' || counter || ' = ' || n(counter));
--         counter := n.NEXT(counter);
--      END LOOP;
--   ELSE
--      dbms_output.put_line('N is null, nothing to do.');
--   END IF;
--END;
--/
--
--
--
--
--
--
--
--
--set serveroutput on;
--
--
--DECLARE
--   TYPE NumList IS TABLE OF NUMBER;
--   n NumList := NumList(1966,1971,1984,1989,1999);
--BEGIN
--   dbms_output.put_line('The element after #2 is #' || n.NEXT(2));
--   dbms_output.put_line('The element before #2 is #' || n.PRIOR(2));
--   n.DELETE(3); -- Delete an element to show how NEXT can handle gaps.
--   dbms_output.put_line('Now the element after #2 is #' || n.NEXT(2));
--   IF n.PRIOR(n.FIRST) IS NULL THEN
--      dbms_output.put_line('Can''t get PRIOR of the first element or NEXT of the last.');
--   END IF;
--END;
--/
----You can use PRIOR or NEXT to traverse collections indexed by any series of subscripts.
----The following example uses NEXT to traverse a nested table from which some elements have been deleted:
--
--DECLARE
--   TYPE NumList IS TABLE OF NUMBER;
--   n NumList := NumList(1,3,5,7);
--   counter INTEGER;
--BEGIN
--   n.DELETE(2); -- Delete second element.
---- When the subscripts have gaps, the loop logic is more extensive. We start at the
---- first element, and keep looking for the next element until there are no more.
--   counter := n.FIRST;
--   WHILE counter IS NOT NULL
--   LOOP
--      dbms_output.put_line('Counting up: Element #' || counter || ' = ' || n(counter));
--      counter := n.NEXT(counter);
--   END LOOP;
--
---- Run the same loop in reverse order.
--   counter := n.LAST;
--   WHILE counter IS NOT NULL
--   LOOP
--      dbms_output.put_line('Counting down: Element #' || counter || ' = ' || n(counter));
--      counter := n.PRIOR(counter);
--   END LOOP;
--END;
--/
--
--
--
--
--DECLARE
--   TYPE NumList IS TABLE OF NUMBER;
--   n NumList := NumList(1,2,3,5,7,11);
--   PROCEDURE print_numlist(the_list NumList) IS
--      output VARCHAR2(128);
--   BEGIN
--      IF n.COUNT = 0 THEN
--         dbms_output.put_line('No elements in collection.');
--      ELSE
--         FOR i IN the_list.FIRST .. the_list.LAST
--         LOOP
--            output := output || NVL(TO_CHAR(the_list(i)),'NULL') || ' ';
--         END LOOP;
--         dbms_output.put_line(output);
--      END IF;
--   END;
--BEGIN
--   print_numlist(n);
--   n.TRIM(2); -- Remove last 2 elements.
--   print_numlist(n);
--   n.TRIM; -- Remove last element.
--   print_numlist(n);
--   n.TRIM(n.COUNT); -- Remove all remaining elements.
--   print_numlist(n);
--
---- If too many elements are specified, TRIM raises the exception SUBSCRIPT_BEYOND_COUNT.
--   BEGIN
--      n := NumList(1,2,3);
--      n.TRIM(100);
--      EXCEPTION
--         WHEN SUBSCRIPT_BEYOND_COUNT THEN
--            dbms_output.put_line('I guess there weren''t 100 elements that could be trimmed.');
--   END;
--
---- When elements are removed by DELETE, placeholders are left behind. TRIM counts these
---- placeholders as it removes elements from the end.
--
--   n := NumList(1,2,3,4);
--   n.DELETE(3);  -- delete element 3
---- At this point, n contains elements (1,2,4).
---- TRIMming the last 2 elements removes the 4 and the placeholder, not 4 and 2.
--   n.TRIM(2);
--   print_numlist(n);
--END;
--/
--END;
--/
--
--*/