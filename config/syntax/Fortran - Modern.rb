# Encoding: UTF-8

{comment: "Specificities of Fortran >= 90",
 fileTypes: ["f90", "F90", "f95", "F95", "f03", "F03", "f08", "F08"],
 firstLineMatch: "(?i)-[*]- mode: f90 -[*]-",
 foldingStartMarker: 
  /(?x)				# extended mode
	^\s*						# start of line and some space
	(?i:						# case insensitive match
	(?<_1>
	if.*then				# if ... then
	|for|do|select\s+case|where|interface	# some easy keywords
	|module(?!\s*procedure)	# module not followed by procedure
	|type(?!\s*\()		# type but not type(?<_2>
	)
	 		|					# ...or...
	(?<_3>
	[a-z]*(?<!end)\s*(?<_4>function|subroutine)	# possibly some letters, but not the word end, and a space, then function
	)
	)
	.*$						# anything until the end of the line
	/,
 foldingStopMarker: 
  /(?x)				# extended mode
	^\s*						# start of line and some space
	(?i:(?<_1>end))				# the word end, was insensitive
	.*$						# anything until the end of the line
	/,
 keyEquivalent: "^~F",
 name: "Fortran - Modern",
 patterns: 
  [{begin: /^[Cc]\s+/,
    beginCaptures: {0 => {name: "punctuation.definition.comment.fortran"}},
    end: "$\\n?",
    name: "invalid.deprecated.comment.line.fortran",
    patterns: [{match: /\\\s*\n/}]},
   {include: "source.fortran"},
   {begin: 
     /(?x:					# extended mode
	^
	\s*					# start of line and possibly some space
	(?i:(?<_1>interface))		# 1: word interface
	\s+					# some space
	(?i:(?<_2>operator|assignment))		# 2: the words operator or assignment
	\(					# opening parenthesis
	(?<_3>(?<_4>\.[a-zA-Z0-9_]+\.)|[\+\-\=\/\*]+)	# 3: an operator
	
	\)					# closing parenthesis
	)/,
    beginCaptures: 
     {1 => {name: "storage.type.function.fortran"},
      2 => {name: "storage.type.fortran"},
      3 => {name: "keyword.operator.fortran"}},
    comment: "Interface declaration of operator/assignments",
    end: 
     "(?x:\n\t\t\t\t\t((?i:end))\t\t\t# 1: the word end\n\t\t\t\t\t\\s*\t\t\t\t\t# possibly some space\n\t\t\t\t\t((?i:interface)?) \t\t# 2: possibly interface\n\t\t\t\t\t)",
    endCaptures: 
     {1 => {name: "keyword.other.fortran"},
      2 => {name: "storage.type.function.fortran"}},
    name: "meta.function.interface.operator.fortran.modern",
    patterns: [{include: "$self"}]},
   {begin: 
     /(?x:					# extended mode
	^
	\s*					# start of line and possibly some space
	(?i:(?<_1>interface))		# 1: word interface
	\s+					# some space
	(?<_2>[A-Za-z_][A-Za-z0-9_]*)	# 1: name
	)/,
    beginCaptures: 
     {1 => {name: "storage.type.function.fortran"},
      2 => {name: "entity.name.function.fortran"}},
    comment: "Interface declaration of function/subroutines",
    end: 
     "(?x:\t\t\t\t# extended mode\n\t\t\t\t\t((?i:end))\t\t# 1: the word end\n\t\t\t\t\t\\s*\t\t\t\t# possibly some space\n\t\t\t\t\t((?i:interface)?) \t# 2: possibly interface\n\t\t\t\t\t)",
    endCaptures: 
     {1 => {name: "keyword.other.fortran"},
      2 => {name: "storage.type.function.fortran"}},
    name: "meta.function.interface.fortran.modern",
    patterns: [{include: "$self"}]},
   {begin: 
     /(?x:			# extended mode
	^\s*			# begining of line and some space
	(?i:(?<_1>type))	# 1: word type
	\s+			# some space
	(?<_2>[a-zA-Z_][a-zA-Z0-9_]*)	# 2: type name
	)/,
    beginCaptures: 
     {1 => {name: "storage.type.fortran.modern"},
      2 => {name: "entity.name.type.fortran.modern"}},
    comment: "Type definition",
    end: 
     "(?x:\n\t\t\t\t\t((?i:end))\t\t\t# 1: the word end\n\t\t\t\t\t\\s*\t\t\t\t\t# possibly some space\n\t\t\t\t\t(?i:(type))? \t\t\t# 2: possibly the word type\n\t\t\t\t\t(\\s+[A-Za-z_][A-Za-z0-9_]*)?\t# 3: possibly the name\n\t\t\t\t\t)",
    endCaptures: 
     {1 => {name: "keyword.other.fortran"},
      2 => {name: "storage.type.fortran.modern"},
      3 => {name: "entity.name.type.end.fortran.modern"}},
    name: "meta.type-definition.fortran.modern",
    patterns: [{include: "$self"}]},
   {begin: /(?<_1>!-)/,
    beginCaptures: {0 => {name: "punctuation.definition.comment.fortran"}},
    end: "$\\n?",
    name: "comment.line.exclamation.mark.fortran.modern",
    patterns: [{match: /\\\s*\n/}]},
   {begin: /[!]/,
    beginCaptures: {0 => {name: "punctuation.definition.comment.fortran"}},
    end: "$\\n?",
    name: "comment.line.exclamation.fortran.modern",
    patterns: [{match: /\\\s*\n/}]},
   {comment: "statements controling the flow of the program",
    match: 
     /\b(?i:(?<_1>select\s+case|case(?<_2>\s+default)?|end\s+select|use|(?<_3>end\s+)?forall))\b/,
    name: "keyword.control.fortran.modern"},
   {comment: "input/output instrinsics",
    match: 
     /\b(?i:(?<_1>access|action|advance|append|apostrophe|asis|blank|delete|delim|direct|end|eor|err|exist|file|fmt|form|formatted|iolength|iostat|keep|name|named|nextrec|new|nml|no|null|number|old|opened|pad|position|quote|read|readwrite|rec|recl|replace|scratch|sequential|size|status|undefined|unformatted|unit|unknown|write|yes|zero|namelist)(?=\())/,
    name: "keyword.control.io.fortran.modern"},
   {comment: "logical operators in symbolic format",
    match: /\b(?<_1>\=\=|\/\=|\>\=|\>|\<|\<\=)\b/,
    name: "keyword.operator.logical.fortran.modern"},
   {comment: "operators",
    match: /(?<_1>\%|\=\>)/,
    name: "keyword.operator.fortran.modern"},
   {comment: "numeric instrinsics",
    match: /\b(?i:(?<_1>ceiling|floor|modulo)(?=\())/,
    name: "keyword.other.instrinsic.numeric.fortran.modern"},
   {comment: "matrix/vector/array instrinsics",
    match: /\b(?i:(?<_1>allocate|allocated|deallocate)(?=\())/,
    name: "keyword.other.instrinsic.array.fortran.modern"},
   {comment: "pointer instrinsics",
    match: /\b(?i:(?<_1>associated)(?=\())/,
    name: "keyword.other.instrinsic.pointer.fortran.modern"},
   {comment: "programming units",
    match: /\b(?i:(?<_1>(?<_2>end\s*)?(?<_3>interface|procedure|module)))\b/,
    name: "keyword.other.programming-units.fortran.modern"},
   {begin: /\b(?i:(?<_1>type(?=\s*\()))\b(?=.*::)/,
    beginCaptures: {1 => {name: "storage.type.fortran.modern"}},
    comment: "Line of type specification",
    end: "(?=!)|$",
    name: "meta.specification.fortran.modern",
    patterns: [{include: "$base"}]},
   {match: /\b(?i:(?<_1>type(?=\s*\()))\b/,
    name: "storage.type.fortran.modern"},
   {match: 
     /\b(?i:(?<_1>optional|recursive|pointer|allocatable|target|private|public))\b/,
    name: "storage.modifier.fortran.modern"}],
 scopeName: "source.fortran.modern",
 uuid: "016CA1B6-8351-4B17-9215-29C275D5D973"}
