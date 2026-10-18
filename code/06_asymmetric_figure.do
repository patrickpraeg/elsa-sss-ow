// Figure 2
clear all

use "output/estimates/main_estimates.dta", clear
keep depvar outcome fe
merge 1:1 depvar using "output/estimates/asymmetric_estimates.dta", nogenerate assert(match)

gen continuous = 0
replace continuous = 1 if inlist(depvar, "health", "cesd", "hedonicwellbeing", "evaluativewellbeing", "meaningfulness", "anxiety", "loneliness", "physical_activity", "mobility")
replace continuous = 1 if inlist(depvar, "adl", "iadl", "gtspd_av", "gripstrength", "memory", "fluency", "cancellation", "trig", "hba1c")
replace continuous = 1 if inlist(depvar, "fibrinogen", "lhscrp")
replace continuous = 1 if inlist(depvar, "bmi", "allostatic", "hdlchol", "frailty")

local n_outcomes = _N
local bz = invnormal(1 - 0.05/(2*`n_outcomes'))

gen b_fall  = -b_neg
gen se_fall = se_neg
foreach s in pos fall {
    gen `s'_lb      = b_`s' - 1.96 * se_`s'
    gen `s'_ub      = b_`s' + 1.96 * se_`s'
    gen `s'_lb_bonf = b_`s' - `bz' * se_`s'
    gen `s'_ub_bonf = b_`s' + `bz' * se_`s'
    gen nonsig_`s'  = (`s'_lb_bonf <= 0 & `s'_ub_bonf >= 0)
}
gen sig_asym = abs(b_asym/se_asym) > `bz'
replace outcome = outcome + " †" if sig_asym

egen sort_continuous = rank(fe) if continuous==1, unique
egen sort_binary     = rank(fe) if continuous==0, unique
labmask sort_continuous if continuous==1, value(outcome)
labmask sort_binary     if continuous==0, value(outcome)

gen yc_p = sort_continuous + 0.17
gen yc_f = sort_continuous - 0.17
gen yb_p = sort_binary + 0.17
gen yb_f = sort_binary - 0.17

local cp "navy"
local cf "maroon"

twoway (scatter sort_continuous b_pos if continuous==1, msymbol(none)) ///
       (scatter yc_p b_pos  if nonsig_pos==0 & continuous==1, msymbol(d) msize(*.4) mcolor(`cp')) ///
       (scatter yc_p b_pos  if nonsig_pos==1 & continuous==1, msymbol(d) msize(*.4) mcolor(`cp'%30)) ///
       (rspike pos_lb pos_ub yc_p if nonsig_pos==0 & continuous==1, horizontal lwidth(thick) lcolor(`cp'%70)) ///
       (rspike pos_lb pos_ub yc_p if nonsig_pos==1 & continuous==1, horizontal lwidth(thick) lcolor(`cp'%30)) ///
       (rspike pos_lb_bonf pos_ub_bonf yc_p if nonsig_pos==0 & continuous==1, horizontal lcolor(`cp'%70)) ///
       (rspike pos_lb_bonf pos_ub_bonf yc_p if nonsig_pos==1 & continuous==1, horizontal lcolor(`cp'%30)) ///
       (scatter yc_f b_fall if nonsig_fall==0 & continuous==1, msymbol(d) msize(*.4) mcolor(`cf')) ///
       (scatter yc_f b_fall if nonsig_fall==1 & continuous==1, msymbol(d) msize(*.4) mcolor(`cf'%30)) ///
       (rspike fall_lb fall_ub yc_f if nonsig_fall==0 & continuous==1, horizontal lwidth(thick) lcolor(`cf'%70)) ///
       (rspike fall_lb fall_ub yc_f if nonsig_fall==1 & continuous==1, horizontal lwidth(thick) lcolor(`cf'%30)) ///
       (rspike fall_lb_bonf fall_ub_bonf yc_f if nonsig_fall==0 & continuous==1, horizontal lcolor(`cf'%70)) ///
       (rspike fall_lb_bonf fall_ub_bonf yc_f if nonsig_fall==1 & continuous==1, horizontal lcolor(`cf'%30)) ///
       , xscale(alt) xtitle("Association with health per rung of change in status" "Regression coefficient") ///
       title({bf:A}, span bexpand justification(left)) ///
       xlabel(, format(%6.2f)) xline(0) ///
       legend(order(2 "Increase in status (per rung)" 8 "Decrease in status (per rung, sign reversed)") ring(1) pos(6) rows(1) region(lstyle(none)) size(small)) ///
       ytitle("") ylabel(1/23, val labsize(small)) name(asym_continuous, replace)

twoway (scatter sort_binary b_pos if continuous==0, msymbol(none)) ///
       (scatter yb_p b_pos  if nonsig_pos==0 & continuous==0, msymbol(d) msize(*.4) mcolor(`cp')) ///
       (scatter yb_p b_pos  if nonsig_pos==1 & continuous==0, msymbol(d) msize(*.4) mcolor(`cp'%30)) ///
       (rspike pos_lb pos_ub yb_p if nonsig_pos==0 & continuous==0, horizontal lwidth(thick) lcolor(`cp'%70)) ///
       (rspike pos_lb pos_ub yb_p if nonsig_pos==1 & continuous==0, horizontal lwidth(thick) lcolor(`cp'%30)) ///
       (rspike pos_lb_bonf pos_ub_bonf yb_p if nonsig_pos==0 & continuous==0, horizontal lcolor(`cp'%70)) ///
       (rspike pos_lb_bonf pos_ub_bonf yb_p if nonsig_pos==1 & continuous==0, horizontal lcolor(`cp'%30)) ///
       (scatter yb_f b_fall if nonsig_fall==0 & continuous==0, msymbol(d) msize(*.4) mcolor(`cf')) ///
       (scatter yb_f b_fall if nonsig_fall==1 & continuous==0, msymbol(d) msize(*.4) mcolor(`cf'%30)) ///
       (rspike fall_lb fall_ub yb_f if nonsig_fall==0 & continuous==0, horizontal lwidth(thick) lcolor(`cf'%70)) ///
       (rspike fall_lb fall_ub yb_f if nonsig_fall==1 & continuous==0, horizontal lwidth(thick) lcolor(`cf'%30)) ///
       (rspike fall_lb_bonf fall_ub_bonf yb_f if nonsig_fall==0 & continuous==0, horizontal lcolor(`cf'%70)) ///
       (rspike fall_lb_bonf fall_ub_bonf yb_f if nonsig_fall==1 & continuous==0, horizontal lcolor(`cf'%30)) ///
       , xscale(alt) xtitle("Association with health per rung of change in status" "Average marginal effect") ///
       title({bf:B}, span bexpand justification(left)) ///
       xlabel(, format(%6.3f)) xline(0) legend(off) ///
       ytitle("") ylabel(1/14, val labsize(small)) name(asym_binary, replace) fysize(45)

graph combine asym_continuous asym_binary, col(1) ysize(13) xsize(8) name(asymmetric, replace)
graph export "output/figures/asymmetric.pdf", replace

gen sig_pos  = nonsig_pos==0
gen sig_fall = nonsig_fall==0
// Counts of Bonferroni-significant increases, decreases and differences in the Results
di _n "Bonferroni-significant: increase, decrease, asymmetry"
count if sig_pos
count if sig_fall
count if sig_asym
list depvar if sig_asym, noobs
list depvar if sig_fall, noobs
list depvar if sig_pos, noobs
save "output/estimates/asymmetric_comparison.dta", replace
