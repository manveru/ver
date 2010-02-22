# Encoding: UTF-8

{fileTypes: 
  ["plist",
   "dict",
   "tmCommand",
   "tmDelta",
   "tmDragCommand",
   "tmLanguage",
   "tmMacro",
   "tmPreferences",
   "tmSnippet",
   "tmTheme",
   "scriptSuite",
   "scriptTerminology",
   "savedSearch"],
 foldingStartMarker: 
  /(?x)
	(?<_1>
	(?<_2>^|=|=[ ]|\s\s|\t)				# Openstep foldings
	(?<_3>\{|\()(?!.*(?<_4>\)|\}))			# spaces before them to 
	# limit false positives
	  | (?<_5>
	^\s*
	(?<_6>
	<[^!?%\/](?!.+?(?<_7>\/>
	  | <\/.+?>))
	  | <[!%]--(?!.+?--%?>)
	)
	)
	)
	 /,
 foldingStopMarker: 
  /(?x)
	(?<_1>
	(?<_2>\}|\))(?<_3>,|;)?					# Openstep foldings
	.*$								# limit false positives
	  | (?<_4>^\s*(?<_5><\/[^>]+>|\/>|-->)\s*$)		# XML						
	)
	/,
 keyEquivalent: "^~P",
 name: "Property List",
 patterns: 
  [{begin: /xml|plist/,
    comment: "This gives us the proper scope for the xml or plist snippet.",
    end: "(?=not)possible",
    name: "text.xml.plist"},
   {begin: /^bplist00/,
    comment: "This gives us the proper scope for the convert plist command.",
    end: "(?=not)possible",
    name: "source.plist.binary"},
   {begin: /(?=\s*(?<_1><\?xml|<!DOCTYPE\s*plist))/,
    end: "(?=not)possible",
    name: "text.xml.plist",
    patterns: [{include: "#xml"}]},
   {begin: /(?=\s*(?<_1>{|\(|\/\/|\/\*))/,
    end: "(?=not)possible",
    name: "source.plist",
    patterns: [{include: "#openstep"}]}],
 repository: 
  {openstep: 
    {patterns: 
      [{include: "#openstep_comment"},
       {include: "#openstep_dictionary"},
       {include: "#openstep_array"},
       {include: "#openstep_stray-char"}]},
   openstep_array: 
    {begin: /(?<_1>\()/,
     captures: {1 => {name: "punctuation.section.array.plist"}},
     end: "(\\))",
     name: "meta.group.array.plist",
     patterns: 
      [{include: "#openstep_array-item"},
       {include: "#openstep_comment"},
       {include: "#openstep_stray-char"}]},
   :"openstep_array-item" => 
    {begin: /(?={|\(|"|'|[-a-zA-Z0-9_.]|<)/,
     end: "(,)|(?=\\))",
     endCaptures: {1 => {name: "punctuation.separator.array.plist"}},
     patterns: 
      [{include: "#openstep_string"},
       {include: "#openstep_data"},
       {include: "#openstep_dictionary"},
       {include: "#openstep_array"},
       {begin: /(?<="|'|\}|\))/,
        comment: "Catch stray chars",
        end: "(?=,|\\))",
        patterns: 
         [{include: "#openstep_comment"},
          {include: "#openstep_stray-char"}]}]},
   openstep_comment: 
    {patterns: 
      [{begin: /\/\*/,
        captures: {0 => {name: "punctuation.definition.comment.plist"}},
        end: "\\*/",
        name: "comment.block.plist"},
       {captures: {1 => {name: "punctuation.definition.comment.plist"}},
        match: /(?<_1>\/\/).*$\n?/,
        name: "comment.line.double-slash.plist"}]},
   openstep_data: 
    {begin: /(?<_1><)/,
     beginCaptures: {1 => {name: "punctuation.definition.data.plist"}},
     end: "(=?)\\s*?(>)",
     endCaptures: 
      {1 => {name: "punctuation.terminator.data.plist"},
       2 => {name: "punctuation.definition.data.plist"}},
     name: "meta.binary-data.plist",
     patterns: 
      [{match: /[A-Za-z0-9+\/]/, name: "constant.numeric.base64.plist"},
       {match: /[^ \n]/, name: "invalid.illegal.invalid-character.plist"}]},
   openstep_dictionary: 
    {begin: /(?<_1>\{)/,
     captures: {1 => {name: "punctuation.section.dictionary.plist"}},
     end: "(\\})",
     name: "meta.group.dictionary.plist",
     patterns: 
      [{include: "#openstep_name"},
       {include: "#openstep_comment"},
       {include: "#openstep_stray-char"}]},
   openstep_name: 
    {patterns: 
      [{begin: /(?=(?<_1>[-a-zA-Z0-9_.]+)|(?<_2>"|'))/,
        end: "((?<=\\));)|((?<=\\});)|(;)",
        endCaptures: 
         {1 => {name: "punctuation.terminator.array.plist"},
          2 => {name: "punctuation.terminator.dictionary.plist"},
          3 => {name: "punctuation.terminator.rule.plist"}},
        name: "meta.rule.named.plist",
        patterns: 
         [{match: /[-a-zA-Z0-9_.]+/, name: "constant.other.key.plist"},
          {begin: /(?<=(?<_1>'|"|[-a-zA-Z0-9_.]))(?!=)|\s/,
           comment: 
            "Mark anything between the name and the =\n\t\t\t\t\t\t\t\t\t\tas invalid.",
           end: "(?==)",
           patterns: [{include: "#openstep_stray-char"}]},
          {begin: /(?<_1>"|')/,
           beginCaptures: 
            {0 => {name: "punctuation.definition.string.begin.plist"}},
           end: "(\\1)",
           endCaptures: 
            {0 => {name: "punctuation.definition.string.end.plist"}},
           name: "constant.other.key.plist",
           patterns: [{include: "#openstep_string-contents"}]},
          {begin: /(?<_1>=)(?!;)/,
           beginCaptures: 
            {1 => {name: "punctuation.separator.key-value.plist"}},
           end: "(?=;)",
           patterns: 
            [{include: "#openstep_post-value"},
             {include: "#openstep_string"},
             {include: "#openstep_data"},
             {include: "#openstep_array"},
             {include: "#openstep_dictionary"}]}]}]},
   :"openstep_post-value" => 
    {begin: /(?<='|"|\}|\)|>|[-a-zA-Z0-9_.])(?!;)/,
     end: "(?=;)",
     patterns: [{include: "#openstep_stray-char"}]},
   :"openstep_stray-char" => 
    {match: /[^\s\n]/,
     name: "invalid.illegal.character-not-allowed-here.plist"},
   openstep_string: 
    {patterns: 
      [{begin: /'/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.begin.plist"}},
        end: "'",
        endCaptures: {0 => {name: "punctuation.definition.string.end.plist"}},
        name: "string.quoted.single.plist",
        patterns: [{include: "#openstep_string-contents"}]},
       {begin: /"/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.begin.plist"}},
        end: "\"",
        endCaptures: {0 => {name: "punctuation.definition.string.end.plist"}},
        name: "string.quoted.double.plist",
        patterns: [{include: "#openstep_string-contents"}]},
       {match: /[-+]?\d+(?<_1>\.\d*)?(?<_2>E[-+]\d+)?(?!\w)/,
        name: "constant.numeric.plist"},
       {match: /[-a-zA-Z0-9_.]+/, name: "string.unquoted.plist"}]},
   :"openstep_string-contents" => 
    {match: /\\(?<_1>[uU](?<_2>\h{4}|\h{2})|\d{1,3}|.)/,
     name: "constant.character.escape.plist"},
   xml: 
    {patterns: 
      [{begin: /(?<_1>(?<_2><)(?<_3>(?<_4>plist\b)))/,
        captures: 
         {1 => {name: "meta.tag.plist.xml.plist"},
          2 => {name: "punctuation.definition.tag.xml.plist"},
          3 => {name: "entity.name.tag.xml.plist"},
          4 => {name: "entity.name.tag.localname.xml.plist"},
          5 => {name: "punctuation.definition.tag.xml.plist"}},
        end: "((/)((plist))(>))",
        patterns: 
         [{begin: 
            /(?<=<plist)(?!>)\s*(?:(?<_1>version)(?<_2>=)(?:(?<_3>(?<_4>").*?(?<_5>"))|(?<_6>(?<_7>').*?(?<_8>'))))?/,
           beginCaptures: 
            {1 => {name: "entity.other.attribute-name.version.xml.plist"},
             2 => {name: "punctuation.separator.key-value.xml.plist"},
             3 => {name: "string.quoted.double.xml.plist"},
             4 => {name: "punctuation.definition.string.begin.xml.plist"},
             5 => {name: "punctuation.definition.string.end.xml.plist"},
             6 => {name: "string.quoted.single.xml.plist"},
             7 => {name: "punctuation.definition.string.begin.xml.plist"},
             8 => {name: "punctuation.definition.string.end.xml.plist"}},
           end: "(?=>)",
           name: "meta.tag.plist.xml.plist"},
          {captures: 
            {1 => {name: "meta.tag.plist.xml.plist"},
             2 => {name: "punctuation.definition.tag.xml.plist"},
             3 => {name: "meta.scope.between-tag-pair.xml.plist"}},
           comment: "Tag with no content",
           match: /(?<_1>(?<_2>>(?<_3><)))(?=\/plist)/},
          {begin: /(?<_1>(?<_2>>))(?!<\/plist)/,
           beginCaptures: 
            {1 => {name: "meta.tag.plist.xml.plist"},
             2 => {name: "punctuation.definition.tag.xml.plist"}},
           end: "(<)(?=/plist)",
           endCaptures: 
            {0 => {name: "meta.tag.plist.xml.plist"},
             1 => {name: "punctuation.definition.tag.xml.plist"}},
           patterns: [{include: "#xml_tags"}]}]},
       {include: "#xml_invalid"},
       {include: "#xml_comment"},
       {include: "text.xml"},
       {include: "#xml_stray-char"}]},
   xml_comment: 
    {begin: /<!--/,
     captures: {0 => {name: "punctuation.definition.comment.xml.plist"}},
     end: "(?<!-)-->",
     name: "comment.block.xml.plist",
     patterns: 
      [{match: /-(?=-->)|--/,
        name: "invalid.illegal.double-dash-not-allowed.xml.plist"}]},
   xml_innertag: 
    {patterns: 
      [{match: /&(?<_1>[a-zA-Z0-9_-]+|#[0-9]+|#x[0-9a-fA-F]+);/,
        name: "constant.character.entity.xml.plist"},
       {match: /&/, name: "invalid.illegal.bad-ampersand.xml.plist"}]},
   xml_invalid: 
    {captures: 
      {1 => {name: "meta.tag.boolean.xml.plist"},
       2 => {name: "punctuation.definition.tag.xml.plist"},
       3 => {name: "invalid.illegal.tag-not-recognized.xml.plist"},
       4 => {name: "punctuation.definition.tag.xml.plist"}},
     comment: "Invalid tag",
     match: /(?<_1>(?<_2><)\/?(?<_3>\w+).*?(?<_4>>))/},
   :"xml_stray-char" => 
    {match: /\S/,
     name: "invalid.illegal.character-data-not-allowed-here.xml.plist"},
   xml_tags: 
    {patterns: 
      [{captures: 
         {1 => {name: "meta.tag.dict.xml.plist"},
          10 => {name: "entity.name.tag.localname.xml.plist"},
          11 => {name: "punctuation.definition.tag.xml.plist"},
          2 => {name: "punctuation.definition.tag.xml.plist"},
          3 => {name: "entity.name.tag.xml.plist"},
          4 => {name: "entity.name.tag.localname.xml.plist"},
          5 => {name: "punctuation.definition.tag.xml.plist"},
          6 => {name: "meta.tag.dict.xml.plist"},
          7 => {name: "punctuation.definition.tag.xml.plist"},
          8 => {name: "meta.scope.between-tag-pair.xml.plist"},
          9 => {name: "entity.name.tag.xml.plist"}},
        comment: "Empty tag: Dictionary",
        match: 
         /(?<_1>(?<_2><)(?<_3>(?<_4>dict))(?<_5>>))(?<_6>(?<_7>(?<_8><)\/)(?<_9>(?<_10>dict))(?<_11>>))/},
       {captures: 
         {1 => {name: "meta.tag.array.xml.plist"},
          10 => {name: "entity.name.tag.localname.xml.plist"},
          11 => {name: "punctuation.definition.tag.xml.plist"},
          2 => {name: "punctuation.definition.tag.xml.plist"},
          3 => {name: "entity.name.tag.xml.plist"},
          4 => {name: "entity.name.tag.localname.xml.plist"},
          5 => {name: "punctuation.definition.tag.xml.plist"},
          6 => {name: "meta.tag.array.xml.plist"},
          7 => {name: "punctuation.definition.tag.xml.plist"},
          8 => {name: "meta.scope.between-tag-pair.xml.plist"},
          9 => {name: "entity.name.tag.xml.plist"}},
        comment: "Empty tag: Array",
        match: 
         /(?<_1>(?<_2><)(?<_3>(?<_4>array))(?<_5>>))(?<_6>(?<_7>(?<_8><)\/)(?<_9>(?<_10>array))(?<_11>>))/},
       {captures: 
         {1 => {name: "meta.tag.string.xml.plist"},
          10 => {name: "entity.name.tag.localname.xml.plist"},
          11 => {name: "punctuation.definition.tag.xml.plist"},
          2 => {name: "punctuation.definition.tag.xml.plist"},
          3 => {name: "entity.name.tag.xml.plist"},
          4 => {name: "entity.name.tag.localname.xml.plist"},
          5 => {name: "punctuation.definition.tag.xml.plist"},
          6 => {name: "meta.tag.string.xml.plist"},
          7 => {name: "punctuation.definition.tag.xml.plist"},
          8 => {name: "meta.scope.between-tag-pair.xml.plist"},
          9 => {name: "entity.name.tag.xml.plist"}},
        comment: "Empty tag: String",
        match: 
         /(?<_1>(?<_2><)(?<_3>(?<_4>string))(?<_5>>))(?<_6>(?<_7>(?<_8><)\/)(?<_9>(?<_10>string))(?<_11>>))/},
       {begin: /(?<_1>(?<_2><)(?<_3>(?<_4>key))(?<_5>>))/,
        captures: 
         {1 => {name: "meta.tag.key.xml.plist"},
          2 => {name: "punctuation.definition.tag.xml.plist"},
          3 => {name: "entity.name.tag.xml.plist"},
          4 => {name: "entity.name.tag.localname.xml.plist"},
          5 => {name: "punctuation.definition.tag.xml.plist"}},
        comment: 
         "the extra captures are required to duplicate the effect of the namespace parsing in the XML syntax",
        contentName: "constant.other.name.xml.plist",
        end: "((</)((key))(>))",
        patterns: 
         [{begin: /<!\[CDATA\[/,
           captures: {0 => {name: "punctuation.definition.constant.xml"}},
           end: "]]>"}]},
       {captures: 
         {1 => {name: "meta.tag.dict.xml.plist"},
          2 => {name: "punctuation.definition.tag.xml.plist"},
          3 => {name: "entity.name.tag.xml.plist"},
          4 => {name: "entity.name.tag.localname.xml.plist"},
          5 => {name: "punctuation.definition.tag.xml.plist"}},
        comment: "Self-closing Dictionary",
        match: /(?<_1>(?<_2><)(?<_3>(?<_4>dict))\s*?\/(?<_5>>))/},
       {captures: 
         {1 => {name: "meta.tag.array.xml.plist"},
          2 => {name: "punctuation.definition.tag.xml.plist"},
          3 => {name: "entity.name.tag.xml.plist"},
          4 => {name: "entity.name.tag.localname.xml.plist"},
          5 => {name: "punctuation.definition.tag.xml.plist"}},
        comment: "Self-closing Array",
        match: /(?<_1>(?<_2><)(?<_3>(?<_4>array))\s*?\/(?<_5>>))/},
       {captures: 
         {1 => {name: "meta.tag.string.xml.plist"},
          2 => {name: "punctuation.definition.tag.xml.plist"},
          3 => {name: "entity.name.tag.xml.plist"},
          4 => {name: "entity.name.tag.localname.xml.plist"},
          5 => {name: "punctuation.definition.tag.xml.plist"}},
        comment: "Self-closing String",
        match: /(?<_1>(?<_2><)(?<_3>(?<_4>string))\s*?\/(?<_5>>))/},
       {captures: 
         {1 => {name: "meta.tag.key.xml.plist"},
          2 => {name: "punctuation.definition.tag.xml.plist"},
          3 => {name: "entity.name.tag.xml.plist"},
          4 => {name: "entity.name.tag.localname.xml.plist"},
          5 => {name: "punctuation.definition.tag.xml.plist"}},
        comment: "Self-closing Key",
        match: /(?<_1>(?<_2><)(?<_3>(?<_4>key))\s*?\/(?<_5>>))/},
       {begin: /(?<_1>(?<_2><)(?<_3>(?<_4>dict))(?<_5>>))/,
        captures: 
         {1 => {name: "meta.tag.dict.xml.plist"},
          2 => {name: "punctuation.definition.tag.xml.plist"},
          3 => {name: "entity.name.tag.xml.plist"},
          4 => {name: "entity.name.tag.localname.xml.plist"},
          5 => {name: "punctuation.definition.tag.xml.plist"}},
        comment: "Dictionary",
        end: "((</)((dict))(>))",
        patterns: [{include: "#xml_tags"}]},
       {begin: /(?<_1>(?<_2><)(?<_3>(?<_4>array))(?<_5>>))/,
        captures: 
         {1 => {name: "meta.tag.array.xml.plist"},
          2 => {name: "punctuation.definition.tag.xml.plist"},
          3 => {name: "entity.name.tag.xml.plist"},
          4 => {name: "entity.name.tag.localname.xml.plist"},
          5 => {name: "punctuation.definition.tag.xml.plist"}},
        comment: "Array",
        end: "((</)((array))(>))",
        patterns: [{include: "#xml_tags"}]},
       {begin: /(?<_1>(?<_2><)(?<_3>(?<_4>string))(?<_5>>))/,
        captures: 
         {1 => {name: "meta.tag.string.xml.plist"},
          2 => {name: "punctuation.definition.tag.xml.plist"},
          3 => {name: "entity.name.tag.xml.plist"},
          4 => {name: "entity.name.tag.localname.xml.plist"},
          5 => {name: "punctuation.definition.tag.xml.plist"}},
        comment: "Strings",
        contentName: "string.quoted.other.xml.plist",
        end: "((</)((string))(>))",
        patterns: 
         [{include: "#xml_innertag"},
          {begin: /<!\[CDATA\[/,
           captures: {0 => {name: "punctuation.definition.string.xml"}},
           end: "]]>",
           name: "string.unquoted.cdata.xml"}]},
       {begin: /(?<_1>(?<_2><)(?<_3>(?<_4>real))(?<_5>>))/,
        captures: 
         {1 => {name: "meta.tag.real.xml.plist"},
          2 => {name: "punctuation.definition.tag.xml.plist"},
          3 => {name: "entity.name.tag.xml.plist"},
          4 => {name: "entity.name.tag.localname.xml.plist"},
          5 => {name: "punctuation.definition.tag.xml.plist"}},
        comment: "Numeric",
        end: "((</)((real))(>))",
        patterns: 
         [{begin: /(?<_1><!\[CDATA\[)/,
           captures: 
            {0 => {name: "punctuation.definition.constant.xml"},
             1 => {name: "constant.numeric.real.xml.plist"}},
           end: "(]]>)",
           patterns: 
            [{match: /[-+]?\d+(?<_1>\.\d*)?(?<_2>E[-+]\d+)?/,
              name: "constant.numeric.real.xml.plist"},
             {match: /./, name: "invalid.illegal.not-a-number.xml.plist"}]},
          {match: /[-+]?\d+(?<_1>\.\d*)?(?<_2>E[-+]\d+)?/,
           name: "constant.numeric.real.xml.plist"},
          {match: /./, name: "invalid.illegal.not-a-number.xml.plist"}]},
       {begin: /(?<_1>(?<_2><)(?<_3>(?<_4>integer))(?<_5>>))/,
        captures: 
         {1 => {name: "meta.tag.integer.xml.plist"},
          2 => {name: "punctuation.definition.tag.xml.plist"},
          3 => {name: "entity.name.tag.xml.plist"},
          4 => {name: "entity.name.tag.localname.xml.plist"},
          5 => {name: "punctuation.definition.tag.xml.plist"}},
        comment: "Integer",
        end: "((</)((integer))(>))",
        patterns: 
         [{match: /[-+]?\d+/, name: "constant.numeric.integer.xml.plist"},
          {match: /./, name: "invalid.illegal.not-a-number.xml.plist"}]},
       {captures: 
         {1 => {name: "meta.tag.boolean.xml.plist"},
          2 => {name: "punctuation.definition.tag.xml.plist"},
          3 => {name: "entity.name.tag.xml.plist"},
          4 => {name: "entity.name.tag.localname.xml.plist"},
          5 => {name: "punctuation.definition.tag.xml.plist"}},
        comment: "Boolean",
        match: /(?<_1>(?<_2><)(?<_3>(?<_4>true|false))\s*?(?<_5>\/>))/},
       {begin: /(?<_1>(?<_2><)(?<_3>(?<_4>data))(?<_5>>))/,
        captures: 
         {1 => {name: "meta.tag.data.xml.plist"},
          2 => {name: "punctuation.definition.tag.xml.plist"},
          3 => {name: "entity.name.tag.xml.plist"},
          4 => {name: "entity.name.tag.localname.xml.plist"},
          5 => {name: "punctuation.definition.tag.xml.plist"}},
        comment: "Data",
        end: "((</)((data))(>))",
        patterns: 
         [{match: /[A-Za-z0-9+\/]/, name: "constant.numeric.base64.xml.plist"},
          {match: /=/, name: "constant.numeric.base64.xml.plist"},
          {match: /[^ \n\t]/,
           name: "invalid.illegal.invalid-character.xml.plist"}]},
       {begin: /(?<_1>(?<_2><)(?<_3>(?<_4>date))(?<_5>>))/,
        captures: 
         {1 => {name: "meta.tag.date.xml.plist"},
          2 => {name: "punctuation.definition.tag.xml.plist"},
          3 => {name: "entity.name.tag.xml.plist"},
          4 => {name: "entity.name.tag.localname.xml.plist"},
          5 => {name: "punctuation.definition.tag.xml.plist"}},
        comment: "Date",
        end: "((</)((date))(>))",
        patterns: 
         [{match: 
            /(?x)
	[0-9]{4}						# Year
	-								# Divider
	(?<_1>0[1-9]|1[012])					# Month
	-								# Divider
	(?!00|3[2-9])[0-3][0-9]			# Day
	T								# Separator
	(?!2[5-9])[0-2][0-9]			# Hour
	:								# Divider
	[0-5][0-9]						# Minute
	:								# Divider
	(?!6[1-9])[0-6][0-9]			# Second
	Z								# Zulu
	/,
           name: "constant.other.date.xml.plist"}]},
       {include: "#xml_invalid"},
       {include: "#xml_comment"},
       {include: "#xml_stray-char"}]}},
 scopeName: "",
 uuid: "E62B2729-6B1C-11D9-AE35-000D93589AF6"}
