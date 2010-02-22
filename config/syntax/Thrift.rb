# Encoding: UTF-8

{fileTypes: ["thrift"],
 foldingStartMarker: /\{\s*$/,
 foldingStopMarker: /^\s*\}/,
 keyEquivalent: "^~T",
 name: "Thrift",
 patterns: 
  [{include: "#comments"},
   {captures: 
     {1 => {name: "keyword.other.include.thrift"},
      2 => {name: "string.quoted.thrift"},
      3 => {name: "punctuation.definition.string.begin.thrift"},
      4 => {name: "punctuation.definition.string.end.thrift"}},
    match: 
     /(?<!\S)(?<_1>include)(?!\S)(?:\s+(?<_2>(?<_3>['"])(?>.*?(?<_4>\k<_3>))))?/,
    name: "meta.include.thrift"},
   {captures: 
     {1 => {name: "keyword.other.cpp-include.thrift"},
      2 => {name: "string.quoted.thrift"},
      3 => {name: "punctuation.definition.string.begin.thrift"},
      4 => {name: "punctuation.definition.string.end.thrift"}},
    match: 
     /(?<!\S)(?<_1>cpp_include)(?!\S)(?:\s+(?<_2>(?<_3>['"])(?>.*?(?<_4>\k<_3>))))?/,
    name: "meta.cpp-include.thrift"},
   {captures: 
     {1 => {name: "keyword.other.namespace.thrift"},
      2 => {name: "support.other.namespace-language.thrift"},
      3 => {name: "variable.other.namespace.thrift"}},
    match: 
     /(?<!\S)(?<_1>namespace)(?!\S)(?:\s+(?<_2>[a-zA-Z_][\w.]*)(?:\s+(?<_3>[a-zA-Z_][\w.]*))?)?/,
    name: "meta.namespace.thrift"},
   {captures: 
     {1 => {name: "keyword.other.namespace.thrift"},
      2 => {name: "variable.other.namespace.thrift"}},
    match: 
     /(?<!\S)(?<_1>(?:php|xsd)_namespace)(?!\S)(?:\s+(?<_2>[a-zA-Z_][\w.]*))?/,
    name: "meta.namespace.thrift"},
   {captures: 
     {1 => {name: "invalid.deprecated.namespace.thrift"},
      2 => {name: "variable.other.namespace.thrift"}},
    match: 
     /(?<!\S)(?<_1>(?:cpp|ruby|csharp)_namespace|py_module|(?:java|perl)_package|smalltalk_(?:category|prefix)|cocoa_prefix)(?!\S)(?:\s+(?<_2>[a-zA-Z_][\w.]*))?/},
   {begin: /(?=(?<_1>struct|s?enum|service|const|typedef|exception)\b)/,
    comment: "begin the definition list",
    end: "(?x)$.^ # this regex should never end",
    patterns: 
     [{include: "#comments"},
      {begin: 
        /(?<!\S)(?<_1>const)(?!\S)(?:\s+(?<ft>map\s*<\s*\g<ft>\s*,\s*\g<ft>\s*>|set\s*<\s*\g<ft>\s*>|list\s*<\s*\g<ft>\s*>\s*cpp_type|[a-zA-Z_][\w.]*)(?:\s+(?<_2>[a-zA-Z_][\w.]*)(?:\s*=)?)?)?/,
       beginCaptures: 
        {1 => {name: "keyword.other.const.thrift"},
         2 => {name: "storage.type.const.thrift"},
         3 => {name: "variable.other.const.thrift"}},
       end: "$|^",
       name: "meta.const.thrift",
       patterns: [{include: "#comments"}, {include: "#value"}]},
      {begin: 
        /(?<!\S)(?<_1>typedef)(?!\S)(?:\s+(?<ft>map\s*<\s*\g<ft>\s*,\s*\g<ft>\s*>|set\s*<\s*\g<ft>\s*>|list\s*<\s*\g<ft>\s*>\s*cpp_type|[a-zA-Z_][\w.]*)(?:\s+(?<_2>[a-zA-Z_][\w.]*))?)?/,
       beginCaptures: 
        {1 => {name: "keyword.other.typedef.thrift"},
         2 => {name: "storage.type.typedef.thrift"},
         3 => {name: "variable.other.typedef.thrift"}},
       end: "$|^",
       name: "meta.typedef.thrift",
       patterns: [{include: "#comments"}]},
      {begin: 
        /(?<!\S)(?<_1>enum)(?!\S)(?:\s+(?<_2>[a-zA-Z_][\w.]*)\s*(?![^\s{]))?/,
       beginCaptures: 
        {1 => {name: "keyword.other.enum.thrift"},
         2 => {name: "entity.name.type.enum.thrift"}},
       end: "(?<=\\})|$",
       name: "meta.enum.thrift",
       patterns: 
        [{begin: /\{/,
          beginCaptures: 
           {0 => {name: "punctuation.section.enum.begin.thrift"}},
          end: "\\}",
          endCaptures: {0 => {name: "punctuation.section.enum.end.thrift"}},
          patterns: 
           [{captures: 
              {1 => {name: "variable.other.enum.thrift"},
               2 => {name: "constant.numeric.integer.thrift"}},
             match: 
              /(?<!\S)(?<_1>[a-zA-Z_][\w.]*)(?:\s*=\s*(?<_2>\d*)(?:\s*[,;])?)?/},
            {include: "#comments"},
            {match: /\S/, name: "invalid.illegal.thrift"}]}]},
      {begin: 
        /(?<!\S)(?<_1>senum)(?!\S)(?:\s+(?<_2>[a-zA-Z_][\w.]*)\s*(?![^\s{]))?/,
       beginCaptures: 
        {1 => {name: "keyword.other.senum.thrift"},
         2 => {name: "entity.name.type.senum.thrift"}},
       end: "(?<=\\})|$",
       name: "meta.senum.thrift",
       patterns: 
        [{begin: /\{/,
          beginCaptures: 
           {0 => {name: "punctuation.section.senum.begin.thrift"}},
          end: "\\}",
          endCaptures: {0 => {name: "punctuation.section.senum.end.thrift"}},
          patterns: 
           [{captures: {1 => {name: "variable.other.senum.thrift"}},
             match: /(?<!\S)(?<_1>[a-zA-Z_][\w.]*)(?:\s*[,;])?/},
            {include: "#comments"},
            {match: /\S/, name: "invalid.illegal.thrift"}]}]},
      {begin: 
        /(?<!\S)(?<_1>struct)(?!\S)(?:\s+(?<_2>[a-zA-Z_][\w.]*)\s*(?![^\s{]))?/,
       beginCaptures: 
        {1 => {name: "keyword.other.struct.thrift"},
         2 => {name: "entity.name.type.struct.thrift"}},
       end: "(?<=\\})|$",
       name: "meta.struct.thrift",
       patterns: 
        [{match: /(?<!\S)xsd_all(?!\S)/, name: "keyword.other.xsd-all.thrift"},
         {begin: /\{/,
          beginCaptures: 
           {0 => {name: "punctuation.section.struct.begin.thrift"}},
          end: "\\}",
          endCaptures: {0 => {name: "punctuation.section.struct.end.thrift"}},
          patterns: [{include: "#comments"}, {include: "#field"}]}]},
      {begin: 
        /(?<!\S)(?<_1>exception)(?!\S)(?:\s+(?<_2>[a-zA-Z_][\w.]*)\s*(?![^\s{]))?/,
       beginCaptures: 
        {1 => {name: "keyword.other.exception.thrift"},
         2 => {name: "entity.name.type.exception.thrift"}},
       end: "(?<=\\})|$",
       name: "meta.exception.thrift",
       patterns: 
        [{begin: /\{/,
          beginCaptures: 
           {0 => {name: "punctuation.section.exception.begin.thrift"}},
          end: "\\}",
          endCaptures: 
           {0 => {name: "punctuation.section.exception.end.thrift"}},
          patterns: [{include: "#comments"}, {include: "#field"}]}]},
      {begin: 
        /(?<!\S)(?<_1>service)(?!\S)(?:\s+(?<_2>[a-zA-z_][\w.]*)(?:\s+(?<_3>extends)(?:\s+(?<_4>[a-zA-Z_][\w.]*))?)?\s*(?![^\s{]))?/,
       beginCaptures: 
        {1 => {name: "keyword.other.service.thrift"},
         2 => {name: "entity.name.type.service.thrift"},
         3 => {name: "keyword.other.service.extends.thrift"},
         4 => {name: "entity.other.inherited-class.thrift"}},
       end: "(?<=\\})|$",
       name: "meta.service.thrift",
       patterns: 
        [{begin: /\{/,
          beginCaptures: 
           {0 => {name: "punctuation.section.service.begin.thrift"}},
          end: "\\}",
          endCaptures: {0 => {name: "punctuation.section.service.end.thrift"}},
          patterns: 
           [{include: "#comments"},
            {begin: 
              /(?x)(?<!\S)
	(?<_1>async(?!\S))?\s*
	(?<ft>
	map\s*<\s*\g<ft>\s*,\s*\g<ft>\s*> |
	set\s*<\s*\g<ft>\s*> |
	list\s*<\s*\g<ft>\s*>\s*(?<_2>cpp_type(?!\S))? |
	(?!async\b)[a-zA-Z_][\w.]*
	)\s*
	(?:
	(?<!\S)(?<_3>[a-zA-Z_][\w.]*)\s*(?![^\s(?<_4>])
	)?/,
             beginCaptures: 
              {1 => {name: "keyword.other.async.thrift"},
               2 => {name: "storage.type.function.thrift"},
               3 => {name: "keyword.other.cpp_type.thrift"},
               4 => {name: "entity.name.function.thrift"}},
             end: "$|^",
             name: "meta.service.function.thrift",
             patterns: 
              [{begin: /\(/,
                beginCaptures: 
                 {0 => 
                   {name: "punctuation.definition.arguments.begin.thrift"}},
                end: "\\)",
                endCaptures: 
                 {0 => {name: "punctuation.definition.arguments.end.thrift"}},
                patterns: [{include: "#comments"}, {include: "#field"}]},
               {begin: /(?<![^\s)])(?<_1>throws)(?![^\s(?<_2>])/,
                beginCaptures: 
                 {1 => {name: "keyword.other.service.function.throws.thrift"}},
                end: "$",
                patterns: 
                 [{begin: /\(/,
                   beginCaptures: 
                    {0 => 
                      {name: "punctuation.definition.arguments.begin.thrift"}},
                   end: "\\)",
                   endCaptures: 
                    {0 => 
                      {name: "punctuation.definition.arguments.end.thrift"}},
                   patterns: [{include: "#comments"}, {include: "#field"}]}]},
               {include: "#comments"}]}]}]}]}],
 repository: 
  {comments: 
    {patterns: 
      [{captures: {1 => {name: "punctuation.definition.comment.thrift"}},
        match: /(?<_1>#).*\n?/,
        name: "comment.line.number-sign.thrift"},
       {captures: {1 => {name: "punctuation.definition.comment.thrift"}},
        match: /(?<_1>\/\/).*\n?/,
        name: "comment.line.double-slash.thrift"},
       {begin: /\/\*\*/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.comment.begin.thrift"}},
        end: "\\*/",
        endCaptures: 
         {0 => {name: "punctuation.definition.comment.end.thrift"}},
        name: "comment.block.documentation.thrift"},
       {begin: /\/\*/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.comment.begin.thrift"}},
        end: "\\*/",
        endCaptures: 
         {0 => {name: "punctuation.definition.comment.end.thrift"}},
        name: "comment.block.thrift"}]},
   field: 
    {begin: 
      /(?x)
	(?<![^\s{(?<_1>])(?=\S)
	(?<_2>\d+\s*:)?[ \t]*
	(?:	(?<_3>required|optional)(?!\S)[ \t]*
	|	(?=\S)(?!=required|optional|\d)
	)/,
     beginCaptures: 
      {1 => {name: "entity.other.field-id.thrift"},
       2 => {name: "keyword.other.requiredness.thrift"}},
     end: "[,;]|(?=[)#])|$",
     endCaptures: {0 => {name: "punctuation.separator.fields.thrift"}},
     name: "meta.field.thrift",
     patterns: 
      [{begin: 
         /(?x)
	(?<ft>
	map\s*<\s*\g<ft>\s*,\s*\g<ft>\s*> |
	set\s*<\s*\g<ft>\s*> |
	list\s*<\s*\g<ft>\s*>\s*(?<_1>cpp_type(?!\S))? |
	[a-zA-Z_][\w.]*
	)[ \t]*
	(?:(?<_2>[a-zA-Z_][\w.]*)[ \t]*)? # identifier
	/,
        beginCaptures: 
         {1 => {name: "storage.type.field.thrift"},
          2 => {name: "keyword.other.cpp-type.thrift"},
          3 => {name: "variable.other.field-name.thrift"}},
        end: "(?=[,;]|[)#])|$",
        patterns: 
         [{begin: /=/,
           end: "(?=[,;]|[)#])|$",
           patterns: 
            [{match: /(?<!\S)(?<_1>xsd_optional)\b/,
              name: "keyword.other.xsd_optional.thrift"},
             {match: /(?<!\S)(?<_1>xsd_nillable)\b/,
              name: "keyword.other.xsd_nillable.thrift"},
             {include: "#value"}]}]}]},
   value: 
    {patterns: 
      [{match: /[+-]?\d*\.\d+(?<_1>[eE][+-]?\d+)?/,
        name: "constant.numeric.float.thrift"},
       {match: /[+-]?\d+/, name: "constant.numeric.integer.thrift"},
       {match: /[a-zA-Z_][\w.]*/, name: "constant.other.const-data.thrift"},
       {begin: /'/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.begin.thrift"}},
        end: "'",
        endCaptures: {0 => {name: "punctuation.definition.string.end.thrift"}},
        name: "string.quoted.single.thrift"},
       {begin: /"/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.string.begin.thrift"}},
        end: "\"",
        endCaptures: 
         {0 => {name: "punctuation.definition.string.begin.thrift"}},
        name: "string.quoted.double.thrift"},
       {begin: /\[/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.array.begin.thrift"}},
        end: "\\]",
        endCaptures: {0 => {name: "punctuation.definition.array.end.thrift"}},
        name: "meta.array.thrift",
        patterns: [{match: /[,;]/}, {include: "#value"}]},
       {begin: /\{/,
        beginCaptures: 
         {0 => {name: "punctuation.definition.map.begin.thrift"}},
        end: "\\}",
        endCaptures: {0 => {name: "punctuation.definition.map.end.thrift"}},
        name: "meta.map.thrift",
        patterns: [{match: /[:,;]/}, {include: "#value"}]},
       {match: /\S/, name: "invalid.illegal.thrift"}]}},
 scopeName: "source.thrift",
 uuid: "9E5704AC-54ED-4D7C-946C-6DC3727BDC4C"}
