CREATE DATABASE ForumDB;
USE ForumDB;

--User stuff
CREATE TABLE Users(
    user_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    slug VARCHAR(64) NOT NULL UNIQUE,
    user_name VARCHAR(256) NOT NULL,
    main_car_ID BIGINT,
    user_bio TEXT,
    country_ID BIGINT DEFAULT NULL,
    location_ID BIGINT DEFAULT NULL,
    avatar_url VARCHAR(512),
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(16) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
    last_login TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    password_hash VARCHAR(256) NOT NULL,
    FOREIGN KEY (main_car_ID) REFERENCES Cars(car_ID),
    FOREIGN KEY (country_ID) REFERENCES Countries(country_ID),
    FOREIGN KEY (location_ID) REFERENCES Locations(location_ID)
);
CREATE TABLE User_Statistics(
    user_ID BIGINT NOT NULL PRIMARY KEY,
    --statuses
    is_active BOOLEAN DEFAULT TRUE,
    is_admin BOOLEAN DEFAULT FALSE,
    is_deleted BOOLEAN DEFAULT FALSE,
    --amounts
    friends_amount INT DEFAULT 0,
    posts_amount INT DEFAULT 0,
    photos_amount INT DEFAULT 0,
    comments_amount INT DEFAULT 0,
    cars_amount INT DEFAULT 0,
    past_cars_amount INT DEFAULT 0,
    clubs_amount INT DEFAULT 0,
    likes_amount INT DEFAULT 0,
    dislikes_amount INT DEFAULT 0,
    events_amount INT DEFAULT 0,
    organised_events_amount INT DEFAULT 0,
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID)
);
CREATE TABLE Friends(
    user_ID BIGINT NOT NULL,
    friend_user_ID BIGINT NOT NULL,
    friendship_started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_ID, friend_user_ID),
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID),
    FOREIGN KEY (friend_user_ID) REFERENCES Users(user_ID)
);

CREATE TABLE Cars(
    car_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    user_owner_ID BIGINT NOT NULL,
    car_name VARCHAR(64) DEFAULT NULL,
    description TEXT,
    slug VARCHAR(64) UNIQUE NOT NULL,
    year INT NOT NULL,
    brand_ID BIGINT NOT NULL,
    model_ID BIGINT NOT NULL,
    model_generation_ID BIGINT NOT NULL,
    engine_ID BIGINT NOT NULL,
    gearbox_ID BIGINT DEFAULT NULL,
    modifications TEXT,
    drive_type ENUM('FWD', 'RWD', 'AWD', '4WD') NOT NULL,
    color VARCHAR(64) NOT NULL,
    fuel_type ENUM('petrol', 'diesel', 'petrol+lpg', 'lpg', 'electric', 'hybrid','other') NOT NULL,
    is_modified BOOLEAN DEFAULT FALSE,
    is_past BOOLEAN DEFAULT FALSE,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    users_since TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_owner_ID) REFERENCES Users(user_ID) ON DELETE SET NULL,
    FOREIGN KEY (brand_ID) REFERENCES Car_Brands(brand_ID) ON DELETE SET NULL,
    FOREIGN KEY (model_ID) REFERENCES Car_Models(model_ID) ON DELETE SET NULL,
    FOREIGN KEY (model_generation_ID) REFERENCES Car_Model_Generations(generation_ID) ON DELETE SET NULL,
    FOREIGN KEY (engine_ID) REFERENCES Engines(engine_ID) ON DELETE SET NULL,
    FOREIGN KEY (gearbox_ID) REFERENCES Gearboxes(gearbox_ID) ON DELETE SET NULL
);
CREATE TABLE Car_Statistics(
    car_ID BIGINT NOT NULL PRIMARY KEY,
    posts_amount INT DEFAULT 0,
    photos_amount INT DEFAULT 0,
    likes_amount INT DEFAULT 0,
    dislikes_amount INT DEFAULT 0,
    tags_amount INT DEFAULT 0,
    distance_driven_km INT DEFAULT 0,
    distance_last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (car_ID) REFERENCES Cars(car_ID) ON DELETE SET NULL
);

