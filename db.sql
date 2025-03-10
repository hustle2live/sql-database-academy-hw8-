CREATE TABLE user (
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


CREATE TABLE file {
    id SERIAL PRIMARY KEY,
    file_name VARCHAR(255) UNIQUE,
    mime_type VARCHAR(150),
    bucket_id INTEGER,
    url_link VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP
};

CREATE TABLE movie {
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) UNIQUE NOT NULL,
    poster_id UUID REFERENCES file(id),
    about TEXT,
    budget INTEGER,
    released DATE NOT NULL,
    time_length INTERVAL NOT NULL,
    director_id UUID REFERENCES person(id),
    country_id VARCHAR REFERENCES countries(id),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP
};

CREATE TYPE actor_role AS ENUM ('leading', 'supporting', 'background');

CREATE TABLE character {
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    role actor_role,
    person_id UUID REFERENCES person(id),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP
}

CREATE TABLE movie_characters {
    movie_id UUID REFERENCES movie(id),
    actor_id UUID REFERENCES person(id),
    character_id UUID REFERENCES character(id),
    PRIMARY KEY (movie_id, actor_id, character_id)
};

CREATE TYPE gender_name AS ENUM ('male', 'female');

CREATE TABLE person {
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    biography TEXT,
    birth_date DATE NOT NULL,
    gender gender_name,
    country_id UUID REFERENCES countries(id),
    photo_id UUID REFERENCES file(id),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP
};

CREATE TABLE genres {
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
};

CREATE TABLE person_gallery {
    person_id UUID REFERENCES person(id) ON DELETE CASCADE,
    picture_id UUID REFERENCES file(id) ON DELETE CASCADE,
    PRIMARY KEY (person_id, picture_id)
};

CREATE TABLE favorites {
    user_id UUID REFERENCES user(id) ON DELETE CASCADE,
    movie_id UUID REFERENCES movie(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, movie_id)
};

CREATE TABLE movie_genre {
    movie_id UUID REFERENCES movie(id) ON DELETE CASCADE,
    genre_id UUID REFERENCES genres(id) ON DELETE CASCADE,
    PRIMARY KEY (movie_id, genres_id)
};