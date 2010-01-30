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
    {begin: /\b(background)/,
     beginCaptures: {1 => {name: "keyword.control.background.cfdg"}},
     end: "(\\})|(\\])",
     endCaptures: 
      {1 => {name: "punctuation.section.unordered-block.end.cfdg"},
       2 => {name: "punctuation.section.ordered-block.end.cfdg"}},
     patterns: [{include: "#color-adjustment-block"}, {include: "#comment"}]},
   :"color-adjustment" => 
    {match: /\||\b(h(ue)?|sat(uration)?|b(rightness)?|a(lpha)?)\b/,
     name: "constant.language.color-adjustment.cfdg"},
   :"color-adjustment-block" => 
    {patterns: 
      [{begin: /(\{)/,
        beginCaptures: 
         {1 => {name: "punctuation.section.unordered-block.begin.cfdg"}},
        end: "(?=\\})",
        patterns: 
         [{include: "#color-adjustment"},
          {include: "#number"},
          {include: "#comment"}]},
       {begin: /(\[)/,
        beginCaptures: 
         {1 => {name: "punctuation.section.ordered-block.begin.cfdg"}},
        end: "(?=\\])",
        patterns: 
         [{include: "#color-adjustment"},
          {include: "#number"},
          {include: "#comment"}]}]},
   comment: 
    {patterns: 
      [{begin: /(\/\/|#)/,
        beginCaptures: {1 => {name: "punctuation.definition.comment.cfdg"}},
        end: "$\\n?",
        name: "comment.line.cfdg"},
       {begin: /(\/\*)/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.comment.begin.cfdg"}},
        end: "(\\*/)",
        endCaptures: {1 => {name: "punctuation.definition.comment.end.cfdg"}},
        name: "comment.block.cfdg"}]},
   :"geometry-adjustment" => 
    {match: /\b(x|y|z|s(ize)?|r(ot(ate)?)?|f(lip)?|skew)\b/,
     name: "constant.language.geometry-adjustment.cfdg"},
   :"include-directive" => 
    {captures: 
      {1 => {name: "keyword.control.include.cfdg"},
       2 => {name: "string.unquoted.file-name.cfdg"}},
     match: /\b(include)\s++(\S++)/},
   loop: 
    {begin: /(\d++)\s*+(\*)/,
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
     match: /(\+|\-)?((\d++)?(\.))?\d++/,
     name: "constant.numeric.cfdg"},
   rule: 
    {begin: /(\{)/,
     beginCaptures: {1 => {name: "punctuation.section.rule.begin.cfdg"}},
     end: "(?=\\})",
     patterns: 
      [{include: "#loop"},
       {include: "#shape-replacement"},
       {include: "#comment"}]},
   :"rule-directive" => 
    {begin: 
      /\b(rule)\s++([a-zA-Z_][a-zA-Z_\.\d]*+)(\s++(((\d++)?(\.))?\d++))?/,
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
      [{begin: /(\{)/,
        beginCaptures: 
         {1 => {name: "punctuation.section.unordered-block.begin.cfdg"}},
        end: "(?=\\})",
        patterns: 
         [{include: "#color-adjustment"},
          {include: "#geometry-adjustment"},
          {include: "#number"},
          {include: "#comment"}]},
       {begin: /(\[)/,
        beginCaptures: 
         {1 => {name: "punctuation.section.ordered-block.begin.cfdg"}},
        end: "(?=\\])",
        patterns: 
         [{include: "#color-adjustment"},
          {include: "#geometry-adjustment"},
          {include: "#number"},
          {include: "#comment"}]}]},
   :"shape-replacement" => 
    {begin: /([a-zA-Z_][a-zA-Z_\.\d]*+)/,
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
     match: /\b(startshape)\s++([a-zA-Z_][a-zA-Z_\.\d]*+)/}},
 scopeName: "source.context-free",
 uuid: "8D0EE5A2-FB60-40F8-8D0F-1E1FFB506462"}
