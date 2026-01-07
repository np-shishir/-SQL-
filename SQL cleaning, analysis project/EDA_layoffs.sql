-- EDA
use world_layoffs;

select *
from layoffs_staging2;

select max(total_laid_off), max(percentage_laid_off)
from layoffs_staging2;

select *
from layoffs_staging2
where percentage_laid_off=1;

select company, sum(total_laid_off) as total_laid
from layoffs_staging2
group by company
order by 2 desc;

select min(date), max(date)
from layoffs_staging2;

select industry, sum(total_laid_off) as total_laid
from layoffs_staging2
group by industry
order by 2 desc;

select *
from layoffs_staging2;

select country, sum(total_laid_off) as total_laid
from layoffs_staging2
group by country
order by 2 desc;

select year(`date`) as date_laid,
sum(total_laid_off) as total_laid
from layoffs_staging2
where `date` is not null
group by date_laid
order by 2 desc;

-- rolling total

select substring(`date`, 1, 7) as mnth,
sum(total_laid_off)
from layoffs_staging2
where date is not null
group by mnth
order by 2 desc;

select sum(total_laid_off)
from layoffs_staging2
where date is not null;

with rolling_total as
(
select substring(`date`, 1, 7) as mnth,
sum(total_laid_off) as total_off
from layoffs_staging2
where date is not null
group by mnth
order by 1 asc
)
select mnth, total_off,
sum(total_off) over(order by mnth) as Rolling_Total
from rolling_total;

select company, sum(total_laid_off) as total_laid
from layoffs_staging2
group by company
order by 2 desc;

select company, year(date),  sum(total_laid_off) as total_laid
from layoffs_staging2
group by company, year(date)
order by 3 desc;

with company_year (company, years, total_laid_off) as
(
select company, year(date),  sum(total_laid_off) as total_laid
from layoffs_staging2
group by company, year(date)
), company_year_rank as 
(
select *, dense_rank() 
over(partition by years order by total_laid_off desc) as per_year
from company_year
where years is not null
)
select * 
from company_year_rank
where per_year<=5;






