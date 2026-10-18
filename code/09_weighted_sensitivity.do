// Weighted fixed-effects estimates behind Figure S5
clear all

tempfile weights
forvalues x = 1/11 {
    use idauniq wgt lwgt using "data/temp/wave_`x'_ifs_derived_variables.dta", clear
    rename wgt  xwgt`x'
    rename lwgt lwgt`x'
    if `x' > 1 {
        merge 1:1 idauniq using `weights', nogenerate
    }
    save `weights', replace
}
reshape long xwgt lwgt, i(idauniq) j(wave)
replace xwgt = . if xwgt <= 0
replace lwgt = . if lwgt <= 0
save `weights', replace

use "data/temp/panel_long.dta", clear
capture drop lwgt xwgt
merge 1:1 idauniq wave using `weights', keep(master match) nogenerate
xtset idauniq wave, generic

global continuous "health frailty cesd hedonicwellbeing evaluativewellbeing meaningfulness anxiety loneliness physical_activity  mobility adl iadl gtspd_av gripstrength memory fluency cancellation trig hba1c fibrinogen lhscrp allostatic hdlchol"
global binary "lli pain eyesight hearing smoking drinking obese centrallyobese hisys hidia hifglu htfev_botq htfvc_botq htpef_botq"

foreach y of varlist $continuous {
    center `y', inplace standardize addtolabel("")
}

