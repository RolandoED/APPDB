--------------------------------------------------------
-- Archivo creado  - jueves-julio-14-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Function NOMBRE_EMPLEADO_FN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "HR"."NOMBRE_EMPLEADO_FN" (p_id number) RETURN varchar2 is
  v_nombre varchar2(50);
begin 
  Select first_name||' '||last_name into v_nombre
  From   employees
  Where  EMPLOYEE_ID = p_id;
  
  return initcap(v_nombre);
  exception
      when no_data_found then
          return 'No existe ese empleado';
end;

/
