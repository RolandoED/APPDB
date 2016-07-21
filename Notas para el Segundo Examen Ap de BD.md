Bloque Anonimo no esta asociado a un elemento de la BD

Los Resultados de una Funcion **se asignan a variables**

Los Resultados de un Procedimiento **NO se asignas a variables**

###Ejemplo de Funcion

	create or replace FUNCTION
	TIPO_CAMBIO_FN(p_date date, p_tipo varchar2 DEFAULT 'V') RETURN number is
	v_monto number(5,2);
	BEGIN
	  select decode(upper(p_tipo), 'V', venta, compra)
	  into v_monto
	  from TIPOS_CAMBIOS 
	  where TRUNC(fecha) = TRUNC(p_date);
	  return v_monto;
	END TIPO_CAMBIO_FN;

###Como Ejecutarlo
	
	declare
	  x number;
	begin
	  x := TIPO_CAMBIO_FN(sysdate,'V');
	  DBMS_OUTPUT.PUT_LINE(x);
	end;
	
---

forms ejecucion

	:SALIDAVER := TOTAL_PORDEPT_FN(90);

---

	select TIPO_CAMBIO_FN(SYSDATE, 'V') from DUAL;
	
	INSERT INTO TIPOS_CAMBIOS VALUES(SYSDATE, 522,522);

---
	
	SET SERVEROUTPUT ON
	
	EXEC DBMS_OUTPUT.PUT_LINE(TIPO_CAMBIO_FN(SYSDATE, 'V'));



	EXEC ADD_BITACORA('FORM1');
	EXECUTE dbms_aw.execute(BITACORA_LOGIN());
	SELECT * FROM BITACORA_LOGIN;

---
EJEMPLO SCRIPT

	select d.dname, avg(e.sal)
	from emp e , dept d
	where e.deptno = d.deptno
	group by d.dname
	HAVING COUNT(*) > 3
	/


---


	select e.ename, e.job, e.sal ,
	LPAD(DECODE (e.JOB,
	'MANAGER',SAL*1.05,
	'SALESMAN',SAL*1.10,
	'CLERK',SAL*1.15,SAL*1.025) ,10,'$')
	NEW_SAL,
	ROUND(MONTHS_BETWEEN(SYSDATE, HIREDATE)/12) "ANNOS"
	from emp e
	WHERE JOB != 'ANALYST'
	/

---

	select count(Employee_id) , department_id
	from employees 
	where department_id  != 60 
	group by department_id
	/
