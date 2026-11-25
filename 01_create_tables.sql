-- basic info shown at the top of the website
CREATE TABLE restaurant (
  id integer PRIMARY KEY,
  name varchar(50),
  description varchar(100),
  rating decimal,
  telephone char(10),
  hours varchar(100)
);

-- one address per restaurant, unique keeps it one-to-one
CREATE TABLE address (
  id integer PRIMARY KEY,
  street_number varchar(10),
  street_name varchar(50),
  city varchar(50),
  state varchar(20),
  google_map_link varchar(100),
  restaurant_id integer REFERENCES restaurant(id) UNIQUE
);

-- menu sections like chicken, luncheon specials, and house specials
CREATE TABLE category (
  id char(2) PRIMARY KEY,
  name varchar(20),
  description varchar(200)
);

-- every dish on the menu, priced separately in categories_dishes
CREATE TABLE dish (
  id integer PRIMARY KEY,
  name varchar(50),
  description varchar(200),
  hot_and_spicy boolean
);

-- links dishes to categories, price lives here since it depends on the category
CREATE TABLE categories_dishes (
  category_id char(2) REFERENCES category(id),
  dish_id integer REFERENCES dish(id),
  price money,
  PRIMARY KEY (category_id, dish_id)
);

-- customer reviews, many per restaurant
CREATE TABLE review (
  id integer PRIMARY KEY,
  rating decimal,
  description varchar(200),
  review_date date,
  restaurant_id integer REFERENCES restaurant(id)
);
