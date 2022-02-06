	
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
                             
						/* PARTE 3: GRÁFICOS */
							 
*-------------------------------------------------------------------------------------------*	

clear all
global ins1 "C:\Users\User\Desktop\Panel Data - Trabajo\BD final"
global ins2 "C:\Users\User\Desktop\Panel Data - Trabajo\BD inicial"

	* Gráfico 1
	*-------------------------
	use "$ins2\World Bank World Develpment Indicators\WDIEXCEL.dta", clear
	
	keep if inlist(indicatorname,"GDP growth (annual %)","GDP per capita, PPP (constant 2011 international $)")
	replace indicatorname = "GDP_growth" if indicatorname=="GDP growth (annual %)"
	replace indicatorname = "GDP_percapita" if indicatorname=="GDP per capita, PPP (constant 2011 international $)"
	compress
	duplicates drop
	keep countryname countrycode indicatorname a2016
	
	reshape wide a2016, i(countrycode) j(indicatorname) string
	label var a2016GDP_growth "GDP growth (annual %)"
	label var a2016GDP_percapita "GDP per capita, PPP (constant 2011 international $)"
	merge 1:m countrycode using "$ins1\paises.dta", keep(match)
	
	graph set window fontface "Palatino Linotype"
	separate a2016GDP_growth, by(group)
	separate a2016GDP_percapita, by(group)
	
	twoway (scatter a2016GDP_growth1 a2016GDP_percapita1, xtitle("GDP per capita, PPP (constant 2011 international $)") ytitle("GDP growth (annual %)")) ///
	(scatter a2016GDP_growth2 a2016GDP_percapita2) (scatter a2016GDP_growth3 a2016GDP_percapita3) (scatter a2016GDP_growth4 a2016GDP_percapita4), ///
	title("Crecimiento del PBI y PBI per cápita") subtitle("Grupos de ingreso") note("1") ///
	caption("Fuente:  World Bank Development Indicators") scheme(s1color) scale(0.8) ///
	legend(order(1 "High income" 2 "Low income" 3 "Lower middle income" 4 "Upper middle income")) 
	
	* Gráfico 2
	*-------------------------
	use "$ins2\World Bank World Develpment Indicators\WDIEXCEL.dta", clear
	keep if inlist(indicatorname,"GDP per capita, PPP (constant 2011 international $)")
	replace indicatorname = "GDP_percapita" if indicatorname=="GDP per capita, PPP (constant 2011 international $)"
	merge 1:1 countrycode using "$ins2\status.dta", keep(master match)
	compress
	duplicates drop
	tab status, m
	keep if status==""
	keep countryname countrycode indicatorname a2000 a2005 a2010 a2015

	graph set window fontface "Palatino Linotype"
	twoway (kdensity a2000, , xtitle("GDP per capita, PPP (constant 2011 international $)")) ///
	(kdensity a2005) (kdensity a2010) (kdensity a2015), legend(order(1 "2000" 2 "2005" 3 "2010" 4 "2015")) ///
	scheme(s1color) scale(0.8) caption("Fuente:  World Bank Development Indicators")
	
	* Gráfico 3
	*-------------------------
	use "$ins1\base_final.dta", clear
	keep countrycode country region group year gini_disp
	drop if gini_disp==.
	keep if year == 2013 |	year==1995
	reshape wide gini_disp, i(countrycode) j(year)
	keep if gini_disp1995!=. & gini_disp2013!=.
	gen tasa = gini_disp2013/gini_disp1995-1
	merge 1:1 countrycode using "$ins2\status.dta", keep(master match) nogen
	keep if status==""
	rename countrycode adm0_a3
	merge 1:1 adm0_a3 using "C:\Users\User\Desktop\Panel Data - Trabajo Finalisimo\Hechos\world_data.dta", keepusing(id)
	rename id _id
	spmap tasa using "C:\Users\User\Desktop\Panel Data - Trabajo Finalisimo\Hechos\world_coordinates.dta", id(_id) ///
	clnumber(5) fcolor(Reds2) // ocolor(none ..)
	
	* Gráfico 4
	*-------------------------
	use "$ins1\base_final.dta", clear
	keep countrycode country region group year gini_disp gdp_growth
	drop if gini_disp==.
	keep if year == 2010 |	year==1995
	reshape wide gini_disp gdp_growth, i(countrycode) j(year)
	keep if gini_disp1995!=. & gini_disp2010!=. & gdp_growth1995!=. & gdp_growth2010!=.	
	merge 1:1 countrycode using "$ins2\status.dta", keep(master match) nogen
	keep if status==""
	drop if gdp_growth1995>30
	gen country_f = country if inlist(countrycode,"PER","MWI","BLR","UKR","COL","CHL","CHN","BOL","ARG")
	twoway (scatter gini_disp1995 gdp_growth1995, mlabel(country_f) mlabcolor(black) ///
	msymbol(triangle) mcolor(black) scale(0.8) xtitle("GDP growth (%)") ytitle("Gini (%)") ) ///
	(scatter gini_disp2010 gdp_growth2010, mlabel(country_f)), legend(order(1 "1995" 2 "2010")) scheme(s1color)
	
	* Gráfico 5 - 1 
	*-------------------------
	use "$ins1\base_final.dta", clear
	gen trade_openness = exports_percent_of_gdp + imports_percent_of_gdp
	gen fin_openness = (Totalassets + Totalliabilities)/gdp_real if (gdp_real!=. & Totalassets!=. & Totalliabilities!=.)
	gen tecn = ICT_Capital_Share/Capital_Share if ICT_Capital_Share!=. & Capital_Share!=.
	
	keep countrycode country region group year gini_disp trade_openness ///
	fin_openness tecn credit average_year_educ gini_edu labor_market_inst ///
	female_mortality gov_spend
	
	merge m:1 countrycode using "$ins2\status.dta", keep(master match) nogen
	keep if status==""
	keep if year==1995
	graph set window fontface "Palatino Linotype"
	graph matrix gini_disp trade_openness ///
	fin_openness tecn credit average_year_educ gini_edu labor_market_inst ///
	female_mortality gov_spend, half scheme(s1color)
	
	* Gráfico 5 - 2
	*-------------------------
	use "$ins1\base_final.dta", clear
	gen trade_openness = exports_percent_of_gdp + imports_percent_of_gdp
	gen fin_openness = (Totalassets + Totalliabilities)/gdp_real if (gdp_real!=. & Totalassets!=. & Totalliabilities!=.)
	gen tecn = ICT_Capital_Share/Capital_Share if ICT_Capital_Share!=. & Capital_Share!=.
	
	
	keep countrycode country region group year gini_disp trade_openness ///
	fin_openness tecn credit average_year_educ gini_edu labor_market_inst ///
	female_mortality gov_spend
	
	merge m:1 countrycode using "$ins2\status.dta", keep(master match) nogen
	keep if status==""
	keep if year==2010 // 1995 2010
	graph set window fontface "Palatino Linotype"
	graph matrix gini_disp trade_openness ///
	fin_openness tecn credit average_year_educ gini_edu labor_market_inst ///
	female_mortality gov_spend, half scheme(s1color) ms(Oh) scale(1.2) mcolor(black)
	
	
