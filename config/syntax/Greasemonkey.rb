# Encoding: UTF-8

{fileTypes: ["user.js"],
 firstLineMatch: "// ==UserScript==",
 foldingStartMarker: /\/\/ ==UserScript==/,
 foldingStopMarker: /\/\/ ==\/UserScript==/,
 keyEquivalent: "^~G",
 name: "Greasemonkey",
 patterns: 
  [{match: /\bunsafeWindow\b/, name: "support.class.greasemonkey"},
   {match: 
     /\bGM_(?<_1>registerMenuCommand|xmlhttpRequest|setValue|getValue|log|openInTab|addStyle)\b(?=\()/,
    name: "support.function.greasemonkey"},
   {begin: /\/\/ ==UserScript==/,
    end: "// ==/UserScript==\\s*",
    name: "meta.header.greasemonkey",
    patterns: 
     [{captures: 
        {1 => {name: "keyword.other.greasemonkey"},
         3 => {name: "string.unquoted.greasemonkey"}},
       match: 
        /\/\/ (?<_1>@(?<_2>name|namespace|description|include|exclude))\b\s*(?<_3>.+\s+)?/,
       name: "meta.directive.standard.greasemonkey"},
      {captures: 
        {1 => {name: "keyword.other.greasemonkey"},
         3 => {name: "string.unquoted.greasemonkey"}},
       match: /\/\/ (?<_1>@(?<_2>\S+))\b\s*(?<_3>.+\s+)?/,
       name: "meta.directive.nonstandard.greasemonkey"}]},
   {include: "source.js"}],
 scopeName: "source.js.greasemonkey",
 uuid: "B57ED36B-65DD-492A-82D7-E6C80253BAAB"}
