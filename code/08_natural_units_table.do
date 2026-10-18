// Table S7
clear all

global cont_nat  "gtspd_av gripstrength fibrinogen trig hba1c hdlchol lhscrp frailty adl iadl mobility allostatic memory fluency cancellation"
global cont_rate "meaningfulness anxiety health physical_activity"
global binary    "lli pain eyesight hearing smoking drinking obese centrallyobese hisys hidia hifglu htfev_botq htfvc_botq htpef_botq"
global reverse   "cesd anxiety frailty loneliness mobility adl iadl lli smoking drinking trig hba1c hifglu fibrinogen sysval diaval lhscrp bmi allostatic pain obese centrallyobese hisys hidia htfev_botq htfvc_botq htpef_botq"

use "data/temp/panel_long.dta", clear

tempname d
postfile `d' str30 depvar double(raw_mean raw_sd eff_sd) using "data/temp/natural_units_desc.dta", replace

foreach y of varlist $cont_nat $cont_rate {
    qui summarize `y'
    local m = r(mean)
    local s = r(sd)
    tempvar z
    qui gen double `z' = `y'
    qui center `z', inplace standardize
    qui regress `z' `y'
    local eff = 1 / _b[`y']
    assert e(r2) > 0.999999
    di as text "`y': summarize SD = " %12.6f `s' "   effective SD used by -center- = " %12.6f `eff'
    post `d' ("`y'") (`m') (`s') (`eff')
    drop `z'
}
foreach y of varlist $binary {
    qui summarize `y'
    post `d' ("`y'") (r(mean)) (r(sd)) (.)
}
postclose `d'

use "output/estimates/main_estimates.dta", clear
keep depvar fe fe_se
count
local n_outcomes = r(N)
assert `n_outcomes' == 37
local zb = invnormal(1 - 0.05/(2*`n_outcomes'))

merge 1:1 depvar using "data/temp/natural_units_desc.dta", keep(match) nogenerate
count
assert r(N) == 33

gen byte binary = 0
foreach b of global binary {
    replace binary = 1 if depvar == "`b'"
}
gen sgn = 1
foreach r of global reverse {
    replace sgn = -1 if depvar == "`r'"
}

gen double mult = cond(binary, 100, eff_sd) * sgn
gen double est  = fe * mult
gen double se   = fe_se * abs(mult)
gen double lb   = est - 1.96 * se
gen double ub   = est + 1.96 * se
gen byte bonf   = abs(fe / fe_se) > `zb'

gen double sd_lb = fe - 1.96 * fe_se
gen double sd_ub = fe + 1.96 * fe_se

foreach v in est lb ub {
    gen double `v'_pct = 100 * (exp(`v') - 1) if depvar == "lhscrp"
    replace `v' = `v'_pct if depvar == "lhscrp"
    drop `v'_pct
}
gen double dec_se = cond(depvar == "lhscrp", (ub - lb) / 3.92, se)

gen str60 lab_txt = ""
gen str40 unit  = ""
gen byte  block = .
gen byte  ord   = .

local blk1 `" "gtspd_av|Gait speed|m/s" "gripstrength|Grip strength|kg" "fibrinogen|Fibrinogen|g/L" "trig|Triglycerides|mmol/L" "hba1c|Glycated haemoglobin (HbA1c)|mmol/mol" "hdlchol|HDL/total cholesterol ratio|ratio" "lhscrp|C-reactive protein|\% difference" "'
local blk2 `" "frailty|Frailty index|index (0--1)" "adl|ADL difficulties|count (0--6)" "iadl|IADL difficulties|count (0--5)" "mobility|Mobility limitations|count of difficulties" "allostatic|Allostatic load|systems (0--4)" "memory|Memory|words recalled (0--10)" "fluency|Executive function (verbal fluency)|animals named" "cancellation|Processing speed|letters crossed out" "'
local blk3 `" "lli|Limiting longstanding illness|pp" "pain|Pain|pp" "eyesight|Good eyesight|pp" "hearing|Good hearing|pp" "smoking|Current smoking|pp" "drinking|Drinking alcohol almost daily|pp" "obese|BMI obesity|pp" "centrallyobese|Central obesity|pp" "hisys|High systolic blood pressure|pp" "hidia|High diastolic blood pressure|pp" "hifglu|High fasting blood glucose|pp" "htfev_botq|Low forced expiratory volume|pp" "htfvc_botq|Low forced vital capacity|pp" "htpef_botq|Low peak expiratory flow|pp" "'
local blk4 `" "meaningfulness|Meaningfulness of life|rating (0--10)" "anxiety|Anxiety yesterday|rating (0--10)" "health|Self-rated health|rating (0--4)" "physical_activity|Physical activity|index (0--4)" "'

forvalues b = 1/4 {
    local k = 0
    foreach item of local blk`b' {
        local ++k
        local p1   = strpos("`item'", "|")
        local dv   = substr("`item'", 1, `p1' - 1)
        local rest = substr("`item'", `p1' + 1, .)
        local p2   = strpos("`rest'", "|")
        local lb_  = substr("`rest'", 1, `p2' - 1)
        local un_  = substr("`rest'", `p2' + 1, .)
        replace lab_txt = "`lb_'" if depvar == "`dv'"
        replace unit    = "`un_'" if depvar == "`dv'"
        replace block   = `b'     if depvar == "`dv'"
        replace ord     = `k'     if depvar == "`dv'"
    }
}
assert !missing(block)
sort block ord
list depvar lab_txt block ord est lb ub bonf, noobs

