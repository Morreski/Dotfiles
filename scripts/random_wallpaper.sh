#!/bin/bash

wallpapers_dir="/home/enguerrand/Pictures/wallpapers"

cd $wallpapers_dir

if [ -a "./current_wallpaper.txt" ]
then
    current_wallpaper=$(cat ./current_wallpaper.txt)
fi

next_wallpaper="$(ls | grep -v ${current_wallpaper:-current_wallpaper.txt} | grep -v "current_wallpaper.txt" | sort -R | head -n 1)"
echo "USING file://$wallpapers_dir/$next_wallpaper"


gsettings set org.gnome.desktop.background picture-uri "file://${wallpapers_dir}/${next_wallpaper}"
echo "$next_wallpaper" > "./current_wallpaper.txt"
