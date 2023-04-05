PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS replies;
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
    body TEXT NOT NULL,
    replies_id INTEGER,

    FOREIGN KEY(question_id) REFERENCES questions(id)
    FOREIGN KEY(users_id) REFERENCES users(id)
    FOREIGN KEY(replies_id) REFERENCES replies(id)
);


CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    liked BOOLEAN NOT NULL,
    users_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY(question_id) REFERENCES questions(id)
    FOREIGN KEY(users_id) REFERENCES users(id)
);

INSERT INTO
    users (id, fname, lname)
VALUES 
    (1, 'Gigachad', 'Fart'), 
    (2, 'Harry', 'Bolzack'), 
    (3, 'Ramen', 'Baba'), 
    (4, 'Ben', 'Dover');

INSERT INTO
    questions (id, title, body, associated_author)
VALUES 
    (1, 'why hello', 'what does hello mean', 1 ),
    (2, 'shave?', 'should I shave', 2),
    (3, 'cook', 'how to cook my ramen', 3),
    (4, 'stretch', 'how do I become more flexible', 4);

INSERT INTO 
    question_follows (id, question_id, users_id)
VALUES
    (1, 1, 1), 
    (2, 2, 2), 
    (3, 3, 3), 
    (4, 4, 4);

INSERT INTO
    question_likes (id, liked, users_id, question_id)
VALUES
    (1, true, 1, 4), 
    (2, true, 3, 1), 
    (3, true, 4, 2);

    INSERT INTO 
    replies (id, users_id, question_id, body, replies_id)
VALUES
    (1, 2, 1, 'it means hi', NULL),
    (2, 3, 1, 'no, it means more ramen please', 1),
    (3, 4, 2, 'never', NULL),
    (4, 1, 2, 'agreed', 3);
