# todo dockerise this..

# from,to range. DD-MM-YYYY 
FROM=01032019
TO=31032019

git clone https://github.com/datasciencecampus/webtri.sh.git
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
mv -v x ../combo.csv
cd ..

# prep.ipynb
# split.ipynb
