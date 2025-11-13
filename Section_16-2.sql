-- INSERT TO CUSTOMERS
-- "Sample Data – Make up at least 6 members, using the sequence to generate the PKs:"
INSERT INTO customers (customer_id, last_name, first_name, home_phone, address, city, state, email, cell_phone) 
VALUES (customers_seq.NEXTVAL, 'Palombo', 'Lisa', '716-270-2669', '123 Main St', 'Buffalo', 'NY', 'palombo@ecc.edu', '716-555-1212');

INSERT INTO customers (customer_id, last_name, first_name, home_phone, address, city, state, email, cell_phone)
VALUES (customers_seq.NEXTVAL, 'Anderson', 'James', '213-234-5678', '123 Maple Street', 'Los Angeles', 'CA', 'james.anderson@email.com', '310-987-6543');

INSERT INTO customers (customer_id, last_name, first_name, home_phone, address, city, state, email, cell_phone)
VALUES (customers_seq.NEXTVAL, 'Martinez', 'Sofia', '512-345-6789', '456 Oak Avenue', 'Austin', 'TX', 'sofia.martinez@email.com', '737-876-5432');

INSERT INTO customers (customer_id, last_name, first_name, home_phone, address, city, state, email, cell_phone)
VALUES (customers_seq.NEXTVAL, 'Chen', 'Michael', '206-456-7890', '789 Pine Road', 'Seattle', 'WA', 'michael.chen@email.com', '425-765-4321');

INSERT INTO customers (customer_id, last_name, first_name, home_phone, address, city, state, email, cell_phone)
VALUES (customers_seq.NEXTVAL, 'Thompson', 'Emily', '305-567-8901', '321 Birch Lane', 'Miami', 'FL', 'emily.thompson@email.com', '786-654-3210');

INSERT INTO customers (customer_id, last_name, first_name, home_phone, address, city, state, email, cell_phone)
VALUES (customers_seq.NEXTVAL, 'Patel', 'Raj', '312-678-9012', '654 Cedar Drive', 'Chicago', 'IL', 'raj.patel@email.com', '773-543-2109');

INSERT INTO customers (customer_id, last_name, first_name, home_phone, address, city, state, email, cell_phone)
VALUES (customers_seq.NEXTVAL, 'Williams', 'Sarah', '617-789-0123', '987 Elm Boulevard', 'Boston', 'MA', 'sarah.williams@email.com', '857-432-1098');

SELECT * FROM customers
ORDER BY customer_id;

-- INSERT INTO MOVIES
-- "Sample Data – Add at least 6 titles, use www.imdb.com for information and the sequence for the PKs:""

INSERT INTO movies (title_id, title, description, rating, category, release_date)
VALUES (movies_seq.NEXTVAL, 'Remember the Titans', 'PG', 'DRAMA', '29-SEP-2000');







-- INSERT INTO MEDIA
-- "Sample Data : Use TITLE_ID from the MOVIES table, with one or two copies of each title, using the sequence to generate the PKs:"

INSERT INTO media (media_id, format, title_id)
VALUES (media_seq.NEXTVAL, 'DVD', 1);

INSERT INTO media (media_id, format, title_id)
VALUES (media_seq.NEXTVAL, 'VHS', 1);







-- INSERT INTO RENTAL_HISTORY
-- "Sample Data – Add 4 rows using MEDIA_ID from the MEDIA table and CUSTOMER_ID from the CUSTOMER table:"

INSERT INTO rental_history (media_id, rental_date, customer_id, return_date)
VALUES (92, '19-SEP-2010', '101', '20-SEP-2010');







-- INSERT INTO ACTORS
-- "Sample Data : add at least 4 rows, using the sequence to generate the PKs :"

INSERT INTO actors (actor_id, stage_name, first_name, last_name, birth_date)
VALUES (actors_seq.NEXTVAL, 'Brad Pitt', 'William', 'Pitt', '18-DEC-1963');







-- INSERT INTO STAR_BILLINGS
-- "Sample Data : add at least 4 rows, using ACTOR_IDs from the ACTORS table and TITLE_IDs from the MOVIES table :"

INSERT INTO star_billings (actor_id, title_id, comments)
VALUES (1001, 2, 'Romantic Lead');






