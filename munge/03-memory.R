"
Purpose of script: Configure environment

"
log4r::info(my_logger, paste0("############# ", "Start of ", current_file(), " #############"))

newlimit <- 100000

# bump up memory limit
memory.limit(newlimit)

# check operation executed successfully
log4r::info(my_logger, if (memory.limit() >= newlimit) {
  print(paste0("Memory limit is ", memory.limit(), ". Succesfully increased to required threshold."))
} else {
  print(warning(paste0("Memory limit is ", memory.limit(), ". Succesfully increased to required threshold.")))
})


log4r::info(my_logger, print(paste0(
  "Memory size prior to api request is ",
  memory.size()
)))
