******************************************************************************************
**Project: EDI and Health Equity Mapping
**Task: Read in RWJF 2024 data
**Created by: Demetri Goutos 
**Date: June 2, 2024
******************************************************************************************


***Tennessee***

import excel "/Users/demetrigoutos/Library/CloudStorage/GoogleDrive-dgoutos@bu.edu/My Drive/BUSPH/Research/EDIs and Equity/1_Data/1_raw/2020 RWJF County Health Rankings/2020 County Health Rankings Data - v2.xlsx", sheet("Outcomes & Factors Rankings") firstrow

drop if State != "Tennessee"
drop if missing(County)
rename FIPS fips
destring fips, replace

cd "/Users/demetrigoutos/Library/CloudStorage/GoogleDrive-dgoutos@bu.edu/My Drive/BUSPH/Research/EDIs and Equity/1_Data/2_clean/9_TN/RWJF Rankings"
save "RWJF2020_TN", replace


***TN - merge RWJF with existing map+ADI data***
clear all

cd "/Users/demetrigoutos/Library/CloudStorage/GoogleDrive-dgoutos@bu.edu/My Drive/BUSPH/Research/EDIs and Equity/1_Data/2_clean/9_TN/RWJF Rankings"
use RWJF2020_TN

cd "/Users/demetrigoutos/Library/CloudStorage/GoogleDrive-dgoutos@bu.edu/My Drive/BUSPH/Research/EDIs and Equity/1_Data/2_clean/9_TN/2020 merge"
merge 1:1 fips using TN_ADI_ACS_2020

destring HealthOutcomesQuartile, replace

save TN_ADI_ACS_RWJF_2020, replace

ssc install bimap, replace
ssc install spmap, replace
ssc install palettes, replace
ssc install colrspace, replace
ado update, update
ssc install schemepack, replace
set scheme white_tableau  
graph set window fontface "Arial Narrow"

bimap HealthOutcomesQuartile Tier using county_shp2, cuty(0(1)4) cutx(0(1)4) formatx(%3.0f) formaty(%3.0f) palette(yellowblue) xdisc ydisc ///
		 title("Tennessee - RWJF Health Outcomes Quartile") ///
		 note("All data from 2020.", size(vsmall)) ///	 
		 texty("County RWJF Health Outcomes Quartile") textx("TN State Tier") texts(3) textlabs(3) values count ///
		 ocolor(black) osize(0.03)  ///
		 showleg legenda(off) legend(pos(7) size(5)) legstyle(2)
		 
corr HealthOutcomesQuartile Tier


***NC***
clear all

import excel "/Users/demetrigoutos/Library/CloudStorage/GoogleDrive-dgoutos@bu.edu/My Drive/BUSPH/Research/EDIs and Equity/1_Data/1_raw/2020 RWJF County Health Rankings/2020 County Health Rankings Data - v2.xlsx", sheet("Outcomes & Factors Rankings") firstrow

drop if State != "North Carolina"
drop if missing(County)
rename FIPS fips
destring fips, replace
destring HealthOutcomesRank, replace

xtile tercile = HealthOutcomesRank, nq(3)
gen rev_RWJF_tercile = 4 - tercile
label variable rev_RWJF_tercile "reverse tercile for RWJF in NC"


cd "/Users/demetrigoutos/Library/CloudStorage/GoogleDrive-dgoutos@bu.edu/My Drive/BUSPH/Research/EDIs and Equity/1_Data/2_clean/4_NC_ADI_merges"
merge 1:1 fips using NC_ADI_ACS_2020

save NC_ADI_RWJF_ACS_2020, replace


ssc install bimap, replace
ssc install spmap, replace
ssc install palettes, replace
ssc install colrspace, replace
ado update, update
ssc install schemepack, replace
set scheme white_tableau  
graph set window fontface "Arial Narrow"

bimap rev_RWJF_tercile Tier using county_shp2, palette(yellowblue) xdisc ydisc ///
		 title("North Carolina - RWJF Health Outcomes Tercile") ///
		 note("All data from 2020..", size(vsmall)) ///	 
		 texty("County RWJF Health outcomes Tercile") textx("NC State Tier") texts(3) textlabs(3) values count ///
		 ocolor(black) osize(0.03)  ///
		 showleg legenda(off) legend(pos(7) size(5)) legstyle(2)

corr rev_RWJF_tercile Tier
		 
