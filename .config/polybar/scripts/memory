#!/bin/bash

printf "🧠 $(free -m | awk '/Mem/ { printf "%.2fGB\n", ($3 + $5)/1024}')"
