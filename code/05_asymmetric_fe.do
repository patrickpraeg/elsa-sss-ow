// Asymmetric fixed-effects estimates behind Figure 2 and Table S9
clear all

use "data/temp/panel_long.dta", clear
sort idauniq wave

gen double s_ff = sss
by idauniq (wave): replace s_ff = s_ff[_n-1] if missing(s_ff) & _n > 1
by idauniq (wave): gen double s_prev = s_ff[_n-1] if _n > 1
gen double dsss  = sss - s_prev if !missing(sss) & !missing(s_prev)
gen double drise = max(dsss, 0)  if !missing(dsss)
gen double dfall = max(-dsss, 0) if !missing(dsss)
by idauniq (wave): gen double cumrise = sum(drise)
by idauniq (wave): gen double cumfall = sum(dfall)
label var cumrise "Cumulative rise in subjective SES (rungs)"
label var cumfall "Cumulative fall in subjective SES (rungs)"

xtset idauniq wave, generic

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

di _n "Transitions between consecutive observed values of status (analysis sample):"
count if touse & !missing(dsss)
count if touse & dsss > 0 & !missing(dsss)
count if touse & dsss < 0 & !missing(dsss)
count if touse & dsss == 0
summarize drise dfall if touse & !missing(dsss) & dsss != 0
summarize dsss if touse & !missing(dsss)
bysort idauniq: egen byte anyrise = max(drise > 0 & touse & !missing(drise))
bysort idauniq: egen byte anyfall = max(dfall > 0 & touse & !missing(dfall))
egen byte tag = tag(idauniq) if touse
count if tag
count if tag & anyrise
count if tag & anyfall
count if tag & anyrise & anyfall

tempname foo
postfile `foo' str50 depvar ///
    b_pos se_pos b_neg se_neg b_asym se_asym b_sym se_sym n ng ///
    using "output/estimates/asymmetric_estimates.dta", replace

foreach y of varlist $continuous $binary {
    di "`y'"
    qui xtreg `y' cumrise cumfall $controls i.wave if touse, fe vce(cluster idauniq)
    local b_pos  = _b[cumrise]
    local se_pos = _se[cumrise]
    local b_neg  = _b[cumfall]
    local se_neg = _se[cumfall]
    local n      = e(N)
    local ng     = e(N_g)
    qui lincom cumrise + cumfall
    local b_asym  = r(estimate)
    local se_asym = r(se)
    qui xtreg `y' sss $controls i.wave if touse, fe vce(cluster idauniq)
    local b_sym  = _b[sss]
    local se_sym = _se[sss]
    post `foo' ("`y'") (`b_pos') (`se_pos') (`b_neg') (`se_neg') (`b_asym') (`se_asym') (`b_sym') (`se_sym') (`n') (`ng')
}
postclose `foo'

use "output/estimates/asymmetric_estimates.dta", clear
merge 1:1 depvar using "output/estimates/main_estimates.dta", keepusing(fe) nogenerate
gen chk = b_sym - fe
summarize chk
list depvar b_sym fe chk if abs(chk) > 1e-6, noobs
drop fe chk
save "output/estimates/asymmetric_estimates.dta", replace

local bz = invnormal(1 - 0.05/(2*_N))
gen sig_pos  = abs(b_pos/se_pos)   > `bz'
gen sig_neg  = abs(b_neg/se_neg)   > `bz'
gen sig_asym = abs(b_asym/se_asym) > `bz'
gen nom_asym = abs(b_asym/se_asym) > 1.96
di _n "Bonferroni z = `bz'"
count if sig_pos
count if sig_neg
count if sig_asym
count if nom_asym
format b_pos b_neg b_asym b_sym se_asym %7.4f
list depvar b_sym b_pos b_neg b_asym se_asym sig_pos sig_neg nom_asym, noobs sep(0) abbreviate(14)
