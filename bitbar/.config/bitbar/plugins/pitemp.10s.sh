#!/bin/bash

TEMP=`ssh root@pi 'vcgencmd measure_temp' | cut -d'=' -f 2`
echo $TEMP
