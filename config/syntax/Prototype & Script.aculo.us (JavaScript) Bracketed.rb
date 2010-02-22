# Encoding: UTF-8

{comment: 
  "This is a wrapper for and adds nested bracket scopes to Prototype & Script.aculo.us (JavaScript). It also allow for embedded ruby source. By Thomas Aylott",
 foldingStartMarker: /(?<_1>\{[^\}]*$|\([^\)]*$|<%)/,
 foldingStopMarker: /(?<_1>^[^\{]*\}|^\s*\)|%>)/,
 keyEquivalent: "^~J",
 name: "Prototype & Script.aculo.us (JavaScript) Bracketed",
 patterns: 
  [{begin: /<%=/,
    beginCaptures: {0 => {name: "punctuation.section.embedded.begin.js"}},
    end: "%>",
    endCaptures: {0 => {name: "punctuation.section.embedded.end.js"}},
    name: "meta.source.embedded.return-value",
    patterns: 
     [{begin: /(?<=<%=)/,
       end: "(?=%>)",
       name: "source.ruby.rails.embedded.html",
       patterns: [{include: "source.ruby.rails"}]}]},
   {begin: /<%(?![=#])/,
    beginCaptures: {0 => {name: "punctuation.section.embedded.begin.js"}},
    end: "%>",
    endCaptures: {0 => {name: "punctuation.section.embedded.end.js"}},
    name: "meta.source.embedded",
    patterns: 
     [{begin: /(?<=<%)/,
       end: "(?=%>)",
       name: "source.ruby.rails.embedded.html",
       patterns: [{include: "source.ruby.rails"}]}]},
   {include: "#conditional-compilation"},
   {include: "#round-brackets"},
   {include: "source.js.prototype"}],
 repository: 
  {:"conditional-compilation" => 
    {patterns: 
      [{begin: /\/\*(?=@)/,
        captures: {0 => {name: "punctuation.definition.comment.js"}},
        end: "(?<=@)\\*/",
        name: "comment.block.conditional.js",
        patterns: [{include: "$base"}]},
       {captures: {1 => {name: "punctuation.definition.keyword.js"}},
        match: /(?<_1>@)(?<_2>if|elif|else|end)/,
        name: "keyword.control.conditional.js"},
       {captures: {1 => {name: "punctuation.definition.keyword.js"}},
        match: /(?<_1>@)(?<_2>cc_on|set)/,
        name: "keyword.operator.conditional.js"},
       {captures: {1 => {name: "punctuation.definition.variable.js"}},
        match: 
         /(?<_1>@)(?<_2>_win32|_win16|_mac|_alpha|_x86|_mc680x0|_PowerPC|_jscript_build|_jscript_version|_jscript|_debug|_fast|[a-zA-Z]\w+)/,
        name: "variable.other.conditional.js"}]},
   :"round-brackets" => 
    {patterns: 
      [{begin: /(?<=\))\s*+(?<_1>\{)/,
        captures: 
         {1 => {name: "punctuation.section.function.js.prototype"},
          2 => {name: "punctuation.separator.objects.js.prototype"}},
        end: "(\\})(,)?\\s*",
        name: "meta.group.braces.curly.function.js.prototype",
        patterns: [{include: "$base"}]},
       {begin: /(?<_1>\{)/,
        captures: 
         {1 => {name: "punctuation.section.scope.js"},
          2 => {name: "punctuation.separator.objects.js.prototype"}},
        end: "(\\})(,)?\\s*",
        name: "meta.group.braces.curly",
        patterns: 
         [{captures: 
            {1 => {name: "invalid.illegal.delimiter.object.comma.js"}},
           match: /(?<_1>,)\s*+(?=\})/},
          {captures: 
            {1 => {name: "string.quoted.double.js.prototype"},
             2 => {name: "punctuation.definition.string.js.prototype"},
             3 => {name: "constant.other.object.key.js.prototype"},
             4 => {name: "punctuation.definition.string.js.prototype"},
             5 => {name: "punctuation.separator.objects.js.prototype"}},
           match: 
            /(?<_1>(?<_2>")(?<_3>[^"]*)(?<_4>")\s*)(?<_5>:)\s*+(?!function)/},
          {captures: 
            {1 => {name: "string.quoted.single.js.prototype"},
             2 => {name: "punctuation.definition.string.js.prototype"},
             3 => {name: "constant.other.object.key.js.prototype"},
             4 => {name: "punctuation.definition.string.js.prototype"},
             5 => {name: "punctuation.separator.objects.js.prototype"}},
           match: 
            /(?<_1>(?<_2>')(?<_3>[^']*)(?<_4>')\s*)(?<_5>:)\s*+(?!function)/},
          {captures: 
            {1 => {name: "constant.other.object.key.js.prototype"},
             2 => {name: "punctuation.separator.objects.js.prototype"}},
           match: /\b(?<_1>\w+\b\s*)(?<_2>:)\s*+(?!function)/},
          {include: "$base"}]},
       {begin: /(?<_1>\()(?!\))/,
        captures: {1 => {name: "punctuation.section.scope.js"}},
        end: "(\\))",
        name: "meta.group.braces.round",
        patterns: [{include: "$base"}]},
       {begin: /(?<_1>\[)(?!\])/,
        captures: {1 => {name: "punctuation.section.scope.js"}},
        end: "(\\])",
        name: "meta.group.braces.square",
        patterns: [{include: "$base"}]}]}},
 scopeName: "source.js.prototype.bracketed",
 uuid: "1FD22341-8BAA-4F89-8257-92CBDD7DE29D"}
