create database election_analysis;

-- 1.Total Records in Dataset : To assure all records are imported as per cleaned data.
	-- constituencywise_details table : 8902 records
select 
	count(sr_no) 
from constituencywise_details;
	
    -- constituencywise_results table : 543 records
select 
	count(*) 
from constituencywise_results;
	
    -- partywise_results table : 42 records
select 
	count(*) 
from partywise_results;
    
    -- states : 36 records
select 
	count(*) 
from states;

    -- statewise_results : 543 records
select 
	count(*) 
from statewise_results;


CREATE TABLE constituencywise_details (
    sr_no INT,
    candidate VARCHAR(100),
    party VARCHAR(100),
    evm_votes BIGINT,
    postal_votes BIGINT,
    totaL_votes BIGINT,
    percentage_of_votes DECIMAL(10,4),
    constituency_id VARCHAR(10)
);

LOAD DATA LOCAL INFILE
'F:\FY Msc Sem-2/Election Results Project/Data/Election Processed CSV Files/constituencywise_details.csv'
INTO TABLE constituencywise_details
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(
    sr_no,
    candidate,
    party,
    evm_votes,
    postal_votes,
    totaL_votes,
    percentage_of_votes,
    constituency_id
);

-- --------------------------------------------------------------------------------------------------------------------------------------
-- 2. NOTA votes (for KPIs)
create or replace view nota_votes as
select 
	candidate,
    sum(total_votes)
from constituencywise_details
where candidate = "Nota";

-- 3.Total Candidates and Constituencies overall India (for KPIs): Insight -> Total 8096 Candidates contested elections in 543 constituencies
create or replace view Total_Candidate_Constituency as
select 
	count(distinct(candidate)) as Total_Candidate,
    count(distinct(constituency_id)) as Total_Constituency
from constituencywise_details
where candidate != "Nota";


-- 4.Party performance across states(chart)
create or replace view Statewise_Performance as
with state_party as(
	select 
		pr.party,
        s.state
	from constituencywise_results cr
	left join partywise_results pr
		on cr.party_id = pr.party_id
	left join statewise_results sr
		on cr.winning_candidate = sr.leading_candidate and cr.parliament_constituency = sr.constituency
	left join states s
		on sr.state_id = s.state_id
)
select 
	state,
	party,
    count(party) as Seats_Won
from state_party
group by state,party;

-- 4.State Wise Analysis
create or replace view state_wise_analysis as
select 
	sr.constituency as Constituency,
    sr.leading_candidate as Leading_Candidate,
    sr.trailing_candidate as Trailing_Candidate,
    sr.margin as Winning_Margin,
    s.state as State,
    pr.party as Winning_Party_Name
from statewise_results sr
left join states s
on sr.state_id=s.state_id
left join constituencywise_results cr
on sr.leading_candidate = cr.winning_candidate
left join partywise_results pr
on cr.party_id = pr.party_id
group by sr.state_id,sr.constituency;

-- --------------------------------------------------------------------------------------------------------------------------------------
-- 5.Creation of new table for map as per map labels (for map)
create table constituency as 
select * from state_wise_analysis;

update constituency
set constituency = "Anantnag - Rajouri"
where constituency = "Anantnag-Rajouri";

update constituency
set constituency = "Bikaner (SC)"
where constituency = "Bikaner";

-- 
update constituency
set constituency = "Hardwar"
where constituency = "Haridwar";

update constituency
set constituency = "Kachchh"
where constituency = "Rann of Kutch";

update constituency
set constituency = "North West Delhi"
where constituency = "North-West Delhi";

update constituency
set constituency = "Bahraich"
where constituency = "Baharaich";

update constituency
set constituency = "Gopalganj (SC)"
where constituency = "Gopalganj";

update constituency
set constituency = "Sasaram (SC)"
where constituency = "Sasaram";

update constituency
set constituency = "Surguja"
where constituency = "Surguja";

update constituency
set constituency = "Pataliputra"
where constituency = "Patliputra";

update constituency
set constituency = "Hajipur (SC)"
where constituency = "Hajipur";

update constituency
set constituency = "Samastipur (SC)"
where constituency = "Samastipur";

update constituency
set constituency = "Gaya (SC)"
where constituency = "Gaya";

update constituency
set constituency = "Jamui (SC)"
where constituency = "Jamui";

