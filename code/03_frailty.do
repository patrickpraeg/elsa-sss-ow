// Frailty index (Table S6, Table S4, Figure 1)
clear all
set maxvar 32767

global wdir "data/temp"
global odir "."
cd "$wdir"

tempfile w1 w2 w3 w4 w5 w6 w7 w8 w9 w10 w11 merged

use core1.dta, clear

gen r1agey = indager

gen r1hemobwa = 0
replace r1hemobwa = 1 if heada01==1 | heada02==1 | heada03==1 | heada04==1 | heada05==1 | ///
                         heada06==1 | heada07==1 | heada08==1 | heada09==1 | heada10==1
gen r1hemobsi = 0
replace r1hemobsi = 1 if heada01==2 | heada02==2 | heada03==2 | heada04==2 | heada05==2 | ///
                         heada06==2 | heada07==2 | heada08==2 | heada09==2 | heada10==2
gen r1hemobch = 0
replace r1hemobch = 1 if heada01==3 | heada02==3 | heada03==3 | heada04==3 | heada05==3 | ///
                         heada06==3 | heada07==3 | heada08==3 | heada09==3 | heada10==3
gen r1hemobcs = 0
replace r1hemobcs = 1 if heada01==4 | heada02==4 | heada03==4 | heada04==4 | heada05==4 | ///
                         heada06==4 | heada07==4 | heada08==4 | heada09==4 | heada10==4
gen r1hemobcl = 0
replace r1hemobcl = 1 if heada01==5 | heada02==5 | heada03==5 | heada04==5 | heada05==5 | ///
                         heada06==5 | heada07==5 | heada08==5 | heada09==5 | heada10==5
gen r1hemobst = 0
replace r1hemobst = 1 if heada01==6 | heada02==6 | heada03==6 | heada04==6 | heada05==6 | ///
                         heada06==6 | heada07==6 | heada08==6 | heada09==6 | heada10==6
gen r1hemobre = 0
replace r1hemobre = 1 if heada01==7 | heada02==7 | heada03==7 | heada04==7 | heada05==7 | ///
                         heada06==7 | heada07==7 | heada08==7 | heada09==7 | heada10==7
gen r1hemobpu = 0
replace r1hemobpu = 1 if heada01==8 | heada02==8 | heada03==8 | heada04==8 | heada05==8 | ///
                         heada06==8 | heada07==8 | heada08==8 | heada09==8 | heada10==8
gen r1hemobli = 0
replace r1hemobli = 1 if heada01==9 | heada02==9 | heada03==9 | heada04==9 | heada05==9 | ///
                         heada06==9 | heada07==9 | heada08==9 | heada09==9 | heada10==9
gen r1hemobpi = 0
replace r1hemobpi = 1 if heada01==10 | heada02==10 | heada03==10 | heada04==10 | heada05==10 | ///
                         heada06==10 | heada07==10 | heada08==10 | heada09==10 | heada10==10

gen r1headldr = 0
replace r1headldr = 1 if headb01==1  | headb02==1  | headb03==1  | headb04==1  | headb05==1  | ///
                         headb06==1  | headb07==1  | headb08==1  | headb09==1  | headb10==1  | ///
                         headb11==1  | headb12==1  | headb13==1
gen r1headlwa = 0
replace r1headlwa = 1 if headb01==2  | headb02==2  | headb03==2  | headb04==2  | headb05==2  | ///
                         headb06==2  | headb07==2  | headb08==2  | headb09==2  | headb10==2  | ///
                         headb11==2  | headb12==2  | headb13==2
gen r1headlba = 0
replace r1headlba = 1 if headb01==3  | headb02==3  | headb03==3  | headb04==3  | headb05==3  | ///
                         headb06==3  | headb07==3  | headb08==3  | headb09==3  | headb10==3  | ///
                         headb11==3  | headb12==3  | headb13==3
gen r1headlea = 0
replace r1headlea = 1 if headb01==4  | headb02==4  | headb03==4  | headb04==4  | headb05==4  | ///
                         headb06==4  | headb07==4  | headb08==4  | headb09==4  | headb10==4  | ///
                         headb11==4  | headb12==4  | headb13==4
gen r1headlbe = 0
replace r1headlbe = 1 if headb01==5  | headb02==5  | headb03==5  | headb04==5  | headb05==5  | ///
                         headb06==5  | headb07==5  | headb08==5  | headb09==5  | headb10==5  | ///
                         headb11==5  | headb12==5  | headb13==5
gen r1headlwc = 0
replace r1headlwc = 1 if headb01==6  | headb02==6  | headb03==6  | headb04==6  | headb05==6  | ///
                         headb06==6  | headb07==6  | headb08==6  | headb09==6  | headb10==6  | ///
                         headb11==6  | headb12==6  | headb13==6
gen r1headlma = 0
replace r1headlma = 1 if headb01==7  | headb02==7  | headb03==7  | headb04==7  | headb05==7  | ///
                         headb06==7  | headb07==7  | headb08==7  | headb09==7  | headb10==7  | ///
                         headb11==7  | headb12==7  | headb13==7
gen r1headlpr = 0
replace r1headlpr = 1 if headb01==8  | headb02==8  | headb03==8  | headb04==8  | headb05==8  | ///
                         headb06==8  | headb07==8  | headb08==8  | headb09==8  | headb10==8  | ///
                         headb11==8  | headb12==8  | headb13==8
gen r1headlsh = 0
replace r1headlsh = 1 if headb01==9  | headb02==9  | headb03==9  | headb04==9  | headb05==9  | ///
                         headb06==9  | headb07==9  | headb08==9  | headb09==9  | headb10==9  | ///
                         headb11==9  | headb12==9  | headb13==9
gen r1headlph = 0
replace r1headlph = 1 if headb01==10 | headb02==10 | headb03==10 | headb04==10 | headb05==10 | ///
                         headb06==10 | headb07==10 | headb08==10 | headb09==10 | headb10==10 | ///
                         headb11==10 | headb12==10 | headb13==10
gen r1headlme = 0
replace r1headlme = 1 if headb01==11 | headb02==11 | headb03==11 | headb04==11 | headb05==11 | ///
                         headb06==11 | headb07==11 | headb08==11 | headb09==11 | headb10==11 | ///
                         headb11==11 | headb12==11 | headb13==11
gen r1headlho = 0
replace r1headlho = 1 if headb01==12 | headb02==12 | headb03==12 | headb04==12 | headb05==12 | ///
                         headb06==12 | headb07==12 | headb08==12 | headb09==12 | headb10==12 | ///
                         headb11==12 | headb12==12 | headb13==12
gen r1headlmo = 0
replace r1headlmo = 1 if headb01==13 | headb02==13 | headb03==13 | headb04==13 | headb05==13 | ///
                         headb06==13 | headb07==13 | headb08==13 | headb09==13 | headb10==13 | ///
                         headb11==13 | headb12==13 | headb13==13

rename (hehelf psceda pscedb pscedc pscedd pscede pscedf pscedg pscedh ///
        heeye hehear hefla hefrac heji mmpain ///
        cfdatd cfdatm cfdaty cfday cflisen cflisd) ///
       (r1hehelf r1psceda r1pscedb r1pscedc r1pscedd r1pscede r1pscedf r1pscedg r1pscedh ///
        r1heeye r1hehear r1hefla r1hefrac r1heji r1mmpain ///
        r1cfdatd r1cfdatm r1cfdaty r1cfday r1cflisen r1cflisd)

gen r1hedimbp = 0
replace r1hedimbp = 1 if hedia01==1 | hedia02==1 | hedia03==1 | hedia04==1 | hedia05==1 | ///
                         hedia06==1 | hedia07==1 | hedia08==1 | hedia09==1
