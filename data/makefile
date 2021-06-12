#!make

# Makefile for trip1/data
# @(#) $Id$
# 2021-06-11, Georg Fischer

all:
	
genicons: # generate the triangle icons
	perl gen_tricons.pl 
#----
deploy:
	scp 
#----
textfile: # generate the textfile for markers and their attributes
	perl GKconvert.pl BW.tsv \
	>        $@.txt
	head -n4 $@.txt
	wc -l    $@.txt
	grep Emmingen $@.txt
#----
exifpos: # DATE=
	exiftool -c '%.6f' -GPSPosition ../fotos/$(DATE)*.jpg
