# Encoding: UTF-8

{fileTypes: ["sce", "sci", "tst", "dem"],
 foldingStartMarker: /^(?!.*\/\/.*).*\b(if|while|for|function|select)\b/,
 foldingStopMarker: /\b(endfunction|end)\b/,
 name: "Scilab",
 patterns: 
  [{begin: /\/\//, end: "$\\n?", name: "comment.line.double-slash.scilab"},
   {match: /\b(([0-9]+\.?[0-9]*)|(\.[0-9]+))((e|E)(\+|-)?[0-9]+)?\b/,
    name: "constant.numeric.scilab"},
   {match: /(%inf|%i|%pi|%eps|%e|%nan|%s|%t|%f)\b/,
    name: "support.constant.scilab"},
   {begin: /"/,
    end: "\"(?!\")",
    name: "string.quoted.double.scilab",
    patterns: [{match: /''|""/, name: "constant.character.escape.scilab"}]},
   {begin: /(?<![\w\]\)])'/,
    end: "'(?!')",
    name: "string.quoted.single.scilab",
    patterns: [{match: /''|""/, name: "constant.character.escape.scilab"}]},
   {captures: 
     {1 => {name: "keyword.control.scilab"},
      2 => {name: "entity.name.function.scilab"}},
    match: /\b(function)\s+(?:[^=]+=\s*)?(\w+)(?:\s*\(.*\))?/},
   {match: 
     /\b(if|then|else|elseif|while|for|function|end|endfunction|return|select|case|break|global)\b/,
    name: "keyword.control.scilab"},
   {match: /\.\.\.\s*$/, name: "punctuation.separator.continuation.scilab"}],
 scopeName: "source.scilab",
 uuid: "14374AA3-A329-4623-8DFA-1ACC2CE222B9"}
