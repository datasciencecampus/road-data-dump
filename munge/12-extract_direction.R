"Purpose of script:
Extract direction and string cleansing
"
info(my_logger, paste0("############# ", "Start of ", current_file(), " #############"))
# extracting direction ----------------------------------------------------

sites$direction <- direction(sites$sites.Name)

# fix sensor typo
sites$direction <- str_replace_all(
  sites$direction,
  pattern = "souhbound", replacement = "southbound"
)
# may wish to consider further string cleansing possibilities here
