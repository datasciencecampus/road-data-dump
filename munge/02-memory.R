"
Purpose of script: Configure environment

"
info(my_logger, paste0("#############", "Start of", this.path(), "#############"))
# calculate start time for performance
start_time <- Sys.time()


newlimit <- 30000

# bump up memory limit
memory.limit(newlimit)

# check operation executed successfully
log4r::info(my_logger, if (memory.limit() >= newlimit) {
  print(paste0("Memory limit is ", memory.limit(), ". Succesfully increased to required threshold."))
} else {
  print(warning(paste0("Memory limit is ", memory.limit(), ". Succesfully increased to required threshold.")))
})


info(my_logger, print(paste0(
  "Memory size prior to api request is ",
  memory.size()
)))
