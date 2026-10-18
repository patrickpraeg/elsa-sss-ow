copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_1_core_data_v3.dta"      "data/temp/core1.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_2_core_data_v4.dta"      "data/temp/core2.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_3_elsa_data_v4.dta"      "data/temp/core3.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_4_elsa_data_v3.dta"      "data/temp/core4.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_5_elsa_data_v4.dta"      "data/temp/core5.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_6_elsa_data_v2.dta"      "data/temp/core6.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_7_elsa_data.dta"         "data/temp/core7.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_8_elsa_data_eul_v2.dta"  "data/temp/core8.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_9_elsa_data_eul_v2.dta"  "data/temp/core9.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_10_elsa_data_eul_v4.dta" "data/temp/core10.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_11_elsa_data_eul.dta" "data/temp/core11.dta", replace

copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_2_nurse_data_v2.dta"      "data/temp/nurse02.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_4_nurse_data.dta"         "data/temp/nurse04.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_6_elsa_nurse_data_v2.dta" "data/temp/nurse06.dta", replace
use if wave == 8 using data/raw/UKDA-5050-stata/stata/stata13_se/elsa_nurse_w8w9_data_eul.dta, clear
save "data/temp/nurse08.dta", replace
use if wave == 9 using data/raw/UKDA-5050-stata/stata/stata13_se/elsa_nurse_w8w9_data_eul.dta, clear
save "data/temp/nurse09.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_11_elsa_nurse_data_eul.dta" "data/temp/nurse11.dta", replace

copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_1_ifs_derived_variables.dta"   "data/temp/wave_1_ifs_derived_variables.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_2_ifs_derived_variables.dta"   "data/temp/wave_2_ifs_derived_variables.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_3_ifs_derived_variables.dta"   "data/temp/wave_3_ifs_derived_variables.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_4_ifs_derived_variables.dta"   "data/temp/wave_4_ifs_derived_variables.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_5_ifs_derived_variables.dta"   "data/temp/wave_5_ifs_derived_variables.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_6_ifs_derived_variables.dta"   "data/temp/wave_6_ifs_derived_variables.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_7_ifs_derived_variables.dta"   "data/temp/wave_7_ifs_derived_variables.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_8_ifs_derived_variables.dta"   "data/temp/wave_8_ifs_derived_variables.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_9_ifs_derived_variables.dta"   "data/temp/wave_9_ifs_derived_variables.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_10_ifs_derived_variables.dta" "data/temp/wave_10_ifs_derived_variables.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_11_ifs_derived_variables.dta" "data/temp/wave_11_ifs_derived_variables.dta", replace

copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_1_financial_derived_variables.dta"   "data/temp/wave_1_financial_derived_variables.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_2_financial_derived_variables.dta"   "data/temp/wave_2_financial_derived_variables.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_3_financial_derived_variables.dta"   "data/temp/wave_3_financial_derived_variables.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_4_financial_derived_variables.dta"   "data/temp/wave_4_financial_derived_variables.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_5_financial_derived_variables.dta"   "data/temp/wave_5_financial_derived_variables.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_6_financial_derived_variables.dta"   "data/temp/wave_6_financial_derived_variables.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_7_financial_derived_variables.dta"   "data/temp/wave_7_financial_derived_variables.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_8_financial_derived_variables.dta"   "data/temp/wave_8_financial_derived_variables.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_9_financial_derived_variables.dta"   "data/temp/wave_9_financial_derived_variables.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_10_financial_derived_variables.dta"  "data/temp/wave_10_financial_derived_variables.dta", replace
copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_11_financial_derived_variables.dta"  "data/temp/wave_11_financial_derived_variables.dta", replace

copy "data/raw/UKDA-5050-stata/stata/stata13_se/wave_2_derived_variables.dta"  "data/temp/wave_2_derived_variables.dta", replace

use idauniq using "data/temp/core1.dta", clear
append using "data/temp/core2.dta", keep(idauniq) nolabel nonotes
append using "data/temp/core3.dta", keep(idauniq) nolabel nonotes
append using "data/temp/core4.dta", keep(idauniq) nolabel nonotes
append using "data/temp/core5.dta", keep(idauniq) nolabel nonotes
append using "data/temp/core6.dta", keep(idauniq) nolabel nonotes
append using "data/temp/core7.dta", keep(idauniq) nolabel nonotes
append using "data/temp/core8.dta", keep(idauniq) nolabel nonotes
append using "data/temp/core9.dta", keep(idauniq) nolabel nonotes
append using "data/temp/core10.dta", keep(idauniq) nolabel nonotes
append using "data/temp/core11.dta", keep(idauniq) nolabel nonotes
duplicates drop

sum idauniq

save "data/temp/panel_wide.dta", replace
