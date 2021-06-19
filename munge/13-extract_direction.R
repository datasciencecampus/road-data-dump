"Purpose of script:
Extract direction and string cleansing
"
log4r::info(my_logger, paste0("############# ", "Start of ", basename(this.path()), " #############"))
# extracting direction ----------------------------------------------------

sites$direction <- direction(sites$sites.Name)

# fix sensor typo
sites$direction <- str_replace_all(
  sites$direction,
  pattern = "souhbound", replacement = "southbound"
)
# may wish to consider further string cleansing possibilities here

# tidy up -----------------------------------------------------------------
rm(direction)

