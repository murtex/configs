#!/bin/sh

Xephyr -ac -br -noreset -screen 1024x768 :1.0 &
PID=$!

sleep 1
DISPLAY=:1.0 awesome -c rc.lua

kill $PID
