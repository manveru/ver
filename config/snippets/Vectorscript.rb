# Encoding: UTF-8

{"proc" => 
  {scope: "source.pascal",
   name: "Procedure (proc)",
   content: 
    "PROCEDURE ${1:Name}${2:(${3:arg1:STRING})};\n\tBEGIN\n\t\t$4\nEND; { PROCEDURE $1 }\n$5"},
 "func" => 
  {scope: "source.pascal",
   name: "Function (func)",
   content: 
    "FUNCTION ${1:Name}${3:(${2:arg1:STRING})}:${4:BOOLEAN};\n\tBEGIN\n\t\t$5\n  \t\t$1 := ;\nEND;$6 { FUNCTION $1 }"},
 "beg" => 
  {scope: "source.pascal.vectorscript",
   name: "Begin..End (beg)",
   content: "BEGIN\n\t$1\nEND;$2"},
 "setr" => 
  {scope: "source.pascal.vectorscript",
   name: "SetRField.. (setr)",
   content: "SetRField(gObjectName,gObjectHd,'$1',$2)$0"},
 "getcus" => 
  {scope: "source.pascal.vectorscript",
   name: "GetCustomObjectInfo (getcus)",
   content: "GetCustomObjectInfo(gObjectName,gObjectHd,gRecHd,gWallHd)"},
 "for" => 
  {scope: "source.pascal",
   name: "For (for)",
   content: "FOR ${1:i} := ${2:1} TO ${3:n} DO BEGIN\n\t$4\nEND; { FOR }"},
 "group" => 
  {scope: "source.pascal",
   name: "BeginGroup..EndGroup (group)",
   content: "BeginGroup;\n$1\nEndGroup;$2"},
 "if" => 
  {scope: "source.pascal",
   name: "If..Then (if)",
   content: "IF ($1) THEN ${3:BEGIN\n\t$2\nEND}; { IF }"},
 "push" => 
  {scope: "source.pascal",
   name: "PushAttrs..PopAttrs (push)",
   content: "PushAttrs;\n$1\nPopAttrs;$2"}}
