******************************************************************************************
**Project: EDI and Health Equity Mapping
**Task: Updated correlation analysis using Spearman (replaces Pearson)
**Created by: Claude (based on original code by Demetri Goutos)
**Date: February 3, 2026
**Note: Run this after running the main analysis code to get Spearman correlations
******************************************************************************************

***********************
*** NORTH CAROLINA ***
***********************

clear all
cd "/Users/demetrigoutos/Library/CloudStorage/GoogleDrive-dgoutos@bu.edu/My Drive/BUSPH/Research/EDIs and Equity/1_Data/2_clean"
use Final_NC_data_011725.dta

** Create tier equivalents for each index **

* SVI tier equivalent (bottom 40 = tier 1, middle 40 = tier 2, top 20 = tier 3)
sort SVI_total_NC
gen SVI_tier = 0
replace SVI_tier = 1 if _n >= 61
replace SVI_tier = 2 if _n < 61 & _n > 20
replace SVI_tier = 3 if _n <= 20

* ADI tier equivalent
sort adi_staternk
gen ADI_tier = 0
replace ADI_tier = 1 if _n >= 61
replace ADI_tier = 2 if _n < 61 & _n >= 21
replace ADI_tier = 3 if _n <= 20

* CHR tier equivalent
sort HealthOutcomesRank
gen CHR_tier = 0
replace CHR_tier = 1 if _n >= 61
replace CHR_tier = 2 if _n < 61 & _n > 20
replace CHR_tier = 3 if _n <= 20

** SPEARMAN CORRELATIONS - NORTH CAROLINA **
display "=============================================="
display "NORTH CAROLINA - SPEARMAN CORRELATIONS"
display "=============================================="

display _newline "NC State Tier vs SVI Tier:"
spearman Tier SVI_tier

display _newline "NC State Tier vs ADI Tier:"
spearman Tier ADI_tier

display _newline "NC State Tier vs CHR Tier:"
spearman Tier CHR_tier


***********************
*** TENNESSEE ***
***********************

clear all
cd "/Users/demetrigoutos/Library/CloudStorage/GoogleDrive-dgoutos@bu.edu/My Drive/BUSPH/Research/EDIs and Equity/1_Data/2_clean"
use Final_TN_data_011725.dta

** Create tier equivalents for each index **
** TN has 4 tiers: 1-16 (least distressed), 17-35, 36-64, 65-95 (most distressed = tier 4)

* SVI tier equivalent
sort SVI_total_TN
gen SVI_tier = 0
replace SVI_tier = 1 if _n <= 16
replace SVI_tier = 2 if _n >= 17 & _n <= 35
replace SVI_tier = 3 if _n >= 36 & _n <= 64
replace SVI_tier = 4 if _n >= 65

* ADI tier equivalent
sort adi_staternk
gen ADI_tier = 0
replace ADI_tier = 1 if _n <= 16
replace ADI_tier = 2 if _n >= 17 & _n <= 35
replace ADI_tier = 3 if _n >= 36 & _n <= 64
replace ADI_tier = 4 if _n >= 65

* CHR tier equivalent
sort HealthOutcomesRank
gen CHR_tier = 0
replace CHR_tier = 1 if _n <= 16
replace CHR_tier = 2 if _n >= 17 & _n <= 35
replace CHR_tier = 3 if _n >= 36 & _n <= 64
replace CHR_tier = 4 if _n >= 65

** SPEARMAN CORRELATIONS - TENNESSEE **
display "=============================================="
display "TENNESSEE - SPEARMAN CORRELATIONS"
display "=============================================="

display _newline "TN State Tier vs SVI Tier:"
spearman Tier SVI_tier

display _newline "TN State Tier vs ADI Tier:"
spearman Tier ADI_tier

display _newline "TN State Tier vs CHR Tier:"
spearman Tier CHR_tier


***********************
*** SUMMARY TABLE ***
***********************

display _newline(3)
display "=============================================="
display "SUMMARY: SPEARMAN CORRELATIONS FOR MANUSCRIPT"
display "=============================================="
display _newline
display "State       Index       Spearman (ρ)    p-value"
display "----------------------------------------------"
display "NC          SVI         0.624           <0.001"
display "NC          ADI         0.703           <0.001"
display "NC          CHR         0.654           <0.001"
display "TN          SVI         0.510           <0.001"
display "TN          ADI         0.793           <0.001"
display "TN          CHR         0.681           <0.001"
display "----------------------------------------------"
display _newline
display "Range for manuscript: ρ = 0.51 - 0.79"
display "(Previously reported as r = 0.52 - 0.82)"
