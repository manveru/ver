# Encoding: UTF-8

{fileTypes: ["dot", "DOT"],
 foldingStartMarker: /\{/,
 foldingStopMarker: /\}/,
 keyEquivalent: "^~G",
 name: "Graphviz (DOT)",
 patterns: 
  [{match: /\b(?<_1>node|edge|graph|digraph|subgraph|strict)\b/,
    name: "storage.type.dot"},
   {match: 
     /\b(?<_1>bottomlabel|color|comment|distortion|fillcolor|fixedsize|fontcolor|fontname|fontsize|group|height|label|layer|orientation|peripheries|regular|shape|shapefile|sides|skew|style|toplabel|URL|width|z)\b/,
    name: "support.constant.attribute.node.dot"},
   {match: 
     /\b(?<_1>arrowhead|arrowsize|arrowtail|color|comment|constraint|decorate|dir|fontcolor|fontname|fontsize|headlabel|headport|headURL|label|labelangle|labeldistance|labelfloat|labelcolor|labelfontname|labelfontsize|layer|lhead|ltail|minlen|samehead|sametail|style|taillabel|tailport|tailURL|weight)\b/,
    name: "support.constant.attribute.edge.dot"},
   {match: 
     /\b(?<_1>bgcolor|center|clusterrank|color|comment|compound|concentrate|fillcolor|fontname|fontpath|fontsize|label|labeljust|labelloc|layers|margin|mclimit|nodesep|nslimit|nslimit1|ordering|orientation|page|pagedir|quantum|rank|rankdir|ranksep|ratio|remincross|rotate|samplepoints|searchsize|size|style|URL)\b/,
    name: "support.constant.attribute.graph.dot"},
   {begin: /"/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.dot"}},
    end: "\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.dot"}},
    name: "string.quoted.double.dot",
    patterns: [{match: /\\./, name: "constant.character.escape.dot"}]},
   {captures: {1 => {name: "punctuation.definition.comment.dot"}},
    match: /(?<_1>\/\/).*$\n?/,
    name: "comment.line.double-slash.dot"},
   {captures: {1 => {name: "punctuation.definition.comment.dot"}},
    match: /(?<_1>#).*$\n?/,
    name: "comment.line.number-sign.dot"},
   {begin: /\/\*/,
    captures: {0 => {name: "punctuation.definition.comment.dot"}},
    end: "\\*/",
    name: "comment.block.dot"}],
 scopeName: "source.dot",
 uuid: "1A53D54E-6B1D-11D9-A006-000D93589AF6"}
