"
Purpose of script: Configure environment

"
# calculate start time for performance
start_time <- Sys.time()

# bump up memory limit
memory.limit(20000)

# check operation executed successfully
if (memory.limit() >= 20000) {
  print(paste("Memory limit is", memory.limit(), ". Succesfully increased to required threshold."))
} else {
  print(warning(paste("Memory limit is", memory.limit(), ". Succesfully increased to required threshold.")))
}






