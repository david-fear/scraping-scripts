#!/bin/bash 

echo 'getting co2 readings, putting into csv'

outfile='/mnt/c/Temp/CO2/CO2readings.csv'
echo 'niwa...'
/usr/bin/printf "niwa-nz," >> $outfile; 
  /usr/bin/curl https://niwa.co.nz/static/co2-data/bhd_co2_info.txt | /usr/bin/sed 's/.*|//' | /usr/bin/sed -z 's/\n/,/g' >> $outfile
echo 'co2.earth...'
/usr/bin/printf "\nco2.earth," >> $outfile; 
  /usr/bin/curl -s https://charting.numberlens.com/api/teamearth/getdailyco2?authtoken=D43026302F294A5784F7512A8969FE37 | jq -r '.SourceCurrentIndexDate + "," + .SourceCurrentIndexValue + "," + .SourcePreviousIndexValue' >> $outfile
echo 'keelingcurve...'
/usr/bin/printf "keelingcurve.ucsd.edu," >> $outfile; 
  /usr/bin/curl -s https://scripps.ucsd.edu/bluemoon/co2_400/co2_daily | sed 's/ //g' | /usr/bin/sed 's/^\([^,]*\),\([^$]*\)/\2,\1/' >> $outfile; 
exit 0