update constituency
set constituency = "Bardhaman Durgapur"
where constituency = "Bardhaman-Durgapur";

update constituency
set constituency = "Barrackpore"
where constituency = "Barrackpur";

update constituency
set constituency = "Cooch behar"
where constituency = "Coochbehar";

update constituency
set constituency = "Tura (ST)"
where constituency = "Tura";

update constituency
set constituency = "Shillong (ST)"
where constituency = "Shillong";

update constituency
set constituency = "Gauhati"
where constituency = "Guwahati";

update constituency
set constituency = "Mangaldoi"
where constituency = "Darrang-Udalguri";

update constituency
set constituency = "Nowgong"
where constituency = "Nagaon";

update constituency
set constituency = "Tezpur"
where constituency = "Sonitpur";

update constituency
set constituency = "Gadchiroli-Chimur"
where constituency = "Gadchiroli - Chimur";

update constituency
set constituency = "Yavatmal-Washim"
where constituency = "Yavatmal- Washim";

update constituency
set constituency = "Ahmadnagar"
where constituency = "Ahmednagar";

update constituency
set constituency = "Ratnagiri - sindhudurg"
where constituency = "Ratnagiri- Sindhudurg";

update constituency
set constituency = "Hatkanangle"
where constituency = "Hatkanangale";

update constituency
set constituency = "Narasaraopet"
where constituency = "Narsaraopet";

update constituency
set constituency = "Aruku"
where constituency = "Araku";

update constituency
set constituency = "Anakapalli"
where constituency = "Anakapalle";

update constituency
set constituency = "Kurnool"
where constituency = "Kurnoolu";

update constituency
set constituency = "Anantapur"
where constituency = "Ananthapur";

update constituency
set constituency = "Tirupathi"
where constituency = "Thirupathi";

update constituency
set constituency = "Thiruvallur"
where constituency = "Thiruvananthapuram";

update constituency
set constituency = "Bhandara - Gondiya"
where constituency = "Bhandara Gondiya";

update constituency
set constituency = "Barrackpore"
where constituency = "Barrackpur";

update constituency
set constituency = "Tirupati"
where constituency = "Tirupathi";

update constituency
set constituency = "Autonomous District"
where constituency = "undefined";

update constituency
set constituency = "Dadra & Nagar Haveli"
where constituency = "Dadar & Nagar Haveli";

update constituency
set constituency = "Thiruvananthapuram"
where constituency = "Thiruvallur";

update constituency
set constituency = "Secundrabad"
where constituency = "Secunderabad";

update constituency
set constituency = "North East Delhi"
where constituency = "North-East Delhi";

update constituency
set constituency = "Sarguja"
where constituency = "Surguja";

-- select * from constituency where State = "Kerala";
insert into constituency values ('Rann of Kutch','Chavda Vinod Lakhamshi','Nitesh Parbatbhai Lalan (Matang)',268782,'Gujarat','Bharatiya Janata Party');
insert into constituency values ('Thiruvallur','Sashikanth Senthil','Unknown',572155,'Tamil Nadu','Indian National Congress');
insert into constituency values ('Autonomous District','UNKNOWN','NA',00000,'Assam','Bharatiya Janata Party');

-- --------------------------------------------------------------------------------------------------------------------------------------
-- 6.NDA VS INDI Comparison (for map)
create or replace view NDAvsINDI as
select constituency,party,
case 
	when Party in ("Bharatiya Janata Party","Telugu Desam","Janata Dal (United)","Shiv Sena","Lok Janshakti Party(Ram Vilas)","Janasena Party","Janata Dal (Secular)","Rashtriya Lok Dal","United Peopleâ€™s Party, Liberal","Asom Gana Parishad","Hindustani Awam Morcha (Secular)","Nationalist Congress Party","Sikkim Krantikari Morcha","Apna Dal (Soneylal)","AJSU Party") then "ND Alliance"
    when Party in ("Indian National Congress","Samajwadi Party","All India Trinamool Congress","Dravida Munnetra Kazhagam","Shiv Sena (Uddhav Balasaheb Thackrey)","Nationalist Congress Party â€“ Sharadchandra Pawar","Rashtriya Janata Dal","Communist Party of India (Marxist)","Indian Union Muslim League","Aam Aadmi Party","Jharkhand Mukti Morcha","Communist Party of India (Marxist","Viduthalai Chiruthaigal Katchi","Communist Party of India","Jammu & Kashmir National Conference","Kerala Congress","Revolutionary Socialist Party","Rashtriya Loktantrik Party","Marumalarchi Dravida Munnetra Kazhagam","Bharat Adivasi Party") then "INDI Alliance"
    else "Independent"
