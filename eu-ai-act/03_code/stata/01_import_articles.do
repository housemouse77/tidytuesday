* =============================================================================
* 01_import_articles.do
* In : $proc/aiact_units_<lang>.csv  (from 03_code/R/01_download_aiact.R)
* Out: $proc/aiact_units_<lang>.dta
*      $out/aiact_term_map_en.csv    (which articles use which key terms)
* =============================================================================

foreach l in en it {
    capture confirm file "$proc/aiact_units_`l'.csv"
    if _rc {
        di as error "Missing aiact_units_`l'.csv: run 01_download_aiact.R first"
        continue
    }
    import delimited "$proc/aiact_units_`l'.csv", varnames(1) ///
        encoding("utf-8") stringcols(_all) bindquote(strict) clear
    destring n_words, replace
    gen int art_no = real(unit_no) if unit_type == "article"

    label var lang      "Language version"
    label var unit_type "recital / article / annex"
    label var unit_no   "Number (annexes in Roman numerals)"
    label var heading   "Article title"
    label var text      "Full text"
    label var n_words   "Word count"
    label var art_no    "Article number (numeric)"
    compress
    save "$proc/aiact_units_`l'.dta", replace
}

* ---- Orientation: the 10 longest articles (where the regulatory weight sits) --
use "$proc/aiact_units_en.dta", clear
keep if unit_type == "article"
gsort -n_words
list art_no heading n_words in 1/10, clean noobs

* ---- Term map: how often each key term appears in each article ----------------
* Edit the list as your questions evolve.
local terms `" "deployer" "provider" "high-risk" "financial institution" "credit" "audit" "national security" "fundamental rights" "'
gen ltext = ustrlower(text)
local i = 0
foreach t of local terms {
    local ++i
    gen int kw_`i' = (ustrlen(ltext) - ustrlen(usubinstr(ltext, "`t'", "", .))) / ustrlen("`t'")
    label var kw_`i' "`t'"
}
drop ltext
egen int any_term = rowtotal(kw_*)
keep if any_term > 0
sort art_no
export delimited art_no heading kw_* using "$out/aiact_term_map_en.csv", replace
di as result "Term map written to $out/aiact_term_map_en.csv"
