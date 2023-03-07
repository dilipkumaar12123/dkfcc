codeally@24b649564de2:~/project$ psql --usernme=freecodecamp --dbname=postgres
/usr/lib/postgresql/12/bin/psql: unrecognized option '--usernme=freecodecamp'
Try "psql --help" for more information.
codeally@24b649564de2:~/project$ psql --username=freecodecamp --dbname=postgres
Border style is 2.
Pager usage is off.
psql (12.9 (Ubuntu 12.9-2.pgdg20.04+1))
Type "help" for help.

postgres=> \c universe;
You are now connected to database "universe" as user "freecodecamp".
universe=> CREATE TABLE galaxy
universe-> (galaxy_id SERIAL PRIMARY KEY,
universe(> name VARCHAR(30) NOT NULL UNIQUE,
universe(> size INT NOT NULL,
universe(> age INT NOT NULL,
universe(> shape VARCHAR(30) NOT NULL,
universe(> spiral BOOLEAN NOT NULL);
CREATE TABLE
universe=> CREATE TABLE star
universe-> (star_id SERIAL PRIMARY KEY,
universe(> name VARCHAR(30) NOT NULL UNIQUE,
universe(> mass NUMERIC NOT NULL,
universe(> temperature INT NOT NULL,
universe(> age INT NOT NULL,
universe(> has_planets BOOLEAN NOT NULL,
universe(> galaxy_id INT NOT NULL REFERENCES galaxy(galaxy_id));
CREATE TABLE
universe=> CREATE TABLE planet
universe-> (planet_id SERIAL PRIMARY KEY,
universe(> name VARCHAR(30) NOT NULL UNIQUE,
universe(> distance NUMERIC NOT NULL,
universe(> 
universe(> gravity INT NOT NULL,
universe(> size INT NOT NULL,
universe(> atmosphere TEXT NOT NULL,
universe(> star_id INT NOT NULL REFERENCES star(star_id));
CREATE TABLE
universe=> CREATE TABLE moon
universe-> (moon_id SERIAL PRIMARY KEY,
universe(> name VARHCAR(30) NOT NULL UNIQUE,
universe(> distance NUMERIC NOT NULL,
universe(> gravity INT NOT NULL,
universe(> size INT NOT NULL,
universe(> atmosphere TEXT NOT NULL,
universe(> is_habitable BOOLEAN NOT NULL,
universe(> planet_id INT NOT NULL REFERENCES planet(planet_id));
ERROR:  type "varhcar" does not exist
LINE 3: name VARHCAR(30) NOT NULL UNIQUE,
             ^
universe=> CREATE TABLE moon
(moon_id SERIAL PRIMARY KEY,
name VARCHAR(30) NOT NULL UNIQUE,
distance NUMERIC NOT NULL,
gravity INT NOT NULL,
size INT NOT NULL,
atmosphere TEXT NOT NULL,
is_habitable BOOLEAN NOT NULL,
planet_id INT NOT NULL REFERENCES planet(planet_id));
CREATE TABLE
universe=> CREATE TABLE extra
universe-> (name VARCHAR(30) UNIQUE NOT NULL,
universe(> catastrophy BOOLEAN NOT NULL,
universe(> type TEXT NOT NULL);
CREATE TABLE
universe=> \d universe;
Did not find any relation named "universe".
universe=> \d
                     List of relations
+--------+----------------------+----------+--------------+
| Schema |         Name         |   Type   |    Owner     |
+--------+----------------------+----------+--------------+
| public | extra                | table    | freecodecamp |
| public | galaxy               | table    | freecodecamp |
| public | galaxy_galaxy_id_seq | sequence | freecodecamp |
| public | moon                 | table    | freecodecamp |
| public | moon_moon_id_seq     | sequence | freecodecamp |
| public | planet               | table    | freecodecamp |
| public | planet_planet_id_seq | sequence | freecodecamp |
| public | star                 | table    | freecodecamp |
| public | star_star_id_seq     | sequence | freecodecamp |
+--------+----------------------+----------+--------------+
(9 rows)

universe=> INSERT INTO galaxy (name, size, age, shape, spiral) VALUES
universe-> ('Milky Way', 100000, 13000, 'Spiral', true),
universe-> ('Andromeda', 150000, 20000, 'Spiral', true),
universe-> ('Whirlpool', 60000, 12500, 'Spiral', true),
universe-> ('Triangulum', 50000, 7000, 'Spiral', true),
universe-> ('Sombrero', 50000, 8000, 'Elliptical', false),
universe-> ('Maffei', 30000, 10000, 'Irregular', false);
INSERT 0 6
universe=> INSERT INTO star (name, mass, temperature, age, has_planets, galaxy_id) VALUES
universe-> ('Sun', 1.989e30, 5778, 4.6, true, 1),
universe-> ('Sirius', 2.02, 9940, 8.6, true, 1),
universe-> ('Alpha Centauri A', 1.1, 5790, 4.8, true, 1),
universe-> ('Proxima Centauri', 0.12, 3042, 4.85, false, 1),
universe-> ('Betegeuse', 20, 3500, 8, false, 1),
universe-> ('Rigel', 17.5, 12100, 7.5, false, 1);
INSERT 0 6
universe=> INSERT INTO planet (name, distance, gravity, size, atmosphere, star_id) VALUES
universe-> ('Mercury', 0.39, 3.7, 4879, 'Thin', 1),
universe-> ('Venus', 0.72, 8.87, 12104, 'Thick', 1),
universe-> 
universe-> ('Earth
universe'> ', 1, 9.8, 12756, 'Brethable', 1),
universe-> ('Mars', 1.5, 3.71, 6792, 'Thin', 1),
universe-> ('Jupiter', 5.2, 24.79, 142984, 'Gas', 1),
universe-> ('Saturn', 9.5, 10.44, 120536, 'Gas', 1),
universe-> ('Uranus', 19.2, 8.87, 51118, 'Ice', 1),
universe-> ('Pluto', 39.5, 0.62, 2370, 'Thin', 1),
universe-> ('Kepler-452b', 1402.7, 3.7, 20000, 'Thin', 2),
universe-> ('Proxima Centauri b', 0.05, 0.98, 20000, 'Breathable',4),
universe-> ('Titan', 0.038, 7.64, 20000, 'Gas', 2);
INSERT 0 11
universe=> INSERT INTO moon (name, distance, gravity, size, atmosphere, is_habitable, planet_id) VALUES
universe-> ('Moon', 0.00257, 1.62, 3457, 'Thin', false, 3),
universe-> ('Phobos', 9378, 0.0057, 22.2, 'Thin', false, 4),
universe-> ('Deimos', 23460, 0.003, 12.4, 'Thin', false, 4),
universe-> ('Ganymede', 1070, 1.42, 5268, 'Thin', false, 5),
universe-> 
universe-> ('Callisto', 1883, 1.23, 4821, 'Thin', false, 5),
universe-> ('Europa', 670, 1.31, 3122, 'Thin', true, 6),
universe-> ('Titan, 1221, 1.35, 5150, 'Thick', true, 6),
universe'> ('Enceladus', 238, 0.11, 500, "Thin', true, 6),
universe-> ('Mimas',185, 0.06, 400, 'false', 6),                                    universe-> ('Ariel', 191, 1.1, 1158, 'Thin', false, 7),
universe-> ('Miranda', 129, 0.079, 472, 'Thin', false, 7),
universe-> ('Titania', 435, 0.38, 1578, 'Thin', false, 8),
universe-> ('Oberon', 584, 0.35, 1523, 'Thin', false, 8),
universe-> ('Triton', 354, 0.78, 2705, 'Thin', true, 9),
universe-> ('Charon', 19751, 0.278, 1208, 'Thin', false, 10),
universe-> ('Titanias', 435, 0.38, 1578, 'Thin', false, 11),
universe-> 
universe-> ('Oberoni', 584, 0.35, 1523, 'Thin', false, 11),
universe-> ('Tritonia', 354, 0.78, 2705, 'Thin', true, 12),
universe-> ('Charoni', 19572, 0.278, 1208, 'Thin', false, 13));
ERROR:  syntax error at or near "Thick"
LINE 8: ('Titan, 1221, 1.35, 5150, 'Thick', true, 6),
                                    ^
universe=> INSERT INTO moon (name, distance, gravity, size, atmosphere, is_habitable, planet_id) VALUES
('Moon', 0.00257, 1.62, 3457, 'Thin', false, 3),
('Phobos', 9378, 0.0057, 22.2, 'Thin', false, 4),
('Deimos', 23460, 0.003, 12.4, 'Thin', false, 4),
('Ganymede', 1070, 1.42, 5268, 'Thin', false, 5),
('Callisto', 1883, 1.23, 4821, 'Thin', false, 5),
('Europa', 670, 1.31, 3122, 'Thin', true, 6),
('Titan', 1221, 1.35, 5150, 'Thick', true, 6),
('Enceladus', 238, 0.11, 500, 'Thin', true, 6),
('Mimas',185, 0.06, 400, 'false', 6),
('Ariel', 191, 1.1, 1158, 'Thin', false, 7),
('Miranda', 129, 0.079, 472, 'Thin', false, 7),
('Titania', 435, 0.38, 1578, 'Thin', false, 8),
('Oberon', 584, 0.35, 1523, 'Thin', false, 8),
('Triton', 354, 0.78, 2705, 'Thin', true, 9),
('Charon', 19751, 0.278, 1208, 'Thin', false, 10),
('Titanias', 435, 0.38, 1578, 'Thin', false, 11),
('Oberoni', 584, 0.35, 1523, 'Thin', false, 11),
('Tritonia', 354, 0.78, 2705, 'Thin', true, 12),
('Charoni', 19572, 0.278, 1208, 'Thin', false, 13));
ERROR:  syntax error at or near ")"
LINE 20: ('Charoni', 19572, 0.278, 1208, 'Thin', false, 13));
                                                           ^
universe=> INSERT INTO moon (name, distance, gravity, size, atmosphere, is_habitable, planet_id) VALUES
('Moon', 0.00257, 1.62, 3457, 'Thin', false, 3),
('Phobos', 9378, 0.0057, 22.2, 'Thin', false, 4),
('Deimos', 23460, 0.003, 12.4, 'Thin', false, 4),
('Ganymede', 1070, 1.42, 5268, 'Thin', false, 5),
('Callisto', 1883, 1.23, 4821, 'Thin', false, 5),
('Europa', 670, 1.31, 3122, 'Thin', true, 6),
('Titan', 1221, 1.35, 5150, 'Thick', true, 6),
('Enceladus', 238, 0.11, 500, 'Thin', true, 6),
('Mimas',185, 0.06, 400, 'false', 6),
('Ariel', 191, 1.1, 1158, 'Thin', false, 7),
('Miranda', 129, 0.079, 472, 'Thin', false, 7),
('Titania', 435, 0.38, 1578, 'Thin', false, 8),
('Oberon', 584, 0.35, 1523, 'Thin', false, 8),
('Triton', 354, 0.78, 2705, 'Thin', true, 9),
('Charon', 19751, 0.278, 1208, 'Thin', false, 10),
('Titanias', 435, 0.38, 1578, 'Thin', false, 11),
('Oberoni', 584, 0.35, 1523, 'Thin', false, 11),
('Tritonia', 354, 0.78, 2705, 'Thin', true, 12),
('Charoni', 19572, 0.278, 1208, 'Thin', false, 13);
ERROR:  VALUES lists must all be the same length
LINE 10: ('Mimas',185, 0.06, 400, 'false', 6),
          ^
universe=> INSERT INTO moon (name, distance, gravity, size, atmosphere, is_habitable, planet_id) VALUES
('Moon', 0.00257, 1.62, 3457, 'Thin', false, 3),
('Phobos', 9378, 0.0057, 22.2, 'Thin', false, 4),
('Deimos', 23460, 0.003, 12.4, 'Thin', false, 4),
('Ganymede', 1070, 1.42, 5268, 'Thin', false, 5),
('Callisto', 1883, 1.23, 4821, 'Thin', false, 5),
('Europa', 670, 1.31, 3122, 'Thin', true, 6),
('Titan', 1221, 1.35, 5150, 'Thick', true, 6),
('Enceladus', 238, 0.11, 500, 'Thin', true, 6),
('Mimas', 185, 0.06, 400, 'Thin', false, 6),
('Ariel', 191, 1.1, 1158, 'Thin', false, 7),
('Miranda', 129, 0.079, 472, 'Thin', false, 7),
('Titania', 435, 0.38, 1578, 'Thin', false, 8),
('Oberon', 584, 0.35, 1523, 'Thin', false, 8),
('Triton', 354, 0.78, 2705, 'Thin', true, 9),
('Charon', 19751, 0.278, 1208, 'Thin', false, 10),
('Titanias', 435, 0.38, 1578, 'Thin', false, 11),
('Oberoni', 584, 0.35, 1523, 'Thin', false, 11),
('Tritonia', 354, 0.78, 2705, 'Thin', true, 12),
('Charoni', 19572, 0.278, 1208, 'Thin', false, 13);
ERROR:  insert or update on table "moon" violates foreign key constraint "moon_planet_id_fkey"
DETAIL:  Key (planet_id)=(12) is not present in table "planet".
universe=> INSERT INTO moon (name, distance, gravity, size, atmosphere, is_habitable, planet_id) VALUES
('Moon', 0.00257, 1.62, 3457, 'Thin', false, 3),
('Phobos', 9378, 0.0057, 22.2, 'Thin', false, 4),
('Deimos', 23460, 0.003, 12.4, 'Thin', false, 4),
('Ganymede', 1070, 1.42, 5268, 'Thin', false, 5),
('Callisto', 1883, 1.23, 4821, 'Thin', false, 5),
('Europa', 670, 1.31, 3122, 'Thin', true, 6),
('Titan', 1221, 1.35, 5150, 'Thick', true, 6),
('Enceladus', 238, 0.11, 500, 'Thin', true, 6),
('Mimas', 185, 0.06, 400, 'Thin', false, 6),
('Ariel', 191, 1.1, 1158, 'Thin', false, 7),
('Miranda', 129, 0.079, 472, 'Thin', false, 7),
('Titania', 435, 0.38, 1578, 'Thin', false, 8),
('Oberon', 584, 0.35, 1523, 'Thin', false, 8),
('Triton', 354, 0.78, 2705, 'Thin', true, 9),
('Charon', 19751, 0.278, 1208, 'Thin', false, 10),
('Titanias', 435, 0.38, 1578, 'Thin', false, 10),
('Oberoni', 584, 0.35, 1523, 'Thin', false, 10),
('Tritonia', 354, 0.78, 2705, 'Thin', true, 10),
('Charoni', 19572, 0.278, 1208, 'Thin', false, 10);
INSERT 0 19
universe=> INSERT INTO planet (name, distance, gravity, size, atmosphere, star_id) VALUES ('Fantastic', 1503.6, 4.3, 25000, 'Thin', 2);
INSERT 0 1
universe=> INSERT INTO moon (name, distance, gravity, size, atmosphere, is_habitable, planet_id) VALUES ('Fanta', 129, 0.079, 472, 'Thin', false, 7);
INSERT 0 1
universe=> \d
                     List of relations
+--------+----------------------+----------+--------------+
| Schema |         Name         |   Type   |    Owner     |
+--------+----------------------+----------+--------------+
| public | extra                | table    | freecodecamp |
| public | galaxy               | table    | freecodecamp |
| public | galaxy_galaxy_id_seq | sequence | freecodecamp |
| public | moon                 | table    | freecodecamp |
| public | moon_moon_id_seq     | sequence | freecodecamp |
| public | planet               | table    | freecodecamp |
| public | planet_planet_id_seq | sequence | freecodecamp |
| public | star                 | table    | freecodecamp |
| public | star_star_id_seq     | sequence | freecodecamp |
+--------+----------------------+----------+--------------+
(9 rows)

universe=> \d extra;
                          Table "public.extra"
+-------------+-----------------------+-----------+----------+---------+
|   Column    |         Type          | Collation | Nullable | Default |
+-------------+-----------------------+-----------+----------+---------+
| name        | character varying(30) |           | not null |         |
| catastrophy | boolean               |           | not null |         |
| type        | text                  |           | not null |         |
+-------------+-----------------------+-----------+----------+---------+
Indexes:
    "extra_name_key" UNIQUE CONSTRAINT, btree (name)

universe=> ALTER TABLE extra RENAME COLUMN catastrophy TO harm;
ALTER TABLE
universe=> INSERT INTO extra (name, harm, type) VALUES
universe-> ('Black hole', true, 'Gravity'),
universe-> ('Gamma ray', true, 'Gamma waves'),
universe-> ('Death star', true, 'Explosion');
INSERT 0 3
universe=> ALTER TABLE extra ADD COLUMN extra_id SERIAL PRIMARY KEY;
ALTER TABLE
