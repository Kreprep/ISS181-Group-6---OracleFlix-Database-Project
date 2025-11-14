-- Section 15 - Creating and Managing Views

-- REQUIREMENT: Create a view called TITLE_UNAVAIL to show the movie titles and media_id of the media not returned yet.
-- REQUIREMENT: The view should not allow any DML operations.
CREATE OR REPLACE VIEW TITLE_UNAVAIL AS
SELECT 
    M.TITLE,
    ME.MEDIA_ID
FROM 
    MOVIES M
JOIN 
    MEDIA ME ON M.TITLE_ID = ME.TITLE_ID
JOIN 
    RENTAL_HISTORY R ON ME.MEDIA_ID = R.MEDIA_ID
WHERE 
    R.RETURN_DATE IS NULL
WITH READ ONLY;

-- REQUIREMENT: Run a SELECT * for the view (after data has been added in later step)
SELECT * FROM TITLE_UNAVAIL; 