gen r1hediman = 0
replace r1hediman = 1 if hedia01==2 | hedia02==2 | hedia03==2 | hedia04==2 | hedia05==2 | ///
                         hedia06==2 | hedia07==2 | hedia08==2 | hedia09==2
gen r1hedimmi = 0
replace r1hedimmi = 1 if hedia01==3 | hedia02==3 | hedia03==3 | hedia04==3 | hedia05==3 | ///
                         hedia06==3 | hedia07==3 | hedia08==3 | hedia09==3
gen r1hedimhf = 0
replace r1hedimhf = 1 if hedia01==4 | hedia02==4 | hedia03==4 | hedia04==4 | hedia05==4 | ///
                         hedia06==4 | hedia07==4 | hedia08==4 | hedia09==4
gen r1hedimar = 0
replace r1hedimar = 1 if hedia01==6 | hedia02==6 | hedia03==6 | hedia04==6 | hedia05==6 | ///
                         hedia06==6 | hedia07==6 | hedia08==6 | hedia09==6
gen r1hedimdi = 0
replace r1hedimdi = 1 if hedia01==7 | hedia02==7 | hedia03==7 | hedia04==7 | hedia05==7 | ///
                         hedia06==7 | hedia07==7 | hedia08==7 | hedia09==7
gen r1hedimst = 0
replace r1hedimst = 1 if hedia01==8 | hedia02==8 | hedia03==8 | hedia04==8 | hedia05==8 | ///
                         hedia06==8 | hedia07==8 | hedia08==8 | hedia09==8

gen r1hediblu = 0
replace r1hediblu = 1 if hedib01==1 | hedib02==1 | hedib03==1 | hedib04==1 | hedib05==1 | ///
                         hedib06==1 | hedib07==1 | hedib08==1 | hedib09==1
gen r1hedibas = 0
replace r1hedibas = 1 if hedib01==2 | hedib02==2 | hedib03==2 | hedib04==2 | hedib05==2 | ///
                         hedib06==2 | hedib07==2 | hedib08==2 | hedib09==2
gen r1hedibar = 0
replace r1hedibar = 1 if hedib01==3 | hedib02==3 | hedib03==3 | hedib04==3 | hedib05==3 | ///
                         hedib06==3 | hedib07==3 | hedib08==3 | hedib09==3
gen r1hedibos = 0
replace r1hedibos = 1 if hedib01==4 | hedib02==4 | hedib03==4 | hedib04==4 | hedib05==4 | ///
                         hedib06==4 | hedib07==4 | hedib08==4 | hedib09==4
gen r1hedibca = 0
replace r1hedibca = 1 if hedib01==5 | hedib02==5 | hedib03==5 | hedib04==5 | hedib05==5 | ///
                         hedib06==5 | hedib07==5 | hedib08==5 | hedib09==5
gen r1hedibpd = 0
replace r1hedibpd = 1 if hedib01==6 | hedib02==6 | hedib03==6 | hedib04==6 | hedib05==6 | ///
                         hedib06==6 | hedib07==6 | hedib08==6 | hedib09==6
gen r1hedibps = 0
replace r1hedibps = 1 if hedib01==7 | hedib02==7 | hedib03==7 | hedib04==7 | hedib05==7 | ///
                         hedib06==7 | hedib07==7 | hedib08==7 | hedib09==7
gen r1hedibad = 0
replace r1hedibad = 1 if hedib01==8 | hedib02==8 | hedib03==8 | hedib04==8 | hedib05==8 | ///
                         hedib06==8 | hedib07==8 | hedib08==8 | hedib09==8
gen r1hedibde = 0
replace r1hedibde = 1 if hedib01==9 | hedib02==9 | hedib03==9 | hedib04==9 | hedib05==9 | ///
                         hedib06==9 | hedib07==9 | hedib08==9 | hedib09==9

keep idauniq r1agey ///
     r1hemobwa r1hemobsi r1hemobch r1hemobcs r1hemobcl r1hemobst ///
     r1hemobre r1hemobpu r1hemobli r1hemobpi ///
     r1headldr r1headlwa r1headlba r1headlea r1headlbe r1headlwc ///
     r1headlma r1headlpr r1headlsh r1headlph r1headlme r1headlho r1headlmo ///
     r1hehelf r1psceda r1pscedb r1pscedc r1pscedd r1pscede r1pscedf r1pscedg r1pscedh ///
     r1hedimbp r1hediman r1hedimmi r1hedimhf r1hedimar r1hedimdi r1hedimst ///
     r1hediblu r1hedibas r1hedibar r1hedibos r1hedibca r1hedibpd r1hedibps r1hedibad r1hedibde ///
     r1heeye r1hehear r1hefla r1hefrac r1heji r1mmpain ///
     r1cfdatd r1cfdatm r1cfdaty r1cfday r1cflisen r1cflisd

