-- This will basically reset your APEX by dropping everything.
-- Then this will run the codes from following files from github (derived from MAIN as of 04:09AM 11/14/25 COMMIT 56c9809):
-- -- Section_13.sql
-- -- Section_14.sql
-- -- Section_15.sql
-- -- Section_16.sql

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

----------------------------------------
-- Section_16.sql

-- REQUIREMENT: Create the following sequences to be used for primary key values:

-- REQUIREMENT: Use a sequence to generate PKs for CUSTOMER_ID in CUSTOMERS table
-- Begin at 101 and increment by 1
CREATE SEQUENCE CUSTOMERS_SEQ
    START WITH 101
    INCREMENT BY 1;

-- REQUIREMENT: Use a sequence to generate PKs for TITLE_ID in MOVIES table
-- Begin at 1 and increment by 1
CREATE SEQUENCE MOVIES_SEQ
    START WITH 1
    INCREMENT BY 1;

-- REQUIREMENT: Use a sequence to generate PKs for MEDIA_ID in MEDIA table
-- Begin at 92 and increment by 1
CREATE SEQUENCE MEDIA_SEQ
    START WITH 92
    INCREMENT BY 1;

-- REQUIREMENT: Use a sequence to generate PKs for ACTOR_ID in ACTOR table
-- Begin at 1001 and increment by 1
CREATE SEQUENCE ACTORS_SEQ
    START WITH 1001
    INCREMENT BY 1;

-- REQUIREMENT: Run queries from the data dictionaries for the above sequences.
-- SELECT sequence_name, min_value, max_value, increment_by, last_number
-- FROM user_sequences;

-- REQUIREMENT: Add the data to the tables. Be sure to use the sequences for the PKs.

-- INSERT TO CUSTOMERS
-- "Sample Data – Make up at least 6 members, using the sequence to generate the PKs:"
INSERT INTO CUSTOMERS (CUSTOMER_ID, LAST_NAME, FIRST_NAME, HOME_PHONE, ADDRESS, CITY, STATE, EMAIL, CELL_PHONE)
VALUES (CUSTOMERS_SEQ.NEXTVAL, 'Palombo', 'Lisa', '716-270-2669', '123 Main St', 'Buffalo', 'NY', 'palombo@ecc.edu', '716-555-1212');

-- Next 6 inserts are AI Generated. For references
INSERT INTO CUSTOMERS (CUSTOMER_ID, LAST_NAME, FIRST_NAME, HOME_PHONE, ADDRESS, CITY, STATE, EMAIL, CELL_PHONE)
VALUES (CUSTOMERS_SEQ.NEXTVAL, 'Anderson', 'James', '213-234-5678', '123 Maple Street', 'Los Angeles', 'CA', 'james.anderson@email.com', '310-987-6543');

INSERT INTO CUSTOMERS (CUSTOMER_ID, LAST_NAME, FIRST_NAME, HOME_PHONE, ADDRESS, CITY, STATE, EMAIL, CELL_PHONE)
VALUES (CUSTOMERS_SEQ.NEXTVAL, 'Martinez', 'Sofia', '512-345-6789', '456 Oak Avenue', 'Austin', 'TX', 'sofia.martinez@email.com', '737-876-5432');

INSERT INTO CUSTOMERS (CUSTOMER_ID, LAST_NAME, FIRST_NAME, HOME_PHONE, ADDRESS, CITY, STATE, EMAIL, CELL_PHONE)
VALUES (CUSTOMERS_SEQ.NEXTVAL, 'Chen', 'Michael', '206-456-7890', '789 Pine Road', 'Seattle', 'WA', 'michael.chen@email.com', '425-765-4321');

INSERT INTO CUSTOMERS (CUSTOMER_ID, LAST_NAME, FIRST_NAME, HOME_PHONE, ADDRESS, CITY, STATE, EMAIL, CELL_PHONE)
VALUES (CUSTOMERS_SEQ.NEXTVAL, 'Thompson', 'Emily', '305-567-8901', '321 Birch Lane', 'Miami', 'FL', 'emily.thompson@email.com', '786-654-3210');

