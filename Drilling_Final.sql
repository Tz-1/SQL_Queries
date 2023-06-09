--Aquellas usadas para insertar, modificar y eliminar un Customer, Staff y Actor.

--Customer:
insert into customer (customer_id, store_id, first_name, last_name, email, address_id, activebool, create_date, last_update, active) values
(default, 1, 'Raidou', 'Kuzunoha', 'devil.summoner@sakilacustomer.org', 605, true, '2023-06-08', current_timestamp, 1);

update customer set first_name = 'Keiji', last_name = 'Minegishi' where customer_id = 601; 

delete from customer where customer_id = 601;

--Staff:
insert into staff (staff_id, first_name, last_name, address_id, email, store_id, active, username, password, last_update, picture) values
(default, 'Justy', 'Tylor', 3, 'Captain.Tylor@sakilastaff.com', 2, true, 'Captain', '123', current_timestamp, null);

update staff set username = 'Irresponsible' where staff_id = 3;

delete from staff where staff_id = 3;

--Actor:
insert into actor (actor_id, first_name, last_name, last_update) values
(default, 'Mima', 'Kirigoe', current_timestamp);

update actor set first_name = 'Rumi' where actor_id = 201;

delete from actor where actor_id = 201;

--Listar todas las “rental” con los datos del “customer” dado un año y mes.
select r.*, c.*
from rental r
join customer c on r.customer_id  = c.customer_id 
where extract(year from rental_date) = 2005
and extract(month from rental_date) = 07;

--Listar Número, Fecha (payment_date) y Total (amount) de todas las “payment”.
select date(payment_date) as fecha, count(*) AS cantidad_pagos, sum(amount) AS total_pagado
FROM payment
group by date(payment_date);

--Listar todas las “film” del año 2006 que contengan un (rental_rate) mayor a 4.0.
select f.title, f.release_year, f.rental_rate
from film f
where f.release_year = 2006 and rental_rate >= 4.0;

--Realiza un Diccionario de datos que contenga el nombre de las tablas y columnas, si éstas pueden ser nulas, y su tipo de dato correspondiente.
SELECT
 t1.TABLE_NAME AS tabla_nombre,
 t1.COLUMN_NAME AS columna_nombre,
 t1.COLUMN_DEFAULT AS columna_defecto,
 t1.IS_NULLABLE AS columna_nulo,
 t1.DATA_TYPE AS columna_tipo_dato,
 COALESCE(t1.NUMERIC_PRECISION,
 t1.CHARACTER_MAXIMUM_LENGTH) AS columna_longitud,
 PG_CATALOG.COL_DESCRIPTION(t2.OID,
 t1.DTD_IDENTIFIER::int) AS columna_descripcion,
 t1.DOMAIN_NAME AS columna_dominio
FROM
 INFORMATION_SCHEMA.COLUMNS t1
 INNER JOIN PG_CLASS t2 ON (t2.RELNAME = t1.TABLE_NAME)
WHERE
 t1.TABLE_SCHEMA = 'public'
ORDER BY
 t1.TABLE_NAME;