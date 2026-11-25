-- restaurant name, street address, and phone for the top of the website
SELECT
  restaurant.name,
  address.street_number || ' ' || address.street_name AS address,
  restaurant.telephone
FROM restaurant
JOIN address
  ON restaurant.id = address.restaurant_id;
