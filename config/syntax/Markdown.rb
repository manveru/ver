# Encoding: UTF-8

{fileTypes: ["mdown", "markdown", "markdn", "md"],
 foldingStartMarker: 
  /(?x)
	(?<_1><(?i:head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|form|dl)\b.*?>
	|<!--(?!.*-->)
	|\{\s*(?<_2>$|\?>\s*$|\/\/|\/\*(?<_3>.*\*\/\s*$|(?!.*?\*\/)))
	)/,
 foldingStopMarker: 
  /(?x)
	(?<_1><\/(?i:head|body|table|thead|tbody|tfoot|tr|div|select|fieldset|style|script|ul|ol|form|dl)>
	|^\s*-->
	|(?<_2>^|\s)\}
	)/,
 keyEquivalent: "^~M",
 name: "Markdown",
 patterns: 
  [{begin: 
     /(?x)^
	(?=	[ ]{,3}>.
	|	(?<_1>[ ]{4}|\t)(?!$)
	|	[#]{1,6}\s*+
	|	[ ]{,3}(?<marker>[-*_])(?<_2>[ ]{,2}\k<marker>){2,}[ \t]*+$
	)/,
    comment: 
     "\n\t\t\t\tWe could also use an empty end match and set\n\t\t\t\tapplyEndPatternLast, but then we must be sure that the begin\n\t\t\t\tpattern will only match stuff matched by the sub-patterns.\n\t\t\t",
    end: 
     "(?x)^\n\t\t\t\t(?!\t[ ]{,3}>.\n\t\t\t\t|\t([ ]{4}|\\t)\n\t\t\t\t|\t[#]{1,6}\\s*+\n\t\t\t\t|\t[ ]{,3}(?<marker>[-*_])([ ]{,2}\\k<marker>){2,}[ \\t]*+$\n\t\t\t\t)",
    name: "meta.block-level.markdown",
    patterns: 
     [{include: "#block_quote"},
      {include: "#block_raw"},
      {include: "#heading"},
      {include: "#separator"}]},
   {begin: /^[ ]{0,3}(?<_1>[*+-])(?=\s)/,
    captures: {1 => {name: "punctuation.definition.list_item.markdown"}},
    end: "^(?=\\S)",
    name: "markup.list.unnumbered.markdown",
    patterns: [{include: "#list-paragraph"}]},
   {begin: /^[ ]{0,3}(?<_1>[0-9]+\.)(?=\s)/,
    captures: {1 => {name: "punctuation.definition.list_item.markdown"}},
    end: "^(?=\\S)",
    name: "markup.list.numbered.markdown",
    patterns: [{include: "#list-paragraph"}]},
   {begin: 
     /^(?=<(?<_1>p|div|h[1-6]|blockquote|pre|table|dl|ol|ul|script|noscript|form|fieldset|iframe|math|ins|del)\b)(?!.*?<\/\k<_1>>)/,
    comment: 
     "\n\t\t\t\tMarkdown formatting is disabled inside block-level tags.\n\t\t\t",
    end: "(?<=^</\\1>$\\n)",
    name: "meta.disable-markdown",
    patterns: [{include: "text.html.basic"}]},
   {begin: 
     /^(?=<(?<_1>p|div|h[1-6]|blockquote|pre|table|dl|ol|ul|script|noscript|form|fieldset|iframe|math|ins|del)\b)/,
    comment: "Same rule but for one line disables.",
    end: "$\\n?",
    name: "meta.disable-markdown",
    patterns: [{include: "text.html.basic"}]},
   {captures: 
     {1 => {name: "punctuation.definition.constant.markdown"},
      10 => {name: "punctuation.definition.string.end.markdown"},
      11 => {name: "string.other.link.description.title.markdown"},
      12 => {name: "punctuation.definition.string.begin.markdown"},
      13 => {name: "punctuation.definition.string.end.markdown"},
      2 => {name: "constant.other.reference.link.markdown"},
      3 => {name: "punctuation.definition.constant.markdown"},
      4 => {name: "punctuation.separator.key-value.markdown"},
      5 => {name: "punctuation.definition.link.markdown"},
      6 => {name: "markup.underline.link.markdown"},
      7 => {name: "punctuation.definition.link.markdown"},
      8 => {name: "string.other.link.description.title.markdown"},
      9 => {name: "punctuation.definition.string.begin.markdown"}},
    match: 
     /(?x:
	\s*						# Leading whitespace
	(?<_1>\[)(?<_2>.+?)(?<_3>\])(?<_4>:)		# Reference name
	[ \t]*					# Optional whitespace
	(?<_5><?)(?<_6>\S+?)(?<_7>>?)			# The url
	[ \t]*					# Optional whitespace
	(?:
	  (?<_8>(?<_9>\().+?(?<_10>\)))		# Match title in quotes…
	| (?<_11>(?<_12>").+?(?<_13>"))		# or in parens.
	)?						# Title is optional
	\s*						# Optional whitespace
	$
	)/,
    name: "meta.link.reference.def.markdown"},
   {begin: /^(?=\S)(?![=-]{3,}(?=$))/,
    end: 
     "^(?:\\s*$|(?=[ ]{,3}>.))|(?=[ \\t]*\\n)(?<=^===|^====|=====|^---|^----|-----)[ \\t]*\\n|(?=^#)",
    name: "meta.paragraph.markdown",
    patterns: 
     [{include: "#inline"},
      {include: "text.html.basic"},
      {captures: {1 => {name: "punctuation.definition.heading.markdown"}},
       match: /^(?<_1>={3,})(?=[ \t]*$)/,
       name: "markup.heading.1.markdown"},
      {captures: {1 => {name: "punctuation.definition.heading.markdown"}},
       match: /^(?<_1>-{3,})(?=[ \t]*$)/,
       name: "markup.heading.2.markdown"}]}],
 repository: 
  {ampersand: 
    {comment: 
      "\n\t\t\t\tMarkdown will convert this for us. We match it so that the\n\t\t\t\tHTML grammar will not mark it up as invalid.\n\t\t\t",
     match: /&(?!(?<_1>[a-zA-Z0-9]+|#[0-9]+|#x[0-9a-fA-F]+);)/,
     name: "meta.other.valid-ampersand.markdown"},
   block_quote: 
    {begin: /\G[ ]{,3}(?<_1>>)(?!$)[ ]?/,
     beginCaptures: 
      {1 => {name: "punctuation.definition.blockquote.markdown"}},
     comment: 
      "\n\t\t\t\tWe terminate the block quote when seeing an empty line, a\n\t\t\t\tseparator or a line with leading > characters. The latter is\n\t\t\t\tto “reset” the quote level for quoted lines.\n\t\t\t",
     end: 
      "(?x)^\n\t\t\t\t(?=\t\\s*$\n\t\t\t\t|\t[ ]{,3}(?<marker>[-*_])([ ]{,2}\\k<marker>){2,}[ \\t]*+$\n\t\t\t\t|\t[ ]{,3}>.\n\t\t\t\t)",
     name: "markup.quote.markdown",
     patterns: 
      [{begin: /(?x)\G
	(?=	[ ]{,3}>.
	)/,
        end: "^",
        patterns: [{include: "#block_quote"}]},
       {applyEndPatternLast: 1,
        begin: 
         /(?x)\G
	(?=	(?<_1>[ ]{4}|\t)
	|	[#]{1,6}\s*+
	|	[ ]{,3}(?<marker>[-*_])(?<_2>[ ]{,2}\k<marker>){2,}[ \t]*+$
	)/,
        end: "^",
        patterns: 
         [{include: "#block_raw"},
          {include: "#heading"},
          {include: "#separator"}]},
       {begin: 
         /(?x)\G
	(?!	$
	|	[ ]{,3}>.
	|	(?<_1>[ ]{4}|\t)
	|	[#]{1,6}\s*+
	|	[ ]{,3}(?<marker>[-*_])(?<_2>[ ]{,2}\k<marker>){2,}[ \t]*+$
	)/,
        end: "$|(?<=\\n)",
        patterns: [{include: "#inline"}]}]},
   block_raw: 
    {match: /\G(?<_1>[ ]{4}|\t).*$\n?/, name: "markup.raw.block.markdown"},
   bold: 
    {begin: 
      /(?x)
	(?<_1>\*\*|__)(?=\S)								# Open
	(?=
	(?<_2>
	    <[^>]*+>							# HTML tags
	  | (?<raw>`+)(?<_3>[^`]|(?!(?<!`)\k<raw>(?!`))`)*+\k<raw>
	# Raw
	  | \\[\\`*_{}\[\](?<_4>)#.!+\->]?+			# Escapes
	  | \[
	(?<_5>				
	        (?<square>					# Named group
	[^\[\]\\]				# Match most chars
	          | \\.						# Escaped chars
	          | \[ \g<square>*+ \]		# Nested brackets
	        )*+
	\]
	(?<_6>
	(?<_7>							# Reference Link
	[ ]?					# Optional space
	\[[^\]]*+\]				# Ref name
	)
	  | (?<_8>							# Inline Link
	\(						# Opening paren
	[ \t]*+				# Optional whtiespace
	<?(?<_9>.*?)>?			# URL
	[ \t]*+				# Optional whtiespace
	(?<_10>					# Optional Title
	(?<title>['"])
	(?<_11>.*?)
	\k<title>
	)?
	\)
	)
	)
	)
	  | (?!(?<=\S)\k<_1>).						# Everything besides
	# style closer
	)++
	(?<=\S)\k<_1>								# Close
	)
	/,
     captures: {1 => {name: "punctuation.definition.bold.markdown"}},
     end: "(?<=\\S)(\\1)",
     name: "markup.bold.markdown",
     patterns: 
      [{applyEndPatternLast: 1,
        begin: /(?=<[^>]*?>)/,
        end: "(?<=>)",
        patterns: [{include: "text.html.basic"}]},
       {include: "#escape"},
       {include: "#ampersand"},
       {include: "#bracket"},
       {include: "#raw"},
       {include: "#italic"},
       {include: "#image-inline"},
       {include: "#link-inline"},
       {include: "#link-inet"},
       {include: "#link-email"},
       {include: "#image-ref"},
       {include: "#link-ref-literal"},
       {include: "#link-ref"}]},
   bracket: 
    {comment: 
      "\n\t\t\t\tMarkdown will convert this for us. We match it so that the\n\t\t\t\tHTML grammar will not mark it up as invalid.\n\t\t\t",
     match: /<(?![a-z\/?\$!])/,
     name: "meta.other.valid-bracket.markdown"},
   escape: 
    {match: /\\[-`*_#+.!(?<_1>){}\[\]\\>]/,
     name: "constant.character.escape.markdown"},
   heading: 
    {begin: /\G(?<_1>\#{1,6})(?!#)\s*(?=\S)/,
     captures: {1 => {name: "punctuation.definition.heading.markdown"}},
     contentName: "entity.name.section.markdown",
     end: "\\s*(#*)$\\n?",
     name: "markup.heading.markdown",
     patterns: [{include: "#inline"}]},
   :"image-inline" => 
    {captures: 
      {1 => {name: "punctuation.definition.string.begin.markdown"},
       10 => {name: "string.other.link.description.title.markdown"},
       11 => {name: "punctuation.definition.string.markdown"},
       12 => {name: "punctuation.definition.string.markdown"},
       13 => {name: "string.other.link.description.title.markdown"},
       14 => {name: "punctuation.definition.string.markdown"},
       15 => {name: "punctuation.definition.string.markdown"},
       16 => {name: "punctuation.definition.metadata.markdown"},
       2 => {name: "string.other.link.description.markdown"},
       3 => {name: "punctuation.definition.string.end.markdown"},
       5 => {name: "invalid.illegal.whitespace.markdown"},
       6 => {name: "punctuation.definition.metadata.markdown"},
       7 => {name: "punctuation.definition.link.markdown"},
       8 => {name: "markup.underline.link.image.markdown"},
       9 => {name: "punctuation.definition.link.markdown"}},
     match: 
      /(?x:
	\!							# Images start with !
	(?<_1>\[)(?<_2>(?<square>[^\[\]\\]|\\.|\[\g<square>*+\])*+)(?<_3>\])	
	# Match the link text.
	(?<_4>[ ])?						# Space not allowed
	(?<_5>\()						# Opening paren for url
	(?<_6><?)(?<_7>\S+?)(?<_8>>?)			# The url
	[ \t]*					# Optional whitespace
	(?:
	  (?<_9>(?<_10>\().+?(?<_11>\)))		# Match title in parens…
	| (?<_12>(?<_13>").+?(?<_14>"))		# or in quotes.
	)?						# Title is optional
	\s*						# Optional whitespace
	(?<_15>\))
	 )/,
     name: "meta.image.inline.markdown"},
   :"image-ref" => 
    {captures: 
      {1 => {name: "punctuation.definition.string.begin.markdown"},
       2 => {name: "string.other.link.description.markdown"},
       4 => {name: "punctuation.definition.string.begin.markdown"},
       5 => {name: "punctuation.definition.constant.markdown"},
       6 => {name: "constant.other.reference.link.markdown"},
       7 => {name: "punctuation.definition.constant.markdown"}},
     match: 
      /\!(?<_1>\[)(?<_2>(?<square>[^\[\]\\]|\\.|\[\g<square>*+\])*+)(?<_3>\])[ ]?(?<_4>\[)(?<_5>.*?)(?<_6>\])/,
     name: "meta.image.reference.markdown"},
   inline: 
    {patterns: 
      [{include: "#escape"},
       {include: "#ampersand"},
       {include: "#bracket"},
       {include: "#raw"},
       {include: "#bold"},
       {include: "#italic"},
       {include: "#line-break"},
       {include: "#image-inline"},
       {include: "#link-inline"},
       {include: "#link-inet"},
       {include: "#link-email"},
       {include: "#image-ref"},
       {include: "#link-ref-literal"},
       {include: "#link-ref"}]},
   italic: 
    {begin: 
      /(?x)
	(?<_1>\*|_)(?=\S)								# Open
	(?=
	(?<_2>
	    <[^>]*+>							# HTML tags
	  | (?<raw>`+)(?<_3>[^`]|(?!(?<!`)\k<raw>(?!`))`)*+\k<raw>
	# Raw
	  | \\[\\`*_{}\[\](?<_4>)#.!+\->]?+			# Escapes
	  | \[
	(?<_5>				
	        (?<square>					# Named group
	[^\[\]\\]				# Match most chars
	          | \\.						# Escaped chars
	          | \[ \g<square>*+ \]		# Nested brackets
	        )*+
	\]
	(?<_6>
	(?<_7>							# Reference Link
	[ ]?					# Optional space
	\[[^\]]*+\]				# Ref name
	)
	  | (?<_8>							# Inline Link
	\(						# Opening paren
	[ \t]*+				# Optional whtiespace
	<?(?<_9>.*?)>?			# URL
	[ \t]*+				# Optional whtiespace
	(?<_10>					# Optional Title
	(?<title>['"])
	(?<_11>.*?)
	\k<title>
	)?
	\)
	)
	)
	)
	  | \k<_1>\k<_1>								# Must be bold closer
	  | (?!(?<=\S)\k<_1>).						# Everything besides
	# style closer
	)++
	(?<=\S)\k<_1>								# Close
	)
	/,
     captures: {1 => {name: "punctuation.definition.italic.markdown"}},
     end: "(?<=\\S)(\\1)((?!\\1)|(?=\\1\\1))",
     name: "markup.italic.markdown",
     patterns: 
      [{applyEndPatternLast: 1,
        begin: /(?=<[^>]*?>)/,
        end: "(?<=>)",
        patterns: [{include: "text.html.basic"}]},
       {include: "#escape"},
       {include: "#ampersand"},
       {include: "#bracket"},
       {include: "#raw"},
       {include: "#bold"},
       {include: "#image-inline"},
       {include: "#link-inline"},
       {include: "#link-inet"},
       {include: "#link-email"},
       {include: "#image-ref"},
       {include: "#link-ref-literal"},
       {include: "#link-ref"}]},
   :"line-break" => {match: / {2,}$/, name: "meta.dummy.line-break"},
   :"link-email" => 
    {captures: 
      {1 => {name: "punctuation.definition.link.markdown"},
       2 => {name: "markup.underline.link.markdown"},
       4 => {name: "punctuation.definition.link.markdown"}},
     match: 
      /(?<_1><)(?<_2>(?:mailto:)?[-.\w]+@[-a-z0-9]+(?<_3>\.[-a-z0-9]+)*\.[a-z]+)(?<_4>>)/,
     name: "meta.link.email.lt-gt.markdown"},
   :"link-inet" => 
    {captures: 
      {1 => {name: "punctuation.definition.link.markdown"},
       2 => {name: "markup.underline.link.markdown"},
       3 => {name: "punctuation.definition.link.markdown"}},
     match: /(?<_1><)(?<_2>(?:https?|ftp):\/\/.*?)(?<_3>>)/,
     name: "meta.link.inet.markdown"},
   :"link-inline" => 
    {captures: 
      {1 => {name: "punctuation.definition.string.begin.markdown"},
       10 => {name: "string.other.link.description.title.markdown"},
       11 => {name: "punctuation.definition.string.begin.markdown"},
       12 => {name: "punctuation.definition.string.end.markdown"},
       13 => {name: "string.other.link.description.title.markdown"},
       14 => {name: "punctuation.definition.string.begin.markdown"},
       15 => {name: "punctuation.definition.string.end.markdown"},
       16 => {name: "punctuation.definition.metadata.markdown"},
       2 => {name: "string.other.link.title.markdown"},
       4 => {name: "punctuation.definition.string.end.markdown"},
       5 => {name: "invalid.illegal.whitespace.markdown"},
       6 => {name: "punctuation.definition.metadata.markdown"},
       7 => {name: "punctuation.definition.link.markdown"},
       8 => {name: "markup.underline.link.markdown"},
       9 => {name: "punctuation.definition.link.markdown"}},
     match: 
      /(?x:
	(?<_1>\[)(?<_2>(?<square>[^\[\]\\]|\\.|\[\g<square>*+\])*+)(?<_3>\])	
	# Match the link text.
	(?<_4>[ ])?						# Space not allowed
	(?<_5>\()						# Opening paren for url
	(?<_6><?)(?<_7>.*?)(?<_8>>?)			# The url
	[ \t]*					# Optional whitespace
	(?:
	  (?<_9>(?<_10>\().+?(?<_11>\)))		# Match title in parens…
	| (?<_12>(?<_13>").+?(?<_14>"))		# or in quotes.
	)?						# Title is optional
	\s*						# Optional whitespace
	(?<_15>\))
	 )/,
     name: "meta.link.inline.markdown"},
   :"link-ref" => 
    {captures: 
      {1 => {name: "punctuation.definition.string.begin.markdown"},
       2 => {name: "string.other.link.title.markdown"},
       4 => {name: "punctuation.definition.string.end.markdown"},
       5 => {name: "punctuation.definition.constant.begin.markdown"},
       6 => {name: "constant.other.reference.link.markdown"},
       7 => {name: "punctuation.definition.constant.end.markdown"}},
     match: 
      /(?<_1>\[)(?<_2>(?<square>[^\[\]\\]|\\.|\[\g<square>*+\])*+)(?<_3>\])[ ]?(?<_4>\[)(?<_5>[^\]]*+)(?<_6>\])/,
     name: "meta.link.reference.markdown"},
   :"link-ref-literal" => 
    {captures: 
      {1 => {name: "punctuation.definition.string.begin.markdown"},
       2 => {name: "string.other.link.title.markdown"},
       4 => {name: "punctuation.definition.string.end.markdown"},
       5 => {name: "punctuation.definition.constant.begin.markdown"},
       6 => {name: "punctuation.definition.constant.end.markdown"}},
     match: 
      /(?<_1>\[)(?<_2>(?<square>[^\[\]\\]|\\.|\[\g<square>*+\])*+)(?<_3>\])[ ]?(?<_4>\[)(?<_5>\])/,
     name: "meta.link.reference.literal.markdown"},
   :"list-paragraph" => 
    {patterns: 
      [{begin: /\G\s+(?=\S)/,
        end: "^\\s*$",
        name: "meta.paragraph.list.markdown",
        patterns: 
         [{include: "#inline"},
          {captures: 
            {1 => {name: "punctuation.definition.list_item.markdown"}},
           comment: "Match the list punctuation",
           match: /^\s*(?<_1>[*+-]|[0-9]+\.)/}]}]},
   raw: 
    {captures: 
      {1 => {name: "punctuation.definition.raw.markdown"},
       3 => {name: "punctuation.definition.raw.markdown"}},
     match: /(?<_1>`+)(?<_2>[^`]|(?!(?<!`)\k<_1>(?!`))`)*+(?<_3>\k<_1>)/,
     name: "markup.raw.inline.markdown"},
   separator: 
    {match: /\G[ ]{,3}(?<_1>[-*_])(?<_2>[ ]{,2}\k<_1>){2,}[ \t]*$\n?/,
     name: "meta.separator.markdown"}},
 scopeName: "text.html.markdown",
 uuid: "0A1D9874-B448-11D9-BD50-000D93B6E43C"}
