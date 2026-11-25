-- highest rating out of all the reviews
SELECT MAX(rating) AS best_rating
FROM review;

-- the top review and what the customer actually said
SELECT rating AS best_rating, description
FROM review
WHERE rating = (SELECT MAX(rating) FROM review);