save `w1'

use core2.dta, clear

gen r2agey = dhager

gen r2hemobwa = 0
replace r2hemobwa = 1 if heada01==1 | heada02==1 | heada03==1 | heada04==1 | heada05==1 | ///
                         heada06==1 | heada07==1 | heada08==1 | heada09==1 | heada10==1
gen r2hemobsi = 0
replace r2hemobsi = 1 if heada01==2 | heada02==2 | heada03==2 | heada04==2 | heada05==2 | ///
                         heada06==2 | heada07==2 | heada08==2 | heada09==2 | heada10==2
gen r2hemobch = 0
replace r2hemobch = 1 if heada01==3 | heada02==3 | heada03==3 | heada04==3 | heada05==3 | ///
                         heada06==3 | heada07==3 | heada08==3 | heada09==3 | heada10==3
gen r2hemobcs = 0
replace r2hemobcs = 1 if heada01==4 | heada02==4 | heada03==4 | heada04==4 | heada05==4 | ///
                         heada06==4 | heada07==4 | heada08==4 | heada09==4 | heada10==4
gen r2hemobcl = 0
replace r2hemobcl = 1 if heada01==5 | heada02==5 | heada03==5 | heada04==5 | heada05==5 | ///
                         heada06==5 | heada07==5 | heada08==5 | heada09==5 | heada10==5
gen r2hemobst = 0
replace r2hemobst = 1 if heada01==6 | heada02==6 | heada03==6 | heada04==6 | heada05==6 | ///
                         heada06==6 | heada07==6 | heada08==6 | heada09==6 | heada10==6
gen r2hemobre = 0
replace r2hemobre = 1 if heada01==7 | heada02==7 | heada03==7 | heada04==7 | heada05==7 | ///
                         heada06==7 | heada07==7 | heada08==7 | heada09==7 | heada10==7
gen r2hemobpu = 0
replace r2hemobpu = 1 if heada01==8 | heada02==8 | heada03==8 | heada04==8 | heada05==8 | ///
                         heada06==8 | heada07==8 | heada08==8 | heada09==8 | heada10==8
gen r2hemobli = 0
replace r2hemobli = 1 if heada01==9 | heada02==9 | heada03==9 | heada04==9 | heada05==9 | ///
                         heada06==9 | heada07==9 | heada08==9 | heada09==9 | heada10==9
gen r2hemobpi = 0
replace r2hemobpi = 1 if heada01==10 | heada02==10 | heada03==10 | heada04==10 | heada05==10 | ///
                         heada06==10 | heada07==10 | heada08==10 | heada09==10 | heada10==10

gen r2headldr = 0
replace r2headldr = 1 if headb01==1  | headb02==1  | headb03==1  | headb04==1  | headb05==1  | ///
                         headb06==1  | headb07==1  | headb08==1  | headb09==1  | headb10==1  | ///
                         headb11==1  | headb12==1  | headb13==1
gen r2headlwa = 0
replace r2headlwa = 1 if headb01==2  | headb02==2  | headb03==2  | headb04==2  | headb05==2  | ///
                         headb06==2  | headb07==2  | headb08==2  | headb09==2  | headb10==2  | ///
                         headb11==2  | headb12==2  | headb13==2
gen r2headlba = 0
replace r2headlba = 1 if headb01==3  | headb02==3  | headb03==3  | headb04==3  | headb05==3  | ///
                         headb06==3  | headb07==3  | headb08==3  | headb09==3  | headb10==3  | ///
                         headb11==3  | headb12==3  | headb13==3
gen r2headlea = 0
replace r2headlea = 1 if headb01==4  | headb02==4  | headb03==4  | headb04==4  | headb05==4  | ///
                         headb06==4  | headb07==4  | headb08==4  | headb09==4  | headb10==4  | ///
                         headb11==4  | headb12==4  | headb13==4
gen r2headlbe = 0
replace r2headlbe = 1 if headb01==5  | headb02==5  | headb03==5  | headb04==5  | headb05==5  | ///
                         headb06==5  | headb07==5  | headb08==5  | headb09==5  | headb10==5  | ///
                         headb11==5  | headb12==5  | headb13==5
gen r2headlwc = 0
replace r2headlwc = 1 if headb01==6  | headb02==6  | headb03==6  | headb04==6  | headb05==6  | ///
                         headb06==6  | headb07==6  | headb08==6  | headb09==6  | headb10==6  | ///
                         headb11==6  | headb12==6  | headb13==6
gen r2headlma = 0
replace r2headlma = 1 if headb01==7  | headb02==7  | headb03==7  | headb04==7  | headb05==7  | ///
                         headb06==7  | headb07==7  | headb08==7  | headb09==7  | headb10==7  | ///
                         headb11==7  | headb12==7  | headb13==7
gen r2headlpr = 0
replace r2headlpr = 1 if headb01==8  | headb02==8  | headb03==8  | headb04==8  | headb05==8  | ///
                         headb06==8  | headb07==8  | headb08==8  | headb09==8  | headb10==8  | ///
                         headb11==8  | headb12==8  | headb13==8
gen r2headlsh = 0
replace r2headlsh = 1 if headb01==9  | headb02==9  | headb03==9  | headb04==9  | headb05==9  | ///
                         headb06==9  | headb07==9  | headb08==9  | headb09==9  | headb10==9  | ///
                         headb11==9  | headb12==9  | headb13==9
gen r2headlph = 0
replace r2headlph = 1 if headb01==10 | headb02==10 | headb03==10 | headb04==10 | headb05==10 | ///
                         headb06==10 | headb07==10 | headb08==10 | headb09==10 | headb10==10 | ///
                         headb11==10 | headb12==10 | headb13==10
gen r2headlme = 0
replace r2headlme = 1 if headb01==11 | headb02==11 | headb03==11 | headb04==11 | headb05==11 | ///
                         headb06==11 | headb07==11 | headb08==11 | headb09==11 | headb10==11 | ///
                         headb11==11 | headb12==11 | headb13==11
gen r2headlho = 0
replace r2headlho = 1 if headb01==12 | headb02==12 | headb03==12 | headb04==12 | headb05==12 | ///
                         headb06==12 | headb07==12 | headb08==12 | headb09==12 | headb10==12 | ///
                         headb11==12 | headb12==12 | headb13==12
gen r2headlmo = 0
replace r2headlmo = 1 if headb01==13 | headb02==13 | headb03==13 | headb04==13 | headb05==13 | ///
                         headb06==13 | headb07==13 | headb08==13 | headb09==13 | headb10==13 | ///
                         headb11==13 | headb12==13 | headb13==13

rename (Hehelf PScedA PScedB PScedC PScedD PScedE PScedF PScedG PScedH ///
        Heeye Hehear HeFla HeFrac HeJi MmPain ///
        CfDatD CfDatM CfDatY CfDay CfLisEn CfLisD) ///
       (r2hehelf r2psceda r2pscedb r2pscedc r2pscedd r2pscede r2pscedf r2pscedg r2pscedh ///
        r2heeye r2hehear r2hefla r2hefrac r2heji r2mmpain ///
        r2cfdatd r2cfdatm r2cfdaty r2cfday r2cflisen r2cflisd)

gen r2hedimbp = 0
replace r2hedimbp = 1 if hedia01==1 | hedia02==1 | hedia03==1 | hedia04==1 | hedia05==1 | ///
                         hedia06==1 | hedia07==1 | hedia08==1 | hedia09==1
gen r2hediman = 0
replace r2hediman = 1 if hedia01==2 | hedia02==2 | hedia03==2 | hedia04==2 | hedia05==2 | ///
                         hedia06==2 | hedia07==2 | hedia08==2 | hedia09==2
gen r2hedimmi = 0
replace r2hedimmi = 1 if hedia01==3 | hedia02==3 | hedia03==3 | hedia04==3 | hedia05==3 | ///
                         hedia06==3 | hedia07==3 | hedia08==3 | hedia09==3
gen r2hedimhf = 0
replace r2hedimhf = 1 if hedia01==4 | hedia02==4 | hedia03==4 | hedia04==4 | hedia05==4 | ///
                         hedia06==4 | hedia07==4 | hedia08==4 | hedia09==4
gen r2hedimar = 0
replace r2hedimar = 1 if hedia01==6 | hedia02==6 | hedia03==6 | hedia04==6 | hedia05==6 | ///
                         hedia06==6 | hedia07==6 | hedia08==6 | hedia09==6
gen r2hedimdi = 0
replace r2hedimdi = 1 if hedia01==7 | hedia02==7 | hedia03==7 | hedia04==7 | hedia05==7 | ///
                         hedia06==7 | hedia07==7 | hedia08==7 | hedia09==7
gen r2hedimst = 0
replace r2hedimst = 1 if hedia01==8 | hedia02==8 | hedia03==8 | hedia04==8 | hedia05==8 | ///
                         hedia06==8 | hedia07==8 | hedia08==8 | hedia09==8

rename (hediac1 HeDiaC2 HeDiaC3 HeDiaC4 HeDiaC6 HeDiaC7 HeDiaC8) ///
       (r2hedawbp r2hedawan r2hedawmi r2hedawhf r2hedawar r2hedawdi r2hedawst)

gen r2hediblu = 0
replace r2hediblu = 1 if hedib01==1 | hedib02==1 | hedib03==1 | hedib04==1
gen r2hedibas = 0
replace r2hedibas = 1 if hedib01==2 | hedib02==2 | hedib03==2 | hedib04==2
gen r2hedibar = 0
replace r2hedibar = 1 if hedib01==3 | hedib02==3 | hedib03==3 | hedib04==3
gen r2hedibos = 0
replace r2hedibos = 1 if hedib01==4 | hedib02==4 | hedib03==4 | hedib04==4
gen r2hedibca = 0
replace r2hedibca = 1 if hedib01==5 | hedib02==5 | hedib03==5 | hedib04==5
gen r2hedibpd = 0
replace r2hedibpd = 1 if hedib01==6 | hedib02==6 | hedib03==6 | hedib04==6
gen r2hedibps = 0
replace r2hedibps = 1 if hedib01==7 | hedib02==7 | hedib03==7 | hedib04==7
gen r2hedibad = 0
replace r2hedibad = 1 if hedib01==8 | hedib02==8 | hedib03==8 | hedib04==8
gen r2hedibde = 0
replace r2hedibde = 1 if hedib01==9 | hedib02==9 | hedib03==9 | hedib04==9

rename (hedibw1 HeDibW2 HeDibW3 HeDibW4 HeDibW5 HeDibW6 HeDibW7 HeDibW8 HeDibW9) ///
       (r2hedbwlu r2hedbwas r2hedbwar r2hedbwos r2hedbwca r2hedbwpd r2hedbwps r2hedbwad r2hedbwde)

keep idauniq r2agey ///
     r2hemobwa r2hemobsi r2hemobch r2hemobcs r2hemobcl r2hemobst ///
     r2hemobre r2hemobpu r2hemobli r2hemobpi ///
     r2headldr r2headlwa r2headlba r2headlea r2headlbe r2headlwc ///
     r2headlma r2headlpr r2headlsh r2headlph r2headlme r2headlho r2headlmo ///
     r2hehelf r2psceda r2pscedb r2pscedc r2pscedd r2pscede r2pscedf r2pscedg r2pscedh ///
     r2hedimbp r2hediman r2hedimmi r2hedimhf r2hedimar r2hedimdi r2hedimst ///
     r2hedawbp r2hedawan r2hedawmi r2hedawhf r2hedawar r2hedawdi r2hedawst ///
     r2hediblu r2hedibas r2hedibar r2hedibos r2hedibca r2hedibpd r2hedibps r2hedibad r2hedibde ///
     r2hedbwlu r2hedbwas r2hedbwar r2hedbwos r2hedbwca r2hedbwpd r2hedbwps r2hedbwad r2hedbwde ///
     r2heeye r2hehear r2hefla r2hefrac r2heji r2mmpain ///
     r2cfdatd r2cfdatm r2cfdaty r2cfday r2cflisen r2cflisd

save `w2'

