clear all
set more off
set maxvar 32767

capture mkdir "data"
capture mkdir "data/raw"
capture mkdir "data/temp"
capture mkdir "output"
capture mkdir "output/figures"
capture mkdir "output/tables"
capture mkdir "output/estimates"

capture log close
log using "output/replication.log", text replace

display "Stata " c(stata_version) " " c(flavor) " " c(os)
display c(current_date) " " c(current_time)

foreach pair in esttab:estout labmask:labutil heatplot:heatplot colorpalette:palettes scores:scores center:center binscatter:binscatter xtabond2:xtabond2 {
    tokenize `pair', parse(":")
    capture which `1'
    if _rc ssc install `3', replace
}
capture findfile _gxtile.ado
if _rc ssc install egenmore, replace
capture findfile lcolrspace.mlib
if _rc ssc install colrspace, replace
capture findfile scheme-lean1.scheme
if _rc net install gr0002_3, from("http://www.stata-journal.com/software/sj4-3") replace

do "code/01_prepare_data.do"
do "code/02_allostatic_load.do"
do "code/03_frailty.do"
do "code/04_main_analysis.do"
do "code/05_asymmetric_fe.do"
do "code/06_asymmetric_figure.do"
do "code/07_asymmetric_table.do"
do "code/08_natural_units_table.do"
do "code/09_weighted_sensitivity.do"
do "code/10_weighted_figure.do"
do "code/11_dynamic_panel_xtabond2.do"
do "code/12_anxiety_validation.do"

display c(current_date) " " c(current_time)
log close
