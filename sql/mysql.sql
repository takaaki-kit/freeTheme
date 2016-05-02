CREATE TABLE IF NOT EXISTS user (
    id           INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id      VARCHAR(255),
    name         VARCHAR(255),
    password     VARCHAR(255)
);