use core3.dta, clear

recode indager (-7=99), gen(r3agey)

rename (hemobwa hemobsi hemobch hemobcs hemobcl hemobst hemobre hemobpu hemobli hemobpi ///
        headldr headlwa headlba headlea headlbe headlwc ///
        headlma headlpr headlsh headlph headlme headlho headlmo ///
        hegenh psceda pscedb pscedc pscedd pscede pscedf pscedg pscedh ///
        dhedimbp dhediman dhedimmi dhedimhf dhedimar dhedimdi dhedimst ///
        hedawbp  hedawan  hedawmi  hedawhf  hedawar  hedawdi  hedawst ///
        dhediblu dhedibas dhedibar dhedibos dhedibca dhedibpd dhedibps dhedibad dhedibde ///
        hedbwlu  hedbwas  hedbwar  hedbwos  hedbwca  hedbwpd  hedbwps  hedbwad  hedbwde ///
        heeye hehear hefla hefrac heji mmpain cfdatd cfdatm cfdaty cfday cflisen cflisd) ///
       (r3hemobwa r3hemobsi r3hemobch r3hemobcs r3hemobcl r3hemobst r3hemobre r3hemobpu r3hemobli r3hemobpi ///
        r3headldr r3headlwa r3headlba r3headlea r3headlbe r3headlwc ///
        r3headlma r3headlpr r3headlsh r3headlph r3headlme r3headlho r3headlmo ///
        r3hehelf  r3psceda r3pscedb r3pscedc r3pscedd r3pscede r3pscedf r3pscedg r3pscedh ///
        r3hedimbp r3hediman r3hedimmi r3hedimhf r3hedimar r3hedimdi r3hedimst ///
        r3hedawbp r3hedawan r3hedawmi r3hedawhf r3hedawar r3hedawdi r3hedawst ///
        r3hediblu r3hedibas r3hedibar r3hedibos r3hedibca r3hedibpd r3hedibps r3hedibad r3hedibde ///
        r3hedbwlu r3hedbwas r3hedbwar r3hedbwos r3hedbwca r3hedbwpd r3hedbwps r3hedbwad r3hedbwde ///
        r3heeye r3hehear r3hefla r3hefrac r3heji r3mmpain r3cfdatd r3cfdatm r3cfdaty r3cfday r3cflisen r3cflisd)

keep idauniq r3agey ///
     r3hemobwa r3hemobsi r3hemobch r3hemobcs r3hemobcl r3hemobst ///
     r3hemobre r3hemobpu r3hemobli r3hemobpi ///
     r3headldr r3headlwa r3headlba r3headlea r3headlbe r3headlwc ///
     r3headlma r3headlpr r3headlsh r3headlph r3headlme r3headlho r3headlmo ///
     r3hehelf r3psceda r3pscedb r3pscedc r3pscedd r3pscede r3pscedf r3pscedg r3pscedh ///
     r3hedimbp r3hediman r3hedimmi r3hedimhf r3hedimar r3hedimdi r3hedimst ///
     r3hedawbp r3hedawan r3hedawmi r3hedawhf r3hedawar r3hedawdi r3hedawst ///
     r3hediblu r3hedibas r3hedibar r3hedibos r3hedibca r3hedibpd r3hedibps r3hedibad r3hedibde ///
     r3hedbwlu r3hedbwas r3hedbwar r3hedbwos r3hedbwca r3hedbwpd r3hedbwps r3hedbwad r3hedbwde ///
     r3heeye r3hehear r3hefla r3hefrac r3heji r3mmpain ///
     r3cfdatd r3cfdatm r3cfdaty r3cfday r3cflisen r3cflisd

save `w3'

foreach wn of numlist 4 5 {
  use core`wn'.dta, clear
  recode indager (-7=99), gen(r`wn'agey)

  rename (hemobwa hemobsi hemobch hemobcs hemobcl hemobst hemobre hemobpu hemobli hemobpi ///
          headldr headlwa headlba headlea headlbe headlwc ///
          headlma headlpr headlsh headlte headlme headlho headlmo ///
          hehelf psceda pscedb pscedc pscedd pscede pscedf pscedg pscedh ///
          hedimbp hediman hedimmi hedimhf hedimar hedimdi hedimst ///
          hedawbp hedawan hedawmi hedawhf hedawar hedawdi hedawst ///
          hediblu hedibas hedibar hedibos hedibca hedibpd hedibps hedibad hedibde ///
          hedbwlu hedbwas hedbwar hedbwos hedbwca hedbwpd hedbwps hedbwad hedbwde ///
          heeye hehear hefla hefrac heji mmpain cfdatd cfdatm cfdaty cfday cflisen cflisd) ///
         (r`wn'hemobwa r`wn'hemobsi r`wn'hemobch r`wn'hemobcs r`wn'hemobcl r`wn'hemobst r`wn'hemobre r`wn'hemobpu r`wn'hemobli r`wn'hemobpi ///
          r`wn'headldr r`wn'headlwa r`wn'headlba r`wn'headlea r`wn'headlbe r`wn'headlwc ///
          r`wn'headlma r`wn'headlpr r`wn'headlsh r`wn'headlph r`wn'headlme r`wn'headlho r`wn'headlmo ///
          r`wn'hehelf r`wn'psceda r`wn'pscedb r`wn'pscedc r`wn'pscedd r`wn'pscede r`wn'pscedf r`wn'pscedg r`wn'pscedh ///
          r`wn'hedimbp r`wn'hediman r`wn'hedimmi r`wn'hedimhf r`wn'hedimar r`wn'hedimdi r`wn'hedimst ///
          r`wn'hedawbp r`wn'hedawan r`wn'hedawmi r`wn'hedawhf r`wn'hedawar r`wn'hedawdi r`wn'hedawst ///
          r`wn'hediblu r`wn'hedibas r`wn'hedibar r`wn'hedibos r`wn'hedibca r`wn'hedibpd r`wn'hedibps r`wn'hedibad r`wn'hedibde ///
          r`wn'hedbwlu r`wn'hedbwas r`wn'hedbwar r`wn'hedbwos r`wn'hedbwca r`wn'hedbwpd r`wn'hedbwps r`wn'hedbwad r`wn'hedbwde ///
          r`wn'heeye r`wn'hehear r`wn'hefla r`wn'hefrac r`wn'heji r`wn'mmpain ///
          r`wn'cfdatd r`wn'cfdatm r`wn'cfdaty r`wn'cfday r`wn'cflisen r`wn'cflisd)

  keep idauniq r`wn'agey ///
       r`wn'hemobwa r`wn'hemobsi r`wn'hemobch r`wn'hemobcs r`wn'hemobcl r`wn'hemobst ///
       r`wn'hemobre r`wn'hemobpu r`wn'hemobli r`wn'hemobpi ///
       r`wn'headldr r`wn'headlwa r`wn'headlba r`wn'headlea r`wn'headlbe r`wn'headlwc ///
       r`wn'headlma r`wn'headlpr r`wn'headlsh r`wn'headlph r`wn'headlme r`wn'headlho r`wn'headlmo ///
       r`wn'hehelf r`wn'psceda r`wn'pscedb r`wn'pscedc r`wn'pscedd r`wn'pscede r`wn'pscedf r`wn'pscedg r`wn'pscedh ///
       r`wn'hedimbp r`wn'hediman r`wn'hedimmi r`wn'hedimhf r`wn'hedimar r`wn'hedimdi r`wn'hedimst ///
       r`wn'hedawbp r`wn'hedawan r`wn'hedawmi r`wn'hedawhf r`wn'hedawar r`wn'hedawdi r`wn'hedawst ///
       r`wn'hediblu r`wn'hedibas r`wn'hedibar r`wn'hedibos r`wn'hedibca r`wn'hedibpd r`wn'hedibps r`wn'hedibad r`wn'hedibde ///
       r`wn'hedbwlu r`wn'hedbwas r`wn'hedbwar r`wn'hedbwos r`wn'hedbwca r`wn'hedbwpd r`wn'hedbwps r`wn'hedbwad r`wn'hedbwde ///
       r`wn'heeye r`wn'hehear r`wn'hefla r`wn'hefrac r`wn'heji r`wn'mmpain ///
       r`wn'cfdatd r`wn'cfdatm r`wn'cfdaty r`wn'cfday r`wn'cflisen r`wn'cflisd

  save `w`wn''
}

