# Encoding: UTF-8

[{beforeRunningCommand: "saveActiveFile",
  command: 
   "# To install ANTLR via MacPorts\n# 1. sudo port install antlr\n# 2. set TM_ANTLR to -classpath /opt/local/lib/antlr.jar antlr/Tool\n\nTM_JAVA=$(type -p \"${TM_JAVA:-java}\")\nTM_ANTLR=\"${TM_ANTLR:-org.antlr.Tool}\"\n\ncd \"$TM_DIRECTORY\"\n\n# for this to work you need to set CLASSPATH to\n# include antlr v3, v2, and StringTemplate jars\n# or set TM_ANTLR to include a proper -classpath\n\"$TM_JAVA\" $TM_ANTLR \"$TM_FILENAME\"\n",
  input: "none",
  keyEquivalent: "@b",
  name: "Build",
  output: "showAsTooltip",
  scope: "source.antlr, source.antlr source.java",
  uuid: "EA5073FF-4ABB-44FA-95E3-6CB4B8818106"}]
