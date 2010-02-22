# Encoding: UTF-8

{comment: 
  "\n\tTODO: unresolved issues\n\n\ttext:\n\t\"p << end\n\tprint me!\n\tend\"\n\tsymptoms:\n\tnot recognized as a heredoc\n\tsolution:\n\tthere is no way to distinguish perfectly between the << operator and the start\n\tof a heredoc. Currently, we require assignment to recognize a heredoc. More\n\trefinement is possible.\n\t• Heredocs with indented terminators (<<-) are always distinguishable, however.\n\t• Nested heredocs are not really supportable at present\n\n\ttext:\n\tprint <<-'THERE' \n\tThis is single quoted. \n\tThe above used \#{Time.now} \n\tTHERE \n\tsymtoms:\n\tFrom Programming Ruby p306; should be a non-interpolated heredoc.\n\t\n\ttext:\n\t\"a\\332a\"\n\tsymptoms:\n\t'\\332' is not recognized as slash3.. which should be octal 332.\n\tsolution:\n\tplain regexp.. should be easy.\n\n    text:\n    val?(a):p(b)\n    val?'a':'b'\n    symptoms:\n    ':p' is recognized as a symbol.. its 2 things ':' and 'p'.\n    :'b' has same problem.\n    solution:\n    ternary operator rule, precedence stuff, symbol rule.\n    but also consider 'a.b?(:c)' ??\n",
 fileTypes: 
  ["rb",
   "rbx",
   "rjs",
   "Rakefile",
   "rake",
   "cgi",
   "fcgi",
   "gemspec",
   "irbrc",
   "capfile"],
 firstLineMatch: "^#!/.*\\bruby",
 foldingStartMarker: 
  /(?x)^
	    (?<_1>\s*+
	        (?<_2>module|class|def(?!.*\bend\s*$)
	        |unless|if
	        |case
	        |begin
	        |for|while|until
	         |^=begin
	        |(?<_3>  "(?<_4>\\.|[^"])*+"          # eat a double quoted string
	         | '(?<_5>\\.|[^'])*+'        # eat a single quoted string
	         |   [^#"']                # eat all but comments and strings
	         )*
	         (?<_6>                        \s   (?<_7>do|begin|case)
	         | (?<!\$)[-+=&|*\/~%^<>~] \s*+ (?<_8>if|unless)
	         )
	        )\b
	        (?! [^;]*+ ; .*? \bend\b )
	    |(?<_9>  "(?<_10>\\.|[^"])*+"              # eat a double quoted string
	     | '(?<_11>\\.|[^'])*+'            # eat a single quoted string
	     |   [^#"']                    # eat all but comments and strings
	     )*
	     (?<_12> \{ (?!  [^}]*+ \} )
	     | \[ (?! [^\]]*+ \] )
	     )
	    ).*$
	|   [#] .*? \(fold\) \s*+ $         # Sune’s special marker
	/,
 foldingStopMarker: 
  /(?x)
	(?<_1>   (?<_2>^|;) \s*+ end   \s*+ (?<_3>[#].*)? $
	|   (?<_4>^|;) \s*+ end \. .* $
	|   ^     \s*+ [}\]] ,? \s*+ (?<_5>[#].*)? $
	|   [#] .*? \(end\) \s*+ $    # Sune’s special marker
	|   ^=end
	)/,
 keyEquivalent: "^~R",
 name: "Ruby",
 patterns: 
  [{captures: 
     {1 => {name: "keyword.control.class.ruby"},
      2 => {name: "entity.name.type.class.ruby"},
      4 => {name: "entity.other.inherited-class.ruby"},
      5 => {name: "punctuation.separator.inheritance.ruby"},
      6 => {name: "variable.other.object.ruby"},
      7 => {name: "punctuation.definition.variable.ruby"}},
    match: 
     /^\s*(?<_1>class)\s+(?<_2>(?<_3>[.a-zA-Z0-9_:]+(?<_4>\s*(?<_5><)\s*[.a-zA-Z0-9_:]+)?)|(?<_6>(?<_7><<)\s*[.a-zA-Z0-9_:]+))/,
    name: "meta.class.ruby"},
   {captures: 
     {1 => {name: "keyword.control.module.ruby"},
      2 => {name: "entity.name.type.module.ruby"},
      3 => {name: "entity.other.inherited-class.module.first.ruby"},
      4 => {name: "punctuation.separator.inheritance.ruby"},
      5 => {name: "entity.other.inherited-class.module.second.ruby"},
      6 => {name: "punctuation.separator.inheritance.ruby"},
      7 => {name: "entity.other.inherited-class.module.third.ruby"},
      8 => {name: "punctuation.separator.inheritance.ruby"}},
    match: 
     /^\s*(?<_1>module)\s+(?<_2>(?<_3>[A-Z]\w*(?<_4>::))?(?<_5>[A-Z]\w*(?<_6>::))?(?<_7>[A-Z]\w*(?<_8>::))*[A-Z]\w*)/,
    name: "meta.module.ruby"},
   {comment: 
     "else if is a common mistake carried over from other languages. it works if you put in a second end, but it’s never what you want.",
    match: /(?<!\.)\belse(?<_1>\s)+if\b/,
    name: "invalid.deprecated.ruby"},
   {comment: 
     "everything being a reserved word, not a value and needing a 'end' is a..",
    match: 
     /(?<!\.)\b(?<_1>BEGIN|begin|case|class|else|elsif|END|end|ensure|for|if|in|module|rescue|then|unless|until|when|while)\b(?![?!])/,
    name: "keyword.control.ruby"},
   {comment: "contextual smart pair support for block parameters",
    match: /(?<!\.)\bdo\b\s*/,
    name: "keyword.control.start-block.ruby"},
   {comment: "contextual smart pair support",
    match: /(?<=\{)(?<_1>\s+)/,
    name: "meta.syntax.ruby.start-block"},
   {comment: " as above, just doesn't need a 'end' and does a logic operation",
    match: /(?<!\.)\b(?<_1>and|not|or)\b/,
    name: "keyword.operator.logical.ruby"},
   {comment: " just as above but being not a logical operation",
    match: 
     /(?<!\.)\b(?<_1>alias|alias_method|break|next|redo|retry|return|super|undef|yield)\b(?![?!])|\bdefined\?|\bblock_given\?/,
    name: "keyword.control.pseudo-method.ruby"},
   {match: /\b(?<_1>nil|true|false)\b(?![?!])/,
    name: "constant.language.ruby"},
   {match: /\b(?<_1>__(?<_2>FILE|LINE)__|self)\b(?![?!])/,
    name: "variable.language.ruby"},
   {comment: " everything being a method but having a special function is a..",
    match: 
     /\b(?<_1>initialize|new|loop|include|extend|raise|attr_reader|attr_writer|attr_accessor|attr|catch|throw|private|module_function|public|protected)\b(?![?!])/,
    name: "keyword.other.special-method.ruby"},
   {begin: /\b(?<_1>require|gem)\b/,
    captures: {1 => {name: "keyword.other.special-method.ruby"}},
    end: "$|(?=#)",
    name: "meta.require.ruby",
    patterns: [{include: "$self"}]},
   {captures: {1 => {name: "punctuation.definition.variable.ruby"}},
    match: /(?<_1>@)[a-zA-Z_]\w*/,
    name: "variable.other.readwrite.instance.ruby"},
   {captures: {1 => {name: "punctuation.definition.variable.ruby"}},
    match: /(?<_1>@@)[a-zA-Z_]\w*/,
    name: "variable.other.readwrite.class.ruby"},
   {captures: {1 => {name: "punctuation.definition.variable.ruby"}},
    match: /(?<_1>\$)[a-zA-Z_]\w*/,
    name: "variable.other.readwrite.global.ruby"},
   {captures: {1 => {name: "punctuation.definition.variable.ruby"}},
    match: 
     /(?<_1>\$)(?<_2>!|@|&|`|'|\+|\d+|~|=|\/|\\|,|;|\.|<|>|_|\*|\$|\?|:|"|-[0adFiIlpv])/,
    name: "variable.other.readwrite.global.pre-defined.ruby"},
   {begin: /\b(?<_1>ENV)\[/,
    beginCaptures: {1 => {name: "variable.other.constant.ruby"}},
    end: "\\]",
    name: "meta.environment-variable.ruby",
    patterns: [{include: "$self"}]},
   {match: /\b[A-Z]\w*(?=(?<_1>(?<_2>\.|::)[A-Za-z]|\[))/,
    name: "support.class.ruby"},
   {match: /\b[A-Z]\w*\b/, name: "variable.other.constant.ruby"},
   {begin: 
     /(?x)
	         (?=def\b)                                                      # an optimization to help Oniguruma fail fast
	         (?<=^|\s)(?<_1>def)\s+                                              # the def keyword
	         (?<_2> (?>[a-zA-Z_]\w*(?>\.|::))?                                   # a method name prefix
	           (?>[a-zA-Z_]\w*(?>[?!]|=(?!>))?                              # the method name
	           |===?|>[>=]?|<=>|<[<=]?|[%&`\/\|]|\*\*?|=?~|[-+]@?|\[\]=?) )  # …or an operator method
	         \s*(?<_3>\()                                                        # the openning parenthesis for arguments
	        /,
    beginCaptures: 
     {1 => {name: "keyword.control.def.ruby"},
      2 => {name: "entity.name.function.ruby"},
      3 => {name: "punctuation.definition.parameters.ruby"}},
    comment: 
     "the method pattern comes from the symbol pattern, see there for a explaination",
    contentName: "variable.parameter.function.ruby",
    end: "\\)",
    endCaptures: {0 => {name: "punctuation.definition.parameters.ruby"}},
    name: "meta.function.method.with-arguments.ruby",
    patterns: [{include: "$self"}]},
   {begin: 
     /(?x)
	         (?=def\b)                                                      # an optimization to help Oniguruma fail fast
	         (?<=^|\s)(?<_1>def)\s+                                              # the def keyword
	         (?<_2> (?>[a-zA-Z_]\w*(?>\.|::))?                                   # a method name prefix
	           (?>[a-zA-Z_]\w*(?>[?!]|=(?!>))?                              # the method name
	           |===?|>[>=]?|<=>|<[<=]?|[%&`\/\|]|\*\*?|=?~|[-+]@?|\[\]=?) )  # …or an operator method
	         [ \t]                                                          # the space separating the arguments
	         (?=[ \t]*[^\s#;])                                              # make sure arguments and not a comment follow
	        /,
    beginCaptures: 
     {1 => {name: "keyword.control.def.ruby"},
      2 => {name: "entity.name.function.ruby"}},
    comment: 
     "same as the previous rule, but without parentheses around the arguments",
    contentName: "variable.parameter.function.ruby",
    end: "$",
    name: "meta.function.method.with-arguments.ruby",
    patterns: [{include: "$self"}]},
   {captures: 
     {1 => {name: "keyword.control.def.ruby"},
      3 => {name: "entity.name.function.ruby"}},
    comment: 
     " the optional name is just to catch the def also without a method-name",
    match: 
     /(?x)
	         (?=def\b)                                                           # an optimization to help Oniguruma fail fast
	         (?<=^|\s)(?<_1>def)\b                                                    # the def keyword
	         (?<_2> \s+                                                               # an optional group of whitespace followed by…
	           (?<_3> (?>[a-zA-Z_]\w*(?>\.|::))?                                      # a method name prefix
	             (?>[a-zA-Z_]\w*(?>[?!]|=(?!>))?                                 # the method name
	             |===?|>[>=]?|<=>|<[<=]?|[%&`\/\|]|\*\*?|=?~|[-+]@?|\[\]=?) ) )?  # …or an operator method
	        /,
    name: "meta.function.method.without-arguments.ruby"},
   {match: 
     /\b(?<_1>0[xX]\h(?>_?\h)*|\d(?>_?\d)*(?<_2>\.(?![^[:space:][:digit:]])(?>_?\d)*)?(?<_3>[eE][-+]?\d(?>_?\d)*)?|0[bB][01]+)\b/,
    name: "constant.numeric.ruby"},
   {begin: /:'/,
    captures: {0 => {name: "punctuation.definition.constant.ruby"}},
    end: "'",
    name: "constant.other.symbol.single-quoted.ruby",
    patterns: [{match: /\\['\\]/, name: "constant.character.escape.ruby"}]},
   {begin: /:"/,
    captures: {0 => {name: "punctuation.definition.constant.ruby"}},
    end: "\"",
    name: "constant.other.symbol.double-quoted.ruby",
    patterns: [{include: "#interpolated_ruby"}, {include: "#escaped_char"}]},
   {comment: "Needs higher precidence than regular expressions.",
    match: /\/=/,
    name: "keyword.operator.assignment.augmented.ruby"},
   {begin: /'/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "single quoted string (does not allow interpolation)",
    end: "'",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.quoted.single.ruby",
    patterns: [{match: /\\'|\\\\/, name: "constant.character.escape.ruby"}]},
   {begin: /"/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "double quoted string (allows for interpolation)",
    end: "\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.quoted.double.ruby",
    patterns: [{include: "#interpolated_ruby"}, {include: "#escaped_char"}]},
   {begin: /`/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "execute string (allows for interpolation)",
    end: "`",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.interpolated.ruby",
    patterns: [{include: "#interpolated_ruby"}, {include: "#escaped_char"}]},
   {begin: /%x\{/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "execute string (allow for interpolation)",
    end: "\\}",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.interpolated.ruby",
    patterns: 
     [{include: "#interpolated_ruby"},
      {include: "#escaped_char"},
      {include: "#nest_curly_i"}]},
   {begin: /%x\[/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "execute string (allow for interpolation)",
    end: "\\]",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.interpolated.ruby",
    patterns: 
     [{include: "#interpolated_ruby"},
      {include: "#escaped_char"},
      {include: "#nest_brackets_i"}]},
   {begin: /%x\</,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "execute string (allow for interpolation)",
    end: "\\>",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.interpolated.ruby",
    patterns: 
     [{include: "#interpolated_ruby"},
      {include: "#escaped_char"},
      {include: "#nest_ltgt_i"}]},
   {begin: /%x\(/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "execute string (allow for interpolation)",
    end: "\\)",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.interpolated.ruby",
    patterns: 
     [{include: "#interpolated_ruby"},
      {include: "#escaped_char"},
      {include: "#nest_parens_i"}]},
   {begin: /%x(?<_1>[^\w])/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "execute string (allow for interpolation)",
    end: "\\1",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.interpolated.ruby",
    patterns: [{include: "#interpolated_ruby"}, {include: "#escaped_char"}]},
   {begin: 
     /(?x)
	   (?:
	     ^                      # beginning of line
	   | (?<=                   # or look-behind on:
	       [=>~(?:\[,|&;]
	     | [\s;]if\s			# keywords
	     | [\s;]elsif\s
	     | [\s;]while\s
	     | [\s;]unless\s
	     | [\s;]when\s
	     | [\s;]assert_match\s
	     | [\s;]or\s			# boolean opperators
	     | [\s;]and\s
	     | [\s;]not\s
	     | [\s.]index\s			# methods
	     | [\s.]scan\s
	     | [\s.]sub\s
	     | [\s.]sub!\s
	     | [\s.]gsub\s
	     | [\s.]gsub!\s
	     | [\s.]match\s
	     )
	   | (?<=                  # or a look-behind with line anchor:
	        ^when\s            # duplication necessary due to limits of regex
	      | ^if\s
	      | ^elsif\s
	      | ^while\s
	      | ^unless\s
	      )
	   )
	   \s*(?<_1>(?<_2>\/))(?![*+{}?])
	/,
    captures: 
     {1 => {name: "string.regexp.classic.ruby"},
      2 => {name: "punctuation.definition.string.ruby"}},
    comment: 
     "regular expressions (normal)\n\t\t\twe only start a regexp if the character before it (excluding whitespace)\n\t\t\tis what we think is before a regexp\n\t\t\t",
    contentName: "string.regexp.classic.ruby",
    end: "((/[eimnosux]*))",
    patterns: [{include: "#regex_sub"}]},
   {begin: /%r\{/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "regular expressions (literal)",
    end: "\\}[eimnosux]*",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.regexp.mod-r.ruby",
    patterns: [{include: "#regex_sub"}, {include: "#nest_curly_r"}]},
   {begin: /%r\[/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "regular expressions (literal)",
    end: "\\][eimnosux]*",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.regexp.mod-r.ruby",
    patterns: [{include: "#regex_sub"}, {include: "#nest_brackets_r"}]},
   {begin: /%r\(/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "regular expressions (literal)",
    end: "\\)[eimnosux]*",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.regexp.mod-r.ruby",
    patterns: [{include: "#regex_sub"}, {include: "#nest_parens_r"}]},
   {begin: /%r\</,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "regular expressions (literal)",
    end: "\\>[eimnosux]*",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.regexp.mod-r.ruby",
    patterns: [{include: "#regex_sub"}, {include: "#nest_ltgt_r"}]},
   {begin: /%r(?<_1>[^\w])/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "regular expressions (literal)",
    end: "\\1[eimnosux]*",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.regexp.mod-r.ruby",
    patterns: [{include: "#regex_sub"}]},
   {begin: /%[QWSR]?\(/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "literal capable of interpolation ()",
    end: "\\)",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.quoted.other.literal.upper.ruby",
    patterns: 
     [{include: "#interpolated_ruby"},
      {include: "#escaped_char"},
      {include: "#nest_parens_i"}]},
   {begin: /%[QWSR]?\[/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "literal capable of interpolation []",
    end: "\\]",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.quoted.other.literal.upper.ruby",
    patterns: 
     [{include: "#interpolated_ruby"},
      {include: "#escaped_char"},
      {include: "#nest_brackets_i"}]},
   {begin: /%[QWSR]?\</,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "literal capable of interpolation <>",
    end: "\\>",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.quoted.other.literal.upper.ruby",
    patterns: 
     [{include: "#interpolated_ruby"},
      {include: "#escaped_char"},
      {include: "#nest_ltgt_i"}]},
   {begin: /%[QWSR]?\{/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "literal capable of interpolation -- {}",
    end: "\\}",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.quoted.double.ruby.mod",
    patterns: 
     [{include: "#interpolated_ruby"},
      {include: "#escaped_char"},
      {include: "#nest_curly_i"}]},
   {begin: /%[QWSR](?<_1>[^\w])/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "literal capable of interpolation -- wildcard",
    end: "\\1",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.quoted.other.literal.upper.ruby",
    patterns: [{include: "#interpolated_ruby"}, {include: "#escaped_char"}]},
   {begin: /%(?<_1>[^\w\s=])/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "literal capable of interpolation -- wildcard",
    end: "\\1",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.quoted.other.literal.other.ruby",
    patterns: [{include: "#interpolated_ruby"}, {include: "#escaped_char"}]},
   {begin: /%[qws]\(/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "literal incapable of interpolation -- ()",
    end: "\\)",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.quoted.other.literal.lower.ruby",
    patterns: 
     [{match: /\\\)|\\\\/, name: "constant.character.escape.ruby"},
      {include: "#nest_parens"}]},
   {begin: /%[qws]\</,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "literal incapable of interpolation -- <>",
    end: "\\>",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.quoted.other.literal.lower.ruby",
    patterns: 
     [{match: /\\\>|\\\\/, name: "constant.character.escape.ruby"},
      {include: "#nest_ltgt"}]},
   {begin: /%[qws]\[/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "literal incapable of interpolation -- []",
    end: "\\]",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.quoted.other.literal.lower.ruby",
    patterns: 
     [{match: /\\\]|\\\\/, name: "constant.character.escape.ruby"},
      {include: "#nest_brackets"}]},
   {begin: /%[qws]\{/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "literal incapable of interpolation -- {}",
    end: "\\}",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.quoted.other.literal.lower.ruby",
    patterns: 
     [{match: /\\\}|\\\\/, name: "constant.character.escape.ruby"},
      {include: "#nest_curly"}]},
   {begin: /%[qws](?<_1>[^\w])/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "literal incapable of interpolation -- wildcard",
    end: "\\1",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.quoted.other.literal.lower.ruby",
    patterns: 
     [{comment: "Cant be named because its not neccesarily an escape.",
       match: /\\./}]},
   {captures: {1 => {name: "punctuation.definition.constant.ruby"}},
    comment: "symbols",
    match: 
     /(?<!:)(?<_1>:)(?>[a-zA-Z_]\w*(?>[?!]|=(?![>=]))?|===?|>[>=]?|<[<=]?|<=>|[%&`\/\|]|\*\*?|=?~|[-+]@?|\[\]=?|@@?[a-zA-Z_]\w*)/,
    name: "constant.other.symbol.ruby"},
   {captures: {1 => {name: "punctuation.definition.constant.ruby"}},
    comment: "symbols",
    match: /(?>[a-zA-Z_]\w*(?>[?!])?)(?<_1>:)(?!:)/,
    name: "constant.other.symbol.ruby.19syntax"},
   {begin: /^=begin/,
    captures: {0 => {name: "punctuation.definition.comment.ruby"}},
    comment: "multiline comments",
    end: "^=end",
    name: "comment.block.documentation.ruby"},
   {captures: {1 => {name: "punctuation.definition.comment.ruby"}},
    match: /(?:^[ \t]+)?(?<_1>#).*$\n?/,
    name: "comment.line.number-sign.ruby"},
   {comment: 
     "\n\t\t\tmatches questionmark-letters.\n\n\t\t\texamples (1st alternation = hex):\n\t\t\t?\\x1     ?\\x61\n\n\t\t\texamples (2nd alternation = octal):\n\t\t\t?\\0      ?\\07     ?\\017\n\n\t\t\texamples (3rd alternation = escaped):\n\t\t\t?\\n      ?\\b\n\n\t\t\texamples (4th alternation = meta-ctrl):\n\t\t\t?\\C-a    ?\\M-a    ?\\C-\\M-\\C-\\M-a\n\n\t\t\texamples (4th alternation = normal):\n\t\t\t?a       ?A       ?0 \n\t\t\t?*       ?\"       ?( \n\t\t\t?.       ?#\n\t\t\t\n\t\t\t\n\t\t\tthe negative lookbehind prevents against matching\n\t\t\tp(42.tainted?)\n\t\t\t",
    match: 
     /(?<!\w)\?(?<_1>\\(?<_2>x\h{1,2}(?!\h)\b|0[0-7]{0,2}(?![0-7])\b|[^x0MC])|(?<_3>\\[MC]-)+\w|[^\s\\])/,
    name: "constant.numeric.ruby"},
   {begin: /^__END__\n/,
    captures: {0 => {name: "string.unquoted.program-block.ruby"}},
    comment: "__END__ marker",
    contentName: "text.plain",
    end: "(?=not)impossible",
    patterns: 
     [{begin: /(?=<?xml|<(?i:html\b)|!DOCTYPE (?i:html\b))/,
       end: "(?=not)impossible",
       name: "text.html.embedded.ruby",
       patterns: [{include: "text.html.basic"}]}]},
   {begin: /(?><<-(?<_1>"?)(?<_2>(?:[_\w]+_|)HTML)\b\k<_1>)/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "heredoc with embedded HTML and indented terminator",
    contentName: "text.html.embedded.ruby",
    end: "\\s*\\2$",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.unquoted.embedded.html.ruby",
    patterns: 
     [{include: "#heredoc"},
      {include: "text.html.basic"},
      {include: "#interpolated_ruby"},
      {include: "#escaped_char"}]},
   {begin: /(?><<-(?<_1>"?)(?<_2>(?:[_\w]+_|)SQL)\b\k<_1>)/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "heredoc with embedded SQL and indented terminator",
    contentName: "text.sql.embedded.ruby",
    end: "\\s*\\2$",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.unquoted.embedded.sql.ruby",
    patterns: 
     [{include: "#heredoc"},
      {include: "source.sql"},
      {include: "#interpolated_ruby"},
      {include: "#escaped_char"}]},
   {begin: /(?><<-(?<_1>"?)(?<_2>(?:[_\w]+_|)CSS)\b\k<_1>)/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "heredoc with embedded css and intented terminator",
    contentName: "text.css.embedded.ruby",
    end: "\\s*\\2$",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.unquoted.embedded.css.ruby",
    patterns: 
     [{include: "#heredoc"},
      {include: "source.css"},
      {include: "#interpolated_ruby"},
      {include: "#escaped_char"}]},
   {begin: /(?><<-(?<_1>"?)(?<_2>(?:[_\w]+_|)CPP)\b\k<_1>)/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "heredoc with embedded c++ and intented terminator",
    contentName: "text.c++.embedded.ruby",
    end: "\\s*\\2$",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.unquoted.embedded.cplusplus.ruby",
    patterns: 
     [{include: "#heredoc"},
      {include: "source.c++"},
      {include: "#interpolated_ruby"},
      {include: "#escaped_char"}]},
   {begin: /(?><<-(?<_1>"?)(?<_2>(?:[_\w]+_|)C)\b\k<_1>)/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "heredoc with embedded c++ and intented terminator",
    contentName: "text.c.embedded.ruby",
    end: "\\s*\\2$",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.unquoted.embedded.c.ruby",
    patterns: 
     [{include: "#heredoc"},
      {include: "source.c"},
      {include: "#interpolated_ruby"},
      {include: "#escaped_char"}]},
   {begin: /(?><<-(?<_1>"?)(?<_2>(?:[_\w]+_|)(?:JS|JAVASCRIPT))\b\k<_1>)/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "heredoc with embedded javascript and intented terminator",
    contentName: "text.js.embedded.ruby",
    end: "\\s*\\2$",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.unquoted.embedded.js.ruby",
    patterns: 
     [{include: "#heredoc"},
      {include: "source.js"},
      {include: "#interpolated_ruby"},
      {include: "#escaped_char"}]},
   {begin: /(?><<-(?<_1>"?)(?<_2>(?:[_\w]+_|)JQUERY)\b\k<_1>)/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "heredoc with embedded javascript and intented terminator",
    contentName: "text.js.jquery.embedded.ruby",
    end: "\\s*\\2$",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.unquoted.embedded.js.jquery.ruby",
    patterns: 
     [{include: "#heredoc"},
      {include: "source.js.jquery"},
      {include: "#interpolated_ruby"},
      {include: "#escaped_char"}]},
   {begin: /(?><<-(?<_1>"?)(?<_2>(?:[_\w]+_|)(?:SH|SHELL))\b\k<_1>)/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "heredoc with embedded shell and intented terminator",
    contentName: "text.shell.embedded.ruby",
    end: "\\s*\\2$",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.unquoted.embedded.shell.ruby",
    patterns: 
     [{include: "#heredoc"},
      {include: "source.shell"},
      {include: "#interpolated_ruby"},
      {include: "#escaped_char"}]},
   {begin: /(?><<-(?<_1>"?)(?<_2>(?:[_\w]+_|)RUBY)\b\k<_1>)/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "heredoc with embedded ruby and intented terminator",
    contentName: "text.ruby.embedded.ruby",
    end: "\\s*\\2$",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.unquoted.embedded.ruby.ruby",
    patterns: 
     [{include: "#heredoc"},
      {include: "source.ruby"},
      {include: "#interpolated_ruby"},
      {include: "#escaped_char"}]},
   {begin: /(?>\=\s*<<(?<_1>\w+))/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    end: "^\\1$",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.unquoted.heredoc.ruby",
    patterns: 
     [{include: "#heredoc"},
      {include: "#interpolated_ruby"},
      {include: "#escaped_char"}]},
   {begin: /(?><<-(?<_1>\w+))/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.ruby"}},
    comment: "heredoc with indented terminator",
    end: "\\s*\\1$",
    endCaptures: {0 => {name: "punctuation.definition.string.end.ruby"}},
    name: "string.unquoted.heredoc.ruby",
    patterns: 
     [{include: "#heredoc"},
      {include: "#interpolated_ruby"},
      {include: "#escaped_char"}]},
   {begin: /(?<=\{|do|\{\s|do\s)(?<_1>\|)/,
    captures: {1 => {name: "punctuation.separator.variable.ruby"}},
    end: "(\\|)",
    patterns: 
     [{match: /[_a-zA-Z][_a-zA-Z0-9]*/, name: "variable.other.block.ruby"},
      {match: /,/, name: "punctuation.separator.variable.ruby"}]},
   {match: /=>/, name: "punctuation.separator.key-value"},
   {match: /<<=|%=|&=|\*=|\*\*=|\+=|\-=|\^=|\|{1,2}=|<</,
    name: "keyword.operator.assignment.augmented.ruby"},
   {match: /<=>|<(?!<|=)|>(?!<|=|>)|<=|>=|===|==|=~|!=|!~|(?<=[ \t])\?/,
    name: "keyword.operator.comparison.ruby"},
   {match: /(?<=[ \t])!+|\bnot\b|&&|\band\b|\|\||\bor\b|\^/,
    name: "keyword.operator.logical.ruby"},
   {match: /(?<_1>%|&|\*\*|\*|\+|\-|\/)/,
    name: "keyword.operator.arithmetic.ruby"},
   {match: /=/, name: "keyword.operator.assignment.ruby"},
   {match: /\||~|>>/, name: "keyword.operator.other.ruby"},
   {match: /:/, name: "punctuation.separator.other.ruby"},
   {match: /\;/, name: "punctuation.separator.statement.ruby"},
   {match: /,/, name: "punctuation.separator.object.ruby"},
   {match: /\.|::/, name: "punctuation.separator.method.ruby"},
   {match: /\{|\}/, name: "punctuation.section.scope.ruby"},
   {match: /\[|\]/, name: "punctuation.section.array.ruby"},
   {match: /\(|\)/, name: "punctuation.section.function.ruby"}],
 repository: 
  {escaped_char: 
    {match: /\\(?:[0-7]{1,3}|x[\da-fA-F]{1,2}|.)/,
     name: "constant.character.escape.ruby"},
   heredoc: {begin: /^<<-?\w+/, end: "$", patterns: [{include: "$self"}]},
   interpolated_ruby: 
    {patterns: 
      [{captures: 
         {0 => {name: "punctuation.section.embedded.ruby"},
          1 => {name: "source.ruby.embedded.source.empty"}},
        match: /#\{(?<_1>\})/,
        name: "source.ruby.embedded.source"},
       {begin: /#\{/,
        captures: {0 => {name: "punctuation.section.embedded.ruby"}},
        end: "\\}",
        name: "source.ruby.embedded.source",
        patterns: [{include: "#nest_curly_and_self"}, {include: "$self"}]},
       {captures: {1 => {name: "punctuation.definition.variable.ruby"}},
        match: /(?<_1>\#@)[a-zA-Z_]\w*/,
        name: "variable.other.readwrite.instance.ruby"},
       {captures: {1 => {name: "punctuation.definition.variable.ruby"}},
        match: /(?<_1>\#@@)[a-zA-Z_]\w*/,
        name: "variable.other.readwrite.class.ruby"},
       {captures: {1 => {name: "punctuation.definition.variable.ruby"}},
        match: /(?<_1>#\$)[a-zA-Z_]\w*/,
        name: "variable.other.readwrite.global.ruby"}]},
   nest_brackets: 
    {begin: /\[/,
     captures: {0 => {name: "punctuation.section.scope.ruby"}},
     end: "\\]",
     patterns: [{include: "#nest_brackets"}]},
   nest_brackets_i: 
    {begin: /\[/,
     captures: {0 => {name: "punctuation.section.scope.ruby"}},
     end: "\\]",
     patterns: 
      [{include: "#interpolated_ruby"},
       {include: "#escaped_char"},
       {include: "#nest_brackets_i"}]},
   nest_brackets_r: 
    {begin: /\[/,
     captures: {0 => {name: "punctuation.section.scope.ruby"}},
     end: "\\]",
     patterns: [{include: "#regex_sub"}, {include: "#nest_brackets_r"}]},
   nest_curly: 
    {begin: /\{/,
     captures: {0 => {name: "punctuation.section.scope.ruby"}},
     end: "\\}",
     patterns: [{include: "#nest_curly"}]},
   nest_curly_and_self: 
    {patterns: 
      [{begin: /\{/,
        captures: {0 => {name: "punctuation.section.scope.ruby"}},
        end: "\\}",
        patterns: [{include: "#nest_curly_and_self"}]},
       {include: "$self"}]},
   nest_curly_i: 
    {begin: /\{/,
     captures: {0 => {name: "punctuation.section.scope.ruby"}},
     end: "\\}",
     patterns: 
      [{include: "#interpolated_ruby"},
       {include: "#escaped_char"},
       {include: "#nest_curly_i"}]},
   nest_curly_r: 
    {begin: /\{/,
     captures: {0 => {name: "punctuation.section.scope.ruby"}},
     end: "\\}",
     patterns: [{include: "#regex_sub"}, {include: "#nest_curly_r"}]},
   nest_ltgt: 
    {begin: /\</,
     captures: {0 => {name: "punctuation.section.scope.ruby"}},
     end: "\\>",
     patterns: [{include: "#nest_ltgt"}]},
   nest_ltgt_i: 
    {begin: /\</,
     captures: {0 => {name: "punctuation.section.scope.ruby"}},
     end: "\\>",
     patterns: 
      [{include: "#interpolated_ruby"},
       {include: "#escaped_char"},
       {include: "#nest_ltgt_i"}]},
   nest_ltgt_r: 
    {begin: /\</,
     captures: {0 => {name: "punctuation.section.scope.ruby"}},
     end: "\\>",
     patterns: [{include: "#regex_sub"}, {include: "#nest_ltgt_r"}]},
   nest_parens: 
    {begin: /\(/,
     captures: {0 => {name: "punctuation.section.scope.ruby"}},
     end: "\\)",
     patterns: [{include: "#nest_parens"}]},
   nest_parens_i: 
    {begin: /\(/,
     captures: {0 => {name: "punctuation.section.scope.ruby"}},
     end: "\\)",
     patterns: 
      [{include: "#interpolated_ruby"},
       {include: "#escaped_char"},
       {include: "#nest_parens_i"}]},
   nest_parens_r: 
    {begin: /\(/,
     captures: {0 => {name: "punctuation.section.scope.ruby"}},
     end: "\\)",
     patterns: [{include: "#regex_sub"}, {include: "#nest_parens_r"}]},
   regex_sub: 
    {patterns: 
      [{include: "#interpolated_ruby"},
       {include: "#escaped_char"},
       {captures: 
         {1 => {name: "punctuation.definition.arbitrary-repitition.ruby"},
          3 => {name: "punctuation.definition.arbitrary-repitition.ruby"}},
        match: /(?<_1>\{)\d+(?<_2>,\d+)?(?<_3>\})/,
        name: "string.regexp.arbitrary-repitition.ruby"},
       {begin: /\[(?:\^?\])?/,
        captures: {0 => {name: "punctuation.definition.character-class.ruby"}},
        end: "\\]",
        name: "string.regexp.character-class.ruby",
        patterns: [{include: "#escaped_char"}]},
       {begin: /\(/,
        captures: {0 => {name: "punctuation.definition.group.ruby"}},
        end: "\\)",
        name: "string.regexp.group.ruby",
        patterns: [{include: "#regex_sub"}]},
       {captures: {1 => {name: "punctuation.definition.comment.ruby"}},
        comment: 
         "We are restrictive in what we allow to go after the comment character to avoid false positives, since the availability of comments depend on regexp flags.",
        match: /(?<=^|\s)(?<_1>#)\s[[a-zA-Z0-9,. \t?!-][^\x00-\x7F]]*$/,
        name: "comment.line.number-sign.ruby"}]}},
 scopeName: "source.ruby",
 uuid: "E00B62AC-6B1C-11D9-9B1F-000D93589AF6"}