foreach wn of numlist 6 7 8 9 {
  use core`wn'.dta, clear
  rename *, lower
  recode indager (-7=99), gen(r`wn'agey)

  rename (hemobwa hemobsi hemobch hemobcs hemobcl hemobst hemobre hemobpu hemobli hemobpi ///
          headldr headlwa headlba headlea headlbe headlwc ///
          headlma headlpr headlsh headlph headlme headlho headlmo ///
          hehelf psceda pscedb pscedc pscedd pscede pscedf pscedg pscedh ///
          hedimbp hediman hedimmi hedimhf hedimar hedimdi hedimst ///
          hedawbp hedawan hedawmi hedawhf hedawar hedawdi hedawst ///
          hediblu hedibas hedibar hedibos hedibca hedibpd hedibps hedibad hedibde ///
          hedbwlu hedbwas hedbwar hedbwos hedbwca hedbwpd hedbwps hedbwad hedbwde ///
          heeye hehear hefla hefrac heji mmpain cfdatd cfdatm cfdaty cfday cflisen cflisd) ///
         (r`wn'hemobwa r`wn'hemobsi r`wn'hemobch r`wn'hemobcs r`wn'hemobcl r`wn'hemobst r`wn'hemobre r`wn'hemobpu r`wn'hemobli r`wn'hemobpi ///
          r`wn'headldr r`wn'headlwa r`wn'headlba r`wn'headlea r`wn'headlbe r`wn'headlwc ///
          r`wn'headlma r`wn'headlpr r`wn'headlsh r`wn'headlph r`wn'headlme r`wn'headlho r`wn'headlmo ///
          r`wn'hehelf r`wn'psceda r`wn'pscedb r`wn'pscedc r`wn'pscedd r`wn'pscede r`wn'pscedf r`wn'pscedg r`wn'pscedh ///
          r`wn'hedimbp r`wn'hediman r`wn'hedimmi r`wn'hedimhf r`wn'hedimar r`wn'hedimdi r`wn'hedimst ///
          r`wn'hedawbp r`wn'hedawan r`wn'hedawmi r`wn'hedawhf r`wn'hedawar r`wn'hedawdi r`wn'hedawst ///
          r`wn'hediblu r`wn'hedibas r`wn'hedibar r`wn'hedibos r`wn'hedibca r`wn'hedibpd r`wn'hedibps r`wn'hedibad r`wn'hedibde ///
          r`wn'hedbwlu r`wn'hedbwas r`wn'hedbwar r`wn'hedbwos r`wn'hedbwca r`wn'hedbwpd r`wn'hedbwps r`wn'hedbwad r`wn'hedbwde ///
          r`wn'heeye r`wn'hehear r`wn'hefla r`wn'hefrac r`wn'heji r`wn'mmpain ///
          r`wn'cfdatd r`wn'cfdatm r`wn'cfdaty r`wn'cfday r`wn'cflisen r`wn'cflisd)

  keep idauniq r`wn'agey ///
       r`wn'hemobwa r`wn'hemobsi r`wn'hemobch r`wn'hemobcs r`wn'hemobcl r`wn'hemobst ///
       r`wn'hemobre r`wn'hemobpu r`wn'hemobli r`wn'hemobpi ///
       r`wn'headldr r`wn'headlwa r`wn'headlba r`wn'headlea r`wn'headlbe r`wn'headlwc ///
       r`wn'headlma r`wn'headlpr r`wn'headlsh r`wn'headlph r`wn'headlme r`wn'headlho r`wn'headlmo ///
       r`wn'hehelf r`wn'psceda r`wn'pscedb r`wn'pscedc r`wn'pscedd r`wn'pscede r`wn'pscedf r`wn'pscedg r`wn'pscedh ///
       r`wn'hedimbp r`wn'hediman r`wn'hedimmi r`wn'hedimhf r`wn'hedimar r`wn'hedimdi r`wn'hedimst ///
       r`wn'hedawbp r`wn'hedawan r`wn'hedawmi r`wn'hedawhf r`wn'hedawar r`wn'hedawdi r`wn'hedawst ///
       r`wn'hediblu r`wn'hedibas r`wn'hedibar r`wn'hedibos r`wn'hedibca r`wn'hedibpd r`wn'hedibps r`wn'hedibad r`wn'hedibde ///
       r`wn'hedbwlu r`wn'hedbwas r`wn'hedbwar r`wn'hedbwos r`wn'hedbwca r`wn'hedbwpd r`wn'hedbwps r`wn'hedbwad r`wn'hedbwde ///
       r`wn'heeye r`wn'hehear r`wn'hefla r`wn'hefrac r`wn'heji r`wn'mmpain ///
       r`wn'cfdatd r`wn'cfdatm r`wn'cfdaty r`wn'cfday r`wn'cflisen r`wn'cflisd

  save `w`wn''
}

use core10.dta, clear
rename *, lower

recode indager (-7=99), gen(r10agey)

rename (hemobwa hemobsi hemobch hemobcs hemobcl hemobst hemobre hemobpu hemobli hemobpi ///
        headldr headlwa headlba headlea headlbe headlwc ///
        headlma headlpr headlsh headlph headlme headlho headlmo ///
        hehelf psceda pscedb pscedc pscedd pscede pscedf pscedg pscedh ///
        hehavebp hehavean           hehavehf hehaveah hehavedi ///
        hehavecl hehaveas hehavear hehaveos hehaveca hehavepd hehaveps hehavead hehavedm ///
        heevermi heeverst ///
        heeye hehear hefla hefrac heji mmpain cfdatd cfdatm cfdaty cfday cflisen cflisd) ///
       (r10hemobwa r10hemobsi r10hemobch r10hemobcs r10hemobcl r10hemobst r10hemobre r10hemobpu r10hemobli r10hemobpi ///
        r10headldr r10headlwa r10headlba r10headlea r10headlbe r10headlwc ///
        r10headlma r10headlpr r10headlsh r10headlph r10headlme r10headlho r10headlmo ///
        r10hehelf r10psceda r10pscedb r10pscedc r10pscedd r10pscede r10pscedf r10pscedg r10pscedh ///
        r10hehavebp r10hehavean             r10hehavehf r10hehaveah r10hehavedi ///
        r10hehavecl r10hehaveas r10hehavear r10hehaveos r10hehaveca r10hehavepd r10hehaveps r10hehavead r10hehavedm ///
        r10heevermi r10heeverst ///
        r10heeye r10hehear r10hefla r10hefrac r10heji r10mmpain r10cfdatd r10cfdatm r10cfdaty r10cfday r10cflisen r10cflisd)

keep idauniq r10agey ///
     r10hemobwa r10hemobsi r10hemobch r10hemobcs r10hemobcl r10hemobst ///
     r10hemobre r10hemobpu r10hemobli r10hemobpi ///
     r10headldr r10headlwa r10headlba r10headlea r10headlbe r10headlwc ///
     r10headlma r10headlpr r10headlsh r10headlph r10headlme r10headlho r10headlmo ///
     r10hehelf r10psceda r10pscedb r10pscedc r10pscedd r10pscede r10pscedf r10pscedg r10pscedh ///
     r10hehavebp r10hehavean r10hehavehf r10hehaveah r10hehavedi ///
     r10hehavecl r10hehaveas r10hehavear r10hehaveos r10hehaveca r10hehavepd r10hehaveps r10hehavead r10hehavedm ///
     r10heevermi r10heeverst ///
     r10heeye r10hehear r10hefla r10hefrac r10heji r10mmpain ///
     r10cfdatd r10cfdatm r10cfdaty r10cfday r10cflisen r10cflisd

save `w10'

use core11.dta, clear
rename *, lower

recode indager (-7=99), gen(r11agey)

rename (hemobwa hemobsi hemobch hemobcs hemobcl hemobst hemobre hemobpu hemobli hemobpi ///
        headldr headlwa headlba headlea headlbe headlwc ///
        headlma headlpr headlsh headlph headlme headlho headlmo ///
        hehelf psceda pscedb pscedc pscedd pscede pscedf pscedg pscedh ///
        heeye hehear hefla hefrac heji mmpain cfdatd cfdatm cfdaty cfday cflisen cflisd) ///
       (r11hemobwa r11hemobsi r11hemobch r11hemobcs r11hemobcl r11hemobst r11hemobre r11hemobpu r11hemobli r11hemobpi ///
        r11headldr r11headlwa r11headlba r11headlea r11headlbe r11headlwc ///
        r11headlma r11headlpr r11headlsh r11headlph r11headlme r11headlho r11headlmo ///
        r11hehelf r11psceda r11pscedb r11pscedc r11pscedd r11pscede r11pscedf r11pscedg r11pscedh ///
        r11heeye r11hehear r11hefla r11hefrac r11heji r11mmpain ///
        r11cfdatd r11cfdatm r11cfdaty r11cfday r11cflisen r11cflisd)

gen r11bp = 0
replace r11bp = 1 if hehavebp==1 | hehavebp==2
replace r11bp = 1 if hediia1==1 | hediacbp==1
replace r11bp = . if hehavebp==-8 & hediia1!=1 & hediacbp!=1

gen r11an = 0
replace r11an = 1 if hehavean==1 | hehavean==2
replace r11an = 1 if hediia2==1 | hediacan==1
replace r11an = . if hehavean==-8 & hediia2!=1 & hediacan!=1

gen r11mi = 0
replace r11mi = 1 if hediia3==1 | hediacmi==1

gen r11hf = 0
replace r11hf = 1 if hehavehf==1 | hehavehf==2
replace r11hf = 1 if hediia4==1 | hediachf==1
replace r11hf = . if hehavehf==-8 & hediia4!=1 & hediachf!=1

gen r11ah = 0
replace r11ah = 1 if hehaveah==1 | hehaveah==2
replace r11ah = 1 if hediia6==1 | hediacah==1
replace r11ah = . if hehaveah==-8 & hediia6!=1 & hediacah!=1

gen r11st = 0
replace r11st = 1 if hediia7==1 | hediacst==1

gen r11di = 0
replace r11di = 1 if hehavedi==1 | hehavedi==2
replace r11di = 1 if hedids12==1 | hediaddi==1
replace r11di = . if hehavedi==-8 & hedids12!=1 & hediaddi!=1

gen r11cl = 0
replace r11cl = 1 if hehavecl==1 | hehavecl==2
replace r11cl = 1 if hedids1==1 | hediadcl==1
replace r11cl = . if hehavecl==-8 & hedids1!=1 & hediadcl!=1

gen r11as = 0
replace r11as = 1 if hehaveas==1 | hehaveas==2
replace r11as = 1 if hedids2==1 | hediadas==1
replace r11as = . if hehaveas==-8 & hedids2!=1 & hediadas!=1

gen r11ar = 0
replace r11ar = 1 if hehavear==1 | hehavear==2
replace r11ar = 1 if hedids3==1 | hediadar==1
replace r11ar = . if hehavear==-8 & hedids3!=1 & hediadar!=1

gen r11os = 0
replace r11os = 1 if hehaveos==1 | hehaveos==2
replace r11os = 1 if hedids4==1 | hediados==1
replace r11os = . if hehaveos==-8 & hedids4!=1 & hediados!=1

gen r11ca = 0
replace r11ca = 1 if hehaveca==1 | hehaveca==2
replace r11ca = 1 if hedids5==1 | hediadca==1
replace r11ca = . if hehaveca==-8 & hedids5!=1 & hediadca!=1

gen r11pd = 0
replace r11pd = 1 if hehavepd==1 | hehavepd==2
replace r11pd = 1 if hedids6==1 | hediadpd==1
replace r11pd = . if hehavepd==-8 & hedids6!=1 & hediadpd!=1

gen r11ps = 0
replace r11ps = 1 if hehaveps==1 | hehaveps==2
replace r11ps = 1 if hedids7==1 | hediadps==1
replace r11ps = . if hehaveps==-8 & hedids7!=1 & hediadps!=1

gen r11ad = 0
replace r11ad = 1 if hehavead==1 | hehavead==2
replace r11ad = 1 if hedids8==1 | hediadad==1
replace r11ad = . if hehavead==-8 & hedids8!=1 & hediadad!=1

gen r11dm = 0
replace r11dm = 1 if hehavedm==1 | hehavedm==2
replace r11dm = 1 if hedids9==1 | hediaddm==1
replace r11dm = . if hehavedm==-8 & hedids9!=1 & hediaddm!=1

keep idauniq r11agey ///
     r11hemobwa r11hemobsi r11hemobch r11hemobcs r11hemobcl r11hemobst ///
     r11hemobre r11hemobpu r11hemobli r11hemobpi ///
     r11headldr r11headlwa r11headlba r11headlea r11headlbe r11headlwc ///
     r11headlma r11headlpr r11headlsh r11headlph r11headlme r11headlho r11headlmo ///
     r11hehelf r11psceda r11pscedb r11pscedc r11pscedd r11pscede r11pscedf r11pscedg r11pscedh ///
     r11bp r11an r11mi r11hf r11ah r11st r11di ///
     r11cl r11as r11ar r11os r11ca r11pd r11ps r11ad r11dm ///
     r11heeye r11hehear r11hefla r11hefrac r11heji r11mmpain ///
     r11cfdatd r11cfdatm r11cfdaty r11cfday r11cflisen r11cflisd

save `w11'

use `w1', clear
sort idauniq
merge 1:1 idauniq using `w2',  nogenerate
merge 1:1 idauniq using `w3',  nogenerate
merge 1:1 idauniq using `w4',  nogenerate
merge 1:1 idauniq using `w5',  nogenerate
merge 1:1 idauniq using `w6',  nogenerate
merge 1:1 idauniq using `w7',  nogenerate
merge 1:1 idauniq using `w8',  nogenerate
merge 1:1 idauniq using `w9',  nogenerate
merge 1:1 idauniq using `w10', nogenerate
merge 1:1 idauniq using `w11', nogenerate

save `merged'

replace r2hedimbp = 1 if (r2hedimbp<0 | r2hedimbp==0 | r2hedimbp==.) & r2hedawbp==1
replace r2hediman = 1 if (r2hediman<0 | r2hediman==0 | r2hediman==.) & r2hedawan==1
replace r2hedimmi = 1 if (r2hedimmi<0 | r2hedimmi==0 | r2hedimmi==.) & r2hedawmi==1
replace r2hedimhf = 1 if (r2hedimhf<0 | r2hedimhf==0 | r2hedimhf==.) & r2hedawhf==1
replace r2hedimar = 1 if (r2hedimar<0 | r2hedimar==0 | r2hedimar==.) & r2hedawar==1
replace r2hedimdi = 1 if (r2hedimdi<0 | r2hedimdi==0 | r2hedimdi==.) & r2hedawdi==1
replace r2hedimst = 1 if (r2hedimst<0 | r2hedimst==0 | r2hedimst==.) & r2hedawst==1

replace r2hediblu = 1 if (r2hediblu<0 | r2hediblu==0 | r2hediblu==.) & r2hedbwlu==1
replace r2hedibas = 1 if (r2hedibas<0 | r2hedibas==0 | r2hedibas==.) & r2hedbwas==2
replace r2hedibar = 1 if (r2hedibar<0 | r2hedibar==0 | r2hedibar==.) & r2hedbwar==3
replace r2hedibos = 1 if (r2hedibos<0 | r2hedibos==0 | r2hedibos==.) & r2hedbwos==4
replace r2hedibca = 1 if (r2hedibca<0 | r2hedibca==0 | r2hedibca==.) & r2hedbwca==5
replace r2hedibpd = 1 if (r2hedibpd<0 | r2hedibpd==0 | r2hedibpd==.) & r2hedbwpd==6
replace r2hedibps = 1 if (r2hedibps<0 | r2hedibps==0 | r2hedibps==.) & r2hedbwps==7
replace r2hedibad = 1 if (r2hedibad<0 | r2hedibad==0 | r2hedibad==.) & r2hedbwad==8
replace r2hedibde = 1 if (r2hedibde<0 | r2hedibde==0 | r2hedibde==.) & r2hedbwde==9

foreach wn of numlist 3 4 5 6 7 8 9 {
  replace r`wn'hedimbp = 1 if (r`wn'hedimbp<0 | r`wn'hedimbp==0 | r`wn'hedimbp==.) & r`wn'hedawbp==1
  replace r`wn'hediman = 1 if (r`wn'hediman<0 | r`wn'hediman==0 | r`wn'hediman==.) & r`wn'hedawan==2
  replace r`wn'hedimmi = 1 if (r`wn'hedimmi<0 | r`wn'hedimmi==0 | r`wn'hedimmi==.) & r`wn'hedawmi==3
  replace r`wn'hedimhf = 1 if (r`wn'hedimhf<0 | r`wn'hedimhf==0 | r`wn'hedimhf==.) & r`wn'hedawhf==4
  replace r`wn'hedimar = 1 if (r`wn'hedimar<0 | r`wn'hedimar==0 | r`wn'hedimar==.) & r`wn'hedawar==6
  replace r`wn'hedimdi = 1 if (r`wn'hedimdi<0 | r`wn'hedimdi==0 | r`wn'hedimdi==.) & r`wn'hedawdi==7
  replace r`wn'hedimst = 1 if (r`wn'hedimst<0 | r`wn'hedimst==0 | r`wn'hedimst==.) & r`wn'hedawst==8
  replace r`wn'hediblu = 1 if (r`wn'hediblu<0 | r`wn'hediblu==0 | r`wn'hediblu==.) & r`wn'hedbwlu==1
  replace r`wn'hedibas = 1 if (r`wn'hedibas<0 | r`wn'hedibas==0 | r`wn'hedibas==.) & r`wn'hedbwas==2
  replace r`wn'hedibar = 1 if (r`wn'hedibar<0 | r`wn'hedibar==0 | r`wn'hedibar==.) & r`wn'hedbwar==3
  replace r`wn'hedibos = 1 if (r`wn'hedibos<0 | r`wn'hedibos==0 | r`wn'hedibos==.) & r`wn'hedbwos==4
  replace r`wn'hedibca = 1 if (r`wn'hedibca<0 | r`wn'hedibca==0 | r`wn'hedibca==.) & r`wn'hedbwca==5
  replace r`wn'hedibpd = 1 if (r`wn'hedibpd<0 | r`wn'hedibpd==0 | r`wn'hedibpd==.) & r`wn'hedbwpd==6
  replace r`wn'hedibps = 1 if (r`wn'hedibps<0 | r`wn'hedibps==0 | r`wn'hedibps==.) & r`wn'hedbwps==7
  replace r`wn'hedibad = 1 if (r`wn'hedibad<0 | r`wn'hedibad==0 | r`wn'hedibad==.) & r`wn'hedbwad==8
  replace r`wn'hedibde = 1 if (r`wn'hedibde<0 | r`wn'hedibde==0 | r`wn'hedibde==.) & r`wn'hedbwde==9
}

