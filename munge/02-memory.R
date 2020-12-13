"
Purpose of script: Configure environment

"
# calculate start time for performance
start_time <- Sys.time()


newlimit <- 2000000

# bump up memory limit
memory.limit(newlimit)

# check operation executed successfully
log4r::info(my_logger, if (memory.limit() >= newlimit) {
  print(paste0("Memory limit is ", memory.limit(), ". Succesfully increased to required threshold."))
} else {
  print(warning(paste0("Memory limit is ", memory.limit(), ". Succesfully increased to required threshold.")))
}

)


info(my_logger, print(paste0("Memory size prior to api request is ",
                             memory.size())))