INSERT INTO CUSTOMERS (CUSTOMER_ID, LAST_NAME, FIRST_NAME, HOME_PHONE, ADDRESS, CITY, STATE, EMAIL, CELL_PHONE)
VALUES (CUSTOMERS_SEQ.NEXTVAL, 'Patel', 'Raj', '312-678-9012', '654 Cedar Drive', 'Chicago', 'IL', 'raj.patel@email.com', '773-543-2109');

INSERT INTO CUSTOMERS (CUSTOMER_ID, LAST_NAME, FIRST_NAME, HOME_PHONE, ADDRESS, CITY, STATE, EMAIL, CELL_PHONE)
VALUES (CUSTOMERS_SEQ.NEXTVAL, 'Williams', 'Sarah', '617-789-0123', '987 Elm Boulevard', 'Boston', 'MA', 'sarah.williams@email.com', '857-432-1098');

-- REQUIREMENT: Run a SELECT * for each table.
-- SELECT * FROM CUSTOMERS ORDER BY CUSTOMER_ID;

-- INSERT INTO MOVIES
INSERT INTO MOVIES (TITLE_ID, TITLE, DESCRIPTION, RATING, CATEGORY, RELEASE_DATE)
VALUES (MOVIES_SEQ.NEXTVAL, 'Remember the Titans', 'High school football integration drama', 'PG', 'DRAMA', TO_DATE('29-SEP-2000','DD-MON-YYYY'));

INSERT INTO MOVIES (TITLE_ID, TITLE, DESCRIPTION, RATING, CATEGORY, RELEASE_DATE)
VALUES (MOVIES_SEQ.NEXTVAL, 'Inception', 'A thief steals secrets through dreams', 'PG13', 'SCIFI', TO_DATE('16-JUL-2010','DD-MON-YYYY'));

INSERT INTO MOVIES (TITLE_ID, TITLE, DESCRIPTION, RATING, CATEGORY, RELEASE_DATE)
VALUES (MOVIES_SEQ.NEXTVAL, 'The Dark Knight', 'Batman battles the Joker', 'PG13', 'ACTION', TO_DATE('18-JUL-2008','DD-MON-YYYY'));

INSERT INTO MOVIES (TITLE_ID, TITLE, DESCRIPTION, RATING, CATEGORY, RELEASE_DATE)
VALUES (MOVIES_SEQ.NEXTVAL, 'Titanic', 'Romance and tragedy aboard the RMS Titanic', 'PG13', 'DRAMA', TO_DATE('19-DEC-1997','DD-MON-YYYY'));

INSERT INTO MOVIES (TITLE_ID, TITLE, DESCRIPTION, RATING, CATEGORY, RELEASE_DATE)
VALUES (MOVIES_SEQ.NEXTVAL, 'The Matrix', 'A hacker learns the truth about reality', 'R', 'SCIFI', TO_DATE('31-MAR-1999','DD-MON-YYYY'));

INSERT INTO MOVIES (TITLE_ID, TITLE, DESCRIPTION, RATING, CATEGORY, RELEASE_DATE)
VALUES (MOVIES_SEQ.NEXTVAL, 'Forrest Gump', 'Life story of Forrest Gump', 'PG13', 'DRAMA', TO_DATE('06-JUL-1994','DD-MON-YYYY'));

-- SELECT * FROM MOVIES ORDER BY TITLE_ID;

-- INSERT INTO MEDIA
INSERT INTO MEDIA (MEDIA_ID, FORMAT, TITLE_ID)
VALUES (MEDIA_SEQ.NEXTVAL, 'DVD', 1);

INSERT INTO MEDIA (MEDIA_ID, FORMAT, TITLE_ID)
VALUES (MEDIA_SEQ.NEXTVAL, 'VHS', 1);

-- SELECT * FROM MEDIA ORDER BY MEDIA_ID;

