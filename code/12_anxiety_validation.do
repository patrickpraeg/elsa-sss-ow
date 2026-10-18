// Figure S2 and text on the validation of the anxiety measure
use idauniq ///
    CvMhgad_CvMhgad1_q CvMhgad_CvMhgad2_q CvMhgad_CvMhgad3_q ///
    CvMhgad_CvMhgad4_q CvMhgad_CvMhgad5_q CvMhgad_CvMhgad6_q ///
    CvMhgad_CvMhgad7_q CvMhOnsB ///
    using "data/raw/UKDA-8688-stata/stata/stata13/elsa_covid_w1_eulv2.dta", clear

generate wave = 1

append using "data/raw/UKDA-8688-stata/stata/stata13/elsa_covid_w2_eulv2.dta", ///
    keep(idauniq ///
         CvMhgad_CvMhgad1_q CvMhgad_CvMhgad2_q CvMhgad_CvMhgad3_q ///
         CvMhgad_CvMhgad4_q CvMhgad_CvMhgad5_q CvMhgad_CvMhgad6_q ///
         CvMhgad_CvMhgad7_q CvMhOnsB)
replace wave = 2 if missing(wave)

mvdecode _all, mv(-9 -8 -3 -2 -1 = .)

egen gad7_total = rowtotal(CvMhgad_CvMhgad1_q CvMhgad_CvMhgad2_q ///
    CvMhgad_CvMhgad3_q CvMhgad_CvMhgad4_q CvMhgad_CvMhgad5_q ///
    CvMhgad_CvMhgad6_q CvMhgad_CvMhgad7_q), missing
label var gad7_total "GAD-7 total score (0-21)"

generate gad7_case = (gad7_total >= 10) if !missing(gad7_total)
label var gad7_case "GAD-7 >= 10 (moderate-to-severe anxiety)"

mark validpair
markout validpair CvMhOnsB gad7_total

tabstat CvMhOnsB gad7_total if validpair, ///
    statistics(n mean sd min p25 p50 p75 max) columns(statistics)

quietly correlate CvMhOnsB gad7_total if validpair
local r_pearson = r(rho)

quietly spearman CvMhOnsB gad7_total if validpair
local r_spearman = r(rho)

di "Pearson r = " %5.3f `r_pearson'
di "Spearman rho = " %5.3f `r_spearman'

quietly roctab gad7_case CvMhOnsB if validpair, summary
local auc    = r(area)
local auc_lb = r(lb)
local auc_ub = r(ub)

di "AUC = " %5.3f `auc' " (95% CI: " %5.3f `auc_lb' "-" %5.3f `auc_ub' ")"

quietly roctab gad7_case CvMhOnsB if validpair, detail

quietly count if validpair
local n_valid = r(N)
quietly count if gad7_case == 1 & validpair
local n_case  = r(N)
local prev    = `n_case' / `n_valid' * 100

local f_r_p  : display %5.3f `r_pearson'
local f_r_s  : display %5.3f `r_spearman'
local f_auc  : display %5.3f `auc'
local f_lb   : display %5.3f `auc_lb'
local f_ub   : display %5.3f `auc_ub'
local f_prev : display %4.1f `prev'
local f_n    : display %12.0fc `n_valid'
local f_n    = subinstr(trim("`f_n'"), ",", "{,}", .)

capture which binscatter
if _rc == 0 {
    binscatter gad7_total CvMhOnsB if validpair, ///
        xtitle("Single-item anxiety score (0-10)") ///
        ytitle("GAD-7 total score (0-21)") ///
        title("A. Convergent validity") ///
        note("Pearson r = `f_r_p', Spearman {&rho} = `f_r_s'") ///
        scheme(lean1) name(scatter_a, replace) nodraw
}
else {
    twoway (scatter gad7_total CvMhOnsB if validpair, ///
                mcolor(navy%20) msymbol(p) jitter(3)) ///
           (lfit   gad7_total CvMhOnsB if validpair, lcolor(maroon) lwidth(medthick)) ///
           (lowess gad7_total CvMhOnsB if validpair, lcolor(black) lpattern(dash)), ///
        xtitle("Single-item anxiety score (0-10)") ///
        ytitle("GAD-7 total score (0-21)") ///
        legend(order(2 "Linear fit" 3 "Lowess") pos(11) ring(0) cols(1)) ///
        title("A. Convergent validity") ///
        note("Pearson r = `f_r_p', Spearman {&rho} = `f_r_s'") ///
        scheme(lean1) name(scatter_a, replace) nodraw
}

roctab gad7_case CvMhOnsB if validpair, ///
    graph ///
    title("B. Criterion validity (GAD-7 {&ge} 10)") ///
    note("AUC = `f_auc' (95% CI: `f_lb'--`f_ub')") ///
    scheme(lean1) name(roc_b, replace) nodraw

graph combine scatter_a roc_b, cols(2) scheme(lean1)
graph export "output/figures/anxiety_validation.pdf", replace

file open anx_stats using "output/tables/anxiety_validation_stats.tex", write replace
file write anx_stats ///
    "The ONS4 single-item anxiety score correlated strongly with the GAD-7 total score " ///
    "(Pearson " _char(36) "r = `f_r_p'" _char(36) ", " ///
    "Spearman " _char(36) "\rho = `f_r_s'" _char(36) ", " ///
    _char(36) "N = `f_n'" _char(36) " person-wave observations). " ///
    "Using a GAD-7 score of " _char(36) "\geq 10" _char(36) " as the reference standard " ///
    "for moderate-to-severe anxiety (`f_prev'\% of the sample), " ///
    "the single-item score achieved an area under the receiver operating " ///
    "characteristic curve of AUC~" _char(36) "= `f_auc'" _char(36) " " ///
    "(95\% CI: `f_lb'--`f_ub')."
file close anx_stats