CREATE TABLE Clubs(
    club_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    user_owner_ID BIGINT NOT NULL,
    club_name VARCHAR(128) NOT NULL,
    slug VARCHAR(64) UNIQUE NOT NULL,
    description TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_private BOOLEAN DEFAULT FALSE,
    cover_photo_url VARCHAR(500),
    banner_photo_url VARCHAR(500),
    FOREIGN KEY (user_owner_ID) REFERENCES Users(user_ID)
);
CREATE TABLE Club_Statistics(
    club_ID BIGINT NOT NULL PRIMARY KEY,
    total_posts INT DEFAULT 0,
    total_photos INT DEFAULT 0,
    total_members INT DEFAULT 0,
    total_cars INT DEFAULT 0,
    total_active_members INT DEFAULT 0,
    total_events INT DEFAULT 0,
    FOREIGN KEY (club_ID) REFERENCES Clubs(club_ID) ON DELETE SET NULL
);
CREATE TABLE Club_Members(
    club_ID BIGINT NOT NULL,
    user_ID BIGINT NOT NULL,
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    role ENUM('member', 'moderator', 'admin') DEFAULT 'member',
    status ENUM('active', 'pending', 'banned') DEFAULT 'active',
    PRIMARY KEY (club_id, user_id),
    FOREIGN KEY (club_ID) REFERENCES Clubs(club_ID) ON DELETE SET NULL,
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID) ON DELETE SET NULL
);

--Posts
CREATE TABLE Posts(
    post_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    user_ID BIGINT NOT NULL,
    club_ID BIGINT DEFAULT NULL,
    car_ID BIGINT DEFAULT NULL,
    event_ID BIGINT DEFAULT NULL,
    location_ID BIGINT DEFAULT NULL,
    title VARCHAR(256) NOT NULL,
    content TEXT NOT NULL,
    location VARCHAR(256),
    linked_photos_amount INT,
    comment_amount INT,
    likes_amount INT,
    dislikes_amount INT,
    is_nsfw BOOLEAN DEFAULT FALSE,
    is_edited BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    edited_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (car_ID) REFERENCES Cars(car_ID) ON DELETE SET NULL,
    FOREIGN KEY (club_ID) REFERENCES Clubs(club_ID) ON DELETE SET NULL,
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID) ON DELETE SET NULL,
    FOREIGN KEY (event_ID) REFERENCES Events(event_ID) ON DELETE SET NULL,
    FOREIGN KEY (location_ID) REFERENCES Locations(location_ID) ON DELETE SET NULL
);
CREATE TABLE Post_Tags(
    post_ID BIGINT NOT NULL,
    tag VARCHAR(64) NOT NULL,
    PRIMARY KEY (post_ID, tag),
    FOREIGN KEY (post_ID) REFERENCES Posts(post_ID) ON DELETE CASCADE
);
CREATE TABLE Post_Comments(
    comment_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    post_ID BIGINT NOT NULL,
    parent_comment_ID BIGINT DEFAULT NULL,
    user_ID BIGINT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    likes_amount INT,
    dislikes_amount INT,
    FOREIGN KEY (post_ID) REFERENCES Posts(post_ID) ON DELETE SET NULL,
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID),
    FOREIGN KEY (parent_comment_ID) REFERENCES Post_Comments(comment_ID) ON DELETE CASCADE
);
CREATE TABLE Post_Comment_Reactions (
    comment_ID BIGINT NOT NULL,
    user_ID BIGINT NOT NULL,
    reaction ENUM('like', 'dislike') NOT NULL,
    PRIMARY KEY (comment_ID, user_ID),
    FOREIGN KEY (comment_ID) REFERENCES Post_Comments(comment_ID) ON DELETE CASCADE,
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID)
);

