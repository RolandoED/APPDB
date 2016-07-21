--------------------------------------------------------
-- Archivo creado  - jueves-julio-14-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Procedure DATOS_EMP_PR
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "HR"."DATOS_EMP_PR" (P_ID NUMBER, 
                            P_NOMBRE OUT VARCHAR2,
                            P_SALARIO OUT NUMBER) IS
BEGIN
  SELECT FIRST_NAME || ' ' || LAST_NAME, SALARY
  INTO   P_NOMBRE, P_SALARIO
  FROM EMPLOYEES
  WHERE EMPLOYEE_ID = P_ID;
END;

/
