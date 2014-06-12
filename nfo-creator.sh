#!/bin/bash

find . -path "*[????-??-??]*" | while read folder; do # schon angepasst!
        band_name=`echo $file_name | sed 's/ *-.*$//'` # Hier soll er anhand
        band_name=`echo $band_name | sed 's/^.*\///'`  # der Ordnernamen die Variablen
        song_name=`echo $file_name | sed 's/^.*- *//'` # wie Ort, Stadt, Künstler, Datum
        song_name=`echo $song_name | sed 's/.avi//'` # vergeben. Frage ist nur, wie.
        new_file_name=`echo $file_name | sed 's/.avi/.nfo/'` # Make new filename
        echo "Making $new_file_name..."
        echo -en "<musicvideo>\n<title>$song_name</title>\n<artist>$band_name</artist>\n</musicvideo>\n" > "$new_file_name"
done
