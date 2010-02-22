# Encoding: UTF-8

{fileTypes: ["applescript", "script editor"],
 firstLineMatch: "^#!.*(osascript)",
 foldingStartMarker: 
  /(?x)
	^\s*
	(?<_1>
	 tell \s+ (?! .* \b(?<_2>to)\b) .*
	|tell\b.*?\bto\ tell \s+ (?! .* \b(?<_3>to)\b) .*
	|using \s+ terms \s+ from \s+ .*
	|if\b .* \bthen\b
	|repeat\b .*
	|(?<_4> on | to )\b (?!\s+ error) .*
	|try\b
	|with \s+ timeout\b .*
	|script\b .*
	|(?<_5> considering | ignoring )\b .*
	)\s*(?<_6>--.*?)?$
	/,
 foldingStopMarker: /^\s*end\b.*$/,
 keyEquivalent: "^~A",
 name: "AppleScript",
 patterns: [{include: "#blocks"}, {include: "#inline"}],
 repository: 
  {:"attributes.considering-ignoring" => 
    {patterns: 
      [{match: /,/,
        name: "punctuation.separator.array.attributes.applescript"},
       {match: /\b(?<_1>and)\b/,
        name: "keyword.control.attributes.and.applescript"},
       {match: 
         /\b(?i:case|diacriticals|hyphens|numeric\s+strings|punctuation|white\s+space)\b/,
        name: "constant.other.attributes.text.applescript"},
       {match: /\b(?i:application\s+responses)\b/,
        name: "constant.other.attributes.application.applescript"}]},
   blocks: 
    {patterns: 
      [{begin: /^\s*(?<_1>script)\s+(?<_2>\w+)/,
        beginCaptures: 
         {1 => {name: "keyword.control.script.applescript"},
          2 => {name: "entity.name.type.script-object.applescript"}},
        end: "^\\s*(end(?:\\s+script)?)(?=\\s*(--.*?)?$)",
        endCaptures: {1 => {name: "keyword.control.script.applescript"}},
        name: "meta.block.script.applescript",
        patterns: [{include: "$self"}]},
       {begin: 
         /^(?x)
	\s*(?<_1>to|on)\s+ 					# "on" or "to"
	(?<_2>\w+)							# function name
	(?<_3>\()							# opening paren
	(?<_4>(?:[\s,:\{\}]*(?:\w+)?)*)	# parameters
	(?<_5>\))							# closing paren
	/,
        beginCaptures: 
         {1 => {name: "keyword.control.function.applescript"},
          2 => {name: "entity.name.function.handler.applescript"},
          3 => {name: "punctuation.definition.parameters.applescript"},
          4 => {name: "variable.parameter.handler.applescript"},
          5 => {name: "punctuation.definition.parameters.applescript"}},
        comment: 
         "\n\t\t\t\t\t\tThis is not a very well-designed rule.  For now,\n\t\t\t\t\t\twe can leave it like this though, as it sorta works.\n\t\t\t\t\t",
        end: "^\\s*(end)(?:\\s+(\\2))?(?=\\s*(--.*?)?$)",
        endCaptures: {1 => {name: "keyword.control.function.applescript"}},
        name: "meta.function.positional.applescript",
        patterns: [{include: "$self"}]},
       {begin: 
         /^(?x)
	\s*(?<_1>to|on)\s+ 					# "on" or "to"
	(?<_2>\w+)							# function name
	(?:\s+
	(?<_3>of|in)\s+					# "of" or "in"
	(?<_4>\w+)						# direct parameter
	)?
	(?=\s+(?<_5>above|against|apart\s+from|around|aside\s+from|at|below|beneath|beside|between|by|for|from|instead\s+of|into|on|onto|out\s+of|over|thru|under)\b)
	/,
        beginCaptures: 
         {1 => {name: "keyword.control.function.applescript"},
          2 => {name: "entity.name.function.handler.applescript"},
          3 => {name: "keyword.control.function.applescript"},
          4 => {name: "variable.parameter.handler.direct.applescript"}},
        comment: "TODO: match `given` parameters",
        end: "^\\s*(end)(?:\\s+(\\2))?(?=\\s*(--.*?)?$)",
        endCaptures: {1 => {name: "keyword.control.function.applescript"}},
        name: "meta.function.prepositional.applescript",
        patterns: 
         [{captures: 
            {1 => {name: "keyword.control.preposition.applescript"},
             2 => {name: "variable.parameter.handler.applescript"}},
           match: 
            /\b(?i:above|against|apart\s+from|around|aside\s+from|at|below|beneath|beside|between|by|for|from|instead\s+of|into|on|onto|out\s+of|over|thru|under)\s+(?<_1>\w+)\b/},
          {include: "$self"}]},
       {begin: 
         /^(?x)
	\s*(?<_1>to|on)\s+ 					# "on" or "to"
	(?<_2>\w+)							# function name
	(?=\s*(?<_3>--.*?)?$)				# nothing else
	/,
        beginCaptures: 
         {1 => {name: "keyword.control.function.applescript"},
          2 => {name: "entity.name.function.handler.applescript"}},
        end: "^\\s*(end)(?:\\s+(\\2))?(?=\\s*(--.*?)?$)",
        endCaptures: {1 => {name: "keyword.control.function.applescript"}},
        name: "meta.function.parameterless.applescript",
        patterns: [{include: "$self"}]},
       {include: "#blocks.tell"},
       {include: "#blocks.repeat"},
       {include: "#blocks.statement"},
       {include: "#blocks.other"}]},
   :"blocks.other" => 
    {patterns: 
      [{begin: /^\s*(?<_1>considering)\b/,
        end: "^\\s*(end(?:\\s+considering)?)(?=\\s*(--.*?)?$)",
        name: "meta.block.considering.applescript",
        patterns: 
         [{begin: /(?<=considering)/,
           end: "(?<!¬)$",
           name: "meta.array.attributes.considering.applescript",
           patterns: [{include: "#attributes.considering-ignoring"}]},
          {begin: /(?<=ignoring)/,
           end: "(?<!¬)$",
           name: "meta.array.attributes.ignoring.applescript",
           patterns: [{include: "#attributes.considering-ignoring"}]},
          {match: /\b(?<_1>but)\b/, name: "keyword.control.but.applescript"},
          {include: "$self"}]},
       {begin: /^\s*(?<_1>ignoring)\b/,
        end: "^\\s*(end(?:\\s+ignoring)?)(?=\\s*(--.*?)?$)",
        name: "meta.block.ignoring.applescript",
        patterns: 
         [{begin: /(?<=considering)/,
           end: "(?<!¬)$",
           name: "meta.array.attributes.considering.applescript",
           patterns: [{include: "#attributes.considering-ignoring"}]},
          {begin: /(?<=ignoring)/,
           end: "(?<!¬)$",
           name: "meta.array.attributes.ignoring.applescript",
           patterns: [{include: "#attributes.considering-ignoring"}]},
          {match: /\b(?<_1>but)\b/, name: "keyword.control.but.applescript"},
          {include: "$self"}]},
       {begin: /^\s*(?<_1>if)\b/,
        beginCaptures: {1 => {name: "keyword.control.if.applescript"}},
        end: "^\\s*(end(?:\\s+if)?)(?=\\s*(--.*?)?$)",
        endCaptures: {1 => {name: "keyword.control.end.applescript"}},
        name: "meta.block.if.applescript",
        patterns: 
         [{match: /\b(?<_1>then)\b/, name: "keyword.control.then.applescript"},
          {match: /\b(?<_1>else\s+if)\b/,
           name: "keyword.control.else-if.applescript"},
          {match: /\b(?<_1>else)\b/, name: "keyword.control.else.applescript"},
          {include: "$self"}]},
       {begin: /^\s*(?<_1>try)\b/,
        beginCaptures: {1 => {name: "keyword.control.try.applescript"}},
        end: "^\\s*(end(?:\\s+(try|error))?)(?=\\s*(--.*?)?$)",
        endCaptures: {1 => {name: "keyword.control.end.applescript"}},
        name: "meta.block.try.applescript",
        patterns: 
         [{begin: /^\s*(?<_1>on\s+error)\b/,
           beginCaptures: 
            {1 => {name: "keyword.control.exception.on-error.applescript"}},
           end: "(?<!¬)$",
           name: "meta.property.error.applescript",
           patterns: 
            [{match: /\b(?i:number|partial|from|to)\b/,
              name: "keyword.control.exception.modifier.applescript"},
             {include: "#inline"}]},
          {include: "$self"}]},
       {begin: /^\s*(?<_1>using\s+terms\s+from)\b/,
        beginCaptures: {1 => {name: "keyword.control.terms.applescript"}},
        end: "^\\s*(end(?:\\s+using\\s+terms\\s+from)?)(?=\\s*(--.*?)?$)",
        endCaptures: {1 => {name: "keyword.control.end.applescript"}},
        name: "meta.block.terms.applescript",
        patterns: [{include: "$self"}]},
       {begin: /^\s*(?<_1>with\s+timeout(?<_2>\s+of)?)\b/,
        beginCaptures: {1 => {name: "keyword.control.timeout.applescript"}},
        end: "^\\s*(end(?:\\s+timeout)?)(?=\\s*(--.*?)?$)",
        endCaptures: {1 => {name: "keyword.control.end.applescript"}},
        name: "meta.block.timeout.applescript",
        patterns: [{include: "$self"}]},
       {begin: /^\s*(?<_1>with\s+transaction(?<_2>\s+of)?)\b/,
        beginCaptures: 
         {1 => {name: "keyword.control.transaction.applescript"}},
        end: "^\\s*(end(?:\\s+transaction)?)(?=\\s*(--.*?)?$)",
        endCaptures: {1 => {name: "keyword.control.end.applescript"}},
        name: "meta.block.transaction.applescript",
        patterns: [{include: "$self"}]}]},
   :"blocks.repeat" => 
    {patterns: 
      [{begin: /^\s*(?<_1>repeat)\s+(?<_2>until)\b/,
        beginCaptures: 
         {1 => {name: "keyword.control.repeat.applescript"},
          2 => {name: "keyword.control.until.applescript"}},
        end: "^\\s*(end(?:\\s+repeat)?)(?=\\s*(--.*?)?$)",
        endCaptures: {1 => {name: "keyword.control.end.applescript"}},
        name: "meta.block.repeat.until.applescript",
        patterns: [{include: "$self"}]},
       {begin: /^\s*(?<_1>repeat)\s+(?<_2>while)\b/,
        beginCaptures: 
         {1 => {name: "keyword.control.repeat.applescript"},
          2 => {name: "keyword.control.while.applescript"}},
        end: "^\\s*(end(?:\\s+repeat)?)(?=\\s*(--.*?)?$)",
        endCaptures: {1 => {name: "keyword.control.end.applescript"}},
        name: "meta.block.repeat.while.applescript",
        patterns: [{include: "$self"}]},
       {begin: /^\s*(?<_1>repeat)\s+(?<_2>with)\s+(?<_3>\w+)\b/,
        beginCaptures: 
         {1 => {name: "keyword.control.repeat.applescript"},
          2 => {name: "keyword.control.until.applescript"},
          3 => {name: "variable.parameter.loop.applescript"}},
        end: "^\\s*(end(?:\\s+repeat)?)(?=\\s*(--.*?)?$)",
        endCaptures: {1 => {name: "keyword.control.end.applescript"}},
        name: "meta.block.repeat.with.applescript",
        patterns: 
         [{match: /\b(?<_1>from|to|by)\b/,
           name: "keyword.control.modifier.range.applescript"},
          {match: /\b(?<_1>in)\b/,
           name: "keyword.control.modifier.list.applescript"},
          {include: "$self"}]},
       {begin: /^\s*(?<_1>repeat)\b(?=\s*(?<_2>--.*?)?$)/,
        beginCaptures: {1 => {name: "keyword.control.repeat.applescript"}},
        end: "^\\s*(end(?:\\s+repeat)?)(?=\\s*(--.*?)?$)",
        endCaptures: {1 => {name: "keyword.control.end.applescript"}},
        name: "meta.block.repeat.forever.applescript",
        patterns: [{include: "$self"}]},
       {begin: /^\s*(?<_1>repeat)\b/,
        beginCaptures: {1 => {name: "keyword.control.repeat.applescript"}},
        end: "^\\s*(end(?:\\s+repeat)?)(?=\\s*(--.*?)?$)",
        endCaptures: {1 => {name: "keyword.control.end.applescript"}},
        name: "meta.block.repeat.times.applescript",
        patterns: 
         [{match: /\b(?<_1>times)\b/,
           name: "keyword.control.times.applescript"},
          {include: "$self"}]}]},
   :"blocks.statement" => 
    {patterns: 
      [{begin: /\b(?<_1>prop(?:erty)?)\s+(?<_2>\w+)\b/,
        beginCaptures: 
         {1 => {name: "keyword.control.def.property.applescript"},
          2 => {name: "variable.other.property.applescript"}},
        end: "(?<!¬)$",
        name: "meta.statement.property.applescript",
        patterns: 
         [{match: /:/,
           name: "punctuation.separator.key-value.property.applescript"},
          {include: "#inline"}]},
       {begin: /\b(?<_1>set)\s+(?<_2>\w+)\s+(?<_3>to)\b/,
        beginCaptures: 
         {1 => {name: "keyword.control.def.set.applescript"},
          2 => {name: "variable.other.readwrite.set.applescript"},
          3 => {name: "keyword.control.def.set.applescript"}},
        end: "(?<!¬)$",
        name: "meta.statement.set.applescript",
        patterns: [{include: "#inline"}]},
       {begin: /\b(?<_1>local)\b/,
        beginCaptures: {1 => {name: "keyword.control.def.local.applescript"}},
        end: "(?<!¬)$",
        name: "meta.statement.local.applescript",
        patterns: 
         [{match: /,/,
           name: "punctuation.separator.variables.local.applescript"},
          {match: /\b\w+/, name: "variable.other.readwrite.local.applescript"},
          {include: "#inline"}]},
       {begin: /\b(?<_1>global)\b/,
        beginCaptures: {1 => {name: "keyword.control.def.global.applescript"}},
        end: "(?<!¬)$",
        name: "meta.statement.global.applescript",
        patterns: 
         [{match: /,/,
           name: "punctuation.separator.variables.global.applescript"},
          {match: /\b\w+/,
           name: "variable.other.readwrite.global.applescript"},
          {include: "#inline"}]},
       {begin: /\b(?<_1>error)\b/,
        beginCaptures: 
         {1 => {name: "keyword.control.exception.error.applescript"}},
        end: "(?<!¬)$",
        name: "meta.statement.error.applescript",
        patterns: 
         [{match: /\b(?<_1>number|partial|from|to)\b/,
           name: "keyword.control.exception.modifier.applescript"},
          {include: "#inline"}]},
       {begin: /\b(?<_1>if)\b(?=.*\bthen\b(?!\s*(?<_2>--.*?)?$))/,
        beginCaptures: {1 => {name: "keyword.control.if.applescript"}},
        end: "(?<!¬)$",
        name: "meta.statement.if-then.applescript",
        patterns: [{include: "#inline"}]}]},
   :"blocks.tell" => 
    {patterns: 
      [{begin: 
         /^\s*(?<_1>tell)\s+(?=app(?<_2>lication)?\s+"(?i:textmate)")(?!.*\bto(?!\s+tell)\b)/,
        captures: {1 => {name: "keyword.control.tell.applescript"}},
        comment: "tell Textmate",
        end: "^\\s*(end(?:\\s+tell)?)(?=\\s*(--.*?)?$)",
        name: "meta.block.tell.application.textmate.applescript",
        patterns: 
         [{include: "#textmate"},
          {include: "#standard-suite"},
          {include: "$self"}]},
       {begin: 
         /^\s*(?<_1>tell)\s+(?=app(?<_2>lication)?\s+"(?i:finder)")(?!.*\bto(?!\s+tell)\b)/,
        captures: {1 => {name: "keyword.control.tell.applescript"}},
        comment: "tell Finder",
        end: "^\\s*(end(?:\\s+tell)?)(?=\\s*(--.*?)?$)",
        name: "meta.block.tell.application.finder.applescript",
        patterns: 
         [{include: "#finder"},
          {include: "#standard-suite"},
          {include: "$self"}]},
       {begin: 
         /^\s*(?<_1>tell)\s+(?=app(?<_2>lication)?\s+"(?i:system events)")(?!.*\bto(?!\s+tell)\b)/,
        captures: {1 => {name: "keyword.control.tell.applescript"}},
        comment: "tell System Events",
        end: "^\\s*(end(?:\\s+tell)?)(?=\\s*(--.*?)?$)",
        name: "meta.block.tell.application.system-events.applescript",
        patterns: 
         [{include: "#system-events"},
          {include: "#standard-suite"},
          {include: "$self"}]},
       {begin: 
         /^\s*(?<_1>tell)\s+(?=app(?<_2>lication)?\s+"(?i:itunes)")(?!.*\bto(?!\s+tell)\b)/,
        captures: {1 => {name: "keyword.control.tell.applescript"}},
        comment: "tell iTunes",
        end: "^\\s*(end(?:\\s+tell)?)(?=\\s*(--.*?)?$)",
        name: "meta.block.tell.application.itunes.applescript",
        patterns: 
         [{include: "#itunes"},
          {include: "#standard-suite"},
          {include: "$self"}]},
       {begin: 
         /^\s*(?<_1>tell)\s+(?=app(?<_2>lication)?\s+process\b)(?!.*\bto(?!\s+tell)\b)/,
        captures: {1 => {name: "keyword.control.tell.applescript"}},
        comment: "tell generic application process",
        end: "^\\s*(end(?:\\s+tell)?)(?=\\s*(--.*?)?$)",
        name: "meta.block.tell.application-process.generic.applescript",
        patterns: [{include: "#standard-suite"}, {include: "$self"}]},
       {begin: 
         /^\s*(?<_1>tell)\s+(?=app(?<_2>lication)?\b)(?!.*\bto(?!\s+tell)\b)/,
        captures: {1 => {name: "keyword.control.tell.applescript"}},
        comment: "tell generic application",
        end: "^\\s*(end(?:\\s+tell)?)(?=\\s*(--.*?)?$)",
        name: "meta.block.tell.application.generic.applescript",
        patterns: [{include: "#standard-suite"}, {include: "$self"}]},
       {begin: /^\s*(?<_1>tell)\s+(?!.*\bto(?!\s+tell)\b)/,
        captures: {1 => {name: "keyword.control.tell.applescript"}},
        comment: "generic tell block",
        end: "^\\s*(end(?:\\s+tell)?)(?=\\s*(--.*?)?$)",
        name: "meta.block.tell.generic.applescript",
        patterns: [{include: "$self"}]},
       {begin: /^\s*(?<_1>tell)\s+(?=.*\bto\b)/,
        captures: {1 => {name: "keyword.control.tell.applescript"}},
        comment: "tell … to statement",
        end: "(?<!¬)$",
        name: "meta.block.tell.generic.applescript",
        patterns: [{include: "$self"}]}]},
   :"built-in" => 
    {patterns: 
      [{include: "#built-in.constant"},
       {include: "#built-in.keyword"},
       {include: "#built-in.support"},
       {include: "#built-in.punctuation"}]},
   :"built-in.constant" => 
    {patterns: 
      [{comment: 
         "yes/no can’t always be used as booleans, e.g. in an if() expression. But they work e.g. for boolean arguments.",
        match: /\b(?i:true|false|yes|no)\b/,
        name: "constant.language.boolean.applescript"},
       {match: /\b(?i:null|missing\s+value)\b/,
        name: "constant.language.null.applescript"},
       {match: /-?\b\d+(?<_1>(?<_2>\.(?<_3>\d+\b)?)?(?i:e\+?\d*\b)?|\b)/,
        name: "constant.numeric.applescript"},
       {match: /\b(?i:space|tab|return|linefeed|quote)\b/,
        name: "constant.other.text.applescript"},
       {match: 
         /\b(?i:all\s+(?<_1>caps|lowercase)|bold|condensed|expanded|hidden|italic|outline|plain|shadow|small\s+caps|strikethrough|(?<_2>sub|super)script|underline)\b/,
        name: "constant.other.styles.applescript"},
       {match: 
         /\b(?i:Jan(?<_1>uary)?|Feb(?<_2>ruary)?|Mar(?<_3>ch)?|Apr(?<_4>il)?|May|Jun(?<_5>e)?|Jul(?<_6>y)?|Aug(?<_7>ust)?|Sep(?<_8>tember)?|Oct(?<_9>ober)?|Nov(?<_10>ember)?|Dec(?<_11>ember)?)\b/,
        name: "constant.other.time.month.applescript"},
       {match: 
         /\b(?i:Mon(?<_1>day)?|Tue(?<_2>sday)?|Wed(?<_3>nesday)?|Thu(?<_4>rsday)?|Fri(?<_5>day)?|Sat(?<_6>urday)?|Sun(?<_7>day)?)\b/,
        name: "constant.other.time.weekday.applescript"},
       {match: 
         /\b(?i:AppleScript|pi|result|version|current\s+application|its?|m[ey])\b/,
        name: "constant.other.miscellaneous.applescript"},
       {match: /\b(?i:text\s+item\s+delimiters|print\s+(?<_1>length|depth))\b/,
        name: "variable.language.applescript"}]},
   :"built-in.keyword" => 
    {patterns: 
      [{match: /(?<_1>&|\*|\+|-|\/|÷|\^)/,
        name: "keyword.operator.arithmetic.applescript"},
       {match: /(?<_1>=|≠|>|<|≥|>=|≤|<=)/,
        name: "keyword.operator.comparison.applescript"},
       {match: 
         /(?ix)\b
	(?<_1>and|or|div|mod|as|not
	|(?<_2>a\s+)?(?<_3>ref(?<_4>\s+to)?|reference\s+to)
	|equal(?<_5>s|\s+to)|contains?|comes\s+(?<_6>after|before)|(?<_7>start|begin|end)s?\s+with
	)
	\b/,
        name: "keyword.operator.word.applescript"},
       {comment: 
         "In double quotes so we can use a single quote in the keywords.",
        match: 
         /(?ix)\b
	(?<_1>is(?<_2>n't|\s+not)?(?<_3>\s+(?<_4>equal(?<_5>\s+to)?|(?<_6>less|greater)\s+than(?<_7>\s+or\s+equal(?<_8>\s+to)?)?|in|contained\s+by))?
	|does(?<_9>n't|\s+not)\s+(?<_10>equal|come\s+(?<_11>before|after)|contain)
	)
	\b/,
        name: "keyword.operator.word.applescript"},
       {match: 
         /\b(?i:some|every|whose|where|that|id|index|\d+(?<_1>st|nd|rd|th)|first|second|third|fourth|fifth|sixth|seventh|eighth|ninth|tenth|last|front|back|middle|named|beginning|end|from|to|thr(?<_2>u|ough)|before|(?<_3>front|back|beginning|end)\s+of|after|behind|in\s+(?<_4>front|back|beginning|end)\s+of)\b/,
        name: "keyword.operator.reference.applescript"},
       {match: /\b(?i:continue|return|exit(?<_1>\s+repeat)?)\b/,
        name: "keyword.control.loop.applescript"},
       {match: 
         /\b(?i:about|above|after|against|and|apart\s+from|around|as|aside\s+from|at|back|before|beginning|behind|below|beneath|beside|between|but|by|considering|contain|contains|contains|copy|div|does|eighth|else|end|equal|equals|error|every|false|fifth|first|for|fourth|from|front|get|given|global|if|ignoring|in|instead\s+of|into|is|it|its|last|local|me|middle|mod|my|ninth|not|of|on|onto|or|out\s+of|over|prop|property|put|ref|reference|repeat|returning|script|second|set|seventh|since|sixth|some|tell|tenth|that|the|then|third|through|thru|timeout|times|to|transaction|true|try|until|where|while|whose|with|without)\b/,
        name: "keyword.other.applescript"}]},
   :"built-in.punctuation" => 
    {patterns: 
      [{match: /¬/,
        name: "punctuation.separator.continuation.line.applescript"},
       {comment: "the : in property assignments",
        match: /:/,
        name: "punctuation.separator.key-value.property.applescript"},
       {comment: "the parentheses in groups",
        match: /[(?<_1>)]/,
        name: "punctuation.section.group.applescript"}]},
   :"built-in.support" => 
    {patterns: 
      [{match: 
         /\b(?i:POSIX\s+path|frontmost|id|name|running|version|days?|weekdays?|months?|years?|time|date\s+string|time\s+string|length|rest|reverse|items?|contents|quoted\s+form|characters?|paragraphs?|words?)\b/,
        name: "support.function.built-in.property.applescript"},
       {match: 
         /\b(?i:activate|log|clipboard\s+info|set\s+the\s+clipboard\s+to|the\s+clipboard|info\s+for|list\s+(?<_1>disks|folder)|mount\s+volume|path\s+to(?<_2>\s+resource)?|close\s+access|get\s+eof|open\s+for\s+access|read|set\s+eof|write|open\s+location|current\s+date|do\s+shell\s+script|get\s+volume\s+settings|random\s+number|round|set\s+volume|system\s+(?<_3>attribute|info)|time\s+to\s+GMT|load\s+script|run\s+script|scripting\s+components|store\s+script|copy|count|get|launch|run|set|ASCII\s+(?<_4>character|number)|localized\s+string|offset|summarize|beep|choose\s+(?<_5>application|color|file(?<_6>\s+name)?|folder|from\s+list|remote\s+application|URL)|delay|display\s+(?<_7>alert|dialog)|say)\b/,
        name: "support.function.built-in.command.applescript"},
       {match: /\b(?i:get|run)\b/,
        name: "support.function.built-in.applescript"},
       {match: /\b(?i:anything|data|text|upper\s+case|propert(?<_1>y|ies))\b/,
        name: "support.class.built-in.applescript"},
       {match: /\b(?i:alias|class)(?<_1>es)?\b/,
        name: "support.class.built-in.applescript"},
       {match: 
         /\b(?i:app(?<_1>lication)?|boolean|character|constant|date|event|file(?<_2>\s+specification)?|handler|integer|item|keystroke|linked\s+list|list|machine|number|picture|preposition|POSIX\s+file|real|record|reference(?<_3>\s+form)?|RGB\s+color|script|sound|text\s+item|type\s+class|vector|writing\s+code(?<_4>\s+info)?|zone|(?<_5>(?<_6>international|styled(?<_7>\s+(?<_8>Clipboard|Unicode))?|Unicode)\s+)?text|(?<_9>(?<_10>C|encoded|Pascal)\s+)?string)s?\b/,
        name: "support.class.built-in.applescript"},
       {match: 
         /(?ix)\b
	(?<_1>	(?<_2>cubic\s+(?<_3>centi)?|square\s+(?<_4>kilo)?|centi|kilo)met(?<_5>er|re)s
	|	square\s+(?<_6>yards|feet|miles)|cubic\s+(?<_7>yards|feet|inches)|miles|inches
	|	lit(?<_8>re|er)s|gallons|quarts
	|	(?<_9>kilo)?grams|ounces|pounds
	|	degrees\s+(?<_10>Celsius|Fahrenheit|Kelvin)
	)
	\b/,
        name: "support.class.built-in.unit.applescript"},
       {match: /\b(?i:seconds|minutes|hours|days)\b/,
        name: "support.class.built-in.time.applescript"}]},
   comments: 
    {patterns: 
      [{captures: {1 => {name: "punctuation.definition.comment.applescript"}},
        match: /^\s*(?<_1>#!).*$\n?/,
        name: "comment.line.number-sign.applescript"},
       {captures: {1 => {name: "punctuation.definition.comment.applescript"}},
        match: /(?<_1>--).*$\n?/,
        name: "comment.line.double-dash.applescript"},
       {begin: /\(\*/,
        captures: {0 => {name: "punctuation.definition.comment.applescript"}},
        end: "\\*\\)",
        name: "comment.block.applescript",
        patterns: [{include: "#comments.nested"}]}]},
   :"comments.nested" => 
    {patterns: 
      [{begin: /\(\*/,
        captures: {0 => {name: "punctuation.definition.comment.applescript"}},
        end: "\\*\\)",
        name: "comment.block.applescript",
        patterns: [{include: "#comments.nested"}]}]},
   :"data-structures" => 
    {patterns: 
      [{begin: /(?<_1>\{)/,
        captures: {1 => {name: "punctuation.section.array.applescript"}},
        comment: 
         "We cannot necessarily distinguish \"records\" from \"arrays\", and so this could be either.",
        end: "(\\})",
        name: "meta.array.applescript",
        patterns: 
         [{captures: 
            {1 => {name: "constant.other.key.applescript"},
             2 => {name: "meta.identifier.applescript"},
             3 => {name: "punctuation.definition.identifier.applescript"},
             4 => {name: "punctuation.definition.identifier.applescript"},
             5 => {name: "punctuation.separator.key-value.applescript"}},
           match: /(?<_1>\w+|(?<_2>(?<_3>\|)[^|\n]*(?<_4>\|)))\s*(?<_5>:)/},
          {match: /:/, name: "punctuation.separator.key-value.applescript"},
          {match: /,/, name: "punctuation.separator.array.applescript"},
          {include: "#inline"}]},
       {begin: /(?:(?<=application )|(?<=app ))(?<_1>")/,
        captures: {1 => {name: "punctuation.definition.string.applescript"}},
        end: "(\")",
        name: "string.quoted.double.application-name.applescript",
        patterns: 
         [{match: /\\./, name: "constant.character.escape.applescript"}]},
       {begin: /(?<_1>")/,
        captures: {1 => {name: "punctuation.definition.string.applescript"}},
        end: "(\")",
        name: "string.quoted.double.applescript",
        patterns: 
         [{match: /\\./, name: "constant.character.escape.applescript"}]},
       {captures: 
         {1 => {name: "punctuation.definition.identifier.applescript"},
          2 => {name: "punctuation.definition.identifier.applescript"}},
        match: /(?<_1>\|)[^|\n]*(?<_2>\|)/,
        name: "meta.identifier.applescript"},
       {captures: 
         {1 => {name: "punctuation.definition.data.applescript"},
          2 => {name: "support.class.built-in.applescript"},
          3 => {name: "storage.type.utxt.applescript"},
          4 => {name: "string.unquoted.data.applescript"},
          5 => {name: "punctuation.definition.data.applescript"},
          6 => {name: "keyword.operator.applescript"},
          7 => {name: "support.class.built-in.applescript"}},
        match: 
         /(?<_1>«)(?<_2>data) (?<_3>utxt|utf8)(?<_4>[[:xdigit:]]*)(?<_5>»)(?:\s+(?<_6>as)\s+(?i:Unicode\s+text))?/,
        name: "constant.other.data.utxt.applescript"},
       {begin: /(?<_1>«)(?<_2>\w+)\b(?=\s)/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.data.applescript"},
          2 => {name: "support.class.built-in.applescript"}},
        end: "(»)",
        endCaptures: {1 => {name: "punctuation.definition.data.applescript"}},
        name: "constant.other.data.raw.applescript"},
       {captures: 
         {1 => {name: "punctuation.definition.data.applescript"},
          2 => {name: "punctuation.definition.data.applescript"}},
        match: /(?<_1>«)[^»]*(?<_2>»)/,
        name: "invalid.illegal.data.applescript"}]},
   finder: 
    {patterns: 
      [{match: 
         /\b(?<_1>item|container|(?<_2>computer|disk|trash)-object|disk|folder|(?<_3>(?<_4>alias|application|document|internet location) )?file|clipping|package)s?\b/,
        name: "support.class.finder.items.applescript"},
       {match: 
         /\b(?<_1>(?<_2>Finder|desktop|information|preferences|clipping) )windows?\b/,
        name: "support.class.finder.window-classes.applescript"},
       {match: 
         /\b(?<_1>preferences|(?<_2>icon|column|list) view options|(?<_3>label|column|alias list)s?)\b/,
        name: "support.class.finder.type-definitions.applescript"},
       {match: 
         /\b(?<_1>copy|find|sort|clean up|eject|empty(?<_2> trash)|erase|reveal|update)\b/,
        name: "support.function.finder.items.applescript"},
       {match: 
         /\b(?<_1>insertion location|product version|startup disk|desktop|trash|home|computer container|finder preferences)\b/,
        name: "support.constant.finder.applescript"},
       {match: /\b(?<_1>visible)\b/,
        name: "support.variable.finder.applescript"}]},
   inline: 
    {patterns: 
      [{include: "#comments"},
       {include: "#data-structures"},
       {include: "#built-in"},
       {include: "#standardadditions"}]},
   itunes: 
    {patterns: 
      [{match: 
         /\b(?<_1>artwork|application|encoder|EQ preset|item|source|visual|(?<_2>EQ |browser )?window|(?<_3>(?<_4>audio CD|device|shared|URL|file) )?track|playlist window|(?<_5>(?<_6>audio CD|device|radio tuner|library|folder|user) )?playlist)s?\b/,
        name: "support.class.itunes.applescript"},
       {match: 
         /\b(?<_1>add|back track|convert|fast forward|(?<_2>next|previous) track|pause|play(?<_3>pause)?|refresh|resume|rewind|search|stop|update|eject|subscribe|update(?<_4>Podcast|AllPodcasts)|download)\b/,
        name: "support.function.itunes.applescript"},
       {match: 
         /\b(?<_1>current (?<_2>playlist|stream (?<_3>title|URL)|track)|player state)\b/,
        name: "support.constant.itunes.applescript"},
       {match: 
         /\b(?<_1>current (?<_2>encoder|EQ preset|visual)|EQ enabled|fixed indexing|full screen|mute|player position|sound volume|visuals enabled|visual size)\b/,
        name: "support.variable.itunes.applescript"}]},
   :"standard-suite" => 
    {patterns: 
      [{match: /\b(?<_1>colors?|documents?|items?|windows?)\b/,
        name: "support.class.standard-suite.applescript"},
       {match: 
         /\b(?<_1>close|count|delete|duplicate|exists|make|move|open|print|quit|save|activate|select|data size)\b/,
        name: "support.function.standard-suite.applescript"},
       {match: /\b(?<_1>name|frontmost|version)\b/,
        name: "support.constant.standard-suite.applescript"},
       {match: /\b(?<_1>selection)\b/,
        name: "support.variable.standard-suite.applescript"},
       {match: 
         /\b(?<_1>attachments?|attribute runs?|characters?|paragraphs?|texts?|words?)\b/,
        name: "support.class.text-suite.applescript"}]},
   standardadditions: 
    {patterns: 
      [{match: /\b(?<_1>(?<_2>alert|dialog) reply)\b/,
        name: "support.class.standardadditions.user-interaction.applescript"},
       {match: /\b(?<_1>file information)\b/,
        name: "support.class.standardadditions.file.applescript"},
       {match: /\b(?<_1>POSIX files?|system information|volume settings)\b/,
        name: "support.class.standardadditions.miscellaneous.applescript"},
       {match: 
         /\b(?<_1>URLs?|internet address(?<_2>es)?|web pages?|FTP items?)\b/,
        name: "support.class.standardadditions.internet.applescript"},
       {match: 
         /\b(?<_1>info for|list (?<_2>disks|folder)|mount volume|path to(?<_3> resource)?)\b/,
        name: "support.function.standardadditions.file.applescript"},
       {match: 
         /\b(?<_1>beep|choose (?<_2>application|color|file(?<_3> name)?|folder|from list|remote application|URL)|delay|display (?<_4>alert|dialog)|say)\b/,
        name: 
         "support.function.standardadditions.user-interaction.applescript"},
       {match: 
         /\b(?<_1>ASCII (?<_2>character|number)|localized string|offset|summarize)\b/,
        name: "support.function.standardadditions.string.applescript"},
       {match: /\b(?<_1>set the clipboard to|the clipboard|clipboard info)\b/,
        name: "support.function.standardadditions.clipboard.applescript"},
       {match: 
         /\b(?<_1>open for access|close access|read|write|get eof|set eof)\b/,
        name: "support.function.standardadditions.file-i-o.applescript"},
       {match: /\b(?<_1>(?<_2>load|store|run) script|scripting components)\b/,
        name: "support.function.standardadditions.scripting.applescript"},
       {match: 
         /\b(?<_1>current date|do shell script|get volume settings|random number|round|set volume|system attribute|system info|time to GMT)\b/,
        name: "support.function.standardadditions.miscellaneous.applescript"},
       {match: 
         /\b(?<_1>opening folder|(?<_2>closing|moving) folder window for|adding folder items to|removing folder items from)\b/,
        name: "support.function.standardadditions.folder-actions.applescript"},
       {match: /\b(?<_1>open location|handle CGI request)\b/,
        name: "support.function.standardadditions.internet.applescript"}]},
   :"system-events" => 
    {patterns: 
      [{match: /\b(?<_1>audio (?<_2>data|file))\b/,
        name: "support.class.system-events.audio-file.applescript"},
       {match: 
         /\b(?<_1>alias(?<_2>es)?|(?<_3>Classic|local|network|system|user) domain objects?|disk(?<_4> item)?s?|domains?|file(?<_5> package)?s?|folders?|items?)\b/,
        name: "support.class.system-events.disk-folder-file.applescript"},
       {match: /\b(?<_1>delete|open|move)\b/,
        name: "support.function.system-events.disk-folder-file.applescript"},
       {match: /\b(?<_1>folder actions?|scripts?)\b/,
        name: "support.class.system-events.folder-actions.applescript"},
       {match: 
         /\b(?<_1>attach action to|attached scripts|edit action of|remove action from)\b/,
        name: "support.function.system-events.folder-actions.applescript"},
       {match: /\b(?<_1>movie data|movie file)\b/,
        name: "support.class.system-events.movie-file.applescript"},
       {match: /\b(?<_1>log out|restart|shut down|sleep)\b/,
        name: "support.function.system-events.power.applescript"},
       {match: 
         /\b(?<_1>(?<_2>(?<_3>application |desk accessory )?process|(?<_4>check|combo )?box)(?<_5>es)?|(?<_6>action|attribute|browser|(?<_7>busy|progress|relevance) indicator|color well|column|drawer|group|grow area|image|incrementor|list|menu(?<_8> bar)?(?<_9> item)?|(?<_10>menu |pop up |radio )?button|outline|(?<_11>radio|tab|splitter) group|row|scroll (?<_12>area|bar)|sheet|slider|splitter|static text|table|text (?<_13>area|field)|tool bar|UI element|window)s?)\b/,
        name: "support.class.system-events.processes.applescript"},
       {match: /\b(?<_1>click|key code|keystroke|perform|select)\b/,
        name: "support.function.system-events.processes.applescript"},
       {match: /\b(?<_1>property list (?<_2>file|item))\b/,
        name: "support.class.system-events.property-list.applescript"},
       {match: /\b(?<_1>annotation|QuickTime (?<_2>data|file)|track)s?\b/,
        name: "support.class.system-events.quicktime-file.applescript"},
       {match: /\b(?<_1>(?<_2>abort|begin|end) transaction)\b/,
        name: "support.function.system-events.system-events.applescript"},
       {match: /\b(?<_1>XML (?<_2>attribute|data|element|file)s?)\b/,
        name: "support.class.system-events.xml.applescript"},
       {match: /\b(?<_1>print settings|users?|login items?)\b/,
        name: "support.class.sytem-events.other.applescript"}]},
   textmate: 
    {patterns: 
      [{match: /\b(?<_1>print settings)\b/,
        name: "support.class.textmate.applescript"},
       {match: /\b(?<_1>get url|insert|reload bundles)\b/,
        name: "support.function.textmate.applescript"}]}},
 scopeName: "source.applescript",
 uuid: "777CF925-14B9-428E-B07B-17FAAB8FA27E"}
