# Game-Analysis-Using-SQL
 Introduction 
 In the gaming industry, understanding player behavior and engagement is crucial for enhancing user experience and game design. Our goal was to analyze various aspects of gameplay to gain insights into:
 
 🔷Player progression across levels and difficulty settings.
 
 🔷Player engagement metrics.
 
 🔷Device performance impacts on gameplay.
 
 🔷Overall progress tracking and performance metrics.

## Efforts Towards the Solution:
To address these challenges, I executed a series of complex SQL queries and employed advanced SQL techniques. Here’s a summary of the key tasks:

#### Q1) Extract P_ID,Dev_ID,PName and Difficulty_level of all players at level 0

#### Q2) Find Level1_code wise Avg_Kill_Count where lives_earned is 2 and atleast 3 stages are crossed
#### Q3) Find the total number of stages crossed at each diffuculty level where for Level2 with players use zm_series devices. Arrange the result in decsreasing order of total number of stages crossed.
#### Q4) Extract P_ID and the total number of unique dates for those players who have played games on multiple days.
#### Q5) Find P_ID and level wise sum of kill_counts where kill_count is greater than avg kill count for the Medium difficulty.
#### Q6)  Find Level and its corresponding Level code wise sum of lives earned excluding level 0. Arrange in asecending order of level.
#### Q7) Find Top 3 score based on each dev_id and Rank them in increasing order using Row_Number. Display difficulty as well. 
#### Q8) Find first_login datetime for each device id
#### Q9) Find Top 5 score based on each difficulty level and Rank them in increasing order using Rank. Display dev_id as well.
#### Q10) Find the device ID that is first logged in(based on start_datetime) for each player(p_id). Output should contain player id, device id and first login datetime.
#### Q11) For each player and date, how many kill_count played so far by the player. That is, the total number of games played -- by the player until that date.
a) window function
b) without window function
#### Q12) Find the cumulative sum of stages crossed over a start_datetime 
#### Q13) Find the cumulative sum of an stages crossed over a start_datetime for each player id but exclude the most recent start_datetime
#### Q14) Extract top 3 highest sum of score for each device id and the corresponding player_id
#### Q15) Find players who scored more than 50% of the avg score scored by sum of scores for each player_id
#### Q16) Create a stored procedure to find top n headshots_count based on each dev_id and Rank them in increasing order using Row_Number. Display difficulty as well.
#### Q17) Create a function to return sum of Score for a given player_id.

### 🛠️ Technical Learnings:

#### Advanced SQL Concepts:
Gained proficiency in window functions for complex data analysis and cumulative calculations.
#### Stored Procedures: 
Learned to create and utilize stored procedures to streamline repetitive tasks and enhance query efficiency.
#### User-Defined Functions:
Developed custom functions to provide flexible and reusable solutions for specific analysis needs.

### Conclusion
This project on Game Analysis using SQL has been an enriching experience, providing deep insights into player behavior, engagement, and device performance within a gaming environment. By leveraging advanced SQL techniques, we were able to extract valuable information that can be utilized to enhance game design and player experience.

### Key Achievements:
Comprehensive Player Progression Tracking: Successfully tracked player levels and performance across different difficulties, providing a clear understanding of player progression.

Detailed Engagement Analysis: Monitored player engagement through various metrics, including multi-day gameplay and unique play dates.

Device Performance Insights: Analyzed the impact of device performance on gameplay, highlighting the importance of optimizing games for different devices.

Advanced Data Analysis Techniques: Employed complex SQL queries, window functions, stored procedures, and user-defined functions to perform in-depth data analysis.

Actionable Insights: Derived meaningful insights that can help in making data-driven decisions for game improvement and player retention strategies.



