# Encoding: UTF-8

{fileTypes: ["mhtml", "autohandler", "dhandler", "md", "mc"],
 foldingStartMarker: 
  /(?<_1><(?i:(?<_2>head|table|div|style|script|ul|ol|form|dl))\b.*?>|\{)/,
 foldingStopMarker: 
  /(?<_1><\/(?i:(?<_2>head|table|div|style|script|ul|ol|form|dl))>|\})/,
 name: "HTML (Mason)",
 patterns: 
  [{begin: 
     /(?<_1><%(?<_2>perl|attr|global|once|init|cleanup|requestlocal|requestonce|shared|threadlocal|threadonce|flags)(?<_3> scope.*?)?>)/,
    captures: 
     {1 => {name: "punctuation.section.embedded.perl.mason"},
      2 => {name: "keyword.control"}},
    end: "(</%(\\2)>)(\\s*$\\n)?",
    name: "source.perl.mason.block",
    patterns: [{include: "source.perl"}]},
   {begin: /(?<_1><(?<_2>%text)>)/,
    captures: {1 => {name: "keyword.control"}, 2 => {name: "variable.other"}},
    end: "(</(%text)>)",
    name: "source.perl.mason.doc",
    patterns: 
     [{begin: /(?<=<%text>)/, end: "(?=</%text>)", name: "comment.block"}]},
   {begin: /(?<_1><(?<_2>%doc)>)/,
    captures: {1 => {name: "keyword.control"}, 2 => {name: "variable.other"}},
    end: "(</(%doc)>)",
    name: "source.perl.mason.doc",
    patterns: 
     [{begin: /(?<=<%doc>)/, end: "(?=</%doc>)", name: "comment.block"}]},
   {begin: /^(?<_1>%)/,
    beginCaptures: {1 => {name: "punctuation.section.embedded.perl.mason"}},
    end: "$\\n?",
    name: "source.perl.mason.line",
    patterns: [{include: "source.perl"}]},
   {begin: /(?<_1><&\|)(?<_2>(?<_3>\w|\.|\:)*)(?!&>)/,
    beginCaptures: 
     {1 => {name: "keyword.control"}, 2 => {name: "entity.name.function"}},
    end: "(</&>)",
    endCaptures: {1 => {name: "keyword.control"}},
    name: "source.mason.component.block",
    patterns: 
     [{begin: /(?<_1>&>)/,
       beginCaptures: {1 => {name: "keyword.control"}},
       end: "(?=</&>)",
       name: "source.mason.nesty",
       patterns: [{include: "$self"}]}]},
   {begin: /(?<_1><&)(?<_2>.{1,}?)(?<_3> |,)+/,
    beginCaptures: 
     {1 => {name: "keyword.control"}, 2 => {name: "entity.name.function"}},
    end: "(&>)",
    endCaptures: {1 => {name: "keyword.control"}},
    name: "source.mason.component",
    patterns: [{include: "source.perl"}]},
   {begin: /(?<_1><%(?<_2>args.*?)>)/,
    captures: {1 => {name: "keyword.control"}, 2 => {name: "variable.other"}},
    end: "(</%(\\2)>)",
    name: "source.mason.args",
    patterns: 
     [{captures: {2 => {name: "string.quoted.single"}},
       include: "source.perl",
       match: /(?<_1>\s*)?(?<_2>\w*)/}]},
   {begin: /(?<_1><%(?<_2>method|def|closure) .*?>)/,
    captures: {1 => {name: "keyword.control"}, 2 => {name: "variable.other"}},
    end: "(</%(\\2)>)",
    name: "source.mason.methods",
    patterns: [{include: "$self"}]},
   {begin: /(?<_1><%) /,
    captures: {1 => {name: "keyword.control"}},
    end: "(%>)",
    name: "source.mason.substitution",
    patterns: [{include: "source.perl"}]},
   {include: "text.html.basic"}],
 scopeName: "text.html.mason",
 uuid: "34979B9C-CDDC-483E-93B5-B65C6B15E6B0"}
