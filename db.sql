-- CREATE database movies_db;

-- \connect movies_db;


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
    image_id INTEGER REFERENCES file(id),
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
    photo_id INTEGER REFERENCES file(id),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP
);

CREATE TABLE movie (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) UNIQUE NOT NULL,
    poster_id INTEGER REFERENCES file(id),
    about TEXT,
    budget INTEGER,
    released DATE NOT NULL,
    time_length INTERVAL NOT NULL,
    director_id INTEGER REFERENCES person(id),
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
    person_id INTEGER REFERENCES person(id),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP
);

CREATE TABLE movie_characters (
    movie_id INTEGER REFERENCES movie(id),
    actor_id INTEGER REFERENCES person(id),
    character_id INTEGER REFERENCES character(id),
    PRIMARY KEY (movie_id, actor_id, character_id)
);

CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE person_gallery (
    person_id INTEGER REFERENCES person(id) ON DELETE CASCADE,
    picture_id INTEGER REFERENCES file(id) ON DELETE CASCADE,
    PRIMARY KEY (person_id, picture_id)
);

CREATE TABLE favorites (
    user_id INTEGER REFERENCES "user"(id) ON DELETE CASCADE,
    movie_id INTEGER REFERENCES movie(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, movie_id)
);

CREATE TABLE movie_genre (
    movie_id INTEGER REFERENCES movie(id) ON DELETE CASCADE,
    genre_id INTEGER REFERENCES genres(id) ON DELETE CASCADE,
    PRIMARY KEY (movie_id, genre_id)
);


-- Складання кількох зовнішніх ключів в одних таблицях:
-- Для таблиць типу movie_characters та movie_genre, де ви створюєте зв'язки між кількома таблицями, все в порядку, але зазвичай ці зв'язки також потребують індексації для підвищення продуктивності запитів.

-- Наприклад, ви можете додати індекси для цих таблиць, щоб покращити продуктивність пошуку за зовнішніми ключами:

CREATE INDEX idx_movie_characters_movie_id ON movie_characters (movie_id);
CREATE INDEX idx_movie_characters_actor_id ON movie_characters (actor_id);
CREATE INDEX idx_movie_genre_movie_id ON movie_genre (movie_id);
CREATE INDEX idx_movie_genre_genre_id ON movie_genre (genre_id);