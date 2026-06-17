-- 02_indexes.sql
-- DB indexes creation script

CREATE INDEX idx_posts_user ON Posts(user_ID);
CREATE INDEX idx_posts_club ON Posts(club_ID);
CREATE INDEX idx_cars_user ON Cars(owner_user_ID);
CREATE INDEX idx_notifications_user ON Notifications(user_ID);
CREATE INDEX idx_photos_user ON Photos(user_ID);

-- TODO
