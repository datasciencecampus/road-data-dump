# Roads Data Dump: r-pipeline branch

Documentation available on [GitHub pages](https://datasciencecampus.github.io/road-data-pipeline-documentation/)

Also locally available in `./docs/index.html`.

## Changelog

### Version 1.3

* present tables in UI on successful completion.
* Menu at bottom of app allows user to switch between parameters and data tables.
* Updated tour info to reflect above changes.
* table outputs very slow on full month query, revert to table preview, first 100 lines.
* error handling for daterange queried when all responses are empty - pipeline to output pipeline_message for display in UI. Create conditional logic in pipeline that skips scripts if all content is empty.
* Update selected date on app launch to current date.
* Tidy up environment from final sequential script forwards.

### Known Issues

* re-running whole month queries can cause system crashes. Updating documentation to ensure user advised on starting fresh R session once finished testing whilst troubleshooting.

### Version 1.2.1

* Error handling on re-running pipeline following successful execution.
* Confirmation dialogue box bug handling.
=======

### Version 1.2

* User Interface for setting query parameters & executing pipeline.
* user Email input
* Test pipeline toggle radio buttons.
* Daterange input.
* Output all parameters to cache for pipeline execution.
* Action button to execute run.
* Pipeline adjusted to read parameters from cache.
* Only execute pipeline if user Email is validated.
* Pipeline - check all outputs have written.
* Cache MIDAS head if successfully written.
* Spinner presents when server is busy.
* Grey out date selection elements when testing.
* Email field inputs can be recorded within a session.
* Application guide added.
* Sticky Email validation result resolved.

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