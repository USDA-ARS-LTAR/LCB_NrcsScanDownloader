#!/bin/bash
# loop thru sites, download historic SCAN data

# get the list of sites from text file
# just one station ID per line
for s in `cat SCAN_ID.txt` ; do
	echo "site: [$s]"
	# make the directory if it does not exist
	if [ ! -d $s ] ; then
		mkdir $s
	fi

	cd $s

	# loop thru years and get a file for each year
	for y in 2002 2003 2004 2005 2006 2007 2008 2009; do
		echo "download station $s year $y"
		sh ../dl_scan_historic.sh $s SCAN Hourly $y CY
		result=$?
		if [ $result -ne 0 ] ; then
			# try again
			echo "try again: station $s year $y"
			sh ../dl_scan_historic.sh $s SCAN Hourly $y CY
			result=$?
			if [ $result -ne 0 ] ; then
				# give up
				echo "*** failed for station $STATION year $YEAR - give up"
			else
				echo "success!!!"
			fi
		fi
	done

	cd ..

done
