-- how many categories each dish shows up in
SELECT dish_id, COUNT(dish_id) AS dish_count
FROM categories_dishes
GROUP BY dish_id;

-- only dishes listed in more than one category
SELECT dish_id, COUNT(dish_id) AS dish_count
FROM categories_dishes
GROUP BY dish_id
HAVING COUNT(dish_id) > 1;

-- same check, but shows the dish name instead of its id
SELECT dish.name AS dish_name, COUNT(categories_dishes.dish_id) AS dish_count
FROM dish
JOIN categories_dishes
  ON dish.id = categories_dishes.dish_id
GROUP BY dish.name
HAVING COUNT(categories_dishes.dish_id) > 1;
