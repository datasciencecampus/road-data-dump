
# road-data-dump

## Branch: r-pipeline-dev

## Branch Purpose

* Convert pipeline to R.
* Use ProjectTemplate directory configuration
* Use renv package management


## API Documentation
[Highways England WebTRIS Traffic Flow API documentation](https://webtris.highwaysengland.co.uk/api/swagger/ui/index)



## API workflow:

**Step 1.** Get site by type. From Phil Stubbings' webtri.sh/txt, available in /shell_scripts/webtri.sh.txt:

Filter site information by site type. Use `get_site_types` function to see
available options. The API currently returns:

1. Motorway Incident Detection and Automatic Signalling (MIDAS)
   Predominantly inductive loops (though there are a few sites where radar
   technology is being trialled)

2. TAME (Traffic Appraisal, Modelling and Economics) which are inductive loops

3. Traffic Monitoring Units (TMU) (loops)

4. Highways Agency’s Traffic Flow Database System (TRADS)
   Traffic Accident Database System (TRADS)? (legacy)
   
   
   
**Step 2.** Rbind (append) sitetype files from **Step 1**.

**Step 3.** Test the top 10 rows. Looks like simple printing out. Unsure of utility. Replace with unit tests using site quality feature of api? From Phil Stubbings' webtri.sh/txt, available in /shell_scripts/webtri.sh.txt:

  [get_quality] Get overall or daily quality.
    args
      1. Comma seperated list of site ids. Or single site id if daily.
      2. ddmmyyyy start period.
      3. ddmmyyyy end period.
      4. overall or daily.

    If overall quality has been specified, gets the quality in terms of a
    percentage score. The percentage represents aggregated site data
    availability for the specified time period. If daily has been specified,
    Gets the day by day percentage quality for each site.

    Note that the orignal API contains a bug in which the overall quality is not
    calculated correctly. If CSV output has been specified (or jq is not
    present) This implementation will automatically correct for this bug.


**Step 5.** Get all the site IDs.

**Step 6.**  Get daily reports for all site IDs and save to numbered csvs in data folder. Seems to be the parallel step. From Phil Stubbings' webtri.sh/txt, available in /shell_scripts/webtri.sh.txt:

$1 - Comma seperated list of site ids. Or single site id if daily. (max 30)
$2 - ddmmyyyy start period.
$3 - ddmmyyyy end period.
$4 - overall or daily.

This is the main part of the API. A site report consists of a number of
variables for each time period (minimum 15 minute interval) covering vehicle
lengths, speeds and total counts.

Examples

  get_report 5688 daily 01012015 01012018
  get_report 5688 daily 01012018 01012018

Returns

  * site_name
  * report_date
  * time_period_end,
  * interval
  * len_0_520_cm
  * len_521_660_cm
  * len_661_1160_cm
  * len_1160_plus_cm
  * speed_0_10_mph
  * speed_11_15_mph
  * speed_16_20_mph
  * speed_21_25_mph
  * speed_26_30_mph
  * speed_31_35_mph
  * speed_36_40_mph
  * speed_41_45_mph
  * speed_46_50_mph
  * speed_51_55_mph
  * speed_56_60_mph
  * speed_61_70_mph
  * speed_71_80_mph
  * speed_80_plus_mph
  * speed_avg_mph
  * total_vol

**Step 7.** Combine all the numbered csvs into combo.csv. 


**Step 8.** Proceed with sequential R scripts, cleansing, extracting direction, easting northing, joining sitetype data to daily reports, output to separate csvs.





## Previous Readme

[![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](http://www.repostatus.org/badges/latest/wip.svg)](http://www.repostatus.org/#wip)

> Code to download all England road traffic data once per month.

Current dump (Nov'18 - Feb'19): http://parasec.net/road-data/

Idea if this repo is to use [phil8192/webtri.sh](https://github.com/phil192/webtri.sh) to snatch data then push to some remote location.


## Prerequisites

Install [JQ](https://stedolan.github.io/jq/) - the JSON command line processor.
