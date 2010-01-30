# Encoding: UTF-8

{fileTypes: ["rl", "ragel"],
 foldingStartMarker: 
  /(?x)
	 \/\*\*(?!\*)
	|^(?![^{]*?\/\/|[^{]*?\/\*(?!.*?\*\/.*?\{)).*?\{\s*($|\/\/|\/\*(?!.*?\*\/.*\S))
	/,
 foldingStopMarker: /(?<!\*)\*\*\/|^\s*\}/,
 keyEquivalent: "^~R",
 name: "Ragel",
 patterns: 
  [{begin: /%%{/,
    captures: {0 => {name: "punctuation.section.embedded.ragel"}},
    end: "}%%",
    name: "source.ragel",
    patterns: [{include: "#source_ragel"}]},
   {begin: /%%$/,
    beginCaptures: {0 => {name: "punctuation.section.embedded.ragel"}},
    end: "$",
    name: "source.ragel",
    patterns: [{include: "#source_ragel"}]},
   {begin: /%%/,
    beginCaptures: {0 => {name: "punctuation.section.embedded.ragel"}},
    end: "$",
    name: "support.function.ragel",
    patterns: [{include: "#keywords"}]},
   {include: "source.c"}],
 repository: 
  {action_name: 
    {patterns: 
      [{captures: {1 => {name: "punctuation.definition.entity.ragel"}},
        match: /([@$>%])\s*([\w\d]+)/,
        name: "entity.name.type.action-reference.ragel"}]},
   comments: 
    {patterns: 
      [{begin: /#/,
        beginCaptures: {0 => {name: "punctuation.definition.comment.ragel"}},
        end: "$\\n?",
        name: "comment.line.ragel"}]},
   embedded_code: 
    {patterns: 
      [{begin: /\{/,
        beginCaptures: {0 => {name: "punctuation.section.embedded.c"}},
        end: "\\}",
        name: "source.c",
        patterns: [{include: "source.c"}]}]},
   keywords: 
    {patterns: 
      [{match: 
         /\b(machine|action|context|include|variable|access|write|contained)\b/,
        name: "keyword.other.ragel"}]},
   operators: 
    {patterns: 
      [{match: /(\:\>\>?|\<\:)/,
        name: "keyword.operator.contatenation.ragel"}]},
   regexp: 
    {patterns: 
      [{begin: /\[/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.begin.ragel"}},
        end: "\\]\\s*[*?]?",
        endCaptures: {0 => {name: "punctuation.definition.string.end.ragel"}},
        name: "string.regexp.character-class.ragel"},
       {begin: /\//,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.begin.ragel"}},
        end: "\\/\\s*[*?]?",
        endCaptures: {0 => {name: "punctuation.definition.string.end.ragel"}},
        name: "string.regexp.classic.ragel"}]},
   source_ragel: 
    {patterns: 
      [{include: "#keywords"},
       {include: "#regexp"},
       {include: "#string"},
       {include: "#comments"},
       {include: "#embedded_code"},
       {begin: /(action)\s+([\w\d]+)\s+({)/,
        beginCaptures: 
         {1 => {name: "keyword.other.action.ragel"},
          2 => {name: "entity.name.type.action.ragel"},
          3 => {name: "punctuation.section.function.ragel"}},
        end: "(})",
        endCaptures: {1 => {name: "punctuation.section.function.ragel"}},
        name: "meta.function.action.ragel",
        patterns: [{include: "source.c"}]},
       {begin: /([\w\d]+)\s*(=)/,
        beginCaptures: 
         {1 => {name: "entity.name.type.machine-definition.ragel"},
          2 => {name: "punctuation.separator.key-value.ragel"}},
        end: "(;)",
        endCaptures: 
         {1 => {name: "punctuation.terminator.machine-definition.ragel"}},
        name: "meta.machine-definition.ragel",
        patterns: 
         [{include: "#regexp"},
          {include: "#string"},
          {include: "#action_name"},
          {include: "#embedded_code"},
          {include: "#operators"},
          {include: "#comments"}]},
       {begin: /([\w\d]+)\s*(:=)/,
        beginCaptures: 
         {1 => {name: "entity.name.type.machine-instantiation.ragel"},
          2 => {name: "punctuation.separator.key-value.ragel"}},
        end: ";",
        endCaptures: 
         {1 => {name: "punctuation.terminator.machine-instantiation.ragel"}},
        name: "meta.machine-instantiation.ragel",
        patterns: 
         [{include: "#regexp"},
          {include: "#string"},
          {include: "#action_name"},
          {include: "#embedded_code"},
          {include: "#operators"},
          {include: "#comments"},
          {begin: /\|\*/,
           end: "\\*\\|",
           name: "meta.ragel.longest-match",
           patterns: [{include: "#source_ragel"}]}]}]},
   string: 
    {patterns: 
      [{begin: /"/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.begin.ragel"}},
        end: "\"",
        endCaptures: {0 => {name: "punctuation.definition.string.end.ragel"}},
        name: "string.quoted.double.ragel",
        patterns: 
         [{include: "#string_escaped_char"},
          {include: "#string_placeholder"}]},
       {begin: /'/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.begin.ragel"}},
        end: "'",
        endCaptures: {0 => {name: "punctuation.definition.string.end.ragel"}},
        name: "string.quoted.single.ragel",
        patterns: [{include: "#string_escaped_char"}]}]},
   string_escaped_char: 
    {patterns: 
      [{match: /\\(\\|[abefnprtv'"?]|[0-3]\d{,2}|[4-7]\d?|x[a-fA-F0-9]{,2})/,
        name: "constant.character.escape.ragel"},
       {match: /\\./, name: "invalid.illegal.unknown-escape.ragel"}]},
   string_placeholder: 
    {patterns: 
      [{match: 
         /(?x)%
	(\d+\$)?                             # field (argument #)
	[#0\- +']*                           # flags
	[,;:_]?                              # separator character (AltiVec)
	((-?\d+)|\*(-?\d+\$)?)?              # minimum field width
	(\.((-?\d+)|\*(-?\d+\$)?)?)?         # precision
	(hh|h|ll|l|j|t|z|q|L|vh|vl|v|hv|hl)? # length modifier
	[diouxXDOUeEfFgGaACcSspn%]           # conversion type
	/,
        name: "constant.other.placeholder.ragel"},
       {match: /%/, name: "invalid.illegal.placeholder.ragel"}]}},
 scopeName: "source.c.ragel",
 uuid: "F1172666-F07C-4F6A-B07D-E1AD08DE2070"}
