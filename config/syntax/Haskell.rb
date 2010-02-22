# Encoding: UTF-8

{fileTypes: ["hs"],
 keyEquivalent: "^~H",
 name: "Haskell",
 patterns: 
  [{captures: 
     {1 => {name: "punctuation.definition.entity.haskell"},
      2 => {name: "punctuation.definition.entity.haskell"}},
    comment: 
     "In case this regex seems unusual for an infix operator, note that Haskell allows any ordinary function application (elem 4 [1..10]) to be rewritten as an infix expression (4 `elem` [1..10]).",
    match: /(?<_1>`)[a-zA-Z_']*?(?<_2>`)/,
    name: "keyword.operator.function.infix.haskell"},
   {match: /\(\)/, name: "constant.language.unit.haskell"},
   {match: /\[\]/, name: "constant.language.empty-list.haskell"},
   {begin: /(?<_1>module)/,
    beginCaptures: {1 => {name: "keyword.other.haskell"}},
    end: "(where)",
    endCaptures: {1 => {name: "keyword.other.haskell"}},
    name: "meta.declaration.module.haskell",
    patterns: 
     [{include: "#module_name"},
      {include: "#module_exports"},
      {match: /[a-z]+/, name: "invalid"}]},
   {begin: /\b(?<_1>class)\b/,
    beginCaptures: {1 => {name: "keyword.other.haskell"}},
    end: "\\b(where)\\b",
    endCaptures: {1 => {name: "keyword.other.haskell"}},
    name: "meta.declaration.class.haskell",
    patterns: 
     [{match: 
        /\b(?<_1>Monad|Functor|Eq|Ord|Read|Show|Num|(?<_2>Frac|Ra)tional|Enum|Bounded|Real(?<_3>Frac|Float)?|Integral|Floating)\b/,
       name: "support.class.prelude.haskell"},
      {match: /[A-Z][A-Za-z_']*/,
       name: "entity.other.inherited-class.haskell"},
      {match: /\b[a-z][a-zA-Z0-9_']*\b/,
       name: "variable.other.generic-type.haskell"}]},
   {begin: /\b(?<_1>instance)\b/,
    beginCaptures: {1 => {name: "keyword.other.haskell"}},
    end: "\\b(where)\\b|$",
    endCaptures: {1 => {name: "keyword.other.haskell"}},
    name: "meta.declaration.instance.haskell",
    patterns: [{include: "#type_signature"}]},
   {begin: /(?<_1>import)/,
    beginCaptures: {1 => {name: "keyword.other.haskell"}},
    end: "($|;)",
    name: "meta.import.haskell",
    patterns: 
     [{match: /(?<_1>qualified|as|hiding)/, name: "keyword.other.haskell"},
      {include: "#module_name"},
      {include: "#module_exports"}]},
   {begin: /(?<_1>deriving)\s*\(/,
    beginCaptures: {1 => {name: "keyword.other.haskell"}},
    end: "\\)",
    name: "meta.deriving.haskell",
    patterns: 
     [{match: /\b[A-Z][a-zA-Z_']*/,
       name: "entity.other.inherited-class.haskell"}]},
   {match: 
     /\b(?<_1>deriving|where|data|type|case|of|let|in|newtype|default)\b/,
    name: "keyword.other.haskell"},
   {match: /\binfix[lr]?\b/, name: "keyword.operator.haskell"},
   {match: /\b(?<_1>do|if|then|else)\b/, name: "keyword.control.haskell"},
   {comment: "Floats are always decimal",
    match: 
     /\b(?<_1>[0-9]+\.[0-9]+(?<_2>[eE][+-]?[0-9]+)?|[0-9]+[eE][+-]?[0-9]+)\b/,
    name: "constant.numeric.float.haskell"},
   {match: /\b(?<_1>[0-9]+|0(?<_2>[xX][0-9a-fA-F]+|[oO][0-7]+))\b/,
    name: "constant.numeric.haskell"},
   {captures: {1 => {name: "punctuation.definition.preprocessor.c"}},
    comment: 
     "In addition to Haskell's \"native\" syntax, GHC permits the C preprocessor to be run on a source file.",
    match: /^\s*(?<_1>#)\s*\w+/,
    name: "meta.preprocessor.c"},
   {include: "#pragma"},
   {begin: /"/,
    beginCaptures: 
     {0 => {name: "punctuation.definition.string.begin.haskell"}},
    end: "\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.haskell"}},
    name: "string.quoted.double.haskell",
    patterns: 
     [{match: 
        /\\(?<_1>NUL|SOH|STX|ETX|EOT|ENQ|ACK|BEL|BS|HT|LF|VT|FF|CR|SO|SI|DLE|DC1|DC2|DC3|DC4|NAK|SYN|ETB|CAN|EM|SUB|ESC|FS|GS|RS|US|SP|DEL|[abfnrtv\\\"'\&])/,
       name: "constant.character.escape.haskell"},
      {match: /\\o[0-7]+|\\x[0-9A-Fa-f]+|\\[0-9]+/,
       name: "constant.character.escape.octal.haskell"},
      {match: /\^[A-Z@\[\]\\\^_]/,
       name: "constant.character.escape.control.haskell"}]},
   {captures: 
     {1 => {name: "punctuation.definition.string.begin.haskell"},
      2 => {name: "constant.character.escape.haskell"},
      3 => {name: "constant.character.escape.octal.haskell"},
      4 => {name: "constant.character.escape.hexadecimal.haskell"},
      5 => {name: "constant.character.escape.control.haskell"},
      6 => {name: "punctuation.definition.string.end.haskell"}},
    match: 
     /(?x)
	(?<_1>')
	(?:
	[\ -\[\]-~]								# Basic Char
	  | (?<_2>\\(?:NUL|SOH|STX|ETX|EOT|ENQ|ACK|BEL|BS|HT|LF|VT|FF|CR|SO|SI|DLE
	|DC1|DC2|DC3|DC4|NAK|SYN|ETB|CAN|EM|SUB|ESC|FS|GS|RS
	|US|SP|DEL|[abfnrtv\\\"'\&]))		# Escapes
	  | (?<_3>\\o[0-7]+)								# Octal Escapes
	  | (?<_4>\\x[0-9A-Fa-f]+)						# Hexadecimal Escapes
	  | (?<_5>\^[A-Z@\[\]\\\^_])						# Control Chars
	)
	(?<_6>')
	/,
    name: "string.quoted.single.haskell"},
   {begin: /^\s*(?<_1>[a-z_][a-zA-Z0-9_']*|\([|!%$+\-.,=<\/>]+\))\s*(?<_2>::)/,
    beginCaptures: 
     {1 => {name: "entity.name.function.haskell"},
      2 => {name: "keyword.other.double-colon.haskell"}},
    end: "$\\n?",
    name: "meta.function.type-declaration.haskell",
    patterns: [{include: "#type_signature"}]},
   {match: /\b(?<_1>Just|Nothing|Left|Right|True|False|LT|EQ|GT|\(\)|\[\])\b/,
    name: "support.constant.haskell"},
   {match: /\b[A-Z]\w*\b/, name: "constant.other.haskell"},
   {include: "#comments"},
   {match: 
     /\b(?<_1>abs|acos|acosh|all|and|any|appendFile|applyM|asTypeOf|asin|asinh|atan|atan2|atanh|break|catch|ceiling|compare|concat|concatMap|const|cos|cosh|curry|cycle|decodeFloat|div|divMod|drop|dropWhile|elem|encodeFloat|enumFrom|enumFromThen|enumFromThenTo|enumFromTo|error|even|exp|exponent|fail|filter|flip|floatDigits|floatRadix|floatRange|floor|fmap|foldl|foldl1|foldr|foldr1|fromEnum|fromInteger|fromIntegral|fromRational|fst|gcd|getChar|getContents|getLine|head|id|init|interact|ioError|isDenormalized|isIEEE|isInfinite|isNaN|isNegativeZero|iterate|last|lcm|length|lex|lines|log|logBase|lookup|map|mapM|mapM_|max|maxBound|maximum|maybe|min|minBound|minimum|mod|negate|not|notElem|null|odd|or|otherwise|pi|pred|print|product|properFraction|putChar|putStr|putStrLn|quot|quotRem|read|readFile|readIO|readList|readLn|readParen|reads|readsPrec|realToFrac|recip|rem|repeat|replicate|return|reverse|round|scaleFloat|scanl|scanl1|scanr|scanr1|seq|sequence|sequence_|show|showChar|showList|showParen|showString|shows|showsPrec|significand|signum|sin|sinh|snd|span|splitAt|sqrt|subtract|succ|sum|tail|take|takeWhile|tan|tanh|toEnum|toInteger|toRational|truncate|uncurry|undefined|unlines|until|unwords|unzip|unzip3|userError|words|writeFile|zip|zip3|zipWith|zipWith3)\b/,
    name: "support.function.prelude.haskell"},
   {include: "#infix_op"},
   {comment: 
     "In case this regex seems overly general, note that Haskell permits the definition of new operators which can be nearly any string of punctuation characters, such as $%^&*.",
    match: /[|!%$?~+:\-.=<\/>\\]+/,
    name: "keyword.operator.haskell"},
   {match: /,/, name: "punctuation.separator.comma.haskell"}],
 repository: 
  {block_comment: 
    {applyEndPatternLast: 1,
     begin: /\{-(?!#)/,
     captures: {0 => {name: "punctuation.definition.comment.haskell"}},
     end: "-\\}",
     name: "comment.block.haskell",
     patterns: [{include: "#block_comment"}]},
   comments: 
    {patterns: 
      [{captures: {1 => {name: "punctuation.definition.comment.haskell"}},
        match: /(?<_1>--).*$\n?/,
        name: "comment.line.double-dash.haskell"},
       {include: "#block_comment"}]},
   infix_op: 
    {match: /(?<_1>\([|!%$+:\-.=<\/>]+\)|\(,+\))/,
     name: "entity.name.function.infix.haskell"},
   module_exports: 
    {begin: /\(/,
     end: "\\)",
     name: "meta.declaration.exports.haskell",
     patterns: 
      [{match: /\b[a-z][a-zA-Z_']*/, name: "entity.name.function.haskell"},
       {match: /\b[A-Z][A-Za-z_']*/, name: "storage.type.haskell"},
       {match: /,/, name: "punctuation.separator.comma.haskell"},
       {include: "#infix_op"},
       {comment: "So named because I don't know what to call this.",
        match: /\(.*?\)/,
        name: "meta.other.unknown.haskell"}]},
   module_name: 
    {match: /[A-Z][A-Za-z._']*/, name: "support.other.module.haskell"},
   pragma: 
    {begin: /\{-#/,
     end: "#-\\}",
     name: "meta.preprocessor.haskell",
     patterns: 
      [{match: /\b(?<_1>LANGUAGE|UNPACK|INLINE)\b/,
        name: "keyword.other.preprocessor.haskell"}]},
   type_signature: 
    {patterns: 
      [{captures: 
         {1 => {name: "entity.other.inherited-class.haskell"},
          2 => {name: "variable.other.generic-type.haskell"},
          3 => {name: "keyword.other.big-arrow.haskell"}},
        match: 
         /\(\s*(?<_1>[A-Z][A-Za-z]*)\s+(?<_2>[a-z][A-Za-z_']*)\)\s*(?<_3>=>)/,
        name: "meta.class-constraint.haskell"},
       {include: "#pragma"},
       {match: /->/, name: "keyword.other.arrow.haskell"},
       {match: /=>/, name: "keyword.other.big-arrow.haskell"},
       {match: 
         /\b(?<_1>Int(?<_2>eger)?|Maybe|Either|Bool|Float|Double|Char|String|Ordering|ShowS|ReadS|FilePath|IO(?<_3>Error)?)\b/,
        name: "support.type.prelude.haskell"},
       {match: /\b[a-z][a-zA-Z0-9_']*\b/,
        name: "variable.other.generic-type.haskell"},
       {match: /\b[A-Z][a-zA-Z0-9_']*\b/, name: "storage.type.haskell"},
       {match: /\(\)/, name: "support.constant.unit.haskell"},
       {include: "#comments"}]}},
 scopeName: "source.haskell",
 uuid: "5C034675-1F6D-497E-8073-369D37E2FD7D"}
