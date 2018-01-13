#!/bin/sh

echo Be careful
exit

./amalgamate.pl -v virtual-validity.pl -f virtual-packages.txt > virtual-data.txt
./amalgamate.pl -v real-validity.pl -f real-packages.txt > real-data.txt
