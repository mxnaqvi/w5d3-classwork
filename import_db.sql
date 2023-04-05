PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    associated_author INTEGER NOT NULL,

    FOREIGN KEY (associated_author) REFERENCES users(id)
);


CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

CREATE TABLE question_follows (
    id INTEGER PRIMARY KEY, 
    question_id INTEGER NOT NULL,
    users_id INTEGER NOT NULL,

    FOREIGN KEY(question_id) REFERENCES questions(id)
    FOREIGN KEY(users_id) REFERENCES users(id)
);



CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    users_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    replies_id INTEGER,

    FOREIGN KEY(question_id) REFERENCES questions(id)
    FOREIGN KEY(users_id) REFERENCES users(id)
    FOREIGN KEY(replies_id) REFERENCES replies(id)
);


CREATE TABLE question_likes (
    liked TEXT NOT NULL,
    users_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY(question_id) REFERENCES questions(id)
    FOREIGN KEY(users_id) REFERENCES users(id)
);

INSERT INTO
    users (id, fname, lname)
VALUES 
(1, 'gigachad', 'fart');

INSERT INTO
    questions (id, title, body, associated_author)
VALUES 
(1, 'why hello', 'what does hello mean', 1 );