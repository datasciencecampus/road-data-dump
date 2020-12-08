"Purpose of script:
Write out product of analysis to csv to /output_data/ folder
"

# write out csvs
fwrite(midas, "output_data/midas.csv", row.names=F, quote=F)
fwrite(tame, "output_data/tame.csv", row.names=F, quote=F)
fwrite(tmu, "output_data/tmu.csv", row.names=F, quote=F)

# calculate elapsed time
elapsed <- Sys.time() - start_time
print(round(elapsed, digits = 3))


# sound alert when script completes
beepr::beep("coin")

