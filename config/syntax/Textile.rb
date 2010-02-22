# Encoding: UTF-8

{fileTypes: ["textile"],
 firstLineMatch: "textile",
 keyEquivalent: "^~T",
 name: "Textile",
 patterns: 
  [{begin: 
     /(?<_1>^h[1-6](?<_2>[<>=(?<_3>)]+)?)(?<_4>\([^)]*\)|{[^}]*})*(?<_5>\.)/,
    captures: 
     {1 => {name: "entity.name.tag.heading.textile"},
      3 => {name: "entity.name.type.textile"},
      4 => {name: "entity.name.tag.heading.textile"}},
    end: "^$",
    name: "markup.heading.textile",
    patterns: [{include: "#inline"}, {include: "text.html.basic"}]},
   {begin: /(?<_1>^bq(?<_2>[<>=(?<_3>)]+)?)(?<_4>\([^)]*\)|{[^}]*})*(?<_5>\.)/,
    captures: 
     {1 => {name: "entity.name.tag.blockquote.textile"},
      3 => {name: "entity.name.type.textile"},
      4 => {name: "entity.name.tag.blockquote.textile"}},
    end: "^$",
    name: "markup.quote.textile",
    patterns: [{include: "#inline"}, {include: "text.html.basic"}]},
   {begin: 
     /(?<_1>^fn[0-9]+(?<_2>[<>=(?<_3>)]+)?)(?<_4>\([^)]*\)|{[^}]*})*(?<_5>\.)/,
    captures: 
     {1 => {name: "entity.name.tag.footnote.textile"},
      3 => {name: "entity.name.type.textile"},
      4 => {name: "entity.name.tag.footnote.textile"}},
    end: "^$",
    name: "markup.other.footnote.textile",
    patterns: [{include: "#inline"}, {include: "text.html.basic"}]},
   {begin: 
     /(?<_1>^table(?<_2>[<>=(?<_3>)]+)?)(?<_4>\([^)]*\)|{[^}]*})*(?<_5>\.)/,
    captures: 
     {1 => {name: "entity.name.tag.footnote.textile"},
      3 => {name: "entity.name.type.textile"},
      4 => {name: "entity.name.tag.footnote.textile"}},
    end: "^$",
    name: "markup.other.table.textile",
    patterns: [{include: "#inline"}, {include: "text.html.basic"}]},
   {begin: /^(?=\S)/,
    end: "^$",
    name: "meta.paragraph.textile",
    patterns: 
     [{captures: 
        {1 => {name: "entity.name.tag.paragraph.textile"},
         3 => {name: "entity.name.type.textile"},
         4 => {name: "entity.name.tag.paragraph.textile"}},
       match: 
        /(?<_1>^p(?<_2>[<>=(?<_3>)]+)?)(?<_4>\([^)]*\)|{[^}]*})*(?<_5>\.)/,
       name: "entity.name.section.paragraph.textile"},
      {include: "#inline"},
      {include: "text.html.basic"}]},
   {comment: "Since html is valid in Textile include the html patterns",
    include: "text.html.basic"}],
 repository: 
  {inline: 
    {patterns: 
      [{comment: 
         "& is handled automagically by textile, so we match it to avoid text.html.basic from flagging it",
        match: /&(?![A-Za-z0-9]+;)/,
        name: "text.html.textile"},
       {captures: {1 => {name: "entity.name.type.textile"}},
        match: /^\*+(?<_1>\([^)]*\)|{[^}]*})*(?<_2>\s+|$)/,
        name: "markup.list.unnumbered.textile"},
       {captures: {1 => {name: "entity.name.type.textile"}},
        match: /^#+(?<_1>\([^)]*\)|{[^}]*})*\s+/,
        name: "markup.list.numbered.textile"},
       {captures: 
         {1 => {name: "string.other.link.title.textile"},
          2 => {name: "string.other.link.description.title.textile"},
          3 => {name: "constant.other.reference.link.textile"}},
        match: 
         /(?x)
	"								# Start name, etc
	(?:							# Attributes
	# I swear, this is how the language is defined,
	# couldnt make it up if I tried.
	(?:\([^)]+\))?(?:\{[^}]+\})?(?:\[[^\]]+\])?
	# Class, Style, Lang
	  | (?:\{[^}]+\})?(?:\[[^\]]+\])?(?:\([^)]+\))?
	# Style, Lang, Class
	  | (?:\[[^\]]+\])?(?:\{[^}]+\})?(?:\([^)]+\))?
	# Lang, Style, Class
	)?
	(?<_1>[^"]+?)					# Link name
	\s?							# Optional whitespace
	(?:\((?<_2>[^)]+?)\))?
	":								# End name
	(?<_3>\w[-\w_]*)						# Linkref
	(?=[^\w\/;]*?(?<_4><|\s|$))			# Catch closing punctuation
	#  and end of meta.link
	/,
        name: "meta.link.reference.textile"},
       {captures: 
         {1 => {name: "string.other.link.title.textile"},
          2 => {name: "string.other.link.description.title.textile"},
          3 => {name: "markup.underline.link.textile"}},
        match: 
         /(?x)
	"								# Start name, etc
	(?:							# Attributes
	# I swear, this is how the language is defined,
	# couldnt make it up if I tried.
	(?:\([^)]+\))?(?:\{[^}]+\})?(?:\[[^\]]+\])?
	# Class, Style, Lang
	  | (?:\{[^}]+\})?(?:\[[^\]]+\])?(?:\([^)]+\))?
	# Style, Lang, Class
	  | (?:\[[^\]]+\])?(?:\{[^}]+\})?(?:\([^)]+\))?
	# Lang, Style, Class
	)?
	(?<_1>[^"]+?)					# Link name
	\s?							# Optional whitespace
	(?:\((?<_2>[^)]+?)\))?
	":								# End Name
	(?<_3>\S*?(?:\w|\/|;))				# URL
	(?=[^\w\/;]*?(?<_4><|\s|$))			# Catch closing punctuation
	#  and end of meta.link
	/,
        name: "meta.link.inline.textile"},
       {captures: 
         {2 => {name: "markup.underline.link.image.textile"},
          3 => {name: "string.other.link.description.textile"},
          4 => {name: "markup.underline.link.textile"}},
        match: 
         /(?x)
	\!										# Open image
	(?<_1>\<|\=|\>)?								# Optional alignment
	(?:										# Attributes
	# I swear, this is how the language is defined,
	# couldnt make it up if I tried.
	(?:\([^)]+\))?(?:\{[^}]+\})?(?:\[[^\]]+\])?
	# Class, Style, Lang
	  | (?:\{[^}]+\})?(?:\[[^\]]+\])?(?:\([^)]+\))?
	# Style, Lang, Class
	  | (?:\[[^\]]+\])?(?:\{[^}]+\})?(?:\([^)]+\))?
	# Lang, Style, Class
	)?
	(?:\.[ ])?            					# Optional
	(?<_2>[^\s(?<_3>!]+?)         					# Image URL
	\s?                						# Optional space
	(?:\((?<_4>(?:[^\(\)]|\([^\)]+\))+?)\))?   	# Optional title
	\!										# Close image
	(?:
	:
	(?<_5>\S*?(?:\w|\/|;))					# URL
	(?=[^\w\/;]*?(?<_6><|\s|$))				# Catch closing punctuation
	)?
	/,
        name: "meta.image.inline.textile"},
       {captures: {1 => {name: "entity.name.type.textile"}},
        match: /\|(?<_1>\([^)]*\)|{[^}]*})*(?<_2>\\\||.)+\|/,
        name: "markup.other.table.cell.textile"},
       {captures: {3 => {name: "entity.name.type.textile"}},
        match: 
         /\B(?<_1>\*\*?)(?<_2>(?<_3>\([^)]*\)|{[^}]*}|\[[^\]]+\]){0,3})(?<_4>\S.*?\S|\S)\k<_1>\B/,
        name: "markup.bold.textile"},
       {captures: {2 => {name: "entity.name.type.textile"}},
        match: 
         /\B-(?<_1>(?<_2>\([^)]*\)|{[^}]*}|\[[^\]]+\]){0,3})(?<_3>\S.*?\S|\S)-\B/,
        name: "markup.deleted.textile"},
       {captures: {2 => {name: "entity.name.type.textile"}},
        match: 
         /\B\+(?<_1>(?<_2>\([^)]*\)|{[^}]*}|\[[^\]]+\]){0,3})(?<_3>\S.*?\S|\S)\+\B/,
        name: "markup.inserted.textile"},
       {captures: {2 => {name: "entity.name.type.textile"}},
        match: 
         /(?:\b|\s)_(?<_1>(?<_2>\([^)]*\)|{[^}]*}|\[[^\]]+\]){0,3})(?<_3>\S.*?\S|\S)_(?:\b|\s)/,
        name: "markup.italic.textile"},
       {captures: {3 => {name: "entity.name.type.textile"}},
        match: 
         /\B(?<_1>[@\^~%]|\?\?)(?<_2>(?<_3>\([^)]*\)|{[^}]*}|\[[^\]]+\]){0,3})(?<_4>\S.*?\S|\S)\k<_1>/,
        name: "markup.italic.phrasemodifiers.textile"},
       {comment: "Footnotes",
        match: /(?<!w)\[[0-9+]\]/,
        name: "entity.name.tag.textile"}]}},
 scopeName: "text.html.textile",
 uuid: "68F0B1A5-3274-4E85-8B3A-A481C5F5B194"}
