PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS users

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

DROP TABLE IF EXISTS questions

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT,
    body TEXT,
    associated_author TEXT,

    FOREIGN KEY (associated_author) REFERENCES users(id)
);

DROP TABLE IF EXISTS question_follows

CREATE TABLE question_follows (
    order INTEGER PRIMARY KEY, 
    question_id INTEGER NOT NULL,
    users_id INTEGER NOT NULL,

    FOREIGN KEY(question_id) REFERENCES questions(id)
    FOREIGN KEY(users_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS replies

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    users_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    replies_id INTEGER,

    FOREIGN KEY(question_id) REFERENCES questions(id)
    FOREIGN KEY(users_id) REFERENCES users(id)
    FOREIGN KEY(replies_id) REFERENCES replies(id)
);

DROP TABLE IF EXISTS question_likes

CREATE TABLE question_likes (
    liked BOOLEAN NOT NULL,
    users_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY(question_id) REFERENCES questions(id)
    FOREIGN KEY(users_id) REFERENCES users(id)
);