drop r*hedawbp r*hedawan r*hedawmi r*hedawhf r*hedawar r*hedawdi r*hedawst
drop r*hedbwlu r*hedbwas r*hedbwar r*hedbwos r*hedbwca r*hedbwpd r*hedbwps r*hedbwad r*hedbwde

save `merged', replace

foreach wn of numlist 1/9 {
  rename r`wn'hedimbp r`wn'bp
  rename r`wn'hediman r`wn'an
  rename r`wn'hedimmi r`wn'mi
  rename r`wn'hedimhf r`wn'hf
  rename r`wn'hedimar r`wn'ah
  rename r`wn'hedimdi r`wn'di
  rename r`wn'hedimst r`wn'st
  rename r`wn'hediblu r`wn'cl
  rename r`wn'hedibas r`wn'as
  rename r`wn'hedibar r`wn'ar
  rename r`wn'hedibos r`wn'os
  rename r`wn'hedibca r`wn'ca
  rename r`wn'hedibpd r`wn'pd
  rename r`wn'hedibps r`wn'ps
  rename r`wn'hedibad r`wn'ad
  rename r`wn'hedibde r`wn'dm
}

rename r10hehavebp r10bp
rename r10hehavean r10an
rename r10heevermi r10mi
rename r10hehavehf r10hf
rename r10hehaveah r10ah
rename r10hehavedi r10di
rename r10heeverst r10st
rename r10hehavecl r10cl
rename r10hehaveas r10as
rename r10hehavear r10ar
rename r10hehaveos r10os
rename r10hehaveca r10ca
rename r10hehavepd r10pd
rename r10hehaveps r10ps
rename r10hehavead r10ad
rename r10hehavedm r10dm

