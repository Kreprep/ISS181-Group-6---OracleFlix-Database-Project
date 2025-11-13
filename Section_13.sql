-- 1. CUSTOMERS Table
CREATE TABLE customers (
    customer_id NUMBER(10),
    last_name VARCHAR2(25),
    first_name VARCHAR2(25),
    home_phone VARCHAR2(12),
    address VARCHAR2(100),
    city VARCHAR2(30),
    state VARCHAR2(2),
    email VARCHAR2(25),
    cell_phone VARCHAR2(12)
);

-- 2. MOVIES Table
CREATE TABLE movies (
    title_id NUMBER(10),
    title VARCHAR2(60),
    description VARCHAR2(400),
    rating VARCHAR2(4),
    category VARCHAR2(20),
    release_date DATE
);

-- 3. MEDIA Table
CREATE TABLE media (
    media_id NUMBER(10),
    format VARCHAR2(3),
    title_id NUMBER(10) 
);

-- 4. RENTAL_HISTORY Table
CREATE TABLE rental_history (
    media_id NUMBER(10),
    rental_date DATE DEFAULT SYSDATE,
    customer_id NUMBER(10),
    return_date DATE
);

-- 5. ACTORS 
CREATE TABLE actors (
    actor_id NUMBER(10),
    stage_name VARCHAR2(40),
    first_name VARCHAR2(25),
    last_name VARCHAR2(25),
    birth_date DATE
);

-- 6. STAR_BILLINGS Table
CREATE TABLE star_billings (
    actor_id NUMBER(10),
    title_id NUMBER(10),
    comments VARCHAR2(40)
);

-- "Run a DESC command for each table."
DESC CUSTOMERS;
DESC MOVIES;
DESC MEDIA;
DESC RENTAL_HISTORY;
DESC ACTORS;
DESC STAR_BILLINGS;
