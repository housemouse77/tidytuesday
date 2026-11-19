* =============================================================================
* master.do: EU AI Act workspace
* Runs every Stata step in order. R step 01_download_aiact.R must run first.
* =============================================================================
version 16
clear all
set more off

* ---- EDIT THIS LINE ONCE -----------------------------------------------------
global root "C:/Users/YOURNAME/Documents/eu-ai-act"
* ------------------------------------------------------------------------------

global raw  "$root/02_data/raw"
global proc "$root/02_data/processed"
global code "$root/03_code/stata"
global out  "$root/06_output"
cd "$root"

capture log close
log using "$code/master.log", replace text

do "$code/01_import_articles.do"

log close
