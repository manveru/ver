# Encoding: UTF-8

{comment: "CoffeeScript Syntax: version 1",
 fileTypes: ["coffee", "Cakefile"],
 foldingStartMarker: /^.*[:=] \{[^\}]*$/,
 foldingStopMarker: /\s*\}/,
 keyEquivalent: "^~C",
 name: "CoffeeScript",
 patterns: 
  [{captures: 
     {1 => {name: "variable.parameter.function.coffee"},
      2 => {name: "variable.parameter.function.coffee"},
      4 => {name: "variable.parameter.function.coffee"},
      5 => {name: "storage.type.function.coffee"}},
    comment: "match stuff like: a -> … ",
    match: 
     /(?<_1>\()(?<_2>[a-zA-Z0-9_?.\$]*(?<_3>,\s*[a-zA-Z0-9_?.\$]+)*)(?<_4>\))\s*(?<_5>(?<_6>=|-)>)/,
    name: "meta.inline.function.coffee"},
   {captures: 
     {1 => {name: "keyword.operator.new.coffee"},
      2 => {name: "entity.name.type.instance.coffee"}},
    match: /(?<_1>new)\s+(?<_2>\w+(?:\.\w*)?)/,
    name: "meta.class.instance.constructor"},
   {begin: /'''/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.coffee"}},
    end: "'''",
    endCaptures: {0 => {name: "punctuation.definition.string.end.coffee"}},
    name: "string.quoted.heredoc.coffee"},
   {begin: /"""/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.coffee"}},
    end: "\"\"\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.coffee"}},
    name: "string.quoted.heredoc.coffee",
    patterns: [{match: /\\./, name: "constant.character.escape.coffee"}]},
   {begin: /`/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.coffee"}},
    end: "`",
    endCaptures: {0 => {name: "punctuation.definition.string.end.coffee"}},
    name: "string.quoted.script.coffee",
    patterns: 
     [{match: 
        /\\(?<_1>x\h{2}|[0-2][0-7]{,2}|3[0-6][0-7]|37[0-7]?|[4-7][0-7]?|.)/,
       name: "constant.character.escape.coffee"}]},
   {begin: /###(?!#)[ \t]*\n/,
    captures: {0 => {name: "punctuation.definition.comment.coffee"}},
    end: "###",
    name: "comment.block.coffee"},
   {captures: {1 => {name: "punctuation.definition.comment.coffee"}},
    match: /(?<_1>#).*$\n?/,
    name: "comment.line.coffee"},
   {match: /(?<!\d)\s*\/(?![\s\/*+{}?]).*\/[igmy]*/,
    name: "string.regexp.coffee"},
   {match: 
     /\b(?<!\.)(?<_1>break|by|catch|continue|else|finally|for|in|of|if|return|switch|then|throw|try|unless|when|while|until|loop)(?!\s*:)\b/,
    name: "keyword.control.coffee"},
   {captures: {1 => {name: "variable.assignment.coffee"}},
    match: 
     /(?=[a-zA-Z\$_])(?<_1>[a-zA-Z\$_](?<_2>\w|\$|\.)*\s*(?=(?!\::)\:(?!(?<_3>\s*\(.*\))?\s*(?<_4>(?<_5>=|-)>))))/,
    name: "variable.assignment.coffee"},
   {begin: /(?<=\s|^)(?<_1>\[)(?=.*?\]\s*:)/,
    beginCaptures: {0 => {name: "keyword.operator.coffee"}},
    end: "(\\]\\s*:)",
    endCaptures: {0 => {name: "keyword.operator.coffee"}},
    name: "meta.variable.assignment.destructured.coffee",
    patterns: 
     [{include: "#variable_name"},
      {include: "#instance_variable"},
      {include: "#single_quoted_string"},
      {include: "#double_quoted_string"},
      {include: "#numeric"}]},
   {captures: {2 => {name: "entity.name.function.coffee"}},
    match: 
     /(?<_1>\s*)(?=[a-zA-Z\$_])(?<_2>[a-zA-Z\$_](?<_3>\w|\$|:|\.)*\s*(?=\:(?<_4>\s*\(.*\))?\s*(?<_5>(?<_6>=|-)>)))/,
    name: "meta.function.coffee"},
   {match: /(?<_1>=|-)>/, name: "storage.type.function.coffee"},
   {match: /\b(?<!\.)(?<_1>true|on|yes)(?!\s*:)\b/,
    name: "constant.language.boolean.true.coffee"},
   {match: /\b(?<!\.)(?<_1>false|off|no)(?!\s*:)\b/,
    name: "constant.language.boolean.false.coffee"},
   {match: /\b(?<!\.)null(?!\s*:)\b/, name: "constant.language.null.coffee"},
   {match: /\b(?<!\.)(?<_1>super|this|extends)(?!\s*:)\b/,
    name: "variable.language.coffee"},
   {captures: 
     {1 => {name: "storage.type.class.coffee"},
      2 => {name: "entity.name.type.class.coffee"},
      3 => {name: "entity.other.inherited-class.coffee"},
      4 => {name: "keyword.control.inheritance.coffee"}},
    match: 
     /(?<_1>class)\s+(?<_2>[a-zA-Z\$_]\w+)(?<_3>\s+(?<_4>extends)\s+[a-zA-Z\$_]\w*)?/,
    name: "meta.class.coffee"},
   {match: /\b(?<_1>debugger|\\)\b/, name: "keyword.other.coffee"},
   {match: 
     /!|%|&|\*|\/|\-\-|\-|\+\+|\+|~|===|==|=|!=|!==|<=|>=|<<=|>>=|>>>=|<>|<|>|!|&&|\?|\||\|\||\:|\*=|(?<!\()\/=|%=|\+=|\-=|&=|\^=|\b(?<_1>instanceof|new|delete|typeof|and|or|is|isnt|not)\b/,
    name: "keyword.operator.coffee"},
   {match: /\b(?<_1>Infinity|NaN|undefined)\b/,
    name: "constant.language.coffee"},
   {match: /\;/, name: "punctuation.terminator.statement.coffee"},
   {match: /,[ |\t]*/, name: "meta.delimiter.object.comma.coffee"},
   {match: /\./, name: "meta.delimiter.method.period.coffee"},
   {match: /\{|\}/, name: "meta.brace.curly.coffee"},
   {match: /\(|\)/, name: "meta.brace.round.coffee"},
   {match: /\[|\]\s*/, name: "meta.brace.square.coffee"},
   {include: "#instance_variable"},
   {include: "#single_quoted_string"},
   {include: "#double_quoted_string"},
   {include: "#numeric"}],
 repository: 
  {double_quoted_string: 
    {patterns: 
      [{begin: /"/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.begin.coffee"}},
        end: "\"",
        endCaptures: {0 => {name: "punctuation.definition.string.end.coffee"}},
        name: "string.quoted.double.coffee",
        patterns: 
         [{match: 
            /\\(?<_1>x\h{2}|[0-2][0-7]{,2}|3[0-6][0-7]|37[0-7]?|[4-7][0-7]?|.)/,
           name: "constant.character.escape.coffee"},
          {include: "#interpolated_coffee"}]}]},
   instance_variable: 
    {patterns: 
      [{match: /(?<_1>@)(?<_2>[a-zA-Z_\$]\w*)?/,
        name: "variable.other.readwrite.instance.coffee"}]},
   interpolated_coffee: 
    {patterns: 
      [{begin: /\$\{/,
        captures: {0 => {name: "punctuation.section.embedded.coffee"}},
        end: "\\}",
        name: "source.coffee.embedded.source",
        patterns: [{include: "$self"}]},
       {captures: {1 => {name: "punctuation.definition.variable.coffee"}},
        match: /(?<_1>\$)@[a-zA-Z_]\w*(?<_2>\.\w+)*/,
        name: "variable.other.readwrite.coffee"},
       {captures: {1 => {name: "punctuation.definition.variable.coffee"}},
        match: /(?<_1>\$)(?!@)[a-zA-Z_]\w*(?<_2>\.\w+)*/,
        name: "source.coffee.embedded.source"}]},
   numeric: 
    {patterns: 
      [{match: 
         /(?<!\$)\b(?<_1>(?<_2>0(?<_3>x|X)[0-9a-fA-F]+)|(?<_4>[0-9]+(?<_5>\.[0-9]+)?(?<_6>e[+\-]?[0-9]+)?))\b/,
        name: "constant.numeric.coffee"}]},
   single_quoted_string: 
    {patterns: 
      [{begin: /'/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.begin.coffee"}},
        end: "'",
        endCaptures: {0 => {name: "punctuation.definition.string.end.coffee"}},
        name: "string.quoted.single.coffee",
        patterns: 
         [{match: 
            /\\(?<_1>x\h{2}|[0-2][0-7]{,2}|3[0-6][0-7]?|37[0-7]?|[4-7][0-7]?|.)/,
           name: "constant.character.escape.coffee"}]}]},
   variable_name: 
    {patterns: 
      [{captures: {1 => {name: "variable.assignment.coffee"}},
        match: /(?<_1>[a-zA-Z\$_]\w*(?<_2>\.\w+)*)/,
        name: "variable.assignment.coffee"}]}},
 scopeName: "source.coffee",
 uuid: "5B520980-A7D5-4E10-8582-1A4C889A8DE5"}
