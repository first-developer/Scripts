#! /bin/bash


for line in `cat fonts.txt`
	echo "`cut -f1 -d\	 $line`" >> fts.txt
done