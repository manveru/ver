# Encoding: UTF-8

{bundleUUID: "E3BADC20-6B0E-11D9-9DC9-000D93589AF6",
 comment: 
  "\n\ttodo:\n\t\tlist comprehension / generator comprehension scope.\n\t\t\n\t",
 fileTypes: 
  ["py",
   "rpy",
   "pyw",
   "cpy",
   "SConstruct",
   "Sconstruct",
   "sconstruct",
   "SConscript"],
 firstLineMatch: "^#!/.*\\bpython\\b",
 foldingStartMarker: 
  /^\s*(?<_1>def|class)\s+(?<_2>[.a-zA-Z0-9_ <]+)\s*(?<_3>\((?<_4>.*)\))?\s*:|\{\s*$|\(\s*$|\[\s*$|^\s*"""(?=.)(?!.*""")/,
 foldingStopMarker: /^\s*$|^\s*\}|^\s*\]|^\s*\)|^\s*"""\s*$/,
 keyEquivalent: "^~P",
 name: "Python",
 patterns: 
  [{captures: {1 => {name: "punctuation.definition.comment.python"}},
    match: /(?<_1>#).*$\n?/,
    name: "comment.line.number-sign.python"},
   {match: /\b(?i:(?<_1>0x\h*)L)/,
    name: "constant.numeric.integer.long.hexadecimal.python"},
   {match: /\b(?i:(?<_1>0x\h*))/,
    name: "constant.numeric.integer.hexadecimal.python"},
   {match: /\b(?i:(?<_1>0[0-7]+)L)/,
    name: "constant.numeric.integer.long.octal.python"},
   {match: /\b(?<_1>0[0-7]+)/, name: "constant.numeric.integer.octal.python"},
   {match: 
     /\b(?i:(?<_1>(?<_2>(?<_3>\d+(?<_4>\.(?=[^a-zA-Z_])\d*)?|(?<=[^0-9a-zA-Z_])\.\d+)(?<_5>e[\-\+]?\d+)?))J)/,
    name: "constant.numeric.complex.python"},
   {match: /\b(?i:(?<_1>\d+\.\d*(?<_2>e[\-\+]?\d+)?))(?=[^a-zA-Z_])/,
    name: "constant.numeric.float.python"},
   {match: /(?<=[^0-9a-zA-Z_])(?i:(?<_1>\.\d+(?<_2>e[\-\+]?\d+)?))/,
    name: "constant.numeric.float.python"},
   {match: /\b(?i:(?<_1>\d+e[\-\+]?\d+))/,
    name: "constant.numeric.float.python"},
   {match: /\b(?i:(?<_1>[1-9]+[0-9]*|0)L)/,
    name: "constant.numeric.integer.long.decimal.python"},
   {match: /\b(?<_1>[1-9]+[0-9]*|0)/,
    name: "constant.numeric.integer.decimal.python"},
   {captures: {1 => {name: "storage.modifier.global.python"}},
    match: /\b(?<_1>global)\b/},
   {captures: 
     {1 => {name: "keyword.control.import.python"},
      2 => {name: "keyword.control.import.from.python"}},
    match: /\b(?:(?<_1>import)|(?<_2>from))\b/},
   {comment: "keywords that delimit flow blocks",
    match: /\b(?<_1>elif|else|except|finally|for|if|try|while|with)\b/,
    name: "keyword.control.flow.python"},
   {comment: "keywords that alter flow from within a block",
    match: /\b(?<_1>break|continue|pass|raise|return|yield)\b/,
    name: "keyword.control.flow.python"},
   {comment: "keyword operators that evaluate to True or False",
    match: /\b(?<_1>and|in|is|not|or)\b/,
    name: "keyword.operator.logical.python"},
   {captures: {1 => {name: "keyword.other.python"}},
    comment: "keywords that haven't fit into other groups (yet).",
    match: /\b(?<_1>as|assert|del|exec|print)\b/},
   {match: /<\=|>\=|\=\=|<|>|<>/, name: "keyword.operator.comparison.python"},
   {match: /\+\=|-\=|\*\=|\/\=|\/\/\=|%\=|&\=|\|\=|\^\=|>>\=|<<\=|\*\*\=/,
    name: "keyword.operator.assignment.augmented.python"},
   {match: /\+|\-|\*|\*\*|\/|\/\/|%|<<|>>|&|\||\^|~/,
    name: "keyword.operator.arithmetic.python"},
   {match: /\=/, name: "keyword.operator.assignment.python"},
   {begin: /^\s*(?<_1>class)\s+(?=[a-zA-Z_][a-zA-Z_0-9]*\s*\:)/,
    beginCaptures: {1 => {name: "storage.type.class.python"}},
    contentName: "entity.name.type.class.python",
    end: "\\s*(:)",
    endCaptures: {1 => {name: "punctuation.section.class.begin.python"}},
    name: "meta.class.old-style.python",
    patterns: [{include: "#entity_name_class"}]},
   {begin: /^\s*(?<_1>class)\s+(?=[a-zA-Z_][a-zA-Z_0-9]*\s*\()/,
    beginCaptures: {1 => {name: "storage.type.class.python"}},
    end: "(\\))\\s*(?:(\\:)|(.*$\\n?))",
    endCaptures: 
     {1 => {name: "punctuation.definition.inheritance.end.python"},
      2 => {name: "punctuation.section.class.begin.python"},
      3 => {name: "invalid.illegal.missing-section-begin.python"}},
    name: "meta.class.python",
    patterns: 
     [{begin: /(?=[A-Za-z_][A-Za-z0-9_]*)/,
       contentName: "entity.name.type.class.python",
       end: "(?![A-Za-z0-9_])",
       patterns: [{include: "#entity_name_class"}]},
      {begin: /(?<_1>\()/,
       beginCaptures: 
        {1 => {name: "punctuation.definition.inheritance.begin.python"}},
       contentName: "meta.class.inheritance.python",
       end: "(?=\\)|:)",
       patterns: 
        [{begin: /(?<=\(|,)\s*/,
          contentName: "entity.other.inherited-class.python",
          end: "\\s*(?:(,)|(?=\\)))",
          endCaptures: 
           {1 => {name: "punctuation.separator.inheritance.python"}},
          patterns: [{include: "$self"}]}]}]},
   {begin: /^\s*(?<_1>class)\s+(?=[a-zA-Z_][a-zA-Z_0-9])/,
    beginCaptures: {1 => {name: "storage.type.class.python"}},
    end: "(\\()|\\s*($\\n?|#.*$\\n?)",
    endCaptures: 
     {1 => {name: "punctuation.definition.inheritance.begin.python"},
      2 => {name: "invalid.illegal.missing-inheritance.python"}},
    name: "meta.class.python",
    patterns: 
     [{begin: /(?=[A-Za-z_][A-Za-z0-9_]*)/,
       contentName: "entity.name.type.class.python",
       end: "(?![A-Za-z0-9_])",
       patterns: [{include: "#entity_name_function"}]}]},
   {begin: /^\s*(?<_1>def)\s+(?=[A-Za-z_][A-Za-z0-9_]*\s*\()/,
    beginCaptures: {1 => {name: "storage.type.function.python"}},
    end: "(\\))\\s*(?:(\\:)|(.*$\\n?))",
    endCaptures: 
     {1 => {name: "punctuation.definition.parameters.end.python"},
      2 => {name: "punctuation.section.function.begin.python"},
      3 => {name: "invalid.illegal.missing-section-begin.python"}},
    name: "meta.function.python",
    patterns: 
     [{begin: /(?=[A-Za-z_][A-Za-z0-9_]*)/,
       contentName: "entity.name.function.python",
       end: "(?![A-Za-z0-9_])",
       patterns: [{include: "#entity_name_function"}]},
      {begin: /(?<_1>\()/,
       beginCaptures: 
        {1 => {name: "punctuation.definition.parameters.begin.python"}},
       contentName: "meta.function.parameters.python",
       end: "(?=\\)\\s*\\:)",
       patterns: 
        [{include: "#keyword_arguments"},
         {captures: 
           {1 => {name: "variable.parameter.function.python"},
            2 => {name: "punctuation.separator.parameters.python"}},
          match: 
           /\b(?<_1>[a-zA-Z_][a-zA-Z_0-9]*)\s*(?:(?<_2>,)|(?=[\n\)]))/}]}]},
   {begin: /^\s*(?<_1>def)\s+(?=[A-Za-z_][A-Za-z0-9_]*)/,
    beginCaptures: {1 => {name: "storage.type.function.python"}},
    end: "(\\()|\\s*($\\n?|#.*$\\n?)",
    endCaptures: 
     {1 => {name: "punctuation.definition.parameters.begin.python"},
      2 => {name: "invalid.illegal.missing-parameters.python"}},
    name: "meta.function.python",
    patterns: 
     [{begin: /(?=[A-Za-z_][A-Za-z0-9_]*)/,
       contentName: "entity.name.function.python",
       end: "(?![A-Za-z0-9_])",
       patterns: [{include: "#entity_name_function"}]}]},
   {begin: /(?<_1>lambda)(?=\s+)/,
    beginCaptures: {1 => {name: "storage.type.function.inline.python"}},
    end: "(\\:)",
    endCaptures: 
     {1 => {name: "punctuation.definition.parameters.end.python"},
      2 => {name: "punctuation.section.function.begin.python"},
      3 => {name: "invalid.illegal.missing-section-begin.python"}},
    name: "meta.function.inline.python",
    patterns: 
     [{begin: /\s+/,
       contentName: "meta.function.inline.parameters.python",
       end: "(?=\\:)",
       patterns: 
        [{include: "#keyword_arguments"},
         {captures: 
           {1 => {name: "variable.parameter.function.python"},
            2 => {name: "punctuation.separator.parameters.python"}},
          match: 
           /\b(?<_1>[a-zA-Z_][a-zA-Z_0-9]*)\s*(?:(?<_2>,)|(?=[\n\)\:]))/}]}]},
   {begin: 
     /^\s*(?=@\s*[A-Za-z_][A-Za-z0-9_]*(?:\.[a-zA-Z_][a-zA-Z_0-9]*)*\s*\()/,
    comment: "a decorator may be a function call which returns a decorator.",
    end: "(\\))",
    endCaptures: {1 => {name: "punctuation.definition.arguments.end.python"}},
    name: "meta.function.decorator.python",
    patterns: 
     [{begin: 
        /(?=(?<_1>@)\s*[A-Za-z_][A-Za-z0-9_]*(?:\.[A-Za-z_][A-Za-z0-9_]*)*\s*\()/,
       beginCaptures: {1 => {name: "punctuation.definition.decorator.python"}},
       contentName: "entity.name.function.decorator.python",
       end: "(?=\\s*\\()",
       patterns: [{include: "#dotted_name"}]},
      {begin: /(?<_1>\()/,
       beginCaptures: 
        {1 => {name: "punctuation.definition.arguments.begin.python"}},
       contentName: "meta.function.decorator.arguments.python",
       end: "(?=\\))",
       patterns: [{include: "#keyword_arguments"}, {include: "$self"}]}]},
   {begin: /^\s*(?=@\s*[A-Za-z_][A-Za-z0-9_]*(?:\.[a-zA-Z_][a-zA-Z_0-9]*)*)/,
    contentName: "entity.name.function.decorator.python",
    end: "(?=\\s|$\\n?|#)",
    name: "meta.function.decorator.python",
    patterns: 
     [{begin: 
        /(?=(?<_1>@)\s*[A-Za-z_][A-Za-z0-9_]*(?<_2>\.[A-Za-z_][A-Za-z0-9_]*)*)/,
       beginCaptures: {1 => {name: "punctuation.definition.decorator.python"}},
       end: "(?=\\s|$\\n?|#)",
       patterns: [{include: "#dotted_name"}]}]},
   {begin: /(?<=\)|\])\s*(?<_1>\()/,
    beginCaptures: 
     {1 => {name: "punctuation.definition.arguments.begin.python"}},
    contentName: "meta.function-call.arguments.python",
    end: "(\\))",
    endCaptures: {1 => {name: "punctuation.definition.arguments.end.python"}},
    name: "meta.function-call.python",
    patterns: [{include: "#keyword_arguments"}, {include: "$self"}]},
   {begin: /(?=[A-Za-z_][A-Za-z0-9_]*(?:\.[a-zA-Z_][a-zA-Z_0-9]*)*\s*\()/,
    end: "(\\))",
    endCaptures: {1 => {name: "punctuation.definition.arguments.end.python"}},
    name: "meta.function-call.python",
    patterns: 
     [{begin: /(?=[A-Za-z_][A-Za-z0-9_]*(?:\.[A-Za-z_][A-Za-z0-9_]*)*\s*\()/,
       end: "(?=\\s*\\()",
       patterns: [{include: "#dotted_name"}]},
      {begin: /(?<_1>\()/,
       beginCaptures: 
        {1 => {name: "punctuation.definition.arguments.begin.python"}},
       contentName: "meta.function-call.arguments.python",
       end: "(?=\\))",
       patterns: [{include: "#keyword_arguments"}, {include: "$self"}]}]},
   {begin: /(?=[A-Za-z_][A-Za-z0-9_]*(?:\.[a-zA-Z_][a-zA-Z_0-9]*)*\s*\[)/,
    end: "(\\])",
    endCaptures: {1 => {name: "punctuation.definition.arguments.end.python"}},
    name: "meta.item-access.python",
    patterns: 
     [{begin: /(?=[A-Za-z_][A-Za-z0-9_]*(?:\.[A-Za-z_][A-Za-z0-9_]*)*\s*\[)/,
       end: "(?=\\s*\\[)",
       patterns: [{include: "#dotted_name"}]},
      {begin: /(?<_1>\[)/,
       beginCaptures: 
        {1 => {name: "punctuation.definition.arguments.begin.python"}},
       contentName: "meta.item-access.arguments.python",
       end: "(?=\\])",
       patterns: [{include: "$self"}]}]},
   {begin: /(?<=\)|\])\s*(?<_1>\[)/,
    beginCaptures: 
     {1 => {name: "punctuation.definition.arguments.begin.python"}},
    contentName: "meta.item-access.arguments.python",
    end: "(\\])",
    endCaptures: {1 => {name: "punctuation.definition.arguments.end.python"}},
    name: "meta.item-access.python",
    patterns: [{include: "$self"}]},
   {captures: {1 => {name: "storage.type.function.python"}},
    match: /\b(?<_1>def|lambda)\b/},
   {captures: {1 => {name: "storage.type.class.python"}},
    match: /\b(?<_1>class)\b/},
   {include: "#line_continuation"},
   {include: "#language_variables"},
   {match: /\b(?<_1>None|True|False|Ellipsis|NotImplemented)\b/,
    name: "constant.language.python"},
   {include: "#string_quoted_single"},
   {include: "#string_quoted_double"},
   {include: "#dotted_name"},
   {begin: /(?<_1>\()/, end: "(\\))", patterns: [{include: "$self"}]},
   {captures: 
     {1 => {name: "punctuation.definition.list.begin.python"},
      2 => {name: "meta.empty-list.python"},
      3 => {name: "punctuation.definition.list.end.python"}},
    match: /(?<_1>\[)(?<_2>\s*(?<_3>\]))\b/},
   {begin: /(?<_1>\[)/,
    beginCaptures: {1 => {name: "punctuation.definition.list.begin.python"}},
    end: "(\\])",
    endCaptures: {1 => {name: "punctuation.definition.list.end.python"}},
    name: "meta.structure.list.python",
    patterns: 
     [{begin: /(?<=\[|\,)\s*(?![\],])/,
       contentName: "meta.structure.list.item.python",
       end: "\\s*(?:(,)|(?=\\]))",
       endCaptures: {1 => {name: "punctuation.separator.list.python"}},
       patterns: [{include: "$self"}]}]},
   {captures: 
     {1 => {name: "punctuation.definition.tuple.begin.python"},
      2 => {name: "meta.empty-tuple.python"},
      3 => {name: "punctuation.definition.tuple.end.python"}},
    match: /(?<_1>\()(?<_2>\s*(?<_3>\)))/,
    name: "meta.structure.tuple.python"},
   {captures: 
     {1 => {name: "punctuation.definition.dictionary.begin.python"},
      2 => {name: "meta.empty-dictionary.python"},
      3 => {name: "punctuation.definition.dictionary.end.python"}},
    match: /(?<_1>\{)(?<_2>\s*(?<_3>\}))/,
    name: "meta.structure.dictionary.python"},
   {begin: /(?<_1>\{)/,
    beginCaptures: 
     {1 => {name: "punctuation.definition.dictionary.begin.python"}},
    end: "(\\})",
    endCaptures: {1 => {name: "punctuation.definition.dictionary.end.python"}},
    name: "meta.structure.dictionary.python",
    patterns: 
     [{begin: /(?<=\{|\,|^)\s*(?![\},])/,
       contentName: "meta.structure.dictionary.key.python",
       end: "\\s*(?:(?=\\})|(\\:))",
       endCaptures: 
        {1 => {name: "punctuation.separator.valuepair.dictionary.python"}},
       patterns: [{include: "$self"}]},
      {begin: /(?<=\:|^)\s*/,
       contentName: "meta.structure.dictionary.value.python",
       end: "\\s*(?:(?=\\})|(,))",
       endCaptures: {1 => {name: "punctuation.separator.dictionary.python"}},
       patterns: [{include: "$self"}]}]}],
 repository: 
  {builtin_exceptions: 
    {match: 
      /(?x)\b(?<_1>(?<_2>Arithmetic|Assertion|Attribute|EOF|Environment|FloatingPoint|IO|Import|Indentation|Index|Key|Lookup|Memory|Name|OS|Overflow|NotImplemented|Reference|Runtime|Standard|Syntax|System|Tab|Type|UnboundLocal|Unicode(?<_3>Translate|Encode|Decode)?|Value|ZeroDivision)Error|(?<_4>Deprecation|Future|Overflow|PendingDeprecation|Runtime|Syntax|User)?Warning|KeyboardInterrupt|NotImplemented|StopIteration|SystemExit|(?<_5>Base)?Exception)\b/,
     name: "support.type.exception.python"},
   builtin_functions: 
    {match: 
      /(?x)\b(?<_1>
                __import__|all|abs|any|apply|callable|chr|cmp|coerce|compile|delattr|dir|
                divmod|eval|execfile|filter|getattr|globals|hasattr|hash|hex|id|
                input|intern|isinstance|issubclass|iter|len|locals|map|max|min|oct|
                ord|pow|range|raw_input|reduce|reload|repr|round|setattr|sorted|
                sum|unichr|vars|zip
	)\b/,
     name: "support.function.builtin.python"},
   builtin_types: 
    {match: 
      /(?x)\b(?<_1>
	basestring|bool|buffer|classmethod|complex|dict|enumerate|file|
	float|frozenset|int|list|long|object|open|property|reversed|set|
	slice|staticmethod|str|super|tuple|type|unicode|xrange
	)\b/,
     name: "support.type.python"},
   constant_placeholder: 
    {match: 
      /(?i:%(?<_1>\([a-z_]+\))?#?0?\-?[ ]?\+?(?<_2>[0-9]*|\*)(?<_3>\.(?<_4>[0-9]*|\*))?[hL]?[a-z%])/,
     name: "constant.other.placeholder.python"},
   docstrings: 
    {patterns: 
      [{begin: /^\s*(?=[uU]?[rR]?""")/,
        end: "(?<=\"\"\")",
        name: "comment.block.python",
        patterns: [{include: "#string_quoted_double"}]},
       {begin: /^\s*(?=[uU]?[rR]?''')/,
        end: "(?<=''')",
        name: "comment.block.python",
        patterns: [{include: "#string_quoted_single"}]}]},
   dotted_name: 
    {begin: /(?=[A-Za-z_][A-Za-z0-9_]*(?:\.[A-Za-z_][A-Za-z0-9_]*)*)/,
     end: "(?![A-Za-z0-9_\\.])",
     patterns: 
      [{begin: /(?<_1>\.)(?=[A-Za-z_][A-Za-z0-9_]*)/,
        end: "(?![A-Za-z0-9_])",
        patterns: 
         [{include: "#magic_function_names"},
          {include: "#magic_variable_names"},
          {include: "#illegal_names"},
          {include: "#generic_names"}]},
       {begin: /(?<!\.)(?=[A-Za-z_][A-Za-z0-9_]*)/,
        end: "(?![A-Za-z0-9_])",
        patterns: 
         [{include: "#builtin_functions"},
          {include: "#builtin_types"},
          {include: "#builtin_exceptions"},
          {include: "#illegal_names"},
          {include: "#magic_function_names"},
          {include: "#magic_variable_names"},
          {include: "#language_variables"},
          {include: "#generic_names"}]}]},
   entity_name_class: 
    {patterns: [{include: "#illegal_names"}, {include: "#generic_names"}]},
   entity_name_function: 
    {patterns: 
      [{include: "#magic_function_names"},
       {include: "#illegal_names"},
       {include: "#generic_names"}]},
   escaped_char: 
    {captures: 
      {1 => {name: "constant.character.escape.hex.python"},
       10 => {name: "constant.character.escape.linefeed.python"},
       11 => {name: "constant.character.escape.return.python"},
       12 => {name: "constant.character.escape.tab.python"},
       13 => {name: "constant.character.escape.vertical-tab.python"},
       2 => {name: "constant.character.escape.octal.python"},
       3 => {name: "constant.character.escape.newline.python"},
       4 => {name: "constant.character.escape.backlash.python"},
       5 => {name: "constant.character.escape.double-quote.python"},
       6 => {name: "constant.character.escape.single-quote.python"},
       7 => {name: "constant.character.escape.bell.python"},
       8 => {name: "constant.character.escape.backspace.python"},
       9 => {name: "constant.character.escape.formfeed.python"}},
     match: 
      /(?<_1>\\x[0-9A-F]{2})|(?<_2>\\[0-7]{3})|(?<_3>\\\n)|(?<_4>\\\\)|(?<_5>\\\")|(?<_6>\\')|(?<_7>\\a)|(?<_8>\\b)|(?<_9>\\f)|(?<_10>\\n)|(?<_11>\\r)|(?<_12>\\t)|(?<_13>\\v)/},
   escaped_unicode_char: 
    {captures: 
      {1 => {name: "constant.character.escape.unicode.16-bit-hex.python"},
       2 => {name: "constant.character.escape.unicode.32-bit-hex.python"},
       3 => {name: "constant.character.escape.unicode.name.python"}},
     match: 
      /(?<_1>\\U[0-9A-Fa-f]{8})|(?<_2>\\u[0-9A-Fa-f]{4})|(?<_3>\\N\{[a-zA-Z ]+\})/},
   function_name: 
    {patterns: 
      [{include: "#magic_function_names"},
       {include: "#magic_variable_names"},
       {include: "#builtin_exceptions"},
       {include: "#builtin_functions"},
       {include: "#builtin_types"},
       {include: "#generic_names"}]},
   generic_names: {match: /[A-Za-z_][A-Za-z0-9_]*/},
   illegal_names: 
    {match: 
      /\b(?<_1>and|as|assert|break|class|continue|def|del|elif|else|except|exec|finally|for|from|global|if|import|in|is|lambda|not|or|pass|print|raise|return|try|while|with|yield)\b/,
     name: "invalid.illegal.name.python"},
   keyword_arguments: 
    {begin: /\b(?<_1>[a-zA-Z_][a-zA-Z_0-9]*)\s*(?<_2>=)(?!=)/,
     beginCaptures: 
      {1 => {name: "variable.parameter.function.python"},
       2 => {name: "keyword.operator.assignment.python"}},
     end: "\\s*(?:(,)|(?=$\\n?|[\\)\\:]))",
     endCaptures: {1 => {name: "punctuation.separator.parameters.python"}},
     patterns: [{include: "$self"}]},
   language_variables: 
    {match: /\b(?<_1>self|cls)\b/, name: "variable.language.python"},
   line_continuation: 
    {captures: 
      {1 => {name: "punctuation.separator.continuation.line.python"},
       2 => {name: "invalid.illegal.unexpected-text.python"}},
     match: /(?<_1>\\)(?<_2>.*)$\n?/},
   magic_function_names: 
    {comment: 
      "these methods have magic interpretation by python and are generally called indirectly through syntactic constructs",
     match: 
      /(?x)\b(?<_1>__(?:
	abs|add|and|call|cmp|coerce|complex|contains|del|delattr|
	delete|delitem|delslice|div|divmod|enter|eq|exit|float|
	floordiv|ge|get|getattr|getattribute|getitem|getslice|gt|
	hash|hex|iadd|iand|idiv|ifloordiv|ilshift|imod|imul|init|
	int|invert|ior|ipow|irshift|isub|iter|itruediv|ixor|le|len|
	long|lshift|lt|mod|mul|ne|neg|new|nonzero|oct|or|pos|pow|
	radd|rand|rdiv|rdivmod|repr|rfloordiv|rlshift|rmod|rmul|ror|
	rpow|rrshift|rshift|rsub|rtruediv|rxor|set|setattr|setitem|
	setslice|str|sub|truediv|unicode|xor
	)__)\b/,
     name: "support.function.magic.python"},
   magic_variable_names: 
    {comment: "magic variables which a class/module may have.",
     match: 
      /\b__(?<_1>all|bases|class|debug|dict|doc|file|members|metaclass|methods|name|slots|weakref)__\b/,
     name: "support.variable.magic.python"},
   regular_expressions: 
    {comment: 
      "Changed disabled to 1 to turn off syntax highlighting in “r” strings.",
     disabled: 0,
     patterns: [{include: "source.regexp.python"}]},
   string_quoted_double: 
    {patterns: 
      [{begin: /(?<_1>[uU]r)(?<_2>""")/,
        beginCaptures: 
         {1 => {name: "storage.type.string.python"},
          2 => {name: "punctuation.definition.string.begin.python"}},
        comment: "single quoted unicode-raw string",
        end: "((?<=\"\"\")(\")\"\"|\"\"\")",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "meta.empty-string.double.python"}},
        name: "string.quoted.double.block.unicode-raw-regex.python",
        patterns: 
         [{include: "#constant_placeholder"},
          {include: "#escaped_unicode_char"},
          {include: "#escaped_char"},
          {include: "#regular_expressions"}]},
       {begin: /(?<_1>[uU]R)(?<_2>""")/,
        beginCaptures: 
         {1 => {name: "storage.type.string.python"},
          2 => {name: "punctuation.definition.string.begin.python"}},
        comment: 
         "single quoted unicode-raw string without regular expression highlighting",
        end: "((?<=\"\"\")(\")\"\"|\"\"\")",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "meta.empty-string.double.python"}},
        name: "string.quoted.double.block.unicode-raw.python",
        patterns: 
         [{include: "#constant_placeholder"},
          {include: "#escaped_unicode_char"},
          {include: "#escaped_char"}]},
       {begin: /(?<_1>r)(?<_2>""")/,
        beginCaptures: 
         {1 => {name: "storage.type.string.python"},
          2 => {name: "punctuation.definition.string.begin.python"}},
        comment: "double quoted raw string",
        end: "((?<=\"\"\")(\")\"\"|\"\"\")",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "meta.empty-string.double.python"}},
        name: "string.quoted.double.block.raw-regex.python",
        patterns: 
         [{include: "#constant_placeholder"},
          {include: "#escaped_char"},
          {include: "#regular_expressions"}]},
       {begin: /(?<_1>R)(?<_2>""")/,
        beginCaptures: 
         {1 => {name: "storage.type.string.python"},
          2 => {name: "punctuation.definition.string.begin.python"}},
        comment: "double quoted raw string",
        end: "((?<=\"\"\")(\")\"\"|\"\"\")",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "meta.empty-string.double.python"}},
        name: "string.quoted.double.block.raw.python",
        patterns: 
         [{include: "#constant_placeholder"}, {include: "#escaped_char"}]},
       {begin: /(?<_1>[uU])(?<_2>""")/,
        beginCaptures: 
         {1 => {name: "storage.type.string.python"},
          2 => {name: "punctuation.definition.string.begin.python"}},
        comment: "double quoted unicode string",
        end: "((?<=\"\"\")(\")\"\"|\"\"\")",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "meta.empty-string.double.python"}},
        name: "string.quoted.double.block.unicode.python",
        patterns: 
         [{include: "#constant_placeholder"},
          {include: "#escaped_unicode_char"},
          {include: "#escaped_char"}]},
       {begin: /(?<_1>[uU]r)(?<_2>")/,
        beginCaptures: 
         {1 => {name: "storage.type.string.python"},
          2 => {name: "punctuation.definition.string.begin.python"}},
        comment: "double-quoted raw string",
        end: "((?<=\")(\")|\")|(\\n)",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "meta.empty-string.double.python"},
          3 => {name: "invalid.illegal.unclosed-string.python"}},
        name: "string.quoted.double.single-line.unicode-raw-regex.python",
        patterns: 
         [{include: "#constant_placeholder"},
          {include: "#escaped_unicode_char"},
          {include: "#escaped_char"},
          {include: "#regular_expressions"}]},
       {begin: /(?<_1>[uU]R)(?<_2>")/,
        beginCaptures: 
         {1 => {name: "storage.type.string.python"},
          2 => {name: "punctuation.definition.string.begin.python"}},
        comment: "double-quoted raw string",
        end: "((?<=\")(\")|\")|(\\n)",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "meta.empty-string.double.python"},
          3 => {name: "invalid.illegal.unclosed-string.python"}},
        name: "string.quoted.double.single-line.unicode-raw.python",
        patterns: 
         [{include: "#constant_placeholder"},
          {include: "#escaped_unicode_char"},
          {include: "#escaped_char"}]},
       {begin: /(?<_1>r)(?<_2>")/,
        beginCaptures: 
         {1 => {name: "storage.type.string.python"},
          2 => {name: "punctuation.definition.string.begin.python"}},
        comment: "double-quoted raw string",
        end: "((?<=\")(\")|\")|(\\n)",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "meta.empty-string.double.python"},
          3 => {name: "invalid.illegal.unclosed-string.python"}},
        name: "string.quoted.double.single-line.raw-regex.python",
        patterns: 
         [{include: "#constant_placeholder"},
          {include: "#escaped_char"},
          {include: "#regular_expressions"}]},
       {begin: /(?<_1>R)(?<_2>")/,
        beginCaptures: 
         {1 => {name: "storage.type.string.python"},
          2 => {name: "punctuation.definition.string.begin.python"}},
        comment: "double-quoted raw string",
        end: "((?<=\")(\")|\")|(\\n)",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "meta.empty-string.double.python"},
          3 => {name: "invalid.illegal.unclosed-string.python"}},
        name: "string.quoted.double.single-line.raw.python",
        patterns: 
         [{include: "#constant_placeholder"}, {include: "#escaped_char"}]},
       {begin: /(?<_1>[uU])(?<_2>")/,
        beginCaptures: 
         {1 => {name: "storage.type.string.python"},
          2 => {name: "punctuation.definition.string.begin.python"}},
        comment: "double quoted unicode string",
        end: "((?<=\")(\")|\")|(\\n)",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "meta.empty-string.double.python"},
          3 => {name: "invalid.illegal.unclosed-string.python"}},
        name: "string.quoted.double.single-line.unicode.python",
        patterns: 
         [{include: "#constant_placeholder"},
          {include: "#escaped_unicode_char"},
          {include: "#escaped_char"}]},
       {begin: 
         /(?<_1>""")(?=\s*(?<_2>SELECT|INSERT|UPDATE|DELETE|CREATE|REPLACE|ALTER))/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.string.begin.python"}},
        comment: "double quoted string",
        end: "((?<=\"\"\")(\")\"\"|\"\"\")",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "meta.empty-string.double.python"}},
        name: "string.quoted.double.block.sql.python",
        patterns: 
         [{include: "#constant_placeholder"},
          {include: "#escaped_char"},
          {include: "source.sql"}]},
       {begin: 
         /(?<_1>")(?=\s*(?<_2>SELECT|INSERT|UPDATE|DELETE|CREATE|REPLACE|ALTER))/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.string.begin.python"}},
        comment: "double quoted string",
        end: "((?<=\")(\")|\")|(\\n)",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "meta.empty-string.double.python"},
          3 => {name: "invalid.illegal.unclosed-string.python"}},
        name: "string.quoted.double.single-line.sql.python",
        patterns: 
         [{include: "#constant_placeholder"},
          {include: "#escaped_char"},
          {include: "source.sql"}]},
       {begin: /(?<_1>""")/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.string.begin.python"}},
        comment: "double quoted string",
        end: "((?<=\"\"\")(\")\"\"|\"\"\")",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "meta.empty-string.double.python"}},
        name: "string.quoted.double.block.python",
        patterns: 
         [{include: "#constant_placeholder"}, {include: "#escaped_char"}]},
       {begin: /(?<_1>")/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.string.begin.python"}},
        comment: "double quoted string",
        end: "((?<=\")(\")|\")|(\\n)",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "meta.empty-string.double.python"},
          3 => {name: "invalid.illegal.unclosed-string.python"}},
        name: "string.quoted.double.single-line.python",
        patterns: 
         [{include: "#constant_placeholder"}, {include: "#escaped_char"}]}]},
   string_quoted_single: 
    {patterns: 
      [{captures: 
         {1 => {name: "punctuation.definition.string.begin.python"},
          2 => {name: "punctuation.definition.string.end.python"},
          3 => {name: "meta.empty-string.single.python"}},
        match: /(?<!')(?<_1>')(?<_2>(?<_3>'))(?!')/,
        name: "string.quoted.single.single-line.python"},
       {begin: /(?<_1>[uU]r)(?<_2>''')/,
        beginCaptures: 
         {1 => {name: "storage.type.string.python"},
          2 => {name: "punctuation.definition.string.begin.python"}},
        comment: "single quoted unicode-raw string",
        end: "((?<=''')(')''|''')",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "meta.empty-string.single.python"}},
        name: "string.quoted.single.block.unicode-raw-regex.python",
        patterns: 
         [{include: "#constant_placeholder"},
          {include: "#escaped_unicode_char"},
          {include: "#escaped_char"},
          {include: "#regular_expressions"}]},
       {begin: /(?<_1>[uU]R)(?<_2>''')/,
        beginCaptures: 
         {1 => {name: "storage.type.string.python"},
          2 => {name: "punctuation.definition.string.begin.python"}},
        comment: "single quoted unicode-raw string",
        end: "((?<=''')(')''|''')",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "meta.empty-string.single.python"}},
        name: "string.quoted.single.block.unicode-raw.python",
        patterns: 
         [{include: "#constant_placeholder"},
          {include: "#escaped_unicode_char"},
          {include: "#escaped_char"}]},
       {begin: /(?<_1>r)(?<_2>''')/,
        beginCaptures: 
         {1 => {name: "storage.type.string.python"},
          2 => {name: "punctuation.definition.string.begin.python"}},
        comment: "single quoted raw string",
        end: "((?<=''')(')''|''')",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "meta.empty-string.single.python"}},
        name: "string.quoted.single.block.raw-regex.python",
        patterns: 
         [{include: "#constant_placeholder"},
          {include: "#escaped_char"},
          {include: "#regular_expressions"}]},
       {begin: /(?<_1>R)(?<_2>''')/,
        beginCaptures: 
         {1 => {name: "storage.type.string.python"},
          2 => {name: "punctuation.definition.string.begin.python"}},
        comment: "single quoted raw string",
        end: "((?<=''')(')''|''')",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "meta.empty-string.single.python"}},
        name: "string.quoted.single.block.raw.python",
        patterns: 
         [{include: "#constant_placeholder"}, {include: "#escaped_char"}]},
       {begin: /(?<_1>[uU])(?<_2>''')/,
        beginCaptures: 
         {1 => {name: "storage.type.string.python"},
          2 => {name: "punctuation.definition.string.begin.python"}},
        comment: "single quoted unicode string",
        end: "((?<=''')(')''|''')",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "meta.empty-string.single.python"}},
        name: "string.quoted.single.block.unicode.python",
        patterns: 
         [{include: "#constant_placeholder"},
          {include: "#escaped_unicode_char"},
          {include: "#escaped_char"}]},
       {begin: /(?<_1>[uU]r)(?<_2>')/,
        beginCaptures: 
         {1 => {name: "storage.type.string.python"},
          2 => {name: "punctuation.definition.string.begin.python"}},
        comment: "single quoted raw string",
        end: "(')|(\\n)",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "invalid.illegal.unclosed-string.python"}},
        name: "string.quoted.single.single-line.unicode-raw-regex.python",
        patterns: 
         [{include: "#constant_placeholder"},
          {include: "#escaped_unicode_char"},
          {include: "#escaped_char"},
          {include: "#regular_expressions"}]},
       {begin: /(?<_1>[uU]R)(?<_2>')/,
        beginCaptures: 
         {1 => {name: "storage.type.string.python"},
          2 => {name: "punctuation.definition.string.begin.python"}},
        comment: "single quoted raw string",
        end: "(')|(\\n)",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "invalid.illegal.unclosed-string.python"}},
        name: "string.quoted.single.single-line.unicode-raw.python",
        patterns: 
         [{include: "#constant_placeholder"},
          {include: "#escaped_unicode_char"},
          {include: "#escaped_char"}]},
       {begin: /(?<_1>r)(?<_2>')/,
        beginCaptures: 
         {1 => {name: "storage.type.string.python"},
          2 => {name: "punctuation.definition.string.begin.python"}},
        comment: "single quoted raw string",
        end: "(')|(\\n)",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "invalid.illegal.unclosed-string.python"}},
        name: "string.quoted.single.single-line.raw-regex.python",
        patterns: 
         [{include: "#constant_placeholder"},
          {include: "#escaped_char"},
          {include: "#regular_expressions"}]},
       {begin: /(?<_1>R)(?<_2>')/,
        beginCaptures: 
         {1 => {name: "storage.type.string.python"},
          2 => {name: "punctuation.definition.string.begin.python"}},
        comment: "single quoted raw string",
        end: "(')|(\\n)",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "invalid.illegal.unclosed-string.python"}},
        name: "string.quoted.single.single-line.raw.python",
        patterns: 
         [{include: "#constant_placeholder"}, {include: "#escaped_char"}]},
       {begin: /(?<_1>[uU])(?<_2>')/,
        beginCaptures: 
         {1 => {name: "storage.type.string.python"},
          2 => {name: "punctuation.definition.string.begin.python"}},
        comment: "single quoted unicode string",
        end: "(')|(\\n)",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "invalid.illegal.unclosed-string.python"}},
        name: "string.quoted.single.single-line.unicode.python",
        patterns: 
         [{include: "#constant_placeholder"},
          {include: "#escaped_unicode_char"},
          {include: "#escaped_char"}]},
       {begin: 
         /(?<_1>''')(?=\s*(?<_2>SELECT|INSERT|UPDATE|DELETE|CREATE|REPLACE|ALTER))/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.string.begin.python"}},
        comment: "single quoted string",
        end: "((?<=''')(')''|''')",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "meta.empty-string.single.python"}},
        name: "string.quoted.single.block.python",
        patterns: 
         [{include: "#constant_placeholder"},
          {include: "#escaped_char"},
          {include: "source.sql"}]},
       {begin: 
         /(?<_1>')(?=\s*(?<_2>SELECT|INSERT|UPDATE|DELETE|CREATE|REPLACE|ALTER))/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.string.begin.python"}},
        comment: "single quoted string",
        end: "(')|(\\n)",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "invalid.illegal.unclosed-string.python"}},
        name: "string.quoted.single.single-line.python",
        patterns: 
         [{include: "#constant_placeholder"},
          {include: "#escaped_char"},
          {include: "source.sql"}]},
       {begin: /(?<_1>''')/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.string.begin.python"}},
        comment: "single quoted string",
        end: "((?<=''')(')''|''')",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "meta.empty-string.single.python"}},
        name: "string.quoted.single.block.python",
        patterns: 
         [{include: "#constant_placeholder"}, {include: "#escaped_char"}]},
       {begin: /(?<_1>')/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.string.begin.python"}},
        comment: "single quoted string",
        end: "(')|(\\n)",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.python"},
          2 => {name: "invalid.illegal.unclosed-string.python"}},
        name: "string.quoted.single.single-line.python",
        patterns: 
         [{include: "#constant_placeholder"}, {include: "#escaped_char"}]}]},
   strings: 
    {patterns: 
      [{include: "#string_quoted_double"},
       {include: "#string_quoted_single"}]}},
 scopeName: "source.python",
 uuid: "F23DB5B2-7D08-11D9-A709-000D93B6E43C"}
