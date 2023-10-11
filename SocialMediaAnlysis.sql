-- Database Creation

CREATE DATABASE social_media;

-- Table Creation

CREATE TABLE socialposts (
User_ID INT PRIMARY KEY NOT NULL,
Username VARCHAR(255) NOT NULL,
Platform VARCHAR(255) NOT NULL,
Post_Text VARCHAR(255),
Likes INT,
Comments INT,
Hashtags VARCHAR(255),
Media_Type VARCHAR(100),
User_Engagement INT,
User_Interactions INT,
User_Activity VARCHAR(255)
);


-- Data Loading

LOAD DATA INFILE 'F:/Projects/Social_media/socialmedia.csv'
INTO TABLE socialposts
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- User Engagement and Activity

-- What is the average user engagement(likes and comments) per post on each platform?
SELECT platform,AVG(Likes) AS avg_like_per_post,AVG(Comments) AS avg_comments_per_post FROM socialposts GROUP BY Platform;

-- Which users have the highest user engagement on average?
SELECT Username,AVG(User_Engagement) AS avg_user_engagement FROM socialposts GROUP BY Username ORDER BY avg_user_engagement DESC LIMIT 5;

-- How does user activity vary across different platforms?
SELECT Platform,SUM(UserActivity) AS total_user_activity FROM socialposts GROUP BY Platform ORDER BY total_user_activity DESC;

-- Content Analysis

-- What are the most common hashtags used in the posts?
SELECT Hashtags,AVG(Likes) AS avg_likes,AVG(Comments) AS avg_comments FROM socialposts GROUP BY Hashtags ORDER BY avg_likes DESC LIMIT 5;

-- Is there a relationship between the type of media (e.g., text, images, videos) and user engagement?
SELECT Media_Type,AVG(User_Engagement) AS avg_user_engagement,AVG(User_Interactions) AS avg_user_interactions FROM socialposts GROUP BY Media_Type;


-- User Behavior

-- Are there users who consistently post content with high user engagement?
SELECT Username,AVG(User_Engagement) as avg_engagement FROM socialposts GROUP BY User_ID,Username HAVING avg_engagement > (SELECT AVG(User_Engagement) FROM socialposts) ORDER BY avg_engagement DESC LIMIT 5;

-- What is the distribution of user activity (number of posts) across different users?
SELECT Username,COUNT(*) as post_count FROM socialposts GROUP BY Username ORDER BY post_count DESC;

-- Are there users who frequently interact with other users' posts?
SELECT User_ID,Username,SUM(User_Interactions) AS total_interactions FROM socialposts GROUP BY User_ID,Username ORDER BY total_interactions;

-- Platform Comparison 

-- How does user engagement and user activity differ between platforms?
   -- average likes and comments per post by platform
SELECT Platform,AVG(Likes) AS avg_likes,AVG(comments) AS avg_comments FROM socialposts GROUP BY Platform;

   -- total user activity (number of posts) by platform
SELECT Platform,COUNT(*) as total_posts FROM socialposts GROUP BY Platform;


-- Are there differences in the types of media (e.g., text, images) posted on each platform?

SELECT Platform,Media_Type,COUNT(*) AS media_count FROM socialposts GROUP BY Platform,Media_Type;

-- Which platform has the highest average user engagement

SELECT Platform,AVG(Likes) as avg_likes,AVG(Comments) FROM socialposts GROUP BY Platform;












