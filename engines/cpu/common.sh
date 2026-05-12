#!/bin/bash -eu

server="$SNAP_COMPONENTS/$(qwen36 get server)"
model="$SNAP_COMPONENTS/$(qwen36 get model)"
mmproj="$SNAP_COMPONENTS/$(qwen36 get multimodel-projector)"

if [ ! -d "$model" ]; then
    echo "Missing component: $model"
    exit 1
fi

if [ ! -d "$mmproj" ]; then
    echo "Missing component: $mmproj"
    exit 1
fi

source "$model/init" # exports MODEL_FILE
source "$mmproj/init" # export MMPROJ_FILE

if [ ! -d "$server" ]; then
    echo "Missing component: $server"
    exit 1
fi

# For staged shared objects
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$server/usr/lib/$ARCH_TRIPLET:$server/usr/local/lib"
