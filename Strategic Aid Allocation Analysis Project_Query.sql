/*SHOW ALL DATA*/
select*
from `strategic-aid-allocation.Country_Data.country`;


/*BAB 1*/

/*1.1 ECONOMIC DISPARITY PROFILE*/
#TOTAL COUNTRY WITH MIN/MAX GDP
select
    count(country) as total_negara,
    min(gdpp) as gdp_minimal,
    max(gdpp) as gdp_maksimal
from `strategic-aid-allocation.Country_Data.country`;

#LIST 5 COUNTRY WITH MINIMUM GDP
select country, gdpp
from `strategic-aid-allocation.Country_Data.country`
order by gdpp asc
limit 5;

#LIST 5 COUNTRY WITH MAXIMUM GDP
select country, gdpp
from `strategic-aid-allocation.Country_Data.country`
order by gdpp desc
limit 5;

/*1.2 FERTILITY LEVEL ANALYSIS*/
#LIST 5 COUNTRY WITH HIGHER FERTILITY LEVEL
select country, total_fer
from `strategic-aid-allocation.Country_Data.country`
order by total_fer desc
limit 5;

#LIST 5 COUNTRY WITH LOWER FERTILITY LEVEL
select country, total_fer
from `strategic-aid-allocation.Country_Data.country`
order by total_fer asc
limit 5;

/*1.3 LIFE EXPECTANCY ANALYSIS*/
#LIST 5 COUNTRY WITH HIGHER LIFE EXPECTANCY LEVEL
select country, life_expec
from `strategic-aid-allocation.Country_Data.country`
order by life_expec desc
limit 5;

#LIST 5 COUNTRY WITH LOWER LIFE EXPECTANCY LEVEL
select country, life_expec
from `strategic-aid-allocation.Country_Data.country`
order by life_expec asc
limit 5;

/*1.4 IDENTIFYING HIGH INFLATION*/
#LIST 5 COUNTRY WITH HIGHER INFLATION
select country, inflation
from `strategic-aid-allocation.Country_Data.country`
order by inflation desc
limit 5;

#LIST 5 COUNTRY WITH LOWER INFLATION 
select country, inflation
from `strategic-aid-allocation.Country_Data.country`
order by inflation asc
limit 5;

/*1.5 RELATIONSHIP BETWEEN INCOME AND HEALTH*/
#
(select 'Top Income' as kategori, country, income, child_mort
from `strategic-aid-allocation.Country_Data.country`
order by income desc
limit 5)
union all
(select 'Lowest Child Mortality' as kategori, country, income, child_mort
from `strategic-aid-allocation.Country_Data.country`
order by child_mort asc
limit 5);

/*BAB 2*/

/*2.1 CONVERT HEALTH BUDGET TO USD*/
#ACTUAL HEALTH EXPENDITURE PER PERSON IN USD (FORMULA: HEALTH/100 * GDPP)
select
    country,
    gdpp,
    health AS health_percentage,
    round((health / 100) * gdpp, 2) AS health_usd
from `strategic-aid-allocation.Country_Data.country`
order by health_usd desc;

/*2.2 TRADE BALANCE ANALYSIS*/
#DIFFERENCE BETWEEN EXPORT AND IMPORT IN USD (FORMULAS: (EXPORT-IMPORT)*(GDPP/100))
select
country,
exports as ekspor_persen,
imports as impor_persen,
gdpp,
round(((exports - imports) * (gdpp / 100)), 2) as selisih_ekspor_usd,
case
    when (exports - imports) * (gdpp / 100) > 0 then 'Surplus'
    when (exports - imports) * (gdpp / 100) < 0 then 'Defisit'
    else 'Seimbang'
end as status_perdagangan
from `strategic-aid-allocation.Country_Data.country`
where (exports - imports) * (gdpp / 100) <> 0
order by selisih_ekspor_usd desc;

/*2.3 COMPARISON OF PRODUCTION AND INCOME*/
#DIFFERENCE BETWEEN GDP AND CITIZENS' INCOME
select
    country,
    gdpp,
    income,
    (gdpp - income) as selisih_gdp_income,
    round(((gdpp - income) / gdpp) * 100, 2) as persentase_selisih
from `strategic-aid-allocation.Country_Data.country`
order by selisih_gdp_income desc;

/*BAB 3*/

/*3.1 ECONOMIC LEVEL SEGMENTATION*/
#CATEGORY AND AVERAGE OF ECONOMIC 
select
    case
      when gdpp < 2000 then 'Rendah (<$2000)'
      when gdpp between 2000 and 10000 then 'Menengah ($2000-$10000)'
      else 'Tinggi (>$10000)'
    end as kategori_gdp,
    count(*) as jumlah_negara,
    round(avg(child_mort), 2) as rata_rata_kematian_anak
