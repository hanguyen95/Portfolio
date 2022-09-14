drop view sanity_check
--check sanity by day
create view sanity_check as
(select a.week, a.weekday, a.day, a.Xcont, b.Ncont, c.Xexp, d.Nexp
from
	(select week, weekday, day, count(converted) as Xcont
	from ab_summary
	where converted = 1 and team = 'control'
	group by week, weekday, day) as a
join
	(select week, weekday, day, count(converted) as Ncont
	from ab_summary
	where team = 'control'
	group by week, weekday, day) as b
on a.week= b.week and a.weekday= b.weekday
join
	(select week, weekday, day, count(converted) as Xexp
	from ab_summary
	where team = 'treatment' and converted = 1
	group by week, weekday, day) as c
on a.week= c.week and a.weekday= c.weekday
join
	(select week, weekday, day, count(converted) as Nexp
	from ab_summary
	where team = 'treatment'
	group by week, weekday, day) as d
on a.week= d.week and a.weekday= d.weekday)

select * from sanity_check
order by week, weekday