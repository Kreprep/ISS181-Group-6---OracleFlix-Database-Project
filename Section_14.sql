-- 1. CUSTOMERS Table Constraints
    -- Add Primary Key
    ALTER TABLE CUSTOMERS
    ADD CONSTRAINT pk_customers PRIMARY KEY (CUSTOMER_ID);

    -- Add Not Null Constraints
    ALTER TABLE CUSTOMERS
    MODIFY (LAST_NAME VARCHAR2(25) NOT NULL,
            FIRST_NAME VARCHAR2(25) NOT NULL,
            HOME_PHONE VARCHAR2(12) NOT NULL,
            ADDRESS VARCHAR2(100) NOT NULL,
            CITY VARCHAR2(30) NOT NULL,
            STATE VARCHAR2(2) NOT NULL);

-- 2. MOVIES Table Constraints
    -- Add Primary Key
    ALTER TABLE MOVIES
    ADD CONSTRAINT pk_movies PRIMARY KEY (TITLE_ID);

    -- Add Not Null Constraints
    ALTER TABLE MOVIES
    MODIFY (TITLE VARCHAR2(60) NOT NULL,
            DESCRIPTION VARCHAR2(400) NOT NULL,
            RELEASE_DATE DATE NOT NULL);

    -- Add Check Constraints
    ALTER TABLE MOVIES
    ADD CONSTRAINT chk_movies_rating 
    CHECK (RATING IN ('G', 'PG', 'R', 'PG13')); -- [cite: 53]

    ALTER TABLE MOVIES
    ADD CONSTRAINT chk_movies_category 
    CHECK (CATEGORY IN ('DRAMA', 'COMEDY', 'ACTION', 'CHILD', 'SCIFI', 'DOCUMENTARY')); -- [cite: 54]

-- 3. MEDIA Table Constraints
    -- Add Primary Key
    ALTER TABLE MEDIA
    ADD CONSTRAINT pk_media PRIMARY KEY (MEDIA_ID);

    -- Add Not Null Constraints
    ALTER TABLE MEDIA
    MODIFY (FORMAT VARCHAR2(3) NOT NULL,
            TITLE_ID NUMBER(10) NOT NULL);

    -- Add Foreign Key
    ALTER TABLE MEDIA
    ADD CONSTRAINT fk_media_movies FOREIGN KEY (TITLE_ID)
    REFERENCES MOVIES(TITLE_ID);

-- 4. RENTAL_HISTORY Table Constraints
    -- Add Composite Primary Key
    ALTER TABLE RENTAL_HISTORY
    ADD CONSTRAINT pk_rental_history PRIMARY KEY (MEDIA_ID, RENTAL_DATE); -- 

    -- Add Not Null Constraint
    ALTER TABLE RENTAL_HISTORY
    MODIFY (CUSTOMER_ID NUMBER(10) NOT NULL);

    -- Add Foreign Keys
    ALTER TABLE RENTAL_HISTORY
    ADD CONSTRAINT fk_rental_media FOREIGN KEY (MEDIA_ID)
    REFERENCES MEDIA(MEDIA_ID); -- 

    ALTER TABLE RENTAL_HISTORY
    ADD CONSTRAINT fk_rental_customers FOREIGN KEY (CUSTOMER_ID)
    REFERENCES CUSTOMERS(CUSTOMER_ID); --

-- 5. ACTORS Table Constraints
    -- Add Primary Key
    ALTER TABLE ACTORS
    ADD CONSTRAINT pk_actors PRIMARY KEY (ACTOR_ID);

    -- Add Not Null Constraints
    ALTER TABLE ACTORS
    MODIFY (STAGE_NAME VARCHAR2(40) NOT NULL,
            FIRST_NAME VARCHAR2(25) NOT NULL,
            LAST_NAME VARCHAR2(25) NOT NULL,
            BIRTH_DATE DATE NOT NULL);


-- 6. STAR_BILLINGS Table Constraints
    -- Add Composite Primary Key
    ALTER TABLE STAR_BILLINGS
    ADD CONSTRAINT pk_star_billings PRIMARY KEY (ACTOR_ID, TITLE_ID); -- 

    -- Add Foreign Keys
    ALTER TABLE STAR_BILLINGS
    ADD CONSTRAINT fk_star_actors FOREIGN KEY (ACTOR_ID)
    REFERENCES ACTORS(ACTOR_ID);

    ALTER TABLE STAR_BILLINGS
    ADD CONSTRAINT fk_star_movies FOREIGN KEY (TITLE_ID)
    REFERENCES MOVIES(TITLE_ID);

-- Notes: Verify Your Constraints
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


    