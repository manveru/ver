# Encoding: UTF-8

{fileTypes: ["ml", "mli"],
 foldingStartMarker: 
  /(?<_1>\b(?<_2>module|class|)\s.*?=\s*$|\bbegin|sig|struct|(?<_3>object(?<_4>\s*\(_?[a-z]+\))?)\s*$|\bwhile\s.*?\bdo\s*$|^let(?:\s+rec)?\s+[a-z_][a-zA-Z0-9_]*\s+(?!=)\S)/,
 foldingStopMarker: 
  /(?<_1>\bend(?<_2>\s+in)?[ \t]*(?<_3>;{1,2}|=)?|\bdone;?|^\s*;;|^\s*in)[ \t]*$/,
 keyEquivalent: "^~O",
 name: "OCaml",
 patterns: 
  [{captures: 
     {1 => {name: "keyword.other.module-binding.ocaml"},
      2 => {name: "keyword.other.module-definition.ocaml"},
      3 => {name: "support.other.module.ocaml"},
      4 => {name: "punctuation.separator.module-binding.ocmal"}},
    match: 
     /\b(?<_1>let)\s+(?<_2>module)\s+(?<_3>[A-Z][a-zA-Z0-9'_]*)\s*(?<_4>=)/,
    name: "meta.module.binding"},
   {begin: 
     /\b(?<_1>let|and)\s+(?!\(\*)(?<_2>(?<_3>rec\s+)(?<_4>[a-z_][a-zA-Z0-9_']*)\b|(?<_5>[a-z_][a-zA-Z0-9_']*|\([^)]+\))(?=\s)(?<_6>(?=\s*=\s*(?=fun(?:ction)\b))|(?!\s*=)))/,
    beginCaptures: 
     {1 => {name: "keyword.other.function-definition.ocaml"},
      3 => {name: "keyword.other.funtion-definition.ocaml"},
      4 => {name: "entity.name.function.ocaml"},
      5 => {name: "entity.name.function.ocaml"}},
    end: "(?:(:)\\s*([^=]+))?(?:(=)|(=)\\s*(?=fun(?:ction)\\b))",
    endCaptures: 
     {1 => {name: "punctuation.separator.function.type-constraint.ocaml"},
      2 => {name: "storage.type.ocaml"},
      3 => {name: "keyword.operator.ocaml"},
      4 => {name: "keyword.operator.ocaml"}},
    name: "meta.function.ocaml",
    patterns: [{include: "#variables"}]},
   {begin: /(?<_1>\(|\s)(?=fun\s)/,
    beginCaptures: 
     {1 => {name: "punctuation.definition.function.anonymous.ocaml"}},
    end: "(\\))",
    endCaptures: 
     {1 => {name: "punctuation.definition.function.anonymous.ocaml"}},
    name: "meta.function.anonymous.ocaml",
    patterns: 
     [{begin: /(?<=(?<_1>\(|\s))(?<_2>fun)\s/,
       beginCaptures: {2 => {name: "keyword.other.function-definition.ocaml"}},
       end: "(->)",
       endCaptures: 
        {1 => {name: "punctuation.separator.function-definition.ocaml"}},
       name: "meta.function.anonymous.definition.ocaml",
       patterns: [{include: "#variables"}]},
      {include: "$self"}]},
   {begin: /^\s*(?=type\s)/,
    end: "\\b(?=let|end|val)|^\\s*$",
    name: "meta.type-definition-group.ocaml",
    patterns: 
     [{begin: /\b(?<_1>type|and)\s+(?<_2>[^=]*)(?<_3>=)?/,
       beginCaptures: 
        {1 => {name: "keyword.other.type-definition.ocaml"},
         2 => {name: "storage.type.ocaml"},
         3 => {name: "punctuation.separator.type-definition.ocaml"}},
       end: "(?=\\b(type|and|let|end|val)\\b)|(?=^\\s*$)",
       name: "meta.type-definition.ocaml",
       patterns: [{include: "#typedefs"}]}]},
   {begin: 
     /\b(?<_1>with|function)(?=(?<_2>\s*$|.*->))\b|(?<_3>(?<!\S)(?<_4>\|)(?=(?<_5>\w|\s).*->))/,
    beginCaptures: 
     {1 => {name: "keyword.control.match-definition.ocaml"},
      2 => {name: "keyword.other.function-definition.ocaml"},
      3 => {name: "keyword.control.match-definition.ocaml"}},
    end: "(?:(->)|\\b(when)\\b|\\s(?=\\|))",
    endCaptures: 
     {1 => {name: "punctuation.separator.match-definition.ocaml"},
      2 => {name: "keyword.control.match-condition.ocaml"}},
    name: "meta.pattern-match.ocaml",
    patterns: [{include: "#matchpatterns"}]},
   {captures: 
     {1 => {name: "keyword.other.class-type-definition.ocaml"},
      2 => {name: "entity.name.type.class-type.ocaml"},
      4 => {name: "storage.type.ocaml"}},
    match: 
     /^[ \t]*(?<_1>class\s+type\s+)(?<_2>(?<_3>\[\s*(?<_4>'[A-Za-z][a-zA-Z0-9_']*(?:\s*,\s*'[A-Za-z][a-zA-Z0-9_']*)*)\s*\]\s+)?[a-z_][a-zA-Z0-9'_]*)/,
    name: "meta.class.type-definition.ocaml"},
   {begin: 
     /^[ \t]*(?<_1>class)(?:\s+(?!(?:virtual)\s+))(?<_2>(?<_3>\[\s*(?<_4>'[A-Za-z][a-zA-Z0-9_']*(?:\s*,\s*'[A-Za-z][a-zA-Z0-9_']*)*)\s*\]\s+)?[a-z_][a-zA-Z0-9'_]*)/,
    beginCaptures: 
     {1 => {name: "keyword.other.class-definition.ocaml"},
      2 => {name: "entity.name.type.class.ocaml"},
      4 => {name: "storage.type.ocaml"}},
    end: "(=)",
    endCaptures: {1 => {name: "keyword.operator.ocaml"}},
    name: "meta.class.ocaml",
    patterns: [{include: "#variables"}]},
   {begin: 
     /^[ \t]*(?<_1>class\s+virtual\s+)(?<_2>(?<_3>\[\s*(?<_4>'[A-Za-z][a-zA-Z0-9_']*(?:\s*,\s*'[A-Za-z][a-zA-Z0-9_']*)*)\s*\]\s+)?[a-z_][a-zA-Z0-9'_]*)/,
    beginCaptures: 
     {1 => {name: "keyword.other.class-definition.ocaml"},
      2 => {name: "entity.name.type.class.ocaml"},
      4 => {name: "storage.type.ocaml"}},
    end: "(=)",
    endCaptures: {1 => {name: "keyword.operator.ocaml"}},
    name: "meta.class.virtual.ocaml",
    patterns: [{include: "#variables"}]},
   {captures: 
     {1 => {name: "keyword.other.class-type-definition.ocaml"},
      2 => {name: "entity.name.type.class-type.ocaml"},
      4 => {name: "storage.type.ocaml"}},
    match: 
     /^[ \t]*(?<_1>class\s+type\s+virtual)(?<_2>(?<_3>\[\s*(?<_4>'[A-Za-z][a-zA-Z0-9_']*(?:\s*,\s*'[A-Za-z][a-zA-Z0-9_']*)*)\s*\]\s+)?[a-z_][a-zA-Z0-9'_]*)/,
    name: "meta.class.virtual.type-definition.ocaml"},
   {begin: /(?<_1>\{)/,
    beginCaptures: {1 => {name: "punctuation.definition.record.ocaml"}},
    end: "(\\})",
    endCaptures: {1 => {name: "punctuation.definition.record.ocaml"}},
    name: "meta.record.ocaml",
    patterns: 
     [{match: /\bwith\b/, name: "keyword.other.language.ocaml"},
      {begin: /(?<_1>\bmutable\s+)?\b(?<_2>[a-z_][a-zA-Z0-9_']*)\s*(?<_3>:)/,
       beginCaptures: 
        {1 => {name: "keyword.other.storage.modifier.ocaml"},
         2 => {name: "source.ocaml"},
         3 => {name: "punctuation.definition.record.ocaml"}},
       end: "(;|(?=}))",
       endCaptures: {1 => {name: "keyword.operator.ocaml"}},
       name: "meta.record.definition.ocaml",
       patterns: [{include: "#typedefs"}]},
      {include: "$self"}]},
   {begin: /\b(?<_1>object)\s*(?:(?<_2>\()(?<_3>_?[a-z]+)(?<_4>\)))?\s*$/,
    beginCaptures: 
     {1 => {name: "keyword.other.object-definition.ocaml"},
      2 => {name: "punctuation.definition.self-binding.ocaml"},
      3 => {name: "entity.name.type.self-binding.ocaml"},
      4 => {name: "punctuation.definition.self-binding.ocaml"}},
    end: "\\b(end)\\b",
    endCaptures: 
     {1 => {name: "keyword.control.object.ocaml"},
      2 => {name: "punctuation.terminator.expression.ocaml"}},
    name: "meta.object.ocaml",
    patterns: 
     [{begin: 
        /\b(?<_1>method)\s+(?<_2>virtual\s+)?(?<_3>private\s+)?(?<_4>[a-z_][a-zA-Z0-9'_]*)/,
       beginCaptures: 
        {1 => {name: "keyword.other.method-definition.ocaml"},
         2 => {name: "keyword.other.method-definition.ocaml"},
         3 => {name: "keyword.other.method-restriction.ocaml"},
         4 => {name: "entity.name.function.method.ocaml"}},
       end: "(=|:)",
       endCaptures: {1 => {name: "keyword.operator.ocaml"}},
       name: "meta.method.ocaml",
       patterns: [{include: "#variables"}]},
      {begin: /(?<_1>constraint)\s+(?<_2>[a-z_'][a-zA-Z0-9'_]*)\s+(?<_3>=)/,
       beginCaptures: 
        {1 => {name: "keyword.other.language.ocaml"},
         2 => {name: "storage.type.ocaml"},
         3 => {name: "keyword.operator.ocaml"}},
       end: 
        "(#[a-z_][a-zA-Z0-9'_]*)|(int|char|float|string|list|array|bool|unit|exn|option|int32|int64|nativeint|format4|lazy_t)|([a-z_][a-zA-Z0-9'_]*)\\s*$",
       endCaptures: 
        {1 => {name: "storage.type.polymorphic-variant.ocaml"},
         2 => {name: "storage.type.ocaml"},
         3 => {name: "storage.type.ocaml"}},
       name: "meta.object.type-constraint.ocaml"},
      {include: "$self"}]},
   {captures: {1 => {name: "punctuation.separator.method-call.ocaml"}},
    match: /(?<=\w|\)|')(?<_1>#)[a-z_][a-zA-Z0-9'_]*/,
    name: "meta.method-call.ocaml"},
   {captures: 
     {1 => {name: "keyword.other.module-definition.ocaml"},
      2 => {name: "entity.name.type.module.ocaml"},
      3 => {name: "punctuation.separator.module-definition.ocaml"},
      4 => {name: "entity.name.type.module-type.ocaml"}},
    match: 
     /^[ \t]*(?<_1>module)\s+(?<_2>[A-Z_][a-zA-Z0-9'_]*)(?:\s*(?<_3>:)\s*(?<_4>[A-Z][a-zA-Z0-9'_]*)?)?/,
    name: "meta.module.ocaml"},
   {captures: 
     {1 => {name: "keyword.other.module-type-definition.ocaml"},
      2 => {name: "entity.name.type.module-type.ocaml"}},
    match: /^[ \t]*(?<_1>module\s+type\s+)(?<_2>[A-Z][a-zA-Z0-9'_]*)/,
    name: "meta.module.type.ocaml"},
   {begin: /\b(?<_1>sig)\b/,
    beginCaptures: {1 => {name: "keyword.other.module.signature.ocaml"}},
    end: "\\b(end)\\b",
    endCaptures: 
     {1 => {name: "keyword.other.module.signature.ocaml"},
      2 => {name: "punctuation.terminator.expression.ocaml"},
      3 => {name: "keyword.operator.ocaml"}},
    name: "meta.module.signature.ocaml",
    patterns: [{include: "#module-signature"}, {include: "$self"}]},
   {begin: /\b(?<_1>struct)\b/,
    beginCaptures: {1 => {name: "keyword.other.module.structure.ocaml"}},
    end: "\\b(end)\\b",
    endCaptures: {1 => {name: "keyword.other.module.structure.ocaml"}},
    name: "meta.module.structure.ocaml",
    patterns: [{include: "$self"}]},
   {include: "#moduleref"},
   {begin: 
     /\b(?<_1>open)\s+(?<_2>[A-Z][a-zA-Z0-9'_]*)(?=(?<_3>\.[A-Z][a-zA-Z0-9_]*)*)/,
    beginCaptures: 
     {1 => {name: "keyword.other.ocaml"},
      2 => {name: "support.other.module.ocaml"}},
    end: "(\\s|$)",
    name: "meta.module.open.ocaml",
    patterns: 
     [{captures: {1 => {name: "punctuation.separator.module-reference.ocaml"}},
       match: /(?<_1>\.)(?<_2>[A-Z][a-zA-Z0-9'_]*)/,
       name: "support.other.module.ocaml"}]},
   {captures: 
     {1 => {name: "keyword.other.ocaml"},
      2 => {name: "entity.name.type.exception.ocaml"}},
    match: /\b(?<_1>exception)\s+(?<_2>[A-Z][a-zA-Z0-9'_]*)\b/,
    name: "meta.exception.ocaml"},
   {begin: /(?=(?<_1>\[<)(?![^\[]+?[^>]]))/,
    end: "(>])",
    endCaptures: {1 => {name: "punctuation.definition.camlp4-stream.ocaml"}},
    name: "source.camlp4.embedded.ocaml",
    patterns: [{include: "source.camlp4.ocaml"}]},
   {include: "#strings"},
   {include: "#constants"},
   {include: "#comments"},
   {include: "#lists"},
   {include: "#arrays"},
   {begin: 
     /(?<_1>\()(?=(?<_2>~[a-z][a-zA-Z0-9_]*:|(?<_3>"(?<_4>\\"|[^"])*")|[^\(\)~"])+(?<!:)(?<_5>:>|:(?![:=])))/,
    beginCaptures: {1 => {name: "punctuation.section.type-constraint.ocaml"}},
    end: "(?<!:)(:>|:(?![:=]))(.*?)(\\))",
    endCaptures: 
     {1 => {name: "punctuation.separator.type-constraint.ocaml"},
      2 => {name: "storage.type.ocaml"},
      3 => {name: "punctuation.section.type-constraint.ocaml"}},
    name: "meta.type-constraint.ocaml",
    patterns: [{include: "$self"}]},
   {match: /^[ \t]*#[a-zA-Z]+/, name: "keyword.other.directive.ocaml"},
   {match: /^[ \t]*#[0-9]*/,
    name: "keyword.other.directive.line-number.ocaml"},
   {include: "#storagetypes"},
   {match: /\b(?<_1>mutable|ref)\b/,
    name: "keyword.other.storage.modifier.ocaml"},
   {match: /`[A-Za-z][a-zA-Z0-9'_]*\b/,
    name: "entity.name.type.variant.polymorphic.ocaml"},
   {match: /\b[A-Z][a-zA-Z0-9'_]*\b/, name: "entity.name.type.variant.ocaml"},
   {match: /!=|:=|>|</, name: "keyword.operator.symbol.ocaml"},
   {match: /[*+\/-]\./, name: "keyword.operator.infix.floating-point.ocaml"},
   {match: /~-\./, name: "keyword.operator.prefix.floating-point.ocaml"},
   {match: /::/, name: "punctuation.definition.list.constructor.ocaml"},
   {match: /;;/, name: "punctuation.terminator.expression.ocaml"},
   {match: /;/, name: "punctuation.separator.ocaml"},
   {match: /->/, name: "punctuation.separator.function-return.ocaml"},
   {match: /[=<>@^&+\-*\/$%|][|!$%&*+.\/:<=>?@^~-]*/,
    name: "keyword.operator.infix.ocaml"},
   {match: /\bnot\b|!|[!\?~][!$%&*+.\/:<=>?@^~-]+/,
    name: "keyword.operator.prefix.ocaml"},
   {captures: {1 => {name: "punctuation.separator.argument-label.ocaml"}},
    match: /~[a-z][a-z0-9'_]*(?<_1>:)?/,
    name: "entity.name.tag.label.ocaml"},
   {begin: /\b(?<_1>begin)\b/,
    beginCaptures: {1 => {name: "keyword.control.begin-end.ocaml"}},
    end: "\\b(end)\\b",
    endCaptures: {1 => {name: "keyword.control.begin-end.ocaml"}},
    name: "meta.begin-end-group.ocaml",
    patterns: [{include: "$self"}]},
   {begin: /\b(?<_1>for)\b/,
    beginCaptures: {1 => {name: "keyword.control.for-loop.ocaml"}},
    end: "\\b(done)\\b",
    endCaptures: {1 => {name: "keyword.control.for-loop.ocaml"}},
    name: "meta.for-loop.ocaml",
    patterns: 
     [{match: /\bdo\b/, name: "keyword.control.loop.ocaml"},
      {include: "$self"}]},
   {begin: /\b(?<_1>while)\b/,
    beginCaptures: {1 => {name: "keyword.control.while-loop.ocaml"}},
    end: "\\b(done)\\b",
    endCaptures: {1 => {name: "keyword.control.while-loop.ocaml"}},
    name: "meta.while-loop.ocaml",
    patterns: 
     [{match: /\bdo\b/, name: "keyword.control.loop.ocaml"},
      {include: "$self"}]},
   {begin: /\(/,
    end: "\\)",
    name: "meta.paren-group.ocaml",
    patterns: [{include: "$self"}]},
   {match: /\b(?<_1>and|land|lor|lsl|lsr|lxor|mod|or)\b/,
    name: "keyword.operator.ocaml"},
   {match: /\b(?<_1>downto|if|else|match|then|to|when|with|try)\b/,
    name: "keyword.control.ocaml"},
   {match: 
     /\b(?<_1>as|assert|class|constraint|exception|functor|in|include|inherit|initializer|lazy|let|mod|module|mutable|new|object|open|private|rec|sig|struct|type|virtual)\b/,
    name: "keyword.other.ocaml"},
   {include: "#module-signature"},
   {match: /(?<_1>’|‘|“|”)/,
    name: "invalid.illegal.unrecognized-character.ocaml"}],
 repository: 
  {arrays: 
    {patterns: 
      [{begin: /(?<_1>\[\|)/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.array.begin.ocaml"}},
        end: "(\\|])",
        endCaptures: {1 => {name: "punctuation.definition.array.end.ocaml"}},
        name: "meta.array.ocaml",
        patterns: [{include: "#arrays"}, {include: "$self"}]}]},
   comments: 
    {patterns: 
      [{captures: {1 => {name: "comment.block.empty.ocaml"}},
        match: /\(\*+(?<_1>\*)\)/,
        name: "comment.block.ocaml"},
       {begin: /\(\*/,
        end: "\\*\\)",
        name: "comment.block.ocaml",
        patterns: [{include: "#comments"}]},
       {begin: /(?=[^\\])(?<_1>")/,
        end: "\"",
        name: "comment.block.string.quoted.double.ocaml",
        patterns: 
         [{match: /\\(?<_1>x[a-fA-F0-9][a-fA-F0-9]|[0-2]\d\d|[bnrt'"\\])/,
           name: "comment.block.string.constant.character.escape.ocaml"}]}]},
   constants: 
    {patterns: 
      [{captures: 
         {1 => {name: "meta.empty-typing-pair.ocaml"},
          2 => {name: "meta.empty-typing-pair.parens.ocaml"},
          3 => {name: "meta.empty-typing-pair.ocaml"}},
        match: /(?:\[\s*(?<_1>\])|\((?<_2>\))|\(\s*(?<_3>\)))/,
        name: "constant.language.pseudo-variable.ocaml"},
       {match: /\b(?<_1>true|false)\b/,
        name: "constant.language.boolean.ocaml"},
       {match: 
         /\b-?[0-9][0-9_]*(?<_1>(?<_2>\.(?<_3>[0-9][0-9_]*(?<_4>[eE][+-]??[0-9][0-9_]*)?)?)|(?<_5>[eE][+-]??[0-9][0-9_]*))/,
        name: "constant.numeric.floating-point.ocaml"},
       {match: 
         /\b(?<_1>-?(?<_2>(?<_3>0(?<_4>x|X)[0-9a-fA-F][0-9a-fA-F_]*)|(?<_5>0(?<_6>o|O)[0-7][0-7_]*)|(?<_7>0(?<_8>b|B)[01][01_]*)|(?<_9>[0-9][0-9_]*)))n/,
        name: "constant.numeric.integer.nativeint.ocaml"},
       {match: 
         /\b(?<_1>-?(?<_2>(?<_3>0(?<_4>x|X)[0-9a-fA-F][0-9a-fA-F_]*)|(?<_5>0(?<_6>o|O)[0-7][0-7_]*)|(?<_7>0(?<_8>b|B)[01][01_]*)|(?<_9>[0-9][0-9_]*)))L/,
        name: "constant.numeric.integer.int64.ocaml"},
       {match: 
         /\b(?<_1>-?(?<_2>(?<_3>0(?<_4>x|X)[0-9a-fA-F][0-9a-fA-F_]*)|(?<_5>0(?<_6>o|O)[0-7][0-7_]*)|(?<_7>0(?<_8>b|B)[01][01_]*)|(?<_9>[0-9][0-9_]*)))l/,
        name: "constant.numeric.integer.int32.ocaml"},
       {match: 
         /\b(?<_1>-?(?<_2>(?<_3>0(?<_4>x|X)[0-9a-fA-F][0-9a-fA-F_]*)|(?<_5>0(?<_6>o|O)[0-7][0-7_]*)|(?<_7>0(?<_8>b|B)[01][01_]*)|(?<_9>[0-9][0-9_]*)))/,
        name: "constant.numeric.integer.ocaml"},
       {match: 
         /'(?<_1>.|\\(?<_2>x[a-fA-F0-9][a-fA-F0-9]|[0-2]\d\d|[bnrt'"\\]))'/,
        name: "constant.character.ocaml"}]},
   definite_storagetypes: 
    {patterns: 
      [{include: "#storagetypes"},
       {match: /\b[a-zA-Z0-9'_]+\b/, name: "storage.type.ocaml"}]},
   lists: 
    {patterns: 
      [{begin: /(?<_1>\[)(?!\||<|>)/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.list.begin.ocaml"}},
        end: "(?<!\\||>)(])",
        endCaptures: {1 => {name: "punctuation.definition.list.end.ocaml"}},
        name: "meta.list.ocaml",
        patterns: [{include: "#lists"}, {include: "$self"}]}]},
   matchpatterns: 
    {patterns: 
      [{match: /\b_\b/, name: "constant.language.universal-match.ocaml"},
       {match: /\|(?=\s*\S)/,
        name: "punctuation.separator.match-pattern.ocaml"},
       {begin: /(?<_1>\()(?=(?!=.*?->).*?\|)/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.match-option.ocaml"}},
        end: "(\\))",
        endCaptures: 
         {1 => {name: "punctuation.definition.match-option.ocaml"}},
        name: "meta.match-option.ocaml",
        patterns: 
         [{match: /\|/, name: "punctuation.separator.match-option.ocaml"},
          {include: "#matchpatterns"}]},
       {include: "#moduleref"},
       {include: "#constants"},
       {include: "#variables"},
       {include: "$self"}]},
   :"module-signature" => 
    {patterns: 
      [{begin: /(?<_1>val)\s+(?<_2>[a-z_][a-zA-Z0-9_']*)\s*(?<_3>:)/,
        beginCaptures: 
         {1 => {name: "keyword.other.ocaml"},
          2 => {name: "entity.name.type.value-signature.ocaml"},
          3 => {name: "punctuation.separator.type-constraint.ocaml"}},
        end: "(?=\\b(type|val|external|class|module|end)\\b)|^\\s*$",
        name: "meta.module.signature.val.ocaml",
        patterns: 
         [{captures: 
            {1 => {name: "punctuation.definition.optional-parameter.ocaml"},
             2 => {name: "entity.name.tag.label.optional.ocaml"},
             3 => {name: "punctuation.separator.optional-parameter.ocaml"}},
           match: /(?<_1>\?)(?<_2>[a-z][a-zA-Z0-9_]*)\s*(?<_3>:)/,
           name: "variable.parameter.ameter.optional.ocaml"},
          {begin: /(?<_1>[a-z][a-zA-Z0-9'_]*)\s*(?<_2>:)\s*/,
           beginCaptures: 
            {1 => {name: "entity.name.tag.label.ocaml"},
             2 => {name: "punctuation.separator.label.ocaml"},
             3 => {name: "storage.type.ocaml"}},
           end: "\\s",
           name: "variable.parameter.labeled.ocaml",
           patterns: [{include: "#definite_storagetypes"}]},
          {include: "#typedefs"}]},
       {begin: /(?<_1>external)\s+(?<_2>[a-z_][a-zA-Z0-9_']*)\s*(?<_3>:)/,
        beginCaptures: 
         {1 => {name: "keyword.other.ocaml"},
          2 => {name: "entity.name.type.external-signature.ocaml"},
          3 => {name: "punctuation.separator.type-constraint.ocaml"}},
        end: "(?=\\b(type|val|external|class|module|let|end)\\b)|^\\s*$",
        name: "meta.module.signature.external.ocaml",
        patterns: 
         [{captures: 
            {1 => {name: "punctuation.definition.optional-parameter.ocaml"},
             2 => {name: "entity.name.tag.label.optional.ocaml"},
             3 => {name: "punctuation.separator.optional-parameter.ocaml"}},
           match: /(?<_1>\?)(?<_2>[a-z][a-zA-Z0-9_]*)\s*(?<_3>:)/,
           name: "variable.parameter.optional.ocaml"},
          {begin: /(?<_1>~)(?<_2>[a-z][a-zA-Z0-9'_]*)\s*(?<_3>:)\s*/,
           beginCaptures: 
            {1 => {name: "punctuation.definition.labeled-parameter.ocaml"},
             2 => {name: "entity.name.tag.label.ocaml"},
             3 => {name: "punctuation.separator.label.ocaml"}},
           end: "\\s",
           name: "variable.parameter.labeled.ocaml",
           patterns: [{include: "#variables"}]},
          {include: "#strings"},
          {include: "#typedefs"}]}]},
   moduleref: 
    {patterns: 
      [{beginCaptures: 
         {1 => {name: "support.other.module.ocaml"},
          2 => {name: "punctuation.separator.module-reference.ocaml"}},
        match: /\b(?<_1>[A-Z][a-zA-Z0-9'_]*)(?<_2>\.)/,
        name: "meta.module-reference.ocaml"}]},
   storagetypes: 
    {patterns: 
      [{match: 
         /\b(?<_1>int|char|float|string|list|array|bool|unit|exn|option|int32|int64|nativeint|format4|lazy_t)\b/,
        name: "storage.type.ocaml"},
       {match: /#[a-z_][a-zA-Z0-9_]*/,
        name: "storage.type.variant.polymorphic.ocaml"}]},
   strings: 
    {patterns: 
      [{begin: /(?=[^\\])(?<_1>")/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.string.begin.ocaml"}},
        end: "(\")",
        endCaptures: {1 => {name: "punctuation.definition.string.end.ocaml"}},
        name: "string.quoted.double.ocaml",
        patterns: 
         [{match: /\\$[ \t]*/,
           name: "punctuation.separator.string.ignore-eol.ocaml"},
          {match: /\\(?<_1>x[a-fA-F0-9][a-fA-F0-9]|[0-2]\d\d|[bnrt'"\\])/,
           name: "constant.character.string.escape.ocaml"},
          {match: /\\[\|\(\)1-9$^.*+?\[\]]/,
           name: "constant.character.regexp.escape.ocaml"},
          {match: 
            /\\(?!(?<_1>x[a-fA-F0-9][a-fA-F0-9]|[0-2]\d\d|[bnrt'"\\]|[\|\(\)1-9$^.*+?\[\]]|$[ \t]*))(?:.)/,
           name: "invalid.illegal.character.string.escape"}]}]},
   typedefs: 
    {patterns: 
      [{match: /\|/, name: "punctuation.separator.variant-definition.ocaml"},
       {include: "#comments"},
       {begin: /\(/,
        end: "\\)",
        name: "meta.paren-group.ocaml",
        patterns: [{include: "#typedefs"}]},
       {match: /\bof\b/, name: "keyword.other.ocaml"},
       {include: "#storagetypes"},
       {match: /(?<=\s|\()['a-z_][a-zA-Z0-9_]*\b/, name: "storage.type.ocaml"},
       {captures: 
         {1 => {name: "support.other.module.ocaml"},
          2 => {name: "storage.type.module.ocaml"}},
        match: 
         /\b(?<_1>(?:[A-Z][a-zA-Z0-9'_]*)(?:\.[A-Z][a-zA-Z0-9'_]+)*)(?<_2>\.[a-zA-Z0-9'_]+)/,
        name: "meta.module.type.ocaml"},
       {begin: /(?<_1>\[(?<_2>>|<)?)/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.polymorphic-variant.ocaml"}},
        end: "(\\])",
        endCaptures: 
         {1 => {name: "punctuation.definition.polymorphic-variant.ocaml"}},
        name: "meta.polymorphic-variant.definition.ocaml",
        patterns: [{include: "#typedefs"}]},
       {include: "$self"},
       {match: /\|/, name: "punctuation.separator.algebraic-type.ocaml"}]},
   variables: 
    {patterns: 
      [{match: /\(\)/, name: "variable.parameter.unit.ocaml"},
       {include: "#constants"},
       {include: "#moduleref"},
       {begin: /(?<_1>~)(?<_2>[a-z][a-zA-Z0-9'_]*)(?<_3>\s*:\s*)?/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.labeled-parameter.ocaml"},
          2 => {name: "entity.name.tag.label.ocaml"},
          3 => {name: "punctuation.separator.label.ocaml"}},
        end: "(?=(->|\\s))",
        name: "variable.parameter.labeled.ocaml",
        patterns: [{include: "#variables"}]},
       {captures: 
         {1 => {name: "punctuation.definition.optional-parameter.ocaml"},
          2 => {name: "entity.name.tag.label.optional.ocaml"}},
        match: /(?<_1>\?)(?<_2>[a-z][a-zA-Z0-9_]*)/,
        name: "variable.parameter.optional.ocaml"},
       {begin: /(?<_1>\?)(?<_2>\()(?<_3>[a-z_][a-zA-Z0-9'_]*)\s*(?<_4>=)/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.optional-parameter.ocaml"},
          2 => {name: "punctuation.definition.optional-parameter.ocaml"},
          3 => {name: "entity.name.tag.label.optional.ocaml"},
          4 => 
           {name: 
             "punctuation.separator.optional-parameter-assignment.ocaml"}},
        end: "(\\))",
        endCaptures: 
         {1 => {name: "punctuation.definition.optional-parameter.ocaml"}},
        name: "variable.parameter.optional.ocaml",
        patterns: [{include: "$self"}]},
       {begin: 
         /(?<_1>\()(?=(?<_2>~[a-z][a-zA-Z0-9_]*:|(?<_3>"(?<_4>\\"|[^"])*")|[^\(\)~"])+(?<!:)(?<_5>:>|:(?![:=])))/,
        beginCaptures: 
         {1 => {name: "punctuation.section.type-constraint.ocaml"}},
        end: "(\\))",
        endCaptures: 
         {1 => {name: "punctuation.section.type-constraint.ocaml"}},
        name: "meta.parameter.type-constrained.ocaml",
        patterns: 
         [{begin: /(?<!:)(?<_1>:>|:(?![:=]))/,
           beginCaptures: 
            {1 => {name: "punctuation.separator.type-constraint.ocaml"}},
           end: "(?=\\))",
           name: "storage.type.ocaml",
           patterns: [{begin: /\(/, end: "\\)", name: "meta.paren.group"}]},
          {include: "#variables"}]},
       {include: "#comments"},
       {begin: /\(/,
        end: "\\)",
        name: "meta.paren-group.ocaml",
        patterns: [{include: "#variables"}]},
       {begin: /(?<_1>\()/,
        beginCaptures: {1 => {name: "punctuation.definition.tuple.ocaml"}},
        end: "(\\))",
        endCaptures: {1 => {name: "punctuation.definition.tuple.ocaml"}},
        name: "variable.parameter.tuple.ocaml",
        patterns: 
         [{include: "#matchpatterns"},
          {include: "#variables"},
          {match: /,/, name: "punctuation.separator.tuple.ocaml"}]},
       {begin: /(?<_1>\{)/,
        beginCaptures: {1 => {name: "punctuation.definition.record.ocaml"}},
        end: "(\\})",
        endCaptures: {1 => {name: "punctuation.definition.record.ocaml"}},
        name: "variable.parameter.record.ocaml",
        patterns: 
         [{include: "#moduleref"},
          {begin: /\b(?<_1>[a-z][a-zA-Z0-9'_]*)\s*(?<_2>=)/,
           beginCaptures: 
            {1 => {name: "entity.name.tag.record.ocaml"},
             2 => 
              {name: "punctuation.separator.record.field-assignment.ocaml"}},
           end: "(;)|(?=\\})",
           endCaptures: {1 => {name: "punctuation.separator.record.ocaml"}},
           name: "meta.recordfield.match.ocaml",
           patterns: [{include: "#matchpatterns"}]}]},
       {include: "#storagetypes"},
       {match: /\b[a-z_][a-zA-Z0-9'_]*/, name: "variable.parameter.ocaml"}]}},
 scopeName: "source.ocaml",
 uuid: "F816FA69-6EE8-11D9-BF2D-000D93589AF6"}
