	
/********************************
	Papper: 
	"Determinantes e impacto de la desigualdad: Un Caso para los países en vías de desarrollo"

	Autores:
	De la Cruz Calderón, María Giovana
	Zelada Chambilla, Carlos Andrés

	Curso de Especialización de Econometría Aplicada
	Módulo: Panel Data

*/*******************************


*-------------------------------------------------------------------------------------------*
                             
						/* PARTE 1: BASES DE DATOS */
							 
*-------------------------------------------------------------------------------------------*	

clear all
global insumos "C:\Users\User\Desktop\Panel Data - Trabajo\BD inicial"
global final "C:\Users\User\Desktop\Panel Data - Trabajo\BD final"

cd "$final"

* 1. BASE DE PAISES POR GRUPO

	import excel using "$insumos\Clasificador de Paises.xls", sheet("List of economies") ///
				 cellrange(C5:G223) first clear
	drop X
	gen ind = "world"

	rename (Economy Region Incomegroup Code) (country region group countrycode)
	order region group country countrycode

	forvalues i = 1950 (1) 2016 {
	gen a`i' = 1 
	}

	reshape long a, i(countrycode country) j(year)
	drop a ind
	order year, last

	sort countrycode year
	save paises, replace

	
* 2. EXTERNAL WEALTH OF NATIONS

	import excel using "$insumos\External Wealth of Nations database\EWN 1970-2014_Feb2_2016.xlsx", sheet("Data") first clear
	rename Country country
	replace country = upper(country)
	replace country = strtrim(country)

	run "codigo de paises.do"

	order country countrycode
	keep country countrycode Year Totalassets Totalliabilities
	sort countrycode

	replace Totalassets = Totalassets*1000000
	replace Totalliabilities = Totalliabilities*1000000
	rename Year year

	drop country 
	sort countrycode year
	save EWN, replace

	
* 3. Standardized World Income Inequality database

	import delim "$insumos\Standardized World Income Inequality database\swiid6_1_summary.csv", varn(1) clear
				  
	replace country = upper(country)
	replace country = strtrim(country)

	run "codigo de paises.do"

	drop gini_disp_se  gini_mkt_se abs_red-rel_red_se

	drop country 
	order countrycode year
	sort countrycode year
	save SWIID, replace

	
* 4. WORLD ECONOMICS OUTLOOK

	import excel "$insumos\WEO Database\WEOOct2017all.xlsx", first clear
	drop a2016-EstimatesStartAfter

	replace SubjectDescriptor = "GDP_Percapita_PPP" if ///
	SubjectNotes == "GDP is expressed in constant international dollars per person. Data are derived by dividing constant price purchasing-power parity (PPP) GDP by total population."
	replace SubjectDescriptor = "GDP_percapita" if ///
	SubjectNotes == "GDP is expressed in constant national currency per person. Data are derived by dividing constant price GDP by total population."
	replace SubjectDescriptor = "GDP_real" if SubjectDescriptor == "Gross domestic product, constant prices" & WEOSubjectCode=="NGDP_R"
	replace SubjectDescriptor = "goverment_exp" if SubjectDescriptor == "General government total expenditure" & Units == "National currency"

	keep if inlist(SubjectDescriptor,"GDP_Percapita_PPP", "GDP_percapita", "goverment_exp", "GDP_real")
	compress

	forval i=1980/2015{
	replace a`i' = ""  if a`i'== "n/a"|a`i'== "--" 
	}
	forval i=1980/2015{
	destring a`i', replace 
	replace  a`i' =  a`i'*1000000000 if Scale == "Billions"
	}

	drop WEOCountryCode WEOSubjectCode Units SubjectNotes Scale CountrySeriesspecificNotes
	rename (SubjectDescriptor ISO) (indicatorname countrycode)

	levelsof indicatorname, local(nombre)

	foreach indi of local nombre{
	preserve
	keep if indicatorname == "`indi'"
	reshape long a, i(countrycode Country) j(year)
	rename a `indi'
	drop indicatorname
	tempfile `indi'_1
	save ``indi'_1', replace
	restore
	}
	clear all
	use `GDP_Percapita_PPP_1', clear
	merge 1:1 countrycode Country year using `GDP_percapita_1', nogen
	merge 1:1 countrycode Country year using `goverment_exp_1', nogen
	merge 1:1 countrycode Country year using `GDP_real_1'
	rename Country country
	drop country 
	sort countrycode year
	save WEO, replace

	