save `merged', replace

foreach cond in bp an mi hf ah di st cl as ar os ca pd ps ad dm {
  replace r2`cond' = 1 if (r2`cond'<=0 | r2`cond'==.) & r1`cond'==1
}
foreach cond in bp an mi hf ah di st cl as ar os ca pd ps ad dm {
  replace r3`cond' = 1 if (r3`cond'<=0 | r3`cond'==.) & r2`cond'==1
}
foreach wn of numlist 4/9 {
  local prev = `wn' - 1
  foreach cond in bp an mi hf ah di st cl as ar os ca pd ps ad dm {
    replace r`wn'`cond' = 1 if (r`wn'`cond'<=0 | r`wn'`cond'==.) & r`prev'`cond'==1
  }
}

foreach cond in bp an hf ah di cl as ar os ca pd ps ad dm {
  replace r10`cond' = 1 if r10`cond'==2
  replace r10`cond' = 0 if r10`cond'==-1 | r10`cond'==3
  replace r10`cond' = . if r10`cond'==-8
}
foreach cond in mi st {
  replace r10`cond' = 0 if r10`cond'==2
  replace r10`cond' = . if r10`cond'<0
}

foreach wn of numlist 1/11 {
  rename r`wn'agey    age`wn'
  rename r`wn'hemobwa hemobwa`wn'
  rename r`wn'hemobsi hemobsi`wn'
  rename r`wn'hemobch hemobch`wn'
  rename r`wn'hemobcs hemobcs`wn'
  rename r`wn'hemobcl hemobcl`wn'
  rename r`wn'hemobst hemobst`wn'
  rename r`wn'hemobre hemobre`wn'
  rename r`wn'hemobpu hemobpu`wn'
  rename r`wn'hemobli hemobli`wn'
  rename r`wn'hemobpi hemobpi`wn'
  rename r`wn'headldr headldr`wn'
  rename r`wn'headlwa headlwa`wn'
  rename r`wn'headlba headlba`wn'
  rename r`wn'headlea headlea`wn'
  rename r`wn'headlbe headlbe`wn'
  rename r`wn'headlwc headlwc`wn'
  rename r`wn'headlma headlma`wn'
  rename r`wn'headlpr headlpr`wn'
  rename r`wn'headlsh headlsh`wn'
  rename r`wn'headlph headlph`wn'
  rename r`wn'headlme headlme`wn'
  rename r`wn'headlho headlho`wn'
  rename r`wn'headlmo headlmo`wn'
  rename r`wn'hehelf  hehelf`wn'
  rename r`wn'psceda  psceda`wn'
  rename r`wn'pscedb  pscedb`wn'
  rename r`wn'pscedc  pscedc`wn'
  rename r`wn'pscedd  pscedd`wn'
  rename r`wn'pscede  pscede`wn'
  rename r`wn'pscedf  pscedf`wn'
  rename r`wn'pscedg  pscedg`wn'
  rename r`wn'pscedh  pscedh`wn'
  rename r`wn'bp      bp`wn'
  rename r`wn'an      an`wn'
  rename r`wn'mi      mi`wn'
  rename r`wn'hf      hf`wn'
  rename r`wn'ah      ah`wn'
  rename r`wn'di      di`wn'
  rename r`wn'st      st`wn'
  rename r`wn'cl      cl`wn'
  rename r`wn'as      as`wn'
  rename r`wn'ar      ar`wn'
  rename r`wn'os      os`wn'
  rename r`wn'ca      ca`wn'
  rename r`wn'pd      pd`wn'
  rename r`wn'ps      ps`wn'
  rename r`wn'ad      ad`wn'
  rename r`wn'dm      dm`wn'
  rename r`wn'heeye   heeye`wn'
  rename r`wn'hehear  hehear`wn'
  rename r`wn'hefla   hefla`wn'
  rename r`wn'hefrac  hefrac`wn'
  rename r`wn'heji    heji`wn'
  rename r`wn'mmpain  mmpain`wn'
  rename r`wn'cfdatd  cfdatd`wn'
  rename r`wn'cfdatm  cfdatm`wn'
  rename r`wn'cfdaty  cfdaty`wn'
  rename r`wn'cfday   cfday`wn'
  rename r`wn'cflisen cflisen`wn'
  rename r`wn'cflisd  cflisd`wn'
}

