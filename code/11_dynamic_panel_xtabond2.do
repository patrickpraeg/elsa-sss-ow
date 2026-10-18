// Arellano-Bond estimates for the sensitivity analyses in the Results and the dynamic panel section of the supplement
clear all

use "data/temp/panel_long.dta", clear
sort idauniq wave

global continuous "health frailty cesd hedonicwellbeing evaluativewellbeing meaningfulness anxiety loneliness physical_activity  mobility adl iadl gtspd_av gripstrength memory fluency cancellation trig hba1c fibrinogen lhscrp allostatic hdlchol"
global binary "lli pain eyesight hearing smoking drinking obese centrallyobese hisys hidia hifglu htfev_botq htfvc_botq htpef_botq"
foreach y of varlist $continuous {
    center `y', inplace standardize addtolabel("")
}
global reverse "cesd anxiety frailty loneliness mobility adl iadl lli smoking drinking trig hba1c hifglu fibrinogen sysval diaval lhscrp bmi allostatic pain obese centrallyobese hisys hidia htfev_botq htfvc_botq htpef_botq"
foreach var of global reverse {
    local is_binary 0
    foreach bvar of global binary {
        if "`var'" == "`bvar'" local is_binary 1
    }
    if `is_binary' replace `var' = 1 - `var'
    else            replace `var' = `var' * -1
}

global controls "age working wealth_ihs lnincome i.marstat"
global tccontrols "female nonwhite ib2.education ib2.class"
mark touse
markout touse idauniq wave sss $controls $tccontrols
qui tab marstat, gen(msd)
xtset idauniq wave

global remap "gripstrength trig hba1c fibrinogen lhscrp allostatic hdlchol obese centrallyobese hisys hidia hifglu htfev_botq htfvc_botq htpef_botq"

tempname foo
postfile `foo' str30 depvar byte(binary remapped spec) double(n_ab npers_ab ninstr b_ab se_ab rho_ab se_rho ar1_p ar2_p hansen_p sargan_p b_fe_all se_fe_all) using "output/estimates/xtabond2_all.dta", replace

foreach y in $continuous $binary {
    di _n "=================== `y' ==================="
    local isbin = 0
    foreach bvar of global binary {
        if "`y'" == "`bvar'" local isbin = 1
    }
    local isremap = 0
    foreach rvar of global remap {
        if "`y'" == "`rvar'" local isremap = 1
    }
    qui xtreg `y' sss $controls i.wave if touse, fe vce(cluster idauniq)
    local b_fe_all = _b[sss]
    local se_fe_all = _se[sss]

    preserve
    capture drop tt
    gen int tt = wave
    if `isremap' {
        qui levelsof wave if touse & !missing(`y'), local(ws)
        replace tt = .
        local k = 0
        foreach w of local ws {
            local ++k
            replace tt = `k' if wave == `w'
        }
        di "re-indexed time points for `y': `ws'"
        keep if !missing(tt)
    }
    qui xtset idauniq tt
    capture drop d_*
    qui tab tt, gen(d_)
    drop d_1
    local exog "age working wealth_ihs lnincome msd2 msd3 msd4 d_*"

    forvalues spec = 1/2 {
        local col = cond(`spec' == 1, "collapse", "")
        capture noisily xtabond2 `y' L.`y' sss `exog' if touse, gmm(L.`y', lag(1 3) `col') gmm(sss, lag(1 3) `col') iv(`exog', eq(diff)) noleveleq twostep robust
        if _rc {
            di "xtabond2 failed for `y' spec `spec' (rc=" _rc ")"
            post `foo' ("`y'") (`isbin') (`isremap') (`spec') (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (.) (`b_fe_all') (`se_fe_all')
        }
        else {
            post `foo' ("`y'") (`isbin') (`isremap') (`spec') (e(N)) (e(N_g)) (e(j)) (_b[sss]) (_se[sss]) (_b[L.`y']) (_se[L.`y']) (e(ar1p)) (e(ar2p)) (e(hansenp)) (e(sarganp)) (`b_fe_all') (`se_fe_all')
        }
    }
    restore
}
postclose `foo'

use "output/estimates/xtabond2_all.dta", clear
gen z_ab = b_ab / se_ab
format %9.3f b_ab se_ab rho_ab se_rho ar1_p ar2_p hansen_p sargan_p b_fe_all se_fe_all z_ab
list depvar spec remapped n_ab ninstr b_ab se_ab z_ab b_fe_all rho_ab ar2_p hansen_p, noobs abbreviate(14) sepby(depvar)
export delimited using "output/estimates/xtabond2_all.csv", replace