--Photos
CREATE TABLE Photos(
    photo_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    user_ID BIGINT NOT NULL,
    post_ID BIGINT DEFAULT NULL,
    club_ID BIGINT DEFAULT NULL,
    car_ID BIGINT DEFAULT NULL,
    location_ID BIGINT DEFAULT NULL,
    event_ID BIGINT DEFAULT NULL,
    photo_url VARCHAR(512) NOT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description VARCHAR(512),
    part_on_the_photo VARCHAR(128),
    likes_amount INT,
    dislikes_amount INT,
    is_nsfw BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID),
    FOREIGN KEY (post_ID) REFERENCES Posts(post_ID) ON DELETE SET NULL,
    FOREIGN KEY (club_ID) REFERENCES Clubs(club_ID) ON DELETE SET NULL,
    FOREIGN KEY (car_ID) REFERENCES Cars(car_ID) ON DELETE SET NULL,
    FOREIGN KEY (event_ID) REFERENCES Events(event_ID) ON DELETE SET NULL,
    FOREIGN KEY (location_ID) REFERENCES Locations(location_ID) ON DELETE SET NULL
);
CREATE TABLE Photos_Likes (
    photo_ID BIGINT NOT NULL,
    user_ID BIGINT NOT NULL,
    reaction ENUM('like', 'dislike') NOT NULL,
    PRIMARY KEY (photo_ID, user_ID),
    FOREIGN KEY (photo_ID) REFERENCES Photos(photo_ID) ON DELETE CASCADE,
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID) ON DELETE CASCADE
);
CREATE TABLE Photos_Comments(
    photo_comment_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    photo_ID BIGINT NOT NULL,
    parent_comment_ID BIGINT DEFAULT NULL,
    user_ID BIGINT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    likes_amount INT,
    dislikes_amount INT,
    FOREIGN KEY (photo_ID) REFERENCES Photos(photo_ID) ON DELETE SET NULL,
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID),
    FOREIGN KEY (parent_comment_ID) REFERENCES Photos_Comments(photo_comment_ID) ON DELETE CASCADE
);
CREATE TABLE Photos_Comment_Reactions (
    comment_ID BIGINT NOT NULL,
    user_ID BIGINT NOT NULL,
    reaction ENUM('like', 'dislike') NOT NULL,
    PRIMARY KEY (comment_ID, user_ID),
    FOREIGN KEY (comment_ID) REFERENCES Photos_Comments(photo_comment_ID) ON DELETE CASCADE,
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID)
);

--Forum sTUFF
CREATE TABLE Forum_Statistics(
    total_users INT DEFAULT 0,
    total_active_users INT DEFAULT 0,
    total_posts INT DEFAULT 0,
    total_photos INT DEFAULT 0,
    total_comments INT DEFAULT 0,
    total_clubs INT DEFAULT 0,
    total_cars INT DEFAULT 0,
    total_events INT DEFAULT 0,
    total_active_events INT DEFAULT 0,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
CREATE TABLE Notifications (
    notification_ID BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_ID BIGINT NOT NULL,
    type_ID BIGINT NOT NULL,
    other_user_ID BIGINT,
    related_post_ID BIGINT,
    related_comment_ID BIGINT,
    related_photo_ID BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID) ON DELETE CASCADE,
    FOREIGN KEY (type_ID) REFERENCES Notifications_Types(type_ID) ON DELETE SET NULL,
    FOREIGN KEY (other_user_ID) REFERENCES Users(user_ID),
    FOREIGN KEY (related_post_ID) REFERENCES Posts(post_ID) ON DELETE SET NULL,
    FOREIGN KEY (related_comment_ID) REFERENCES Post_Comments(comment_ID) ON DELETE SET NULL,
    FOREIGN KEY (related_photo_ID) REFERENCES Photos(photo_ID) ON DELETE SET NULL
);
CREATE TABLE Notifications_Types(
    type_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    type_name VARCHAR(64) NOT NULL UNIQUE,
    description VARCHAR(256) DEFAULT NULL
);

--places
CREATE TABLE Locations(
    location_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    location_name VARCHAR(256) NOT NULL,
    country_ID BIGINT NOT NULL,
    latitude DECIMAL(9,6) NOT NULL,
    longitude DECIMAL(9,6) NOT NULL,
    description TEXT,
    FOREIGN KEY (country_ID) REFERENCES Countries(country_ID)
);
CREATE TABLE Countries(
    country_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    country_name VARCHAR(128) NOT NULL,
    country_flag_url VARCHAR(512),
    country_code VARCHAR(8) NOT NULL,
    continent VARCHAR(64) NOT NULL
);

