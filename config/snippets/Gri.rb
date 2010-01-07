# Encoding: UTF-8

[{content: 
   "# `date`\n# ${1:$TM_FULLNAME}\n\n# Read columnar data (x,y,z), convert to a grid, then contour.\n\n# Data from figure 5 of Koch et al., 1983, J. Climate\n# Appl. Met., volume 22, pages 1487-1503.\nopen \"http://gri.sourceforge.net/gridoc/examples/example5.dat\"\nread columns x y z\nclose\nset x size 12\nset x axis 0 12 2\nset y size 10\nset y axis 0 10 2\nset y margin 15\ndraw axes\nset color rgb 0 0 .6 # dark blue\nset line width symbol 0.2\nset symbol size 0.2\ndraw symbol bullet\nset font size 8\ndraw values\nset color black\nset x grid 0 12 0.25\nset y grid 0 10 0.25\n\n# Uncomment one of the 'convert' lines below, to try\n# various gridding schemes.\nconvert columns to grid         # \"default\"\n#convert columns to grid objective                # As default\n#convert columns to grid objective -1.4 -1.4      # As default\n#convert columns to grid objective -1.4 -1.4 5 1  # As default\n#convert columns to grid objective -1.4 -1.4 5 -1 #  + fill grid\n#convert columns to grid objective -2   -2        # Average\n#convert columns to grid objective  2    2        #\n#convert columns to grid boxcar                   # Ugly\n#convert columns to grid boxcar -2 -2             # Still ugly\n\nset font size 12\ndraw contour 0 40 10 2\nset line width rapidograph 3\ndraw contour 0 40 10\nset color black\ndraw title \"N. Am. wind (Fig5 Koch et al, 1983)\"\n",
  name: "Contour",
  scope: "source.gri",
  tabTrigger: "con",
  uuid: "2046FFE7-A68E-4955-8FCA-C802F456792C"},
 {content: 
   "# `date`\n# ${1:$TM_FULLNAME}\n\nset x size 5\nset y size 5\nset y margin 20\nset x axis 0 1 0.25\nset y axis 0 20 10\nset font size 0\n\\\\background_color = \"hsb 0.6 0.2 1.0\"\n\\\\line_color =       \"red\"\n\\\\word_color =       \"rgb 0.0 0.1 0.6\"\n\nread columns x y\n0.0  12.5\n0.25 19  \n0.5  12  \n0.75 15  \n1    13  \n\ndraw axes none\nset color \\\\background_color\nset line width axis rapidograph 6\ndraw curve filled to ..ybottom.. y\nset color black\n#draw axes frame\n\nset color \\\\line_color\nset line width 10\ndraw curve\n\nset color \\\\word_color\nset font size 100\nset font to Helvetica\ndraw label \"Gri\" at 0.05 1.3\n",
  name: "Icon",
  scope: "source.gri",
  tabTrigger: "icon",
  uuid: "68248C77-9EB9-4B05-BEA6-162719D55AE0"}]
