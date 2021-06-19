"
Purpose of script:
Create status code named character vector
which pipeline message can be updated with
"
log4r::info(my_logger, paste0("############# ", "Start of ", basename(this.path()), " #############"))


stat_codes <- c("1" = "Pipeline executed.",
                "2" = "Pipeline executed. Unresolved api errors detected. Check logs.",
                "3" = "Queried dates are empty.")
