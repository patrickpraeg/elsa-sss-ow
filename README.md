# Replication package

Subjective Socioeconomic Status and Health and Wellbeing in Later Life: An Outcome-Wide Fixed-Effects Analysis of the English Longitudinal Study of Ageing

Patrick Präg, Asri Maharani, Lindsay Richards

## Data

The ELSA data cannot be redistributed. Download them from the [UK Data Service](https://ukdataservice.ac.uk), unzip, and place the folders in `data/raw/`:

| Study | Folder | DOI |
|---|---|---|
| SN 5050, ELSA Waves 0--11, 49th edition (Stata format) | `data/raw/UKDA-5050-stata/` | 10.5255/UKDA-SN-5050-36 |
| SN 8688, ELSA COVID-19 Study Waves 1--2 (Stata format) | `data/raw/UKDA-8688-stata/` | 10.5255/UKDA-SN-8688-3 |

## Run

Requires Stata (developed and tested with StataNow 19.5 MP). On the first run, an internet connection is needed to install the user-written commands. Set the working directory to this folder and run:

```stata
do code/00_master.do
```

The complete log is written to `output/replication.log`. Intermediate data go to `data/temp/`. A full run takes about 35 minutes.

## Code

| Script | Content |
|---|---|
| `00_master.do` | Installs commands, opens the log, runs all scripts |
| `01_prepare_data.do` | Copies the raw files used |
| `02_allostatic_load.do` | Allostatic load and nurse-visit biomarkers |
| `03_frailty.do` | Frailty index |
| `04_main_analysis.do` | Data construction, random and fixed effects, E-values, sex-stratified models |
| `05_asymmetric_fe.do` | Asymmetric fixed-effects models |
| `06_asymmetric_figure.do` | Asymmetric estimates figure |
| `07_asymmetric_table.do` | Asymmetric estimates table |
| `08_natural_units_table.do` | Estimates in original units |
| `09_weighted_sensitivity.do` | Weighted fixed-effects models |
| `10_weighted_figure.do` | Weighted versus unweighted figure |
| `11_dynamic_panel_xtabond2.do` | Arellano--Bond models |
| `12_anxiety_validation.do` | Anxiety measure validation |

## Output

| Item | Script | File |
|---|---|---|
| Figure 1 | `04` | `output/figures/figure1.pdf` |
| Figure 2 | `06` | `output/figures/asymmetric.pdf` |
| Table S2 | `04` | `output/tables/dataselection.txt` |
| Table S3 | `04` | `output/tables/descriptives.tex` |
| Table S4 | `04` | `output/tables/outcome_table.txt`, `output/figures/hist_*.pdf` |
| Table S7 | `08` | `output/tables/natural_units_table.tex` |
| Table S8 | `04` | `output/tables/coefficients_table.tex` |
| Table S9 | `07` | `output/tables/asymmetric_table.tex` |
| Figure S1 | `04` | `output/figures/sss_distributions.pdf`, `output/tables/sss_stats.tex` |
| Figure S2 | `12` | `output/figures/anxiety_validation.pdf`, `output/tables/anxiety_validation_stats.tex` |
| Figure S3 | `04` | `output/figures/correlations.pdf` |
| Figure S4 | `04` | `output/figures/evalues.pdf` |
| Figure S5 | `09`, `10` | `output/figures/weighted_differences.pdf` |
| Figure S6 | `04` | `output/figures/sex_differences.pdf` |
| Arellano--Bond results | `11` | `output/estimates/xtabond2_all.csv` |

Tables S1, S5, S6 and S10 (ethical approval, allostatic load cut-offs, frailty deficits, STROBE checklist) contain no estimates. Numbers quoted in the text are in `output/replication.log`.
