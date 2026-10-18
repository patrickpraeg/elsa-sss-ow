// Allostatic load and biomarker outcomes (Table S5, Table S4, Figure 1)
clear all
set maxvar 32767

cd "data/temp"

use core2, clear
rename *, lower

keep idauniq indsex ///
     hemda hehrtb hehrtc hemdb heins ///
     hedia* hedib*

gen cvd = 0
foreach n in 1 2 3 4 5 6 {
    capture replace cvd = 1 if hediac`n' == 1
    capture replace cvd = 1 if hedias`n' == 1
}
foreach v of varlist hedia01-hedia09 {
    replace cvd = 1 if inlist(`v', 1, 2, 3, 4, 5, 6)
}

gen diabetes = 0
capture replace diabetes = 1 if hediac7 == 1
capture replace diabetes = 1 if hedias7 == 1
foreach v of varlist hedia01-hedia09 {
    replace diabetes = 1 if `v' == 7
}

gen stroke = 0
capture replace stroke = 1 if hediac8 == 1
foreach v of varlist hedia01-hedia09 {
    replace stroke = 1 if `v' == 8
}

gen copd = 0
capture replace copd = 1 if hediad1 == 1
capture replace copd = 1 if hediad2 == 1
foreach v of varlist hedib01-hedib04 {
    replace copd = 1 if inlist(`v', 1, 2)
}

gen arthri = 0
capture replace arthri = 1 if hediad3 == 1
capture replace arthri = 1 if hediad4 == 1
capture replace arthri = 1 if hedias3 == 1
foreach v of varlist hedib01-hedib04 {
    replace arthri = 1 if inlist(`v', 3, 4)
}

gen cancer = 0
capture replace cancer = 1 if hediad5 == 1
foreach v of varlist hedib01-hedib04 {
    replace cancer = 1 if `v' == 5
}

gen dementia = 0
foreach n in 6 8 9 {
    capture replace dementia = 1 if hediad`n' == 1
}
capture replace dementia = 1 if hedias8 == 1
foreach v of varlist hedib01-hedib04 {
    replace dementia = 1 if inlist(`v', 6, 8, 9)
}

gen hyprx = 0
gen diarx  = 0
gen cholrx = 0
foreach v in hemda hehrtb hehrtc {
    capture replace hyprx = 1 if `v' == 1
}
foreach v in hemdb heins {
    capture replace diarx = 1 if `v' == 1
}

keep idauniq indsex cvd diabetes stroke copd arthri cancer dementia hyprx diarx cholrx

merge 1:1 idauniq using nurse02, ///
    keepusing(hscrp cfib diaval sysval wtval htval wstval ///
              fglu trig hdl chol hba1c confage visyear htfev htfvc htpf)
keep if _merge == 3
drop _merge
rename htpf htpef

gen wv = 2
gen yr = 2004
rename confage age

save w2_temp.dta, replace

foreach wnum in 4 6 {

    if `wnum' == 4  local yr_val = 2008
    if `wnum' == 6  local yr_val = 2012

    use core`wnum', clear
    rename *, lower

    gen cvd = 0
    foreach v in hediaan hediami hediabp hediahf hediahm hediaar {
        capture replace cvd = 1 if `v' == 1
    }
    foreach v in hedacan hedacmi hedacbp hedachf hedachm hedacar {
        capture replace cvd = 1 if `v' == 1
    }
    foreach v in hedanan hedanmi hedanbp hedanhf hedanhm hedanar {
        capture replace cvd = 1 if `v' == 1
    }

    gen diabetes = 0
    capture replace diabetes = 1 if hediadi == 1
    capture replace diabetes = 1 if hedacdi == 1
    capture replace diabetes = 1 if hedandi == 1

    gen stroke = 0
    capture replace stroke = 1 if hediast == 1
    capture replace stroke = 1 if hedacst == 1
    capture replace stroke = 1 if hedanst == 1

    gen copd = 0
    foreach v in hediblu hedibas hedbdlu hedbdas {
        capture replace copd = 1 if `v' == 1
    }

    gen arthri = 0
    foreach v in hedibar hedibos hedbdar hedbdos {
        capture replace arthri = 1 if `v' == 1
    }

    gen cancer = 0
    capture replace cancer = 1 if hedibca == 1
    capture replace cancer = 1 if hedbdca == 1

    gen dementia = 0
    foreach v in hedibpd hedibad hedibde hedbdpd hedbdad hedbdde {
        capture replace dementia = 1 if `v' == 1
    }

    gen hyprx = 0
    gen diarx  = 0
    gen cholrx = 0
    foreach v in hemda hemdab hemda1 hehrtb hehrtc {
        capture replace hyprx = 1 if `v' == 1
    }
    capture replace hyprx = 1 if ffhemdab == 1
    foreach v in hemdb heins {
        capture replace diarx = 1 if `v' == 1
    }
    foreach v in hechmd hechme {
        capture replace cholrx = 1 if `v' == 1
    }
    capture replace cholrx = 1 if ffhechmd == 1

    keep idauniq indsex cvd diabetes stroke copd arthri cancer dementia hyprx diarx cholrx

    merge 1:1 idauniq using nurse0`wnum'
    keep if _merge == 3
    drop _merge
    rename *, lower
    capture rename confage age
    capture rename indager age
    capture gen htpef = .
    keep idauniq indsex cvd diabetes stroke copd arthri cancer dementia hyprx diarx cholrx ///
         hscrp cfib diaval sysval wtval htval wstval fglu trig hdl chol hba1c age visyear ///
         htfev htfvc htpef

    gen wv = `wnum'
    gen yr = `yr_val'

    save w`wnum'_temp.dta, replace
}

use core8, clear
rename *, lower

keep idauniq indsex weight ///
     hemda hemdab hemda1 hehrtb hehrtc hemdb heins hechmd hechme ///
     hedim* hedib* heda* hedb*

egen cvd = anymatch(hediman hedimar hedimbp hedimhf hedimhm hedimmi), v(1)
replace cvd = 1 if (hedawan==1 & hedacan==1) | (hedawar==1 & hedacar==1) ///
  | (hedawbp==1 & hedacbp==1) | (hedawhf==1 & hedachf==1) ///
  | (hedawhm==1 & hedachm==1) | (hedawmi==1 & hedacmi==1)

egen diabetes = anymatch(hedimdi), v(1)

egen stroke = anymatch(hedimst), v(1)

egen copd = anymatch(hediblu hedibas), v(1)
replace copd = 1 if (hedbwlu==1 & hedbdlu==1) | (hedbwas==1 & hedbdas==1)

egen arthri = anymatch(hedibar hedibos), v(1)
replace arthri = 1 if (hedbwar==1 & hedbdar==1) | (hedbwos==1 & hedbdos==1)

egen cancer = anymatch(hedibca), v(1)
replace cancer = 1 if (hedbwca==1 & hedbdca==1)

egen dementia = anymatch(hedibpd hedibad hedibde), v(1)
replace dementia = 1 if (hedbwpd==1 & hedbdpd==1) | (hedbwad==1 & hedbdad==1) ///
  | (hedbwde==1 & hedbdde==1)

egen hyprx  = anymatch(hemda hemdab hemda1 hehrtb hehrtc), values(1)
egen diarx  = anymatch(hemdb heins),   values(1)
egen cholrx = anymatch(hechmd hechme), values(1)

keep idauniq indsex cvd diabetes stroke copd arthri cancer dementia hyprx diarx cholrx weight

merge 1:1 idauniq using nurse08, ///
    keepusing(hscrp cfib diaval sysval fglu trig hdl chol hba1c indager visyear)
keep if _merge == 3
drop _merge
rename weight wtval
gen htval = .

gen wv = 8
gen yr = 2016
rename indager age

save w8_temp.dta, replace

use core8, clear
rename *, lower

keep idauniq indsex ///
     hemda hemdab hemda1 hehrtb hehrtc hemdb heins hechmd hechme ///
     hedim* hedib* heda* hedb*

egen cvd = anymatch(hediman hedimar hedimbp hedimhf hedimhm hedimmi), v(1)
replace cvd = 1 if (hedawan==1 & hedacan==1) | (hedawar==1 & hedacar==1) ///
  | (hedawbp==1 & hedacbp==1) | (hedawhf==1 & hedachf==1) ///
  | (hedawhm==1 & hedachm==1) | (hedawmi==1 & hedacmi==1)
egen diabetes = anymatch(hedimdi), v(1)
egen stroke   = anymatch(hedimst), v(1)
egen copd     = anymatch(hediblu hedibas), v(1)
replace copd = 1 if (hedbwlu==1 & hedbdlu==1) | (hedbwas==1 & hedbdas==1)
egen arthri   = anymatch(hedibar hedibos), v(1)
replace arthri = 1 if (hedbwar==1 & hedbdar==1) | (hedbwos==1 & hedbdos==1)
egen cancer   = anymatch(hedibca), v(1)
replace cancer = 1 if (hedbwca==1 & hedbdca==1)
egen dementia = anymatch(hedibpd hedibad hedibde), v(1)
replace dementia = 1 if (hedbwpd==1 & hedbdpd==1) | (hedbwad==1 & hedbdad==1) ///
  | (hedbwde==1 & hedbdde==1)
egen hyprx  = anymatch(hemda hemdab hemda1 hehrtb hehrtc), values(1)
egen diarx  = anymatch(hemdb heins),   values(1)
egen cholrx = anymatch(hechmd hechme), values(1)

keep idauniq indsex cvd diabetes stroke copd arthri cancer dementia hyprx diarx cholrx

merge 1:1 idauniq using nurse09, ///
    keepusing(hscrp cfib diaval sysval fglu trig hdl chol hba1c indager visyear)
keep if _merge == 3
drop _merge

merge 1:1 idauniq using core9, keepusing(weight) nogenerate noreport
capture rename weight wtval
capture gen wtval = .
gen htval = .

gen wv = 9
gen yr = 2018
rename indager age

save w9_temp.dta, replace

use core11, clear
rename *, lower

capture keep idauniq indsex ///
     hemda hemdab hemda1 hehrtb hehrtc hemdb heins hechmd hechme ///
     hehave* hediad* hediac* hediia*

gen cvd = 0
foreach v in hehavean hehavebp hehavehf hehavehm hehaveah {
    capture replace cvd = 1 if inlist(`v', 1, 2)
}
foreach v in hediacan hediacmi hediacbp hediachf hediachm hediacah {
    capture replace cvd = 1 if `v' == 1
}
forval i = 1/6 {
    capture replace cvd = 1 if hediia`i' == 1
}

gen diabetes = 0
capture replace diabetes = 1 if inlist(hehavedi, 1, 2)
capture replace diabetes = 1 if hediaddi == 1
capture replace diabetes = 1 if hedids12 == 1

gen stroke = 0
capture replace stroke = 1 if inlist(hehavest, 1, 2)
capture replace stroke = 1 if hediacst == 1
capture replace stroke = 1 if hediiam7 == 1
capture replace stroke = 1 if hediia7  == 1

gen copd = 0
foreach v in hehavecl hehaveas {
    capture replace copd = 1 if inlist(`v', 1, 2)
}
foreach v in hediadcl hediadas {
    capture replace copd = 1 if `v' == 1
}
capture replace copd = 1 if hedids1 == 1
capture replace copd = 1 if hedids2 == 1

gen arthri = 0
foreach v in hehavear hehaveos {
    capture replace arthri = 1 if inlist(`v', 1, 2)
}
foreach v in hediadar hediados {
    capture replace arthri = 1 if `v' == 1
}
capture replace arthri = 1 if hedids3 == 1

gen cancer = 0
capture replace cancer = 1 if inlist(hehaveca, 1, 2)
capture replace cancer = 1 if hediadca == 1
capture replace cancer = 1 if hedids5 == 1

gen dementia = 0
foreach v in hehavepd hehavead hehavedm {
    capture replace dementia = 1 if inlist(`v', 1, 2)
}
foreach v in hediadpd hediadad hediaddm {
    capture replace dementia = 1 if `v' == 1
}
capture replace dementia = 1 if hedids6 == 1
capture replace dementia = 1 if hedids8 == 1
capture replace dementia = 1 if hedids9 == 1

gen hyprx = 0
foreach v in hehavebp hehavean hehavehf hehaveah {
    capture replace hyprx = 1 if `v' == 2
}
gen diarx = 0
capture replace diarx = 1 if hehavedi == 2
gen cholrx = 0
capture replace cholrx = 1 if hehavehc == 2

keep idauniq indsex cvd diabetes stroke copd arthri cancer dementia hyprx diarx cholrx

merge 1:1 idauniq using nurse11, ///
    keepusing(hscrp cfib diaval sysval wtval htval ///
              fglu trig hdl chol hba1c indager visyear htfev htfvc htpef)
keep if _merge == 3
drop _merge

gen wv  = 11
gen yr  = 2022
rename indager age

save w11_temp.dta, replace

use w2_temp, clear
append using w4_temp,  nolabel
append using w6_temp,  nolabel
append using w8_temp,  nolabel
append using w9_temp,  nolabel
append using w11_temp, nolabel
sort idauniq wv

keep if age > 34 & age <= 90
mvdecode age, mv(-9/0)
gen age2 = age * age

recode indsex (2=1 Female) (1=0 Male), gen(she)
label var she "Female"

sort idauniq wv
by idauniq: replace htval = htval[_n-1] if missing(htval)
gsort idauniq -wv
by idauniq: replace htval = htval[_n-1] if missing(htval)
sort idauniq wv

capture mvdecode wstval, mv(-999/-1=. \ 999.9=.)

mvdecode wtval htval fglu trig hdl chol sysval diaval hscrp cfib hba1c, mv(-999/-1)
capture mvdecode htfev htfvc htpef, mv(-999/-1)

assert hba1c < 20 if inlist(wv, 2, 4) & !missing(hba1c)
assert hba1c > 10 if !inlist(wv, 2, 4) & !missing(hba1c)
replace hba1c = (hba1c - 2.15) * 10.929 if inlist(wv, 2, 4) & !missing(hba1c)

keep if hscrp > 0 & hscrp < 12

capture drop if htfev < 0.5 & htfev != .
capture drop if htfev > 6.0 & htfev != .

gen bmi = wtval / ((htval/100)^2) if !missing(wtval, htval)

gen obswaist = cond(wstval < 102, 0, 1) if !missing(wstval)
replace obswaist = 1 if wstval >= 88 & she & !missing(wstval)

gen hdlchol = hdl / chol

_pctile hscrp, p(66.667)
gen hi3crp = hscrp > r(r1)
gen lhscrp = log(hscrp)

foreach v of varlist trig hscrp cfib hdl chol hba1c {
    _pctile `v', p(33.333, 66.667)
    egen `v't = cut(`v'), at(0 `=r(r1)' `=r(r2)' 999) icodes
}

foreach v of varlist htfev htfvc htpef {
    capture {
        _pctile `v', p(33.333, 66.667)
        egen `v't = cut(`v'), at(0 `=r(r1)' `=r(r2)' 999) icodes
    }
}

egen sysvalt = cut(sysval), at(0, 130, 140, 990)  icodes
egen diavalt = cut(diaval), at(0, 85,  90,  990)  icodes
egen fglut   = cut(fglu),   at(0, 6.1, 7.0,  99)  icodes
capture {
    egen wstvalt = cut(wstval), at(0, 94, 102, 990) icodes
    replace wstvalt = 1 if wstval >= 80 & wstval < 88
    replace wstvalt = 2 if wstval >= 88 & wstval < .
}
egen bmit = cut(bmi), at(0, 25, 30, 99) icodes

foreach v of varlist sysvalt diavalt fglut trigt hscrpt cfibt hba1ct {
    replace `v' = 2 - `v'
}
capture replace wstvalt = 2 - wstvalt
replace bmit = 2 - bmit

capture replace htfevt = 0 if yr < 2016 & copd
capture replace htfvct = 0 if yr < 2016 & copd
capture replace htpeft = 0 if yr < 2016 & copd
capture replace htfevt = 0 if wv == 11 & copd
capture replace htfvct = 0 if wv == 11 & copd
capture replace htpeft = 0 if wv == 11 & copd

replace fglut = 0 if yr < 2016 & diabetes
replace fglut = 0 if wv == 11  & diabetes

replace sysvalt = 0 if cvd | hyprx
replace diavalt = 0 if cvd | hyprx
capture replace hdlt = 0 if cvd | hyprx

gen hapheno  = sysvalt + fglut + hba1ct + htfevt + wstvalt + hdlt + trigt + hscrpt
gen haphenox = hapheno + diavalt + htfvct + bmit + cfibt
gen hapheno_comp  = sysvalt + fglut + hba1ct + hdlt + trigt + hscrpt
gen haphenox_comp = hapheno_comp + diavalt + bmit + cfibt

gen tmpwstval = (she  & wstval >= 88  & wstval < 999) | ///
                (!she & wstval >= 102 & wstval < 999)
gen tmptrig  = (trig >= 1.7 & trig < .)
gen tmphdl   = (!she & hdl < 1.03) | (she & hdl < 1.3)
gen tmphyper = ((sysval >= 130 & sysval < .) | (diaval >= 85 & diaval < .) | hyprx)
gen tmpglu   = ((fglu >= 5.6 & fglu < .) | diabetes)

egen mets = rowtotal(tmpwstval tmptrig tmphdl tmphyper tmpglu)
recode mets (0/2 = 0) (3/5 = 1)
drop tmp*

foreach v of varlist hscrp cfib trig hba1c {
    qui sum `v' if  she, detail
    gen `v'q = (`v' > r(p75)) if  she & !missing(`v')
    qui sum `v' if !she, detail
    replace `v'q = (`v' > r(p75)) if !she & !missing(`v')
}

qui sum hdlchol if  she, detail
gen hdlcholq = (hdlchol < r(p25)) if  she & !missing(hdlchol)
qui sum hdlchol if !she, detail
replace hdlcholq = (hdlchol < r(p25)) if !she & !missing(hdlchol)

foreach v of varlist htfev htfvc htpef {
    capture {
        qui sum `v' if  she & inlist(wv, 2, 4, 6), detail
        gen `v'q = (`v' < r(p25)) if  she & inlist(wv, 2, 4, 6) & !missing(`v')
        qui sum `v' if !she & inlist(wv, 2, 4, 6), detail
        replace `v'q = (`v' < r(p25)) if !she & inlist(wv, 2, 4, 6) & !missing(`v')
    }
    capture {
        qui sum `v' if  she & wv == 11, detail
        replace `v'q = (`v' < r(p25)) if  she & wv == 11 & !missing(`v')
        qui sum `v' if !she & wv == 11, detail
        replace `v'q = (`v' < r(p25)) if !she & wv == 11 & !missing(`v')
    }
}

