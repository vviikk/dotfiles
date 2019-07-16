#!/bin/sh

curl -s https://data.smartdublin.ie/cgi-bin/rtpi/realtimebusinformation\?stopid\=3182\&format\=json | jq -r '.results[].duetime' | sed -e 's/^/Bus 114 arrives in /' | sed 's/$/ mins/'
