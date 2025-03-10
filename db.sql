CREATE TABLE file (
    id SERIAL PRIMARY KEY,
    file_name VARCHAR(255) UNIQUE,
    mime_type VARCHAR(150),
    bucket_id INTEGER,
    url_link VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP
);

CREATE TABLE "user" (
    id SERIAL PRIMARY KEY,
    user_name VARCHAR(50) UNIQUE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(100) NOT NULL,
    image_id INT REFERENCES file(id),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP
);

CREATE TABLE countries (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL
);

CREATE TYPE gender_name AS ENUM ('male', 'female');

CREATE TABLE person (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    biography TEXT,
    birth_date DATE NOT NULL,
    gender gender_name,
    country_name VARCHAR REFERENCES countries(name),
    photo_id INT REFERENCES file(id),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP
);

CREATE TABLE movie (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) UNIQUE NOT NULL,
    poster_id INT REFERENCES file(id),
    about TEXT,
    budget INTEGER,
    released DATE NOT NULL,
    time_length INTERVAL NOT NULL,
    director_id INT REFERENCES person(id),
    country_name VARCHAR REFERENCES countries(name),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP
);

CREATE TYPE actor_role AS ENUM ('leading', 'supporting', 'background');

CREATE TABLE character (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    role actor_role,
    person_id INT REFERENCES person(id),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP
);

CREATE TABLE movie_characters (
    movie_id INT REFERENCES movie(id),
    actor_id INT REFERENCES person(id),
    character_id INT REFERENCES character(id),
    PRIMARY KEY (movie_id, actor_id, character_id)
);

CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE person_gallery (
    person_id INT REFERENCES person(id) ON DELETE CASCADE,
    picture_id INT REFERENCES file(id) ON DELETE CASCADE,
    PRIMARY KEY (person_id, picture_id)
);

CREATE TABLE favorites (
    user_id INT REFERENCES "user"(id) ON DELETE CASCADE,
    movie_id INT REFERENCES movie(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, movie_id)
);

CREATE TABLE movie_genre (
    movie_id INT REFERENCES movie(id) ON DELETE CASCADE,
    genre_id INT REFERENCES genres(id) ON DELETE CASCADE,
    PRIMARY KEY (movie_id, genre_id)
);