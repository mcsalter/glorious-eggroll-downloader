# Glorious Eggroll Downloader
A simple downloader script for glorious eggroll's proton variants.

This stores information about the downloaded versions in a file named `glorious-data.txt`, currently it is set to look for that in the home directory. It should be created automatically but may be a good idea to make it manually to be safe.

## Usage:
The downloader requires input options to tell it what to do, otherwise it quits without doing anything.

`-a` is the tag to download both proton and wine builds.

`-w` tells the downloader to pull only the wine build.

`-p` tells the downloader to pull only the proton build.

`-t [tag name]` tells the downloader which tag to download from github. 
Used in conjunction with `-w` or `-p`, currently it will not work with `-a`.

`-h` a basic help screen.
