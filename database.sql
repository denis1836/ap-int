CREATE DATABASE IF NOT EXISTS ForumDB;
USE ForumDB;

-- places
CREATE TABLE Countries(
    country_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    country_name VARCHAR(128) NOT NULL,
    country_flag_url VARCHAR(512),
    country_code VARCHAR(4) NOT NULL
);

CREATE TABLE Regions(
    region_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    country_ID BIGINT NOT NULL,

    -- main
    region_name VARCHAR(128) NOT NULL,
    region_flag_url VARCHAR(512),
    region_code VARCHAR(4) NOT NULL,

    -- refs
    FOREIGN KEY (country_ID) REFERENCES Countries(country_ID)
);

CREATE TABLE Locations(
    location_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    region_ID BIGINT NOT NULL,
    location_name VARCHAR(256) NOT NULL,
    description TEXT,
    latitude DECIMAL(9,6) NOT NULL,
    longitude DECIMAL(9,6) NOT NULL,

    FOREIGN KEY (region_ID) REFERENCES Regions(region_ID)
);

-- help tables
CREATE TABLE Colors(
    color_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    color_name VARCHAR(64) NOT NULL,
    hex_code VARCHAR(7)
);

CREATE TABLE Tags(
    tag_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    tag_name VARCHAR(64) NOT NULL UNIQUE
);

CREATE TABLE Car_Tags(
    tag_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    tag_name VARCHAR(64) NOT NULL UNIQUE
);

-- car data
CREATE TABLE Car_Brands(
    brand_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    brand_name VARCHAR(128) NOT NULL UNIQUE
);

CREATE TABLE Car_Models(
    model_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    brand_ID BIGINT NOT NULL,
    
    -- main
    model_name VARCHAR(128) NOT NULL,
    
    -- links
    wikipedia_link VARCHAR(512),
    forum_link VARCHAR(512),
    misc_link VARCHAR(512),

    -- refs
    FOREIGN KEY (brand_ID) REFERENCES Car_Brands(brand_ID)
);

CREATE TABLE Car_Model_Generations(
    generation_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    model_ID BIGINT NOT NULL,
    
    -- main
    generation_name VARCHAR(128) NOT NULL,
    production_start_year INT NOT NULL,
    production_end_year INT,

    -- refs
    FOREIGN KEY (model_ID) REFERENCES Car_Models(model_ID)
);

CREATE TABLE Engines(
    engine_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    
    -- main
    name VARCHAR(128) NOT NULL,
    description TEXT,
    format VARCHAR(48) NOT NULL,
    code VARCHAR(48) NOT NULL,
    fuel_type VARCHAR(48) NOT NULL,
    displacement FLOAT NOT NULL,
    horsepower INT NOT NULL,
    torque INT NOT NULL
);

CREATE TABLE Gearboxes(
    gearbox_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    
    -- main
    name VARCHAR(128) NOT NULL,
    description TEXT,
    type ENUM('manual', 'automatic', 'semi-automatic', 'cvt') NOT NULL,
    gears_amount INT NOT NULL
);

-- users
CREATE TABLE Users(
    user_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,

    -- main
    user_name VARCHAR(64) NOT NULL UNIQUE,
    full_name VARCHAR(256) NOT NULL,
    user_bio VARCHAR(2048),

    -- collabs
    main_car_ID BIGINT,
    country_ID BIGINT DEFAULT NULL,
    location_ID BIGINT DEFAULT NULL,

    -- media
    avatar_url VARCHAR(512),
    banner_url VARCHAR(512),

    -- user data
    email VARCHAR(100) UNIQUE NOT NULL,
    phone_number VARCHAR(16) UNIQUE,
    password_hash VARCHAR(256) NOT NULL,

    -- statuses
    is_active BOOLEAN DEFAULT TRUE,
    is_admin BOOLEAN DEFAULT FALSE,
    is_deleted BOOLEAN DEFAULT FALSE,

    -- amounts
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

    -- time
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- refs
    FOREIGN KEY (country_ID) REFERENCES Countries(country_ID),
    FOREIGN KEY (location_ID) REFERENCES Locations(location_ID)
);

