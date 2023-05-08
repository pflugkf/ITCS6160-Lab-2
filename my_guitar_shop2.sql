#Question 1
SELECT product_code, product_name, list_price, discount_percent
FROM products
ORDER BY list_price desc;

#Question 2
SELECT product_name, list_price, date_added
FROM products
WHERE list_price > 500 AND list_price < 2000
ORDER BY date_added desc;

#Question 3
SELECT category_name, product_name, list_price
FROM categories c, products p
WHERE c.category_id = p.category_id
ORDER BY category_name, product_name;

#Question 4 
SELECT p1.product_name AS product1, p2.product_name AS product2, p1.list_price
FROM products AS p1, products AS p2
WHERE p1.product_id < p2.product_id AND p1.list_price = p2.list_price
ORDER BY p1.list_price;

#Question 5
SELECT order_id, order_date, ship_date
FROM orders
WHERE ship_date IS NULL;

#Question 6
SELECT CONCAT(c.first_name, ' ', c.last_name) AS full_name, o.order_date
FROM customers c, orders o
WHERE c.customer_id = o.customer_id AND o.order_date LIKE '2015-04-%';

#Question 7
SELECT product_name, list_price, category_name
FROM products p, categories c
WHERE list_price = (SELECT MAX(list_price) FROM products) AND p.category_id = c.category_id;

#Question 8
SELECT DISTINCT CONCAT(customers.first_name, ' ', customers.last_name) AS customer_name, addresses.state
FROM ((customers INNER JOIN addresses ON addresses.state = 'NJ' OR addresses.state = 'NY')
INNER JOIN orders ON orders.customer_id = customers.customer_id)
WHERE YEAR(orders.order_date) = 2015
ORDER BY customer_name, state;

#Question 9
SELECT SUM(tax_amount) AS NJ_tax_total
FROM addresses, orders
WHERE addresses.address_id = orders.billing_address_id AND addresses.state = 'NJ';

#Question 10
SELECT addresses.state, SUM(tax_amount) AS state_tax_total FROM addresses, orders
WHERE addresses.address_id = orders.billing_address_id AND addresses.state = 'NJ'
UNION
SELECT addresses.state, SUM(tax_amount) AS state_tax_total FROM addresses, orders
WHERE addresses.address_id = orders.billing_address_id AND addresses.state = 'NY'
UNION
SELECT addresses.state, SUM(tax_amount) AS state_tax_total FROM addresses, orders
WHERE addresses.address_id = orders.billing_address_id AND addresses.state = 'OR'
UNION
SELECT addresses.state, SUM(tax_amount) AS state_tax_total FROM addresses, orders
WHERE addresses.address_id = orders.billing_address_id AND addresses.state = 'NE'
UNION
SELECT addresses.state, SUM(tax_amount) AS state_tax_total FROM addresses, orders
WHERE addresses.address_id = orders.billing_address_id AND addresses.state = 'CA'
UNION
SELECT addresses.state, SUM(tax_amount) AS state_tax_total FROM addresses, orders
WHERE addresses.address_id = orders.billing_address_id AND addresses.state = 'CO';