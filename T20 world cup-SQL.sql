create database T20;
use T20;
Select * from batting_summary,bowling_summary,match_data,players_information_with_image;

-- Top 5 run Scores
Select batsmanName,SUM(runs) as total_runs From batting_summary
group by batsmanName
order by total_runs desc
limit 5;

-- Top 5 wicket-takers
select  bowlerName,SUM(wickets) as total_wickets from bowling_summary 
group by bowlerName
order by total_wickets desc
limit 5;

-- Team-wise total wins
Select winner as team , count(*) as total_wins from match_data
group by winner
order by total_wins desc;

-- Show all matches where **India** was either 'team1' or 'team2'
select * from match_data
where team1 = 'India' or team2 ='India';

-- List all batsman who scored more than **50 runs** in a match.
select batsmanName,runs from batting_summary
where runs>50;

-- Get all bowlers who took ** 3 or more wickets** in a match.
select bowlerName,wickets from bowling_summary
where wickets >=3;

-- Get the winner and venue of the match where** virat kohli ** batted.
select distinct m.matchID,m.ground as venue,m.winner from batting_summary as b
join match_data as m
ON b.matchID = m.matchID
where b.batsmanName='Virat Kohli';

-- show all players (from 'players information') who are **All rounders** and also appear in 'batting summary'
Select distinct p.name from players_information_with_image as p
Join batting_summary as b
On p.name = b.batsmanName
Where p.playingRole ='All rounder';

-- Find the top scorer in each match with match details
select m.matchID,m.team1,m.team2,m.ground as venue,m.winner,b.batsmanName,b.runs as top_score from batting_summary as b
Join Match_data as m
On b.matchID = m.matchID
where b.runs =( 
select Max(b2.runs)
from batting_summary as b2
where b2.matchID = b.matchID);

-- Find the average runs scored in each match with match details
Select matchID, avg(total_runs) as avg_runs_in_match
from(select matchID,teamInnings,sum(runs)as total_runs from batting_summary
group by matchID,teamInnings) as t
group by matchID;

-- Find the average runs scored by each team
Select teamInnings,avg(runs) as avg_runs from batting_summary
group by teamInnings;
-- Get the bowler with the **best economy rate** in each match
Select 
b.matchID,
b.bowlerName,
b.economy from bowling_summary as b
join( select matchID, min(economy) as best_economy from bowling_summary
where overs > 0
group by matchID) as x
ON  b. matchID = x.matchID
AND b.economy = x.best_economy
order by economy desc;

-- Find the total sixes hit in each match
select matchID,sum(6s) as total_sixes from batting_summary
group by matchID;

-- Find the** man of the match candidate** the batsman with highest runs or bowler with most wickets in a match. 
select t.matchID,
t.player,
t.performance
from(
select
 matchID,batsmanName as player, 
sum(runs) as performance ,
RANK() OVER(partition by matchID order by sum(runs) desc) as rnk
from batting_summary
group by matchID, batsmanName

UNION ALL

select matchID, bowlerName as player,
sum(wickets) as performance,
RANK() over (partition by matchID order by sum(wickets) desc) as rnk
 from bowling_summary
group by matchID,bowlerName
) as t 
WHERE t.rnk =1;




