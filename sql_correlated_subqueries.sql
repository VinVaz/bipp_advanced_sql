-- ADVANCED SQL: Corretated Subqueries Lesson
-- LINK: https://bipp.io/sql-tutorial/advanced-sql/sql-correlated-subqueries/

CREATE TYPE payment AS ENUM ('monthly pay', 'bonus', 'adjustment');

-- CREATE TABLES
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


-- QUERIES:

-- Example 1 - List the employees who have never received a bonus.

-- using subquery with IN operator (Simple Query)
SELECT last_name, first_name
FROM employee em
WHERE employee_id NOT IN (
	SELECT ph.employee_id
	FROM payment_history ph
	WHERE payment_history.payment_type = 'bonus'
)

-- subquery with Exists operator (Correlated)
SELECT last_name, first_name
FROM employee em
WHERE NOT EXISTS (
	SELECT ph.last_name 
	FROM payment_history ph
	WHERE ph.employee_id = em.employee_id
	AND ph.payment_type = 'bonus'
	)

-- Notes 1: "correlated subqueries reference columns from the outer table"



/* Notes 2: 
  Should you use a correlated subquery for a positive data question? No.
  You can if you want to, but a JOIN condition or a relationship between two tables
  to answer data questions is a better approach for positive data questions.*/

SELECT first_name, last_name
FROM employee em, payment_history ph
WHERE ph.employee_id = em.employee_id
AND ph.payment_type = 'bonus'


SELECT first_name, last_name
FROM employee em
INNER JOIN payment_history ph ON ph.employee_id = em.employee_id
WHERE  ph.payment_type = 'bonus'

