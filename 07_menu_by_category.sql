-- same menu data, grouped by category this time
SELECT
  category.name AS category,
  dish.name AS dish_name,
  categories_dishes.price AS price
FROM dish
JOIN categories_dishes
  ON dish.id = categories_dishes.dish_id
JOIN category
  ON categories_dishes.category_id = category.id
ORDER BY category.name;
