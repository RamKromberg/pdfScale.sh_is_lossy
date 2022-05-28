A small test example showing ghostscript recompresses some pngs into jpegs rendering pdfScale.sh's output lossy.

The issue is disscussed here [here](https://github.com/tavinus/pdfScale/issues/27).

Dependencies:
* img2pdf
* python + pymupdf
* pdfScale.sh (ghostscript)
* imagemagick
* pdfimages

Starting with in.png:

![in.png](in.png?raw=true "in.png")

We santifize with imagemagick into sample.png:

![sample.png](sample.png?raw=true "sample.png")

We convert to pdf with img2pdf and, dump using pdfimages and compare with magick:

![sample1.pdf](sample1.pdf?raw=true "sample1.pdf")

![sample1-000.png](sample1-000.png?raw=true "sample1-000.png")

![sample1-000-diff.png](sample1-000-diff.png?raw=true "sample1-000-diff.png")

Result: img2pdf is lossless.

Same with pdfScale.sh:

![sample2.pdf](sample2.pdf?raw=true "sample2.pdf")

![sample2-000.jpg](sample2-000.jpg?raw=true "sample2-000.jpg")

![sample2-000-diff.png](sample2-000-diff.png?raw=true "sample2-000-diff.png")

Result: GhostScript (via pdfScale.sh) recompresses to jpeg and introduces artifacts.

Now just with GhostScript:

![sample3.pdf](sample3.pdf?raw=true "sample3.pdf")

![sample3-000.jpg](sample3-000.jpg?raw=true "sample3-000.jpg")

![sample3-000-diff.png](sample3-000-diff.png?raw=true "sample3-000-diff.png")

Result: GhostScript (alone) introduces artifacts.

Finally, with pdfScale.py:

![sample4.pdf](sample4.pdf?raw=true "sample4.pdf")

![sample4-000.png](sample4-000.png?raw=true "sample4-000.png")

![sample4-000-diff.png](sample4-000-diff.png?raw=true "sample4-000-diff.png")

Result: pdfScale.py is lossless.

Conclusion: GhostScript is lossy and pdfScale.sh is affected.

