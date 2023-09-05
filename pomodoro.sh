#!/bin/sh

# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
# http://www.wtfpl.net/ for more details.

title="Pomodoro"
start_working_text="Start working!"
focus=1500
focus_text="Focus on working, please!"
short_break=300
short_break_text="Short break."
long_break=1500
long_break_text="Long break."
cancel_text="Cancelled."
counter=0

countdown () {
    (
    remain=$length
    while [ $remain -ge 0 ]; do
        echo $((($length - $remain) * 100 / $length))
        echo "# "$text"\n\nRemaining time: "$(($remain / 60))"min"$(($remain % 60))"s"
        remain=$(($remain - 1))
        sleep 1
    done
    ) |
    zenity --progress --title="$title $counter" --percentage=0 --auto-close
    if [ "$?" = 1 ] ; then
        zenity --error --title="$title" --text="$cancel_text"
        exit
    fi
}

focus () {
    zenity --warning --title="$title" --text="$start_working_text"
    length=$focus
    text="$focus_text"
    countdown
}

short_break () {
    length=$short_break
    text="$short_break_text"
    countdown
}

long_break () {
    length=$long_break
    text="$long_break_text"
    countdown
}

while true; do
    counter=$(($counter + 1))
    focus
    short_break
    counter=$(($counter + 1))
    focus
    short_break
    counter=$(($counter + 1))
    focus
    short_break
    counter=$(($counter + 1))
    focus
    long_break
done
