--1. Create index

CREATE INDEX idx_orders_order_date ON orders(order_date);
CREATE INDEX idx_orders_ship_city ON orders(ship_city);
CREATE INDEX idx_orders_customer_id_order_id ON orders(customer_id,order_id);
CREATE UNIQUE INDEX idx_u_products_product_id ON products (product_id);
CREATE UNIQUE INDEX idx_u_employees_employee_id ON employees (employee_id);
CREATE UNIQUE INDEX idx_u_orders_customer_id_order_id ON orders(customer_id,order_id);
CREATE UNIQUE INDEX idx_u_employees_employee_id_hire_date ON employees (employee_id, hire_date);
SELECT * FROM employees;

--2. All indexes 

SELECT * FROM pg_indexes;
SELECT * FROM pg_indexes WHERE schemaname = 'public';
SELECT * FROM pg_indexes WHERE tablename = 'orders';
SELECT pg_size_pretty(pg_indexes_size('orders'));

--3. Applying indices on table will increase size of tables

SELECT pg_size_pretty(pg_indexes_size('suppliers'));   --- 16 KB
CREATE INDEX idx_suppliers_region ON suppliers(region);
SELECT pg_size_pretty(pg_indexes_size('suppliers'));   --- 32 KB

--4. pg_stat_all_indexes

SELECT * FROM pg_stat_all_indexes;
SELECT * FROM pg_stat_all_indexes WHERE schemaname = 'public';
SELECT * FROM pg_stat_all_indexes WHERE relname = 'orders';

--5. Drop indexes

DROP INDEX idx_suppliers_region; 

SELECT * FROM pg_am;

--6. Sequential scan, when no valuable alternative available
 