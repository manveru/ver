# Encoding: UTF-8

{"ec" => 
  {scope: "source.actionscript.2",
   name: "#endinitclip",
   content: "#endinitclip"},
 "in" => 
  {scope: "source.actionscript.2",
   name: "#include",
   content: "#include \"$1\""},
 "ic" => 
  {scope: "source.actionscript.2", name: "#initclip", content: "#initclip"},
 "mc" => 
  {scope: "source.actionscript.2", name: "MovieClip", content: "MovieClip"},
 "br" => {scope: "source.actionscript.2", name: "break", content: "break;"},
 "ca" => 
  {scope: "source.actionscript.2", name: "call", content: "call(${1:frame});"},
 "ce" => 
  {scope: "source.actionscript.2",
   name: "case",
   content: "case ${1:expression} :\n\t${1:statement}"},
 "ch" => 
  {scope: "source.actionscript.2",
   name: "catch",
   content: "catch ($1) {\n\t$2\n}"},
 "co" => 
  {scope: "source.actionscript.2", name: "continue", content: "continue;"},
 "dt" => 
  {scope: "source.actionscript.2",
   name: "default",
   content: "default :\n\t${1:statement}"},
 "de" => 
  {scope: "source.actionscript.2", name: "delete", content: "delete $1;"},
 "do" => 
  {scope: "source.actionscript.2",
   name: "do while",
   content: "do {\n\t$1\n} while (${2:condition});"},
 "dm" => 
  {scope: "source.actionscript.2",
   name: "duplicateMovieClip",
   content: "duplicateMovieClip(${1:target}, ${2:newName}, ${3:depth});"},
 "ei" => 
  {scope: "source.actionscript.2",
   name: "else if",
   content: "else if ($1) {\n\t$2\n}"},
 "fy" => 
  {scope: "source.actionscript.2",
   name: "finally",
   content: "finally {\n\t$1\n}\n"},
 "fi" => 
  {scope: "source.actionscript.2",
   name: "for in",
   content: "for ( var $1 in $2 ){\n\t$3\n};"},
 "fr" => 
  {scope: "source.actionscript.2",
   name: "for",
   content: "for ( var $1=0; $1<$3.length; $1++ ) {\n\t$4\n};"},
 "fs" => 
  {scope: "source.actionscript.2",
   name: "fscommand",
   content: "fscommand(${1:command}, ${2:paramaters});"},
 "fn" => 
  {scope: "source.actionscript.2",
   name: "function",
   content: "function $1($2):$3{\n\t$4\n};"},
 "gu" => 
  {scope: "source.actionscript.2", name: "getURL", content: "getURL($1);"},
 "gp" => 
  {scope: "source.actionscript.2",
   name: "gotoAndPlay",
   content: "gotoAndPlay($1);"},
 "gs" => 
  {scope: "source.actionscript.2",
   name: "gotoAndStop",
   content: "gotoAndStop($1);"},
 "if" => 
  {scope: "source.actionscript.2", name: "if", content: "if ($1) {\n\t$2\n}"},
 "il" => 
  {scope: "source.actionscript.2",
   name: "ifFrameLoaded",
   content: "ifFrameLoaded ($1) {\n\t$2\n}"},
 "ip" => 
  {scope: "source.actionscript.2", name: "import", content: "import $1;"},
 "it" => 
  {scope: "source.actionscript.2",
   name: "interface",
   content: "interface $1 {\n\t$2\n}"},
 "lm" => 
  {scope: "source.actionscript.2",
   name: "loadMovie",
   content: "loadMovie( ${1:url}, ${2:target}, ${3:method});\n"},
 "ln" => 
  {scope: "source.actionscript.2",
   name: "loadMovieNum",
   content: "loadMovieNum( ${1:url}, ${2:level}, ${3:method});\n"},
 "lv" => 
  {scope: "source.actionscript.2",
   name: "loadVariables",
   content: "loadVariables( ${1:url}, ${2:target}, ${3:method});"},
 "vn" => 
  {scope: "source.actionscript.2",
   name: "loadVariablesNum",
   content: "loadVariables( ${1:url}, ${2:level}, ${3:method});"},
 "nf" => 
  {scope: "source.actionscript.2",
   name: "nextFrame",
   content: "nextFrame();\n"},
 "ns" => 
  {scope: "source.actionscript.2", name: "nextScene", content: "nextScene();"},
 "on" => 
  {scope: "source.actionscript.2",
   name: "on",
   content: "on ($1) {\n\t$2\n};\n"},
 "oc" => 
  {scope: "source.actionscript.2",
   name: "onClipEvent",
   content: "onClipEvent ($1) {\n\t$2\n};"},
 "pl" => {scope: "source.actionscript.2", name: "play", content: "play();"},
 "pf" => 
  {scope: "source.actionscript.2", name: "prevFrame", content: "prevFrame();"},
 "ps" => 
  {scope: "source.actionscript.2",
   name: "prevScene",
   content: "prevScene();\n"},
 "pr" => 
  {scope: "source.actionscript.2",
   name: "print",
   content: "print( ${1:target}, ${2:type} );"},
 "pb" => 
  {scope: "source.actionscript.2",
   name: "printAsBitmap",
   content: "printAsBitmap( ${1:target}, ${2:type} );"},
 "bn" => 
  {scope: "source.actionscript.2",
   name: "printAsBitmapNum",
   content: "printAsBitmapNum( ${1:level}, ${2:type} );"},
 "pn" => 
  {scope: "source.actionscript.2",
   name: "printNum",
   content: "printNum( ${1:level}, ${2:type} );"},
 "rm" => 
  {scope: "source.actionscript.2",
   name: "removeMovieClip",
   content: "removeMovieClip( ${1:target} );"},
 "rt" => 
  {scope: "source.actionscript.2", name: "return", content: "return $1;"},
 "sp" => 
  {scope: "source.actionscript.2",
   name: "setProperty",
   content: "setProperty( ${1:target}, ${2:property}, ${3:value} );"},
 "sv" => 
  {scope: "source.actionscript.2",
   name: "setVariable",
   content: "set( ${1:name}, ${2:value} );"},
 "dr" => 
  {scope: "source.actionscript.2",
   name: "startDrag",
   content: 
    "startDrag(${1:target}, ${2:lockcenter}, ${3:l}, ${4:t}, ${5:r}, ${6:b} );"},
 "st" => {scope: "source.actionscript.2", name: "stop", content: "stop();"},
 "ss" => 
  {scope: "source.actionscript.2",
   name: "stopAllSounds",
   content: "stopAllSounds();"},
 "sd" => 
  {scope: "source.actionscript.2", name: "stopDrag", content: "stopDrag();"},
 "sw" => 
  {scope: "source.actionscript.2",
   name: "switch",
   content: "switch ( ${1:condition} ) {\n\t$2\n}"},
 "tt" => 
  {scope: "source.actionscript.2",
   name: "tellTarget",
   content: "tellTarget( ${1:target} ) {\n\t$2\n}"},
 "th" => {scope: "source.actionscript.2", name: "throw", content: "throw $1;"},
 "tq" => 
  {scope: "source.actionscript.2",
   name: "toggleHighQuality",
   content: "toggleHighQuality();"},
 "tr" => 
  {scope: "source.actionscript.2",
   name: "trace",
   content: "trace(${1:\"$0\"});"},
 "ty" => 
  {scope: "source.actionscript.2", name: "try", content: "try {\n\t$1\n};"},
 "um" => 
  {scope: "source.actionscript.2",
   name: "unloadMovie",
   content: "unloadMovie(${1:target});"},
 "un" => 
  {scope: "source.actionscript.2",
   name: "unloadMovieNum",
   content: "unloadMovieNum(${1:level});"},
 "vr" => {scope: "source.actionscript.2", name: "var", content: "var $1:$2;"},
 "wh" => 
  {scope: "source.actionscript.2",
   name: "while",
   content: "while (${1:condition}) {\n\t$2\n};"},
 "wt" => 
  {scope: "source.actionscript.2",
   name: "with",
   content: "with (${1:target});\n\t$2\n};"},
 "class" => 
  {scope: "source.actionscript.2",
   name: "class",
   content: 
    "class ${1:ClassName} {\n\tvar _${2/\\u/_/g};\n\tfunction $1($2){\n\t\t_${2/:(.*)//g} = ${2/:(.*)//g};$0\n\t}\n}"}}