-- cars themselves
CREATE TABLE Cars(
    car_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    user_owner_ID BIGINT,

    -- main
    car_name VARCHAR(64) DEFAULT NULL,
    description TEXT,
    slug VARCHAR(64) UNIQUE NOT NULL,

    -- car info
    year INT NOT NULL,
    brand_ID BIGINT NOT NULL,
    model_ID BIGINT NOT NULL,
    model_generation_ID BIGINT NOT NULL,
    engine_ID BIGINT NOT NULL,
    gearbox_ID BIGINT DEFAULT NULL,
    fuel_type ENUM('petrol', 'diesel', 'petrol+lpg', 'lpg', 'electric', 'hybrid', 'other') NOT NULL,
    drive_type ENUM('FWD', 'RWD', 'AWD', '4WD') NOT NULL,
    color_ID BIGINT NOT NULL,

    -- mods
    is_modified BOOLEAN DEFAULT FALSE,
    modifications TEXT,
    state ENUM('active', 'main', 'past', 'deleted'),

    -- stats
    posts_amount INT DEFAULT 0,
    photos_amount INT DEFAULT 0,
    likes_amount INT DEFAULT 0,
    dislikes_amount INT DEFAULT 0,
    tags_amount INT DEFAULT 0,
    distance_driven_km INT DEFAULT 0,
    distance_last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- time
    owning_since TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- refs
    FOREIGN KEY (user_owner_ID) REFERENCES Users(user_ID) ON DELETE SET NULL,
    FOREIGN KEY (brand_ID) REFERENCES Car_Brands(brand_ID) ON DELETE SET NULL,
    FOREIGN KEY (model_ID) REFERENCES Car_Models(model_ID) ON DELETE SET NULL,
    FOREIGN KEY (model_generation_ID) REFERENCES Car_Model_Generations(generation_ID) ON DELETE SET NULL,
    FOREIGN KEY (engine_ID) REFERENCES Engines(engine_ID) ON DELETE SET NULL,
    FOREIGN KEY (gearbox_ID) REFERENCES Gearboxes(gearbox_ID) ON DELETE SET NULL,
    FOREIGN KEY (color_ID) REFERENCES Colors(color_ID) ON DELETE SET NULL
);
ALTER TABLE Users ADD CONSTRAINT fk_users_main_car
    FOREIGN KEY (main_car_ID) REFERENCES Cars(car_ID) ON DELETE SET NULL;

CREATE TABLE Car_Tags(
    car_ID BIGINT NOT NULL,
    tag_ID BIGINT NOT NULL,

    -- refs
    PRIMARY KEY (car_ID, tag_ID),
    FOREIGN KEY (tag_ID) REFERENCES Car_Tags(tag_ID) ON DELETE CASCADE,
    FOREIGN KEY (car_ID) REFERENCES Cars(car_ID) ON DELETE CASCADE
);

-- friends
CREATE TABLE Friends(
    user_ID BIGINT NOT NULL,
    friend_user_ID BIGINT NOT NULL,
    status ENUM('pending', 'accepted', 'blocked'),
    friendship_started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (user_ID, friend_user_ID),
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID),
    FOREIGN KEY (friend_user_ID) REFERENCES Users(user_ID)
);

-- clubs
CREATE TABLE Clubs(
    club_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    user_owner_ID BIGINT NOT NULL,

    -- main info
    club_name VARCHAR(128) NOT NULL,
    slug VARCHAR(64) UNIQUE NOT NULL,
    description TEXT NOT NULL,

    -- media
    avatar_url VARCHAR(512),
    banner_url VARCHAR(512),

    visiblity ENUM('public', 'private'),

    -- stats
    total_posts INT DEFAULT 0,
    total_photos INT DEFAULT 0,
    total_members INT DEFAULT 0,
    total_cars INT DEFAULT 0,
    total_active_members INT DEFAULT 0,
    total_events INT DEFAULT 0,

    -- time
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_owner_ID) REFERENCES Users(user_ID)
);

CREATE TABLE Club_Members(
    club_ID BIGINT NOT NULL,
    user_ID BIGINT NOT NULL,
    
    -- main
    role ENUM('member', 'moderator', 'admin', 'owner') DEFAULT 'member',
    status ENUM('pending', 'active', 'banned') DEFAULT 'active',
    
    -- time
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (club_ID, user_ID),
    FOREIGN KEY (club_ID) REFERENCES Clubs(club_ID) ON DELETE CASCADE,
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID) ON DELETE CASCADE
);

-- events
CREATE TABLE Events(
    event_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    user_organizer_ID BIGINT NOT NULL,
    title VARCHAR(256) NOT NULL,
    description TEXT NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
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

    -- refs
    PRIMARY KEY (event_ID, user_ID),
    FOREIGN KEY (event_ID) REFERENCES Events(event_ID) ON DELETE CASCADE,
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID),
    FOREIGN KEY (user_car_ID) REFERENCES Cars(car_ID)
);


