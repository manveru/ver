# Encoding: UTF-8

{comment: 
  "?i: has to be added everywhere because fortran is case insensitive; NB: order of matching matters",
 fileTypes: ["f", "F", "f77", "F77", "for", "FOR", "fpp", "FPP"],
 foldingStartMarker: 
  /(?x:		# extended mode
	^\s*						# start of line and some space
	(?i:						# case insensitive match
	(?<_1>
	if.*then			# if ... then
	|for|do|select\s+case|where|interface	# some easy keywords
	|module(?!\s*procedure)				# module not followed by procedure
	|type(?!\s*\()	# type but not type(?<_2>
	)
	|					# ...or...
	(?<_3>
	[a-z]*(?<!end)\s*(?<_4>function|subroutine)	# possibly some letters, but not the word end, and a space, then function
	)
	)
	.*$						# anything until the end of the line
	)/,
 foldingStopMarker: 
  /(?x:		# extended mode
	^\s*				# start of line and some space
	(?i:(?<_1>end))		# the word end, case insensitive
	.*$				# anything until the end of the line
	)/,
 name: "Fortran - Punchcard",
 patterns: 
  [{include: "#preprocessor-rule-enabled"},
   {include: "#preprocessor-rule-disabled"},
   {include: "#preprocessor-rule-other"},
   {comment: "built-in constants",
    match: /(?i:(?<_1>r8|r4|\.TRUE\.|\.FALSE\.))/,
    name: "constant.language.fortran"},
   {comment: "numbers",
    match: /\b[\+\-]?[0-9]+\.?[0-9a-zA-Z_]*\b/,
    name: "constant.numeric.fortran"},
   {begin: 
     /(?x:					# extended mode
	^
	\s*					# start of line and possibly some space
	(?<_1>[a-zA-Z\(\)]*)(?<!end)	# 1: possibly some type specification but not the word end
	\s*					# possibly some space
	(?i:(?<_2>function|subroutine))\b	# 2: function or subroutine
	\s+					# some space
	(?<_3>[A-Za-z_][A-Za-z0-9_]*)		# 3: name
	\s*					# possibly some space
	(?<_4>\()					# 4: opening parenthesis
	(?<_5>[^)]*)?  		# 5: arguments (?<_6>anything but a parenthesis)
	(?<_7>\))?					# 6: closing parenthesis
	)/,
    beginCaptures: 
     {1 => {name: "storage.type.fortran"},
      2 => {name: "storage.type.function.fortran"},
      3 => {name: "entity.name.function.fortran"},
      4 => {name: "punctuation.definition.parameters.fortran"},
      5 => {name: "variable.parameter.fortran"},
      6 => {name: "punctuation.definition.parameters.fortran"}},
    comment: "First line of function/subroutine definition",
    end: 
     "(?x:\t\t\t\t\t# extended mode\n\t\t\t\t\t((?i:end))\t\t\t# 1: the word end\n\t\t\t\t\t(\t\t\t\t\t# followed by\n\t\t\t\t\t\t$\t\t\t\t# end of line\n\t\t\t\t\t|\t\t\t\t\t# or\n\t\t\t\t\t\t\\s*\t\t\t\t# possibly some space\n\t\t\t\t\t\t(?i:(function|subroutine))\t# 2: function or subroutine\n\t\t\t\t\t\t((\\s+[A-Za-z_][A-Za-z0-9_]*)?)\t# 3: possibly the name\n\t\t\t\t\t)\n\t\t\t\t\t)",
    endCaptures: 
     {1 => {name: "keyword.other.fortran"},
      3 => {name: "storage.type.function.fortran"},
      4 => {name: "entity.name.function.end.fortran"}},
    name: "meta.function.fortran",
    patterns: [{include: "$self"}, {include: "source.fortran.modern"}]},
   {begin: 
     /\b(?i:(?<_1>integer|real|double\s+precision|complex|logical|character))\b(?=.*::)/,
    beginCaptures: {1 => {name: "storage.type.fortran"}},
    comment: "Line of type specification",
    end: "(?=!)|$",
    name: "meta.specification.fortran",
    patterns: [{include: "$self"}]},
   {comment: "statements controling the flow of the program",
    match: 
     /\b(?i:(?<_1>go\s*to|assign|to|if|then|else|end\s*if|continue|stop|pause|do|end\s*do|while|cycle))\b/,
    name: "keyword.control.fortran"},
   {comment: "programming units",
    match: 
     /\b(?i:(?<_1>program|end\s+program|entry|block\s+data|call|return|contains|include))\b/,
    name: "keyword.control.programming-units.fortran"},
   {comment: "i/o statements",
    match: 
     /\b(?i:(?<_1>open|close|read|write|print|inquire|backspace|endfile|format))\b/,
    name: "keyword.control.io.fortran"},
   {comment: "operators",
    match: /(?<_1>(?<!\=)\=(?!\=)|\-|\+|\/\/|\/|\*|::)/,
    name: "keyword.operator.fortran"},
   {comment: "logical operators",
    match: 
     /(?i:(?<_1>\.and\.|\.or\.|\.eq\.|\.lt\.|\.le\.|\.gt\.|\.ge\.|\.ne\.|\.not\.|\.eqv\.|\.neqv\.))/,
    name: "keyword.operator.logical.fortran"},
   {comment: "argument related intrisics",
    match: /\b(?i:(?<_1>present)(?=\())/,
    name: "keyword.other.instrisic.argument.fortran"},
   {comment: "numeric intrisics",
    match: 
     /\b(?i:(?<_1>abs|aimag|aint|anint|cmplx|conjg|dble|dim|dprod|int|max|min|mod|nint|real|sign|digits|epsilon|huge|maxexponent|minexponent|precision|radix|range|tiny)(?=\())/,
    name: "keyword.other.instrisic.numeric.fortran"},
   {comment: "character string intrinsics",
    match: 
     /\b(?i:(?<_1>achar|adjustl|adjustr|char|iachar|ichar|index|len_trim|repeat|scan|string|trim|verify|len)(?=\())/,
    name: "keyword.other.instrisic.string.fortran"},
   {comment: "mathematical intrisics",
    match: 
     /\b(?i:(?<_1>(?<_2>(?<_3>acos|asin|atan|atan2|cos|cosh|exp|log|log10|sin|sinh|sqrt|tan|tanh)(?=\())|(?<_4>random_number|random_seed)))\b/,
    name: "keyword.other.instrisic.math.fortran"},
   {comment: "data kind intrinsics",
    match: 
     /\b(?i:(?<_1>kind|selected_int_kind|selected_real_kind|transfer)(?=\())/,
    name: "keyword.other.instrisic.data.fortran"},
   {comment: "logical intrinsics",
    match: /\b(?i:(?<_1>logical)(?=\())/,
    name: "keyword.other.instrisic.logical.fortran"},
   {comment: "bit operations intrinsics",
    match: 
     /\b(?i:(?<_1>(?<_2>(?<_3>bit_size|btest|iand|ibclr|ibits|ibset|ieor|ior|ishift|ishiftc|not)(?=\())|mvbits))\b/,
    name: "keyword.other.instrisic.bit.fortran"},
   {comment: "floating point intrinsics",
    match: 
     /\b(?i:(?<_1>exponent|fraction|nearest|rrspacing|scale|set_exponent|spacing)(?=\())/,
    name: "keyword.other.instrisic.floating-point.fortran"},
   {comment: "matrix/vector/array intrisics",
    match: 
     /\b(?i:(?<_1>(?<_2>(?<_3>dot_product|sum|matmul|transpose|all|any|count|maxval|minval|maxloc|minloc|product|sum|lbound|ubound|shape|size|merge|pack|unpack|reshape|spread|cshift|eoshift)(?=\())|(?<_4>where|elsewhere|end\s*where)))\b/,
    name: "keyword.other.instrisic.array.fortran"},
   {comment: "other intrisics",
    match: 
     /\b(?i:(?<_1>(?<_2>(?<_3>dtime)(?=\())|(?<_4>date_and_time|system_clock)))\b/,
    name: "keyword.other.instrisic.fortran"},
   {comment: "data specification",
    match: 
     /\b(?i:(?<_1>integer|real|double\s+precision|complex|logical|character|block\sdata|operator|assignment))\b/,
    name: "storage.type.fortran"},
   {comment: "data type attributes",
    match: 
     /\b(?i:(?<_1>dimension|common|equivalence|parameter|external|intrinsic|save|data|implicit\s*none|implicit|intent|in|out|inout))\b/,
    name: "storage.modifier.fortran"},
   {applyEndPatternLast: 1,
    begin: /'/,
    beginCaptures: 
     {0 => {name: "punctuation.definition.string.begin.fortran"}},
    comment: "String",
    end: "'",
    endCaptures: {0 => {name: "punctuation.definition.string.end.fortran"}},
    name: "string.quoted.single.fortran",
    patterns: 
     [{match: /''/, name: "constant.character.escape.apostrophe.fortran"}]},
   {applyEndPatternLast: 1,
    begin: /"/,
    beginCaptures: 
     {0 => {name: "punctuation.definition.string.begin.fortran"}},
    comment: "String",
    end: "\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.fortran"}},
    name: "string.quoted.double.fortran",
    patterns: 
     [{match: /""/, name: "constant.character.escape.quote.fortran"}]},
   {begin: /^[Cc]/,
    beginCaptures: {0 => {name: "punctuation.definition.comment.fortran"}},
    end: "$\\n?",
    name: "comment.line.c.fortran",
    patterns: [{match: /\\\s*\n/}]},
   {begin: /^\s*#\s*(?<_1>error|warning)\b/,
    captures: {1 => {name: "keyword.control.import.error.fortran"}},
    end: "$\\n?",
    name: "meta.preprocessor.diagnostic.fortran",
    patterns: 
     [{match: /(?>\\\s*\n)/,
       name: "punctuation.separator.continuation.fortran"}]},
   {begin: /^\s*#\s*(?<_1>include|import)\b\s+/,
    captures: {1 => {name: "keyword.control.import.include.fortran"}},
    end: "(?=(?://|/\\*))|$\\n?",
    name: "meta.preprocessor.fortran.include",
    patterns: 
     [{match: /(?>\\\s*\n)/,
       name: "punctuation.separator.continuation.fortran"},
      {begin: /"/,
       beginCaptures: 
        {0 => {name: "punctuation.definition.string.begin.fortran"}},
       end: "\"",
       endCaptures: {0 => {name: "punctuation.definition.string.end.fortran"}},
       name: "string.quoted.double.include.fortran"},
      {begin: /</,
       beginCaptures: 
        {0 => {name: "punctuation.definition.string.begin.fortran"}},
       end: ">",
       endCaptures: {0 => {name: "punctuation.definition.string.end.fortran"}},
       name: "string.quoted.other.lt-gt.include.fortran"}]},
   {include: "#pragma-mark"},
   {begin: 
     /^\s*#\s*(?<_1>define|defined|elif|else|if|ifdef|ifndef|line|pragma|undef)\b/,
    captures: {1 => {name: "keyword.control.import.fortran"}},
    end: "(?=(?://|/\\*))|$\\n?",
    name: "meta.preprocessor.fortran",
    patterns: 
     [{match: /(?>\\\s*\n)/,
       name: "punctuation.separator.continuation.fortran"}]}],
 repository: 
  {disabled: 
    {begin: /^\s*#\s*if(?<_1>n?def)?\b.*$/,
     comment: "eat nested preprocessor if(def)s",
     end: "^\\s*#\\s*endif\\b.*$",
     patterns: [{include: "#disabled"}, {include: "#pragma-mark"}]},
   :"pragma-mark" => 
    {captures: 
      {1 => {name: "meta.preprocessor.fortran"},
       2 => {name: "keyword.control.import.pragma.fortran"},
       3 => {name: "meta.toc-list.pragma-mark.fortran"}},
     match: /^\s*(?<_1>#\s*(?<_2>pragma\s+mark)\s+(?<_3>.*))/,
     name: "meta.section"},
   :"preprocessor-rule-disabled" => 
    {begin: /^\s*(?<_1>#(?<_2>if)\s+(?<_3>0)\b).*/,
     captures: 
      {1 => {name: "meta.preprocessor.fortran"},
       2 => {name: "keyword.control.import.if.fortran"},
       3 => {name: "constant.numeric.preprocessor.fortran"}},
     end: "^\\s*(#\\s*(endif)\\b)",
     patterns: 
      [{begin: /^\s*(?<_1>#\s*(?<_2>else)\b)/,
        captures: 
         {1 => {name: "meta.preprocessor.fortran"},
          2 => {name: "keyword.control.import.else.fortran"}},
        end: "(?=^\\s*#\\s*endif\\b.*$)",
        patterns: [{include: "$base"}]},
       {begin: //,
        end: "(?=^\\s*#\\s*(else|endif)\\b.*$)",
        name: "comment.block.preprocessor.if-branch",
        patterns: [{include: "#disabled"}, {include: "#pragma-mark"}]}]},
   :"preprocessor-rule-enabled" => 
    {begin: /^\s*(?<_1>#(?<_2>if)\s+(?<_3>0*1)\b)/,
     captures: 
      {1 => {name: "meta.preprocessor.fortran"},
       2 => {name: "keyword.control.import.if.fortran"},
       3 => {name: "constant.numeric.preprocessor.fortran"}},
     end: "^\\s*(#\\s*(endif)\\b)",
     patterns: 
      [{begin: /^\s*(?<_1>#\s*(?<_2>else)\b).*/,
        captures: 
         {1 => {name: "meta.preprocessor.fortran"},
          2 => {name: "keyword.control.import.else.fortran"}},
        contentName: "comment.block.preprocessor.else-branch",
        end: "(?=^\\s*#\\s*endif\\b.*$)",
        patterns: [{include: "#disabled"}, {include: "#pragma-mark"}]},
       {begin: //,
        end: "(?=^\\s*#\\s*(else|endif)\\b.*$)",
        patterns: [{include: "$base"}]}]},
   :"preprocessor-rule-other" => 
    {begin: 
      /^\s*(?<_1>#\s*(?<_2>if(?<_3>n?def)?)\b.*?(?:(?=(?:\/\/|\/\*))|$))/,
     captures: 
      {1 => {name: "meta.preprocessor.fortran"},
       2 => {name: "keyword.control.import.fortran"}},
     end: "^\\s*(#\\s*(endif)\\b).*$",
     patterns: [{include: "$base"}]}},
 scopeName: "source.fortran",
 uuid: "45253F88-F7CC-49C5-9C32-F3FADD2AB579"}
