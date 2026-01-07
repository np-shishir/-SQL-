create database world_layoffs;
use world_layoffs;

select * from layoffs;

-- 1. remove duplicates if any -- difficult as we donot have a unique col(e.g a PK)
-- 2. Standardize the data
-- 3. Null or blank values
-- 4. remove unnecessary columns

-- make raw data available even if the real data is changed
create table layoffs_staging
like layoffs;

select * from layoffs_staging;

insert layoffs_staging
select * from layoffs;

-- identify duplicates

with duplicate_cte as
(
	select *,
	row_number() over(
	partition by company,location, industry, total_laid_off,
		percentage_laid_off, `date`, stage, country,
		funds_raised_millions) as row_num
	from layoffs_staging
)
select * from duplicate_cte 
where row_num>1;

select *
from layoffs_staging 
where company = 'Casper';

-- create table to store non-duplicates
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



-- insert all data
insert into layoffs_staging2
select *,
	row_number() over(
	partition by company,location, industry, total_laid_off,
		percentage_laid_off, `date`, stage, country,
		funds_raised_millions) as row_num
	from layoffs_staging;
    
select *
from layoffs_staging2
where row_num>1;

-- delete duplicates i.e. row_number>1
delete
from layoffs_staging2
where row_num>1;

select *
from layoffs_staging2
where row_num>1;

-- Standardizing the data

# trim the unwanted space
select company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

select distinct industry
from layoffs_staging2
order by industry;

# Crypto, CryptoCurrency and Crypto Currency should be same not different fields
select *
from layoffs_staging2
where industry like '%Crypto%';

update layoffs_staging2
set industry = 'Crypto'
where industry like '%Crypto%';

select distinct country
from layoffs_staging2
where country like '%United States%'
order by 1;

# United States and United States. are taken as different country
update layoffs_staging2
set country = 'United States'
where country like '%United States%';

# the date column is text data type
select date 
from layoffs_staging2;

select date,
str_to_date(date, '%m/%d/%Y') -- use m,d,Y
from layoffs_staging2;

update layoffs_staging2
set date = str_to_date(date, '%m/%d/%Y');

# even after doing such, the column is still in text format. so,

alter table layoffs_staging2
modify column `date` DATE;


-- 3. Working with null and blank values

select *
from layoffs_staging2
where industry is null
or industry = '';

select * 
from layoffs_staging
where company like '%Airbnb%';

# fill missing values from other available values
select *
from layoffs_staging2 as t1
join layoffs_staging2 as t2
	on t1.company = t2.company
    and t1.location = t2.location
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;

#change blank fields to null to fill with values later
update layoffs_staging2
set industry = null
where industry = '';

update layoffs_staging2 as t1
join layoffs_staging2 as t2
	on t1.company = t2.company
set t1.industry = t2.industry
where (t1.industry is null or t1.industry = '')
and t2.industry is not null;


select * from layoffs_staging2
where industry is null or industry='';

# data having no data has little signifance so we delete them
select *
from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

delete from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;


# the row_num column we added to identify the duplicate rows need to be dropped
alter table layoffs_staging2
drop column row_num;

select *
from layoffs_staging2;