-- posts
CREATE TABLE Posts(
    post_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,

    -- main
    title VARCHAR(256) NOT NULL,
    content TEXT NOT NULL,

    -- collabs
    user_ID BIGINT NOT NULL,
    club_ID BIGINT DEFAULT NULL,
    car_ID BIGINT DEFAULT NULL,
    event_ID BIGINT DEFAULT NULL,
    location_ID BIGINT DEFAULT NULL,

    -- stats
    linked_photos_amount INT DEFAULT 0,
    comment_amount INT DEFAULT 0,
    likes_amount INT DEFAULT 0,
    dislikes_amount INT DEFAULT 0,

    -- misc
    is_nsfw BOOLEAN DEFAULT FALSE,
    is_edited BOOLEAN DEFAULT FALSE,

    -- time
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    edited_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    -- refs
    FOREIGN KEY (car_ID) REFERENCES Cars(car_ID) ON DELETE SET NULL,
    FOREIGN KEY (club_ID) REFERENCES Clubs(club_ID) ON DELETE SET NULL,
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID) ON DELETE SET NULL,
    FOREIGN KEY (event_ID) REFERENCES Events(event_ID) ON DELETE SET NULL,
    FOREIGN KEY (location_ID) REFERENCES Locations(location_ID) ON DELETE SET NULL
);


CREATE TABLE Post_Tags(
    post_ID BIGINT NOT NULL,
    tag_ID BIGINT NOT NULL,

    -- refs
    PRIMARY KEY (post_ID, tag_ID),
    FOREIGN KEY (tag_ID) REFERENCES Tags(tag_ID) ON DELETE CASCADE,
    FOREIGN KEY (post_ID) REFERENCES Posts(post_ID) ON DELETE CASCADE
);

CREATE TABLE Posts_Reactions (
    post_ID BIGINT NOT NULL,
    user_ID BIGINT NOT NULL,

    -- main
    reaction ENUM('like', 'dislike') NOT NULL,

    -- time
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- refs
    PRIMARY KEY (post_ID, user_ID),
    FOREIGN KEY (post_ID) REFERENCES Posts(post_ID) ON DELETE CASCADE,
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID) ON DELETE CASCADE
);

CREATE TABLE Post_Comments(
    post_comment_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    parent_post_comment_ID BIGINT DEFAULT NULL,
    user_ID BIGINT NOT NULL,
    post_ID BIGINT NOT NULL,
    
    -- time
    content TEXT NOT NULL,
    likes_amount INT DEFAULT 0,
    dislikes_amount INT DEFAULT 0,
    
    -- time
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- refs
    FOREIGN KEY (post_ID) REFERENCES Posts(post_ID) ON DELETE CASCADE,  -- SET NULL → CASCADE
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID),
    FOREIGN KEY (parent_post_comment_ID) REFERENCES Post_Comments(post_comment_ID) ON DELETE CASCADE
);

CREATE TABLE Post_Comment_Reactions (
    post_comment_ID BIGINT NOT NULL,
    user_ID BIGINT NOT NULL,
    
    -- main
    reaction ENUM('like', 'dislike') NOT NULL,
    
    --time
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    --refs
    PRIMARY KEY (post_comment_ID, user_ID),
    FOREIGN KEY (post_comment_ID) REFERENCES Post_Comments(post_comment_ID) ON DELETE CASCADE,
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID)
);


-- photos
CREATE TABLE Photos(
    photo_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    user_ID BIGINT NOT NULL,
    photo_url VARCHAR(512) NOT NULL,
    description VARCHAR(512),
    part_on_the_photo VARCHAR(128),

    -- collabs
    post_ID BIGINT DEFAULT NULL,
    club_ID BIGINT DEFAULT NULL,
    car_ID BIGINT DEFAULT NULL,
    location_ID BIGINT DEFAULT NULL,
    event_ID BIGINT DEFAULT NULL,

    -- stats
    likes_amount INT DEFAULT 0,
    dislikes_amount INT DEFAULT 0,
    is_nsfw BOOLEAN DEFAULT FALSE,

    -- time
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- refs
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID),
    FOREIGN KEY (post_ID) REFERENCES Posts(post_ID) ON DELETE SET NULL,
    FOREIGN KEY (club_ID) REFERENCES Clubs(club_ID) ON DELETE SET NULL,
    FOREIGN KEY (car_ID) REFERENCES Cars(car_ID) ON DELETE SET NULL,
    FOREIGN KEY (event_ID) REFERENCES Events(event_ID) ON DELETE SET NULL,
    FOREIGN KEY (location_ID) REFERENCES Locations(location_ID) ON DELETE SET NULL
);

