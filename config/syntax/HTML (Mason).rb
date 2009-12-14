# Encoding: UTF-8

{fileTypes: ["mhtml", "autohandler", "dhandler", "md", "mc"],
 foldingStartMarker: 
  /(<(?i:(head|table|div|style|script|ul|ol|form|dl))\b.*?>|\{)/,
 foldingStopMarker: 
  /(<\/(?i:(head|table|div|style|script|ul|ol|form|dl))>|\})/,
 name: "HTML (Mason)",
 patterns: 
  [{begin: 
     /(<%(perl|attr|global|once|init|cleanup|requestlocal|requestonce|shared|threadlocal|threadonce|flags)( scope.*?)?>)/,
    captures: 
     {1 => {name: "punctuation.section.embedded.perl.mason"},
      2 => {name: "keyword.control"}},
    end: "(</%(\\2)>)(\\s*$\\n)?",
    name: "source.perl.mason.block",
    patterns: [{include: "source.perl"}]},
   {begin: /(<(%text)>)/,
    captures: {1 => {name: "keyword.control"}, 2 => {name: "variable.other"}},
    end: "(</(%text)>)",
    name: "source.perl.mason.doc",
    patterns: 
     [{begin: /(?<=<%text>)/, end: "(?=</%text>)", name: "comment.block"}]},
   {begin: /(<(%doc)>)/,
    captures: {1 => {name: "keyword.control"}, 2 => {name: "variable.other"}},
    end: "(</(%doc)>)",
    name: "source.perl.mason.doc",
    patterns: 
     [{begin: /(?<=<%doc>)/, end: "(?=</%doc>)", name: "comment.block"}]},
   {begin: /^(%)/,
    beginCaptures: {1 => {name: "punctuation.section.embedded.perl.mason"}},
    end: "$\\n?",
    name: "source.perl.mason.line",
    patterns: [{include: "source.perl"}]},
   {begin: /(<&\|)((\w|\.|\:)*)(?!&>)/,
    beginCaptures: 
     {1 => {name: "keyword.control"}, 2 => {name: "entity.name.function"}},
    end: "(</&>)",
    endCaptures: {1 => {name: "keyword.control"}},
    name: "source.mason.component.block",
    patterns: 
     [{begin: /(&>)/,
       beginCaptures: {1 => {name: "keyword.control"}},
       end: "(?=</&>)",
       name: "source.mason.nesty",
       patterns: [{include: "$self"}]}]},
   {begin: /(<&)(.{1,}?)( |,)+/,
    beginCaptures: 
     {1 => {name: "keyword.control"}, 2 => {name: "entity.name.function"}},
    end: "(&>)",
    endCaptures: {1 => {name: "keyword.control"}},
    name: "source.mason.component",
    patterns: [{include: "source.perl"}]},
   {begin: /(<%(args.*?)>)/,
    captures: {1 => {name: "keyword.control"}, 2 => {name: "variable.other"}},
    end: "(</%(\\2)>)",
    name: "source.mason.args",
    patterns: 
     [{captures: {2 => {name: "string.quoted.single"}},
       include: "source.perl",
       match: /(\s*)?(\w*)/}]},
   {begin: /(<%(method|def|closure) .*?>)/,
    captures: {1 => {name: "keyword.control"}, 2 => {name: "variable.other"}},
    end: "(</%(\\2)>)",
    name: "source.mason.methods",
    patterns: [{include: "$self"}]},
   {begin: /(<%) /,
    captures: {1 => {name: "keyword.control"}},
    end: "(%>)",
    name: "source.mason.substitution",
    patterns: [{include: "source.perl"}]},
   {include: "text.html.basic"}],
 scopeName: "text.html.mason",
 uuid: "34979B9C-CDDC-483E-93B5-B65C6B15E6B0"}
