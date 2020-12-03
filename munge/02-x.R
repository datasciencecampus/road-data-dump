# extracting direction ----------------------------------------------------



#testing on extract
#direction(ex$name)

sites$direction <- direction(sites$name)
#table(sites$direction)

# fix sensor typo

sites$direction <- str_replace_all(
  sites$direction, pattern = "souhbound", replacement = "southbound")
# may wish to consider further string cleansing possibilities here

