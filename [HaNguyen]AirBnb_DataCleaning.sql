use airbnb
select * from rawdata

--1.Delete unused column

alter table rawdata
drop column listing_url, scrape_id, last_scraped, description, neighborhood_overview, picture_url, host_url,
			name, host_about, host_thumbnail_url, host_picture_url, host_listings_count, host_verifications, neighbourhood,
			neighbourhood_group_cleansed, latitude, longitude, bathrooms, amenities, minimum_minimum_nights, maximum_minimum_nights,
			minimum_maximum_nights, maximum_maximum_nights, minimum_nights_avg_ntm, maximum_nights_avg_ntm, calendar_updated,
			availability_30, availability_60, availability_90, availability_365, calendar_last_scraped, license
alter table rawdata
drop column host_total_listings_count

--2.Standardize date format

select host_since, convert(date,host_since),
		first_review, convert(date, first_review),
		last_review, convert(date, last_review)
from rawdata

update rawdata
set host_since = convert(date,host_since),
		first_review = convert(date, first_review),
		last_review = convert(date, last_review)

alter table rawdata
add host_since_converted date,
	first_review_convert date,
	last_review_convert date

update rawdata
set host_since_converted = convert(date,host_since),
	first_review_convert = convert(date, first_review),
	last_review_convert = convert(date, last_review)

alter table rawdata
drop column host_since, first_review, last_review

--3.Change name of column

use airbnb
select * from rawdata

exec sp_rename 'rawdata.list_id', 'property_id', 'column';
exec sp_rename 'rawdata.neighbourhood_cleansed', 'neighbourhood_by_coordinates', 'column';
exec sp_rename 'rawdata.has_availability', 'property_pic', 'column';


--4.Change 't' to 'Yes', 'f' to 'No', N/A to 'null' in host_is_superhost, host_has_profile_pic, host_identity_verified and property_pic fields
select host_is_superhost, count(*) from rawdata
group by host_is_superhost

select property_pic, count(*) from rawdata
group by property_pic

select host_is_superhost,
		case when host_is_superhost = 't' then 'Yes'
			when host_is_superhost = 'f' then 'No'
			else 'No'
		end
from rawdata

update rawdata
set host_is_superhost =
		case when host_is_superhost = 't' then 'Yes'
			when host_is_superhost = 'f' then 'No'
			else 'No'
		end,
	host_has_profile_pic =
		case when host_has_profile_pic = 't' then 'Yes'
			when host_has_profile_pic = 'f' then 'No'
			else 'No'
		end,
	host_identity_verified =
		case when host_identity_verified = 't' then 'Yes'
			when host_identity_verified = 'f' then 'No'
			else 'No'
		end,
	property_pic =
		case when property_pic = 't' then 'Yes'
			when property_pic = 'f' then 'No'
			else 'No'
		end


--5.Group host's location into country
use airbnb
select * from rawdata

select host_location, count(*) from rawdata
group by host_location
order by 2 desc

alter table rawdata
add host_country varchar(50)

update rawdata
set host_country =  'Australia'
where host_location in
	(select host_location from rawdata
	where host_location like '%Australia%'
	or host_location like 'AU')

update rawdata
set host_country =  'Argentina'
where host_location in
	(select host_location from rawdata
	where host_location like '%Argentina%'
	or host_location like 'AR')

update rawdata
set host_country =  'Austria'
where host_location in
	(select host_location from rawdata
	where host_location like '%Austria%'
	or host_location like 'AT')

update rawdata
set host_country =  'Bangladesh'
where host_location in
	(select host_location from rawdata
	where host_location like '%Bangladesh%'
	or host_location like 'BD')

update rawdata
set host_country =  'Bulgaria'
where host_location in
	(select host_location from rawdata
	where host_location like '%Bulgaria%'
	or host_location like 'BG')

update rawdata
set host_country =  'Canada'
where host_location in
	(select host_location from rawdata
	where host_location like '%Canada%'
	or host_location like 'CA')


update rawdata
set host_country =  'Cambodia'
where host_location in
	(select host_location from rawdata
	where host_location like '%Cambodia%'
	or host_location like 'KH')

