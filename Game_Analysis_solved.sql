Create database game_analysis;

use game_analysis;

show tables;

select * from player_details;
select * from level_details2;


alter table level_details2 modify L1_Status varchar(30);
alter table level_details2 modify L2_Status varchar(30);
alter table level_details2 modify P_ID int primary	key;
alter table level_details2 drop MyUnknownColumn;

alter table level_details2 modify Dev_ID varchar(10);
alter table level_details2 modify Difficulty varchar(15);
alter table level_details2 change timestamp start_datetime datetime;
alter table level_details2 drop MyUnknownColumn;
alter table level_details2 add primary key (P_ID , Dev_id,start_datetime);

-- Q1) Extract P_ID,Dev_ID,PName and Difficulty_level of all players at level 0

select player_details.P_ID, player_details.PName, level_Details2.Dev_ID, level_Details2.Difficulty
 from player_details
 join level_Details2 on player_details.P_ID = level_Details2.P_ID
 where Level_= 0;

-- Q2) Find Level1_code wise Avg_Kill_Count where lives_earned is 2 and atleast 3 stages are crossed

select player_details.L1_code , avg(level_Details2.Kill_count) as Avg_kill_count
from player_details
join level_Details2 
on player_details.P_ID=level_Details2.P_ID
where
Lives_Earned=2
and
Stages_crossed >=3
group by player_details.L1_Code;

-- Q3) Find the total number of stages crossed at each diffuculty level
-- where for Level2 with players use zm_series devices. Arrange the result
-- in decsreasing order of total number of stages crossed.

select Difficulty,sum(Stages_crossed) as total_stages_crossed from level_Details2
where Dev_ID like 'zm_%'
and level_ = 2
group by Difficulty
order by (total_stages_crossed)
desc;



-- Q4) Extract P_ID and the total number of unique dates for those players 
-- who have played games on multiple days.

select P_ID, count(distinct(start_datetime)) as unique_dates 
from level_Details2
group by P_ID
having unique_dates > 1
;

-- Q5) Find P_ID and level wise sum of kill_counts where kill_count
-- is greater than avg kill count for the Medium difficulty.

select P_ID, Level_, sum(Kill_Count) as total_kill_count 
from level_Details2
where Kill_Count > (
	select avg(Kill_Count) from level_Details2
	where Difficulty = 'Medium')
group by P_ID, Level_;


alter table level_details2 change timestamp start_datetime datetime;

alter table level_Details2 change Level Level_ varchar (30);


-- Q6)  Find Level and its corresponding Level code wise sum of lives earned 
-- excluding level 0. Arrange in asecending order of level.

select level_Details2.Level_, player_details.L1_Code, player_details.L2_Code,
sum(level_Details2.Lives_Earned) as total_lives_earned
from level_Details2
join player_details on level_Details2.P_ID = player_details.P_ID
where Level_ <> 0
group by level_Details2.Level_,player_details.L1_Code,player_details.L2_Code
order by Level_
asc;

-- Q7) Find Top 3 score based on each dev_id and Rank them in increasing order
-- using Row_Number. Display difficulty as well. 

WITH ScoreRanking AS (
    SELECT
        Dev_ID,
        Difficulty,
        score,
        ROW_NUMBER() OVER (
            PARTITION BY Dev_ID
            ORDER BY score DESC
        ) AS Ranked
    FROM level_Details2
)
SELECT
    Dev_ID,
    Difficulty,
    score,Ranked
FROM ScoreRanking
WHERE Ranked <= 3
ORDER BY dev_id,Ranked ;


-- Q8) Find first_login datetime for each device id

select Dev_ID,min(start_datetime) as first_login_datetime
from level_Details2
group by Dev_ID;

-- Q9) Find Top 5 score based on each difficulty level and Rank them in 
-- increasing order using Rank. Display dev_id as well.