--Event tables
CREATE TABLE Events(
    event_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    user_organizer_ID BIGINT NOT NULL,
    title VARCHAR(256) NOT NULL,
    description TEXT NOT NULL,
    start TIMESTAMP NOT NULL,
    end TIMESTAMP NOT NULL,
    location_ID BIGINT NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    amount_of_participants INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_organizer_ID) REFERENCES Users(user_ID),
    FOREIGN KEY (location_ID) REFERENCES Locations(location_ID)
);
CREATE TABLE Event_Participants(
    event_ID BIGINT NOT NULL,
    user_ID BIGINT NOT NULL,
    user_car_ID BIGINT,
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (event_ID, user_ID),
    FOREIGN KEY (event_ID) REFERENCES Events(event_ID) ON DELETE SET NULL,
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID),
    FOREIGN KEY (user_car_ID) REFERENCES Cars(car_ID)
);

--Mechanical data tables
CREATE TABLE Car_Brands(
    car_brand_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    brand_name VARCHAR(128) NOT NULL UNIQUE
);
CREATE TABLE Car_Models(
    model_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    brand_ID BIGINT NOT NULL,
    model_name VARCHAR(128) NOT NULL,
    wikipedia_link VARCHAR(512),
    FOREIGN KEY (brand_ID) REFERENCES Car_Brands(brand_ID)
);
CREATE TABLE Car_Model_Generations(
    generation_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    model_ID BIGINT NOT NULL,
    generation_name VARCHAR(128) NOT NULL,
    production_start_year INT NOT NULL,
    production_end_year INT,
    FOREIGN KEY (model_ID) REFERENCES Car_Models(model_ID) 
);
CREATE TABLE Engines(
    engine_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    name VARCHAR(128) NOT NULL,
    displacement FLOAT NOT NULL,
    format VARCHAR(48) NOT NULL,
    code VARCHAR(48) NOT NULL,
    horsepower INT NOT NULL,
    torque INT NOT NULL,
    fuel_type VARCHAR(48) NOT NULL,
    description TEXT
);
CREATE TABLE Gearboxes(
    gearbox_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    name VARCHAR(128) NOT NULL,
    type ENUM('manual', 'automatic', 'semi-automatic', 'cvt') NOT NULL,
    gears_amount INT NOT NULL,
    description TEXT
);

--Indexes
CREATE INDEX idx_users_email ON Users(email);
CREATE INDEX idx_posts_op ON Posts(user_ID);
CREATE INDEX idx_cars_owner ON Cars(user_owner_ID);
CREATE INDEX idx_posts_car ON Posts(car_ID);
CREATE INDEX idx_posts_club ON Posts(club_ID);
CREATE INDEX idx_photos_car ON Photos(car_ID);
CREATE INDEX idx_notifications_user ON Notifications(user_ID, is_read DESC);
CREATE INDEX idx_slug_users ON Users(slug);
CREATE INDEX idx_slug_cars ON Cars(slug);
CREATE INDEX idx_slug_clubs ON Clubs(slug);
CREATE INDEX idx_users_country ON Users(country_ID);
CREATE INDEX idx_cars_brand ON Cars(brand_ID);
CREATE INDEX idx_cars_model ON Cars(model_ID);
CREATE INDEX idx_posts_event ON Posts(event_ID);
CREATE INDEX idx_photos_location ON Photos(location_ID);

--Default Inserts
INSERT INTO Notification_Types (type_name, description) VALUES
    ('post_like', 'Someone liked your post.'),
    ('post_dislike', 'Someone disliked your post.'),
    ('post_comment', 'New comment on your post.'),
    ('photo_like', 'Someone liked your photo.'),
    ('photo_dislike', 'Someone disliked your photo.'),
    ('photo_comment', 'New comment on your photo.'),
    ('comment_reply', 'Someone replied to your comment.'),
    ('comment_like', 'Someone liked your comment.'),
    ('comment_dislike', 'Someone disliked your comment.'),
    ('new_follower', 'Someone started following you.'),  
    ('club_request', 'Request to join your club.'),
    ('new_club_member', 'Someone joined your club.'),
    ('event_invite', 'Invitation to an event you might like'),
    ('friend_request', 'Friend request.'),
    ('club_invite', 'You were invited to a club.'),
    ('event_join', 'Someone joined the event you are organising.')
;