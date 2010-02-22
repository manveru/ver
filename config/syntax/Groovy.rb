# Encoding: UTF-8

{fileTypes: ["groovy", "gvy"],
 foldingStartMarker: /(?<_1>\{\s*$|^\s*\/\/ \{\{\{)/,
 foldingStopMarker: /^\s*(?<_1>\}|\/\/ \}\}\}$)/,
 keyEquivalent: "^~G",
 name: "Groovy",
 patterns: 
  [{captures: {1 => {name: "punctuation.definition.comment.groovy"}},
    match: /^(?<_1>#!).+$\n/,
    name: "comment.line.hashbang.groovy"},
   {captures: 
     {1 => {name: "keyword.other.package.groovy"},
      2 => {name: "storage.modifier.package.groovy"},
      3 => {name: "punctuation.terminator.groovy"}},
    match: /^\s*(?<_1>package)\b(?:\s*(?<_2>[^ ;$]+)\s*(?<_3>;)?)?/,
    name: "meta.package.groovy"},
   {captures: 
     {1 => {name: "keyword.other.import.groovy"},
      2 => {name: "keyword.other.import.static.groovy"},
      3 => {name: "storage.modifier.import.groovy"},
      4 => {name: "punctuation.terminator.groovy"}},
    match: 
     /^\s*(?<_1>import)(?:\s+(?<_2>static)\s+)\b(?:\s*(?<_3>[^ ;$]+)\s*(?<_4>;)?)?/,
    name: "meta.import.static.groovy"},
   {captures: 
     {1 => {name: "keyword.other.import.groovy"},
      2 => {name: "storage.modifier.import.groovy"},
      3 => {name: "punctuation.terminator.groovy"}},
    match: /^\s*(?<_1>import)\b(?:\s*(?<_2>[^ ;$]+)\s*(?<_3>;)?)?/,
    name: "meta.import.groovy"},
   {captures: 
     {1 => {name: "keyword.other.import.groovy"},
      2 => {name: "keyword.other.import.static.groovy"},
      3 => {name: "storage.modifier.import.groovy"},
      4 => {name: "punctuation.terminator.groovy"}},
    match: 
     /^\s*(?<_1>import)(?:\s+(?<_2>static)\s+)\b(?:\s*(?<_3>[^ ;$]+)\s*(?<_4>;)?)?/,
    name: "meta.import.groovy"},
   {include: "#groovy"}],
 repository: 
  {annotations: 
    {patterns: 
      [{begin: /(?<!\.)(?<_1>@[^ (?<_2>]+)(?<_3>\()/,
        beginCaptures: 
         {1 => {name: "storage.type.annotation.groovy"},
          2 => 
           {name: "punctuation.definition.annotation-arguments.begin.groovy"}},
        end: "(\\))",
        endCaptures: 
         {1 => 
           {name: "punctuation.definition.annotation-arguments.end.groovy"}},
        name: "meta.declaration.annotation.groovy",
        patterns: 
         [{captures: 
            {1 => {name: "constant.other.key.groovy"},
             2 => {name: "keyword.operator.assignment.groovy"}},
           match: /(?<_1>\w*)\s*(?<_2>=)/},
          {include: "#values"},
          {match: /,/, name: "punctuation.definition.seperator.groovy"}]},
       {match: /(?<!\.)@\S+/, name: "storage.type.annotation.groovy"}]},
   braces: {begin: /\{/, end: "\\}", patterns: [{include: "#groovy-code"}]},
   class: 
    {begin: /(?=\w?[\w\s]*(?:class|(?:@)?interface|enum)\s+\w+)/,
     end: "}",
     endCaptures: {0 => {name: "punctuation.section.class.end.groovy"}},
     name: "meta.definition.class.groovy",
     patterns: 
      [{include: "#storage-modifiers"},
       {include: "#comments"},
       {captures: 
         {1 => {name: "storage.modifier.groovy"},
          2 => {name: "entity.name.type.class.groovy"}},
        match: /(?<_1>class|(?:@)?interface|enum)\s+(?<_2>\w+)/,
        name: "meta.class.identifier.groovy"},
       {begin: /extends/,
        beginCaptures: {0 => {name: "storage.modifier.extends.groovy"}},
        end: "(?={|implements)",
        name: "meta.definition.class.inherited.classes.groovy",
        patterns: 
         [{include: "#object-types-inherited"}, {include: "#comments"}]},
       {begin: /(?<_1>implements)\s/,
        beginCaptures: {1 => {name: "storage.modifier.implements.groovy"}},
        end: "(?=\\s*extends|\\{)",
        name: "meta.definition.class.implemented.interfaces.groovy",
        patterns: 
         [{include: "#object-types-inherited"}, {include: "#comments"}]},
       {begin: /{/,
        end: "(?=})",
        name: "meta.class.body.groovy",
        patterns: [{include: "#groovy"}]}]},
   :"class-variables" => 
    {patterns: 
      [{begin: /\b(?!as)(?=\w[\w\[\]<>,]*?\s\w)/,
        end: ";|$",
        name: "meta.definition.class-variable.groovy",
        patterns: 
         [{captures: {1 => {name: "constant.class-variable.groovy"}},
           match: /(?<_1>[A-Z_0-9]+)\s+(?=\=)/},
          {captures: 
            {1 => {name: "meta.definition.class-variable.name.groovy"}},
           match: /(?<_1>\w[^\s,]*)\s+(?=\=)/},
          {begin: /=/,
           beginCaptures: {0 => {name: "keyword.operator.assignment.groovy"}},
           end: "$",
           patterns: [{include: "#groovy-code"}]},
          {captures: 
            {1 => {name: "meta.definition.class-variable.name.groovy"}},
           match: /(?<_1>\w\S*)(?=\s*(?<_2>$|;))/},
          {include: "#groovy-code"}]}]},
   closures: 
    {begin: /\{(?=.*->)/,
     end: "\\}",
     patterns: 
      [{begin: /(?!->)/,
        end: "(?=->)",
        patterns: 
         [{begin: /(?!->)/,
           end: "(?=->)",
           name: "meta.closure.parameters.groovy",
           patterns: 
            [{begin: /(?!,|->)/,
              end: "(?=,|->)",
              name: "meta.closure.parameter.groovy",
              patterns: 
               [{begin: /=/,
                 beginCaptures: 
                  {0 => {name: "keyword.operator.assignment.groovy"}},
                 end: "(?=,|->)",
                 name: "meta.parameter.default.groovy",
                 patterns: [{include: "#groovy-code"}]},
                {include: "#parameters"}]}]}]},
       {begin: /->/,
        beginCaptures: {0 => {name: "keyword.operator.groovy"}},
        end: "(?=\\})",
        patterns: [{include: "#groovy-code"}]}]},
   :"comment-block" => 
    {begin: /\/\*/,
     captures: {0 => {name: "punctuation.definition.comment.groovy"}},
     end: "\\*/",
     name: "comment.block.groovy"},
   comments: 
    {patterns: 
      [{captures: {0 => {name: "punctuation.definition.comment.groovy"}},
        match: /\/\*\*\//,
        name: "comment.block.empty.groovy"},
       {include: "text.html.javadoc"},
       {include: "#comment-block"},
       {captures: {1 => {name: "punctuation.definition.comment.groovy"}},
        match: /(?<_1>\/\/).*$\n?/,
        name: "comment.line.double-slash.groovy"}]},
   constants: 
    {patterns: 
      [{match: /\b(?<_1>[A-Z][A-Z0-9_]+)\b/, name: "constant.other.groovy"},
       {match: /\b(?<_1>true|false|null)\b/,
        name: "constant.language.groovy"}]},
   :"enum-values" => 
    {patterns: 
      [{begin: /\b[A-Z0-9_]*(?=\s*(?:,|;|}|\(|$))/,
        beginCaptures: {0 => {name: "constant.enum.name.groovy"}},
        end: ",|;|(?=})|^(?!\\s*\\w+\\s*(?:,|$))",
        patterns: 
         [{begin: /\(/,
           end: "\\)",
           name: "meta.enum.value.groovy",
           patterns: [{include: "#values"}]}]}]},
   groovy: 
    {patterns: 
      [{include: "#comments"},
       {include: "#annotations"},
       {include: "#class"},
       {include: "#enum-values"},
       {include: "#methods"},
       {include: "#class-variables"},
       {include: "#groovy-code"}]},
   :"groovy-code" => 
    {patterns: 
      [{include: "#groovy-code-minus-map-keys"}, {include: "#map-keys"}]},
   :"groovy-code-minus-map-keys" => 
    {comment: 
      "In some situations, maps can't be declared without enclosing []'s, \n\t\t\t\ttherefore we create a collection of everything but that",
     patterns: 
      [{include: "#comments"},
       {include: "#annotations"},
       {include: "#support-functions"},
       {include: "#keyword-language"},
       {include: "#values"},
       {include: "#keyword-operator"},
       {include: "#types"},
       {include: "#storage-modifiers"},
       {include: "#parens"},
       {include: "#closures"},
       {include: "#braces"}]},
   keyword: 
    {patterns: 
      [{include: "#keyword-operator"}, {include: "#keyword-language"}]},
   :"keyword-language" => 
    {patterns: 
      [{match: /\b(?<_1>try|catch|finally|throw)\b/,
        name: "keyword.control.exception.groovy"},
       {match: 
         /\b(?<_1>(?<!\.)(?:return|break|continue|default|do|while|for|switch|if|else))\b/,
        name: "keyword.control.groovy"},
       {begin: /\bcase\b/,
        beginCaptures: {0 => {name: "keyword.control.groovy"}},
        end: ":",
        endCaptures: 
         {0 => {name: "punctuation.definition.case-terminator.groovy"}},
        name: "meta.case.groovy",
        patterns: [{include: "#groovy-code-minus-map-keys"}]},
       {match: /\b(?<_1>new)\b/, name: "keyword.other.new.groovy"},
       {begin: /\b(?<_1>assert)\s/,
        beginCaptures: {1 => {name: "keyword.control.assert.groovy"}},
        end: "$",
        name: "meta.declaration.assertion.groovy",
        patterns: 
         [{match: /:/,
           name: "keyword.operator.assert.expression-seperator.groovy"},
          {include: "#groovy-code-minus-map-keys"}]},
       {match: /\b(?<_1>throws)\b/, name: "keyword.other.throws.groovy"}]},
   :"keyword-operator" => 
    {patterns: 
      [{match: /\b(?<_1>as)\b/, name: "keyword.operator.as.groovy"},
       {match: /\b(?<_1>is)\b/, name: "keyword.operator.is.groovy"},
       {match: /\?\:/, name: "keyword.operator.elvis.groovy"},
       {match: /\.\./, name: "keyword.operator.range.groovy"},
       {match: /\->/, name: "keyword.operator.arrow.groovy"},
       {match: /<</, name: "keyword.operator.leftshift.groovy"},
       {match: /(?<=\S)\.(?=\S)/, name: "keyword.operator.navigation.groovy"},
       {match: /(?<=\S)\?\.(?=\S)/,
        name: "keyword.operator.safe-navigation.groovy"},
       {begin: /\?/,
        beginCaptures: {0 => {name: "keyword.operator.ternary.groovy"}},
        end: "(?=$|\\)|})",
        name: "meta.evaluation.ternary.groovy",
        patterns: 
         [{match: /:/,
           name: "keyword.operator.ternary.expression-seperator.groovy"},
          {include: "#groovy-code-minus-map-keys"}]},
       {match: /==~/, name: "keyword.operator.match.groovy"},
       {match: /=~/, name: "keyword.operator.find.groovy"},
       {match: /\b(?<_1>instanceof)\b/,
        name: "keyword.operator.instanceof.groovy"},
       {match: /(?<_1>===|==|!=|<=|>=|<=>|<>|<|>|<<)/,
        name: "keyword.operator.comparison.groovy"},
       {match: /=/, name: "keyword.operator.assignment.groovy"},
       {match: /(?<_1>\-\-|\+\+)/,
        name: "keyword.operator.increment-decrement.groovy"},
       {match: /(?<_1>\-|\+|\*|\/|%)/,
        name: "keyword.operator.arithmetic.groovy"},
       {match: /(?<_1>!|&&|\|\|)/, name: "keyword.operator.logical.groovy"}]},
   :"map-keys" => 
    {patterns: 
      [{captures: 
         {1 => {name: "constant.other.key.groovy"},
          2 => {name: "punctuation.definition.seperator.key-value.groovy"}},
        match: /(?<_1>\w+)\s*(?<_2>:)/}]},
   :"method-call" => 
    {begin: /(?<_1>\w+)(?<_2>\()/,
     beginCaptures: 
      {1 => {name: "meta.method.groovy"},
       2 => {name: "punctuation.definition.method-parameters.begin.groovy"}},
     end: "\\)",
     endCaptures: 
      {0 => {name: "punctuation.definition.method-parameters.end.groovy"}},
     name: "meta.method-call.groovy",
     patterns: 
      [{match: /,/, name: "punctuation.definition.seperator.parameter.groovy"},
       {include: "#groovy-code"}]},
   methods: 
    {applyEndPatternLast: 1,
     begin: 
      /(?x:
	    (?<!\.)\b # not preceeded by . (?<_1>method call)
	    (?!new) # not before new
	    (?= # looking forward we see
	        (?:
	            (?:\w|<)\S* # a word (?<_2>modifier or return type) or a parameter type
	            \s+ # some space
	            (?:\w|<)\S*[^=\.\s]*? # another word and anything but =, . or space
	            | # or
	            [A-Z_]\w* # a capitalised word (?<_3>i.e. constructor name)
	        )
	        \( # and the leading parens of the params
	    )
	)/,
     end: "}|(?=(^\\s*)?[^{])",
     name: "meta.definition.method.groovy",
     patterns: 
      [{match: /\s/},
       {include: "#storage-modifiers"},
       {begin: /(?<_1>\w+)\s*\(/,
        beginCaptures: {1 => {name: "entity.name.function.java"}},
        end: "\\)",
        name: "meta.definition.method.signature.java",
        patterns: 
         [{begin: /(?=[^)])/,
           end: "(?=\\))",
           name: "meta.method.parameters.groovy",
           patterns: 
            [{begin: /(?=[^,)])/,
              end: "(?=,|\\))",
              name: "meta.method.parameter.groovy",
              patterns: 
               [{match: /,/, name: "punctuation.definition.separator.groovy"},
                {begin: /=/,
                 beginCaptures: 
                  {0 => {name: "keyword.operator.assignment.groovy"}},
                 end: "(?=,|\\))",
                 name: "meta.parameter.default.groovy",
                 patterns: [{include: "#groovy-code"}]},
                {include: "#parameters"}]}]}]},
       {begin: /(?=<)/,
        end: "(?=\\s)",
        name: "meta.method.paramerised-type.groovy",
        patterns: 
         [{begin: /</,
           end: ">",
           name: "storage.type.parameters.groovy",
           patterns: 
            [{include: "#types"},
             {match: /,/, name: "punctuation.definition.seperator.groovy"}]}]},
       {begin: /(?=(?:\w|<).*\s+(?:\w|<)+\s*\()/,
        end: "(?=\\w+\\s*\\()",
        name: "meta.method.return-type.java",
        patterns: [{include: "#types"}]},
       {begin: /throws/,
        beginCaptures: {0 => {name: "storage.modifier.groovy"}},
        end: "(?={|;)|^(?=\\s*(?:[^{\\s]|$))",
        name: "meta.throwables.groovy",
        patterns: [{include: "#object-types"}]},
       {begin: /{/,
        end: "(?=})",
        name: "meta.method.body.java",
        patterns: [{include: "#groovy-code"}]}]},
   nest_curly: 
    {begin: /\{/,
     captures: {0 => {name: "punctuation.section.scope.groovy"}},
     end: "\\}",
     patterns: [{include: "#nest_curly"}]},
   numbers: 
    {patterns: 
      [{match: 
         /(?<_1>(?<_2>0(?<_3>x|X)[0-9a-fA-F]*)|(?<_4>\+|-)?\b(?<_5>(?<_6>[0-9]+\.?[0-9]*)|(?<_7>\.[0-9]+))(?<_8>(?<_9>e|E)(?<_10>\+|-)?[0-9]+)?)(?<_11>[LlFfUuDd]|UL|ul)?\b/,
        name: "constant.numeric.groovy"}]},
   :"object-types" => 
    {patterns: 
      [{begin: /\b(?<_1>(?:[a-z]\w*\.)*[A-Z]+\w*)</,
        end: ">|[^\\w\\s,\\?<\\[\\]]",
        name: "storage.type.generic.groovy",
        patterns: 
         [{include: "#object-types"},
          {begin: /</,
           comment: "This is just to support <>'s with no actual type prefix",
           end: ">|[^\\w\\s,\\[\\]<]",
           name: "storage.type.generic.groovy"}]},
       {begin: /\b(?<_1>(?:[a-z]\w*\.)*[A-Z]+\w*)(?=\[)/,
        end: "(?=[^\\]\\s])",
        name: "storage.type.object.array.groovy",
        patterns: 
         [{begin: /\[/, end: "\\]", patterns: [{include: "#groovy"}]}]},
       {captures: {1 => {name: "keyword.operator.dereference.groovy"}},
        match: /\b(?:[a-z]\w*(?<_1>\.))*[A-Z]+\w*\b/,
        name: "storage.type.groovy"}]},
   :"object-types-inherited" => 
    {patterns: 
      [{begin: /\b(?<_1>(?:[a-z]\w*\.)*[A-Z]+\w*)</,
        end: ">|[^\\w\\s,\\?<\\[\\]]",
        name: "entity.other.inherited-class.groovy",
        patterns: 
         [{include: "#object-types-inherited"},
          {begin: /</,
           comment: "This is just to support <>'s with no actual type prefix",
           end: ">|[^\\w\\s,\\[\\]<]",
           name: "storage.type.generic.groovy"}]},
       {captures: {1 => {name: "keyword.operator.dereference.groovy"}},
        match: /\b(?:[a-z]\w*(?<_1>\.))*[A-Z]+\w*\b/,
        name: "entity.other.inherited-class.groovy"}]},
   parameters: 
    {patterns: 
      [{include: "#annotations"},
       {include: "#storage-modifiers"},
       {include: "#types"},
       {match: /\w+/, name: "variable.parameter.method.groovy"}]},
   parens: {begin: /\(/, end: "\\)", patterns: [{include: "#groovy-code"}]},
   :"primitive-arrays" => 
    {patterns: 
      [{match: 
         /\b(?:void|boolean|byte|char|short|int|float|long|double)(?<_1>\[\])*\b/,
        name: "storage.type.primitive.array.groovy"}]},
   :"primitive-types" => 
    {patterns: 
      [{match: /\b(?:void|boolean|byte|char|short|int|float|long|double)\b/,
        name: "storage.type.primitive.groovy"}]},
   regexp: 
    {patterns: 
      [{begin: /\/(?=[^\/]+\/)/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.regexp.begin.groovy"}},
        end: "/",
        endCaptures: 
         {0 => {name: "punctuation.definition.string.regexp.end.groovy"}},
        name: "string.regexp.groovy",
        patterns: 
         [{match: /\\./, name: "constant.character.escape.groovy"}]}]},
   :"storage-modifiers" => 
    {patterns: 
      [{match: /\b(?<_1>private|protected|public)\b/,
        name: "storage.modifier.access-control.groovy"},
       {match: /\b(?<_1>static)\b/, name: "storage.modifier.static.groovy"},
       {match: /\b(?<_1>final)\b/, name: "storage.modifier.final.groovy"},
       {match: /\b(?<_1>native|synchronized|abstract|threadsafe|transient)\b/,
        name: "storage.modifier.other.groovy"}]},
   :"string-quoted-double" => 
    {begin: /"/,
     beginCaptures: 
      {0 => {name: "punctuation.definition.string.begin.groovy"}},
     end: "\"",
     endCaptures: {0 => {name: "punctuation.definition.string.end.groovy"}},
     name: "string.quoted.double.groovy",
     patterns: [{include: "#string-quoted-double-contents"}]},
   :"string-quoted-double-contents" => 
    {patterns: 
      [{match: /\\./, name: "constant.character.escape.groovy"},
       {match: /\$\w+/, name: "variable.other.interpolated.groovy"},
       {begin: /\$\{/,
        captures: {0 => {name: "punctuation.section.embedded.groovy"}},
        end: "\\}",
        name: "source.groovy.embedded.source",
        patterns: [{include: "#nest_curly"}]}]},
   :"string-quoted-double-multiline" => 
    {begin: /"""/,
     beginCaptures: 
      {0 => {name: "punctuation.definition.string.begin.groovy"}},
     end: "\"\"\"",
     endCaptures: {0 => {name: "punctuation.definition.string.end.groovy"}},
     name: "string.quoted.double.multiline.groovy",
     patterns: [{include: "#string-quoted-double-contents"}]},
   :"string-quoted-single" => 
    {begin: /'/,
     beginCaptures: 
      {0 => {name: "punctuation.definition.string.begin.groovy"}},
     end: "'",
     endCaptures: {0 => {name: "punctuation.definition.string.end.groovy"}},
     name: "string.quoted.single.groovy",
     patterns: [{include: "#string-quoted-single-contents"}]},
   :"string-quoted-single-contents" => 
    {patterns: [{match: /\\./, name: "constant.character.escape.groovy"}]},
   :"string-quoted-single-multiline" => 
    {begin: /'''/,
     beginCaptures: 
      {0 => {name: "punctuation.definition.string.begin.groovy"}},
     end: "'''",
     endCaptures: {0 => {name: "punctuation.definition.string.end.groovy"}},
     name: "string.quoted.single.multiline.groovy",
     patterns: [{include: "#string-quoted-single-contents"}]},
   strings: 
    {patterns: 
      [{include: "#string-quoted-double-multiline"},
       {include: "#string-quoted-single-multiline"},
       {include: "#string-quoted-double"},
       {include: "#string-quoted-single"},
       {include: "#regexp"}]},
   structures: 
    {begin: /\[/,
     beginCaptures: 
      {0 => {name: "punctuation.definition.structure.begin.groovy"}},
     end: "\\]",
     endCaptures: {0 => {name: "punctuation.definition.structure.end.groovy"}},
     name: "meta.structure.groovy",
     patterns: 
      [{include: "#groovy-code"},
       {match: /,/, name: "punctuation.definition.separator.groovy"}]},
   :"support-functions" => 
    {patterns: 
      [{match: /(?x)\b(?:sprintf|print(?:f|ln)?)\b/,
        name: "support.function.print.groovy"},
       {match: 
         /(?x)\b(?:shouldFail|fail(?:NotEquals)?|ass(?:ume|ert(?:S(?:cript|ame)|N(?:ot(?:Same|
	Null)|ull)|Contains|T(?:hat|oString|rue)|Inspect|Equals|False|Length|
	ArrayEquals)))\b/,
        name: "support.function.testing.groovy"}]},
   types: 
    {patterns: 
      [{match: /\b(?<_1>def)\b/, name: "storage.type.def.groovy"},
       {include: "#primitive-types"},
       {include: "#primitive-arrays"},
       {include: "#object-types"}]},
   values: 
    {patterns: 
      [{include: "#variables"},
       {include: "#strings"},
       {include: "#numbers"},
       {include: "#constants"},
       {include: "#types"},
       {include: "#structures"},
       {include: "#method-call"}]},
   variables: 
    {patterns: 
      [{match: /\b(?<_1>this|super)\b/, name: "variable.language.groovy"}]}},
 scopeName: "source.groovy",
 uuid: "B3A64888-EBBB-4436-8D9E-F1169C5D7613"}
