# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "#!/bin/bash\n\nTPROLOG=${TM_PROLOG:-gprolog}\n\nesc () {\nSTR=\"$1\" ruby <<\"RUBY\"\n   str = ENV['STR']\n   str = str.gsub(/'/, \"'\\\\\\\\''\")\n   str = str.gsub(/[\\\\\"]/, '\\\\\\\\\\\\0')\n   print \"'\#{str}'\"\nRUBY\n}\n\nosascript <<- APPLESCRIPT\ntell application \"Terminal\"\n\tlaunch\n\tactivate\n\tdo script \"clear; cd $(esc \"${TM_DIRECTORY}\"); ${TPROLOG} --entry-goal \\\"consult('${TM_FILEPATH}')\\\"\"\n\tset position of first window to {100, 100}\nend tell\nAPPLESCRIPT\n\n\n",
  input: "none",
  keyEquivalent: "@r",
  name: "Run",
  output: "discard",
  scope: "source.prolog",
  uuid: "38D17DB7-C0D3-4C05-BD10-A7F78D67DF03"}]
