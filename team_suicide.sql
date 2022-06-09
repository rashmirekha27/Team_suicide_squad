-- Create tables for raw data to be loaded into
CREATE TABLE suicide_data (
id INT PRIMARY KEY,
Country TEXT,
population Integer,
suicides_no Integer,
avg_suicides Integer
);

CREATE TABLE happiness_data (
id INT PRIMARY KEY,
Happiness_score Integer,
Happiness_Rank Integer,
Region TEXT
);

select * from suicide_data;
select * from happiness_data;

select a.*,b.happiness_score, b.happiness_rank, b.region from suicide_data as a
join happiness_data as b
on a.id = b.id
