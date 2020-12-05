#!/bin/bash

# combo..
cd ./data
echo "site_id,"$(head -1 1.csv) > x
for i in $(find . -name "*.csv" |sed 's/.\///') ;do
  tail -n+2 $i |sed "s/^/$i,/; s/.csv//" >> x
done
mv -v x ../combo.csv
cd ..