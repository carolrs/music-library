TRUNCATE TABLE artists RESTART IDENTITY;
TRUNCATE TABLE albums RESTART IDENTITY; 

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
INSERT INTO artists (name, genre) VALUES ('Guns n Roses', 'Rock');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Patience', '1988', '1');
INSERT INTO albums (title, release_year, artist_id) VALUES (' Dont Cry', '1991', '1');
