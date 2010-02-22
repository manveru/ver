# Encoding: UTF-8

{comment: 
  "I don't think anyone uses .hp. .cp tends to be paired with .h. (I could be wrong. :) -- chris",
 fileTypes: ["cc", "cpp", "cp", "cxx", "c++", "C", "h", "hh", "hpp", "h++"],
 firstLineMatch: "-\\*- C\\+\\+ -\\*-",
 foldingStartMarker: 
  /(?x)
	 \/\*\*(?!\*)
	|^(?![^{]*?\/\/|[^{]*?\/\*(?!.*?\*\/.*?\{)).*?\{\s*(?<_1>$|\/\/|\/\*(?!.*?\*\/.*\S))
	/,
 foldingStopMarker: /(?<!\*)\*\*\/|^\s*\}/,
 keyEquivalent: "^~C",
 name: "C++",
 patterns: 
  [{include: "#special_block"},
   {include: "source.c"},
   {match: /\b(?<_1>friend|explicit|virtual)\b/, name: "storage.modifier.c++"},
   {match: /\b(?<_1>private:|protected:|public:)/,
    name: "storage.modifier.c++"},
   {match: /\b(?<_1>catch|operator|try|throw|using)\b/,
    name: "keyword.control.c++"},
   {match: /\bdelete\b(?<_1>\s*\[\])?|\bnew\b(?!\])/,
    name: "keyword.control.c++"},
   {comment: "common C++ instance var naming idiom -- fMemberName",
    match: /\b(?<_1>f|m)[A-Z]\w*\b/,
    name: "variable.other.readwrite.member.c++"},
   {match: /\b(?<_1>this)\b/, name: "variable.language.c++"},
   {match: /\btemplate\b\s*/, name: "storage.type.template.c++"},
   {match: 
     /\b(?<_1>const_cast|dynamic_cast|reinterpret_cast|static_cast)\b\s*/,
    name: "keyword.operator.cast.c++"},
   {match: 
     /\b(?<_1>and|and_eq|bitand|bitor|compl|not|not_eq|or|or_eq|typeid|xor|xor_eq)\b/,
    name: "keyword.operator.c++"},
   {match: /\b(?<_1>class|wchar_t)\b/, name: "storage.type.c++"},
   {match: /\b(?<_1>export|mutable|typename)\b/, name: "storage.modifier.c++"},
   {begin: 
     /(?x)
    				(?:  ^                                 # begin-of-line
    				  |  (?: (?<!else|new|=) )             #  or word + space before name
    				)
    				(?<_1>(?:[A-Za-z_][A-Za-z0-9_]*::)*+~[A-Za-z_][A-Za-z0-9_]*) # actual name
    				 \s*(?<_2>\()                           # start bracket or end-of-line
    			/,
    beginCaptures: 
     {1 => {name: "entity.name.function.c++"},
      2 => {name: "punctuation.definition.parameters.c"}},
    end: "\\)",
    endCaptures: {0 => {name: "punctuation.definition.parameters.c"}},
    name: "meta.function.destructor.c++",
    patterns: [{include: "$base"}]},
   {begin: 
     /(?x)
    				(?:  ^                                 # begin-of-line
    				  |  (?: (?<!else|new|=) )             #  or word + space before name
    				)
    				(?<_1>(?:[A-Za-z_][A-Za-z0-9_]*::)*+~[A-Za-z_][A-Za-z0-9_]*) # actual name
    				 \s*(?<_2>\()                           # terminating semi-colon
    			/,
    beginCaptures: 
     {1 => {name: "entity.name.function.c++"},
      2 => {name: "punctuation.definition.parameters.c"}},
    end: "\\)",
    endCaptures: {0 => {name: "punctuation.definition.parameters.c"}},
    name: "meta.function.destructor.prototype.c++",
    patterns: [{include: "$base"}]}],
 repository: 
  {angle_brackets: 
    {begin: /</,
     end: ">",
     name: "meta.angle-brackets.c++",
     patterns: [{include: "#angle_brackets"}, {include: "$base"}]},
   block: 
    {begin: /\{/,
     end: "\\}",
     name: "meta.block.c++",
     patterns: 
      [{captures: 
         {1 => {name: "support.function.any-method.c"},
          2 => {name: "punctuation.definition.parameters.c"}},
        match: 
         /(?x)
    				(?<_1>
    					(?!while|for|do|if|else|switch|catch|enumerate|return|r?iterate)(?: \b[A-Za-z_][A-Za-z0-9_]*+\b | :: )*+                  # actual name
    				)
    				 \s*(?<_2>\()/,
        name: "meta.function-call.c"},
       {include: "$base"}]},
   constructor: 
    {patterns: 
      [{begin: 
         /(?x)
    				(?:  ^\s*)                             # begin-of-line
    				(?<_1>(?!while|for|do|if|else|switch|catch|enumerate|r?iterate)[A-Za-z_][A-Za-z0-9_:]*) # actual name
    				 \s*(?<_2>\()                            # start bracket or end-of-line
    			/,
        beginCaptures: 
         {1 => {name: "entity.name.function.c++"},
          2 => {name: "punctuation.definition.parameters.c"}},
        end: "\\)",
        endCaptures: {0 => {name: "punctuation.definition.parameters.c"}},
        name: "meta.function.constructor.c++",
        patterns: [{include: "$base"}]},
       {begin: 
         /(?x)
    				(?<_1>:)                            # begin-of-line
    				(?<_2>(?=\s*[A-Za-z_][A-Za-z0-9_:]* # actual name
    				 \s*(?<_3>\()))                      # start bracket or end-of-line
    			/,
        beginCaptures: {1 => {name: "punctuation.definition.parameters.c"}},
        end: "(?=\\{)",
        name: "meta.function.constructor.initializer-list.c++",
        patterns: [{include: "$base"}]}]},
   special_block: 
    {patterns: 
      [{begin: /\b(?<_1>namespace)\b\s*(?<_2>[_A-Za-z][_A-Za-z0-9]*\b)?+/,
        beginCaptures: 
         {1 => {name: "storage.type.c++"},
          2 => {name: "entity.name.type.c++"}},
        end: "(?<=\\})|(?=(;|,|\\(|\\)|>|\\[|\\]|=))",
        name: "meta.namespace-block.c++",
        patterns: 
         [{begin: /(?<_1>\{)/,
           beginCaptures: {1 => {name: "punctuation.definition.scope.c++"}},
           end: "(\\})",
           endCaptures: {1 => {name: "punctuation.definition.invalid.c++"}},
           patterns: 
            [{include: "#special_block"},
             {include: "#constructor"},
             {include: "$base"}]},
          {include: "$base"}]},
       {begin: /\b(?<_1>class|struct)\b\s*(?<_2>[_A-Za-z][_A-Za-z0-9]*\b)?+/,
        beginCaptures: 
         {1 => {name: "storage.type.c++"},
          2 => {name: "entity.name.type.c++"}},
        end: "(?<=\\})|(?=(;|,|\\(|\\)|>|\\[|\\]|=))",
        name: "meta.class-struct-block.c++",
        patterns: 
         [{include: "#angle_brackets"},
          {begin: /(?<_1>\{)/,
           beginCaptures: {1 => {name: "punctuation.definition.scope.c++"}},
           end: "(\\})(\\s*\\n)?",
           endCaptures: 
            {1 => {name: "punctuation.definition.invalid.c++"},
             2 => {name: "invalid.illegal.you-forgot-semicolon.c++"}},
           patterns: 
            [{include: "#special_block"},
             {include: "#constructor"},
             {include: "$base"}]},
          {include: "$base"}]},
       {begin: /\b(?<_1>extern)(?=\s*")/,
        beginCaptures: {1 => {name: "storage.modifier.c++"}},
        end: "(?<=\\})|(?=\\w)",
        name: "meta.extern-block.c++",
        patterns: 
         [{begin: /\{/,
           end: "\\}",
           patterns: [{include: "#special_block"}, {include: "$base"}]},
          {include: "$base"}]}]}},
 scopeName: "source.c++",
 uuid: "26251B18-6B1D-11D9-AFDB-000D93589AF6"}
