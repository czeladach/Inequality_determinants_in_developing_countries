	
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
                             
						/* PARTE 2: ESTIMACIÓN */
							 
*-------------------------------------------------------------------------------------------*	

/****************************************************

	1ER MODELO GENERAL: 
	IMPACTO DE LA DESIGUALDAD EN EL CRECIMIENTO DEL PBI

*****************************************************/


set more off, perm

global base "C:\Users\User\Desktop\Panel Data - Trabajo\BD final"
cd "$base"

use "base_final.dta",clear
sort countryname 

merge 1:1 countrycode year using "paises.dta", keepusing(status) nogen

*ssc install outreg

/*PRIMER MODELO */

	gen log_gdp_pc = log(1+GDP_percapita)

	** Identificación de los observaciones con datos balanceados

	keep if year > 1997 & year <= 2010
	keep if year == 1998 | year == 2001 | year == 2004 | year == 2007 | year == 2010

	gen mod_1 = gini_disp != . & gini_mkt != . & log_gdp_pc != . & gdp_growth != . & fbk_growth != .
	keep if mod_1 == 1

	bys countrycode: gen tot = _N 
	keep if tot == 5
	drop tot mod_*

	distinct countrycode
	encode country, g(id)

	xtset id year, delta(3)

	bys id: gen log_gdp_pc0 = log_gdp_pc[1]

	gen lag_gdp_growth = l.gdp_growth

/* EXPLORATORIO : MODELO MCO POOLED */

	reg gdp_growth lag_gdp_growth gini_disp log_gdp_pc0 fbk_growth i.id i.year, vce(cluster id) // ---> Mundo
	reg gdp_growth lag_gdp_growth gini_disp log_gdp_pc0 fbk_growth i.id i.year if status == "", vce(cluster id) // ---->Emergentes
	estimates store POOLED


/* EXPLORATORIO : MODELO DE EFECTOS FIJOS Y EFECTOS ALEATORIOS */

	xtreg gdp_growth lag_gdp_growth gini_disp log_gdp_pc0 fbk_growth if status == "", fe  // ----> Efectos Fijos
	estimates store FE

	xtreg gdp_growth lag_gdp_growth gini_disp log_gdp_pc0 fbk_growth if status == "", re    // ----> Efectos Aleatorios
	estimates store RE

	tab year, g(t_)
	tab id, g(country_)

/* Robustez de coeficientes MCO, FE y Random Effects */

	estimates table POOLED FE RE, keep(lag_gdp_growth gini_disp log_gdp_pc0 fbk_growth)

	** Test de Haussman
	hausman FE RE, sigmamore 


/* ARELLANO Y BOND - MODELO SIMPLE */
	xtabond gdp_growth fbk_growth gini_disp if status == "", lag(1) end(gini_disp, lag(0,1)) end(fbk_growth, lag(0,1)) inst(country_* t_*) 


/* ARELLANO Y BOND - PANEL DINAMICO */


* RELACION ENTRE CRECIMIENTO Y DESIGUALDAD
*-----------------------------------------

* Medición de desigualdad mediante el Indice de Gini

	** Primera especificación - Model 1
		xtdpd L(0/1).gdp_growth gini_disp log_gdp_pc0  if status == "" ,  dgmmiv(gdp_growth, lag(1)) dgmmiv(gini_disp, lag(1)) lgmmiv(gdp_growth) lgmmiv(gini_disp) iv(t_* country_* log_gdp_pc0, nodi) vce(robust)
		estimates store model_1

	** Segunda especificación - Model 2
		xtdpd L(0/1).gdp_growth log_gdp_pc0 fbk_growth gini_disp  if status == "" ,  dgmmiv(gdp_growth, lag(1)) dgmmiv(gini_disp, lag(1)) dgmmiv(fbk_growth, lag(1))  lgmmiv(gdp_growth) lgmmiv(gini_disp) lgmmiv(fbk_growth)  iv(t_* country_* log_gdp_pc0, nodi) vce(robust)
		outreg using finales, replace starlevels(10 5 1) sigsymbols(*,**,***)
		estimates store model_2

		estimates table model_1 model_2


	** Medición de desigualdad mediante el quintiles de la distribución del ingreso

	reg gdp_growth lag_gdp_growth q1 log_gdp_pc0 i.id i.year if status == "", vce(cluster id) // ---->Emergentes
	reg gdp_growth lag_gdp_growth q2  log_gdp_pc0 i.id i.year if status == "", vce(cluster id) // ---->Emergentes
	reg gdp_growth lag_gdp_growth q3  log_gdp_pc0 i.id i.year if status == "", vce(cluster id) // ---->Emergentes
	reg gdp_growth lag_gdp_growth q4 log_gdp_pc0 i.id i.year if status == "", vce(cluster id) // ---->Emergentes
	reg gdp_growth lag_gdp_growth q5 log_gdp_pc0 i.id i.year if status == "", vce(cluster id) // ---->Emergentes


	** Medición Alternativa de la desigualdad mediante el quintiles de la distribución del ingreso:

	xtdpd L(0/1).gdp_growth fbk_growth log_gdp_pc0 q1   if status == ""  ,  dgmmiv(gdp_growth, lag(1)) dgmmiv(q1, lag(1)) dgmmiv(fbk_growth, lag(1)) lgmmiv(gdp_growth,lag(1)) lgmmiv(q1) iv(t_* country_* log_gdp_pc0, nodi) vce(robust)
	outreg using finales, merge replace starlevels(10 5 1) sigsymbols(*,**,***)
	estimates store q1_1
	xtdpd L(0/1).gdp_growth fbk_growth log_gdp_pc0 q2  if status == ""  ,  dgmmiv(gdp_growth, lag(1)) dgmmiv(q2, lag(1)) dgmmiv(fbk_growth, lag(1)) lgmmiv(gdp_growth, lag(1)) lgmmiv(q2) iv(t_* country_* log_gdp_pc0, nodi) vce(robust)
	outreg using finales, merge replace starlevels(10 5 1) sigsymbols(*,**,***)
	estimates store q2_1
	xtdpd L(0/1).gdp_growth fbk_growth log_gdp_pc0 q3  if status == ""  ,  dgmmiv(gdp_growth, lag(1)) dgmmiv(q3, lag(1))  dgmmiv(fbk_growth, lag(1)) lgmmiv(gdp_growth, lag(1)) lgmmiv(q3) iv(t_* country_* log_gdp_pc0, nodi) vce(robust)
	outreg using finales, merge replace starlevels(10 5 1) sigsymbols(*,**,***)
	estimates store q3_1
	xtdpd L(0/1).gdp_growth fbk_growth log_gdp_pc0 q4  if status == ""   ,  dgmmiv(gdp_growth, lag(1)) dgmmiv(q4, lag(1)) dgmmiv(fbk_growth, lag(1))  lgmmiv(gdp_growth, lag(1)) lgmmiv(q4) iv(t_* country_* log_gdp_pc0, nodi) vce(robust)
	outreg using finales, merge replace starlevels(10 5 1) sigsymbols(*,**,***)
	estimates store q4_1
	xtdpd L(0/1).gdp_growth fbk_growth log_gdp_pc0 q5   if status == ""  ,  dgmmiv(gdp_growth, lag(1)) dgmmiv(q5, lag(1)) dgmmiv(fbk_growth, lag(1)) lgmmiv(gdp_growth, lag(1)) lgmmiv(q5) iv(t_* country_* log_gdp_pc0, nodi) vce(robust)
	outreg using finales, merge replace note("Incluye dummys de control por paises y por años") starlevels(10 5 1) sigsymbols(*,**,***)
	estimates store q5_1 

	estimates table q1_1 q2_1 q3_1 q4_1 q5_1 // ---->Resumen de estimadores

 * Nota: Mayor concentracion de ingresos en los primeros quintiles (mas pobres) incrementa el crecimiento del PBI  

 
