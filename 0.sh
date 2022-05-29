#!/bin/sh

echo magick sanitation:
convert "./in.png" "./sample.png"
stat -c "%n,%s" in.png sample.png | column -t -s,
echo Result: our sample is ready.
echo

echo img2pdf output:
img2pdf ./sample.png -o ./sample1.pdf
pdfimages -list ./sample1.pdf
pdfimages -all ./sample1.pdf ./sample1
echo size comparision:
stat -c "%n,%s" sample1*.* | column -t -s,
echo pixel-to-pixel comparision:
magick compare -metric AE sample.png sample1-000.png sample1-000-diff.png
echo
echo Result: img2pdf is lossless.
echo

echo pdfScale.sh output:
pdfScale.sh --print-gs-call -r "custom points 228 166" ./sample1.pdf ./sample2.pdf
pdfimages -list ./sample2.pdf
pdfimages -all ./sample2.pdf ./sample2
echo size comparision:
stat -c "%n,%s" sample2*.* | column -t -s,
echo pixel-to-pixel comparision:
magick compare -metric AE sample.png sample2-000.jpg sample2-000-diff.png
echo
echo Result: GhostScript \(via pdfScale.sh\) recompresses to jpeg and introduces artifacts.
echo

echo ghostscript output:
gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dSAFER -dCompatibilityLevel="1.5" -dPDFSETTINGS="/printer" -dColorImageResolution=300 -dGrayImageResolution=300 -dColorImageDownsampleType="/Bicubic" -dGrayImageDownsampleType="/Bicubic" -dColorConversionStrategy=/LeaveColorUnchanged -dSubsetFonts=true -dEmbedAllFonts=true -dDEVICEWIDTHPOINTS=228 -dDEVICEHEIGHTPOINTS=166 -dAutoRotatePages=/PageByPage -dFIXEDMEDIA -dPDFFitPage  -sOutputFile="./sample3.pdf" -c "" -f "./sample1.pdf"
pdfimages -list ./sample3.pdf
pdfimages -all ./sample3.pdf ./sample3
echo size comparision:
stat -c "%n,%s" sample3*.* | column -t -s,
echo pixel-to-pixel comparision:
magick compare -metric AE sample.png sample3-000.jpg sample3-000-diff.png
echo
echo Result: GhostScript \(alone\) introduces artifacts.
echo

echo pdfScale.py output:
./pdfScale.py -r "custom points 228 166" ./sample1.pdf ./sample4.pdf
pdfimages -list ./sample4.pdf
pdfimages -all ./sample4.pdf ./sample4
echo size comparision:
stat -c "%n,%s" sample4*.* | column -t -s,
echo pixel-to-pixel comparision:
magick compare -metric AE sample.png sample4-000.png sample4-000-diff.png
echo
echo Result: pdfScale.py is lossless.
echo
echo Conclusion: GhostScript is lossy and pdfScale.sh is affected.