reshape long age ///
  hemobwa hemobsi hemobch hemobcs hemobcl hemobst hemobre hemobpu hemobli hemobpi ///
  headldr headlwa headlba headlea headlbe headlwc headlma headlpr headlsh headlph headlme headlho headlmo ///
  hehelf psceda pscedb pscedc pscedd pscede pscedf pscedg pscedh ///
  bp an mi hf ah di st cl as ar os ca pd ps ad dm ///
  heeye hehear hefla hefrac heji mmpain ///
  cfdatd cfdatm cfdaty cfday cflisen cflisd ///
  , i(idauniq) j(yr)

drop if age == .

mvdecode _all, mv(-9 -8 -2 -1)

recode hehelf (1=0)(2=0.25)(3=0.5)(4=0.75)(5=1)
gen float hehelfi = hehelf if hehelf!=.

recode psceda (2=0)
recode pscedb (2=0)
recode pscedc (2=0)
recode pscedd (1=0)(2=1)
recode pscede (2=0)
recode pscedf (1=0)(2=1)
recode pscedg (2=0)
recode pscedh (2=0)

recode heeye (1=0)(2=0.2)(3=0.4)(4=0.6)(5=0.8)(6=1)
gen heeyei = (heeye>=0.8) if heeye!=.

recode hehear (1=0)(2=0.25)(3=0.5)(4=0.75)(5=1)
gen heheari = (hehear==1) if hehear!=.

recode hefla  (2=0)
recode hefrac (2=0)
recode heji   (2=0)
replace hefla  = 0 if hefla ==. & age<60
replace hefrac = 0 if hefrac==. & age<60
replace heji   = 0 if heji  ==. & age<60

recode mmpain (2=0)

recode cfdatd (1=0)(2=1)
recode cfdatm (1=0)(2=1)
recode cfdaty (1=0)(2=1)
recode cfday  (1=0)(2=1)

sort yr
egen cflisenq = xtile(cflisen) if cflisen>=0, n(4) by(yr)
replace cflisenq = 1    if cflisenq==1
replace cflisenq = 0.6  if cflisenq==2
replace cflisenq = 0.3  if cflisenq==3
replace cflisenq = 0    if cflisenq==4

egen cflisdq = xtile(cflisd) if cflisd>=0, n(5) by(yr)
replace cflisdq = 1    if cflisdq==1
replace cflisdq = 0.75 if cflisdq==2
replace cflisdq = 0.5  if cflisdq==3
replace cflisdq = 0.25 if cflisdq==4
replace cflisdq = 0    if cflisdq==5

gen float cfliseni = cflisenq if cflisenq!=.
gen float cflisdi  = cflisdq  if cflisdq !=.

local fi hemobwa hemobsi hemobch hemobcs hemobcl hemobst hemobre hemobpu hemobli hemobpi ///
         headldr headlwa headlba headlea headlbe headlwc headlma headlpr headlsh headlph headlme headlho headlmo ///
         hehelfi ///
         psceda pscedb pscedc pscedd pscede pscedf pscedg pscedh ///
         bp an mi hf ah di st ///
         cl as ar os ca pd ps ad dm ///
         heeyei heheari hefla hefrac heji ///
         mmpain ///
         cfdatd cfdatm cfdaty cfday cfliseni cflisdi

egen denominator = rownonmiss(`fi')
egen fraill = rowmean(`fi') if denominator>=30

rename yr wave
keep idauniq wave fraill
save "$odir/elsa_frailty_w1_11.dta", replace

cd "../.."
