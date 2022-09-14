use ab_test
go
EXEC sp_rename 'ab_data.group', 'team', 'COLUMN';

create view ab_summary as --- make a new table with detail info
(
select *, year(timestamp) as year, month(timestamp) as month, day(timestamp) as day, --detail datepart from timestamp
			datepart(week,timestamp) as week, datepart(weekday,timestamp) as weekday
	from ab_data
)

select * from ab_summary

Select * into ab_testing from ab_summary