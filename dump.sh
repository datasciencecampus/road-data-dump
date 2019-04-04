# dockerise this..
git clone https://github.com/phil8192/webtri.sh.git
cd webtri.sh
./webtri.sh -f get_site_by_type -a 1 >  ../sites.csv
./webtri.sh -f get_site_by_type -a 2 >> ../sites.csv
./webtri.sh -f get_site_by_type -a 3 >> ../sites.csv
mkdir ../data/

time for i in $(tail +2 ../sites.csv |awk -F ',' '{print $1}' |tr -d '"') ;do
  echo "get site id ${i}..."
  ./webtri.sh -f get_report -a "$i daily 01112018 31032019" > ../data/"$i".csv
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
