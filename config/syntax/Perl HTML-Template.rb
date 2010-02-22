# Encoding: UTF-8

{fileTypes: ["tmpl"],
 firstLineMatch: "<(?i:TMPL)_.+?>",
 foldingStartMarker: 
  /(?<_1><(?i:(?<_2>head|table|tr|div|style|script|ul|ol|form|dl))\b.*?>|^ *<(?i:TMPL_(?:LOOP|UNLESS|IF))\b(?!.*<\/(?i:TMPL_(?:LOOP|UNLESS|IF))>))/,
 foldingStopMarker: 
  /(?<_1><\/(?i:(?<_2>head|table|tr|div|style|script|ul|ol|form|dl))>|^ *<\/(?i:TMPL_(?:LOOP|UNLESS|IF)) *>)/,
 keyEquivalent: "^~H",
 name: "Perl HTML-Template",
 patterns: [{include: "#tmpl-container-tag"}, {include: "text.html.basic"}],
 repository: 
  {:"embedded-code" => {},
   entities: 
    {patterns: 
      [{captures: 
         {1 => {name: "punctuation.definition.constant.html"},
          3 => {name: "punctuation.definition.constant.html"}},
        match: /(?<_1>&)(?<_2>[a-zA-Z0-9]+|#[0-9]+|#x[0-9a-fA-F]+)(?<_3>;)/,
        name: "constant.character.entity.html"},
       {match: /&/, name: "invalid.illegal.bad-ampersand.html"}]},
   :"html-template-stuff" => 
    {patterns: 
      [{match: /\b(?i:NAME|ESCAPE|DEFAULT|)\b/,
        name: "keyword.control.html-template"},
       {match: /=/, name: "punctuation.separator.key-value.html-template"},
       {include: "#string-double-quoted"},
       {include: "#string-single-quoted"},
       {include: "#keyword"}]},
   keyword: 
    {match: /\b(?<_1>[A-Za-z0-9_]+)/, name: "string.unquoted.html-template"},
   :"string-double-quoted" => 
    {begin: /"/,
     beginCaptures: 
      {0 => {name: "punctuation.definition.string.begin.html-template"}},
     end: "\"",
     endCaptures: 
      {0 => {name: "punctuation.definition.string.end.html-template"}},
     name: "string.quoted.double.html-template",
     patterns: [{include: "#embedded-code"}, {include: "#entities"}]},
   :"string-single-quoted" => 
    {begin: /'/,
     beginCaptures: 
      {0 => {name: "punctuation.definition.string.begin.html-template"}},
     end: "'",
     endCaptures: 
      {0 => {name: "punctuation.definition.string.end.html-template"}},
     name: "string.quoted.single.html-template",
     patterns: [{include: "#embedded-code"}, {include: "#entities"}]},
   :"tmpl-container-tag" => 
    {patterns: 
      [{begin: /<\/?(?i:TMPL_(?:IF|UNLESS|ELSE|VAR|INCLUDE|LOOP))/,
        captures: {0 => {name: "punctuation.definition.tag.html-template"}},
        end: ">",
        name: "meta.tag.template.html-template",
        patterns: [{include: "#html-template-stuff"}]},
       {begin: /<\/?(?i:TMPL_(?!IF|UNLESS|ELSE|VAR|INCLUDE|LOOP))/,
        end: ">",
        name: "invalid.illegal.tag.template.html-template"}]}},
 scopeName: "text.html.html-template",
 uuid: "79287EAC-597A-480D-974C-837440298571"}
