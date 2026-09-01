-- 04_inserts.sql
-- DB basic data insertion

-- Forum stuff
INSERT INTO Notifications_Types (name, description) VALUES
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