end as Alliance
from constituency;


-- 7.Candidates fielded versus seats won (chart) : Insight -> Out of 745 only 37 parties were able to win seats across 543 constituencies.
create or replace view strike_rate as
with party_candidates as(
	select 
		party,
        count(candidate) as candidates,
        candidate
	from constituencywise_details 
	where party != "None Of The Above" and party != "Independent"
	group by party
	order by count(candidate) desc
)
select 
	pc.party,
    pc.candidates,
    pr.won,
    round((pr.won/pc.candidates)*100,2) as Percentage
from party_candidates pc
left join partywise_results pr
	on pc.party = pr.party;



-- 8.Average vote count per candidate in each party
create or replace view Avg_Vote_Cnt_Per_Cand as 
with party_sum_count as(
	select 
		party,
        sum(total_votes) as votes,
        count(candidate) as candidate
	from constituencywise_details
	where party != 'None Of The Above'
	group by party
)
select 
	party as Party,
    votes as Votes,
    candidate as Candidate,
    round(votes/candidate) as Average_Vote_Per_Candidate
from party_sum_count
order by round(votes/candidate) desc;

-- 9.Total Vote Share by each party (charts): Insight -> BJP has 36.56% vote share followed by Indian National Congress having 21.19%
create or replace view Party_Votes_Percentage as
with total_votes_per_party as(
	select 
		party,	
        sum(total_votes) as Party_Votes
    from constituencywise_details 
    group by party
    order by sum(total_votes) desc
),
total_votes_casted as(
	select 
		sum(total_votes) as Total_Votes
    from constituencywise_details 
)
select 
	tvpv.party as Party,
    tvpv.Party_Votes as Votes,
    round((tvpv.Party_Votes/tvc.Total_Votes)*100,5) as Vote_Share
from total_votes_per_party tvpv
cross join total_votes_casted tvc;

-- 10.State Wise Analysis
create or replace view state_wise_analysis as
select 
	sr.constituency as Constituency,
    sr.leading_candidate as Leading_Candidate,
    sr.trailing_candidate as Trailing_Candidate,
    sr.margin as Winning_Margin,
    s.state as State,
    pr.party as Winning_Party_Name
from statewise_results sr
left join states s
on sr.state_id=s.state_id
left join constituencywise_results cr
on sr.leading_candidate = cr.winning_candidate
left join partywise_results pr
on cr.party_id = pr.party_id
group by sr.state_id,sr.constituency;


-- 11.How many candidates candidates multiple constituencies (for KPIs, Charts): Insight -> 93 Candidates Contested Multiple Constituencies
create or replace view Multiple_Contested_Candidates as 
select 
	candidate as Candidate,
    party as Party,
    count(constituency_id) as Constituency_Contested
from constituencywise_details
where candidate <> "Nota"
group by candidate,party
having count(candidate) >1
order by count(candidate) desc;

-- 12.Winning Margin per Constituency of winning candidate(for charts)
create or replace view Margin_Percentage as 
with constituency_total_votes as (
	select 
		constituency_id,
        sum(total_votes) as Votes
    from constituencywise_details
    group by constituency_id
),
candidates as(
	select 
		constituency_id,
		candidate,
        party,
        total_votes,
		row_number() over(partition by constituency_id order by total_votes desc) as Rnk
    from constituencywise_details
),
top1 as(
	select 
		constituency_id,
        candidate,
        party,
        total_votes,
        Rnk
	from candidates
	where Rnk=1
),
top2 as(
	select 
		constituency_id,
		candidate,
		party,
		total_votes,
		Rnk
	from candidates
	where Rnk=2
)
select 
	t1.constituency_id,
	((t1.total_votes - t2.total_votes)/ ctv.Votes)*100 as Margin_Percent
from top1 t1
left join top2 t2
	on t1.constituency_id = t2.constituency_id
