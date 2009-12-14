# Encoding: UTF-8

{fileTypes: ["textile"],
 firstLineMatch: "textile",
 keyEquivalent: /^~T/,
 name: "Textile",
 patterns: 
  [{begin: /(^h[1-6]([<>=()]+)?)(\([^)]*\)|{[^}]*})*(\.)/,
    captures: 
     {1 => {name: "entity.name.tag.heading.textile"},
      3 => {name: "entity.name.type.textile"},
      4 => {name: "entity.name.tag.heading.textile"}},
    end: "^$",
    name: "markup.heading.textile",
    patterns: [{include: "#inline"}, {include: "text.html.basic"}]},
   {begin: /(^bq([<>=()]+)?)(\([^)]*\)|{[^}]*})*(\.)/,
    captures: 
     {1 => {name: "entity.name.tag.blockquote.textile"},
      3 => {name: "entity.name.type.textile"},
      4 => {name: "entity.name.tag.blockquote.textile"}},
    end: "^$",
    name: "markup.quote.textile",
    patterns: [{include: "#inline"}, {include: "text.html.basic"}]},
   {begin: /(^fn[0-9]+([<>=()]+)?)(\([^)]*\)|{[^}]*})*(\.)/,
    captures: 
     {1 => {name: "entity.name.tag.footnote.textile"},
      3 => {name: "entity.name.type.textile"},
      4 => {name: "entity.name.tag.footnote.textile"}},
    end: "^$",
    name: "markup.other.footnote.textile",
    patterns: [{include: "#inline"}, {include: "text.html.basic"}]},
   {begin: /(^table([<>=()]+)?)(\([^)]*\)|{[^}]*})*(\.)/,
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
       match: /(^p([<>=()]+)?)(\([^)]*\)|{[^}]*})*(\.)/,
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
        match: /^\*+(\([^)]*\)|{[^}]*})*(\s+|$)/,
        name: "markup.list.unnumbered.textile"},
       {captures: {1 => {name: "entity.name.type.textile"}},
        match: /^#+(\([^)]*\)|{[^}]*})*\s+/,
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
	([^"]+?)					# Link name
	\s?							# Optional whitespace
	(?:\(([^)]+?)\))?
	":								# End name
	(\w[-\w_]*)						# Linkref
	(?=[^\w\/;]*?(<|\s|$))			# Catch closing punctuation
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
	([^"]+?)					# Link name
	\s?							# Optional whitespace
	(?:\(([^)]+?)\))?
	":								# End Name
	(\S*?(?:\w|\/|;))				# URL
	(?=[^\w\/;]*?(<|\s|$))			# Catch closing punctuation
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
	(\<|\=|\>)?								# Optional alignment
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
	([^\s(!]+?)         					# Image URL
	\s?                						# Optional space
	(?:\(((?:[^\(\)]|\([^\)]+\))+?)\))?   	# Optional title
	\!										# Close image
	(?:
	:
	(\S*?(?:\w|\/|;))					# URL
	(?=[^\w\/;]*?(<|\s|$))				# Catch closing punctuation
	)?
	/,
        name: "meta.image.inline.textile"},
       {captures: {1 => {name: "entity.name.type.textile"}},
        match: /\|(\([^)]*\)|{[^}]*})*(\\\||.)+\|/,
        name: "markup.other.table.cell.textile"},
       {captures: {3 => {name: "entity.name.type.textile"}},
        match: 
         /\B(\*\*?)((\([^)]*\)|{[^}]*}|\[[^\]]+\]){0,3})(\S.*?\S|\S)\1\B/,
        name: "markup.bold.textile"},
       {captures: {2 => {name: "entity.name.type.textile"}},
        match: /\B-((\([^)]*\)|{[^}]*}|\[[^\]]+\]){0,3})(\S.*?\S|\S)-\B/,
        name: "markup.deleted.textile"},
       {captures: {2 => {name: "entity.name.type.textile"}},
        match: /\B\+((\([^)]*\)|{[^}]*}|\[[^\]]+\]){0,3})(\S.*?\S|\S)\+\B/,
        name: "markup.inserted.textile"},
       {captures: {2 => {name: "entity.name.type.textile"}},
        match: 
         /(?:\b|\s)_((\([^)]*\)|{[^}]*}|\[[^\]]+\]){0,3})(\S.*?\S|\S)_(?:\b|\s)/,
        name: "markup.italic.textile"},
       {captures: {3 => {name: "entity.name.type.textile"}},
        match: 
         /\B([@\^~%]|\?\?)((\([^)]*\)|{[^}]*}|\[[^\]]+\]){0,3})(\S.*?\S|\S)\1/,
        name: "markup.italic.phrasemodifiers.textile"},
       {comment: "Footnotes",
        match: /(?<!w)\[[0-9+]\]/,
        name: "entity.name.tag.textile"}]}},
 scopeName: "text.html.textile",
 uuid: "68F0B1A5-3274-4E85-8B3A-A481C5F5B194"}
