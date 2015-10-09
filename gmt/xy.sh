#!/bin/bash
#		GMT EXAMPLE 21
#		$Id: job21.sh 9545 2011-07-27 19:31:54Z pwessel $
#
# Purpose:	Plot a time-series
# GMT progs:	gmtset, gmtconvert, minmax, psbasemap, psxy 
# Unix progs:	cut, echo
#

ps=example.ps

R=0/8/0/1

# Lay down the basemap:
psbasemap -R$R -JX9i/6i -V -Bs1Y/WSen \
   -Bpa3Of1o/50WSen:=\$::."RedHat (RHAT) Stock Price Trend since IPO": > $ps

# Plot main window with open price as red line over yellow envelope of low/highs



exit 0

# Draw P Wessel's purchase price as line and label it.  Note we temporary switch
# back to default yyyy-mm-dd format since that is what minmax gave us.

echo "05-May-00	0" > RHAT.pw
echo "05-May-00	300" >> RHAT.pw
psxy -R -J RHAT.pw -Wthinner,- -O -K >> $ps
echo "01-Jan-99	25" > RHAT.pw
echo "01-Jan-07	25" >> RHAT.pw
psxy -R -J RHAT.pw -Wthick,- -O -K >> $ps
gmtset INPUT_DATE_FORMAT yyyy-mm-dd
echo "$w 25 12 0 17 LB Wessel purchase price" | pstext -R -J -O -K -D2i/0.05i -N >> $ps
gmtset INPUT_DATE_FORMAT dd-o-yy

# Get smaller region for insert for trend since 2004

R="-R2004T/$e/$s/40"

# Lay down the basemap, using Finnish annotations and place the insert in the upper right:

gmtset TIME_LANGUAGE fi
psbasemap $R -JX6i/3i -Bpa3Of3o/10:=\$:ESw -Bs1Y/ -Glightblue -O -K -X3i -Y3i >> $ps
gmtset TIME_LANGUAGE us

# Again, plot close price as red line over yellow envelope of low/highs

psxy -R -J -Gyellow -O -K RHAT.env >> $ps
psxy -R -J RHAT_price.csv -H -Wthin/red -O -K >> $ps

# Draw P Wessel's purchase price as dashed line

psxy -R -J RHAT.pw -Wthick,- -O >> $ps

# Clean up after ourselves:

rm -f RHAT.* .gmt*