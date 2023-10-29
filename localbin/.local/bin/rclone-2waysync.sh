#!/bin/bash

#exit if already running
if [[ "`pidof -x $(basename $0) -o %PPID`" ]]; then exit; fi

#Make both directories identical without deleting anything
rclone copy mtfranczyk:Studia ~/Documents/Studia -u
rclone copy ~/Documents/Studia mtfranczyk:Studia -u