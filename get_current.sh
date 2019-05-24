#!/bin/bash
# loop thru sites, download historic SCAN data - current year only

PATH=/bin:/usr/bin
YEAR=`date +%Y`
# start in the the correct place
TLD=/misc/array03/SCAN
cd $TLD

# get the list of sites from text file
# just one station ID per line
for s in `cat SCAN_ID.txt` ; do
	echo "site: [$s]"
	# make the directory if it does not exist
	if [ ! -d $s ] ; then
		mkdir $s
	fi

	cd $s

	echo "download station $s year $YEAR"
	./dl_scan_historic.sh $s SCAN Hourly $YEAR CY
	result=$?
	if [ $result -ne 0 ] ; then
		# try again
		echo "try again: station $s year $YEAR"
		./dl_scan_historic.sh $s SCAN Hourly $YEAR CY
		result=$?
		if [ $result -ne 0 ] ; then
			# give up
			echo "*** failed for station $STATION year $YEAR - give up"
		else
			echo "success!!!"
		fi
	fi

	cd ..

done
