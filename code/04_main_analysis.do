use "data/temp/panel_wide.dta", clear

foreach x of numlist 6/11 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(scovwo) nogenerate nolabel noreport
  rename   (scovwo) ///
           (meaningfulness`x')
}

foreach x of numlist 6/11 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(scovan) nogenerate nolabel noreport
  rename   (scovan) ///
           (anxiety`x')
}

foreach x of numlist 1   3 4 5     8 9 10 11 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(hepain hepaa) nogenerate nolabel noreport
  rename   (hepain hepaa) ///
           (hepain`x' hepaa`x')
}

foreach x of numlist 2 6 7 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(HePain HePaa) nogenerate nolabel noreport
  rename   (HePain HePaa) ///
           (hepain`x' hepaa`x')
}

foreach x of numlist 1/11 {
  mvdecode hepain`x' hepaa`x', mv(-9/-1 = .a)
  generate pain`x' = (hepain`x' == 1) if !missing(hepain`x')
  replace  pain`x' = inlist(hepaa`x', 2, 3) if !missing(hepaa`x')
}

drop hepain* hepaa*

foreach x of numlist 1 2 3 4 5 6 7 8 9 10 11 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(scqolj scqolk scqoll scqolm scqoln) nogenerate nolabel noreport
  rename   (scqolj scqolk scqoll scqolm scqoln) ///
           (lookforward`x' meaning`x' enjoythings`x' enjoyothers`x' happiness`x')
}

foreach x of numlist 1 2 3 4 5 6 7 8 9 10 11 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(scqola scqolb scqolc scqold) nogenerate nolabel noreport
  rename   (scqola scqolb scqolc scqold) ///
           (ageprevents`x' outofcontrol`x' freetoplan`x' feelleftout`x')
}

foreach x of numlist 1 2 3 4 5 6 7 8 9 10 11 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(scqole scqolf scqolg scqolh scqoli) nogenerate nolabel noreport
  rename   (scqole scqolf scqolg scqolh scqoli) ///
           (dothingsiwant`x' familyconstrains`x' pleasemyself`x' healthconstrains`x' moneyconstrains`x')
}

foreach x of numlist 1 2 3 4 5 6 7 8 9 10 11 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(scqolo scqolp scqolq scqolr scqols) nogenerate nolabel noreport
  rename   (scqolo scqolp scqolq scqolr scqols) ///
           (fullofenergy`x' doingnewthings`x' satisfiedwlife`x' fullofopportunities`x' futurelooksgood`x')
}

foreach x of numlist   2 3 4 5 6 7 8 9 10 11 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(sclifea sclifeb sclifec sclifed sclifee) nogenerate nolabel noreport
  rename   (sclifea sclifeb sclifec sclifed sclifee) ///
           (swlsa`x' swlsb`x' swlsc`x' swlsd`x' swlse`x')
}

foreach x of numlist   2 3 4 5 6 7 8 9 10 11 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(scfeela scfeelb scfeelc scfeeld) nogenerate nolabel noreport
  rename   (scfeela scfeelb scfeelc scfeeld) ///
           (lonelya`x' lonelyb`x' lonelyc`x' lonelyd`x')
}

foreach x of numlist 1   3 4 5    8 9 10 11 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(psceda pscedb pscedc pscedd pscede pscedf pscedg pscedh) nogenerate nolabel noreport
  rename   (psceda pscedb pscedc pscedd pscede pscedf pscedg pscedh) ///
           (cesda`x' cesdb`x' cesdc`x' cesdd`x' cesde`x' cesdf`x' cesdg`x' cesdh`x' )
}
foreach x of numlist 2 6 7 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(PScedA PScedB PScedC PScedD PScedE PScedF PScedG PScedH) nogenerate nolabel noreport
  rename   (PScedA PScedB PScedC PScedD PScedE PScedF PScedG PScedH) ///
           (cesda`x' cesdb`x' cesdc`x' cesdd`x' cesde`x' cesdf`x' cesdg`x' cesdh`x' )
}

foreach x of numlist 1 8 9 10 11 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(mmwlka mmwlkb) nogenerate nolabel noreport
  rename   (mmwlka mmwlkb) ///
           (mmwlka`x' mmwlkb`x' )
}

foreach x of numlist 6 7 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(MMWlkA MMWlkB) nogenerate nolabel noreport
  rename   (MMWlkA MMWlkB) ///
           (mmwlka`x' mmwlkb`x' )
}

foreach x of numlist 1 6 7 8 9 10 11 {
	mvdecode mmwlka`x' mmwlkb`x', mv(-1 -8 -9 = .)
	replace mmwlka`x' = . if mmwlka`x' >= 30.00
	replace mmwlka`x' = . if mmwlka`x' <=  0.54
	replace mmwlkb`x' = . if mmwlkb`x' >= 30.00
	replace mmwlkb`x' = . if mmwlkb`x' <=  0.54
    generate gtspd_av`x' =  ((2.4384/mmwlka`x') + (2.4384/mmwlkb`x'))/2
	drop mmwlka`x' mmwlkb`x'
}

foreach x of numlist 2 {
merge 1:1 idauniq using "data/temp/wave_2_derived_variables.dta", ///
  keepusing(gtspd_av) nogenerate nolabel noreport
  rename   (gtspd_av) ///
           (gtspd_av`x')
}

foreach x of numlist 3 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(gtspd_av) nogenerate nolabel noreport
  rename   (gtspd_av) ///
           (gtspd_av`x')
}

foreach x of numlist 4 5 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(gtspd_mn) nogenerate nolabel noreport
  rename   (gtspd_mn) ///
           (gtspd_av`x' )
}

foreach x of numlist 1 3 4 5 8 9 10 11 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(heacta heactb heactc) nogenerate nolabel noreport
  rename   (heacta heactb heactc) ///
           (heacta`x' heactb`x' heactc`x')
}

foreach x of numlist 2 6 7 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(HeActa HeActb HeActc) nogenerate nolabel noreport
  rename   (HeActa HeActb HeActc) ///
           (heacta`x' heactb`x' heactc`x')
}

foreach x of numlist 1 3 4 5 8 9 10 11 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(heeye hehear) nogenerate nolabel noreport
  rename   (heeye hehear) ///
           (heeye`x' hehear`x')
}

foreach x of numlist 2 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(Heeye Hehear) nogenerate nolabel noreport
  rename   (Heeye Hehear) ///
           (heeye`x' hehear`x')
}

foreach x of numlist 6 7 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(HeEye HeHear) nogenerate nolabel noreport
  rename   (HeEye HeHear) ///
           (heeye`x' hehear`x')
}

foreach x of numlist 1 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(cflisen cflisd cfani ncorrec) nogenerate nolabel noreport
  rename   (cflisen cflisd cfani ncorrec) ///
           (cflisen`x' cflisd`x' cfani`x' ncorrec`x')
}

foreach x of numlist 2 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(CfLisEn CfLisD CfAni nncorre) nogenerate nolabel noreport
  rename   (CfLisEn CfLisD CfAni nncorre) ///
           (cflisen`x' cflisd`x' cfani`x' ncorrec`x')
}

foreach x of numlist 3 4 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(cflisen cflisd cfani ncorrect) nogenerate nolabel noreport
  rename   (cflisen cflisd cfani ncorrect) ///
           (cflisen`x' cflisd`x' cfani`x' ncorrec`x')
}

foreach x of numlist 5 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(cflisen cflisd cfani NCorrect) nogenerate nolabel noreport
  rename   (cflisen cflisd cfani NCorrect) ///
           (cflisen`x' cflisd`x' cfani`x' ncorrec`x')
}

foreach x of numlist 6 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(CfLisEn CfLisD) nogenerate nolabel noreport
  rename   (CfLisEn CfLisD) ///
           (cflisen`x' cflisd`x')
}

