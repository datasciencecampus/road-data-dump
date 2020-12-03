"
Purpose of script: Configure environment

"
# bump up memory limit
memory.limit(20000)
# check operation executed successfully
if (memory.limit() >= 20000) {
  print(paste("Memory limit is", memory.limit(), ". Succesfully increased to required threshold."))
} else {
  print(warning(paste("Memory limit is", memory.limit(), ". Succesfully increased to required threshold.")))
}
  
# import custom functions
source("func/functions.r")

func_names <- c("direction", "easting_northing")


func_names %in% objects()


