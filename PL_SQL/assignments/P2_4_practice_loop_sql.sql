

SET SERVEROUTPUT ON;
/*
print 1 to 10
*/
DECLARE 
v_start number:=1;
BEGIN 
LOOP 
DBMS_OUTPUT.PUT_LINE(V_START);
V_START:=V_START+1;
EXIT WHEN V_START>10;
end loop;
END;
/

/*
print 
*
**
*** 
****
*/

DECLARE
    V_I NUMBER := 1;
    V_J NUMBER := 0;
BEGIN
    WHILE V_I <= 4 LOOP
        WHILE V_J < V_I LOOP
            DBMS_OUTPUT.put('* ');
            V_J := V_J + 1;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
        V_I := V_I + 1;
        V_J := 0;
    END LOOP;
END;
/


/*
     *
    * * *
 * * * * *
*/
DECLARE 
V_I NUMBER:=0;
V_J NUMBER:=0;
BEGIN 

FOR I IN 0..3 LOOP

 V_J:=3-I;
 FOR J IN 0..V_J LOOP
   DBMS_OUTPUT.PUT(' ');
 END LOOP;
 
  V_J:=2*(I)+1;
  FOR J IN 1..V_J LOOP
    DBMS_OUTPUT.PUT('*');
  END LOOP;
  
  DBMS_OUTPUT.PUT_LINE('');
END LOOP;

END;
/



BEGIN 

<<OUTER_LOOP>>
 FOR I IN 1..5 LOOP
   <<INNER_LOOP>>
   FOR J IN 1..5 LOOP
    
    IF MOD(I,2)=0 AND MOD(J,2)=0 THEN
     DBMS_OUTPUT.PUT_LINE('both are even '||I||J);
     exit  ;
    END IF;
    END LOOP INNER_LOOP;
    
 END LOOP outer_loop;


END;
/