export delimited depvar lab_txt unit fe sd_lb sd_ub est lb ub raw_mean raw_sd eff_sd bonf ///
    using "output/estimates/natural_units_table.csv", replace

local dollar = char(36)
file open tbl using "output/tables/natural_units_table.tex", write replace

local heading1 "Physical and laboratory measures"
local heading2 "Counts and indices"
local heading3 "Binary outcomes (change in percentage points)"
local heading4 "Rating scales (units defined by the questionnaire item; no intrinsic unit)"

local prev = 0
forvalues r = 1/`=_N' {
    local b = block[`r']
    if `b' != `prev' {
        if `prev' != 0 file write tbl "\addlinespace" _n
        file write tbl "\multicolumn{5}{l}{\emph{`heading`b''}} \\" _n
        local prev = `b'
    }

    local dec = max(2, min(5, ceil(-log10(dec_se[`r']))))
    if binary[`r'] local dec = 2
    if depvar[`r'] == "lhscrp" local dec = 1

    local e   = string(est[`r'], "%12.`dec'f")
    local l   = string(lb[`r'],  "%12.`dec'f")
    local u   = string(ub[`r'],  "%12.`dec'f")
    foreach v in e l u {
        if real("``v''") == 0 local `v' = subinstr("``v''", "-", "", 1)
    }
    foreach v in e l u {
        local `v' = subinstr("``v''", "-", "`dollar'-`dollar'", 1)
    }
    local orig "`e' [`l', `u']"
    if bonf[`r'] local orig "\textbf{`e'} [`l', `u']"

    local sdv  = string(fe[`r'],    "%12.3f")
    local sdl  = string(sd_lb[`r'], "%12.3f")
    local sdu  = string(sd_ub[`r'], "%12.3f")
    foreach v in sdv sdl sdu {
        if real("``v''") == 0 local `v' = subinstr("``v''", "-", "", 1)
        local `v' = subinstr("``v''", "-", "`dollar'-`dollar'", 1)
    }
    if binary[`r'] local sdtxt "---"
    else if bonf[`r'] local sdtxt "\textbf{`sdv'} [`sdl', `sdu']"
    else           local sdtxt "`sdv' [`sdl', `sdu']"

    if binary[`r'] {
        local msd = string(100 * raw_mean[`r'], "%12.1f") + "\%"
    }
    else if depvar[`r'] == "lhscrp" {
        local msd = string(exp(raw_mean[`r']), "%12.2f") + " (log-SD " + string(raw_sd[`r'], "%12.2f") + ")"
    }
    else {
        local mdec = cond(raw_sd[`r'] < 0.05, 4, cond(raw_sd[`r'] < 1, 3, cond(raw_sd[`r'] < 10, 2, 1)))
        local msd = string(raw_mean[`r'], "%12.`mdec'f") + " (" + string(raw_sd[`r'], "%12.`mdec'f") + ")"
    }

    file write tbl "`=lab_txt[`r']' & `=unit[`r']' & `msd' & `sdtxt' & `orig' \\" _n
}
file close tbl

di as text _n "Wrote output/tables/natural_units_table.tex and output/estimates/natural_units_table.csv"