with RR_rank as(
select Dev_ID, Difficulty,score, 
rank() over(
partition by Difficulty
order by score asc) as _Rank
from level_Details2)
select Dev_ID, Difficulty,score,  _Rank
from RR_rank
where _Rank <=5
order by Difficulty,_Rank;

-- Q10) Find the device ID that is first logged in(based on start_datetime) 
-- for each player(p_id). Output should contain player id, device id and 
-- first login datetime.

select P_ID, Dev_ID, min(start_datetime) as first_login_date 
from level_Details2
group by Dev_ID,P_ID;

-- Q11) For each player and date, how many kill_count played so far by the player. 
-- That is, the total number of games played -- by the player until that date.
-- a) window function
-- b) without window function

-- Window function

select P_ID,start_datetime,
sum(Kill_Count) over 
(partition by P_ID, start_datetime order by start_datetime) as kills
from level_details2
order by  P_ID, start_datetime;

-- without window function

 select P_ID,start_datetime,
sum(Kill_Count) as kills
from level_details2
group by P_ID, start_datetime
order by  P_ID, start_datetime;


-- Q12) Find the cumulative sum of stages crossed over a start_datetime 

select P_ID,start_datetime,
sum(Stages_crossed) over
 (partition by P_ID order by start_datetime) as stages_crossed
 from level_details2
order by  P_ID, start_datetime;

-- Q13) Find the cumulative sum of an stages crossed over a start_datetime 
-- for each player id but exclude the most recent start_datetime

with recent_start_datetime as 
(select P_ID,
max(start_datetime)  as recent_time
from 
level_details2
group by 
P_ID
),
cumulative_sum as(
select  a.P_ID, 
a.start_datetime,
sum(a.Stages_crossed) over(
 partition by a.P_ID order by a.start_datetime
 )  as cumulative_stages_crossed
 from 
 level_details2 as a
 join recent_start_datetime rsd on a.P_ID = rsd.P_ID
 and a.start_datetime < rsd.recent_time
 )
 select P_ID, start_datetime, cumulative_stages_crossed 
 from cumulative_sum
order by  P_ID,start_datetime;


-- Q14) Extract top 3 highest sum of score for each device id and the corresponding player_id

with high_score as 
(select P_ID, Dev_ID, 
sum(Score) as total_score, 
 row_number() over (partition by Dev_ID order by sum(Score) desc)
 as highest_score 
from level_details2
group by P_ID, Dev_ID
)
select P_ID, Dev_ID, total_score
from high_score
where highest_score <=3
order by  Dev_ID,total_score desc;

-- Q15) Find players who scored more than 50% of the avg score, scored by sum of 
-- scores for each player_id

select P_ID,
SUM(Score) AS total_score
from level_details2
group by P_ID
having total_score > 0.5 * (select avg(Score) from level_details2 
);
    
-- Q16) Create a stored procedure to find top n headshots_count based on each dev_id and Rank them in increasing order
-- using Row_Number. Display difficulty as well.

Delimiter //
create procedure get_top_n_headshots(
in N int
)
begin
	with top_n as (
	select 
		sum(Headshots_Count) as top_n_headshots , 
	Dev_ID, 
    Difficulty,
	row_number() over (
		partition by Dev_ID 
		order by Headshots_Count asc
        ) as n_rank
from 
	level_details2
group by 
	Dev_ID, 
    Difficulty,
    Headshots_Count
)
select Dev_ID,
	   Difficulty,
       top_n_headshots,
       n_rank
from 
	top_n
where 
	n_rank <= N
order by
	Dev_ID, 
    n_rank ;
    
end//

call get_top_n_headshots(3);

-- Q17) Create a function to return sum of Score for a given player_id.

DELIMITER // 
create function player_score(player_id int)
returns int
DETERMINISTIC NO SQL READS SQL DATA
begin 
	declare Sum_of_score int;
select 
	sum(Score) into Sum_of_score
from 
	level_details2
	where P_ID = player_id;
return Sum_of_score;
end//

SELECT player_score(211);

