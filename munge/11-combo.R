"
Purpose of script:
Stack listed data into combo data table.
"
log4r::info(my_logger, paste0("############# ", "Start of ", basename(this.path()), " #############"))

 if(pipeline_message != stat_codes[3]){
   
   combo <- rbindlist.disk.frame(all_requests_tables)
   
}
 
# # memory_report -----------------------------------------------------------
 
memory_report()
