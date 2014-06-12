#!/usr/bin/env python

import os
import os.path
import re
import sys


def handle_concert(dirname, artist, date, venue, city):
    """Create a NFO file in the directory."""

    # the {} are replaced by each argument in turn, like printf()
    # Using a triple quote is a lot like a here document in shell, i.e.
    # cat <EOF
    # foo
    # EOF
    nfo_data = """<musicvideo>
<venue>{}</venue>
<city>{}</city>
<date>{}</date>
<artist>{}</artist>
</musicvideo>
""".format(venue, city, date, artist)

    # create a file called 'nfo' in the directory. Fix this to be
    # whatever you want it to be.
    # when the with statement is done the file is closed and fully
    # written.
    with open(os.path.join(dirname, "nfo"), "w") as fp:
        fp.write(nfo_data)


# This is a regular expression which matches:
# */FOO/[YYYY-MM-DD] VENUE, CITY
# Where possible, white space is left intact
concert_re = re.compile(r'.*/(?P<artist>.+)/\[(?P<date>\d{4}-\d{2}-\d{2})\]\s+(?P<venue>.+),\s+(?P<city>.+)')

def handle_artist(dirname):
    """Found an ARTIST directory. Look for concerts.
    If a subdirectory is found, see if it matches a concert.
    When a concert is found, handle it.
    """
    for i in os.listdir(dirname):
        subdir = os.path.join(dirname, i)
        m = concert_re.match(subdir)
        if m:
            print subdir  # to watch the progress
            handle_concert(subdir, m.group("artist"), m.group("date"),
                           m.group("venue"), m.group("city"))


def walk_collection(start_dir):
    """Examine contents of start_dir.
    If a directory is found, assume it is an ARTIST.
    """
    for i in os.listdir(start_dir):
        # os.path.join ensures paths are right regardless of OS
        dirname = os.path.join(start_dir, i)
        if os.path.isdir(dirname):
            print dirname  # to watch the progress
            handle_artist(dirname)

if __name__ == "__main__":
    collection_dir = sys.argv[1]  # equiv of $1

    walk_collection(collection_dir)
