create database botox;
use botox;
# user_totalMannerPoint를 두고 칭찬을 받으면 +되고, 리폿받으면 -가 되서 나중에 user_totalMannerPoint가 5이상이면 무슨 등급, 10이상이면 무슨 등급 이런느낌으로

# 유저
CREATE TABLE user (
    user_id VARCHAR(20) PRIMARY KEY not null,
    user_pw VARCHAR(20) NOT NULL,
    user_profilepic BLOB,
    user_nickname VARCHAR(20),
    user_connection BOOLEAN,
    user_totalMannerPoint INT DEFAULT 0
);

# 친구
CREATE TABLE friendShip(
    requestID VARCHAR(20),
    acceptID VARCHAR(20),
    FOREIGN KEY (requestID) REFERENCES user(user_id),
    FOREIGN KEY (acceptID) REFERENCES user(user_id)
);

# 친구 테이블 유저테이블에 자체참조하게 하는거 모르겠음
# 방(방장이름(master)
CREATE TABLE room (
    room_num INT PRIMARY KEY NOT NULL,
    room_type VARCHAR(20),
    room_capacity_limit INT,
    room_currentNum INT,
    room_lock_state BOOLEAN,
    room_title VARCHAR(100),
    game_name VARCHAR(20) REFERENCES game(game_name),
    game_user_count INT,
    room_master VARCHAR(20),
    FOREIGN KEY (room_master) REFERENCES user(user_id),
    FOREIGN key (game_name) references game(game_name)
);

# 게임
drop table game;
CREATE TABLE game (
    game_name VARCHAR(20) PRIMARY KEY,
    game_user_count INT
);

# 신고
drop table report;
CREATE TABLE report (
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    report_time DATE,
    reporting_user_id VARCHAR(20),
    reported_user_id VARCHAR(20),
    FOREIGN KEY (reporting_user_id) REFERENCES user(user_id),
    FOREIGN KEY (reported_user_id) REFERENCES user(user_id),
    feedback_result VARCHAR(100),
    reason_for_report TEXT,
    report_type VARCHAR(50),
    processing_status VARCHAR(50)
                    );





#  게시글
drop table post;
CREATE TABLE post (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100),
    content TEXT,
    user_id varchar(20),
    post_time DATE,
    post_type VARCHAR(20),
    comments_count INT DEFAULT 0,
    foreign key (user_id) references user(user_id)

);
# 댓글
CREATE TABLE comment (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT REFERENCES post(post_id),
    author_id VARCHAR(20) REFERENCES user(user_id),
    comment_content TEXT,
    likes_count INT DEFAULT 0,
    foreign key (post_id) references post(post_id)

);
