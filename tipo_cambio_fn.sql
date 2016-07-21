--------------------------------------------------------
-- Archivo creado  - jueves-julio-14-2016   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Function TIPO_CAMBIO_FN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "HR"."TIPO_CAMBIO_FN" 
(p_fecha date, p_tipo varchar2 DEFAULT 'V')
return number is
v_monto number(5,2);
begin
  select decode(upper(p_tipo),'V',venta,compra) 
  into v_monto
  from TIPOS_CAMBIO
  where TRUNC(fecha) = TRUNC(p_fecha);
  
  return v_monto;
end;

/