gen bmiq    = (bmi >= 30)    if !missing(bmi)
gen sysvalq = (sysval >= 140) if !missing(sysval)
gen diavalq = (diaval >= 90)  if !missing(diaval)
gen fgluq   = (fglu >= 7.0)   if !missing(fglu)

gen wstvalq = .
replace wstvalq = (!she & wstval >= 102) | (she & wstval >= 88) ///
    if !missing(wstval)

replace sysvalq = 1 if cvd | hyprx
replace diavalq = 1 if cvd | hyprx
capture replace htfevq = 1 if copd
capture replace htfvcq = 1 if copd
capture replace htpefq = 1 if copd
replace fgluq   = 1 if diabetes
replace hba1cq  = 1 if diarx
replace hdlcholq = 1 if cholrx
replace trigq   = 1 if cholrx

_pctile hscrp, p(50)
replace hscrpq = 1 if hscrp > r(r1) & (diarx | cholrx | hyprx)

gen allos = hscrpq + cfibq + hdlcholq + trigq + hba1cq + fgluq + ///
            sysvalq + diavalq + htfevq + htfvcq + htpefq + bmiq + wstvalq

gen allosw = 0.5*(hscrpq + cfibq) + ///
             0.25*(hdlcholq + trigq + hba1cq + fgluq) + ///
             0.5*(sysvalq + diavalq) + ///
             0.33*(htfevq + htfvcq + htpefq) + ///
             0.5*(bmiq + wstvalq)

gen allos8 = hscrpq + cfibq + hdlcholq + trigq + hba1cq + fgluq + ///
             sysvalq + diavalq + bmiq

gen allosw8 = 0.5*(hscrpq + cfibq) + ///
              0.25*(hdlcholq + trigq + hba1cq + fgluq) + ///
              0.5*(sysvalq + diavalq) + ///
              bmiq

gen allosw8_nofg = 0.5*(hscrpq + cfibq) + ///
                   (1/3)*(hdlcholq + trigq + hba1cq) + ///
                   0.5*(sysvalq + diavalq) + ///
                   bmiq

rename wv   wave
rename yr   year

sort idauniq wave

sort wave
by wave: sum allos allosw allos8 allosw8 allosw8_nofg

save allostaticload_wave2to11.dta, replace

foreach w in 2 4 6 8 9 11 {
    capture erase w`w'_temp.dta
}

  by wave: sum allosw8 allosw8_nofg

   use allostaticload_wave2to11, clear
  by wave: sum hyprx diarx cholrx

cd "../.."
