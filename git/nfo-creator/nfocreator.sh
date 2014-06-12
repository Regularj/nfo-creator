#!/bin/bash

concert(){
   # verarbeitet nach dem Schema "./künstler/[JJJJ-MM-TT] konzertvenue, stadt"
  echo "Gefunden: $@"
  band=`echo $folder | cut -d'/' -f2`           # Suchen Band anhand Ordnernamen
  concert=`echo $folder | cut -d'/' -f3`        # Bereiten Konzertinfos vor
  concert_date=`echo $concert | cut -d' ' -f1`  # Datum
  concert_name=`echo $concert | cut -d' ' -f2 | cut -d',' -f1`  # Konzertname
  concert_location=`echo $concert | cut -d',' -f2`  # Ort
  echo "Band: " $band
  echo "Datum: " $concert_date
  echo "Name: " $concert_name
  echo "Ort: " $concert_location
}

#songname(){
#  searchFolder="$@"
#  song=`find "$searchFolder" -iname "*.avi"`
#  songbase=$(basename "$song")
#  songname="${songbase%.*}"
#  echo "Name des Songs:"
#  echo $songname
#}

find . -path "*[*" -type d  | while read folder; do # schon angepasst!
        concert $folder
        songname $folder
        # song_name=`echo $song_name | sed 's/.avi//'` # vergeben. Frage ist nur, wie.
        # new_file_name=`echo $file_name | sed 's/.avi/.nfo/'` # Make new filename
        # echo "Making $new_file_name..."
        # echo -en "<musicvideo>\n<title>$song_name</title>\n<artist>$band_name</artist>\n</musicvideo>\n" > "$new_file_name"
done