global reverse "cesd anxiety frailty loneliness mobility adl iadl lli smoking drinking trig hba1c hifglu fibrinogen sysval diaval lhscrp bmi allostatic pain obese centrallyobese hisys hidia htfev_botq htfvc_botq htpef_botq"
foreach var of global reverse {
    local current_label : variable label `var'
    label variable `var' "`current_label' {it:(rev.)}"
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

gen byte s_xw = touse & !missing(xwgt)
gen byte s_lw = touse & !missing(lwgt)

di _n "Coverage of valid weights among analysis observations (touse):"
tab wave if touse & !missing(xwgt)
tab wave if touse & !missing(lwgt)
count if touse
count if s_xw
count if s_lw

tempname foo
postfile `foo' str50 depvar ///
    main main_se ///
    u_full u_full_se n_full ng_full u_full_xtse x_u_xtse l_u_xtse ///
    x_w x_w_se x_u x_u_se n_x ng_x ///
    l_w l_w_se l_u l_u_se n_l ng_l ///
    using "output/estimates/weighted_estimates.dta", replace

foreach y of varlist $continuous $binary {
    di "`y'"

    qui xtreg `y' sss $controls i.wave if touse, fe
    local main    = _b[sss]
    local main_se = _se[sss]

    qui areg `y' sss $controls i.wave if touse, absorb(idauniq) vce(cluster idauniq)
    local u_full    = _b[sss]
    local u_full_se = _se[sss]
    local n_full    = e(N)
    local ng_full   = e(N_clust)
    qui xtreg `y' sss $controls i.wave if touse, fe vce(cluster idauniq)
    local u_full_xtse = _se[sss]
    qui xtreg `y' sss $controls i.wave if s_xw, fe vce(cluster idauniq)
    local x_u_xtse = _se[sss]
    qui xtreg `y' sss $controls i.wave if s_lw, fe vce(cluster idauniq)
    local l_u_xtse = _se[sss]

    qui areg `y' sss $controls i.wave [pw=xwgt] if s_xw, absorb(idauniq) vce(cluster idauniq)
    local x_w    = _b[sss]
    local x_w_se = _se[sss]
    local n_x    = e(N)
    local ng_x   = e(N_clust)
    qui areg `y' sss $controls i.wave if s_xw, absorb(idauniq) vce(cluster idauniq)
    local x_u    = _b[sss]
    local x_u_se = _se[sss]

    qui areg `y' sss $controls i.wave [pw=lwgt] if s_lw, absorb(idauniq) vce(cluster idauniq)
    local l_w    = _b[sss]
    local l_w_se = _se[sss]
    local n_l    = e(N)
    local ng_l   = e(N_clust)
    qui areg `y' sss $controls i.wave if s_lw, absorb(idauniq) vce(cluster idauniq)
    local l_u    = _b[sss]
    local l_u_se = _se[sss]

    post `foo' ("`y'") (`main') (`main_se') ///
        (`u_full') (`u_full_se') (`n_full') (`ng_full') (`u_full_xtse') (`x_u_xtse') (`l_u_xtse') ///
        (`x_w') (`x_w_se') (`x_u') (`x_u_se') (`n_x') (`ng_x') ///
        (`l_w') (`l_w_se') (`l_u') (`l_u_se') (`n_l') (`ng_l')
}
postclose `foo'

tempname bar
postfile `bar' str50 depvar ///
    x_d x_d_se x_sew x_seu x_gap ///
    l_d l_d_se l_sew l_seu l_gap ///
    using "output/estimates/weighted_diff.dta", replace

foreach y of varlist $continuous $binary {
    di "diff SEs: `y'"
    foreach sch in x l {
        local w   = cond("`sch'" == "x", "xwgt", "lwgt")
        local sv  = cond("`sch'" == "x", "s_xw", "s_lw")
        capture drop _smp _rw _ru _ew _eu _sw _su _Sw _Su _tag _q1 _q2 _q3 _q4 _q5 _q6
        gen byte _smp = `sv' & !missing(`y')

        qui areg sss $controls i.wave [pw=`w'] if _smp, absorb(idauniq)
        qui predict double _rw if _smp, residuals
        qui areg sss $controls i.wave if _smp, absorb(idauniq)
        qui predict double _ru if _smp, residuals

        qui areg `y' sss $controls i.wave [pw=`w'] if _smp, absorb(idauniq)
        local bw = _b[sss]
        qui predict double _ew if _smp, residuals
        qui areg `y' sss $controls i.wave if _smp, absorb(idauniq)
        local bu = _b[sss]
        qui predict double _eu if _smp, residuals

        qui gen double _sw = `w' * _rw * _ew if _smp
        qui gen double _su = _ru * _eu if _smp
        qui egen double _Sw = total(_sw) if _smp, by(idauniq)
        qui egen double _Su = total(_su) if _smp, by(idauniq)
        qui egen byte _tag = tag(idauniq) if _smp
        qui gen double _q1 = _Sw^2    if _tag == 1
        qui gen double _q2 = _Su^2    if _tag == 1
        qui gen double _q3 = _Sw*_Su  if _tag == 1
        qui gen double _q4 = `w' * _rw^2 if _smp
        qui gen double _q5 = _ru^2       if _smp
        qui gen double _q6 = `w' * _rw * `y' if _smp
        qui summarize _q1, meanonly
        local s11 = r(sum)
        local G   = r(N)
        qui summarize _q2, meanonly
        local s22 = r(sum)
        qui summarize _q3, meanonly
        local s12 = r(sum)
        qui summarize _q4, meanonly
        local Aw = r(sum)
        qui summarize _q5, meanonly
        local Au = r(sum)
        qui summarize _q6, meanonly
        local bw_fwl = r(sum) / `Aw'

        local c    = `G' / (`G' - 1)
        local vw   = `c' * `s11' / (`Aw'^2)
        local vu   = `c' * `s22' / (`Au'^2)
        local cv   = `c' * `s12' / (`Aw' * `Au')
        local d    = `bw' - `bu'
        local d_se = sqrt(`vw' + `vu' - 2 * `cv')
        local sew  = sqrt(`vw')
        local seu  = sqrt(`vu')
        local gap  = `bw_fwl' - `bw'
        local `sch'_d   = `d'
        local `sch'_dse = `d_se'
        local `sch'_sew = `sew'
        local `sch'_seu = `seu'
        local `sch'_gap = `gap'
    }
    post `bar' ("`y'") ///
        (`x_d') (`x_dse') (`x_sew') (`x_seu') (`x_gap') ///
        (`l_d') (`l_dse') (`l_sew') (`l_seu') (`l_gap')
}
postclose `bar'
capture drop _smp _rw _ru _ew _eu _sw _su _Sw _Su _tag _q1 _q2 _q3 _q4 _q5 _q6

use "output/estimates/weighted_estimates.dta", clear
merge 1:1 depvar using "output/estimates/main_estimates.dta", keepusing(fe fe_se) nogenerate
gen diff_main = main - fe
gen diff_areg = u_full - fe
di _n "Replication: xtreg FE vs saved main estimates, and areg FE vs saved main estimates"
summarize diff_main diff_areg
list depvar main fe diff_main if abs(diff_main) > 1e-6, noobs
list depvar u_full fe diff_areg if abs(diff_areg) > 1e-6, noobs
drop fe fe_se diff_main diff_areg
save "output/estimates/weighted_estimates.dta", replace
