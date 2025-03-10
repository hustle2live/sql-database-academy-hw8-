CREATE database movies;

\connect movies;

CREATE TABLE user (
    id SERIAL PRIMARY KEY,
    username VARCHAR(20),
    first_name VARCHAR(20),
    second_name VARCHAR(20),
    email VARCHAR(100) NOT NULL,
    password VARCHAR(20) NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE file (
    id SERIAL PRIMARY KEY,
    filename VARCHAR(50) NOT NULL,
    mime_type VARCHAR(50),
    key VARCHAR(50),
    public_url VARCHAR(150) NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE countries (
    id SERIAL PRIMARY KEY,
    code NUMERIC NOT NULL,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE movie (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description VARCHAR(500),
    budget MONEY,
    release_date DATE,
    duration NUMERIC,
    country_id INTEGER,
    FOREIGN KEY (country_id) REFERENCES countries (id),
    poster_id INTEGER,
    FOREIGN KEY (poster_id) REFERENCES file (id),
    producer VARCHAR(50) NOT NULL,
    genres VARCHAR(150),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TYPE genders AS ENUM ('male', 'female', 'nonbinary');

CREATE TABLE person (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    biography VARCHAR,
    birth_date DATE NOT NULL,
    gender genders,
    country_id INTEGER,
    FOREIGN KEY (country_id) REFERENCES countries (id),
    picture INTEGER,
    FOREIGN KEY (picture) REFERENCES file (id),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TYPE movie_role AS ENUM ('leading', 'supporting', 'background');

CREATE TABLE character (
    id SERIAL PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    description VARCHAR(150),
    role movie_role NOT NULL,
    movie_id INTEGER NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES movie (id),
    person_id INTEGER,
    FOREIGN KEY (person_id) REFERENCES person (id),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE favourite_movies (
    user_id INTEGER NOT NULL,
    movie_id INTEGER,
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (user_id) REFERENCES "user" (id),
    FOREIGN KEY (movie_id) REFERENCES movie (id)
);

CREATE TABLE avatar (
    user_id INTEGER NOT NULL,
    file_id INTEGER,
    PRIMARY KEY (user_id, file_id),
    FOREIGN KEY (user_Id) REFERENCES "user" (id),
    FOREIGN KEY (file_Id) REFERENCES file (id)
);

CREATE TABLE gallery (
    person_id INTEGER NOT NULL,
    file_id INTEGER,
    PRIMARY KEY (person_id, file_id),
    FOREIGN KEY (person_id) REFERENCES person (id),
    FOREIGN KEY (file_id) REFERENCES file (id)
);

CREATE TABLE movie_actors (
    person_id INTEGER,
    movie_id INTEGER,
    PRIMARY KEY (person_id, movie_id),
    FOREIGN KEY (person_id) REFERENCES person (id),
    FOREIGN KEY (movie_id) REFERENCES movie (id)
);

CREATE TABLE movie_characters (
    character_id INTEGER,
    movie_id INTEGER,
    PRIMARY KEY (character_id, movie_id),
    FOREIGN KEY (character_id) REFERENCES character (id),
    FOREIGN KEY (movie_id) REFERENCES movie (id)
);