#!/bin/bash

# nummber of reports to download in parallel.
# set to 1 for serial operation.
PARALLEL=4

# from,to range. DD-MM-YYYY 
#FROM=01042019
FROM=01012015
TO=30042019

git clone https://github.com/phil8192/webtri.sh.git
cd webtri.sh

# get diff site types
./webtri.sh -f get_site_by_type -a 1 > ../site_midas.csv
./webtri.sh -f get_site_by_type -a 2 > ../site_tame.csv
./webtri.sh -f get_site_by_type -a 3 > ../site_tmu.csv

# combine them (need to keep site_x files for later)
cat ../site_midas.csv ../site_tame.csv ../site_tmu.csv > ../sites.csv
head -1 ../site_midas.csv > ../sites.csv
tail -n+2 ../site_midas.csv >> ../sites.csv
tail -n+2 ../site_tame.csv  >> ../sites.csv
tail -n+2 ../site_tmu.csv   >> ../sites.csv

mkdir -p ../data

#test first 10
#head -10 ../sites.csv >x ;mv -v x ../sites.csv


j=0
time for i in $(tail -n+2 ../sites.csv |awk -F ',' '{print $1}' |tr -d '"') ;do
  j=$((j + 1))
  echo "get site id ${i}..."
  ./webtri.sh -f get_report -a "$i daily $FROM $TO" > ../data/"$i".csv &
  if [ 0 == $((j % $PARALLEL)) ] ;then
    wait
  fi
done

# combo..
cd ../data
echo "site_id,"$(head -1 1.csv) > x
for i in $(ls *.csv) ;do
  tail -n+2 $i |sed "s/^/$i,/; s/.csv//" >> x
done
mv -v x ../combo.csv
cd ..

# prep.ipynb
# split.ipynb