CREATE TABLE Photos_Reactions (
    photo_ID BIGINT NOT NULL,
    user_ID BIGINT NOT NULL,

    -- main
    reaction ENUM('like', 'dislike') NOT NULL,

    -- time
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- refs
    PRIMARY KEY (photo_ID, user_ID),
    FOREIGN KEY (photo_ID) REFERENCES Photos(photo_ID) ON DELETE CASCADE,
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID) ON DELETE CASCADE
);

CREATE TABLE Photos_Comments(
    photo_comment_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,
    parent_comment_ID BIGINT DEFAULT NULL,
    photo_ID BIGINT NOT NULL,
    user_ID BIGINT NOT NULL,

    -- main
    content TEXT NOT NULL,
    likes_amount INT DEFAULT 0,
    dislikes_amount INT DEFAULT 0,

    -- time
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- refs
    FOREIGN KEY (photo_ID) REFERENCES Photos(photo_ID) ON DELETE CASCADE,
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID),
    FOREIGN KEY (parent_comment_ID) REFERENCES Photos_Comments(photo_comment_ID) ON DELETE CASCADE
);

CREATE TABLE Photos_Comment_Reactions (
    comment_ID BIGINT NOT NULL,
    user_ID BIGINT NOT NULL,

    -- main
    reaction ENUM('like', 'dislike') NOT NULL,

    -- time
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- refs
    PRIMARY KEY (comment_ID, user_ID),
    FOREIGN KEY (comment_ID) REFERENCES Photos_Comments(photo_comment_ID) ON DELETE CASCADE,
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID)
);

-- forum stuff
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

CREATE TABLE Notifications_Types(
    type_ID BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT UNIQUE,

    type_name VARCHAR(64) NOT NULL UNIQUE,
    description VARCHAR(256) DEFAULT NULL
);

CREATE TABLE Notifications (
    notification_ID BIGINT PRIMARY KEY AUTO_INCREMENT,

    user_ID BIGINT NOT NULL,
    type_ID BIGINT NOT NULL,

    other_user_ID BIGINT,
    related_post_ID BIGINT,
    related_comment_ID BIGINT,
    related_photo_ID BIGINT,

    -- state
    is_read BOOLEAN DEFAULT FALSE,

    -- time
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- refs
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID) ON DELETE CASCADE,
    FOREIGN KEY (type_ID) REFERENCES Notifications_Types(type_ID) ON DELETE SET NULL,
    FOREIGN KEY (other_user_ID) REFERENCES Users(user_ID),
    FOREIGN KEY (related_post_ID) REFERENCES Posts(post_ID) ON DELETE SET NULL,
    FOREIGN KEY (related_comment_ID) REFERENCES Post_Comments(post_comment_ID) ON DELETE SET NULL,
    FOREIGN KEY (related_photo_ID) REFERENCES Photos(photo_ID) ON DELETE SET NULL
);

-- indexes
CREATE INDEX idx_posts_user ON Posts(user_ID);
CREATE INDEX idx_posts_club ON Posts(club_ID);
CREATE INDEX idx_cars_user ON Cars(user_owner_ID);
CREATE INDEX idx_notifications_user ON Notifications(user_ID);
CREATE INDEX idx_photos_user ON Photos(user_ID);

-- default data
INSERT INTO Notifications_Types (type_name, description) VALUES
    ('post_like',         'Someone liked your post.'),
    ('post_dislike',      'Someone disliked your post.'),
    ('post_comment',      'New comment on your post.'),
    ('photo_like',        'Someone liked your photo.'),
    ('photo_dislike',     'Someone disliked your photo.'),
    ('photo_comment',     'New comment on your photo.'),
    ('comment_reply',     'Someone replied to your comment.'),
    ('comment_like',      'Someone liked your comment.'),
    ('comment_dislike',   'Someone disliked your comment.'),
    ('new_follower',      'Someone started following you.'),
    ('club_request',      'Request to join your club.'),
    ('new_club_member',   'Someone joined your club.'),
    ('event_invite',      'Invitation to an event you might like.'),
    ('friend_request',    'Friend request.'),
    ('club_invite',       'You were invited to a club.'),
    ('event_join',        'Someone joined the event you are organising.');