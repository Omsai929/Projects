select * from ProjectSQL1.dbo.data1;
select * from ProjectSQL1.dbo.data2;

--number of rows in our dataset
select count(*) from ProjectSQL1..data1
select count(*) from ProjectSQL1..data2

--dataset for jharkhand and bihar
select * from ProjectSQL1..data1 where state in('Jharkhand','Bihar')

--population of India
select sum(population) population from ProjectSQL1..data2

--avg growth
select avg(growth)*100 avg_growth from ProjectSQL1..data1

--avg growth of a certain state
select state,avg(growth)*100 avg_growth from ProjectSQL1..data1 group by state;

--avg sex ratio
select state,round(avg(sex_ratio),0) avg_sex_ratio from ProjectSQL1..data1 group by state order by avg_sex_ratio desc;

--avg literacy rate
select state,round(avg(literacy),0) avg_literacy from ProjectSQL1..data1 group by state order by avg_literacy desc;

select state,round(avg(literacy),0) avg_literacy from ProjectSQL1..data1 
group by state having round(avg(literacy),0)>90 order by avg_literacy desc;

--top 3 states showing highest growth ratio
select top 3 state,avg(growth)*100 avg_growth from ProjectSQL1..data1 group by state order by avg_growth desc;

--bottom 5 states showing lowest sex ratio
select top 5 state,round(avg(sex_ratio),0) avg_sex_ratio from ProjectSQL1..data1 group by state order by avg_sex_ratio asc;

--displaying top 5 and bottom 5 states in literacy rate in a single table
create table #topstates
( state nvarchar(255),
  topstates float

  )

insert into #topstates
select state,round(avg(literacy),0) avg_literacy from ProjectSQL1..data1 
group by state order by avg_literacy desc;

select top 5 * from #topstates order by #topstates.topstates desc;

drop table if exists #bottomstates;
create table #bottomstates
( state nvarchar(255),
  bottomstate float
  )

insert into #bottomstates
select state,round(avg(literacy),0) avg_literacy_ratio from ProjectSQL1..data1
group by state order by avg_literacy_ratio desc;

select top 5 * from #bottomstates order by #bottomstates.bottomstate asc;

--union operator
select * from (
select top 5 * from #topstates order by #topstates.topstates desc) a
union
select * from (
select top 5 * from #bottomstates order by #bottomstates.bottomstate asc) b;

--filtering states starting with letter a 
select distinct state from ProjectSQL1..data1 where lower(state) like 'a%'
--filtering states starting with letter a and b
select distinct state from ProjectSQL1..data1 where lower(state) like 'a%' or lower(state) like 'b%'
--states starting wih letter a and ending with letter m
select distinct state from ProjectSQL1..data1 where lower(state) like 'a%' and lower(state) like '%m'

--joining both the tables and calculating population of male and female in each state and district
select d.state,sum(d.males) total_males,sum(d.females) total_females from
(select c.district,c.state state,round(c.population/(c.sex_ratio+1),0) males, round((c.population*c.sex_ratio)/(c.sex_ratio+1),0) females from
(select a.district,a.state,a.sex_ratio/1000 sex_ratio,b.population from ProjectSQL1..data1 a inner join ProjectSQL1..data2 b on a.district=b.district ) c) d
group by d.state;

--total literacy rate
select e.state,sum(e.literate_people) total_literate,sum(e.illiterate_people) total_illiterate from
(select d.district,d.state,round(d.literacy_ratio*d.population,0) literate_people,round((1-d.literacy_ratio)*d.population,0) illiterate_people from
(select a.district,a.state,a.literacy/100 literacy_ratio ,b.population from ProjectSQL1..data1 a inner join ProjectSQL1..data2 b on a.district=b.district) d)e
group by e.state

--population in previous census
select sum(f.previous_total_population) population_in_2001, sum(f.current_total_population) population_in_2011 from(
select e.state,sum(e.previous_census_population) previous_total_population, sum(e.current_census_population) current_total_population from
(select d.district,d.state,round(d.population/(1+d.growth),0) previous_census_population,d.population current_census_population from
(select a.district,a.state,a.growth growth,b.population from ProjectSQL1..data1 a inner join ProjectSQL1..data2 b on a.district=b.district) d) e
group by e.state) f

--population vs area
select m.total_area/m.population_in_2001 area_in_2001, m.total_area/m.population_in_2011 area_in_2011 from(
select q.*,r.total_area from (
select '1' as keyy,g.* from
(select sum(f.previous_total_population) population_in_2001, sum(f.current_total_population) population_in_2011 from(
select e.state,sum(e.previous_census_population) previous_total_population, sum(e.current_census_population) current_total_population from
(select d.district,d.state,round(d.population/(1+d.growth),0) previous_census_population,d.population current_census_population from
(select a.district,a.state,a.growth growth,b.population from ProjectSQL1..data1 a inner join ProjectSQL1..data2 b on a.district=b.district) d) e
group by e.state) f) g)q inner join(

select '1' as keyy,h.* from(
select sum(area_km2) total_area from ProjectSQL1..data2)h)r on q.keyy=r.keyy)m

--window functions
--output top 3 districts from each state with highest literacy rate

select a.* from
(select district,state,literacy,rank() over(partition by state order by literacy desc) rnk from ProjectSQL1..data1)a

where a.rnk in (1,2,3) order by state
