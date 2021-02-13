#!/bin/sh

#!/bin/sh

# touchtoggle.sh Copyright (C) 2019 by Steve Litt
# All rights reserved.
# Licensed via the
# Expat license: https://directory.fsf.org/wiki/License:Expat

# FIRST GET DEVICE'S DEVICE ID CONTAINING CASE INSENSITIVE "TOUCHPAD"
devid=`xinput | grep -i touchpad | \
  sed -e"s/.*id=//" | sed -e"s/\s.*//"`

# WITH THAT DEVICE ID, FIND EVERYTING ABOUT PROPERTY
# CONTAINING CASE INSENSITIVE "DEVICE ENABLED"
scratchline=`xinput --list-props 11 | \
  grep -i "device enabled" | \
  sed -e"s/^\s*//" | sed -e"s/\s*$//"`
proptext=`echo $scratchline | sed -e"s/\s*(.*//"`
propid=`echo $scratchline | sed -e"s/.*(//" | sed -e"s/).*//"`
currstate=`echo $scratchline | sed -e"s/.*):\s*//"`

# DIAGNOSTICS, COMMENT OUT WHEN FULLY FUNCTIONAL
echo diagnostic devid      =$devid
echo diagnostic scratchline=$scratchline
echo diagnostic proptext   =$proptext#
echo diagnostic propid     =$propid

# TOGGLE CURRSTATE VARIABLE
echo -n "Current state of $currstate "
if test "$currstate" = "1"; then
        currstate=0
else
        currstate=1
fi
echo has been changed to $currstate.

# IMPLEMENT THE PROPERTY VALUE CHANGE
xinput set-prop $devid $propid $currstate

# UNCOMMENT FOLLOWING LINE IF PROPERTY ID STOPS WORKING
#xinput set-prop $devid "$proptext" $currstate
