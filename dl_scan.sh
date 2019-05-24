#!/bin/sh
if  [[ $# -ne 4  ]] 
then
    echo "Script to get Current data"
    echo "usage: $0 STATION REPORT SERIES INTERVAL "
    echo "where: "
    echo "      STATION is numeric is 2095, 302, etc"
    echo "      REPORT is  SOIL (soil temp and moisture) SCAN (standard scan), ALL (all), WEATHER (atmospheric)"
    echo "      SERIES is Daily or Hourly"
    echo "      INTERVAL is current DAY or WEEK or YEAR (calendar year) or WATERYEAR (current waterhyear)"
    exit
fi

export STATION=$1
export REPORT=$2
export SERIES=$3
export INTERVAL=$4
export INTERVALTYPE=Current

curl "http://www.wcc.nrcs.usda.gov/nwcc/view?intervalType=$INTERVALTYPE+&report=$REPORT&timeseries=$SERIES&format=copy&sitenum=$STATION&interval=$INTERVAL" -o $STATION-$INTERVAL.csv
