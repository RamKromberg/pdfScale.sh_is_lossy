#!/bin/sh
convert "./in.png" "./sample.png"
stat -c "%n,%s" sample.png | column -t -s,
img2pdf ./sample.png -o ./sample1.pdf
pdfimages -list ./sample1.pdf
pdfimages -all ./sample1.pdf ./sample1
stat -c "%n,%s" sample1*.* | column -t -s,

pdfScale.sh -r "custom points 228 166" ./sample1.pdf ./sample2.pdf
pdfimages -list ./sample2.pdf
pdfimages -all ./sample2.pdf ./sample2
stat -c "%n,%s" sample2*.* | column -t -s,

./pdfScale.py -r "custom points 228 166" ./sample1.pdf ./sample3.pdf
pdfimages -list ./sample3.pdf
pdfimages -all ./sample3.pdf ./sample3
stat -c "%n,%s" sample3*.* | column -t -s,
