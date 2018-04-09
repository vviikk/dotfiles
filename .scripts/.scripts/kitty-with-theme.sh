#!/bin/bash
cat ~/.cache/wal/sequences
if [[ "$@" ]]
  then
    exec "$@" && exit 1
fi