* 5. BARRO LEE - DATASET

	use "$insumos\Barro Lee",clear

	replace country = upper(country)
	keep country year yr_sch WBcode region_code
	order country WBcode region_code year yr_sch
	rename (yr_sch WBcode) (average_year_educ countrycode)

	drop country region_code
	sort countrycode year
	save Barro_lee , replace


* 6. FRASER INSTITUTE

	import excel using "$insumos\Fraser Institute.xls", sheet("All Data") ///
				 cellrange(B5:BU3503) first clear
				 
	keep Year ISO_Code Countries GovernmentConsumption Transfersandsubsidies Governmententerprisesandinves
	rename (Year ISO_Code Countries) (year countrycode country)

	gen gov_spend = (GovernmentConsumption+Transfersandsubsidies+Governmententerprisesandinves)/3
	drop GovernmentConsumption-Governmententerprisesandinves

	drop country 
	sort countrycode year
	save Fraser_inst, replace

	
* 7. JORGENSON, DALE AND KHUONG

	import excel using "$insumos\Jorgenson, dale and khuong vu.xlsx", sheet("TCB_ADJUSTED") ///
				 cellrange(A5:BU1989) first clear
				 
	local old ""
	foreach x of varlist G-BU {
	local old "`old' `x'"
	}
	local new
	forvalues i = 1950 (1) 2016 {
	local new "`new' a`i'"
	}
	rename (`old') (`new')

	keep if NR == 14 | NR == 15 | NR == 16
	drop REGION NR MEASURE
	rename (INDICATOR COUNTRY ISO) (indicatorname country countrycode)
	replace indicatorname = "Capital_Share" if indicatorname == "Capital Share"
	replace indicatorname = "ICT_Capital_Share" if indicatorname == "ICT Capital Share"
	replace indicatorname = "Non_ICT_Capital_Share" if indicatorname == "Non-ICT Capital Share"

	levelsof indicatorname, local(nombre)

	foreach indi of local nombre{
	preserve
	keep if indicatorname == "`indi'"
	reshape long a, i(countrycode country) j(year)
	rename a `indi'
	drop indicatorname
	tempfile `indi'_1
	save ``indi'_1', replace
	restore
	}
	clear all
	use `Capital_Share_1', clear
	merge 1:1 countrycode country year using `ICT_Capital_Share_1', nogen
	merge 1:1 countrycode country year using `Non_ICT_Capital_Share_1', nogen

	drop country 
	sort countrycode year
	save Jorgen_dale_khuong,replace

	
* 8. WORLD BANK POVCAL DATABASE 

	import delim "$insumos\worlds bank povcal database.csv", varn(1) clear

	duplicates tag countrycode requestyear, g(dup)
	tab dup
	drop if coveragetype != "A" & dup == 2
	drop dup

	drop isinterpolated usemicrodata regioncode datayear datatype coveragetype ppp-mean povgapsqr-decile10

	rename (requestyear headcount povgap) (year pov_ratio pov_gap)
	drop countryname 
	sort countrycode year
	save povcal_database, replace

	
* 9. World Bank World Development Indicators
 
	set excelxlsxlargefile on
	import excel using "World Bank World Develpment Indicators\WDIEXCEL.xlsx", sheet("Data") first clear
	renvars*, lower
	gen ok = 1 if inlist(indicatorname,"GDP growth (annual %)","GDP per capita growth (annual %)", ///
	"Domestic credit to private sector (% of GDP)","Employment in industry (% of total employment) (modeled ILO estimate)", ///
	"Mortality rate, adult, female (per 1,000 female adults)","Imports of goods and services (% of GDP)", ///
	"Exports of goods and services (% of GDP)")
	replace ok =1 if inlist(indicatorname,"Gross capital formation (annual % growth)","Gross capital formation (constant LCU)", ///
	"Labor force, total","Employment in agriculture (% of total employment) (modeled ILO estimate)")
	keep if ok==1
	tab indicatorname, m
	
	distinct countrycode

	replace indicatorname = "GDP growth" if indicatorname=="GDP growth (annual %)"
	replace indicatorname = "GDP per capita growth" if indicatorname=="GDP per capita growth (annual %)"
	replace indicatorname = "Credit" if indicatorname=="Domestic credit to private sector (% of GDP)"
	replace indicatorname = "Industrial employment growth" if indicatorname=="Employment in industry (% of total employment) (modeled ILO estimate)"
	replace indicatorname = "Female mortality" if indicatorname=="Mortality rate, adult, female (per 1,000 female adults)"
	replace indicatorname = "Imports percent of GDP" if indicatorname=="Imports of goods and services (% of GDP)"
	replace indicatorname = "Exports percent of GDP" if indicatorname=="Exports of goods and services (% of GDP)"
	replace indicatorname = "FBK_growth" if indicatorname=="Gross capital formation (annual % growth)"
	replace indicatorname = "FBK_constant" if indicatorname=="Gross capital formation (constant LCU)"
	replace indicatorname = "Agriculture employment percent" if indicatorname=="Employment in agriculture (% of total employment) (modeled ILO estimate)"	
	replace indicatorname = "labor_force" if indicatorname=="Labor force, total"	
	compress

	distinct countrycode
	replace indicatorname = lower(indicatorname)
	replace indicatorname = subinstr(indicatorname," ","_",.)
	levelsof indicatorname, local(nombre)

	foreach indi of local nombre{
	preserve
	keep if indicatorname == "`indi'"
	reshape long a, i(countrycode) j(year)
	rename a `indi'
	drop indicatorname indicatorcode
	save "`indi'.dta", replace
	restore
	}
	clear all
	use credit.dta, clear
	merge 1:1 countrycode year using "female_mortality", nogen
	merge 1:1 countrycode year using "gdp_growth", nogen
	merge 1:1 countrycode year using "gdp_per_capita_growth", nogen
	merge 1:1 countrycode year using "industrial_employment_growth", nogen
	merge 1:1 countrycode year using "exports_percent_of_gdp", nogen
	merge 1:1 countrycode year using "imports_percent_of_gdp", nogen
	merge 1:1 countrycode year using "fbk_growth", nogen
	merge 1:1 countrycode year using "fbk_constant", nogen
	merge 1:1 countrycode year using "labor_force", nogen
	merge 1:1 countrycode year using "agriculture_employment_percent", nogen
	
	erase "credit.dta"
	erase "female_mortality.dta"
	erase "gdp_growth.dta"
	erase "gdp_per_capita_growth.dta"
	erase "industrial_employment_growth.dta"
	erase "exports_percent_of_gdp.dta"
	erase "imports_percent_of_gdp.dta"
	erase "fbk_growth.dta"
	erase "fbk_constant.dta"
	erase "labor_force.dta"
	erase "agriculture_employment_percent.dta"
	drop ok
	save WDI.dta, replace
	
	
 * 10. UNU
	
	import excel using "UNU - WIDER database\WIID3.4_19JAN2017New.xlsx", first clear
	rename *, lower
	tab region_sub, m
	
    rename countrycode3 countrycode
	distinct country
	bys countrycode: distinct year
	
	distinct country year, joint
	gen comp = q1!=. & q2!=. & q3!=. & q4!=. & q5!=.
	tab comp
	duplicates drop countrycode year comp, force
	drop if comp==0
	distinct country year, joint
    keep country countrycode year source* d1 - d10 q1- q5 currency

	drop source* currency country
	compress
	
	save UNU.dta, replace
	
 * 11. Gini education
  
    import excel using "ginipublicexcel.xls", sheet("146stack 144matrix") cellrange(A2:C1900) first clear
    rename (Wbcode Year _gh15) (countrycode year gini_edu)
    
	sort countrycode year
	save Gini_Educ.dta, replace
  
	
*-------------------------------------------
*-------------------------------------------

	/* FUSION DE BASES */

	use paises, clear
	tab group, m

	merge 1:1 countrycode year using EWN, keep(master match) nogen
	merge 1:1 countrycode year using SWIID, keep(master match) nogen
	merge 1:1 countrycode year using WEO, keep(master match) nogen
	merge 1:1 countrycode year using Barro_lee, keep(master match) nogen
	merge 1:1 countrycode year using Fraser_inst, keep(master match) nogen
	merge 1:1 countrycode year using Jorgen_dale_khuong, keep(master match) nogen
	merge 1:1 countrycode year using povcal_database, keep(master match) nogen
	merge 1:1 countrycode year using Gini_Educ.dta, keep(master match) nogen
	merge 1:1 countrycode year using UNU_2.dta, keep(master match) nogen
	merge 1:1 countrycode year using WDI.dta, keep(master match) nogen
	compress

	save base_final,replace 




