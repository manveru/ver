# Encoding: UTF-8

{fileTypes: ["cfdg", "context free"],
 foldingStartMarker: /[\{\[]\s*$/,
 foldingStopMarker: /^\s*[\}\]]/,
 keyEquivalent: "^~C",
 name: "Context Free",
 patterns: 
  [{include: "#comment"},
   {include: "#startshape-directive"},
   {include: "#include-directive"},
   {include: "#background-directive"},
   {include: "#rule-directive"}],
 repository: 
  {:"background-directive" => 
    {begin: /\b(?<_1>background)/,
     beginCaptures: {1 => {name: "keyword.control.background.cfdg"}},
     end: "(\\})|(\\])",
     endCaptures: 
      {1 => {name: "punctuation.section.unordered-block.end.cfdg"},
       2 => {name: "punctuation.section.ordered-block.end.cfdg"}},
     patterns: [{include: "#color-adjustment-block"}, {include: "#comment"}]},
   :"color-adjustment" => 
    {match: 
      /\||\b(?<_1>h(?<_2>ue)?|sat(?<_3>uration)?|b(?<_4>rightness)?|a(?<_5>lpha)?)\b/,
     name: "constant.language.color-adjustment.cfdg"},
   :"color-adjustment-block" => 
    {patterns: 
      [{begin: /(?<_1>\{)/,
        beginCaptures: 
         {1 => {name: "punctuation.section.unordered-block.begin.cfdg"}},
        end: "(?=\\})",
        patterns: 
         [{include: "#color-adjustment"},
          {include: "#number"},
          {include: "#comment"}]},
       {begin: /(?<_1>\[)/,
        beginCaptures: 
         {1 => {name: "punctuation.section.ordered-block.begin.cfdg"}},
        end: "(?=\\])",
        patterns: 
         [{include: "#color-adjustment"},
          {include: "#number"},
          {include: "#comment"}]}]},
   comment: 
    {patterns: 
      [{begin: /(?<_1>\/\/|#)/,
        beginCaptures: {1 => {name: "punctuation.definition.comment.cfdg"}},
        end: "$\\n?",
        name: "comment.line.cfdg"},
       {begin: /(?<_1>\/\*)/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.comment.begin.cfdg"}},
        end: "(\\*/)",
        endCaptures: {1 => {name: "punctuation.definition.comment.end.cfdg"}},
        name: "comment.block.cfdg"}]},
   :"geometry-adjustment" => 
    {match: 
      /\b(?<_1>x|y|z|s(?<_2>ize)?|r(?<_3>ot(?<_4>ate)?)?|f(?<_5>lip)?|skew)\b/,
     name: "constant.language.geometry-adjustment.cfdg"},
   :"include-directive" => 
    {captures: 
      {1 => {name: "keyword.control.include.cfdg"},
       2 => {name: "string.unquoted.file-name.cfdg"}},
     match: /\b(?<_1>include)\s++(?<_2>\S++)/},
   loop: 
    {begin: /(?<_1>\d++)\s*+(?<_2>\*)/,
     beginCaptures: 
      {1 => {name: "constant.numeric.cfdg"},
       2 => {name: "keyword.operator.loop.cfdg"}},
     end: "(\\})|(\\])",
     endCaptures: 
      {1 => {name: "punctuation.section.unordered-block.end.cfdg"},
       2 => {name: "punctuation.section.ordered-block.end.cfdg"}},
     patterns: [{include: "#shape-adjustment-block"}, {include: "#comment"}]},
   number: 
    {captures: 
      {1 => {name: "keyword.operator.sign.cfdg"},
       4 => {name: "punctuation.separator.integer-float.cfdg"}},
     match: /(?<_1>\+|\-)?(?<_2>(?<_3>\d++)?(?<_4>\.))?\d++/,
     name: "constant.numeric.cfdg"},
   rule: 
    {begin: /(?<_1>\{)/,
     beginCaptures: {1 => {name: "punctuation.section.rule.begin.cfdg"}},
     end: "(?=\\})",
     patterns: 
      [{include: "#loop"},
       {include: "#shape-replacement"},
       {include: "#comment"}]},
   :"rule-directive" => 
    {begin: 
      /\b(?<_1>rule)\s++(?<_2>[a-zA-Z_][a-zA-Z_\.\d]*+)(?<_3>\s++(?<_4>(?<_5>(?<_6>\d++)?(?<_7>\.))?\d++))?/,
     beginCaptures: 
      {1 => {name: "keyword.control.rule.cfdg"},
       2 => {name: "entity.name.function.rule.definition.cfdg"},
       4 => {name: "constant.numeric.cfdg"},
       7 => {name: "punctuation.separator.integer-float.cfdg"}},
     end: "(\\})",
     endCaptures: {1 => {name: "punctuation.section.rule.end.cfdg"}},
     patterns: [{include: "#rule"}, {include: "#comment"}]},
   :"shape-adjustment-block" => 
    {patterns: 
      [{begin: /(?<_1>\{)/,
        beginCaptures: 
         {1 => {name: "punctuation.section.unordered-block.begin.cfdg"}},
        end: "(?=\\})",
        patterns: 
         [{include: "#color-adjustment"},
          {include: "#geometry-adjustment"},
          {include: "#number"},
          {include: "#comment"}]},
       {begin: /(?<_1>\[)/,
        beginCaptures: 
         {1 => {name: "punctuation.section.ordered-block.begin.cfdg"}},
        end: "(?=\\])",
        patterns: 
         [{include: "#color-adjustment"},
          {include: "#geometry-adjustment"},
          {include: "#number"},
          {include: "#comment"}]}]},
   :"shape-replacement" => 
    {begin: /(?<_1>[a-zA-Z_][a-zA-Z_\.\d]*+)/,
     beginCaptures: {1 => {name: "entity.name.function.rule.cfdg"}},
     end: "(\\})|(\\])",
     endCaptures: 
      {1 => {name: "punctuation.section.unordered-block.end.cfdg"},
       2 => {name: "punctuation.section.ordered-block.end.cfdg"}},
     patterns: [{include: "#shape-adjustment-block"}, {include: "#comment"}]},
   :"startshape-directive" => 
    {captures: 
      {1 => {name: "keyword.control.startshape.cfdg"},
       2 => {name: "entity.name.function.rule.cfdg"}},
     match: /\b(?<_1>startshape)\s++(?<_2>[a-zA-Z_][a-zA-Z_\.\d]*+)/}},
 scopeName: "source.context-free",
 uuid: "8D0EE5A2-FB60-40F8-8D0F-1E1FFB506462"}
