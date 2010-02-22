# Encoding: UTF-8

{comment: "Should be current for Inform 6.2 or thereabouts – chris@cjack.com",
 fileTypes: ["inf"],
 foldingStartMarker: /\[/,
 foldingStopMarker: /\]/,
 keyEquivalent: "^~I",
 name: "Inform",
 patterns: 
  [{captures: {1 => {name: "punctuation.definition.comment.inform"}},
    match: /(?<_1>!)(?<_2>.*)$\n?/,
    name: "comment.line.exclamation.inform"},
   {captures: {1 => {name: "entity.name.function.inform"}},
    match: /(?:\s*)\[(?:\s*)(?<_1>.*)(?:\s*);/,
    name: "meta.function.inform"},
   {match: 
     /\b(?<_1>(?<_2>\$[0-9a-fA-F]*)|(?<_3>(?<_4>[0-9]+\.?[0-9]*)|(?<_5>\.[0-9]+))(?<_6>(?<_7>e|E)(?<_8>\+|-)?[0-9]+)?)(?<_9>L|l|UL|ul|u|U|F|f)?\b/,
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
     /\b(?<_1>box|break|continue|do|else|font(?<_2>\s+)(?<_3>on|off)|for|give|if|jump|new_line|objectloop|print|print_ret|remove|return|rfalse|rtrue|spaces|string|style(?<_4>\s+)(?<_5>roman|bold|underline|reverse|fixed)|switch|until|while|has|hasnt|in|notin|ofclass|provides|or)\b/,
    name: "keyword.control.inform"},
   {match: 
     /\b(?<_1>Abbreviate|Array|Attribute|Class|Constant|Default|End|Endif|Extend|Global|Ifdef|Ifndef|Ifnot|Iftrue|Iffalse|Import|Include|Link|Lowstring|Message|Object|Property|Release|Replace|Serial|Switches|Statusline(?<_2>\s+)(?<_3>score|time)|System_file|Verb|Zcharacter)\b/,
    name: "keyword.other.directive.inform"}],
 scopeName: "source.inform",
 uuid: "1510B8C7-6B1D-11D9-B82B-000D93589AF6"}