-- INSERT INTO RENTAL_HISTORY
INSERT INTO RENTAL_HISTORY (MEDIA_ID, RENTAL_DATE, CUSTOMER_ID, RETURN_DATE)
VALUES (92, TO_DATE('19-SEP-2010','DD-MON-YYYY'), 101, TO_DATE('20-SEP-2010','DD-MON-YYYY'));

INSERT INTO RENTAL_HISTORY 
VALUES (93, TO_DATE('20-SEP-2010','DD-MON-YYYY'), 102, TO_DATE('22-SEP-2010','DD-MON-YYYY'));

INSERT INTO RENTAL_HISTORY 
VALUES (94, TO_DATE('01-OCT-2010','DD-MON-YYYY'), 103, TO_DATE('03-OCT-2010','DD-MON-YYYY'));

INSERT INTO RENTAL_HISTORY 
VALUES (95, TO_DATE('05-OCT-2010','DD-MON-YYYY'), 104, TO_DATE('08-OCT-2010','DD-MON-YYYY'));

-- SELECT * FROM RENTAL_HISTORY ORDER BY MEDIA_ID, RENTAL_DATE;

-- INSERT INTO ACTORS
INSERT INTO ACTORS (ACTOR_ID, STAGE_NAME, FIRST_NAME, LAST_NAME, BIRTH_DATE) 
VALUES (ACTORS_SEQ.NEXTVAL, 'Brad Pitt', 'William', 'Pitt', TO_DATE('18-DEC-1963','DD-MON-YYYY'));

INSERT INTO ACTORS 
VALUES (ACTORS_SEQ.NEXTVAL, 'Leonardo DiCaprio', 'Leonardo', 'DiCaprio', TO_DATE('11-NOV-1974','DD-MON-YYYY'));

INSERT INTO ACTORS 
VALUES (ACTORS_SEQ.NEXTVAL, 'Tom Hanks', 'Tom', 'Hanks', TO_DATE('09-JUL-1956','DD-MON-YYYY'));

INSERT INTO ACTORS
VALUES (ACTORS_SEQ.NEXTVAL, 'Christian Bale', 'Christian', 'Bale', TO_DATE('30-JAN-1974','DD-MON-YYYY'));

-- SELECT * FROM ACTORS ORDER BY ACTOR_ID;

-- INSERT INTO STAR_BILLINGS
INSERT INTO STAR_BILLINGS (ACTOR_ID, TITLE_ID, COMMENTS) 
VALUES (1001, 2, 'Supporting Role');

INSERT INTO STAR_BILLINGS (ACTOR_ID, TITLE_ID, COMMENTS) 
VALUES (1002, 4, 'Lead Actor');

INSERT INTO STAR_BILLINGS (ACTOR_ID, TITLE_ID, COMMENTS) 
VALUES (1003, 6, 'Lead Actor');

INSERT INTO STAR_BILLINGS (ACTOR_ID, TITLE_ID, COMMENTS) 
VALUES (1004, 3, 'Villain');

-- SELECT * FROM STAR_BILLINGS ORDER BY ACTOR_ID, TITLE_ID;

-- REQUIREMENT: Create an index on the last_name column of the Customers table.
CREATE INDEX IDX_CUSTOMERS_LAST_NAME ON CUSTOMERS(LAST_NAME);

-- REQUIREMENT: Run a query from the data dictionary for indexes showing this index.
-- SELECT INDEX_NAME, TABLE_NAME, COLUMN_NAME
-- FROM USER_IND_COLUMNS
-- WHERE TABLE_NAME = 'CUSTOMERS' AND COLUMN_NAME = 'LAST_NAME';

-- REQUIREMENT: Create a synonym called TU for the TITLE_UNAVAIL view.
CREATE SYNONYM TU FOR TITLE_UNAVAIL;

-- REQUIREMENT: Run query from the data dictionary for synonyms showing this synonym.
-- SELECT SYNONYM_NAME, TABLE_OWNER, TABLE_NAME
-- FROM USER_SYNONYMS
-- WHERE SYNONYM_NAME = 'TU';

-- REQUIREMENT: Print a SELECT * from the synonym.
-- SELECT * FROM TU;
