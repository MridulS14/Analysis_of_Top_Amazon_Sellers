-- Step 1: Remove Duplicates if any
-- Step 2: Standardize the Data
-- Step 3: Dealing with null or zero values
-- Step 4: Drop unnecessary columns from the staging table
-- Step 5: Add any extra columns for better analysis later if needed



-- Step 1: Remove Duplicates if any

select * from dataset2;

create table dataset2_staging like dataset2;

insert dataset2_staging select * from dataset2;

select * from dataset2_staging;


with duplicate as(
	select *, row_number() over (partition by sellerlink) as row_num
    from dataset2_staging
)
select *
from duplicate
where row_num>1;
-- There are no duplicates in this data


-- Step 2: Standardize the Data

select cast(
		nullif(
			trim(replace(
				substring_index(substring_index(sellerproductcount, ' ',-2), ' ',1),
				',', ''
			)),
            ''
		) as unsigned
    )
from dataset2_staging;

alter table dataset2_staging
add column product_count int;

update dataset2_staging
set product_count = cast(
		nullif(
			trim(replace(
				substring_index(substring_index(sellerproductcount, ' ',-2), ' ',1),
				',', ''
			)),
            ''
		) as unsigned
    );
    



select sellerratings
from dataset2_staging;

select cast(
			nullif(
				substring_index(sellerratings, '%', 1), ''
			) as unsigned
		)
from dataset2_staging;

alter table dataset2_staging
add column positive_rating_percentage int;

update dataset2_staging
set positive_rating_percentage = cast(
			nullif(
				substring_index(sellerratings, '%', 1), ''
			) as unsigned
		);
        
        
        

select cast(nullif(substring_index(substring_index(sellerratings, '(', -1), ' ', 1), '') as unsigned)
from dataset2_staging;

alter table dataset2_staging
add column rating_count int;

update dataset2_staging
set rating_count = cast(nullif(substring_index(substring_index(sellerratings, '(', -1), ' ', 1), '') as unsigned);



select businessaddress
from dataset2_staging;

select sellerlink, substring(businessaddress, -2)
from dataset2_staging;

alter table dataset2_staging
add column country varchar(255);

update dataset2_staging
set country = case
				when substring(businessaddress, -2)='US' then 'United States'
                when substring(businessaddress, -2)='CN' then 'Canada'
                when substring(businessaddress, -2)='DE' then 'Germany'
				else 'Other'
			end;
            
            



select `Sample brand name`
from dataset2_staging;

alter table dataset2_staging
change column `Sample brand name` brand_name varchar(255);

update dataset2_staging
set brand_name = replace(brand_name, 'Visit the ', '');


select sellerdetails
from dataset2_staging;

UPDATE dataset2_staging
SET sellerdetails = REPLACE(REPLACE(sellerdetails, CHAR(13), ' '), CHAR(10), ' ');

UPDATE dataset2_staging
SET sellerdetails = REPLACE(sellerdetails, '  ', ' ');

UPDATE dataset2_staging
SET sellerdetails = REPLACE(sellerdetails, '-', '');

UPDATE dataset2_staging
SET sellerdetails = replace(sellerdetails, 'ï¿½', '');


SELECT sellerdetails
FROM dataset2_staging
WHERE sellerdetails like '%@%';

ALTER TABLE dataset2_staging
add COLUMN email_id VARCHAR(255);
  
UPDATE dataset2_staging
SET email_id = CASE
    WHEN sellerdetails LIKE '%EMail:%' THEN TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(sellerdetails, 'EMail: ', -1), ' ', 1))
    WHEN sellerdetails LIKE '%Email Address:%' THEN TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(sellerdetails, 'Email Address:', -1), ' ', 1))
    WHEN sellerdetails LIKE '%Mail:%' THEN TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(sellerdetails, 'Mail: ', -1), ' ', 1))
    WHEN sellerdetails LIKE '%EMail.:%' THEN TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(sellerdetails, 'EMail.: ', -1), ' ', 1))
    ELSE NULL
END;

SELECT sellerlink, email_id, sellerdetails
FROM dataset2_staging
where email_id is not null and email_id like '%@%';

select sellerlink, email_id, sellerdetails
from dataset2_staging
where email_id = '';


SELECT sellerdetails
FROM dataset2_staging
WHERE sellerdetails like '%+%' or sellerdetails like '%Telefon:%';

ALTER TABLE dataset2_staging
add COLUMN phone_number VARCHAR(255);


UPDATE dataset2_staging
SET phone_number = TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(sellerdetails, 'Telefon: ', -1), ' ', 1))
WHERE sellerdetails LIKE '%Telefon: %';





select sellerlink, phone_number, sellerdetails
from dataset2_staging
where phone_number is not null;





-- Step 3: Dealing with null or zero values


-- select *
-- from dataset_staging
-- where rating_count is null and `Hero Product 1 #ratings` = 0;

-- delete
-- from dataset_staging
-- where rating_count is null and `Hero Product 1 #ratings` = 0;


-- select *
-- from dataset_staging
-- where rating_count < 5 and `Hero Product 1 #ratings` < 5;

-- delete
-- from dataset_staging
-- where rating_count < 5 and `Hero Product 1 #ratings` < 5;

-- select *
-- from dataset_staging
-- where rating_count < 10 and `Hero Product 1 #ratings` < 10;

-- delete
-- from dataset_staging
-- where rating_count < 10 and `Hero Product 1 #ratings` < 10;


-- select *
-- from dataset_staging
-- where `Max % of negative seller ratings - last 12 months` = 0 and rating_count is null and `Hero Product 1 #ratings` < 10;


select * 
from dataset2_staging;

-- Step 4: Drop unnecessary columns from the staging table

alter table dataset2_staging
drop column `sellerlink-url`,
drop column sellerproductcount,
drop column sellerratings,
drop column MyUnknownColumn,
drop column `seller business name`,
drop column sellerdetails;



select `Date Added`, category, sellerlink, brand_name, product_count, positive_rating_percentage, rating_count, country, `Count of seller brands` , `Hero Product 1 #ratings`, 
	`Hero Product 2 #ratings`, `Max % of negative seller ratings - last 30 days`, `Max % of negative seller ratings - last 90 days`, 
    `Max % of negative seller ratings - last 12 months`, businessaddress, `sellerstorefront-url`, `Sample Brand URL`, email_id, phone_number
from dataset2_staging;






