# Game-Analysis-Using-SQL
 Introduction 
 In the gaming industry, understanding player behavior and engagement is crucial for enhancing user experience and game design. Our goal was to analyze various aspects of gameplay to gain insights into:
 
 🔷Player progression across levels and difficulty settings.
 
 🔷Player engagement metrics.
 
 🔷Device performance impacts on gameplay.
 
 🔷Overall progress tracking and performance metrics.

## Efforts Towards the Solution:
To address these challenges, I executed a series of complex SQL queries and employed advanced SQL techniques. Here’s a summary of the key tasks:

 Q1) Extract P_ID,Dev_ID,PName and Difficulty_level of all players at level 0.
 
![1](https://github.com/Kanchan8866/Game-Analysis-Using-SQL/assets/159992336/5278f621-5e7e-4ebc-9de1-2a8a7a8a98cc)

 Q2) Find Level1_code wise Avg_Kill_Count where lives_earned is 2 and atleast 3 stages are crossed.
 
![2](https://github.com/Kanchan8866/Game-Analysis-Using-SQL/assets/159992336/b800292a-bdd0-4622-9819-9262614a17db)

 Q3) Find the total number of stages crossed at each diffuculty level where for Level2 with players use zm_series devices. Arrange the result in decsreasing order of total number of stages crossed.

![3](https://github.com/Kanchan8866/Game-Analysis-Using-SQL/assets/159992336/fbcb5ebc-12ef-4d7e-b65d-e99da6971228)

Q4) Extract P_ID and the total number of unique dates for those players who have played games on multiple days.

![4](https://github.com/Kanchan8866/Game-Analysis-Using-SQL/assets/159992336/a45f9ea0-cb96-4319-9af4-91fd2ba8787b)

 Q5) Find P_ID and level wise sum of kill_counts where kill_count is greater than avg kill count for the Medium difficulty.

![5](https://github.com/Kanchan8866/Game-Analysis-Using-SQL/assets/159992336/0bdc5e98-2e7b-40ae-ac36-9d6b5cba0531)

 Q6)  Find Level and its corresponding Level code wise sum of lives earned excluding level 0. Arrange in asecending order of level.

![6](https://github.com/Kanchan8866/Game-Analysis-Using-SQL/assets/159992336/7e4f05bd-325a-4de4-b644-4da9e09a291b)

 Q7) Find Top 3 score based on each dev_id and Rank them in increasing order using Row_Number. Display difficulty as well. 

![7](https://github.com/Kanchan8866/Game-Analysis-Using-SQL/assets/159992336/1f349079-cbbf-40b5-9c03-60dc5125cc1e)

Q8) Find first_login datetime for each device id.

![8](https://github.com/Kanchan8866/Game-Analysis-Using-SQL/assets/159992336/271a2551-b79b-49ed-ab00-aa52611a5245)

 Q9) Find Top 5 score based on each difficulty level and Rank them in increasing order using Rank. Display dev_id as well.

![9](https://github.com/Kanchan8866/Game-Analysis-Using-SQL/assets/159992336/abb4aecb-7ef7-4d41-b590-7fcff60f1006)

 Q10) Find the device ID that is first logged in(based on start_datetime) for each player(p_id). Output should contain player id, device id and first login datetime.

![10](https://github.com/Kanchan8866/Game-Analysis-Using-SQL/assets/159992336/04610492-5508-4c69-9857-dcfca6c739d0)

 Q11) For each player and date, how many kill_count played so far by the player. That is, the total number of games played by the player until that date.

a) window function

![11a](https://github.com/Kanchan8866/Game-Analysis-Using-SQL/assets/159992336/863a49cd-1833-4fcd-a569-e0f3cbcb5ee2)

b) without window function

![11b](https://github.com/Kanchan8866/Game-Analysis-Using-SQL/assets/159992336/cf62f042-61c2-450e-baa6-fb88b01a5395)

Q12) Find the cumulative sum of stages crossed over a start_datetime. 

![12](https://github.com/Kanchan8866/Game-Analysis-Using-SQL/assets/159992336/5f2242bf-efa6-4b8e-8b22-92d836374803)

 Q13) Find the cumulative sum of an stages crossed over a start_datetime for each player id but exclude the most recent start_datetime.

![13](https://github.com/Kanchan8866/Game-Analysis-Using-SQL/assets/159992336/570c9183-c9f2-48b3-95e3-f7031ccfc300)

 Q14) Extract top 3 highest sum of score for each device id and the corresponding player_id.

![14](https://github.com/Kanchan8866/Game-Analysis-Using-SQL/assets/159992336/6d4fa6b4-5ffa-4e77-94e5-64bc4dc09b09)
 
 Q15) Find players who scored more than 50% of the avg score scored by sum of scores for each player_id.

![15](https://github.com/Kanchan8866/Game-Analysis-Using-SQL/assets/159992336/77db96c5-6251-46a8-954b-c5a213c2b453)

 Q16)Create a stored procedure to find top n headshots_count based on each dev_id and Rank them in increasing order using Row_Number. Display difficulty as well.

![16](https://github.com/Kanchan8866/Game-Analysis-Using-SQL/assets/159992336/a0876f93-fbb1-4702-a1f8-82bf21e4cc02)

Q17) Create a function to return sum of Score for a given player_id.

![17](https://github.com/Kanchan8866/Game-Analysis-Using-SQL/assets/159992336/09f5a38e-e7ae-48b2-a650-b77324e7520b)

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



