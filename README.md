
``` mermaid

---
title: Database erDiagram
---
    erDiagram

user {
    id SERIAL PRIMARY KEY
    user_name
    firstname
    lastname
    email
    password
}

file {
    id INT PRIMARY KEY
    file_name VARCHAR()
    mime_type VARCHAR()
    bucket_id INT FOREIGN KEY
    url_link VARCHAR()
}

avatar {
    file_id INT FOREIGN KEY
    user_id INT FOREIGN KEY
}

movie {
    title VARCHAR(150)
    description TEXT
    budget NUMERIC
    release_date DATE
    time_duration NUMERIC
    director FOREIGN KEY person
    country FOREIGN KEY countries
    poster FOREIGN KEY file
    genres FOREIGN KEY file
}

character {
    name VARCHAR()
    description TEXT
    role VARCHAR()
}

person {
    firstname
    lastname
    biography
    birth_date
    gender
}

favorites {

}

genres {

}

    person ||--o| gallery : photos
    person }|--|{ movie : movieId
    character }|--|{ movie : movieId
    character }|--o{ person : isPerson




```