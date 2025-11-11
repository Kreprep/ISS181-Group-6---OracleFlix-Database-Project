-- Section 15, Task 3: Create the TITLE_UNAVAIL view 
-- This view shows movie titles and media_id for items not returned
-- (i.e., where return_date IS NULL in RENTAL_HISTORY)

CREATE OR REPLACE VIEW TITLE_UNAVAIL AS
SELECT
    m.TITLE,
    rh.MEDIA_ID
FROM
    RENTAL_HISTORY rh
JOIN
    MEDIA md ON rh.MEDIA_ID = md.MEDIA_ID
JOIN
    MOVIES m ON md.TITLE_ID = m.TITLE_ID
WHERE
    rh.RETURN_DATE IS NULL
WITH READ ONLY; -- Makes the view non-updateable 


-- This is the query from Task 3 to check the view
-- NOTE: This will show NOTHING until you run Section_16.sql to add data.
SELECT * FROM TITLE_UNAVAIL;