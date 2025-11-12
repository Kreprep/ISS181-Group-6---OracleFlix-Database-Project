-- section 15
CREATE OR REPLACE VIEW TITLE_UNAVAIL AS
SELECT 
    m.title,
    me.media_id
FROM 
    movies m
JOIN 
    media me ON m.title_id = me.title_id
JOIN 
    rental_history r ON me.media_id = r.media_id
WHERE 
    r.return_date IS NULL
WITH READ ONLY;

SELECT * FROM TITLE_UNAVAIL; 