from `strategic-aid-allocation.Country_Data.country`
group by kategori_gdp
order by avg(gdpp) asc;

#LIST OF COUNTRY WITH LOW GDP CATEGORY (< $2000)
select
    country,
    gdpp
from `strategic-aid-allocation.Country_Data.country`
where gdpp < 2000
order by gdpp asc;

/*3.2 FERTILITY LEVEL SEGMENTATION*/
#CATEGORY, TOTAL COUNTRY, AND AVERAGE OF FERTILITY
select
case
    when total_fer < 2 then 'Rendah (<2)'
    when total_fer between 2 and 4 then 'Menengah (2-4)'
    else 'Tinggi (>4)'
end as kategori_kesuburan,
count(*) as jumlah_negara,
round(avg(income), 2) as rata_rata_pendapatan
from `strategic-aid-allocation.Country_Data.country`
group by kategori_kesuburan
order by rata_rata_pendapatan desc;

#AVERAGE INCOME OF RESIDENTS IN HIGH FERTILITY CATEGORY
select
case
    when total_fer < 2 then 'Rendah (<2)'
    when total_fer between 2 and 4 then 'Menengah (2-4)'
    else 'Tinggi (>4)'
end as kategori_kesuburan,
count(*) as jumlah_negara,
round(avg(income), 2) as rata_rata_pendapatan
from `strategic-aid-allocation.Country_Data.country`
group by kategori_kesuburan
having kategori_kesuburan = 'Tinggi (>4)';

#LIST COUNTRY WITH HIGHER FERTILITY LEVEL
select
    country,
    total_fer
from `strategic-aid-allocation.Country_Data.country`
where total_fer >4
order by total_fer desc;

/*3.3 IMPACT OF INFLATION ON LIFE EXPECTANCY*/
#CATEGORY AND AVERAGE OF INFLATION
select
    case
      when inflation < 5 then 'Stabil (<5%)'
      when inflation between 5 and 15 then 'Moderat (5–15%)'
      else 'Tinggi (>15%)'
      end as kategori_inflasi,
      count(*) as jumlah_negara,
      round (avg(life_expec),2) as rata_rata_harapan_hidup
from `strategic-aid-allocation.Country_Data.country`
group by kategori_inflasi
order by rata_rata_harapan_hidup;

#LIST OF COUNTRY WITH HIGHER INFLATION CATEGORY
select
   country,
   inflation
from `strategic-aid-allocation.Country_Data.country`
where inflation >15
order by inflation desc;

/*BAB 4*/

/*4.1 DETERMINING STATISTICAL THRESHOLDS*/
#25th PERCENTILE VALUE OF GDPP Value of GDPP (POVERTY THRESHOLD)
select
approx_quantiles(gdpp, 100)[offset(25)] as gdpp_p25
from `strategic-aid-allocation.Country_Data.country`;

#75th PERCENTILE VALUE OF CHILD MORTALITY (HEALTH CRISIS THRESHOLD)
select
approx_quantiles(child_mort, 100)[offset(75)] as child_mort_p75
from `strategic-aid-allocation.Country_Data.country`;

/*4.2 PRIORITY COUNTRY FILTRATION*/
#LIST OF RED ZONE COUNTRIES SORTED BY BELOW GDP THRESHOLD AND ABOVE CHILD MORTALITY THRESHOLD
with ambang_batas as (
    select
      approx_quantiles(gdpp, 100)[offset(25)] as gdpp_p25,
      approx_quantiles(child_mort, 100)[OFFSET(75)] as child_mort_p75
    from `strategic-aid-allocation.Country_Data.country`
)
select
    country,
    gdpp,
    child_mort
from `strategic-aid-allocation.Country_Data.country`,
    ambang_batas
where gdpp < ambang_batas.gdpp_p25
and child_mort > ambang_batas.child_mort_p75
order by child_mort desc;

/*BAB 5*/

/*5.1 SELECTION OF 10 PRIORITY COUNTRIES*/
#DETERMINE THE 10 COUNTRIES WITH THE LOWEST LIFE EXPECTANCY IN ABSOLUTE TERMS BASED ON CHAPTER 4
with ambang_batas as (
    select
      approx_quantiles(gdpp, 100)[offset(25)] as gdpp_p25,
      approx_quantiles(child_mort, 100)[offset(75)] as child_mort_p75
    from `strategic-aid-allocation.Country_Data.country`),
zona_merah as (
    select
        country,
        gdpp,
        child_mort,
        life_expec
    from `strategic-aid-allocation.Country_Data.country`,
        ambang_batas
    where gdpp < ambang_batas.gdpp_p25
      and child_mort > ambang_batas.child_mort_p75
)
select
    country,
    gdpp,
    child_mort,
    life_expec
from zona_merah
order by life_expec asc
limit 10;