#!/usr/bin/env python
'''
reimplement pdfScale.sh -r custom points in python
--------------------------------------------------
License: free
(c) 2022
Usage
------
python pdfScale.py -r "custom points %x %y" input.pdf output.pdf
Result
-------
A file "output.pdf" that was scaled to the desired x & y.
Notes
-----
(1) QnD workaround https://github.com/tavinus/pdfScale/issues/27

Dependencies
-------------
PyMuPDF
'''
from __future__ import print_function
import fitz, sys

#TODO: insert some argv santiy checks here

width, height = map(int, sys.argv[2].split(" ")[2:4])
infile = sys.argv[3]
outfile = sys.argv[4]

src = fitz.open(infile)
doc = fitz.open()

r = fitz.Rect(0, 0, width, height)

for spage in src:
	page = doc.new_page(-1, width = width, height = height)
	page.show_pdf_page(r, src, spage.number)

doc.save(outfile, garbage = 4, deflate = True)
