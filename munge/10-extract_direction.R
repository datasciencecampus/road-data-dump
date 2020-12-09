"Purpose of script:
Extract direction and string cleansing
"

# extracting direction ----------------------------------------------------

sites$direction <- direction(sites$sites.Name)

# fix sensor typo
sites$direction <- str_replace_all(
  sites$direction, pattern = "souhbound", replacement = "southbound")
# may wish to consider further string cleansing possibilities here