/****************************************************

	2DO MODELO GENERAL: 
	DETERMINANTES DE LA DESIGUALDAD

*****************************************************/

use "base_final.dta", clear

 /* Identificación de los observaciones con datos balanceados */
 
	gen trade_openness = exports_percent_of_gdp + imports_percent_of_gdp
	gen fin_openness = (Totalassets + Totalliabilities)/gdp_real if (gdp_real!=. & Totalassets!=. & Totalliabilities!=.)
	gen tecn = ICT_Capital_Share/Capital_Share if ICT_Capital_Share!=. & Capital_Share!=.
		
	keep countrycode country region group year gini_disp gini_mkt trade_openness ///
	fin_openness tecn credit average_year_educ gini_edu labor_market_inst ///
	female_mortality gov_spend gdp_growth industrial_employment_growth agriculture_employment_percent
		
	merge m:1 countrycode using "paises.dta", keep(master match) nogen

		gen emerging = status=="" // Identificando a los países en desarrollo o emergentes
		encode countrycode, gen(id)
		gen lac = region == "Latin America & Caribbean"
		gen high_income = group == "High income"
		compress

	foreach var of varlist gini_disp gini_mkt trade_openness fin_openness tecn credit average_year_educ gini_edu labor_market_inst female_mortality gov_spend gdp_growth industrial_employment_growth agriculture_employment_percent{
	gen m_`var' = `var'==.
	}
	egen mod2 = rowtotal(m_*)	
	drop m_*
	keep if mod2==0
	drop mod2

	bys id: gen tot = _N
	keep if tot==4
	drop tot
	tab year, m
	
/* Estructura de la data panel */
	
	xtset id year, delta(5)

/* Creación de variables interactivas */
	gen lac_credit = lac*credit
	gen lac_yeareduc = lac*average_year_educ
	sort id year
	gen l_gdp = l.gdp_growth
	gen l_gov = l.gov_spend
	gen l_credit = l.credit
	tab year, g(t_)
	tab id, g(country_)

/* Test de Hausman (FE o RE) */

	xtreg gini_disp credit gov_spend gini_edu  lac_credit  ///
	trade_openness tecn average_year_educ female_mortality fin_openness labor_market_inst if emerging == 1, fe
	estimates store FE1

	xtreg gini_disp credit gov_spend gini_edu  lac_credit  ///
	trade_openness tecn average_year_educ female_mortality fin_openness labor_market_inst if emerging == 1, re
	estimates store RE1

	hausman FE1 RE1, sigmamore // resultado: FE

* Estimación de los modelos */

	xtabond gini_disp credit gov_spend gini_edu  lac_credit  ///
	trade_openness tecn average_year_educ female_mortality fin_openness labor_market_inst if emerging == 1, lag(1) end(gini_edu average_year_educ gov_spend ) inst(country_* l_gdp agriculture_employment_percent  t_*) vce(robust)


	xtabond gini_mkt credit gov_spend gini_edu  lac_credit  ///
	trade_openness tecn average_year_educ female_mortality fin_openness labor_market_inst if emerging == 1, lag(1) end(gini_edu average_year_educ gov_spend ) inst(country_* l_gdp agriculture_employment_percent  t_*) vce(robust)


