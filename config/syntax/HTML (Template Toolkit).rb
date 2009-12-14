# Encoding: UTF-8

{fileTypes: ["tt"],
 firstLineMatch: "\\[%.+?%\\]",
 foldingStartMarker: 
  /(<(?i:(head|table|tr|div|style|script|ul|ol|form|dl))\b.*?>|^ *\[%[^%]*\b(?:FOR|WRAPPER|SWITCH|FOREACH|IF|UNLESS|BLOCK|MACRO|FILTER|PERL|TRY)\b(?!.*END *%\]))/,
 foldingStopMarker: 
  /(<\/(?i:(head|table|tr|div|style|script|ul|ol|form|dl))>|^ *\[% *END *%\])/,
 keyEquivalent: /^~T/,
 name: "HTML (Template Toolkit)",
 patterns: 
  [{begin: /(?=\[% *(?:RAW)?PERL\b.*? *%\])/,
    contentName: "source.perl",
    end: "(\\[%) *(END) *(%\\])",
    endCaptures: 
     {0 => {name: "meta.tag.template.tt"},
      1 => {name: "punctuation.definition.tag.tt"},
      2 => {name: "entity.name.tag.tt"},
      3 => {name: "punctuation.definition.tag.tt"}},
    patterns: [{include: "#tmpl-container-tag"}, {include: "source.perl"}]},
   {include: "#tmpl-container-tag"},
   {include: "text.html.basic"}],
 repository: 
  {:"embedded-code" => {},
   entities: 
    {patterns: 
      [{captures: 
         {1 => {name: "punctuation.definition.constant.html"},
          3 => {name: "punctuation.definition.constant.html"}},
        match: /(&)([a-zA-Z0-9]+|#[0-9]+|#x[0-9a-fA-F]+)(;)/,
        name: "constant.character.entity.html"},
       {match: /&/, name: "invalid.illegal.bad-ampersand.html"}]},
   keyword: {match: /\b([A-Za-z0-9_]+)/, name: "string.unquoted.tt"},
   :"string-double-quoted" => 
    {begin: /"/,
     beginCaptures: {0 => {name: "punctuation.definition.string.begin.tt"}},
     end: "\"",
     endCaptures: {0 => {name: "punctuation.definition.string.end.tt"}},
     name: "string.quoted.double.tt",
     patterns: [{include: "#embedded-code"}, {include: "#entities"}]},
   :"string-single-quoted" => 
    {begin: /'/,
     beginCaptures: {0 => {name: "punctuation.definition.string.begin.tt"}},
     end: "'",
     endCaptures: {0 => {name: "punctuation.definition.string.end.tt"}},
     name: "string.quoted.single.tt",
     patterns: [{include: "#embedded-code"}, {include: "#entities"}]},
   :"tag-generic-attribute" => 
    {captures: {2 => {name: "punctuation.separator.key-value.tt"}},
     match: /\b([a-zA-Z_:-]+)\s*(=)/,
     name: "entity.other.attribute-name.tt"},
   :"tag-stuff" => 
    {patterns: 
      [{include: "#tag-generic-attribute"},
       {include: "#string-double-quoted"},
       {include: "#string-single-quoted"},
       {include: "#keyword"}]},
   :"tmpl-container-tag" => 
    {patterns: 
      [{begin: /\[%/,
        captures: {0 => {name: "punctuation.definition.tag.tt"}},
        end: "%\\]",
        name: "meta.tag.template.tt",
        patterns: [{include: "#tt-stuff"}]}]},
   :"tt-stuff" => 
    {patterns: 
      [{captures: {1 => {name: "punctuation.definition.comment.tt"}},
        match: /(#).*?(?=%\])/,
        name: "comment.line.number-sign.tt"},
       {captures: 
         {1 => {name: "string.quoted.double.filename.tt"},
          2 => {name: "punctuation.definition.string.begin.tt"},
          4 => {name: "punctuation.definition.string.begin.tt"},
          5 => {name: "string.unquoted.other.filename.tt"}},
        match: 
         /((")([a-z][a-z0-9_]+\/)+[a-z0-9_\.]+("))|(\b([a-z][a-z0-9_]+\/)+[a-z0-9_\.]+\b)/},
       {include: "#string-double-quoted"},
       {include: "#string-single-quoted"},
       {captures: {1 => {name: "punctuation.definition.variable.tt"}},
        match: /(\$?)\b[a-z]([a-z0-9_]\.?)*\b/,
        name: "variable.other.tt"},
       {match: 
         /\b(?:IF|END|BLOCK|INCLUDE|ELSE|ELSIF|SWITCH|CASE|UNLESS|WRAPPER|FOR|FOREACH|LAST|NEXT|USE|WHILE|FILTER|IN|GET|CALL|SET|INSERT|MACRO|PERL|TRY|CATCH|THROW|FINAL|STOP|META|DEBUG|RAWPERL)\b/,
        name: "keyword.control.tt"},
       {match: /\||\|\||=|_|-|\*|\/|\?|:|div|mod|;|\+/,
        name: "keyword.operator.tt"}]}},
 scopeName: "text.html.tt",
 uuid: "67D0DEC7-9E8C-44B3-8FA5-ADD9BBA05DE3"}
