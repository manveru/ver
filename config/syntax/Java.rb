# Encoding: UTF-8

{fileTypes: ["java", "bsh"],
 foldingStartMarker: /(?<_1>\{\s*(?<_2>\/\/.*)?$|^\s*\/\/ \{\{\{)/,
 foldingStopMarker: /^\s*(?<_1>\}|\/\/ \}\}\}$)/,
 keyEquivalent: "^~J",
 name: "Java",
 patterns: 
  [{captures: 
     {1 => {name: "keyword.other.package.java"},
      2 => {name: "storage.modifier.package.java"},
      3 => {name: "punctuation.terminator.java"}},
    match: /^\s*(?<_1>package)\b(?:\s*(?<_2>[^ ;$]+)\s*(?<_3>;)?)?/,
    name: "meta.package.java"},
   {captures: 
     {1 => {name: "keyword.other.import.static.java"},
      2 => {name: "storage.modifier.import.java"},
      3 => {name: "punctuation.terminator.java"}},
    match: /^\s*(?<_1>import static)\b(?:\s*(?<_2>[^ ;$]+)\s*(?<_3>;)?)?/,
    name: "meta.import.static.java"},
   {captures: 
     {1 => {name: "keyword.other.import.java"},
      2 => {name: "storage.modifier.import.java"},
      3 => {name: "punctuation.terminator.java"}},
    match: /^\s*(?<_1>import)\b(?:\s*(?<_2>[^ ;$]+)\s*(?<_3>;)?)?/,
    name: "meta.import.java"},
   {include: "#code"}],
 repository: 
  {:"all-types" => 
    {patterns: 
      [{include: "#primitive-arrays"},
       {include: "#primitive-types"},
       {include: "#object-types"}]},
   annotations: 
    {patterns: 
      [{begin: /(?<_1>@[^ (?<_2>]+)(?<_3>\()/,
        beginCaptures: 
         {1 => {name: "storage.type.annotation.java"},
          2 => 
           {name: "punctuation.definition.annotation-arguments.begin.java"}},
        end: "(\\))",
        endCaptures: 
         {1 => {name: "punctuation.definition.annotation-arguments.end.java"}},
        name: "meta.declaration.annotation.java",
        patterns: 
         [{captures: 
            {1 => {name: "constant.other.key.java"},
             2 => {name: "keyword.operator.assignment.java"}},
           match: /(?<_1>\w*)\s*(?<_2>=)/},
          {include: "#code"},
          {match: /,/, name: "punctuation.seperator.property.java"}]},
       {match: /@\w*/, name: "storage.type.annotation.java"}]},
   :"anonymous-classes-and-new" => 
    {begin: /\bnew\b/,
     beginCaptures: {0 => {name: "keyword.control.new.java"}},
     end: "(?<=\\)|\\])(?!\\s*{)|(?<=})|(?=;)",
     patterns: 
      [{begin: /(?<_1>\w+)\s*(?=\[)/,
        beginCaptures: {1 => {name: "storage.type.java"}},
        end: "}|(?=;|\\))",
        patterns: 
         [{begin: /\[/, end: "\\]", patterns: [{include: "#code"}]},
          {begin: /{/, end: "(?=})", patterns: [{include: "#code"}]}]},
       {begin: /(?=\w.*\()/,
        end: "(?<=\\))",
        patterns: 
         [{include: "#object-types"},
          {begin: /\(/,
           beginCaptures: {1 => {name: "storage.type.java"}},
           end: "\\)",
           patterns: [{include: "#code"}]}]},
       {begin: /{/,
        end: "}",
        name: "meta.inner-class.java",
        patterns: [{include: "#class-body"}]}]},
   assertions: 
    {patterns: 
      [{begin: /\b(?<_1>assert)\s/,
        beginCaptures: {1 => {name: "keyword.control.assert.java"}},
        end: "$",
        name: "meta.declaration.assertion.java",
        patterns: 
         [{match: /:/,
           name: "keyword.operator.assert.expression-seperator.java"},
          {include: "#code"}]}]},
   class: 
    {begin: /(?=\w?[\w\s]*(?:class|(?:@)?interface|enum)\s+\w+)/,
     end: "}",
     endCaptures: {0 => {name: "punctuation.section.class.end.java"}},
     name: "meta.class.java",
     patterns: 
      [{include: "#storage-modifiers"},
       {include: "#comments"},
       {captures: 
         {1 => {name: "storage.modifier.java"},
          2 => {name: "entity.name.type.class.java"}},
        match: /(?<_1>class|(?:@)?interface|enum)\s+(?<_2>\w+)/,
        name: "meta.class.identifier.java"},
       {begin: /extends/,
        beginCaptures: {0 => {name: "storage.modifier.extends.java"}},
        end: "(?={|implements)",
        name: "meta.definition.class.inherited.classes.java",
        patterns: 
         [{include: "#object-types-inherited"}, {include: "#comments"}]},
       {begin: /(?<_1>implements)\s/,
        beginCaptures: {1 => {name: "storage.modifier.implements.java"}},
        end: "(?=\\s*extends|\\{)",
        name: "meta.definition.class.implemented.interfaces.java",
        patterns: 
         [{include: "#object-types-inherited"}, {include: "#comments"}]},
       {begin: /{/,
        end: "(?=})",
        name: "meta.class.body.java",
        patterns: [{include: "#class-body"}]}]},
   :"class-body" => 
    {patterns: 
      [{include: "#comments"},
       {include: "#class"},
       {include: "#enums"},
       {include: "#methods"},
       {include: "#annotations"},
       {include: "#storage-modifiers"},
       {include: "#code"}]},
   code: 
    {patterns: 
      [{include: "#comments"},
       {include: "#class"},
       {begin: /{/, end: "}", patterns: [{include: "#code"}]},
       {include: "#assertions"},
       {include: "#parens"},
       {include: "#constants-and-special-vars"},
       {include: "#anonymous-classes-and-new"},
       {include: "#keywords"},
       {include: "#storage-modifiers"},
       {include: "#strings"},
       {include: "#all-types"}]},
   comments: 
    {patterns: 
      [{captures: {0 => {name: "punctuation.definition.comment.java"}},
        match: /\/\*\*\//,
        name: "comment.block.empty.java"},
       {include: "text.html.javadoc"},
       {include: "#comments-inline"}]},
   :"comments-inline" => 
    {patterns: 
      [{begin: /\/\*/,
        captures: {0 => {name: "punctuation.definition.comment.java"}},
        end: "\\*/",
        name: "comment.block.java"},
       {captures: 
         {1 => {name: "comment.line.double-slash.java"},
          2 => {name: "punctuation.definition.comment.java"}},
        match: /\s*(?<_1>(?<_2>\/\/).*$\n?)/}]},
   :"constants-and-special-vars" => 
    {patterns: 
      [{match: /\b(?<_1>true|false|null)\b/, name: "constant.language.java"},
       {match: /\b(?<_1>this|super)\b/, name: "variable.language.java"},
       {match: 
         /\b(?<_1>(?<_2>0(?<_3>x|X)[0-9a-fA-F]*)|(?<_4>(?<_5>[0-9]+\.?[0-9]*)|(?<_6>\.[0-9]+))(?<_7>(?<_8>e|E)(?<_9>\+|-)?[0-9]+)?)(?<_10>[LlFfUuDd]|UL|ul)?\b/,
        name: "constant.numeric.java"},
       {captures: {1 => {name: "keyword.operator.dereference.java"}},
        match: /(?<_1>\.)?\b(?<_2>[A-Z][A-Z0-9_]+)(?!<|\.class|\s*\w+\s*=)\b/,
        name: "constant.other.java"}]},
   enums: 
    {begin: /^(?=\s*[A-Z0-9_]+\s*(?<_1>{|\(|,))/,
     end: "(?=;|})",
     patterns: 
      [{begin: /\w+/,
        beginCaptures: {0 => {name: "constant.other.enum.java"}},
        end: "(?=,|;|})",
        name: "meta.enum.java",
        patterns: 
         [{include: "#parens"},
          {begin: /{/, end: "}", patterns: [{include: "#class-body"}]}]}]},
   keywords: 
    {patterns: 
      [{match: /\b(?<_1>try|catch|finally|throw)\b/,
        name: "keyword.control.catch-exception.java"},
       {match: /\?|:/, name: "keyword.control.java"},
       {match: 
         /\b(?<_1>return|break|case|continue|default|do|while|for|switch|if|else)\b/,
        name: "keyword.control.java"},
       {match: /\b(?<_1>instanceof)\b/, name: "keyword.operator.java"},
       {match: /(?<_1>==|!=|<=|>=|<>|<|>)/,
        name: "keyword.operator.comparison.java"},
       {match: /(?<_1>=)/, name: "keyword.operator.assignment.java"},
       {match: /(?<_1>\-\-|\+\+)/,
        name: "keyword.operator.increment-decrement.java"},
       {match: /(?<_1>\-|\+|\*|\/|%)/,
        name: "keyword.operator.arithmetic.java"},
       {match: /(?<_1>!|&&|\|\|)/, name: "keyword.operator.logical.java"},
       {match: /(?<=\S)\.(?=\S)/, name: "keyword.operator.dereference.java"},
       {match: /;/, name: "punctuation.terminator.java"}]},
   methods: 
    {begin: /(?!new)(?=\w.*\s+)(?=[^=]+\()/,
     end: "}|(?=;)",
     name: "meta.method.java",
     patterns: 
      [{include: "#storage-modifiers"},
       {begin: /(?<_1>\w+)\s*\(/,
        beginCaptures: {1 => {name: "entity.name.function.java"}},
        end: "\\)",
        name: "meta.method.identifier.java",
        patterns: [{include: "#parameters"}]},
       {begin: /(?=\w.*\s+\w+\s*\()/,
        end: "(?=\\w+\\s*\\()",
        name: "meta.method.return-type.java",
        patterns: [{include: "#all-types"}]},
       {include: "#throws"},
       {begin: /{/,
        end: "(?=})",
        name: "meta.method.body.java",
        patterns: [{include: "#code"}]}]},
   :"object-types" => 
    {patterns: 
      [{begin: /\b(?<_1>(?:[a-z]\w*\.)*[A-Z]+\w*)</,
        end: ">|[^\\w\\s,\\?<\\[\\]]",
        name: "storage.type.generic.java",
        patterns: 
         [{include: "#object-types"},
          {begin: /</,
           comment: "This is just to support <>'s with no actual type prefix",
           end: ">|[^\\w\\s,\\[\\]<]",
           name: "storage.type.generic.java"}]},
       {begin: /\b(?<_1>(?:[a-z]\w*\.)*[A-Z]+\w*)(?=\[)/,
        end: "(?=[^\\]\\s])",
        name: "storage.type.object.array.java",
        patterns: [{begin: /\[/, end: "\\]", patterns: [{include: "#code"}]}]},
       {captures: {1 => {name: "keyword.operator.dereference.java"}},
        match: /\b(?:[a-z]\w*(?<_1>\.))*[A-Z]+\w*\b/,
        name: "storage.type.java"}]},
   :"object-types-inherited" => 
    {patterns: 
      [{begin: /\b(?<_1>(?:[a-z]\w*\.)*[A-Z]+\w*)</,
        end: ">|[^\\w\\s,<]",
        name: "entity.other.inherited-class.java",
        patterns: 
         [{include: "#object-types"},
          {begin: /</,
           comment: "This is just to support <>'s with no actual type prefix",
           end: ">|[^\\w\\s,<]",
           name: "storage.type.generic.java"}]},
       {captures: {1 => {name: "keyword.operator.dereference.java"}},
        match: /\b(?:[a-z]\w*(?<_1>\.))*[A-Z]+\w*/,
        name: "entity.other.inherited-class.java"}]},
   parameters: 
    {patterns: 
      [{match: /final/, name: "storage.modifier.java"},
       {include: "#primitive-arrays"},
       {include: "#primitive-types"},
       {include: "#object-types"},
       {match: /\w+/, name: "variable.parameter.java"}]},
   parens: {begin: /\(/, end: "\\)", patterns: [{include: "#code"}]},
   :"primitive-arrays" => 
    {patterns: 
      [{match: 
         /\b(?:void|boolean|byte|char|short|int|float|long|double)(?<_1>\[\])*\b/,
        name: "storage.type.primitive.array.java"}]},
   :"primitive-types" => 
    {patterns: 
      [{match: /\b(?:void|boolean|byte|char|short|int|float|long|double)\b/,
        name: "storage.type.primitive.java"}]},
   :"storage-modifiers" => 
    {captures: {1 => {name: "storage.modifier.java"}},
     match: 
      /\b(?<_1>public|private|protected|static|final|native|synchronized|abstract|threadsafe|transient)\b/},
   strings: 
    {patterns: 
      [{begin: /"/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.begin.java"}},
        end: "\"",
        endCaptures: {0 => {name: "punctuation.definition.string.end.java"}},
        name: "string.quoted.double.java",
        patterns: [{match: /\\./, name: "constant.character.escape.java"}]},
       {begin: /'/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.begin.java"}},
        end: "'",
        endCaptures: {0 => {name: "punctuation.definition.string.end.java"}},
        name: "string.quoted.single.java",
        patterns: [{match: /\\./, name: "constant.character.escape.java"}]}]},
   throws: 
    {begin: /throws/,
     beginCaptures: {0 => {name: "storage.modifier.java"}},
     end: "(?={|;)",
     name: "meta.throwables.java",
     patterns: [{include: "#object-types"}]},
   values: 
    {patterns: 
      [{include: "#strings"},
       {include: "#object-types"},
       {include: "#constants-and-special-vars"}]}},
 scopeName: "source.java",
 uuid: "2B449DF6-6B1D-11D9-94EC-000D93589AF6"}
