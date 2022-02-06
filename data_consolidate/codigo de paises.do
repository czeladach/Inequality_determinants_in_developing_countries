
gen countrycode = ""


replace countrycode = "AFG" if  strpos(country,"AFGHA")
replace countrycode = "ALB" if  strpos(country,"ALBAN")
replace countrycode = "DZA" if  strpos(country,"ALGER")
replace countrycode = "ASM" if  strpos(country,"AMERI")
replace countrycode = "AND" if  strpos(country,"ANDOR")
replace countrycode = "AGO" if  strpos(country,"ANGOL")
replace countrycode = "ATG" if  strpos(country,"ANTIG")
replace countrycode = "ARG" if  strpos(country,"ARGEN")
replace countrycode = "ARM" if  strpos(country,"ARMEN")
replace countrycode = "ABW" if  strpos(country,"ARUBA")
replace countrycode = "AUS" if  strpos(country,"AUSTRIA")
replace countrycode = "AUT" if  strpos(country,"AUSTRAL")
replace countrycode = "AZE" if  strpos(country,"AZERB")
replace countrycode = "BHS" if  strpos(country,"BAHAM")
replace countrycode = "BHR" if  strpos(country,"BAHRA")
replace countrycode = "BGD" if  strpos(country,"BANGL")
replace countrycode = "BRB" if  strpos(country,"BARBA")
replace countrycode = "BLR" if  strpos(country,"BELAR")
replace countrycode = "BEL" if  strpos(country,"BELGI")
replace countrycode = "BLZ" if  strpos(country,"BELIZ")
replace countrycode = "BEN" if  strpos(country,"BENIN")
replace countrycode = "BMU" if  strpos(country,"BERMU")
replace countrycode = "BTN" if  strpos(country,"BHUTA")
replace countrycode = "BOL" if  strpos(country,"BOLIV")
replace countrycode = "BIH" if  strpos(country,"BOSNI")
replace countrycode = "BWA" if  strpos(country,"BOTSW")
replace countrycode = "BRA" if  strpos(country,"BRAZI")
replace countrycode = "VGB" if  strpos(country,"BRITI")
replace countrycode = "BRN" if  strpos(country,"BRUNE")
replace countrycode = "BGR" if  strpos(country,"BULGA")
replace countrycode = "BFA" if  strpos(country,"BURKI")
replace countrycode = "BDI" if  strpos(country,"BURUN")
replace countrycode = "CPV" if  strpos(country,"VERDE")
replace countrycode = "KHM" if  strpos(country,"CAMBO")
replace countrycode = "CMR" if  strpos(country,"CAMER")
replace countrycode = "CAN" if  strpos(country,"CANAD")
replace countrycode = "CYM" if  strpos(country,"CAYMA")
replace countrycode = "CAF" if  strpos(country,"CENTR")
replace countrycode = "TCD" if  strpos(country,"CHAD")
replace countrycode = "CHI" if  strpos(country,"CHANN")
replace countrycode = "CHL" if  strpos(country,"CHILE")
replace countrycode = "CHN" if  strpos(country,"CHINA")
replace countrycode = "COL" if  strpos(country,"COLOM")
replace countrycode = "COM" if  strpos(country,"COMOR")
replace countrycode = "COG" if  strpos(country,"CONGO")
replace countrycode = "COD" if  strpos(country,"CONGO, D")
replace countrycode = "CRI" if  strpos(country,"COSTA")
replace countrycode = "CIV" if  strpos(country,"IVOIRE")
replace countrycode = "HRV" if  strpos(country,"CROAT")
replace countrycode = "CUB" if  strpos(country,"CUBA")
replace countrycode = "CUW" if  strpos(country,"CURACAO")
replace countrycode = "CYP" if  strpos(country,"CYPRU")
replace countrycode = "CZE" if  strpos(country,"CZECH")
replace countrycode = "DNK" if  strpos(country,"DENMA")
replace countrycode = "DJI" if  strpos(country,"DJIBO")
replace countrycode = "DMA" if  strpos(country,"DOMINICA")
replace countrycode = "DOM" if  strpos(country,"DOMINICAN")
replace countrycode = "ECU" if  strpos(country,"ECUAD")
replace countrycode = "EGY" if  strpos(country,"EGYPT")
replace countrycode = "SLV" if  strpos(country,"EL SA")
replace countrycode = "GNQ" if  strpos(country,"EQUAT")
replace countrycode = "ERI" if  strpos(country,"ERITR")
replace countrycode = "EST" if  strpos(country,"ESTON")
replace countrycode = "ETH" if  strpos(country,"ETHIO")
replace countrycode = "FRO" if  strpos(country,"FAERO")
replace countrycode = "FJI" if  strpos(country,"FIJI")
replace countrycode = "FIN" if  strpos(country,"FINLA")
replace countrycode = "FRA" if  strpos(country,"FRANC")
replace countrycode = "PYF" if  strpos(country,"FRENC")
replace countrycode = "GAB" if  strpos(country,"GABON")
replace countrycode = "GMB" if  strpos(country,"GAMBI")
replace countrycode = "GEO" if  strpos(country,"GEORG")
replace countrycode = "DEU" if  strpos(country,"GERMA")
replace countrycode = "GHA" if  strpos(country,"GHANA")
replace countrycode = "GIB" if  strpos(country,"GIBRA")
replace countrycode = "GRC" if  strpos(country,"GREEC")
replace countrycode = "GRL" if  strpos(country,"GREEN")
replace countrycode = "GRD" if  strpos(country,"GRENA")
replace countrycode = "GUM" if  strpos(country,"GUAM")
replace countrycode = "GTM" if  strpos(country,"GUATE")
replace countrycode = "GIN" if  country == "GUINEA" 
replace countrycode = "GNB" if  strpos(country,"BISSAU")
replace countrycode = "GUY" if  strpos(country,"GUYAN")
replace countrycode = "HTI" if  strpos(country,"HAITI")
replace countrycode = "HND" if  strpos(country,"HONDU")
replace countrycode = "HKG" if  strpos(country,"HONG ")
replace countrycode = "HUN" if  strpos(country,"HUNGA")
replace countrycode = "ISL" if  strpos(country,"ICELA")
replace countrycode = "IND" if  strpos(country,"INDIA")
replace countrycode = "IDN" if  strpos(country,"INDON")
replace countrycode = "IRN" if  strpos(country,"IRAN")
replace countrycode = "IRQ" if  strpos(country,"IRAQ")
replace countrycode = "IRL" if  strpos(country,"IRELA")
replace countrycode = "IMN" if  strpos(country,"ISLE ")
replace countrycode = "ISR" if  strpos(country,"ISRAE")
replace countrycode = "ITA" if  strpos(country,"ITALY")
replace countrycode = "JAM" if  strpos(country,"JAMAI")
replace countrycode = "JPN" if  strpos(country,"JAPAN")
replace countrycode = "JOR" if  strpos(country,"JORDA")
replace countrycode = "KAZ" if  strpos(country,"KAZAK")
replace countrycode = "KEN" if  strpos(country,"KENYA")
replace countrycode = "KIR" if  strpos(country,"KIRIB")
replace countrycode = "PRK" if  strpos(country,"KOREA")
replace countrycode = "KOR" if  strpos(country,"KOREA")
replace countrycode = "XKX" if  strpos(country,"KOSOV")
replace countrycode = "KWT" if  strpos(country,"KUWAI")
replace countrycode = "KGZ" if  strpos(country,"KYRGY")
replace countrycode = "LAO" if  strpos(country,"LAO")
replace countrycode = "LVA" if  strpos(country,"LATVI")
replace countrycode = "LBN" if  strpos(country,"LEBAN")
replace countrycode = "LSO" if  strpos(country,"LESOT")
replace countrycode = "LBR" if  strpos(country,"LIBER")
replace countrycode = "LBY" if  strpos(country,"LIBYA")
replace countrycode = "LIE" if  strpos(country,"LIECH")
replace countrycode = "LTU" if  strpos(country,"LITHU")
replace countrycode = "LUX" if  strpos(country,"LUXEM")
replace countrycode = "MAC" if  strpos(country,"MACAO")
replace countrycode = "MKD" if  strpos(country,"MACED")
replace countrycode = "MDG" if  strpos(country,"MADAG")
replace countrycode = "MWI" if  strpos(country,"MALAW")
replace countrycode = "MYS" if  strpos(country,"MALAY")
replace countrycode = "MDV" if  strpos(country,"MALDI")
replace countrycode = "MLI" if  strpos(country,"MALI")
replace countrycode = "MLT" if  strpos(country,"MALTA")
replace countrycode = "MHL" if  strpos(country,"MARSH")
replace countrycode = "MRT" if  strpos(country,"MAURITANIA")
replace countrycode = "MUS" if  strpos(country,"MAURITIUS")
replace countrycode = "MEX" if  strpos(country,"MEXIC")
replace countrycode = "FSM" if  strpos(country,"MICRO")
replace countrycode = "MDA" if  strpos(country,"MOLDO")
replace countrycode = "MCO" if  strpos(country,"MONAC")
replace countrycode = "MNG" if  strpos(country,"MONGO")
replace countrycode = "MNE" if  strpos(country,"MONTE")
replace countrycode = "MAR" if  strpos(country,"MOROC")
replace countrycode = "MOZ" if  strpos(country,"MOZAM")
replace countrycode = "MMR" if  strpos(country,"MYANM")
replace countrycode = "NAM" if  strpos(country,"NAMIB")
replace countrycode = "NRU" if  strpos(country,"NAURU")
replace countrycode = "NPL" if  strpos(country,"NEPAL")
replace countrycode = "NLD" if  strpos(country,"NETHE")
replace countrycode = "ANT" if  strpos(country,"ANTILLES")
replace countrycode = "NCL" if  strpos(country,"NEW C")
replace countrycode = "NZL" if  strpos(country,"NEW Z")
replace countrycode = "NIC" if  strpos(country,"NICAR")
replace countrycode = "NER" if  strpos(country,"NIGER")
replace countrycode = "NGA" if  strpos(country,"NIGERIA")
replace countrycode = "MNP" if  strpos(country,"NORTH")
replace countrycode = "NOR" if  strpos(country,"NORWA")
replace countrycode = "OMN" if  strpos(country,"OMAN")
replace countrycode = "PAK" if  strpos(country,"PAKIS")
replace countrycode = "PLW" if  strpos(country,"PALAU")
replace countrycode = "PAN" if  strpos(country,"PANAM")
replace countrycode = "PNG" if  strpos(country,"PAPUA")
replace countrycode = "PRY" if  strpos(country,"PARAG")
replace countrycode = "PER" if  strpos(country,"PERU")
replace countrycode = "PHL" if  strpos(country,"PHILI")
replace countrycode = "POL" if  strpos(country,"POLAN")
replace countrycode = "PRT" if  strpos(country,"PORTU")
replace countrycode = "PRI" if  strpos(country,"PUERT")
replace countrycode = "QAT" if  strpos(country,"QATAR")
replace countrycode = "ROU" if  strpos(country,"ROMAN")
replace countrycode = "RUS" if  strpos(country,"RUSSI")
replace countrycode = "RWA" if  strpos(country,"RWAND")
replace countrycode = "WSM" if  strpos(country,"SAMOA")
replace countrycode = "SMR" if  strpos(country,"SAN M")
replace countrycode = "STP" if  strpos(country,"NCIPE")
replace countrycode = "SAU" if  strpos(country,"SAUDI")
replace countrycode = "SEN" if  strpos(country,"SENEG")
replace countrycode = "SRB" if  strpos(country,"SERBI")
replace countrycode = "SYC" if  strpos(country,"SEYCH")
replace countrycode = "SLE" if  strpos(country,"SIERR")
replace countrycode = "SGP" if  strpos(country,"SINGA")
replace countrycode = "SXM" if  strpos(country,"SINT ")
replace countrycode = "SVK" if  strpos(country,"SLOVA")
replace countrycode = "SVN" if  strpos(country,"SLOVE")
replace countrycode = "SLB" if  strpos(country,"SOLOM")
replace countrycode = "SOM" if  strpos(country,"SOMAL")
replace countrycode = "ZAF" if  strpos(country,"SOUTH")
replace countrycode = "SDN" if  strpos(country,"SUDAN")
replace countrycode = "SSD" if  strpos(country,"SOUTH SUDAN")
replace countrycode = "ESP" if  strpos(country,"SPAIN")
replace countrycode = "LKA" if  strpos(country,"SRI L")
replace countrycode = "KNA" if  strpos(country," KITTS")
replace countrycode = "LCA" if  strpos(country," LUCIA")
replace countrycode = "MAF" if  strpos(country,"ST. M")
replace countrycode = "VCT" if  strpos(country,"ST. V") |  strpos(country,"VINC") 
replace countrycode = "SUR" if  strpos(country,"SURIN")
replace countrycode = "SWZ" if  strpos(country,"SWAZI")
replace countrycode = "SWE" if  strpos(country,"SWEDE")
replace countrycode = "CHE" if  strpos(country,"SWITZ")
replace countrycode = "SYR" if  strpos(country,"SYRIA")
replace countrycode = "TWN" if  strpos(country,"TAIWA")
replace countrycode = "TJK" if  strpos(country,"TAJIK")
replace countrycode = "TZA" if  strpos(country,"TANZA")
replace countrycode = "THA" if  strpos(country,"THAIL")
replace countrycode = "TLS" if  strpos(country,"TIMOR")
replace countrycode = "TGO" if  strpos(country,"TOGO")
replace countrycode = "TON" if  strpos(country,"TONGA")
replace countrycode = "TTO" if  strpos(country,"TRINI")
replace countrycode = "TUN" if  strpos(country,"TUNIS")
replace countrycode = "TUR" if  strpos(country,"TURKE")
replace countrycode = "TKM" if  strpos(country,"TURKM")
replace countrycode = "TCA" if  strpos(country,"TURKS")
replace countrycode = "TUV" if  strpos(country,"TUVAL")
replace countrycode = "UGA" if  strpos(country,"UGAND")
replace countrycode = "UKR" if  strpos(country,"UKRAI")
replace countrycode = "ARE" if  strpos(country,"UNITED ARAB")
replace countrycode = "GBR" if  strpos(country,"UNITED KING")
replace countrycode = "USA" if  strpos(country,"UNITED STATES")
replace countrycode = "URY" if  strpos(country,"URUGU")
replace countrycode = "UZB" if  strpos(country,"UZBEK")
replace countrycode = "VUT" if  strpos(country,"VANUA")
replace countrycode = "VEN" if  strpos(country,"VENEZ")
replace countrycode = "VNM" if  strpos(country,"VIET")
replace countrycode = "VIR" if  strpos(country,"VIRGI")
replace countrycode = "PSE" if  strpos(country,"WEST ")
replace countrycode = "YEM" if  strpos(country,"YEMEN")
replace countrycode = "ZMB" if  strpos(country,"ZAMBIA")
replace countrycode = "ZWE" if  strpos(country,"ZIMBA")
replace countrycode = "JSY" if  strpos(country,"JERSEY")
replace countrycode = "AGL" if  strpos(country,"ANGUILLA")
replace countrycode = "MTS" if  strpos(country,"MONTSERRAT")
replace countrycode = "GRY" if  strpos(country,"GUERN")
replace countrycode = "EUA" if  strpos(country,"EURO AREA")
replace countrycode = "YUGf" if strpos(country,"YUGOSLAV")
replace countrycode = "SUN" if strpos(country,"SOVIET")
replace countrycode = "PAL" if strpos(country,"PALESTIN")
replace countrycode = "CSK" if strpos(country,"OSLOVAKIA")
