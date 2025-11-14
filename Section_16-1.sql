-- "Create the following sequences to be used for primary key values:""

-- CUSTOMERS table
CREATE SEQUENCE customers_seq
    START WITH 101
    INCREMENT BY 1;

-- MOVIES table
CREATE SEQUENCE movies_seq
    START WITH 1
    INCREMENT BY 1;

-- MEDIA table
CREATE SEQUENCE media_seq
    START WITH 92
    INCREMENT BY 1;

-- ACTORS table
CREATE SEQUENCE actors_seq
    START WITH 1001
    INCREMENT BY 1;

-- "Run queries from the data dictionaries for the above sequences."
SELECT sequence_name, min_value, max_value, increment_by, last_number
FROM user_sequences;