left join constituency_total_votes ctv
	on t1.constituency_id = ctv.constituency_id
order by ((t1.total_votes - t2.total_votes)/ ctv.Votes)*100 desc;


-- 13.Winnining Candidate and Party (for charts)  
create or replace view Winning_Cand_Votes as
select 
	cr.winning_candidate as Winning_Candidate,
	pr.party as Party,
    cr.parliament_constituency as Constituency,
    cr.margin as Winning_Margin,
    mp.Margin_Percent as Margin_Percent
from constituencywise_results cr
left join partywise_results pr
	on cr.party_id = pr.party_id
left join margin_percentage mp
	on cr.constituency_id = mp.constituency_id
order by mp.Margin_Percent desc ;

-- 14.Candidate with highest winning margin (for KPIs) : Insight -> Shankar Lalwani from BJP won with highest margin of 1175092 votes
create or replace view Highest_Winning_Margin as 
select 
	Winning_Candidate,
    Party,
    Constituency,
    Winning_Margin
from winning_cand_votes 
where Winning_Margin = (
						select 
							max(Winning_Margin) 
						from winning_cand_votes
                        );

-- 15.Candidate with lowest winning margin (for KPIs) : Insight ->Ravindra Dattaram Waikar from Shivsena-SHS won with lowest margin of 48 votes
create or replace view Lowest_Winning_Margin as 
select 
	Winning_Candidate,
    Party,
    Constituency,
    Winning_Margin
from winning_cand_votes 
where Winning_Margin = (
						select 
							min(Winning_Margin) 
						from winning_cand_votes 
                        where Winning_Margin != 0
					   );

-- 16. NOTA votes
create or replace view nota_votes as
select 
	candidate,
    sum(total_votes)
from constituencywise_details
where candidate = "Nota";

-- 17.Closest Constituency Contest(charts) : Insight -> 5 constituencies from different states had closest contest with less than 2000 votes 
create or replace view Close_Contest as
select 
	s.state,
	sr.constituency,
    sr.leading_candidate,
    sr.trailing_candidate,
    sr.margin
from statewise_results sr
left join states s
	on sr.state_id = s.state_id
where margin < 2000 and margin != 0;

-- 18.State-wise Party Winner Map 
create or replace view StateWise_Majority_Party as 
with demo as(
select s.state,count(cd.party) as Cnt,cd.party,
rank() over(partition by s.state order by count(cd.party) desc) as Rnk
from statewise_results sr
left join states s
on sr.state_id = s.state_id
inner join constituencywise_details cd
on sr.leading_candidate = cd.candidate
group by sr.state_id,cd.party
),
demo2 as(
	select state,Cnt,party,Rnk
	from demo 
	where Rnk =1
)
select state,cnt,party,
case 
	when count(state) > 1 then "Tie"
    when count(state) = 1 then party
end as Majority
from demo2
group by state;

create table statewise_party_majority as
select * from statewise_majority_party;

select * from statewise_party_majority;
update statewise_party_majority
set state = "Orissa"
where state = "Odisha";

update statewise_party_majority
set state = "Delhi"
where state = "Orissa" and cnt = 7;

update statewise_party_majority
set state = "Uttaranchal"
where state = "Uttarakhand";


-- 19.Constituencies represented by state
create or replace view State_Cons_Representation as
select 
	s.state as State,
	count(sr.constituency) as Total_Constituencies
from statewise_results sr
left join states s
	on sr.state_id = s.state_id
group by s.state; 

-- 20 Statewise voting count.
create or replace view state_wise_vote_count_demo as
with states as(
	select s.state,sr.constituency
	from statewise_results sr
	left join states s
	on sr.state_id = s.state_id
),
constituency as(
	select cr.parliament_constituency,sum(cd.total_votes) as Votes
    from constituencywise_results cr
    left join constituencywise_details cd
    on cd.constituency_id = cr.constituency_id
    group by cr.parliament_constituency,cr.winning_candidate 
)
select s.state,sum(Votes) as Votes,count(constituency) as cons
from states s
left join constituency c
on s.constituency = c.parliament_constituency
group by state;

-- 21.Average vote per seat statewise
create or replace view avg_vote_per_seat_statewise as
select state,cons,round((votes/cons)) as vps
from state_wise_vote_count_demo
order by round((votes/cons)) desc