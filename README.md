# Bytes of China

A PostgreSQL project from Codecademy's Full-Stack Engineer path. Bytes of China is a made-up Chinese restaurant that needed a database behind its new website, so I designed the schema for its menu and reviews pages, loaded sample data, and wrote the queries the site would use.

There's no live site for this one. It's a set of SQL files you run against a PostgreSQL database in the terminal.

## What it does

The database has six tables:

- `restaurant` holds the name, description, rating, phone number, and hours
- `address` holds the street, city, state, and Google Maps link
- `category` holds the menu sections, like Chicken, Luncheon Specials, and House Specials
- `dish` holds each dish's name, description, and whether it's hot and spicy
- `categories_dishes` links dishes to categories and holds the price
- `review` holds each customer review with its rating and date

And it covers all three kinds of relationships:

- One-to-one: each restaurant has exactly one address (`address.restaurant_id` is a foreign key with UNIQUE)
- One-to-many: one restaurant has many reviews (`review.restaurant_id` is a foreign key without UNIQUE)
- Many-to-many: a category has many dishes, and a dish can be in more than one category, so `categories_dishes` sits in between with a composite primary key

Each step is its own numbered file:

- `01_create_tables.sql` creates all six tables with their primary and foreign keys
- `02_check_keys.sql` checks that every key exists using `information_schema.key_column_usage`
- `03_insert_data.sql` loads Codecademy's sample data
- `04_restaurant_info.sql` gets the name, street address, and phone number for the top of the site
- `05_best_rating.sql` finds the best rating, then shows it with the review text using a subquery
- `06_menu_by_dish.sql` lists every dish with its price and category, sorted by dish name
- `07_menu_by_category.sql` shows the same menu sorted by category
- `08_spicy_dishes.sql` lists only the hot and spicy dishes
- `09_multi_category_dishes.sql` uses COUNT, GROUP BY, and HAVING to find dishes listed in more than one category

## How to run it

You need PostgreSQL installed.

Create the database:

```
psql -U postgres -c "CREATE DATABASE bytes_of_china;"
```

Then run the files in order from this folder:

```
psql -U postgres -d bytes_of_china -f 01_create_tables.sql
psql -U postgres -d bytes_of_china -f 02_check_keys.sql
psql -U postgres -d bytes_of_china -f 03_insert_data.sql
psql -U postgres -d bytes_of_china -f 04_restaurant_info.sql
psql -U postgres -d bytes_of_china -f 05_best_rating.sql
psql -U postgres -d bytes_of_china -f 06_menu_by_dish.sql
psql -U postgres -d bytes_of_china -f 07_menu_by_category.sql
psql -U postgres -d bytes_of_china -f 08_spicy_dishes.sql
psql -U postgres -d bytes_of_china -f 09_multi_category_dishes.sql
```

Run `01` and `03` only once. A local database keeps everything, so running them again gives "already exists" and "duplicate key" errors. To start over:

```
psql -U postgres -c "DROP DATABASE bytes_of_china;"
```

## Example output

The full menu sorted by dish name:

```
                    dish_name                    | price  |     category
-------------------------------------------------+--------+-------------------
 Beef with Garlic Sauce                          |  $8.95 | Luncheon Specials
 Chicken Wings                                   |  $6.95 | Chicken
 Chicken with Broccoli                           |  $6.95 | Chicken
 Chicken with Broccoli                           |  $8.95 | Luncheon Specials
 Fresh Mushroom with Snow Peapods and Baby Corns |  $8.95 | Luncheon Specials
 Hunan Special Half & Half                       | $17.95 | House Specials
 Sesame Chicken                                  | $15.95 | House Specials
 Special Minced Chicken                          | $16.95 | House Specials
(8 rows)
```

The best review, found with a subquery:

```
 best_rating |                         description
-------------+--------------------------------------------------------------
         5.0 | Would love to host another birthday party at Bytes of China!
(1 row)
```

## What I learned

- The sample data decided my column order. The inserts don't list column names, so my tables had to match the data exactly. I first gave `address` a zip code column, but the data had no zip, and the last value turned out to be `restaurant_id`. The phone number was stored as 10 digits with no dashes, so `telephone` became `char(10)`.
- Price goes in `categories_dishes`, not `dish`. Chicken with Broccoli is $6.95 under Chicken but $8.95 as a Luncheon Special, so the price depends on the category, not just the dish.
- The only difference between my one-to-one and one-to-many foreign keys is UNIQUE. That's also why `restaurant_id` shows up twice when I check the keys on `address`: once for the foreign key and once for UNIQUE.
- I got "relation address already exists" because I'd left my old `CREATE TABLE address` in the file when I added the new version with the foreign key. Deleting the old block fixed it.
- WHERE can't use COUNT() because it filters rows before they're grouped. HAVING filters after grouping, so that's where `COUNT(dish_id) > 1` goes.
- MAX() alone only gives the number. To get the review text too, I put `SELECT MAX(rating)` inside the WHERE as a subquery.
- Sweet and Sour Chicken is in the `dish` table but never linked to a category in the sample data, so it doesn't show up on the menu queries.

Built by DeVante Bush
