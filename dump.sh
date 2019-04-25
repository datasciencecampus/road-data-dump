# todo dockerise this..

# from,to range. DD-MM-YYYY 
FROM=01032019
TO=31032019

git clone https://github.com/datasciencecampus/webtri.sh.git
cd webtri.sh
./webtri.sh -f get_site_by_type -a 1 >  ../sites.csv
./webtri.sh -f get_site_by_type -a 2 >> ../sites.csv
./webtri.sh -f get_site_by_type -a 3 >> ../sites.csv
mkdir ../data/

#test first 10
#head -10 ../sites.csv >x ;mv -v x ../sites.csv

time for i in $(tail -n+2 ../sites.csv |awk -F ',' '{print $1}' |tr -d '"') ;do
  echo "get site id ${i}..."
  ./webtri.sh -f get_report -a "$i daily $FROM $TO" > ../data/"$i".csv
done

# combo..
cd ../data
echo "site_id,"$(head -1 1.csv) > x
for i in $(ls *.csv) ;do
  tail -n+2 $i |sed "s/^/$i,/; s/.csv//" >> x
done
mv -v x combo.csv

# prep.ipynb
# split.ipynb
