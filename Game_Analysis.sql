
use game_analysis;

-- Problem Statement - Game Analysis dataset
-- 1) Players play a game divided into 3-levels (L0,L1 and L2)
-- 2) Each level has 3 difficulty levels (Low,Medium,High)
-- 3) At each level,players have to kill the opponents using guns/physical fight
-- 4) Each level has multiple stages at each difficulty level.
-- 5) A player can only play L1 using its system generated L1_code.
-- 6) Only players who have played Level1 can possibly play Level2 
--    using its system generated L2_code.
-- 7) By default a player can play L0.
-- 8) Each player can login to the game using a Dev_ID.
-- 9) Players can earn extra lives at each stage in a level.

alter table pd modify L1_Status varchar(30);
alter table pd modify L2_Status varchar(30);
alter table pd modify P_ID int primary key;
alter table pd drop myunknowncolumn;

alter table ld drop myunknowncolumn;
alter table ld change timestamp start_datetime datetime;
alter table ld modify Dev_Id varchar(10);
alter table ld modify Difficulty varchar(15);
alter table ld add primary key(P_ID,Dev_id,start_datetime);

-- pd (P_ID,PName,L1_status,L2_Status,L1_code,L2_Code)
-- ld (P_ID,Dev_ID,start_time,stages_crossed,level,difficulty,kill_count,
-- headshots_count,score,lives_earned)


-- Q1) Extract P_ID,Dev_ID,PName and Difficulty_level of all players 
-- at level 0
-- Q2) Find Level1_code wise Avg_Kill_Count where lives_earned is 2 and atleast
--    3 stages are crossed
-- Q3) Find the total number of stages crossed at each diffuculty level
-- where for Level2 with players use zm_series devices. Arrange the result
-- in decsreasing order of total number of stages crossed.
-- Q4) Extract P_ID and the total number of unique dates for those players 
-- who have played games on multiple days.
-- Q5) Find P_ID and level wise sum of kill_counts where kill_count
-- is greater than avg kill count for the Medium difficulty.
-- Q6)  Find Level and its corresponding Level code wise sum of lives earned 
-- excluding level 0. Arrange in asecending order of level.
-- Q7) Find Top 3 score based on each dev_id and Rank them in increasing order
-- using Row_Number. Display difficulty as well. 
-- Q8) Find first_login datetime for each device id
-- Q9) Find Top 5 score based on each difficulty level and Rank them in 
-- increasing order using Rank. Display dev_id as well.
-- Q10) Find the device ID that is first logged in(based on start_datetime) 
-- for each player(p_id). Output should contain player id, device id and 
-- first login datetime.
-- Q11) For each player and date, how many kill_count played so far by the player. That is, the total number of games played -- by the player until that date.
-- a) window function
-- b) without window function
-- Q12) Find the cumulative sum of stages crossed over a start_datetime 
-- Q13) Find the cumulative sum of an stages crossed over a start_datetime 
-- for each player id but exclude the most recent start_datetime
-- Q14) Extract top 3 highest sum of score for each device id and the corresponding player_id
-- Q15) Find players who scored more than 50% of the avg score scored by sum of 
-- scores for each player_id
-- Q16) Create a stored procedure to find top n headshots_count based on each dev_id and Rank them in increasing order
-- using Row_Number. Display difficulty as well.
-- Q17) Create a function to return sum of Score for a given player_id.

-- Q3_Response2
select sum(level_Details2.Stages_crossed) as total_stages_crossed, player_details.L2_Status 
from level_Details2
join 
	player_details
on level_Details2.P_ID = player_details.P_ID
	where Dev_ID like 'zm_%'
group by Difficulty,L2_Status
order by (total_stages_crossed)
desc;

-- Q-12 Response 2
select P_ID,start_datetime,
sum(Stages_crossed) over(
 partition by P_ID order by start_datetime
 rows between unbounded preceding and current row)
 as cumulative_stages_crossed
 from level_details2
order by  P_ID,start_datetime;

-- Q 14 response 2-3 
with high_score as 
(select P_ID, Dev_ID, 
sum(Score) as highest_score 
from level_details2
group by P_ID, Dev_ID
),
Rankscore as (
select P_ID, Dev_ID, 
row_number() over (partition by Dev_ID
order by highest_score desc)
as highest_score
from high_score )
select P_ID, Dev_ID, highest_score
from Rankscore
where highest_score <=3
order by Dev_ID, highest_score ;

 
  WITH TopScores AS (
    SELECT
        Dev_ID,
        P_ID,
        SUM(Score) AS total_score,
        ROW_NUMBER() OVER (PARTITION BY Dev_ID ORDER BY SUM(Score)  DESC) AS score_rank
    FROM
        level_details2
    GROUP BY
        Dev_ID,
        P_ID
)
SELECT
    Dev_ID,
    P_ID,
    total_score
FROM
    TopScores
WHERE
    score_rank <= 3
ORDER BY
    Dev_ID,
    total_score DESC
;


-- Q-15 Resopnse 2-3
with some_of_score as (
select P_ID,
SUM(Score) AS total_score
from level_details2
group by P_ID
),
average_score as(
select P_ID,
avg(total_score) as Avg_total_score
from some_of_score
),
player_above_threshold as(
select s.P_ID,
s.total_score
from 
some_of_score s
cross join average_score avg
where s.total_score > avg.average_score * 0.5
)
select P_ID,
total_score
from player_above_threshold;

WITH some_of_score AS (
    SELECT
        P_ID,
        SUM(Score) AS total_score
    FROM
        level_details2
    GROUP BY
        P_ID
),
average_score AS (
    SELECT
        AVG(total_score) AS Avg_total_score
    FROM
        some_of_score
),
player_above_threshold AS (
    SELECT
        s.P_ID,
        s.total_score
    FROM
        some_of_score s
        CROSS JOIN average_score avg
    WHERE
        s.total_score > avg.Avg_total_score * 0.5
)
SELECT
    P_ID,
    total_score
FROM
    player_above_threshold;
    