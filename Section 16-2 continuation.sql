INSERT INTO movies (title_id, title, description, rating, category, release_date)
VALUES (movies_seq.NEXTVAL, 'Remember the Titans', 'High school football integration drama', 'PG', 'DRAMA', TO_DATE('29-SEP-2000','DD-MON-YYYY'));

INSERT INTO movies VALUES (movies_seq.NEXTVAL, 'Inception', 'A thief steals secrets through dreams', 'PG-13', 'SCI-FI', TO_DATE('16-JUL-2010','DD-MON-YYYY'));

INSERT INTO movies VALUES (movies_seq.NEXTVAL, 'The Dark Knight', 'Batman battles the Joker', 'PG-13', 'ACTION', TO_DATE('18-JUL-2008','DD-MON-YYYY'));

INSERT INTO movies VALUES (movies_seq.NEXTVAL, 'Titanic', 'Romance and tragedy aboard the RMS Titanic', 'PG-13', 'DRAMA', TO_DATE('19-DEC-1997','DD-MON-YYYY'));

INSERT INTO movies VALUES (movies_seq.NEXTVAL, 'The Matrix', 'A hacker learns the truth about reality', 'R', 'SCI-FI', TO_DATE('31-MAR-1999','DD-MON-YYYY'));

INSERT INTO movies VALUES (movies_seq.NEXTVAL, 'Forrest Gump', 'Life story of Forrest Gump', 'PG-13', 'DRAMA', TO_DATE('06-JUL-1994','DD-MON-YYYY'));


INSERT INTO rental_history (media_id, rental_date, customer_id, return_date)
VALUES (92, TO_DATE('19-SEP-2010','DD-MON-YYYY'), 101, TO_DATE('20-SEP-2010','DD-MON-YYYY'));

INSERT INTO rental_history VALUES (93, TO_DATE('20-SEP-2010','DD-MON-YYYY'), 102, TO_DATE('22-SEP-2010','DD-MON-YYYY'));

INSERT INTO rental_history VALUES (94, TO_DATE('01-OCT-2010','DD-MON-YYYY'), 103, TO_DATE('03-OCT-2010','DD-MON-YYYY'));

INSERT INTO rental_history VALUES (95, TO_DATE('05-OCT-2010','DD-MON-YYYY'), 104, TO_DATE('08-OCT-2010','DD-MON-YYYY'));


INSERT INTO actors (actor_id, stage_name, first_name, last_name, birth_date)
VALUES (actors_seq.NEXTVAL, 'Brad Pitt', 'William', 'Pitt', TO_DATE('18-DEC-1963','DD-MON-YYYY'));

INSERT INTO actors VALUES (actors_seq.NEXTVAL, 'Leonardo DiCaprio', 'Leonardo', 'DiCaprio', TO_DATE('11-NOV-1974','DD-MON-YYYY'));

INSERT INTO actors VALUES (actors_seq.NEXTVAL, 'Tom Hanks', 'Tom', 'Hanks', TO_DATE('09-JUL-1956','DD-MON-YYYY'));

INSERT INTO actors VALUES (actors_seq.NEXTVAL, 'Christian Bale', 'Christian', 'Bale', TO_DATE('30-JAN-1974','DD-MON-YYYY'));

INSERT INTO star_billings (actor_id, title_id, comments) VALUES (1001, 2, 'Supporting Role');
INSERT INTO star_billings VALUES (1002, 4, 'Lead Actor');
INSERT INTO star_billings VALUES (1003, 6, 'Lead Actor');
INSERT INTO star_billings VALUES (1004, 3, 'Villain');
