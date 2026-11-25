-- every dish with its price and category, a to z by dish name
SELECT
  dish.name AS dish_name,
  categories_dishes.price AS price,
  category.name AS category
FROM dish
JOIN categories_dishes
  ON dish.id = categories_dishes.dish_id
JOIN category
  ON categories_dishes.category_id = category.id
ORDER BY dish.name;
