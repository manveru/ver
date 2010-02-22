# Encoding: UTF-8

{fileTypes: ["g"],
 foldingStartMarker: /\/\*(?!\*\/)|\{\s*$/,
 foldingStopMarker: /\*\/|^\s*\}/,
 keyEquivalent: "^~A",
 name: "ANTLR",
 patterns: 
  [{include: "#strings"},
   {include: "#comments"},
   {begin: /\boptions\b/,
    beginCaptures: {0 => {name: "keyword.other.options.antlr"}},
    end: "(?<=\\})",
    name: "meta.options.antlr",
    patterns: 
     [{begin: /\{/,
       captures: {0 => {name: "punctuation.section.options.antlr"}},
       end: "\\}",
       name: "meta.options-block.antlr",
       patterns: 
        [{include: "#strings"},
         {include: "#comments"},
         {match: /\b\d+\b/, name: "constant.numeric.antlr"},
         {match: 
           /\b(?<_1>k|charVocabulary|filter|greedy|paraphrase|exportVocab|buildAST|defaultErrorHandler|language|namespace|namespaceStd|namespaceAntlr|genHashLines)\b/,
          name: "variable.other.option.antlr"},
         {match: /\b(?<_1>true|false)\b/,
          name: "constant.language.boolean.antlr"}]}]},
   {begin: /^(?<_1>class)\b\s+(?<_2>\w+)/,
    captures: 
     {1 => {name: "storage.type.antlr"},
      2 => {name: "entity.name.type.class.antlr"}},
    end: ";",
    name: "meta.definition.class.antlr",
    patterns: 
     [{begin: /\b(?<_1>extends)\b\s+/,
       captures: {1 => {name: "storage.modifier.antlr"}},
       end: "(?=;)",
       name: "meta.definition.class.extends.antlr",
       patterns: 
        [{match: /\b(?<_1>Parser|Lexer|TreeWalker)\b/,
          name: "support.class.antlr"}]}]},
   {match: /^protected\b/, name: "storage.modifier.antlr"},
   {match: /^[[:upper:]_][[:upper:][:digit:]_]*\b/,
    name: "entity.name.type.token.antlr"},
   {captures: 
     {1 => {name: "entity.name.function.rule.antlr"},
      2 => {name: "keyword.control.antlr"}},
    match: /^(?<_1>\w+)(?:\s+(?<_2>returns\b))?/,
    name: "meta.rule.antlr"},
   {match: /\b[[:upper:]_][[:upper:][:digit:]_]*\b/,
    name: "constant.other.token.antlr"},
   {include: "#nested-curly"}],
 repository: 
  {comments: 
    {patterns: 
      [{begin: /\/\*/,
        captures: {0 => {name: "punctuation.definition.comment.antlr"}},
        end: "\\*/",
        name: "comment.block.antlr"},
       {captures: {1 => {name: "punctuation.definition.comment.antlr"}},
        match: /(?<_1>\/\/).*$\n?/,
        name: "comment.line.double-slash.antlr"}]},
   :"nested-curly" => 
    {begin: /\{/,
     captures: {0 => {name: "punctuation.section.group.antlr"}},
     end: "\\}",
     name: "source.embedded.java-or-c.antlr",
     patterns: 
      [{match: 
         /\b(?<_1>break|case|continue|default|do|else|for|goto|if|_Pragma|return|switch|while)\b/,
        name: "keyword.control.java-or-c"},
       {match: 
         /\b(?<_1>asm|__asm__|auto|bool|_Bool|char|_Complex|double|enum|float|_Imaginary|int|long|short|signed|struct|typedef|union|unsigned|void)\b/,
        name: "storage.type.java-or-c"},
       {match: 
         /\b(?<_1>const|extern|register|restrict|static|volatile|inline)\b/,
        name: "storage.modifier.java-or-c"},
       {match: /\b(?<_1>NULL|true|false|TRUE|FALSE)\b/,
        name: "constant.language.java-or-c"},
       {match: /\b(?<_1>sizeof)\b/, name: "keyword.operator.sizeof.java-or-c"},
       {match: 
         /\b(?<_1>(?<_2>0(?<_3>x|X)[0-9a-fA-F]*)|(?<_4>(?<_5>[0-9]+\.?[0-9]*)|(?<_6>\.[0-9]+))(?<_7>(?<_8>e|E)(?<_9>\+|-)?[0-9]+)?)(?<_10>L|l|UL|ul|u|U|F|f|ll|LL|ull|ULL)?\b/,
        name: "constant.numeric.java-or-c"},
       {begin: /"/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.begin.java-or-c"}},
        end: "\"",
        endCaptures: 
         {0 => {name: "punctuation.definition.string.end.java-or-c"}},
        name: "string.quoted.double.java-or-c",
        patterns: [{match: /\\./, name: "constant.character.escape.antlr"}]},
       {begin: /'/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.begin.java-or-c"}},
        end: "'",
        endCaptures: 
         {0 => {name: "punctuation.definition.string.end.java-or-c"}},
        name: "string.quoted.single.java-or-c",
        patterns: [{match: /\\./, name: "constant.character.escape.antlr"}]},
       {match: /\bEOF_CHAR\b/, name: "support.constant.eof-char.antlr"},
       {include: "#comments"}]},
   strings: 
    {patterns: 
      [{begin: /"/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.begin.antlr"}},
        end: "\"",
        endCaptures: {0 => {name: "punctuation.definition.string.end.antlr"}},
        name: "string.quoted.double.antlr",
        patterns: 
         [{match: /\\(?<_1>u\h{4}|.)/,
           name: "constant.character.escape.antlr"}]},
       {begin: /'/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.begin.antlr"}},
        end: "'",
        endCaptures: {0 => {name: "punctuation.definition.string.end.antlr"}},
        name: "string.quoted.single.antlr",
        patterns: 
         [{match: /\\(?<_1>u\h{4}|.)/,
           name: "constant.character.escape.antlr"}]}]}},
 scopeName: "source.antlr",
 uuid: "ACABDECD-4F22-47D9-A5F4-DBA957A2A1CC"}
