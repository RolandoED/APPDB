---

##Clase10

###Cursores Oracle

Son usados para asignar variables de un select para iterarlas tomar decisiones y devolver resultados acorde

Cursor es como el data set de c# 

	CURSOR emp_cursor IS 

el Open hace que se cargue la informacion en el cursor que de momento es solo una estructura del los Rows de una tabla con los campos declarados en 

	DECLARE
		CURSOR 		emp_cursor  IS 
		SELECT 		employee_id, last_name
		FROM 		empoyees;


COmo se carga la informacion 

LOOP FOR o 

	LOOP 
		FETCH emp_cursor INTO v_empno, v_ename;
		EXIT WHEN....;
		...
	END LOOP


CUANDO SE USA SIN OPEN 
se ponen primero los campos y luego el cursor, 
el for se encarga de cerrar el cursor 

---

	DECLARE 
		CURSOR NOMBRE_CUR IS
			QUERY......;
	CURSOR SDASD IS QUERY;
	V_REC;
	BEGIN 
		FOR V_REC INTO NOMBRE_CUR LOOP
			....
	END FOR


---

	SET SERVEROUTPUT ON
	DECLARE
	
	CURSOR MI_CURSOR IS
	SELECT  E.EMPLOYEE_ID, E.FIRST_NAME || E.LAST_NAME as NOMBRE
	
	FROM EMPLOYEES E, DEPARTMENTS D
	WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID;
	
	MR MI_CURSOR%ROWTYPE;
	
	BEGIN 
	  OPEN MI_CURSOR;
	  LOOP
	    FETCH MI_CURSOR INTO MR;
	    EXIT WHEN MI_CURSOR%NOT FOUND;


###FUNCIONES 

ES LO MISMO QUE UN PROCESO ALMACENADO , PERO A DIFERENCIA LA FUNCION SIEMPRE DEVOLVERÁ UN VALOR 


	create or replace FUNCTION NOMBRE_EMPLEADO_FN(p_id number) return varchar2 is
	  v_nombre varchar(50);
	BEGIN
	  select first_name ||' '||last_name into v_nombre
	  from employees
	  where employee_id = p_id;
	  return initcap(v_nombre);  
	END;

uso

	set serveroutput on
	declare 
	v_nombre varchar2(50);
	begin
	  v_nombre := nombre_empleado_fn(&id_empleado);
	  DBMS_OUTPUT.PUT_LINE('El empleado es: '|| v_nombre);
	end;


	CREATE OR REPLACE FUNCTION
	TIPO_CAMBIO_FN(p_date date, p_tipo varchar2 DEFAULT 'V') RETURN number is
	v_monto number(5,2);
	BEGIN
	  select decode(upper(p_tipo), 'V', venta, compra)
	  into v_monto
	  from TIPOS_CAMBIOS 
	  where TRUNC(fecha) = TRUNC(p_fecha);
	  return v_monto;
	END TIPO_CAMBIO_FN;


---

###Clase  # 12

---

Set system message level

	:system,Message_level:='25';
	commit

Variable Global

	:Global.Employee_ID
 

Borrar el usuario para actualizar el DMP


	DROP USER ___ DELETE CASCADE;
	CREATE USER
	GRANT

---

###Clase  # 13

---

###PACKAGES

- Modularidad 
- Facil diseño de aplicación
- Ocultamiento de información
- Mejor performance

---

	CREATE PACKAGE cust_sal AS 
		PROCEDURE find_sal(c_id customers.id%type);
		FUNCTION nombre_func(parametros return nombre del return);
	END cust_sal;
	/

Invoke

	package_name.element_name;

---

###TRIGGERS

Se dispare un codigo cuando se da una condicion especifica


**A nivel de registro**

Cada operacion que afecte a la tabla 

**A nivel de statement o sentencia** 

Solo se va a actualizar una vez

Controlar tiempos de insercion de tablas de lunes a viernes de 8 a 6pm 

Trigger no llevan commit , procedimientos almacenados si
 
---

###Vistas

Son tablas intermedias para restringir el acceso a información del usuario.

	CREATE OR REPLACE VIEW view1
	SUBQUERY


SINONIMOS

CREATE PUBLIC SYONYM

GRANTS para que funcione

	grant create public synonym to hr;
	
	grant create synonym to hr;
	
	grant select on employees to scott;

	Create role administrador;
	
	Create role usuario1;

	grant insert, update, delete, select on employees to administrador;

	grant insert, select on hr.

	grant administrador to scott;

	grant usuario1 to fulano;


---

La exportacion de datos se realiza con los comandos 

	--Se usan a nivel de CMD line se usaba antes 
	--de al version 9 pero todavia existe en 10g  y 11 g y el resto 
	EXP / IMP * 

	--DP significa datapoint
	EXMPDP / IMPDP


	EXP USR/PWD FILE=RUTA\ARCHIVO.DMP


	TIENE 3 modos
		- Completo TODO 
	
				EXP USR/PWD FILE=RUTA\ARCHIVO.DMP FULL=Y LOG=ARCHIVO.LOG

		- Usuario  TODO lo que tiene el usuario
	

				EXP USR/PWD FILE=RUTA\ARCHIVO.DMP OWNER=HR

		- Tablan   Solo la tabla con todo


				EXP USR/PWD FILE=RUTA\ARCHIVO.DMP TABLES=HR.EMPLOYEES

Importamos un usuario admin con permisos para hacer importaciones
 
	IMP USR/PWD FILE=RUTA\ARCHIVO.DMP FULLY=Y
	IMP USR/PWD FILE=RUTA\ARCHIVO.DMP FROM USER=HR TOUSER=SCOTT

CASE

	SELECT ENAME , JOB, SAL "SAL ACT",
	CASE
		WHEN SAL BETWEEN 0 AND 1000 THEN 'C'
		WHEN SAL BETWEEN 1001 AND 3000 THEN 'B'
		WHEN SAL > 3000 THEN 'C'
	ELSE
		'N/A'
	END CATEGORIA
	FROM EMP

Function

	CREATE OR REPLACE Function IncomeLevel
	   ( name_in IN varchar2 )
	   RETURN varchar2
	IS
	   monthly_value number(6);
	   ILevel varchar2(20);
	
	   cursor c1 is
	     SELECT monthly_income
	     FROM employees
	     WHERE name = name_in;
	
	BEGIN
	
	   open c1;
	   fetch c1 into monthly_value;
	   close c1;
	
	   IF monthly_value <= 4000 THEN
	      ILevel := 'Low Income';
	
	   ELSIF monthly_value > 4000 and monthly_value <= 7000 THEN
	      ILevel := 'Avg Income';
	
	   ELSIF monthly_value > 7000 and monthly_value <= 15000 THEN
	      ILevel := 'Moderate Income';
	
	   ELSE
	      ILevel := 'High Income';
	
	   END IF;
	
	   RETURN ILevel;
	
	END;

###Trigger


	create or replace TRIGGER VERIFICA_HORARIO 
	BEFORE INSERT ON TIPOS_CAMBIOS 
	BEGIN
	  --NULL;
	  IF to_CHAR(sysdate,'DY') IN ('SÁB','DOM') OR
	        to_char(sysdate,'HH24') NOT BETWEEN '08' AND '18' THEN
	        RAISE_APPLICATION_ERROR(-20666, 'No se puede realizar operacion');
	  END IF;
	END;