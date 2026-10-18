// Figure S5
clear all

use "output/estimates/main_estimates.dta", clear
keep depvar outcome fe
merge 1:1 depvar using "output/estimates/weighted_estimates.dta", nogenerate assert(match)
merge 1:1 depvar using "output/estimates/weighted_diff.dta", nogenerate assert(match)

gen continuous = 0
replace continuous = 1 if inlist(depvar, "health", "cesd", "hedonicwellbeing", "evaluativewellbeing", "meaningfulness", "anxiety", "loneliness", "physical_activity", "mobility")
replace continuous = 1 if inlist(depvar, "adl", "iadl", "gtspd_av", "gripstrength", "memory", "fluency", "cancellation", "trig", "hba1c")
replace continuous = 1 if inlist(depvar, "fibrinogen", "lhscrp")
replace continuous = 1 if inlist(depvar, "bmi", "allostatic", "hdlchol", "frailty")

local n_outcomes = _N
local bz = invnormal(1 - 0.05/(2*`n_outcomes'))
di "Number of outcomes: `n_outcomes'   Bonferroni z: `bz'"

foreach s in x l {
    gen `s'_diff = `s'_w - `s'_u
    assert abs(`s'_diff - `s'_d) < 1e-8
    gen `s'_ub      = `s'_diff + 1.96 * `s'_d_se
    gen `s'_lb      = `s'_diff - 1.96 * `s'_d_se
    gen `s'_ub_bonf = `s'_diff + `bz' * `s'_d_se
    gen `s'_lb_bonf = `s'_diff - `bz' * `s'_d_se
    gen nonsig_`s'  = (`s'_lb_bonf <= 0 & `s'_ub_bonf >= 0)
    gen `s'_ratio_w = `s'_sew / `s'_w_se
    gen `s'_ratio_u = `s'_seu / `s'_u_se
}
summarize x_ratio_w x_ratio_u l_ratio_w l_ratio_u
summarize x_gap l_gap

gen chk_x = x_seu / x_u_xtse
gen chk_l = l_seu / l_u_xtse
summarize chk_x chk_l
replace x_w_se  = x_sew
replace x_u_se  = x_seu
replace l_w_se  = l_sew
replace l_u_se  = l_seu
replace u_full_se = u_full_xtse

egen sort_continuous = rank(fe) if continuous==1, unique
egen sort_binary     = rank(fe) if continuous==0, unique
labmask sort_continuous if continuous==1, value(outcome)
labmask sort_binary     if continuous==0, value(outcome)

gen yc_x = sort_continuous + 0.17
gen yc_l = sort_continuous - 0.17
gen yb_x = sort_binary + 0.17
gen yb_l = sort_binary - 0.17

local cx "navy"
local cl "maroon"

twoway (scatter sort_continuous x_diff if continuous==1, msymbol(none)) ///
       (scatter yc_x x_diff if nonsig_x==0 & continuous==1, msymbol(d) msize(*.4) mcolor(`cx')) ///
       (scatter yc_x x_diff if nonsig_x==1 & continuous==1, msymbol(d) msize(*.4) mcolor(`cx'%25)) ///
       (rspike x_lb x_ub yc_x if nonsig_x==0 & continuous==1, horizontal lwidth(thick) lcolor(`cx'%70)) ///
       (rspike x_lb x_ub yc_x if nonsig_x==1 & continuous==1, horizontal lwidth(thick) lcolor(`cx'%25)) ///
       (rspike x_lb_bonf x_ub_bonf yc_x if nonsig_x==0 & continuous==1, horizontal lcolor(`cx'%70)) ///
       (rspike x_lb_bonf x_ub_bonf yc_x if nonsig_x==1 & continuous==1, horizontal lcolor(`cx'%25)) ///
       (scatter yc_l l_diff if nonsig_l==0 & continuous==1, msymbol(d) msize(*.4) mcolor(`cl')) ///
       (scatter yc_l l_diff if nonsig_l==1 & continuous==1, msymbol(d) msize(*.4) mcolor(`cl'%25)) ///
       (rspike l_lb l_ub yc_l if nonsig_l==0 & continuous==1, horizontal lwidth(thick) lcolor(`cl'%70)) ///
       (rspike l_lb l_ub yc_l if nonsig_l==1 & continuous==1, horizontal lwidth(thick) lcolor(`cl'%25)) ///
       (rspike l_lb_bonf l_ub_bonf yc_l if nonsig_l==0 & continuous==1, horizontal lcolor(`cl'%70)) ///
       (rspike l_lb_bonf l_ub_bonf yc_l if nonsig_l==1 & continuous==1, horizontal lcolor(`cl'%25)) ///
       , xscale(alt) xtitle("Difference in subjective SES coefficient" "(weighted minus unweighted, same sample)") ///
       title({bf:A}, span bexpand justification(left)) ///
       xlabel(, format(%6.2f)) xline(0) ///
       legend(order(2 "Cross-sectional weights" 8 "Longitudinal weights") ring(1) pos(6) rows(1) region(lstyle(none))) ///
       ytitle(Outcome) ylabel(1/23, val labsize(small)) name(wdiff_continuous, replace)

twoway (scatter sort_binary x_diff if continuous==0, msymbol(none)) ///
       (scatter yb_x x_diff if nonsig_x==0 & continuous==0, msymbol(d) msize(*.4) mcolor(`cx')) ///
       (scatter yb_x x_diff if nonsig_x==1 & continuous==0, msymbol(d) msize(*.4) mcolor(`cx'%25)) ///
       (rspike x_lb x_ub yb_x if nonsig_x==0 & continuous==0, horizontal lwidth(thick) lcolor(`cx'%70)) ///
       (rspike x_lb x_ub yb_x if nonsig_x==1 & continuous==0, horizontal lwidth(thick) lcolor(`cx'%25)) ///
       (rspike x_lb_bonf x_ub_bonf yb_x if nonsig_x==0 & continuous==0, horizontal lcolor(`cx'%70)) ///
       (rspike x_lb_bonf x_ub_bonf yb_x if nonsig_x==1 & continuous==0, horizontal lcolor(`cx'%25)) ///
       (scatter yb_l l_diff if nonsig_l==0 & continuous==0, msymbol(d) msize(*.4) mcolor(`cl')) ///
       (scatter yb_l l_diff if nonsig_l==1 & continuous==0, msymbol(d) msize(*.4) mcolor(`cl'%25)) ///
       (rspike l_lb l_ub yb_l if nonsig_l==0 & continuous==0, horizontal lwidth(thick) lcolor(`cl'%70)) ///
       (rspike l_lb l_ub yb_l if nonsig_l==1 & continuous==0, horizontal lwidth(thick) lcolor(`cl'%25)) ///
       (rspike l_lb_bonf l_ub_bonf yb_l if nonsig_l==0 & continuous==0, horizontal lcolor(`cl'%70)) ///
       (rspike l_lb_bonf l_ub_bonf yb_l if nonsig_l==1 & continuous==0, horizontal lcolor(`cl'%25)) ///
       , xscale(alt) xtitle("Difference in subjective SES coefficient" "(weighted minus unweighted, same sample)") ///
       title({bf:B}, span bexpand justification(left)) ///
       xlabel(, format(%6.3f)) xline(0) legend(off) ///
       ytitle(Outcome) ylabel(1/14, val labsize(small)) name(wdiff_binary, replace) fysize(45)

graph combine wdiff_continuous wdiff_binary, col(1) ysize(13) xsize(8) name(weighted_differences, replace)
graph export "output/figures/weighted_differences.pdf", replace

di _n "---- SUMMARY ----"
di "Outcomes with Bonferroni-significant weighted-minus-unweighted difference:"
count if nonsig_x == 0
count if nonsig_l == 0
gen absdx = abs(x_diff)
gen absdl = abs(l_diff)
summarize absdx absdl
summarize x_diff l_diff
di "Sample sizes (mean over outcomes): persons / observations"
summarize ng_full n_full ng_x n_x ng_l n_l

gen sig_ufull = abs(u_full/u_full_se) > `bz'
gen sig_xu    = abs(x_u/x_u_se) > `bz'
gen sig_xw    = abs(x_w/x_w_se) > `bz'
gen sig_lu    = abs(l_u/l_u_se) > `bz'
gen sig_lw    = abs(l_w/l_w_se) > `bz'
count if sig_ufull
count if sig_xu
count if sig_xw
count if sig_lu
count if sig_lw
list depvar u_full x_u x_w sig_ufull sig_xu sig_xw if sig_ufull | sig_xu | sig_xw, noobs sep(0)
list depvar l_u l_w sig_lu sig_lw if sig_lu | sig_lw, noobs sep(0)

gen samesign_x = sign(x_u) == sign(x_w)
gen samesign_l = sign(l_u) == sign(l_w)
count if samesign_x
count if samesign_l

save "output/estimates/weighted_comparison.dta", replace
export delimited using "output/estimates/weighted_comparison.csv", replace
