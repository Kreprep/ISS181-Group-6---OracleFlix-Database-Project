-- This will basically reset your APEX by dropping everything.
-- Then this will run the codes from following files from github (derived from MAIN as of 04:09AM 11/14/25 COMMIT 56c9809):
-- -- Section_13.sql
-- -- Section_14.sql
-- -- Section_15.sql

BEGIN
  -- Drop Tables
  FOR i IN (SELECT table_name FROM user_tables) LOOP
    EXECUTE IMMEDIATE 'DROP TABLE "' || i.table_name || '" CASCADE CONSTRAINTS PURGE';
  END LOOP;

  -- Drop Sequences
  FOR i IN (SELECT sequence_name FROM user_sequences) LOOP
    EXECUTE IMMEDIATE 'DROP SEQUENCE "' || i.sequence_name || '"';
  END LOOP;

  -- Drop Views
  FOR i IN (SELECT view_name FROM user_views) LOOP
    EXECUTE IMMEDIATE 'DROP VIEW "' || i.view_name || '"';
  END LOOP;

  -- Drop Procedures, Functions, Packages
  FOR i IN (SELECT object_name, object_type FROM user_objects
            WHERE object_type IN ('PROCEDURE', 'FUNCTION', 'PACKAGE')) LOOP
    EXECUTE IMMEDIATE 'DROP ' || i.object_type || ' "' || i.object_name || '"';
  END LOOP;

  -- Drop Triggers
  FOR i IN (SELECT trigger_name FROM user_triggers) LOOP
    EXECUTE IMMEDIATE 'DROP TRIGGER "' || i.trigger_name || '"';
  END LOOP;
  
  -- Drop Types
  FOR i IN (SELECT type_name FROM user_types) LOOP
    EXECUTE IMMEDIATE 'DROP TYPE "' || i.type_name || '" FORCE';
  END LOOP;
END;
/

----------------------------------------
-- Section_13.sql

-- 1. CUSTOMERS Table
CREATE TABLE CUSTOMERS (
    CUSTOMER_ID NUMBER(10),
    LAST_NAME VARCHAR2(25),
    FIRST_NAME VARCHAR2(25),
    HOME_PHONE VARCHAR2(12),
    ADDRESS VARCHAR2(100),
    CITY VARCHAR2(30),
    STATE VARCHAR2(2),
    EMAIL VARCHAR2(25),
    CELL_PHONE VARCHAR2(12)
);

-- 2. MOVIES Table
CREATE TABLE MOVIES (
    TITLE_ID NUMBER(10),
    TITLE VARCHAR2(60),
    DESCRIPTION VARCHAR2(400),
    RATING VARCHAR2(4),
    CATEGORY VARCHAR2(20),
    RELEASE_DATE DATE
);

-- 3. MEDIA Table
CREATE TABLE MEDIA (
    MEDIA_ID NUMBER(10),
    FORMAT VARCHAR2(3),
    TITLE_ID NUMBER(10)
);

-- 4. RENTAL_HISTORY Table
CREATE TABLE RENTAL_HISTORY (
    MEDIA_ID NUMBER(10),
    RENTAL_DATE DATE DEFAULT SYSDATE,
    CUSTOMER_ID NUMBER(10),
    RETURN_DATE DATE
);

-- 5. ACTORS 
CREATE TABLE ACTORS (
    ACTOR_ID NUMBER(10),
    STAGE_NAME VARCHAR2(40),
    FIRST_NAME VARCHAR2(25),
    LAST_NAME VARCHAR2(25),
    BIRTH_DATE DATE
);

-- 6. STAR_BILLINGS Table
CREATE TABLE STAR_BILLINGS (
    ACTOR_ID NUMBER(10),
    TITLE_ID NUMBER(10),
    COMMENTS VARCHAR2(40)
);

-- -- "Run a DESC command for each table."
-- DESC CUSTOMERS;
-- DESC MOVIES;
-- DESC MEDIA;
-- DESC RENTAL_HISTORY;
-- DESC ACTORS;
-- DESC STAR_BILLINGS;

----------------------------------------
-- Section_14.sql


-- 1. CUSTOMERS Table Constraints
    -- Add Primary Key
    ALTER TABLE CUSTOMERS
    ADD CONSTRAINT pk_customers PRIMARY KEY (CUSTOMER_ID);

    -- Add Not Null Constraints
    ALTER TABLE CUSTOMERS
    MODIFY (LAST_NAME NOT NULL,
            FIRST_NAME NOT NULL,
            HOME_PHONE NOT NULL,
            ADDRESS NOT NULL,
            CITY NOT NULL,
            STATE NOT NULL);