update rawdata
set host_country = 'China'
where host_location in
	(select host_location from rawdata
	where host_location like '%China%'
	or host_location like 'CN')

update rawdata
set host_country =  'Denmark'
where host_location in
	(select host_location from rawdata
	where host_location like '%Denmark%'
	or host_location like 'DK')

update rawdata
set host_country =  'Egypt'
where host_location in
	(select host_location from rawdata
	where host_location like '%Egypt%'
	or host_location like 'EG')


update rawdata
set host_country =  'Finland'
where host_location in
	(select host_location from rawdata
	where host_location like '%Finland%'
	or host_location like 'FI')

	update rawdata
set host_country =  'France'
where host_location in
	(select host_location from rawdata
	where host_location like '%France%'
	or host_location like 'FR')

update rawdata
set host_country =  'Germany'
where host_location in
	(select host_location from rawdata
	where host_location like '%Germany%'
	or host_location like 'DE')

update rawdata
set host_country =  'Hong Kong'
where host_location in
	(select host_location from rawdata
	where host_location like '%Hong Kong%'
	or host_location like 'HK')

update rawdata
set host_country = 'India'
where host_location in
	(select host_location from rawdata
	where host_location like '%India%'
	or host_location like 'IN')

update rawdata
set host_country =  'Indonesia'
where host_location in
	(select host_location from rawdata
	where host_location like '%Indonesia%'
	or host_location like 'ID')

update rawdata
set host_country =  'Israel'
where host_location in
	(select host_location from rawdata
	where host_location like '%Israel%'
	or host_location like 'IL')


update rawdata
set host_country =  'Italy'
where host_location in
	(select host_location from rawdata
	where host_location like '%Italy%'
	or host_location like 'IT')

update rawdata
set host_country =  'Kenya'
where host_location in
	(select host_location from rawdata
	where host_location like '%Kenya%'
	or host_location like 'KE')

update rawdata
set host_country =  'Jamaica'
where host_location in
	(select host_location from rawdata
	where host_location like '%Jamaica%'
	or host_location like 'JM')

update rawdata
set host_country = 'Japan'
where host_location in
	(select host_location from rawdata
	where host_location like '%Japan%'
	or host_location like 'JP')

update rawdata
set host_country =  'Laos'
where host_location in
	(select host_location from rawdata
	where host_location like '%Lao%'
	or host_location like 'LA')

update rawdata
set host_country =  'Latvia'
where host_location in
	(select host_location from rawdata
	where host_location like '%Latvia%'
	or host_location like 'LV')

update rawdata
set host_country =  'Malta'
where host_location in
	(select host_location from rawdata
	where host_location like '%Malta%'
	or host_location like 'MT')

update rawdata
set host_country =  'Malaysia'
where host_location in
	(select host_location from rawdata
	where host_location like '%Malaysia%'
	or host_location like 'MY')

update rawdata
set host_country =  'Myanmar'
where host_location in
	(select host_location from rawdata
	where host_location like '%Myanmar%'
	or host_location like 'MM')


update rawdata
set host_country =  'Macau'
where host_location in
	(select host_location from rawdata
	where host_location like '%Macau%'
	or host_location like '%Macao')


update rawdata
set host_country =  'Netherlands'
where host_location in
	(select host_location from rawdata
	where host_location like '%Netherlands%'
	or host_location like 'NL')

update rawdata
set host_country =  'New Zealand'
where host_location in
	(select host_location from rawdata
	where host_location like '%New Zealand%'
	or host_location like 'NZ')

update rawdata
set host_country =  'Norway'
where host_location in
	(select host_location from rawdata
	where host_location like '%Norway%'
	or host_location like 'NO')

update rawdata
set host_country =  'Pakistan'
where host_location in
	(select host_location from rawdata
	where host_location like '%Pakistan%'
	or host_location like 'PK')

update rawdata
set host_country =  'Philippines'
where host_location in
	(select host_location from rawdata
	where host_location like '%Philippines%'
	or host_location like 'PH')


update rawdata
set host_country =   'Peru'
where host_location in
	(select host_location from rawdata
	where host_location like '%Peru%'
	or host_location like 'PE')

update rawdata
set host_country =  'Portugal'
where host_location in
	(select host_location from rawdata
	where host_location like '%Portugal%')


