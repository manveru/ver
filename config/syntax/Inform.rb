# Encoding: UTF-8

{comment: "Should be current for Inform 6.2 or thereabouts – chris@cjack.com",
 fileTypes: ["inf"],
 foldingStartMarker: /\[/,
 foldingStopMarker: /\]/,
 keyEquivalent: "^~I",
 name: "Inform",
 patterns: 
  [{captures: {1 => {name: "punctuation.definition.comment.inform"}},
    match: /(!)(.*)$\n?/,
    name: "comment.line.exclamation.inform"},
   {captures: {1 => {name: "entity.name.function.inform"}},
    match: /(?:\s*)\[(?:\s*)(.*)(?:\s*);/,
    name: "meta.function.inform"},
   {match: 
     /\b((\$[0-9a-fA-F]*)|(([0-9]+\.?[0-9]*)|(\.[0-9]+))((e|E)(\+|-)?[0-9]+)?)(L|l|UL|ul|u|U|F|f)?\b/,
    name: "constant.numeric.inform"},
   {begin: /'/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.inform"}},
    end: "'",
    endCaptures: {0 => {name: "punctuation.definition.string.end.inform"}},
    name: "string.quoted.single.inform",
    patterns: [{match: /\\./, name: "constant.character.escape.inform"}]},
   {begin: /"/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.inform"}},
    end: "\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.inform"}},
    name: "string.quoted.double.inform"},
   {match: 
     /\b(box|break|continue|do|else|font(\s+)(on|off)|for|give|if|jump|new_line|objectloop|print|print_ret|remove|return|rfalse|rtrue|spaces|string|style(\s+)(roman|bold|underline|reverse|fixed)|switch|until|while|has|hasnt|in|notin|ofclass|provides|or)\b/,
    name: "keyword.control.inform"},
   {match: 
     /\b(Abbreviate|Array|Attribute|Class|Constant|Default|End|Endif|Extend|Global|Ifdef|Ifndef|Ifnot|Iftrue|Iffalse|Import|Include|Link|Lowstring|Message|Object|Property|Release|Replace|Serial|Switches|Statusline(\s+)(score|time)|System_file|Verb|Zcharacter)\b/,
    name: "keyword.other.directive.inform"}],
 scopeName: "source.inform",
 uuid: "1510B8C7-6B1D-11D9-B82B-000D93589AF6"}
