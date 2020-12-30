# Roads Data Dump: r-pipeline branch

Documentation available on [GitHub pages](https://datasciencecampus.github.io/road-data-pipeline-documentation/)

Also locally available in `./docs/index.html`.

## Changelog

### Version 1.2

* Draft user interface added
* user Email input
* Test pipeline? checkbox
* Date inputs
* output all parameters to cache for pipeline

### Version 1.1

* Log cluster details as failed to stop on prior run
* Convert code to using joins with join interrogation
* Documentation updated to include data processing info
* Update site_report with product of anti_join if exists
* Review extract_eastnor function
* Tidy up logs
* Additional testing for appended sites DF
* Testing handle_missing() function.
* Implement a retry for any internal server errors (HTTP status code 500 to 599)

### Version 1.0

* Helper function to increment filenames
* Ensure outputs are cached to correct location of revised repo structure
* Select a logging option to capture console output
* Need pretty sessioninfo output for logging
* Start logging with human friendly delimeter
* added handle_query() function with logging output
* added wrap_up() function for ending sequential ex of munge scripts
* Query api and create equivalents of site.midas, site.tame and site.tmu data
* Unit tests for site dataframes
* Daily reports missing site IDs, inspect this in webtri.sh, may need to query one site at a time
* Investigate issue with 07-join_readings_sites.R, no readings for tame or tmu sites...
* querying siteIds - Use http_status to skip dataframe processing for anything returning $category == "Success" && $reason == "No content", certain siteIDs missing from provided api daterange
* querying dateranges - need to establish api requirements and exception handling
* Output a text file containing all sites that returned empty content for the specified date range
* Combine the csvs in /data/ into `combo.csv`, as achieved in webtri.sh
* Use this.path to demark all script start checkpoints
* Add test logic for handing over: test_run == TRUE, only execute 1 day and first  site ID.
* document error: Error in fwrite(tmu, "output_data/tmu.csv", row.names = F, quote = F) : 
  Permission denied: 'output_data/tmu.csv'. Failed to open existing file for writing. Do you have write permission to it? Is this Windows and does another process such as Excel have it open?
* Print count of missing IDs to log and to txt
* Print count of error IDs to log and to txt
* Print summaries of all status codes to log
* Need to log all query parameters for use in replicating issues.
* remove api_logger
* Update to documentation - markdown web page with screengrabs
* write filename behaviour specified by user: save output data files appended with query dates.
* Update func/functions.R labelling
* apply styler style guide
* Update documentation for adjusting user.email for user.agent()
* date handling tests in 03-set_query_parameters.R, exceeding 31 days to query results in an execution halting.
* parallel computation using socket cluster
* Replace missing report .txt with a .rmd including visuals & text for all missing site Ids and by sitetype.
* Date handling if specified end date is before specified start date