-- 2. MOVIES Table Constraints
    -- Add Primary Key
    ALTER TABLE MOVIES
    ADD CONSTRAINT pk_movies PRIMARY KEY (TITLE_ID);

    -- Add Not Null Constraints
    ALTER TABLE MOVIES
    MODIFY (TITLE NOT NULL,
            DESCRIPTION NOT NULL,
            RELEASE_DATE NOT NULL);

    -- Add Check Constraints "Create check constraint on rating field in movie table to limit rating values to 'G', 'PG', 'R', 'PG13'"
    ALTER TABLE MOVIES
    ADD CONSTRAINT chk_movies_rating 
    CHECK (RATING IN ('G', 'PG', 'R', 'PG13'));

    -- Create check constraint on category field in movie table to limit categories to 'DRAMA', 'COMEDY', 'ACTION', 'CHILD', 'SCIFI', 'DOCUMENTARY'
    ALTER TABLE MOVIES
    ADD CONSTRAINT chk_movies_category 
    CHECK (CATEGORY IN ('DRAMA', 'COMEDY', 'ACTION', 'CHILD', 'SCIFI', 'DOCUMENTARY')); 

-- 3. MEDIA Table Constraints
    -- Add Primary Key
    ALTER TABLE MEDIA
    ADD CONSTRAINT pk_media PRIMARY KEY (MEDIA_ID);

    -- Add Not Null Constraints
    ALTER TABLE MEDIA
    MODIFY (FORMAT NOT NULL,
            TITLE_ID NOT NULL);

    -- Add Foreign Key
    ALTER TABLE MEDIA
    ADD CONSTRAINT fk_media_movies FOREIGN KEY (TITLE_ID)
    REFERENCES MOVIES(TITLE_ID);

-- 4. RENTAL_HISTORY Table Constraints
    -- Add Composite Primary Key
    ALTER TABLE RENTAL_HISTORY
    ADD CONSTRAINT pk_rental_history PRIMARY KEY (MEDIA_ID, RENTAL_DATE); 

    -- Add Not Null Constraint
    ALTER TABLE RENTAL_HISTORY
    MODIFY (CUSTOMER_ID NOT NULL);

    -- Add Foreign Keys
    ALTER TABLE RENTAL_HISTORY
    ADD CONSTRAINT fk_rental_media FOREIGN KEY (MEDIA_ID)
    REFERENCES MEDIA(MEDIA_ID); 

    ALTER TABLE RENTAL_HISTORY
    ADD CONSTRAINT fk_rental_customers FOREIGN KEY (CUSTOMER_ID)
    REFERENCES CUSTOMERS(CUSTOMER_ID);

-- 5. ACTORS Table Constraints
    -- Add Primary Key
    ALTER TABLE ACTORS
    ADD CONSTRAINT pk_actors PRIMARY KEY (ACTOR_ID);

    -- Add Not Null Constraints
    ALTER TABLE ACTORS
    MODIFY (STAGE_NAME NOT NULL,
            FIRST_NAME NOT NULL,
            LAST_NAME NOT NULL,
            BIRTH_DATE NOT NULL);


-- 6. STAR_BILLINGS Table Constraints
    -- Add Composite Primary Key
    ALTER TABLE STAR_BILLINGS
    ADD CONSTRAINT pk_star_billings PRIMARY KEY (ACTOR_ID, TITLE_ID);

    -- Add Foreign Keys
    ALTER TABLE STAR_BILLINGS
    ADD CONSTRAINT fk_star_actors FOREIGN KEY (ACTOR_ID)
    REFERENCES ACTORS(ACTOR_ID);

    ALTER TABLE STAR_BILLINGS
    ADD CONSTRAINT fk_star_movies FOREIGN KEY (TITLE_ID)
    REFERENCES MOVIES(TITLE_ID);

-- -- "Run queries from the data dictionaries for the above constraints."
-- SELECT constraint_name, table_name, constraint_type
-- FROM user_constraints
-- WHERE table_name IN (
--     'CUSTOMERS', 
--     'MOVIES', 
--     'MEDIA', 
--     'RENTAL_HISTORY', 
--     'ACTORS', 
--     'STAR_BILLINGS'
-- );

----------------------------------------
-- Section_15.sql

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

-- SELECT * FROM TITLE_UNAVAIL; 
