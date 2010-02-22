# Encoding: UTF-8

{comment: 
  "\n\t\tThe foldings do not currently work the way I want them to. This\n\t\tmay be a limitation of the way they are applied rather than the\n\t\tregexps in use. Nonetheless, the foldings will end on the last\n\t\tidentically indented blank line following an s-expression. Not\n\t\tideal perhaps, but it works. Also, the #illegal pattern never\n\t\tmatches an unpaired ( as being illegal. Why?! -- Rob Rix\n\t\t\n\t\tOk, hopefully this grammar works better on quoted stuff now.  It\n\t\tmay break for fancy macros, but should generally work pretty\n\t\tsmoothly.  -- Jacob Rus\n\t\t\n\t\tI have attempted to get this under control but because of the way folding\n\t\tand indentation interact in Textmate, I am not sure if it is possible. In the\n\t\tmeantime, I have implemented Python-style folding anchored at newlines.\n\t\tAdditionally, I have made some minor improvements to the numeric constant\n\t\thighlighting. Next up is square bracket expressions, I guess, but that\n\t\tshould be trivial. -- ozy`\n\t",
 fileTypes: ["scm", "sch"],
 foldingStartMarker: 
  /(?x)^ [ \t]* \(
	  (?<par>
	    (?<_1> [^(?<_2>)\n]++ | \( \g<par> \)? )*+
	  )
	$/,
 foldingStopMarker: /^\s*$/,
 keyEquivalent: "^~S",
 name: "Scheme",
 patterns: 
  [{include: "#comment"},
   {include: "#sexp"},
   {include: "#string"},
   {include: "#language-functions"},
   {include: "#quote"},
   {include: "#illegal"}],
 repository: 
  {comment: 
    {captures: {1 => {name: "punctuation.definition.comment.scheme"}},
     match: /(?<_1>;).*$\n?/,
     name: "comment.line.semicolon.scheme"},
   constants: 
    {patterns: 
      [{match: /#[t|f]/, name: "constant.language.boolean.scheme"},
       {match: 
         /(?<=[\(\s])(?<_1>(?<_2>#e|#i)?[0-9]+(?<_3>\.[0-9]+)?|(?<_4>#x)[0-9a-fA-F]+|(?<_5>#o)[0-7]+|(?<_6>#b)[01]+)(?=[\s;(?<_7>)'",\[\]])/,
        name: "constant.numeric.scheme"}]},
   illegal: 
    {match: /[(?<_1>)\[\]]/, name: "invalid.illegal.parenthesis.scheme"},
   :"language-functions" => 
    {patterns: 
      [{match: 
         /(?x)
	(?<=(?<_1>\s|\(|\[)) # preceded by space or (?<_2> 
	(?<_3> do|or|and|else|quasiquote|begin|if|case|set!|
	  cond|let|unquote|define|let\*|unquote-splicing|delay|
	  letrec)
	(?=(?<_4>\s|\())/,
        name: "keyword.control.scheme"},
       {comment: 
         "\n\t\t\t\t\t\tThese functions run a test, and return a boolean\n\t\t\t\t\t\tanswer.\n\t\t\t\t\t",
        match: 
         /(?x)
	(?<=(?<_1>\s|\()) # preceded by space or (?<_2>
	(?<_3> char-alphabetic|char-lower-case|char-numeric|
	  char-ready|char-upper-case|char-whitespace|
	  (?:char|string)(?:-ci)?(?:=|<=?|>=?)|
	  atom|boolean|bound-identifier=|char|complex|
	  identifier|integer|symbol|free-identifier=|inexact|
	  eof-object|exact|list|(?:input|output)-port|pair|
	  real|rational|zero|vector|negative|odd|null|string|
	  eq|equal|eqv|even|number|positive|procedure
	)
	(?<_4>\?)		# name ends with ? sign
	(?=(?<_5>\s|\()) # followed by space or (?<_6>
	/,
        name: "support.function.boolean-test.scheme"},
       {comment: 
         "\n\t\t\t\t\t\tThese functions change one type into another.\n\t\t\t\t\t",
        match: 
         /(?x)
	(?<=(?<_1>\s|\()) # preceded by space or (?<_2>
	(?<_3> char->integer|exact->inexact|inexact->exact|
	  integer->char|symbol->string|list->vector|
	  list->string|identifier->symbol|vector->list|
	  string->list|string->number|string->symbol|
	  number->string
	)
	(?=(?<_4>\s|\()) # followed by space or (?<_5>					
	/,
        name: "support.function.convert-type.scheme"},
       {comment: 
         "\n\t\t\t\t\t\tThese functions are potentially dangerous because\n\t\t\t\t\t\tthey have side-effects which could affect other\n\t\t\t\t\t\tparts of the program.\n\t\t\t\t\t",
        match: 
         /(?x)
	(?<=(?<_1>\s|\()) # preceded by space or (?<_2>
	(?<_3> set-(?:car|cdr)|				 # set car\/cdr
	  (?:vector|string)-(?:fill|set) # fill\/set string\/vector
	)
	(?<_4>!)			# name ends with ! sign
	(?=(?<_5>\s|\()) # followed by space or (?<_6>
	/,
        name: "support.function.with-side-effects.scheme"},
       {comment: "\n\t\t\t\t\t\t+, -, *, /, =, >, etc. \n\t\t\t\t\t",
        match: 
         /(?x)
	(?<=(?<_1>\s|\()) # preceded by space or (?<_2>
	(?<_3> >=?|<=?|=|[*\/+-])
	(?=(?<_4>\s|\()) # followed by space or (?<_5>
	/,
        name: "keyword.operator.arithmetic.scheme"},
       {match: 
         /(?x)
	(?<=(?<_1>\s|\()) # preceded by space or (?<_2>
	(?<_3> append|apply|approximate|
	  call-with-current-continuation|call\/cc|catch|
	  construct-identifier|define-syntax|display|foo|
	  for-each|force|cd|gen-counter|gen-loser|
	  generate-identifier|last-pair|length|let-syntax|
	  letrec-syntax|list|list-ref|list-tail|load|log|
	  macro|magnitude|map|map-streams|max|member|memq|
	  memv|min|newline|nil|not|peek-char|rationalize|
	  read|read-char|return|reverse|sequence|substring|
	  syntax|syntax-rules|transcript-off|transcript-on|
	  truncate|unwrap-syntax|values-list|write|write-char|
	  
	  # cons, car, cdr, etc
	  cons|c(?<_4>a|d){1,4}r| 
                          
	  # unary math operators
	  abs|acos|angle|asin|assoc|assq|assv|atan|ceiling|
	  cos|floor|round|sin|sqrt|tan|
	  (?:real|imag)-part|numerator|denominator
                          
	  # other math operators
	  modulo|exp|expt|remainder|quotient|lcm|
                          
	  # ports \/ files
	  call-with-(?:input|output)-file|
	  (?:close|current)-(?:input|output)-port|
	  with-(?:input|output)-from-file|
	  open-(?:input|output)-file|
	  
	  # char-«foo»
	  char-(?:downcase|upcase|ready)|
	  
	  # make-«foo»
	  make-(?:polar|promise|rectangular|string|vector)
	  
	  # string-«foo», vector-«foo»
	  string(?:-(?:append|copy|length|ref))?|
	  vector(?:-length|-ref)
	)
	(?=(?<_5>\s|\()) # followed by space or (?<_6>
	/,
        name: "support.function.general.scheme"}]},
   quote: 
    {comment: 
      "\n\t\t\t\tWe need to be able to quote any kind of item, which creates\n\t\t\t\ta tiny bit of complexity in our grammar.  It is hopefully\n\t\t\t\tnot overwhelming complexity.\n\t\t\t\t\n\t\t\t\tNote: the first two matches are special cases.  quoted\n\t\t\t\tsymbols, and quoted empty lists are considered constant.other\n\t\t\t\t\n\t\t\t",
     patterns: 
      [{captures: {1 => {name: "punctuation.section.quoted.symbol.scheme"}},
        match: 
         /(?x)
	(?<_1>')\s*
	(?<_2>[[:alnum:]][[:alnum:]!$%&*+-.\/:<=>?@^_~]*)
	/,
        name: "constant.other.symbol.scheme"},
       {captures: 
         {1 => {name: "punctuation.section.quoted.empty-list.scheme"},
          2 => {name: "meta.expression.scheme"},
          3 => {name: "punctuation.section.expression.begin.scheme"},
          4 => {name: "punctuation.section.expression.end.scheme"}},
        match: /(?x)
	(?<_1>')\s*
	(?<_2>(?<_3>\()\s*(?<_4>\)))
	/,
        name: "constant.other.empty-list.schem"},
       {begin: /(?<_1>')\s*/,
        beginCaptures: {1 => {name: "punctuation.section.quoted.scheme"}},
        comment: "quoted double-quoted string or s-expression",
        end: "(?=[\\s()])|(?<=\\n)",
        name: "string.other.quoted-object.scheme",
        patterns: [{include: "#quoted"}]}]},
   :"quote-sexp" => 
    {begin: /(?<=\()\s*(?<_1>quote)\b\s*/,
     beginCaptures: {1 => {name: "keyword.control.quote.scheme"}},
     comment: 
      "\n\t\t\t\tSomething quoted with (quote «thing»).  In this case «thing»\n\t\t\t\twill not be evaluated, so we are considering it a string.\n\t\t\t",
     contentName: "string.other.quote.scheme",
     end: "(?=[\\s)])|(?<=\\n)",
     patterns: [{include: "#quoted"}]},
   quoted: 
    {patterns: 
      [{include: "#string"},
       {begin: /(?<_1>\()/,
        beginCaptures: 
         {1 => {name: "punctuation.section.expression.begin.scheme"}},
        end: "(\\))",
        endCaptures: 
         {1 => {name: "punctuation.section.expression.end.scheme"}},
        name: "meta.expression.scheme",
        patterns: [{include: "#quoted"}]},
       {include: "#quote"},
       {include: "#illegal"}]},
   sexp: 
    {begin: /(?<_1>\()/,
     beginCaptures: 
      {1 => {name: "punctuation.section.expression.begin.scheme"}},
     end: "(\\))(\\n)?",
     endCaptures: 
      {1 => {name: "punctuation.section.expression.end.scheme"},
       2 => {name: "meta.after-expression.scheme"}},
     name: "meta.expression.scheme",
     patterns: 
      [{include: "#comment"},
       {begin: 
         /(?x)
	(?<=\()       # preceded by (?<_1>
	(?<_2>define)\s+   # define
	(?<_3>\()          # list of parameters
	  (?<_4>[[:alnum:]][[:alnum:]!$%&*+-.\/:<=>?@^_~]*)
	  (?<_5>(?<_6>\s+
	    (?<_7>[[:alnum:]][[:alnum:]!$%&*+-.\/:<=>?@^_~]*|[._])
	   )*
	  )\s*
	(?<_8>\))
	/,
        captures: 
         {1 => {name: "keyword.control.scheme"},
          2 => {name: "punctuation.definition.function.scheme"},
          3 => {name: "entity.name.function.scheme"},
          4 => {name: "variable.parameter.function.scheme"},
          7 => {name: "punctuation.definition.function.scheme"}},
        end: "(?=\\))",
        name: "meta.declaration.procedure.scheme",
        patterns: 
         [{include: "#comment"}, {include: "#sexp"}, {include: "#illegal"}]},
       {begin: 
         /(?x)
	(?<=\() # preceded by (?<_1>
	(?<_2>lambda)\s+
	(?<_3>\() # opening paren
	(?<_4>(?:
	  (?<_5>[[:alnum:]][[:alnum:]!$%&*+-.\/:<=>?@^_~]*|[._])
	  \s+
	)*(?:
	  (?<_6>[[:alnum:]][[:alnum:]!$%&*+-.\/:<=>?@^_~]*|[._])
	)?)
	(?<_7>\)) # closing paren
	/,
        captures: 
         {1 => {name: "keyword.control.scheme"},
          2 => {name: "punctuation.definition.variable.scheme"},
          3 => {name: "variable.parameter.scheme"},
          6 => {name: "punctuation.definition.variable.scheme"}},
        comment: 
         "\n\t\t\t\t\t\tNot sure this one is quite correct.  That \\s* is\n\t\t\t\t\t\tparticularly troubling\n\t\t\t\t\t",
        end: "(?=\\))",
        name: "meta.declaration.procedure.scheme",
        patterns: 
         [{include: "#comment"}, {include: "#sexp"}, {include: "#illegal"}]},
       {begin: 
         /(?<=\()(?<_1>define)\s(?<_2>[[:alnum:]][[:alnum:]!$%&*+-.\/:<=>?@^_~]*)\s*.*?/,
        captures: 
         {1 => {name: "keyword.control.scheme"},
          2 => {name: "variable.other.scheme"}},
        end: "(?=\\))",
        name: "meta.declaration.variable.scheme",
        patterns: 
         [{include: "#comment"}, {include: "#sexp"}, {include: "#illegal"}]},
       {include: "#quote-sexp"},
       {include: "#quote"},
       {include: "#language-functions"},
       {include: "#string"},
       {include: "#constants"},
       {match: /(?<=[\(\s])(?<_1>#\\)(?<_2>space|newline|tab)(?=[\s\)])/,
        name: "constant.character.named.scheme"},
       {match: /(?<=[\(\s])(?<_1>#\\)x[0-9A-F]{2,4}(?=[\s\)])/,
        name: "constant.character.hex-literal.scheme"},
       {match: /(?<=[\(\s])(?<_1>#\\).(?=[\s\)])/,
        name: "constant.character.escape.scheme"},
       {comment: 
         "\n\t\t\t\t\t\tthe . in (a . b) which conses together two elements\n\t\t\t\t\t\ta and b. (a b c) == (a . (b . (c . nil)))\n\t\t\t\t\t",
        match: /(?<=[ (?<_1>)])\.(?=[ (?<_2>)])/,
        name: "punctuation.separator.cons.scheme"},
       {include: "#sexp"},
       {include: "#illegal"}]},
   string: 
    {begin: /(?<_1>")/,
     beginCaptures: 
      {1 => {name: "punctuation.definition.string.begin.scheme"}},
     end: "(\")",
     endCaptures: {1 => {name: "punctuation.definition.string.end.scheme"}},
     name: "string.quoted.double.scheme",
     patterns: [{match: /\\./, name: "constant.character.escape.scheme"}]}},
 scopeName: "source.scheme",
 uuid: "3EC2CFD0-909C-4692-AC29-1A60ADBC161E"}
