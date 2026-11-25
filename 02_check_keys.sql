-- check the primary keys on restaurant and address
SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name IN ('restaurant', 'address');

-- check the primary key on category
SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name = 'category';

-- check the primary key on dish
SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name = 'dish';

-- check the keys on review, foreign key makes it one-to-many
SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name = 'review';

-- check the keys on address, restaurant_id should show up twice
SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name = 'address';

-- check the keys on categories_dishes, expect 4 rows
SELECT
  constraint_name, table_name, column_name
FROM
  information_schema.key_column_usage
WHERE
  table_name = 'categories_dishes';
