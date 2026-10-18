// Table S9
clear all

use "output/estimates/main_estimates.dta", clear
keep depvar outcome fe
merge 1:1 depvar using "output/estimates/asymmetric_estimates.dta", nogenerate assert(match)
count
local n_outcomes = r(N)
assert `n_outcomes' == 37
local bz = invnormal(1 - 0.05/(2*`n_outcomes'))

gen continuous = 0
replace continuous = 1 if inlist(depvar, "health", "cesd", "hedonicwellbeing", "evaluativewellbeing", "meaningfulness", "anxiety", "loneliness", "physical_activity", "mobility")
replace continuous = 1 if inlist(depvar, "adl", "iadl", "gtspd_av", "gripstrength", "memory", "fluency", "cancellation", "trig", "hba1c")
replace continuous = 1 if inlist(depvar, "fibrinogen", "lhscrp")
replace continuous = 1 if inlist(depvar, "bmi", "allostatic", "hdlchol", "frailty")

gen inc_b  = b_pos
gen inc_se = se_pos
gen dec_b  = -b_neg
gen dec_se = se_neg
gen dif_b  = b_asym
gen dif_se = se_asym
foreach s in inc dec dif {
    gen `s'_lb  = `s'_b - `bz' * `s'_se
    gen `s'_ub  = `s'_b + `bz' * `s'_se
    gen byte `s'_sig = (`s'_lb > 0 | `s'_ub < 0)
}
count if inc_sig
count if dec_sig
count if dif_sig

replace outcome = subinstr(outcome, "{it:(rev.)}", "\textit{(rev.)}", .)

gsort -continuous -fe

local dollar = char(36)
capture file close tbl
file open tbl using "output/tables/asymmetric_table.tex", write replace

file write tbl "\begin{longtable}{lrcrcrc}" _n
file write tbl "\caption{Associations of increases and decreases in subjective socioeconomic status with 37 health outcomes:" _n
file write tbl " coefficients from asymmetric fixed-effects models with Bonferroni-corrected 95\% confidence intervals." _n
file write tbl " Continuous outcomes show standardised coefficients; binary outcomes show average marginal effects.\label{tab:asymmetric}}\\" _n
file write tbl "\toprule" _n
file write tbl " & \multicolumn{2}{c}{Increase} & \multicolumn{2}{c}{Decrease (sign reversed)} & \multicolumn{2}{c}{Difference} \\" _n
file write tbl "\cmidrule(lr){2-3}\cmidrule(lr){4-5}\cmidrule(lr){6-7}" _n
file write tbl "Outcome & `dollar'\hat{\beta}`dollar' & Bonf.\ 95\% CI & `dollar'\hat{\beta}`dollar' & Bonf.\ 95\% CI & `dollar'\hat{\beta}`dollar' & Bonf.\ 95\% CI \\" _n
file write tbl "\midrule\endfirsthead" _n
file write tbl "\multicolumn{7}{c}{\emph{Table continued from previous page}}\\" _n
file write tbl "\toprule" _n
file write tbl " & \multicolumn{2}{c}{Increase} & \multicolumn{2}{c}{Decrease (sign reversed)} & \multicolumn{2}{c}{Difference} \\" _n
file write tbl "\cmidrule(lr){2-3}\cmidrule(lr){4-5}\cmidrule(lr){6-7}" _n
file write tbl "Outcome & `dollar'\hat{\beta}`dollar' & Bonf.\ 95\% CI & `dollar'\hat{\beta}`dollar' & Bonf.\ 95\% CI & `dollar'\hat{\beta}`dollar' & Bonf.\ 95\% CI \\" _n
file write tbl "\midrule\endhead" _n
file write tbl "\midrule\endfoot" _n
file write tbl "\bottomrule" _n
file write tbl "\multicolumn{7}{p{0.95\linewidth}}{\emph{Note:} Increase and decrease are the associations of a one-rung cumulative increase and a one-rung cumulative decrease in status, respectively, estimated simultaneously in one fixed-effects model." _n
file write tbl " Decrease coefficients are shown with their sign reversed, so that identical values for increase and decrease indicate associations of equal size and opposite direction." _n
file write tbl " Difference is the increase coefficient minus the sign-reversed decrease coefficient; a difference from zero indicates asymmetry." _n
file write tbl " Outcomes marked \textit{(rev.)} were reversed so that higher values indicate better health." _n
file write tbl " Confidence intervals are Bonferroni-corrected for 37 simultaneous tests; coefficients that are Bonferroni-significant are shown in bold.}\\" _n
file write tbl "\endlastfoot" _n

local prev_cont = 2
forval r = 1/`=_N' {
    local cont = continuous[`r']
    if `prev_cont' != `cont' {
        if `cont' == 1 {
            file write tbl "\multicolumn{7}{l}{\emph{Continuous outcomes}} \\" _n
        }
        else {
            file write tbl "\midrule" _n
            file write tbl "\multicolumn{7}{l}{\emph{Binary outcomes}} \\" _n
        }
        file write tbl "\midrule" _n
        local prev_cont = `cont'
    }

    local lab = outcome[`r']
    local row "`lab'"
    foreach s in inc dec dif {
        local b  = string(`s'_b[`r'],  "%6.3f")
        local lb = string(`s'_lb[`r'], "%6.3f")
        local ub = string(`s'_ub[`r'], "%6.3f")
        foreach v in b lb ub {
            if real("``v''") == 0 local `v' = subinstr("``v''", "-", "", 1)
            local `v' = subinstr("``v''", "-", "`dollar'-`dollar'", 1)
        }
        if `s'_sig[`r'] local b "\textbf{`b'}"
        local row "`row' & `b' & [`lb', `ub']"
    }
    file write tbl "`row' \\" _n
}

file write tbl "\end{longtable}" _n
file close tbl
