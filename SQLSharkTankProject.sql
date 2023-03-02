select * from PROJECTSQL@..sheet1

--total episodes
select count(distinct [Ep# No#]) from PROJECTSQL@..sheet1

--pitches
select count(distinct brand) from PROJECTSQL@..sheet1

--pitches converted
select cast(sum(a.converted_not_converted) as float) / cast(count(*) as float) from(
select [Amount Invested lakhs], case when [Amount Invested lakhs]>0 then 1 else 0 end as converted_not_converted from PROJECTSQL@..sheet1) a

--total male and female
select sum(male) from PROJECTSQL@..sheet1
select sum(female) from PROJECTSQL@..sheet1

--now we calculate male to female ratio
select sum(female)/sum(male) from PROJECTSQL@..sheet1

--total invested amount
select sum([Amount Invested lakhs]) from PROJECTSQL@..sheet1

--avg equity taken by sharks
select avg(a.[Equity Taken %]) from(
select * from PROJECTSQL@..sheet1 where [Equity Taken %]>0) a

--highest deal taken
select max([Amount Invested lakhs]) from PROJECTSQL@..sheet1

--highest equity taken
select max([Equity Taken %]) from PROJECTSQL@..sheet1

--The pitches where they had atleast 1 woman
select sum(a.female_count) from(
select female,case when female>0 then 1 else 0 end as female_count from PROJECTSQL@..sheet1) a

--pitches converted where they had atleast 1 woman
select * from PROJECTSQL@..sheet1
select sum(b.female_count) from(
select  case when female>0 then 1 else 0 end as female_count ,a.* from(
(select * from PROJECTSQL@..sheet1 where Deal!='No Deal')) a)b

--avg number of pitchers in each team
select avg([Team members]) from PROJECTSQL@..sheet1

--amount invested per deal
select avg(a.[Amount Invested lakhs]) amount_invested_per_deal from(
select * from PROJECTSQL@..sheet1 where deal!='No Deal') a

--Avg Age Groups of Pitchers
select [Avg age], count([Avg age]) a from PROJECTSQL@..sheet1 group by [Avg age] order by a desc

--Location from where most no. of pitchers came from
select [Location], count([Location]) a from PROJECTSQL@..sheet1 group by [Location] order by a desc

--Sector from which most pitches are from
select [Sector], count([Sector]) a from PROJECTSQL@..sheet1 group by [Sector] order by a desc

--sharks who has the most collaboration deals
select [Partners],count([Partners]) cnt from PROJECTSQL@..sheet1 where [Partners]!='-' group by Partners order by cnt desc

--Ashneer individual metrics
select * from PROJECTSQL@..sheet1

select 'Ashneer' as keyy,count([Ashneer Amount Invested]) from PROJECTSQL@..sheet1 where [Ashneer Amount Invested] is not null

select 'Ashneer' as keyy,count([Ashneer Amount Invested]) from PROJECTSQL@..sheet1 where [Ashneer Amount Invested] is not null and [Ashneer Amount Invested]!=0

SELECT 'Ashneer' as keyy,SUM(c.[Ashneer Amount Invested]),AVG(c.[Ashneer Equity Taken %])
FROM (SELECT * fROM PROJECTSQL@..sheet1 WHERE [Ashneer Equity Taken %]!=0 and [Ashneer Equity Taken %] is not null)c

select m.keyy,m.total_deals_present,m.total_deals,n.total_amount_invested,n.avg_equity_taken from

(select a.keyy,a.total_deals_present,b.total_deals from(

select 'Ashneer' as keyy,count([Ashneer Amount Invested]) total_deals_present from PROJECTSQL@..sheet1 where [Ashneer Amount Invested] is not null) a

inner join(
select 'Ashneer' as keyy,count([Ashneer Amount Invested]) total_deals from PROJECTSQL@..sheet1
where [Ashneer Amount Invested] is not null and [Ashneer Amount Invested]!=0)b
on a.keyy=b.keyy) m

inner join(
SELECT 'Ashneer' as keyy,SUM(c.[Ashneer Amount Invested]) total_amount_invested,
AVG(c.[Ashneer Equity Taken %]) avg_equity_taken
FROM (SELECT * FROM PROJECTSQL@..SHEET1 WHERE [Ashneer Equity Taken %]!=0 AND [Ashneer Equity Taken %] IS NOT NULL) C) n

on m.keyy=n.keyy

--Namita Individual Metrics

select 'Namita' as keyy,count([Namita Amount Invested]) from PROJECTSQL@..sheet1 where [Namita Amount Invested] is not null

select 'Namita' as keyy,count([Namita Amount Invested]) from PROJECTSQL@..sheet1 where [Namita Amount Invested] is not null and [Namita Amount Invested]!=0

SELECT 'Namita' as keyy,SUM(c.[Namita Amount Invested]),AVG(c.[Namita Equity Taken %])
FROM (SELECT * fROM PROJECTSQL@..sheet1 WHERE [Namita Equity Taken %]!=0 and [Namita Equity Taken %] is not null)c

select m.keyy,m.total_deals_present,m.total_deals,n.total_amount_invested,n.avg_equity_taken from

(select a.keyy,a.total_deals_present,b.total_deals from(

select 'Namita' as keyy,count([Namita Amount Invested]) total_deals_present from PROJECTSQL@..sheet1 where [Namita Amount Invested] is not null) a

inner join(
select 'Namita' as keyy,count([Namita Amount Invested]) total_deals from PROJECTSQL@..sheet1
where [Namita Amount Invested] is not null and [Namita Amount Invested]!=0)b
on a.keyy=b.keyy) m

inner join(
SELECT 'Namita' as keyy,SUM(c.[Namita Amount Invested]) total_amount_invested,
AVG(c.[Namita Equity Taken %]) avg_equity_taken
FROM (SELECT * FROM PROJECTSQL@..SHEET1 WHERE [Namita Equity Taken %]!=0 AND [Namita Equity Taken %] IS NOT NULL) C) n

on m.keyy=n.keyy

