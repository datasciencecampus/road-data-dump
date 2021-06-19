"Purpose of script:
Split files processed in prep.R by site
"
log4r::info(my_logger, paste0("############# ", "Start of ", basename(this.path()), " #############"))

# split into midas,tame,tmu
if(pipeline_message != stat_codes[3]) {
  # DAP pipeline expects column names in specific format. rename to expected syntax.
  combo <- rename(combo,
                  site_name = "Site Name",
                  report_date = "Report Date",
                  time_period_end = "Time Period Ending",
                  interval = "Time Interval",    
                  len_0_520_cm = "0 - 520 cm",
                  len_521_660_cm = "521 - 660 cm",
                  len_661_1160_cm = "661 - 1160 cm",
                  len_1160_plus_cm = "1160+ cm",         
                  speed_0_10_mph = "0 - 10 mph",
                  speed_11_15_mph = "11 - 15 mph",
                  speed_16_20_mph = "16 - 20 mph",
                  speed_21_25_mph = "21 - 25 mph",
                  speed_26_30_mph =  "26 - 30 mph",
                  speed_31_35_mph =  "31 - 35 mph",
                  speed_36_40_mph =  "36 - 40 mph",
                  speed_41_45_mph =  "41 - 45 mph", 
                  speed_46_50_mph =  "46 - 50 mph",
                  speed_51_55_mph =  "51 - 55 mph",
                  speed_56_60_mph =  "56 - 60 mph",
                  speed_61_70_mph =  "61 - 70 mph", 
                  speed_71_80_mph =  "71 - 80 mph",
                  speed_80_plus_mph = "80+ mph",
                  speed_avg_mph = "Avg mph",
                  total_vol = "Total Volume",     
                  longitude = "sites.Longitude",
                  latitude = "sites.Latitude",    
                  status = "sites.Status"
                  
)
  
# ensure order of column names is as DAP pipeline expects
  combo <- select(combo,
                  site_id,
                  site_name,
                  report_date,
                  time_period_end,
                  interval,
                  len_0_520_cm,
                  len_521_660_cm,
                  len_661_1160_cm,
                  len_1160_plus_cm,
                  speed_0_10_mph,
                  speed_11_15_mph,
                  speed_16_20_mph,
                  speed_21_25_mph,
                  speed_26_30_mph,
                  speed_31_35_mph,
                  speed_36_40_mph,
                  speed_41_45_mph,
                  speed_46_50_mph,
                  speed_51_55_mph,
                  speed_56_60_mph,
                  speed_61_70_mph,
                  speed_71_80_mph,
                  speed_80_plus_mph,
                  speed_avg_mph,
                  total_vol,
                  longitude,
                  latitude,
                  status,
                  type,
                  direction,
                  easting,
                  northing  
                  )
  
 
  midas <- combo[combo$type == "midas", ]
  tame <- combo[combo$type == "tame", ]
  tmu <- combo[combo$type == "tmu", ]
  
  
  # tidy up -----------------------------------------------------------------
  
  rm(combo)
}


# return empty DFs if queried dates are all empty -------------------------

if (pipeline_message == stat_codes[3]){
  midas <- data.frame()
  tame <- data.frame()
  tmu <- data.frame()
}


# memory_report -----------------------------------------------------------

memory_report()
