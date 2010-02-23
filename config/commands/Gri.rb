# Encoding: UTF-8

[{beforeRunningCommand: "saveActiveFile",
  command: 
   "# Run Gri, convert the PostScript to PDF, and then show the latter.\n# The code is patterned on that for the \"LaTeX and view\" command.\n# GPL 2005 Dan Kelley.\n# (I hope it's OK to GPL something in TM!)\n\n. \"${TM_SUPPORT_PATH}/lib/html.sh\"\n\n# The comment and line below are copied from the \"LaTeX and view\" command.\n# Get the viewer program. Any program (that works with open -a <name>) can be used,\n# except 'html' which is reserved to mean the internal HTML window. This is also the\n# default option.\nV=${TM_LATEX_VIEWER:=html}\n\nGRI=gri\nDIR=`dirname \"$TM_FILEPATH\"`\nFILE=`basename \"$TM_FILEPATH\"`\nPSFILE=`basename \"$FILE\" .gri`.ps\nPDFFILE=`basename \"$FILE\" .gri`.pdf\nCWD=\"`pwd`/\"\nTOPDF=\"epstopdf\"\n\n# Switch to the right directory.\ncd \"$TM_PROJECT_DIRECTORY\"\ncd \"$DIR\"\n\n# Prepare output window.\nhtmlHeader \"Running Gri on file ${FILE}\"\necho \"<h1>Running Gri on ${FILE}...</h1>\";\n\n# Function to close window if the error level is low enough.\nclose() {\n\tif (($RC == 0)); then closeWindow; fi\n}\n\n\n# Compile. Bail out on errors.\necho \"gri -output ${DIR}/${PSFILE} ${TM_FILEPATH}\";\necho \"<BR>\";\ngri -output \"${DIR}/${PSFILE}\" \"${TM_FILEPATH}\";\nRC=$?\nif (($RC != 0)); then exit; fi\necho \"${TOPDF} ${DIR}/$PSFILE ${DIR}/$PDFFILE\";\necho \"<BR>\";\n${TOPDF} \"${DIR}/$PSFILE\" > \"${DIR}/$PDFFILE\";\n\n# View...\nif [ \"$V\" == html ]; then\n\tif [ -s \"${PDFFILE}\" ]; then\n\t\tWEB_LOC=\"tm-file://${DIR}/${PDFFILE}\"\n\t\tif (($RC != 0)); then\n\t\t\tlink \"${WEB_LOC}\" 'Click Here to Preview'\n\t\telse\n\t\t\tredirect \"${WEB_LOC}\"\n\t\tfi\n\telse\n\t\tstrong \"Error: PDF file not written to disk\"\n\tfi\n\thtmlFooter\nelse\n\techo \"HUH?<br>\"\n\topen -a \"$V\" \"${DIR}/${PDFFILE}\"\n\tclose\nfi\n",
  input: "none",
  keyEquivalent: "@b",
  name: "Gri and View",
  output: "showAsHTML",
  scope: "source.gri",
  uuid: "41A8F343-48CB-482E-A395-34C31CE9A5AB"}]