update rawdata
set host_country =   'Qatar'
where host_location in
	(select host_location from rawdata
	where host_location like '%Qatar%'
	or host_location like 'QA')

update rawdata
set host_country =   'Russia'
where host_location in
	(select host_location from rawdata
	where host_location like '%Russia%'
	or host_location like 'RU')

update rawdata
set host_country =   'Senegal'
where host_location in
	(select host_location from rawdata
	where host_location like '%Senegal%'
	or host_location like 'SN')

update rawdata
set host_country =   'Serbia' 
where host_location in
	(select host_location from rawdata
	where host_location like '%Serbia%'
	or host_location like 'RS')

update rawdata
set host_country =   'Spain'
where host_location in
	(select host_location from rawdata
	where host_location like '%Spain%'
	or host_location like 'ES')

	update rawdata
set host_country = 'Singapore'
where host_location in
	(select host_location from rawdata
	where host_location like '%Singapore%'
	or host_location like 'SG')

update rawdata
set host_country =  'Sweden'
where host_location in
	(select host_location from rawdata
	where host_location like '%Sweden%'
	or host_location like 'SE')

update rawdata
set host_country =  'Switzerland'
where host_location in
	(select host_location from rawdata
	where host_location like '%Switzerland%'
	or host_location like 'CH')


update rawdata
set host_country =  'South Korea'
where host_location in
	(select host_location from rawdata
	where host_location like '%Korea%'
	or host_location like 'KR')

update rawdata
set host_country =  'Saudi Arabia'
where host_location in
	(select host_location from rawdata
	where host_location like '%Saudi Arabia%'
	or host_location like 'SA')


select host_location, host_country from rawdata where host_country is null

update rawdata
set host_country = 'Thailand'
where host_location in
	(select host_location from rawdata
	where host_location like '%thailand%'
	or host_location like '%bangkok%'
	or host_location like '%bkk%'
	or host_location like 'TH'
	or host_location like 'patumtanee'
	or host_location like 'Chachoengsao'
	or host_location like '%Surin%'
	or host_location like '%buri%'
	or host_location like '%Prakan%'
	or host_location like '%MRT%'
	or host_location like '%BTS%'
	or host_location like '%rayong%'
	or host_location like '%Ladkrabang%'
	or host_location like '%thong&'
	or host_location like '%thamonthon%'
	or host_location like '%sawan%'
	or host_location like '%ang thong%')

update rawdata
set host_country =  'Taiwan'
where host_location in
	(select host_location from rawdata
	where host_location like '%Taiwan%'
	or host_location like 'TW'
	or host_location like '%Taipei%')

update rawdata
set host_country =  'Turkey'
where host_location in
	(select host_location from rawdata
	where host_location like '%Turkey%'
	or host_location like 'TR')

update rawdata
set host_country = 'United States'
where host_location in
	(select host_location from rawdata
	where host_location like 'US'
	or host_location like '%United States%')

update rawdata
set host_country =  'United Arab Emirates'
where host_location in
	(select host_location from rawdata
	where host_location like '%United Arab Emirates%')

update rawdata
set host_country =  'United Kingdom'
where host_location in
	(select host_location from rawdata
	where host_location like '%United Kingdom%'
	or host_location like 'GB'
	or host_location like '%UK')


update rawdata
set host_country =  'Viet Nam'
where host_location in
	(select host_location from rawdata
	where host_location like '%VietNam%'
	or host_location like 'VN')

select host_location, host_country from rawdata where host_country is null

update rawdata
set host_country =  'Other'
where host_country is null

--6.Change N/A to null
select host_response_time, count(*)
from rawdata
group by host_response_time

update rawdata
set host_response_time =
		case when host_response_time = 'N/A' then Null
			else host_response_time
		end

select * from rawdata

--7.Seperate to Available when last_revew >= 2019
----------------Not Available when last_review < 2019 and

select last_review_convert, status from rawdata
where last_review_convert < '2019-01-01'

alter table rawdata
add Status varchar(50)

update rawdata
set Status = 
case when last_review_convert < '2019-01-01' then 'Not available' else 'Available' end

---------------
