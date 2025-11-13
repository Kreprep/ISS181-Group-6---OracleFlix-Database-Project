-- 1. CUSTOMERS Table Constraints
    -- Add Primary Key
    ALTER TABLE customers
    ADD CONSTRAINT pk_customers PRIMARY KEY (customer_id);

    -- Add Not Null Constraints
    ALTER TABLE customers
    MODIFY (last_name NOT NULL,
            first_name NOT NULL,
            home_phone NOT NULL,
            address NOT NULL,
            city NOT NULL,
            state NOT NULL);

-- 2. MOVIES Table Constraints
    -- Add Primary Key
    ALTER TABLE movies
    ADD CONSTRAINT pk_movies PRIMARY KEY (title_id);

    -- Add Not Null Constraints
    ALTER TABLE movies
    MODIFY (title NOT NULL,
            description NOT NULL,
            release_date NOT NULL);

    -- Add Check Constraints "Create check constraint on rating field in movie table to limit rating values to 'G', 'PG', 'R', 'PG13'"
    ALTER TABLE movies
    ADD CONSTRAINT chk_movies_rating 
    CHECK (rating IN ('G', 'PG', 'R', 'PG13')); 

    -- Create check constraint on category field in movie table to limit categories to 'DRAMA', 'COMEDY', 'ACTION', 'CHILD', 'SCIFI', 'DOCUMENTARY'
    ALTER TABLE movies
    ADD CONSTRAINT chk_movies_category 
    CHECK (CATEGORY IN ('DRAMA', 'COMEDY', 'ACTION', 'CHILD', 'SCIFI', 'DOCUMENTARY')); 

-- 3. MEDIA Table Constraints
    -- Add Primary Key
    ALTER TABLE media
    ADD CONSTRAINT pk_media PRIMARY KEY (media_id);

    -- Add Not Null Constraints
    ALTER TABLE media
    MODIFY (format NOT NULL,
            title_id NOT NULL);

    -- Add Foreign Key
    ALTER TABLE media
    ADD CONSTRAINT fk_media_movies FOREIGN KEY (title_id)
    REFERENCES movies(title_id);

-- 4. RENTAL_HISTORY Table Constraints
    -- Add Composite Primary Key
    ALTER TABLE rental_history
    ADD CONSTRAINT pk_rental_history PRIMARY KEY (media_id, rental_date);

    -- Add Not Null Constraint
    ALTER TABLE rental_history
    MODIFY (customer_id NOT NULL);

    -- Add Foreign Keys
    ALTER TABLE rental_history
    ADD CONSTRAINT fk_rental_media FOREIGN KEY (media_id)
    REFERENCES media(media_id); 

    ALTER TABLE rental_history
    ADD CONSTRAINT fk_rental_customers FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id); 

-- 5. ACTORS Table Constraints
    -- Add Primary Key
    ALTER TABLE actors
    ADD CONSTRAINT pk_actors PRIMARY KEY (actor_id);

    -- Add Not Null Constraints
    ALTER TABLE actors
    MODIFY (stage_name NOT NULL,
            first_name NOT NULL,
            last_name NOT NULL,
            birth_date NOT NULL);


-- 6. STAR_BILLINGS Table Constraints
    -- Add Composite Primary Key
    ALTER TABLE star_billings
    ADD CONSTRAINT pk_star_billings PRIMARY KEY (actor_id, title_id);

    -- Add Foreign Keys
    ALTER TABLE star_billings
    ADD CONSTRAINT fk_star_actors FOREIGN KEY (actor_id)
    REFERENCES actors(actor_id);

    ALTER TABLE star_billings
    ADD CONSTRAINT fk_star_movies FOREIGN KEY (title_id)
    REFERENCES movies(title_id);

-- "Run queries from the data dictionaries for the above constraints."
SELECT constraint_name, table_name, constraint_type
FROM user_constraints
WHERE table_name IN (
    'CUSTOMERS', 
    'MOVIES', 
    'MEDIA', 
    'RENTAL_HISTORY', 
    'ACTORS', 
    'STAR_BILLINGS'
);
