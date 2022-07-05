-- ADVANCED SQL: Corretated Subqueries Lesson
-- LINK: https://bipp.io/sql-tutorial/advanced-sql/sql-correlated-subqueries/

CREATE TYPE payment AS ENUM ('monthly pay', 'bonus', 'adjustment');

CREATE TABLE IF NOT EXISTS employee
  (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
  );

CREATE TABLE IF NOT EXISTS payment_history
  (
    payment_history_id SERIAL PRIMARY KEY,
    employee_id INT NOT NULL REFERENCES employee(employee_id) ON DELETE CASCADE,
    payment_type payment,
    amount_paid DECIMAL(8, 2),
    payment_date DATE
  );

INSERT INTO employee (employee_id, first_name, last_name)
VALUES
  (10100,	'Marcos',	'Bisset'),
  (10101,	'Kate',	'Perez'),
  (10102,	'Carlos',	'Casco');

INSERT INTO payment_history (employee_id, payment_type, amount_paid, payment_date)
VALUES
  (10100,	'monthly pay',	12000.00, '2018-02-02'),
  (10101,	'monthly pay',	2800.00, '2018-02-02'),
  (10102,	'monthly pay',	1900.00, '2018-03-02'),
  (10101,	'bonus',	1500.00, '2018-03-08'),
  (10102,	'adjustment',	124.70, '2018-03-10');