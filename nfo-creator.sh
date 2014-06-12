#!/bin/bash

find . -path "*[????-??-??]*" | while read folder; do
        band_name=`echo $file_name | sed 's/ *-.*$//'` # Get rid of song name
        band_name=`echo $band_name | sed 's/^.*\///'`  # Get rid of file path
        song_name=`echo $file_name | sed 's/^.*- *//'` # Get rid of band name
        song_name=`echo $song_name | sed 's/.avi//'` # Get rid of file extension
        new_file_name=`echo $file_name | sed 's/.avi/.nfo/'` # Make new filename
        echo "Making $new_file_name..."
        echo -en "<musicvideo>\n<title>$song_name</title>\n<artist>$band_name</artist>\n</musicvideo>\n" > "$new_file_name"
done