foreach x of numlist 7 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(CfLisEn CfLisD CfAni) nogenerate nolabel noreport
  rename   (CfLisEn CfLisD CfAni) ///
           (cflisen`x' cflisd`x' cfani`x')
}

foreach x of numlist 8 9 10 11 {
merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(cflisen cflisd cfani) nogenerate nolabel noreport
  rename   (cflisen cflisd cfani) ///
           (cflisen`x' cflisd`x' cfani`x')
}

foreach x of numlist 2 4 6 8 9 11 {
    if `x' < 10 local xf "0`x'"
    else         local xf "`x'"
    merge 1:1 idauniq using "data/temp/nurse`xf'.dta", ///
      keepusing(mmgsd1 mmgsn1 mmgsd2 mmgsn2 mmgsd3 mmgsn3) nogenerate nolabel noreport
    rename (mmgsd1 mmgsn1 mmgsd2 mmgsn2 mmgsd3 mmgsn3) ///
           (mmgsd1_`x' mmgsn1_`x' mmgsd2_`x' mmgsn2_`x' mmgsd3_`x' mmgsn3_`x')
}

foreach x of numlist 1/11 {
 merge 1:1 idauniq using "data/temp/wave_`x'_ifs_derived_variables", ///
  keepusing(lwgt sex    age    edqual    nonwhite    marstat   smoker wpactive    llsill srh_h*) nogenerate  noreport
  rename   (lwgt sex    age    edqual    nonwhite    marstat   smoker wpactive    llsill srh_hrs    srh_hse) ///
           (lwgt`x' sex`x' age`x' edqual`x' nonwhite`x' mstath`x' smoker`x' wpactive`x' llsill`x' srh_hrs`x' srh_hse`x')
}

foreach x of numlist 1/11 {
 merge 1:1 idauniq using "data/temp/wave_`x'_ifs_derived_variables", ///
  keepusing(hemobwa hemobsi hemobch hemobcs hemobcl hemobst hemobre hemobpu hemobli hemobpi) nogenerate noreport
  rename   (hemobwa hemobsi hemobch hemobcs hemobcl hemobst hemobre hemobpu hemobli hemobpi) ///
           (hemobwa`x' hemobsi`x' hemobch`x' hemobcs`x' hemobcl`x' hemobst`x' hemobre`x' hemobpu`x' hemobli`x' hemobpi`x')
}

foreach x of numlist 1/11 {
 merge 1:1 idauniq using "data/temp/wave_`x'_ifs_derived_variables", ///
  keepusing(headldr headlea headlwc headlba headlbe headlwa headlpr headlsh headlph headlme headlmo) nogenerate noreport
  rename   (headldr headlea headlwc headlba headlbe headlwa headlpr headlsh headlph headlme headlmo) ///
           (headldr`x' headlea`x' headlwc`x' headlba`x' headlbe`x' headlwa`x' headlpr`x' headlsh`x' headlph`x' headlme`x' headlmo`x')
}

clonevar sex = sex1
foreach x of numlist 2/11 {
 replace  sex = sex`x' if missing(sex)
}
generate female = (sex == 2)
drop sex sex*
label var female "Female (\emph{Ref.} male)"
label define female 0 "Male" 1 "Female"
label val female female

foreach x of numlist 1/11 {
 recode nonwhite`x' (-9    = .a) ///
                    (-8    = .b) ///
				    (-2    = .c) ///
				    (-1    = .d)
}

clonevar nonwhite = nonwhite1
foreach x of numlist 2/11 {
 replace  nonwhite = nonwhite`x' if missing(nonwhite)
}
drop nonwhite1 nonwhite2 nonwhite3 nonwhite4 nonwhite5 ///
     nonwhite6 nonwhite7 nonwhite8 nonwhite9 nonwhite10 nonwhite11
label var nonwhite "Non-white ethnic group (\emph{Ref.} white)"
label define nonwhite 0 "White" 1 "Non-white"
label val nonwhite nonwhite

egen educs = rowmax(edqual*)
recode educs      (-9  = 6 "Missing") ///
                  (-8  = 6 "Missing") ///
				  (-2  = 6 "Missing") ///
				  (-1  = 6 "Missing") ///
				  (7   = 0 "No qualification") ///
                  (6   = 1 "Foreign/other") ///
                  (4 5 = 2 "Lower secondary") ///
                  (3   = 3 "Upper secondary") ///
                  (2   = 4 "Some tertiary") ///
                  (1   = 5 "Tertiary"), gen(education)
label var education "Education"
drop edqual* educs

foreach x of numlist 1/11 {
 merge 1:1 idauniq using "data/temp/wave_`x'_financial_derived_variables", ///
  keepusing(eqtotinc_bu_s    nettotnhw_bu_s) nogenerate nolabel noreport
  rename   (eqtotinc_bu_s    nettotnhw_bu_s) ///
           (income`x' wealth`x')
}

foreach x of numlist 1/11 {
 merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(sclddr) nogenerate nolabel noreport
  rename   (sclddr) ///
           (sclddr`x')
}

merge 1:1 idauniq using "data/temp/core1.dta", keepusing(heala) nogenerate noreport
rename heala drink1

foreach x of numlist 2/8 10 11 {
 di `x'
 merge 1:1 idauniq using "data/temp/core`x'.dta", ///
  keepusing(scako) nogenerate noreport
  rename   (scako) ///
           (drink`x')
}

merge 1:1 idauniq using "data/temp/core9.dta", keepusing(scalcm) nogenerate noreport
rename scalcm drink9

merge 1:1 idauniq using "data/temp/core1.dta", keepusing(enssec anssec) nogenerate nolabel noreport
rename enssec nsseca
rename anssec nssec1
merge 1:1 idauniq using "data/temp/core2.dta", keepusing(w2nssec8) nogenerate nolabel noreport
rename w2nssec8 nssec2
merge 1:1 idauniq using "data/temp/core3.dta", keepusing(w3nssec) nogenerate nolabel noreport
rename w3nssec nssec3
merge 1:1 idauniq using "data/temp/core4.dta", keepusing(w4nssec) nogenerate nolabel noreport
rename w4nssec nssec4
merge 1:1 idauniq using "data/temp/core5.dta", keepusing(w5nssec) nogenerate nolabel noreport
rename w5nssec nssec5
merge 1:1 idauniq using "data/temp/core6.dta", keepusing(w6nssec13) nogenerate nolabel noreport
rename w6nssec13 nssec6
merge 1:1 idauniq using "data/temp/core7.dta", keepusing(NSSEC) nogenerate nolabel noreport
rename NSSEC nssec7
merge 1:1 idauniq using "data/temp/core8.dta", keepusing(w8nssec8) nogenerate nolabel noreport
rename w8nssec8 nssec8
merge 1:1 idauniq using "data/temp/core9.dta", keepusing(w9nssec8) nogenerate nolabel noreport
rename w9nssec8 nssec9
merge 1:1 idauniq using "data/temp/core10.dta", keepusing(w10nssec8) nogenerate nolabel noreport
rename w10nssec8 nssec10
merge 1:1 idauniq using "data/temp/core11.dta", keepusing(w11nssec8) nogenerate nolabel noreport
rename w11nssec8 nssec11

replace nssec1 = nsseca if missing(nssec1)
drop nsseca

recode nssec1 (-1 = 8) (1/3.4 = 1) (4.1/6 = 2) (7.1/7.4 = 3) (8.1/9.2 = 4) ///
              (10/11.2 = 5) (12.1/12.7 = 6) (13.1/13.5 = 7), generate(class1)
recode nssec2 (-1 = 8) (99 = 8), generate(class2)
recode nssec3 (-1 = 8) (1/3.4 = 1) (4.1/6 = 2) (7.1/7.4 = 3) (8.1/9.2 = 4) ///
              (10/11.2 = 5) (12.1/12.7 = 6) (13.1/13.5 = 7) (14/17 = 8), gen(class3)
recode nssec4 (-3/-1 = 8) (1/3.4 = 1) (4.1/6 = 2) (7.1/7.4 = 3) (8.1/9.2 = 4) ///
              (10/11.2 = 5) (12.1/12.7 = 6) (13.1/13.5 = 7) (14/17 = 8), gen(class4)
recode nssec5 (-3/-1 = 8) (1/3.4 = 1) (4.1/6 = 2) (7.1/7.4 = 3) (8.1/9.2 = 4) ///
              (10/11.2 = 5) (12.1/12.7 = 6) (13.1/13.5 = 7) (14/17 = 8), gen(class5)
recode nssec6 (-3/-1 = 8) (1/3.4 = 1) (4.1/6 = 2) (7.1/7.4 = 3) (8.1/9.2 = 4) ///
              (10/11.2 = 5) (12.1/12.7 = 6) (13.1/13.5 = 7) (14/17 = 8), gen(class6)
recode nssec7 (-3/-1 = 8) (1/3.4 = 1) (4.1/6 = 2) (7.1/7.4 = 3) (8.1/9.2 = 4) ///
              (10/11.2 = 5) (12.1/12.7 = 6) (13.1/13.5 = 7) (14/17 = 8), gen(class7)
recode nssec8 (-1 -3 = 8) (99 = 8), gen(class8)
recode nssec9 (-3 = 8) (99 = 8), gen(class9)
recode nssec10 (-3 -9 = 8), gen(class10)
recode nssec11 (-3 -9 = 8), gen(class11)

drop nssec*

egen float class = rowmin(class*)
label define class 1 "Higher managerial and professional" ///
                   2 "Lower managerial and professional" ///
                   3 "Intermediate occupations" ///
                   4 "Small employers and own account" ///
                   5 "Lower supervisory and technical" ///
                   6 "Semi-routine" ///
                   7 "Routine" ///
                   8 "Other"
label val class class
label var class "Social class"
drop class1-class11

reshape long srh_hrs srh_hse age mstath wealth income wpactive smoker drink lwgt sclddr ///
             lookforward meaning enjoythings enjoyothers happiness swlsa swlsb swlsc swlsd swlse lonelya lonelyb lonelyc lonelyd ///
			 cesda cesdb cesdc cesdd cesde cesdf cesdg cesdh ///
			 mmgsd1_ mmgsn1_ mmgsd2_ mmgsn2_ mmgsd3_ mmgsn3_ ///
			 gtspd_av ///
			 heacta heactb heactc ///
			 heeye hehear ///
			 cflisen cflisd cfani ncorrec ///
			 llsill ///
			 pain ///
			 meaningfulness ///
			 anxiety ///
			 ageprevents outofcontrol freetoplan feelleftout ///
			 dothingsiwant familyconstrains pleasemyself healthconstrains moneyconstrains ///
			 fullofenergy doingnewthings satisfiedwlife fullofopportunities futurelooksgood ///
			 headldr headlea headlwc headlba headlbe headlwa headlpr headlsh headlph headlme headlmo ///
			 hemobwa hemobsi hemobch hemobcs hemobcl hemobst hemobre hemobpu hemobli hemobpi ///
			, i(idauniq) j(wave)

rename age agex
recode agex (-8 = .b "Don't know") (99 = .x "90+"), gen(age)
label var age "Age"
drop agex
drop if missing(age)

mvdecode hemob*, mv(-9 = .a \ -8 = .b \ -1 = .c)
scores mobility = total(hemob*)

label var mobility "Mobility limitations"
drop hemob*

label var meaningfulness "Meaningfulness of life"
label var anxiety "Anxiety"
mvdecode meaningfulness anxiety, mv(-9 -8 -3 -2 -1 11 = .a)

label define pain 0 "No or mild" 1 "Moderate or severe"
label val pain pain
label var pain "Pain"

recode llsill (2 = 1 "Yes") (0 1 = 0 "No") (-3 = .a "Not in this wave") (-9 = .b) (-8 = .c), gen(lli)
label var lli "Limiting longstanding illness"

mvdecode lookforward meaning enjoythings enjoyothers happiness, mv(-9 = .a \ -1 = .b \ -8 = .c \ -3 = .d \ -2 = .e)

scores hedonicnonwellbeing = mean(lookforward meaning enjoythings enjoyothers happiness), nv(1) score(z)
gen hedonicwellbeing = -1 * hedonicnonwellbeing
label var hedonicwellbeing "Hedonic wellbeing"

drop lookforward meaning enjoythings enjoyothers happiness hedonicnonwellbeing

mvdecode ageprevents outofcontrol freetoplan feelleftout ///
         dothingsiwant familyconstrains pleasemyself healthconstrains moneyconstrains ///
		 fullofenergy doingnewthings satisfiedwlife fullofopportunities futurelooksgood ///
		 , mv(-9 = .a \ -1 = .b \ -8 = .c \ -3 = .d \ -2 = .e)

drop ageprevents outofcontrol freetoplan feelleftout ///
     dothingsiwant familyconstrains pleasemyself healthconstrains moneyconstrains ///
	 fullofenergy doingnewthings satisfiedwlife fullofopportunities futurelooksgood

mvdecode swlsa swlsb swlsc swlsd swlse, mv(-9 = .a \ -1 = .b \ -8 = .c \ -3 = .d \ -2 = .e)

scores evaluativenonwellbeing = mean(swlsa swlsb swlsc swlsd swlse), nv(1) score(z)
generate evaluativewellbeing = -1 * evaluativenonwellbeing
label var evaluativewellbeing "Evaluative wellbeing"
drop swlsa swlsb swlsc swlsd swlse evaluativenonwellbeing

mvdecode lonely*, mv(-9 = .a \ -1 = .b \ -8 = .c \ -3 = .d \ -2 = .e)
factor lonelya lonelyb lonelyc, pcf
scores loneliness = mean(lonelya lonelyb lonelyc), nv(1) score(z)
label var loneliness "Loneliness"
drop lonelya lonelyb lonelyc lonelyd

mvdecode cesd*, mv(-9 = .a \ -1 = .b \ -8 = .c \ -3 = .d \ -2 = .e)

recode cesdd cesdf (1 = 2) (2 = 1)
scores nodepression = mean(cesda cesdb cesdc cesdd cesde cesdf cesdg cesdh), nv(1) score(z)
generate cesd = -1 * nodepression
label var cesd "Depression"
drop cesda cesdb cesdc cesdd cesde cesdf cesdg cesdh nodepression

mvdecode gtspd_av, mv(-98/-1 = .)
label var gtspd_av "Gait speed"

generate physical_activity = 3
replace physical_activity = . if inlist(heacta, -9, -8, -1, .) | inlist(heactb, -9, -8, -1, .)
replace physical_activity = 0 if heactb == 4          & heacta == 4
replace physical_activity = 1 if inlist(heactb, 2, 3) & heacta == 4
replace physical_activity = 2 if (heactb == 1 & heacta == 4) | (heacta == 3 & heactb == 4)
replace physical_activity = 4 if heacta == 1
label var physical_activity "Physical activity"
label define physical_activity 0 "Sedentary" 4 "Active"
label val physical_activity physical_activity
drop heact*

generate eyesight = 1 if inlist(heeye, 1, 2, 3)
replace  eyesight = 0 if inlist(heeye, 4, 5, 6)
label var eyesight "Good eyesight"
label define eyesight 1 "Excellent or (very) good" 0 "Fair or poor or blind"
label val eyesight eyesight
drop heeye

generate hearing = 1 if inlist(hehear, 1, 2, 3)
replace  hearing = 0 if inlist(hehear, 4, 5)
label var hearing "Good hearing"
label define hearing 1 "Excellent or (very) good" 0 "Fair or poor"
label val hearing hearing
drop hehear

mvdecode cflisen cflisd, mv(-9 = .a \ -1 = .b \ -8 = .c \ -3 = .d \ -2 = .e)

scores memory = mean(cflisen cflisd)
label var memory "Memory"

drop cflisen cflisd

mvdecode cfani ncorrec, mv(-9 = .a \ -1 = .b \ -8 = .c \ -3 = .d \ -2 = .e \ 99 = .f)

rename cfani fluency
rename ncorrec cancellation
label var fluency "Executive function"
label var cancellation "Processing speed"

mvdecode mmgsd1_ mmgsn1_ mmgsd2_ mmgsn2_ mmgsd3_ mmgsn3_, mv(-9 = .a \ -1 = .b \ -8 = .c \ -3 = .d \ -2 = .e \ 99 = .f)

scores gripstrength = mean(mmgsd1_ mmgsn1_ mmgsd2_ mmgsn2_ mmgsd3_ mmgsn3_), nv(3)
drop mmgsd1_ mmgsn1_ mmgsd2_ mmgsn2_ mmgsd3_ mmgsn3_
label var gripstrength "Grip strength"

mvdecode headldr headlea headlwc headlba headlbe headlwa headlpr headlsh headlph headlme headlmo, mv(-9 = .a \ -1 = .b \ -8 = .c \ -3 = .d \ -2 = .e \ 99 = .f)

scores adl = total(headldr headlea headlwc headlba headlbe headlwa)
label var adl "ADL difficulties"

scores iadl = total(headlpr headlsh headlph headlme headlmo)
label var iadl "IADL difficulties"

scores adliadl = total(headldr headlea headlwc headlba headlbe headlwa ///
                       headlpr headlsh headlph headlme headlmo ///
					   )
label var adliadl "ADL/IADL difficulties"

drop headldr headlea headlwc headlba headlbe headlwa ///
                       headlpr headlsh headlph headlme headlmo

recode lwgt (-1 = .)
label var lwgt "Longitudinal weight"

recode smoker (-9   = .a "Refused") ///
              (-8   = .b "Don't know") ///
              (-2 . = .d "Not asked") ///
			  (0    =  0 "Non-smoker") ///
			  (1    =  1 "Smoker"), gen(smoking)
label var smoking "Smoking"
drop smoker

recode drink (1/2 =  1 Yes) ///
             (3/8 =  0 No) ///
             ( 9  = .f) ///
			 (-9  = .a Refusal) ///
			 (-8  = .b "Don't know") ///
			 (-2  = .c) (-3  = .d) ///
			 (-1  = .e "Not applicable"), gen(drinking)
label variable drinking "Drinking alcohol"
drop drink

recode srh_hrs (-9   = .a "Refused") ///
               (-8   = .b "Don't know") ///
               (-3   = .c "Not asked this wave") ///
               (-2 . = .d "Not asked") ///
               (-1 = .e "Inapplicable (proxy)") ///
               ( 5 =  0 "Poor") ///
               ( 4 =  1 "Fair") ///
               ( 3 =  2 "Good") ///
               ( 2 =  3 "Very good") ///
               ( 1 =  4 "Excellent") ///
               , gen(health)
label var health "Self-rated health"
recode srh_hrs (-9     = .a "Refused") ///
               (-8     = .b "Don't know") ///
               (-3     = .c "Not asked this wave") ///
               (-2 .   = .d "Not asked") ///
               (-1     = .e "Inapplicable (proxy)") ///
               ( 5 4 3 =  0 "Poor/fair/good") ///
               ( 2 =  1 "Very good/excellent") ///
               , gen(verygoodhealth)
label var verygoodhealth "Self-rated health very good or excellent"
drop srh_hse srh_hrs

rename wpactive working
label var working "Working (\emph{Ref.} Not working)"

generate marstat = .
replace  marstat = 1 if mstath == 1 | mstath == 2
replace  marstat = 2 if mstath == 5 | mstath == 6
replace  marstat = 3 if mstath == 4
replace  marstat = 4 if mstath == 3
capture label drop marstat
label define marstat 1 "Married/cohabiting" 2 "Divorced/separated" 3 "Widowed" 4 "Single, never married"
label val marstat marstat
label var marstat "Marital status"
drop mstath

rename sclddr sssx
recode sssx (-9 = .a "Not answered") ///
           (-1 = .b "Item not applicable") ///
		   (-2 = .c "Schedule not applicable") ///
		   (-3 = .d "No valid answer") ///
		   , gen(sss)
replace sss = sss / 10 if !missing(sss)
label var sss "Subjective SES"
drop sssx

gen lnincome = log(income + 1) if income > 0
sum income lnincome
drop income
label var lnincome "Household income (ln)"

generate  wealth_ihs = log(wealth + sqrt(wealth^2 + 1))
label var wealth_ihs "Household wealth (IHS)"
drop wealth

merge 1:1 idauniq wave using "data/temp/allostaticload_wave2to11.dta", nogenerate keep(master match) keepusing(allosw8_nofg lhscrp cfib hba1c bmi wstval sysval diaval htpef htfev htfvc hdl chol trig fglu)
rename allosw8_nofg allostatic
rename cfib fibrinogen
label var allostatic "Allostatic load"
label var lhscrp     "C-reactive protein"
label var bmi        "Body mass index"
label var sysval     "Systolic blood pressure"
label var diaval     "Diastolic blood pressure"
label var htfev      "Forced expiratory volume"
label var htfvc      "Forced vital capacity"
label var fibrinogen "Fibrinogen"
label var htpef      "Peak expiratory flow"
label var hdl        "HDL"
label var wstval     "Waist circumference"
label var chol       "Total cholesterol"
label var trig       "Triglycerides"
label var fglu       "Fasting blood glucose"
label var hba1c "Glycated hemoglobin"
gen hdlchol = hdl/chol
label var hdlchol "HDL/total cholesterol ratio"

generate obese = (bmi >= 30) if !missing(bmi)
label var obese "BMI obesity"

generate centrallyobese = (wstval >=  88) if !missing(wstval) & female
replace  centrallyobese = (wstval >= 102) if !missing(wstval) & !female
label var centrallyobese "Central obesity"

generate hisys = (sysval >= 140) if !missing(sysval)
label var hisys "High blood pressure: systolic"

generate hidia = (diaval >= 90) if !missing(diaval)
label var hidia "High blood pressure: diastolic"

generate hifglu = (fglu >= 7) if !missing(fglu)
label var hifglu "High fasting blood glucose"

foreach var in htfev htfvc htpef {
    gen `var'_botq = .

    foreach wave in 2 4 6 11 {
        quietly summarize `var' if wave == `wave', detail
        local p25 = r(p25)

        replace `var'_botq = 1 if wave == `wave' & `var' <= `p25' & !missing(`var')
        replace `var'_botq = 0 if wave == `wave' & `var' > `p25' & !missing(`var')
    }
}

label var htfev_botq "Low forced expiratory volume"
label var htfvc_botq "Low forced vital capacity"
label var htpef_botq "Low peak expiratory flow"

drop htfev htfvc htpef

mvdecode hba1c, mv(-8 = .a \ -6 = .b \ -2 = .c \ -1 = .d)
replace hba1c = .e if inrange(hba1c, -111, -33)

merge 1:1 idauniq wave using "data/temp/elsa_frailty_w1_11.dta", nogenerate keep(master match)
rename fraill frailty
label var frailty "Frailty"

save "data/temp/panel_long.dta", replace

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


mark sample1
mark sample2
markout sample2 idauniq wave age working i.marstat female nonwhite ib2.education ib2.class
mark sample3
markout sample3 idauniq wave age working i.marstat female nonwhite ib2.education ib2.class wealth_ihs lnincome
mark sample4
markout sample4 idauniq wave age working i.marstat female nonwhite ib2.education ib2.class wealth_ihs lnincome sss

preserve
qui count if sample1
local obs1 = r(N)
egen tag1 = tag(idauniq) if sample1
qui count if tag1
local part1 = r(N)
qui count if sample2
local obs2 = r(N)
egen tag2 = tag(idauniq) if sample2
qui count if tag2
local part2 = r(N)
qui count if sample3
local obs3 = r(N)
egen tag3 = tag(idauniq) if sample3
qui count if tag3
local part3 = r(N)
qui count if sample4
local obs4 = r(N)
egen tag4 = tag(idauniq) if sample4
qui count if tag4
local part4 = r(N)

local obs1_f : display %12.0fc `obs1'
local part1_f : display %12.0fc `part1'
local obs2_f : display %12.0fc `obs2'
local part2_f : display %12.0fc `part2'
local obs3_f : display %12.0fc `obs3'
local part3_f : display %12.0fc `part3'
local obs4_f : display %12.0fc `obs4'
local part4_f : display %12.0fc `part4'

// Table S2
file open myfile using "output/tables/dataselection.txt", write replace
file write myfile "Full sample & `part1_f' & `obs1_f' \\" _n
file write myfile "Excluding those with missing demographic variables & `part2_f' & `obs2_f' \\" _n
file write myfile "Additionally excluding those with missing income or wealth & `part3_f' & `obs3_f' \\" _n
file write myfile "Additionally excluding those with missing subjective socioeconomic status & `part4_f' & `obs4_f' \\" _n
file close myfile
restore

assert sample4 == touse, rc0

tab sample3 touse, mis

foreach x of varlist marstat education class {
  qui tab `x', gen(`x'y)
  foreach var of varlist `x'y* {
   local lab `: var label `var''
   local i = strpos("`lab'", "==") + 2
   local lab `: di substr("`lab'",  `i', .)'
   label var `var' "\dumm `lab'"
  }
}

local vars age female nonwhite marstaty* working educationy* classy* wealth_ihs lnincome

bysort idauniq touse (wave): gen byte first_obs = (_n == 1) if touse

// Table S3
eststo clear
eststo obs:    estpost tabstat `vars' if touse, statistics(mean sd min max n) columns(statistics)
eststo person: estpost tabstat `vars' if touse & first_obs == 1, statistics(mean sd min max n) columns(statistics)

esttab obs person using "output/tables/descriptives.tex", replace ///
                         refcat(educationy1 "Education" ///
						        marstaty1 "Marital status" ///
								classy1 "Social class", nolabel) ///
                         cells(mean(fmt(2)) sd(fmt(2) par keep(age lnincome wealth_ihs))) ///
						 collabels(none) ///
						 nogap ///
						 mtitle("Observations" "Participants") ///
						 stats(N, label("N") fmt(%9.0gc)) ///
						 noobs nonumber label booktabs longtable ///
						 title("Descriptive statistics of control variables for the core sample. Proportions or means (standard deviations in parentheses) \label{descriptives}")							 fragment

drop marstaty* educationy* classy* first_obs

// Text accompanying Figure S1
quietly summarize sss if touse
local sss_scale_stat = cond(r(max) <= 1, 10, 1)
quietly xtsum sss if touse
local sss_mean = r(mean)  * `sss_scale_stat'
local sss_sd_b = r(sd_b)  * `sss_scale_stat'
local sss_sd_w = r(sd_w)  * `sss_scale_stat'
local sss_min  = r(min)   * `sss_scale_stat'
local sss_max  = r(max)   * `sss_scale_stat'

file open sss_stats using "output/tables/sss_stats.tex", write replace
file write sss_stats ///
    "Across all person-wave observations, mean perceived status was " ///
    %4.2f (`sss_mean') " on the 1--10 scale (" ///
    _char(36) "SD_{between} = " %4.2f (`sss_sd_b') _char(36) ", " ///
    _char(36) "SD_{within} = " %4.2f (`sss_sd_w') _char(36) ")."
file close sss_stats

// Figure S1
tempvar sss_disp mean_sss within_sss

quietly summarize sss if touse
local sss_scale = cond(r(max) <= 1, 10, 1)
gen `sss_disp' = round(sss * `sss_scale') if touse
bysort idauniq: egen `mean_sss'   = mean(`sss_disp') if touse
gen `within_sss' = `sss_disp' - `mean_sss'           if touse

histogram `sss_disp' if touse, ///
    discrete freq barwidth(0.8) color(navy%60) lcolor(white) ///
    xlabel(1(1)10) ylabel(, format(%12.0gc)) ///
    xtitle("Perceived status" "(1-10, all observations)") ytitle("Number of observations") ///
    title("A. Overall") scheme(lean1) name(sss_a, replace) nodraw

preserve
keep if touse
bysort idauniq: keep if _n == 1
histogram `mean_sss', ///
    freq width(0.5) color(navy%60) lcolor(white) ///
    xlabel(1(1)10) ylabel(, format(%12.0gc)) ///
    xtitle("Person-mean" "perceived status (1-10)") ytitle("Number of persons") ///
    title("B. Between persons") scheme(lean1) name(sss_b, replace) nodraw
restore

histogram `within_sss' if touse, ///
    freq width(1) color(maroon%60) lcolor(white) ///
    xline(0, lcolor(black) lpattern(dash)) ///
    xlabel(, format(%9.0g)) ylabel(, format(%12.0gc)) ///
    xtitle("Within-person deviation" "(rungs from person mean)") ytitle("Number of observations") ///
    title("C. Within person") scheme(lean1) name(sss_c, replace) nodraw

graph combine sss_a sss_b sss_c, cols(3) scheme(lean1) ///
    note("Note: Panel B shows the distribution of each person's mean perceived status across waves." ///
         "Panel C shows deviations of each observation from the person mean (dashed line = 0).")
graph export "output/figures/sss_distributions.pdf", replace

// Table S4
local yvars "evaluativewellbeing hedonicwellbeing meaningfulness cesd loneliness anxiety health allostatic frailty physical_activity smoking drinking fluency memory cancellation gtspd_av gripstrength lli pain mobility adl iadl eyesight hearing hisys hidia lhscrp fibrinogen hba1c hdlchol trig hifglu obese centrallyobese htfev_botq htfvc_botq htpef_botq"

local non_discrete "gtspd_av gripstrength lhscrp fibrinogen hba1c hdlchol trig frailty"

local alpha_evaluativewellbeing "0.90"
local alpha_hedonicwellbeing    "0.81"
local alpha_cesd                "0.80"
local alpha_loneliness          "0.83"
local alpha_mobility            "0.87"

file open latex_table using "output/tables/outcome_table.txt", write replace

foreach y of local yvars {
    if "`y'" == "evaluativewellbeing" {
        file write latex_table "\multicolumn{10}{c}{\emph{Psychological and subjective wellbeing}} \\" _n
    }
    if "`y'" == "health" {
        file write latex_table "\multicolumn{10}{c}{\emph{Summary measures of health}} \\" _n
    }
    if "`y'" == "physical_activity" {
        file write latex_table "\multicolumn{10}{c}{\emph{Health behaviours}} \\" _n
    }
    if "`y'" == "fluency" {
        file write latex_table "\multicolumn{10}{c}{\emph{Cognitive function}} \\" _n
    }
    if "`y'" == "gtspd_av" {
        file write latex_table "\multicolumn{10}{c}{\emph{Physical health and function}} \\" _n
    }
    if "`y'" == "hisys" {
        file write latex_table "\multicolumn{10}{c}{\emph{Cardiovascular biomarkers}} \\" _n
    }
    if "`y'" == "lhscrp" {
        file write latex_table "\multicolumn{10}{c}{\emph{Inflammation biomarkers}} \\" _n
    }
    if "`y'" == "hba1c" {
        file write latex_table "\multicolumn{10}{c}{\emph{Metabolic biomarkers}} \\" _n
    }
    if "`y'" == "obese" {
        file write latex_table "\multicolumn{10}{c}{\emph{Body fat biomarkers}} \\" _n
    }
    if "`y'" == "htfev_botq" {
        file write latex_table "\multicolumn{10}{c}{\emph{Lung function biomarkers}} \\" _n
    }

    local is_discrete = 1
    foreach var of local non_discrete {
        if "`y'" == "`var'" {
            local is_discrete = 0
            continue, break
        }
    }

    if `is_discrete' == 1 {
        hist `y', ///
         discrete legend(off) yscale(range(0 .09) off) xscale(off) fcolor(black*20000) ///
         lcolor(black) ysize(1.5) xsize(4.5) plotregion(fcolor(none) lcolor(none) margin(zero) )  graphregion(fcolor(none) margin(zero) ) ///
        ylabel(,nogrid) name(hist_`y', replace)
    }
    else {
        hist `y', ///
         legend(off) yscale(range(0 .09) off) xscale(off) fcolor(black*20000) ///
         lcolor(black) ysize(1.5) xsize(4.5) plotregion(fcolor(none) lcolor(none) margin(zero) )  graphregion(fcolor(none) margin(zero) ) ///
        ylabel(,nogrid) name(hist_`y', replace)
    }
    graph export "output/figures/hist_`y'.pdf", replace

    local var_label : variable label `y'

    quietly summarize `y' if touse
    local min_val = r(min)
    local max_val = r(max)

    quietly xtsum `y' if touse
    local sd_between = r(sd_b)
    local sd_within = r(sd_w)

    quietly count if !missing(`y') & touse
    local n_obs = r(N)

    preserve
    keep if !missing(`y') & touse
    quietly duplicates drop idauniq, force
    local n_participants = _N
    restore

    quietly levelsof wave if !missing(`y') & touse, local(available_waves)

    local formatted_waves ""
    local wave_list `available_waves'
    local n_waves : word count `wave_list'

    if `n_waves' > 0 {
        local i = 1
        while `i' <= `n_waves' {
            local start_wave : word `i' of `wave_list'
            local end_wave `start_wave'
            local j = `i' + 1

            while `j' <= `n_waves' {
                local next_wave : word `j' of `wave_list'
                if `next_wave' == `end_wave' + 1 {
                    local end_wave `next_wave'
                    local j = `j' + 1
                }
                else {
                    continue, break
                }
            }

            if `start_wave' == `end_wave' {
                local range "`start_wave'"
            }
            else if `end_wave' == `start_wave' + 1 {
                local range "`start_wave', `end_wave'"
            }
            else {
                local range "`start_wave'--`end_wave'"
            }

            if "`formatted_waves'" == "" {
                local formatted_waves "`range'"
            }
            else {
                local formatted_waves "`formatted_waves', `range'"
            }

            local i = `j'
        }
    }

    local n_obs_f : display %12.0fc `n_obs'
    local n_participants_f : display %12.0fc `n_participants'
    local n_obs_f = trim("`n_obs_f'")
    local n_participants_f = trim("`n_participants_f'")

    local this_alpha ""
    if "`y'" == "evaluativewellbeing" local this_alpha "0.90"
    if "`y'" == "hedonicwellbeing"    local this_alpha "0.81"
    if "`y'" == "cesd"                local this_alpha "0.80"
    if "`y'" == "loneliness"          local this_alpha "0.83"
    if "`y'" == "mobility"            local this_alpha "0.87"
    if "`this_alpha'" != "" local alpha_str "\$\alpha = `this_alpha'\$"
    else                    local alpha_str ""

    local var_label_latex = subinstr("`var_label'", "{it:(rev.)}", "\textit{(rev.)}", .)

    file write latex_table "`var_label_latex' & `alpha_str' & " %9.3f (`min_val') " & " %9.3f (`max_val') " & \includegraphics[scale=.08]{../results/hist_`y'.pdf} & " %9.3f (`sd_between') " & " %9.3f (`sd_within') " & `formatted_waves' & `n_participants_f' & `n_obs_f' \\" _n

}

file close latex_table

global continuous "health frailty cesd hedonicwellbeing evaluativewellbeing meaningfulness anxiety loneliness physical_activity mobility adl iadl gtspd_av gripstrength memory fluency cancellation trig hba1c fibrinogen lhscrp allostatic hdlchol"
global binary "lli pain eyesight hearing smoking drinking obese centrallyobese hisys hidia hifglu htfev_botq htfvc_botq htpef_botq"

global allvars "$continuous $binary"

// Figure S3
pwcorr $allvars

matrix C = r(C)
matrix Correlation = C

heatplot Correlation, color(hcl diverging, intensity(.6)) ///
    aspectratio(1) nodiagonal lower scheme(lean1) label ///
	xscale(alt) ysize(14) xsize(14) title("") ///
	xlabel(, labsize(tiny) angle(90)) ylabel(, labsize(tiny)) ///
	ramp(format(%4.2f))

graph export "output/figures/correlations.pdf", replace

// Estimates behind Figure 1, Figure S6, Table S7 and Table S8
tempname foo
postfile `foo' str50 depvar str50 outcome ols ols_se re re_se fe fe_se fe_male fe_male_se fe_female fe_female_se n residual_sd using "output/estimates/main_estimates.dta", replace

foreach y of varlist $continuous $binary {
	di "`y'"
	local lab: variable label `y'
	qui regress `y' sss $controls $tccontrols i.wave if touse, cluster(idauniq)
	local ols    = _b[sss]
	local ols_se = _se[sss]
	qui xtreg  `y' sss $controls $tccontrols i.wave if touse, re vce(cluster idauniq)
	local re     = _b[sss]
	local re_se  = _se[sss]
	qui xtreg  `y' sss $controls i.wave if touse, fe vce(cluster idauniq)
	local fe     = _b[sss]
	local fe_se  = _se[sss]
	local residual_sd = e(sigma_e)
	local n = e(N_g)

	qui xtreg  `y' sss $controls i.wave if touse & female == 0, fe vce(cluster idauniq)
	local fe_male    = _b[sss]
	local fe_male_se = _se[sss]

	qui xtreg  `y' sss $controls i.wave if touse & female == 1, fe vce(cluster idauniq)
	local fe_female    = _b[sss]
	local fe_female_se = _se[sss]

    post `foo' ("`y'") ("`lab'") (`ols') (`ols_se') (`re') (`re_se') (`fe') (`fe_se') (`fe_male') (`fe_male_se') (`fe_female') (`fe_female_se') (`n') (`residual_sd')
}
postclose `foo'

use "output/estimates/main_estimates.dta", clear

gen continuous = 0
replace continuous = 1 if inlist(depvar, "health", "cesd", "hedonicwellbeing", "evaluativewellbeing", "meaningfulness", "anxiety", "loneliness", "physical_activity", "mobility")
replace continuous = 1 if inlist(depvar, "adl", "iadl", "gtspd_av", "gripstrength", "memory", "fluency", "cancellation", "trig", "hba1c")
replace continuous = 1 if inlist(depvar, "fibrinogen", "lhscrp")
replace continuous = 1 if inlist(depvar, "bmi", "allostatic", "hdlchol", "frailty")

foreach i in ols re fe {
	generate `i'_ub = `i' + 1.96 * `i'_se
	generate `i'_lb = `i' - 1.96 * `i'_se
}

local n_outcomes = _N
local bonferroni_z = invnormal(1 - 0.05/(2*`n_outcomes'))
di "Number of outcomes: " `n_outcomes'
di "Bonferroni critical z-value: " `bonferroni_z'

foreach i in ols re fe {
	generate `i'_ub_bonf = `i' + `bonferroni_z' * `i'_se
	generate `i'_lb_bonf = `i' - `bonferroni_z' * `i'_se
}

egen sort_continuous = rank(fe) if continuous==1, unique
egen sort_binary = rank(fe) if continuous==0, unique

labmask sort_continuous if continuous==1, value(outcome)
labmask sort_binary if continuous==0, value(outcome)

gen nonsig_re = (re_lb_bonf <= 0 & re_ub_bonf >= 0)
gen nonsig_fe = (fe_lb_bonf <= 0 & fe_ub_bonf >= 0)

// Figure 1
twoway (scatter  sort_continuous re if nonsig_re==0 & continuous==1, msymbol(d) msize(*.4) mcolor(blue)) ///
       (scatter  sort_continuous re if nonsig_re==1 & continuous==1, msymbol(d) msize(*.4) mcolor(blue%10)) ///
       (rspike re_lb re_ub sort_continuous if nonsig_re==0 & continuous==1, horizontal lwidth(thick) lcolor(blue%70)) ///
       (rspike re_lb re_ub sort_continuous if nonsig_re==1 & continuous==1, horizontal lwidth(thick) lcolor(blue%10)) ///
       (rspike re_lb_bonf re_ub_bonf sort_continuous if nonsig_re==0 & continuous==1, horizontal lcolor(blue%70)) ///
       (rspike re_lb_bonf re_ub_bonf sort_continuous if nonsig_re==1 & continuous==1, horizontal lcolor(blue%10)) ///
       (scatter sort_continuous fe if nonsig_fe==0 & continuous==1, msymbol(d) msize(*.4) mcolor(red)) ///
       (scatter sort_continuous fe if nonsig_fe==1 & continuous==1, msymbol(d) msize(*.4) mcolor(red%10)) ///
       (rspike fe_lb fe_ub sort_continuous if nonsig_fe==0 & continuous==1, horizontal lwidth(thick) lcolor(red%70)) ///
       (rspike fe_lb fe_ub sort_continuous if nonsig_fe==1 & continuous==1, horizontal lwidth(thick) lcolor(red%10)) ///
       (rspike fe_lb_bonf fe_ub_bonf sort_continuous if nonsig_fe==0 & continuous==1, horizontal lcolor(red%70)) ///
       (rspike fe_lb_bonf fe_ub_bonf sort_continuous if nonsig_fe==1 & continuous==1, horizontal lcolor(red%10)) ///
	   , xscale(alt) xtitle("Subjective socio-economic status" "Regression coefficient") ///
	   title({bf:A}, span bexpand justification(left)) ///
	   xlabel(, format(%6.2f)) ///
	   xline(0) legend(order(1 "Random effects" 7 "Fixed effects") ring(0) pos(4) cols(1)) ///
	   ytitle(Outcome) ylabel(1/23, val) name(figure1_continuous, replace)

twoway (scatter  sort_binary re if nonsig_re==0 & continuous==0, msymbol(d) msize(*.4) mcolor(blue)) ///
       (scatter  sort_binary re if nonsig_re==1 & continuous==0, msymbol(d) msize(*.4) mcolor(blue%10)) ///
       (rspike re_lb re_ub sort_binary if nonsig_re==0 & continuous==0, horizontal lwidth(thick) lcolor(blue%70)) ///
       (rspike re_lb re_ub sort_binary if nonsig_re==1 & continuous==0, horizontal lwidth(thick) lcolor(blue%10)) ///
       (rspike re_lb_bonf re_ub_bonf sort_binary if nonsig_re==0 & continuous==0, horizontal lcolor(blue%70)) ///
       (rspike re_lb_bonf re_ub_bonf sort_binary if nonsig_re==1 & continuous==0, horizontal lcolor(blue%10)) ///
       (scatter sort_binary fe if nonsig_fe==0 & continuous==0, msymbol(d) msize(*.4) mcolor(red)) ///
       (scatter sort_binary fe if nonsig_fe==1 & continuous==0, msymbol(d) msize(*.4) mcolor(red%10)) ///
       (rspike fe_lb fe_ub sort_binary if nonsig_fe==0 & continuous==0, horizontal lwidth(thick) lcolor(red%70)) ///
       (rspike fe_lb fe_ub sort_binary if nonsig_fe==1 & continuous==0, horizontal lwidth(thick) lcolor(red%10)) ///
       (rspike fe_lb_bonf fe_ub_bonf sort_binary if nonsig_fe==0 & continuous==0, horizontal lcolor(red%70)) ///
       (rspike fe_lb_bonf fe_ub_bonf sort_binary if nonsig_fe==1 & continuous==0, horizontal lcolor(red%10)) ///
	   , xscale(alt) xtitle("Subjective socio-economic status" "Average marginal effect") ///
	   title({bf:B}, span bexpand justification(left)) ///
	   xlabel(, format(%6.2f)) ///
	   xline(0) legend(off) ///
	   ytitle(Outcome) ylabel(1/14, val) name(figure1_binary, replace) fysize(45)

graph combine figure1_continuous figure1_binary, col(1) ysize(10) name(figure1, replace)
graph export "output/figures/figure1.pdf", replace

// E-values for Figure S4 and Table S8
gen fe_scaled = (fe / residual_sd) * 1
gen fe_lb_bonf_scaled = (fe_lb_bonf / residual_sd) * 1
gen fe_ub_bonf_scaled = (fe_ub_bonf / residual_sd) * 1

gen fe_rr = exp(0.91 * fe_scaled)
gen fe_lb_bonf_rr = exp(0.91 * fe_lb_bonf_scaled)
gen fe_ub_bonf_rr = exp(0.91 * fe_ub_bonf_scaled)

gen evalue = .
replace evalue = fe_rr + sqrt(fe_rr * (fe_rr - 1)) if nonsig_fe==0 & fe_rr >= 1
replace evalue = (1/fe_rr) + sqrt((1/fe_rr) * ((1/fe_rr) - 1)) if nonsig_fe==0 & fe_rr < 1

gen evalue_lb = .
gen evalue_ub = .

replace evalue_lb = fe_lb_bonf_rr + sqrt(fe_lb_bonf_rr * (fe_lb_bonf_rr - 1)) if fe_lb_bonf_rr >= 1
replace evalue_lb = (1/fe_lb_bonf_rr) + sqrt((1/fe_lb_bonf_rr) * ((1/fe_lb_bonf_rr) - 1)) if fe_lb_bonf_rr < 1

replace evalue_ub = fe_ub_bonf_rr + sqrt(fe_ub_bonf_rr * (fe_ub_bonf_rr - 1)) if fe_ub_bonf_rr >= 1
replace evalue_ub = (1/fe_ub_bonf_rr) + sqrt((1/fe_ub_bonf_rr) * ((1/fe_ub_bonf_rr) - 1)) if fe_ub_bonf_rr < 1

gen ci_border_evalue = .
replace ci_border_evalue = evalue_lb if nonsig_fe==0 & evalue_lb < evalue_ub
replace ci_border_evalue = evalue_ub if nonsig_fe==0 & evalue_ub <= evalue_lb

drop fe_scaled fe_lb_bonf_scaled fe_ub_bonf_scaled fe_rr fe_lb_bonf_rr fe_ub_bonf_rr evalue_lb evalue_ub

egen sort_ = rank(evalue) if !nonsig_fe, unique
labmask sort_  if !nonsig_fe, value(outcome)

twoway (scatter sort_ evalue if nonsig_fe==0, msymbol(d) mcolor(red)) ///
       (scatter sort_ ci_border_evalue if nonsig_fe==0, msymbol(o) mcolor(blue)) ///
       , ytitle("Outcome") ylabel(1/13, val) ///
       xtitle("E-value") xscale(alt) xlabel(, format(%6.1f)) ///
       legend(order(1 "Point estimate" 2 "95% CI border closer to 0") ring(0) pos(4)) ///
       name(evalue, replace) ysize(4)
graph export "output/figures/evalues.pdf", replace

// Table S8
preserve
gsort -continuous -fe

capture file close tbl
file open tbl using "output/tables/coefficients_table.tex", write replace

file write tbl "\begin{longtable}{lrcrccc}" _n
file write tbl "\caption{Associations between subjective socioeconomic status and 37 health outcomes:" _n
file write tbl " random effects and fixed effects coefficients with Bonferroni-corrected 95\% confidence intervals." _n
file write tbl " E-values are reported for outcomes where fixed effects estimates are Bonferroni-significant." _n
file write tbl " Continuous outcomes show standardised coefficients; binary outcomes show average marginal effects." _n
file write tbl "\label{tab:coefficients}}\\" _n
file write tbl "\toprule" _n
file write tbl " & \multicolumn{2}{c}{Random effects} & \multicolumn{2}{c}{Fixed effects} & \multicolumn{2}{c}{E-value} \\" _n
file write tbl "\cmidrule(lr){2-3}\cmidrule(lr){4-5}\cmidrule(lr){6-7}" _n
file write tbl "Outcome & \$\hat{\beta}\$ & Bonf.\ 95\% CI & \$\hat{\beta}\$ & Bonf.\ 95\% CI & Point est. & CI border \\" _n
file write tbl "\midrule\endfirsthead" _n
file write tbl "\multicolumn{7}{c}{\emph{Table continued from previous page}}\\" _n
file write tbl "\toprule" _n
file write tbl " & \multicolumn{2}{c}{Random effects} & \multicolumn{2}{c}{Fixed effects} & \multicolumn{2}{c}{E-value} \\" _n
file write tbl "\cmidrule(lr){2-3}\cmidrule(lr){4-5}\cmidrule(lr){6-7}" _n
file write tbl "Outcome & \$\hat{\beta}\$ & Bonf.\ 95\% CI & \$\hat{\beta}\$ & Bonf.\ 95\% CI & Point est. & CI border \\" _n
file write tbl "\midrule\endhead" _n
file write tbl "\midrule\endfoot" _n
file write tbl "\bottomrule" _n
file write tbl "\multicolumn{7}{p{0.95\linewidth}}{\emph{Note:} Confidence intervals are Bonferroni-corrected for 37 simultaneous tests." _n
file write tbl " Fixed effects coefficients that are Bonferroni-significant are shown in bold." _n
file write tbl " The CI border E-value is calculated for the confidence interval bound closer to zero.}\\" _n
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

    local lab   = subinstr(outcome[`r'], "{it:(rev.)}", "\textit{(rev.)}", .)
    local re_v  = string(re[`r'],          "%6.3f")
    local re_lb = string(re_lb_bonf[`r'],  "%6.3f")
    local re_ub = string(re_ub_bonf[`r'],  "%6.3f")
    local fe_v  = string(fe[`r'],          "%6.3f")
    local fe_lb = string(fe_lb_bonf[`r'],  "%6.3f")
    local fe_ub = string(fe_ub_bonf[`r'],  "%6.3f")
    local nsig  = nonsig_fe[`r']

    if `nsig' == 0 {
        local fe_fmt = "\textbf{`fe_v'}"
        local ev     = string(evalue[`r'],           "%5.2f")
        local ev_c   = string(ci_border_evalue[`r'], "%5.2f")
    }
    else {
        local fe_fmt = "`fe_v'"
        local ev     = "---"
        local ev_c   = "---"
    }

    file write tbl "`lab' & `re_v' & [`re_lb', `re_ub'] & `fe_fmt' & [`fe_lb', `fe_ub'] & `ev' & `ev_c' \\" _n
}

file write tbl "\end{longtable}" _n
file close tbl
restore

// Figure S6
gen fe_diff = fe_female - fe_male
gen fe_diff_se = sqrt(fe_female_se^2 + fe_male_se^2)

generate fe_diff_ub = fe_diff + 1.96 * fe_diff_se
generate fe_diff_lb = fe_diff - 1.96 * fe_diff_se
generate fe_diff_ub_bonf = fe_diff + `bonferroni_z' * fe_diff_se
generate fe_diff_lb_bonf = fe_diff - `bonferroni_z' * fe_diff_se

gen nonsig_diff = (fe_diff_lb_bonf <= 0 & fe_diff_ub_bonf >= 0)

twoway (scatter sort_continuous fe_diff if nonsig_diff==0 & continuous==1, msymbol(d) msize(*.4) mcolor(purple)) ///
       (scatter sort_continuous fe_diff if nonsig_diff==1 & continuous==1, msymbol(d) msize(*.4) mcolor(purple%10)) ///
       (rspike fe_diff_lb fe_diff_ub sort_continuous if nonsig_diff==0 & continuous==1, horizontal lwidth(thick) lcolor(purple%70)) ///
       (rspike fe_diff_lb fe_diff_ub sort_continuous if nonsig_diff==1 & continuous==1, horizontal lwidth(thick) lcolor(purple%10)) ///
       (rspike fe_diff_lb_bonf fe_diff_ub_bonf sort_continuous if nonsig_diff==0 & continuous==1, horizontal lcolor(purple%70)) ///
       (rspike fe_diff_lb_bonf fe_diff_ub_bonf sort_continuous if nonsig_diff==1 & continuous==1, horizontal lcolor(purple%10)) ///
       , xscale(alt) xtitle("Difference in subjective SES coefficient" "(Women minus men)") ///
       title({bf:A}, span bexpand justification(left)) ///
       xlabel(, format(%6.2f)) xline(0) legend(off) ///
       ytitle(Outcome) ylabel(1/23, val) name(diff_continuous, replace)

twoway (scatter sort_binary fe_diff if nonsig_diff==0 & continuous==0, msymbol(d) msize(*.4) mcolor(purple)) ///
       (scatter sort_binary fe_diff if nonsig_diff==1 & continuous==0, msymbol(d) msize(*.4) mcolor(purple%10)) ///
       (rspike fe_diff_lb fe_diff_ub sort_binary if nonsig_diff==0 & continuous==0, horizontal lwidth(thick) lcolor(purple%70)) ///
       (rspike fe_diff_lb fe_diff_ub sort_binary if nonsig_diff==1 & continuous==0, horizontal lwidth(thick) lcolor(purple%10)) ///
       (rspike fe_diff_lb_bonf fe_diff_ub_bonf sort_binary if nonsig_diff==0 & continuous==0, horizontal lcolor(purple%70)) ///
       (rspike fe_diff_lb_bonf fe_diff_ub_bonf sort_binary if nonsig_diff==1 & continuous==0, horizontal lcolor(purple%10)) ///
       , xscale(alt) xtitle("Difference in subjective SES coefficient" "(Women minus men)") ///
       title({bf:B}, span bexpand justification(left)) ///
       xlabel(, format(%6.3f)) xline(0) legend(off) ///
       ytitle(Outcome) ylabel(1/14, val) name(diff_binary, replace) fysize(45)

graph combine diff_continuous diff_binary, col(1) ysize(10) name(sex_differences, replace)
graph export "output/figures/sex_differences.pdf", replace
