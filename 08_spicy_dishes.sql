-- only the dishes marked hot and spicy
SELECT
  dish.name AS spicy_dish_name,
  category.name AS category,
  categories_dishes.price AS price
FROM dish
JOIN categories_dishes
  ON dish.id = categories_dishes.dish_id
JOIN category
  ON categories_dishes.category_id = category.id
WHERE dish.hot_and_spicy = true;
