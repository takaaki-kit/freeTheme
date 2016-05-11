CREATE TABLE IF NOT EXISTS user (
    id           INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id      VARCHAR(255),
    name         VARCHAR(255),
    password     VARCHAR(255)
);


CREATE TABLE IF NOT EXISTS request (
    id           INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    inviter      VARCHAR(255),
    invitee      VARCHAR(255),
    purpose      VARCHAR(255),
    estimated_time INTEGER
);
