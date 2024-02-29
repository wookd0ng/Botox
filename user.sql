create database botox;
use botox;

drop table user;
CREATE TABLE user (
    user_id VARCHAR(20) PRIMARY KEY NOT NULL,
    user_pw VARCHAR(20) NOT NULL,
    user_profilepic BLOB,
    user_carrot_temperature VARCHAR(20),
    user_nickname VARCHAR(20),
    user_connection BOOLEAN,
    user_report INT,
    CONSTRAINT chk_carrot_temp CHECK (user_carrot_temperature IN ('cool', 'warm', 'hot'))
);

drop table friend;
CREATE TABLE friend (
    user_id VARCHAR(20) REFERENCES user(user_id),
    friend_id VARCHAR(20) REFERENCES user(user_id),
    friend_request BOOLEAN,
    friend_connection BOOLEAN,
    foreign key (user_id) references user(user_id)
);

drop table room;
CREATE TABLE room (
    room_num INT PRIMARY KEY NOT NULL,
    room_type VARCHAR(20),
    room_capacity_limit INT,
    room_lock_state BOOLEAN,
    room_title VARCHAR(100),
    game_name VARCHAR(20) REFERENCES game(game_name),
    game_user_count INT,
    user_id VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN key (game_name) references game(game_name),
    CONSTRAINT chk_room_type CHECK (room_type IN ('chat', 'voice'))
);

drop table game;
CREATE TABLE game (
    game_name VARCHAR(20) PRIMARY KEY,
    game_user_count INT
);

drop table report;
CREATE TABLE report (
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    report_date DATE,
    reporting_user_id VARCHAR(20),
    reported_user_id VARCHAR(20),
    FOREIGN KEY (reporting_user_id) REFERENCES user(user_id),
    FOREIGN KEY (reported_user_id) REFERENCES user(user_id),
    feedback_result VARCHAR(100),
    reason_for_report TEXT,
    report_type VARCHAR(50),
    processing_status VARCHAR(50),
    additional_info TEXT
);


drop table post;
CREATE TABLE post (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    author_id VARCHAR(20) REFERENCES user(user_id),
    title VARCHAR(100),
    content TEXT,
    user_id varchar(20),
    post_date DATE,
    likes_count INT DEFAULT 0,
    post_type VARCHAR(20),
    comments_count INT DEFAULT 0,
    foreign key (user_id) references user(user_id)

);

drop table comment;
CREATE TABLE comment (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT REFERENCES post(post_id),
    author_id VARCHAR(20) REFERENCES user(user_id),
    comment_content TEXT,
    likes_count INT DEFAULT 0,
    foreign key (post_id) references post(post_id)

);
