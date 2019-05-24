#!/bin/sh
if  [[ $# -lt 5  ]] 
then
    echo "Script to get historic data"
    echo "usage: $0 STATION REPORT SERIES ITYPE YEAR "
    echo "where: "
    echo "      STATION is numeric is 2095, 302, etc"
    echo "      REPORT is  SOIL (soil temp and moisture) SCAN (standard scan), ALL (all), WEATHER (atmospheric)"
    echo "      SERIES is Daily or Hourly"
    echo "      YEAR is YYYY"
    echo "      MONTH is MM or CY (calendar year), or WY  (water year)"
    echo "      Optional DAY is DD"
    exit
fi

export STATION=$1
export REPORT=$2
export SERIES=$3
export YEAR=$4
export MONTH=$5
export DAY=$6

export INTERVALTYPE=Historic

curl "http://www.wcc.nrcs.usda.gov/nwcc/view?intervalType=$INTERVALTYPE+&report=$REPORT&timeseries=$SERIES&format=copy&sitenum=$STATION&year=$YEAR&month=$MONTH&day=$DAY" -m 60 -o $STATION-$YEAR$MONTH$DAY.csv

result=$?
if [ $result -ne 0 ] ; then
	echo "download failed for station $STATION year $YEAR"
	exit 1
else
	exit 0
fi

