# Encoding: UTF-8

{comment: 
  "The recognition of function definitions and compiler directives (such as module, record and macro definitions) requires that each of the aforementioned constructs must be the first string inside a line (except for whitespace).  Also, the function/module/record/macro names must be given unquoted.  -- desp",
 fileTypes: ["erl", "hrl"],
 keyEquivalent: "^~E",
 name: "Erlang",
 patterns: 
  [{include: "#module-directive"},
   {include: "#import-export-directive"},
   {include: "#record-directive"},
   {include: "#define-directive"},
   {include: "#macro-directive"},
   {include: "#directive"},
   {include: "#function"},
   {include: "#everything-else"}],
 repository: 
  {atom: 
    {patterns: 
      [{begin: /(?<_1>')/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.symbol.begin.erlang"}},
        end: "(')",
        endCaptures: {1 => {name: "punctuation.definition.symbol.end.erlang"}},
        name: "constant.other.symbol.quoted.single.erlang",
        patterns: 
         [{captures: 
            {1 => {name: "punctuation.definition.escape.erlang"},
             3 => {name: "punctuation.definition.escape.erlang"}},
           match: /(?<_1>\\)(?<_2>[bdefnrstv\\'"]|(?<_3>\^)[@-_]|[0-7]{1,3})/,
           name: "constant.other.symbol.escape.erlang"},
          {match: /\\\^?.?/, name: "invalid.illegal.atom.erlang"}]},
       {match: /[a-z][a-zA-Z\d@_]*+/,
        name: "constant.other.symbol.unquoted.erlang"}]},
   binary: 
    {begin: /(?<_1><<)/,
     beginCaptures: 
      {1 => {name: "punctuation.definition.binary.begin.erlang"}},
     end: "(>>)",
     endCaptures: {1 => {name: "punctuation.definition.binary.end.erlang"}},
     name: "meta.structure.binary.erlang",
     patterns: 
      [{captures: 
         {1 => {name: "punctuation.separator.binary.erlang"},
          2 => {name: "punctuation.separator.value-size.erlang"}},
        match: /(?<_1>,)|(?<_2>:)/},
       {include: "#internal-type-specifiers"},
       {include: "#everything-else"}]},
   character: 
    {patterns: 
      [{captures: 
         {1 => {name: "punctuation.definition.character.erlang"},
          2 => {name: "constant.character.escape.erlang"},
          3 => {name: "punctuation.definition.escape.erlang"},
          5 => {name: "punctuation.definition.escape.erlang"}},
        match: 
         /(?<_1>\$)(?<_2>(?<_3>\\)(?<_4>[bdefnrstv\\'"]|(?<_5>\^)[@-_]|[0-7]{1,3}))/,
        name: "constant.character.erlang"},
       {match: /\$\\\^?.?/, name: "invalid.illegal.character.erlang"},
       {captures: {1 => {name: "punctuation.definition.character.erlang"}},
        match: /(?<_1>\$)\S/,
        name: "constant.character.erlang"},
       {match: /\$.?/, name: "invalid.illegal.character.erlang"}]},
   comment: 
    {begin: /(?<_1>%)/,
     beginCaptures: {1 => {name: "punctuation.definition.comment.erlang"}},
     end: "$\\n?",
     name: "comment.line.erlang"},
   :"define-directive" => 
    {patterns: 
      [{begin: 
         /^\s*+(?<_1>-)\s*+(?<_2>define)\s*+(?<_3>\()\s*+(?<_4>[a-zA-Z\d@_]++)\s*+(?<_5>,)/,
        beginCaptures: 
         {1 => {name: "punctuation.section.directive.begin.erlang"},
          2 => {name: "keyword.control.directive.define.erlang"},
          3 => {name: "punctuation.definition.parameters.begin.erlang"},
          4 => {name: "entity.name.function.macro.definition.erlang"},
          5 => {name: "punctuation.separator.parameters.erlang"}},
        end: "(\\))\\s*+(\\.)",
        endCaptures: 
         {1 => {name: "punctuation.definition.parameters.end.erlang"},
          2 => {name: "punctuation.section.directive.end.erlang"}},
        name: "meta.directive.define.erlang",
        patterns: [{include: "#everything-else"}]},
       {begin: /(?=^\s*+-\s*+define\s*+\(\s*+[a-zA-Z\d@_]++\s*+\()/,
        end: "(\\))\\s*+(\\.)",
        endCaptures: 
         {1 => {name: "punctuation.definition.parameters.end.erlang"},
          2 => {name: "punctuation.section.directive.end.erlang"}},
        name: "meta.directive.define.erlang",
        patterns: 
         [{begin: 
            /^\s*+(?<_1>-)\s*+(?<_2>define)\s*+(?<_3>\()\s*+(?<_4>[a-zA-Z\d@_]++)\s*+(?<_5>\()/,
           beginCaptures: 
            {1 => {name: "punctuation.section.directive.begin.erlang"},
             2 => {name: "keyword.control.directive.define.erlang"},
             3 => {name: "punctuation.definition.parameters.begin.erlang"},
             4 => {name: "entity.name.function.macro.definition.erlang"},
             5 => {name: "punctuation.definition.parameters.begin.erlang"}},
           end: "(\\))\\s*(,)",
           endCaptures: 
            {1 => {name: "punctuation.definition.parameters.end.erlang"},
             2 => {name: "punctuation.separator.parameters.erlang"}},
           patterns: 
            [{match: /,/, name: "punctuation.separator.parameters.erlang"},
             {include: "#everything-else"}]},
          {match: /\|\||\||:|;|,|\.|->/,
           name: "punctuation.separator.define.erlang"},
          {include: "#everything-else"}]}]},
   directive: 
    {patterns: 
      [{begin: /^\s*+(?<_1>-)\s*+(?<_2>[a-z][a-zA-Z\d@_]*+)\s*+(?<_3>\()/,
        beginCaptures: 
         {1 => {name: "punctuation.section.directive.begin.erlang"},
          2 => {name: "keyword.control.directive.erlang"},
          3 => {name: "punctuation.definition.parameters.begin.erlang"}},
        end: "(\\))\\s*+(\\.)",
        endCaptures: 
         {1 => {name: "punctuation.definition.parameters.end.erlang"},
          2 => {name: "punctuation.section.directive.end.erlang"}},
        name: "meta.directive.erlang",
        patterns: [{include: "#everything-else"}]},
       {captures: 
         {1 => {name: "punctuation.section.directive.begin.erlang"},
          2 => {name: "keyword.control.directive.erlang"},
          3 => {name: "punctuation.section.directive.end.erlang"}},
        match: /^\s*+(?<_1>-)\s*+(?<_2>[a-z][a-zA-Z\d@_]*+)\s*+(?<_3>\.)/,
        name: "meta.directive.erlang"}]},
   :"everything-else" => 
    {patterns: 
      [{include: "#comment"},
       {include: "#record-usage"},
       {include: "#macro-usage"},
       {include: "#expression"},
       {include: "#keyword"},
       {include: "#textual-operator"},
       {include: "#function-call"},
       {include: "#tuple"},
       {include: "#list"},
       {include: "#binary"},
       {include: "#parenthesized-expression"},
       {include: "#character"},
       {include: "#number"},
       {include: "#atom"},
       {include: "#string"},
       {include: "#symbolic-operator"},
       {include: "#variable"}]},
   expression: 
    {patterns: 
      [{begin: /\b(?<_1>if)\b/,
        beginCaptures: {1 => {name: "keyword.control.if.erlang"}},
        end: "\\b(end)\\b",
        endCaptures: {1 => {name: "keyword.control.end.erlang"}},
        name: "meta.expression.if.erlang",
        patterns: 
         [{include: "#internal-expression-punctuation"},
          {include: "#everything-else"}]},
       {begin: /\b(?<_1>case)\b/,
        beginCaptures: {1 => {name: "keyword.control.case.erlang"}},
        end: "\\b(end)\\b",
        endCaptures: {1 => {name: "keyword.control.end.erlang"}},
        name: "meta.expression.case.erlang",
        patterns: 
         [{include: "#internal-expression-punctuation"},
          {include: "#everything-else"}]},
       {begin: /\b(?<_1>receive)\b/,
        beginCaptures: {1 => {name: "keyword.control.receive.erlang"}},
        end: "\\b(end)\\b",
        endCaptures: {1 => {name: "keyword.control.end.erlang"}},
        name: "meta.expression.receive.erlang",
        patterns: 
         [{include: "#internal-expression-punctuation"},
          {include: "#everything-else"}]},
       {captures: 
         {1 => {name: "keyword.control.fun.erlang"},
          3 => {name: "entity.name.type.class.module.erlang"},
          4 => {name: "punctuation.separator.module-function.erlang"},
          5 => {name: "entity.name.function.erlang"},
          6 => {name: "punctuation.separator.function-arity.erlang"}},
        match: 
         /\b(?<_1>fun)\s*+(?<_2>(?<_3>[a-z][a-zA-Z\d@_]*+)\s*+(?<_4>:)\s*+)?(?<_5>[a-z][a-zA-Z\d@_]*+)\s*(?<_6>\/)/},
       {begin: /\b(?<_1>fun)\b/,
        beginCaptures: {1 => {name: "keyword.control.fun.erlang"}},
        end: "\\b(end)\\b",
        endCaptures: {1 => {name: "keyword.control.end.erlang"}},
        name: "meta.expression.fun.erlang",
        patterns: 
         [{begin: /(?=\()/,
           end: "(;)|(?=\\bend\\b)",
           endCaptures: {1 => {name: "punctuation.separator.clauses.erlang"}},
           patterns: [{include: "#internal-function-parts"}]},
          {include: "#everything-else"}]},
       {begin: /\b(?<_1>try)\b/,
        beginCaptures: {1 => {name: "keyword.control.try.erlang"}},
        end: "\\b(end)\\b",
        endCaptures: {1 => {name: "keyword.control.end.erlang"}},
        name: "meta.expression.try.erlang",
        patterns: 
         [{include: "#internal-expression-punctuation"},
          {include: "#everything-else"}]},
       {begin: /\b(?<_1>begin)\b/,
        beginCaptures: {1 => {name: "keyword.control.begin.erlang"}},
        end: "\\b(end)\\b",
        endCaptures: {1 => {name: "keyword.control.end.erlang"}},
        name: "meta.expression.begin.erlang",
        patterns: 
         [{include: "#internal-expression-punctuation"},
          {include: "#everything-else"}]},
       {begin: /\b(?<_1>query)\b/,
        beginCaptures: {1 => {name: "keyword.control.query.erlang"}},
        end: "\\b(end)\\b",
        endCaptures: {1 => {name: "keyword.control.end.erlang"}},
        name: "meta.expression.query.erlang",
        patterns: [{include: "#everything-else"}]}]},
   function: 
    {begin: /^\s*+(?<_1>[a-z][a-zA-Z\d@_]*+)\s*+(?=\()/,
     beginCaptures: {1 => {name: "entity.name.function.definition.erlang"}},
     end: "(\\.)",
     endCaptures: {1 => {name: "punctuation.terminator.function.erlang"}},
     name: "meta.function.erlang",
     patterns: 
      [{captures: {1 => {name: "entity.name.function.erlang"}},
        match: /^\s*+(?<_1>[a-z][a-zA-Z\d@_]*+)\s*+(?=\()/},
       {begin: /(?=\()/,
        end: "(;)|(?=\\.)",
        endCaptures: {1 => {name: "punctuation.separator.clauses.erlang"}},
        patterns: 
         [{include: "#parenthesized-expression"},
          {include: "#internal-function-parts"}]},
       {include: "#everything-else"}]},
   :"function-call" => 
    {begin: 
      /(?=[a-z][a-zA-Z\d@_]*+\s*+(?<_1>\(|:\s*+[a-z][a-zA-Z\d@_]*+\s*+\())/,
     end: "(\\))",
     endCaptures: 
      {1 => {name: "punctuation.definition.parameters.end.erlang"}},
     name: "meta.function-call.erlang",
     patterns: 
      [{begin: 
         /(?<_1>(?<_2>erlang)\s*+(?<_3>:)\s*+)?(?<_4>is_atom|is_binary|is_constant|is_float|is_function|is_integer|is_list|is_number|is_pid|is_port|is_reference|is_tuple|is_record|abs|element|hd|length|node|round|self|size|tl|trunc)\s*+(?<_5>\()/,
        beginCaptures: 
         {2 => {name: "entity.name.type.class.module.erlang"},
          3 => {name: "punctuation.separator.module-function.erlang"},
          4 => {name: "entity.name.function.guard.erlang"},
          5 => {name: "punctuation.definition.parameters.begin.erlang"}},
        end: "(?=\\))",
        patterns: 
         [{match: /,/, name: "punctuation.separator.parameters.erlang"},
          {include: "#everything-else"}]},
       {begin: 
         /(?<_1>(?<_2>[a-z][a-zA-Z\d@_]*+)\s*+(?<_3>:)\s*+)?(?<_4>[a-z][a-zA-Z\d@_]*+)\s*+(?<_5>\()/,
        beginCaptures: 
         {2 => {name: "entity.name.type.class.module.erlang"},
          3 => {name: "punctuation.separator.module-function.erlang"},
          4 => {name: "entity.name.function.erlang"},
          5 => {name: "punctuation.definition.parameters.begin.erlang"}},
        end: "(?=\\))",
        patterns: 
         [{match: /,/, name: "punctuation.separator.parameters.erlang"},
          {include: "#everything-else"}]}]},
   :"import-export-directive" => 
    {patterns: 
      [{begin: 
         /^\s*+(?<_1>-)\s*+(?<_2>import)\s*+(?<_3>\()\s*+(?<_4>[a-z][a-zA-Z\d@_]*+)\s*+(?<_5>,)/,
        beginCaptures: 
         {1 => {name: "punctuation.section.directive.begin.erlang"},
          2 => {name: "keyword.control.directive.import.erlang"},
          3 => {name: "punctuation.definition.parameters.begin.erlang"},
          4 => {name: "entity.name.type.class.module.erlang"},
          5 => {name: "punctuation.separator.parameters.erlang"}},
        end: "(\\))\\s*+(\\.)",
        endCaptures: 
         {1 => {name: "punctuation.definition.parameters.end.erlang"},
          2 => {name: "punctuation.section.directive.end.erlang"}},
        name: "meta.directive.import.erlang",
        patterns: [{include: "#internal-function-list"}]},
       {begin: /^\s*+(?<_1>-)\s*+(?<_2>export)\s*+(?<_3>\()/,
        beginCaptures: 
         {1 => {name: "punctuation.section.directive.begin.erlang"},
          2 => {name: "keyword.control.directive.export.erlang"},
          3 => {name: "punctuation.definition.parameters.begin.erlang"}},
        end: "(\\))\\s*+(\\.)",
        endCaptures: 
         {1 => {name: "punctuation.definition.parameters.end.erlang"},
          2 => {name: "punctuation.section.directive.end.erlang"}},
        name: "meta.directive.export.erlang",
        patterns: [{include: "#internal-function-list"}]}]},
   :"internal-expression-punctuation" => 
    {captures: 
      {1 => {name: "punctuation.separator.clause-head-body.erlang"},
       2 => {name: "punctuation.separator.clauses.erlang"},
       3 => {name: "punctuation.separator.expressions.erlang"}},
     match: /(?<_1>->)|(?<_2>;)|(?<_3>,)/},
   :"internal-function-list" => 
    {begin: /(?<_1>\[)/,
     beginCaptures: {1 => {name: "punctuation.definition.list.begin.erlang"}},
     end: "(\\])",
     endCaptures: {1 => {name: "punctuation.definition.list.end.erlang"}},
     name: "meta.structure.list.function.erlang",
     patterns: 
      [{begin: /(?<_1>[a-z][a-zA-Z\d@_]*+)\s*+(?<_2>\/)/,
        beginCaptures: 
         {1 => {name: "entity.name.function.erlang"},
          2 => {name: "punctuation.separator.function-arity.erlang"}},
        end: "(,)|(?=\\])",
        endCaptures: {1 => {name: "punctuation.separator.list.erlang"}},
        patterns: [{include: "#everything-else"}]},
       {include: "#everything-else"}]},
   :"internal-function-parts" => 
    {patterns: 
      [{begin: /(?=\()/,
        end: "(->)",
        endCaptures: 
         {1 => {name: "punctuation.separator.clause-head-body.erlang"}},
        patterns: 
         [{begin: /(?<_1>\()/,
           beginCaptures: 
            {1 => {name: "punctuation.definition.parameters.begin.erlang"}},
           end: "(\\))",
           endCaptures: 
            {1 => {name: "punctuation.definition.parameters.end.erlang"}},
           patterns: 
            [{match: /,/, name: "punctuation.separator.parameters.erlang"},
             {include: "#everything-else"}]},
          {match: /,|;/, name: "punctuation.separator.guards.erlang"},
          {include: "#everything-else"}]},
       {match: /,/, name: "punctuation.separator.expressions.erlang"},
       {include: "#everything-else"}]},
   :"internal-record-body" => 
    {begin: /(?<_1>\{)/,
     beginCaptures: 
      {1 => {name: "punctuation.definition.class.record.begin.erlang"}},
     end: "(?=\\})",
     name: "meta.structure.record.erlang",
     patterns: 
      [{begin: /(?<_1>(?<_2>[a-z][a-zA-Z\d@_]*+)|(?<_3>_))\s*+(?<_4>=)/,
        beginCaptures: 
         {2 => {name: "variable.other.field.erlang"},
          3 => {name: "variable.language.omitted.field.erlang"},
          4 => {name: "keyword.operator.assignment.erlang"}},
        end: "(,)|(?=\\})",
        endCaptures: 
         {1 => {name: "punctuation.separator.class.record.erlang"}},
        patterns: [{include: "#everything-else"}]},
       {captures: 
         {1 => {name: "variable.other.field.erlang"},
          2 => {name: "punctuation.separator.class.record.erlang"}},
        match: /(?<_1>[a-z][a-zA-Z\d@_]*+)\s*+(?<_2>,)?/},
       {include: "#everything-else"}]},
   :"internal-type-specifiers" => 
    {begin: /(?<_1>\/)/,
     beginCaptures: {1 => {name: "punctuation.separator.value-type.erlang"}},
     end: "(?=,|:|>>)",
     patterns: 
      [{captures: 
         {1 => {name: "storage.type.erlang"},
          2 => {name: "storage.modifier.signedness.erlang"},
          3 => {name: "storage.modifier.endianness.erlang"},
          4 => {name: "storage.modifier.unit.erlang"},
          5 => {name: "punctuation.separator.type-specifiers.erlang"}},
        match: 
         /(?<_1>integer|float|binary)|(?<_2>signed|unsigned)|(?<_3>big|little|native)|(?<_4>unit)|(?<_5>-)/}]},
   keyword: 
    {match: 
      /\b(?<_1>after|begin|case|catch|cond|end|fun|if|let|of|query|try|receive|when)\b/,
     name: "keyword.control.erlang"},
   list: 
    {begin: /(?<_1>\[)/,
     beginCaptures: {1 => {name: "punctuation.definition.list.begin.erlang"}},
     end: "(\\])",
     endCaptures: {1 => {name: "punctuation.definition.list.end.erlang"}},
     name: "meta.structure.list.erlang",
     patterns: 
      [{match: /\||\|\||,/, name: "punctuation.separator.list.erlang"},
       {include: "#everything-else"}]},
   :"macro-directive" => 
    {patterns: 
      [{captures: 
         {1 => {name: "punctuation.section.directive.begin.erlang"},
          2 => {name: "keyword.control.directive.ifdef.erlang"},
          3 => {name: "punctuation.definition.parameters.begin.erlang"},
          4 => {name: "entity.name.function.macro.erlang"},
          5 => {name: "punctuation.definition.parameters.end.erlang"},
          6 => {name: "punctuation.section.directive.end.erlang"}},
        match: 
         /^\s*+(?<_1>-)\s*+(?<_2>ifdef)\s*+(?<_3>\()\s*+(?<_4>[a-zA-z\d@_]++)\s*+(?<_5>\))\s*+(?<_6>\.)/,
        name: "meta.directive.ifdef.erlang"},
       {captures: 
         {1 => {name: "punctuation.section.directive.begin.erlang"},
          2 => {name: "keyword.control.directive.ifndef.erlang"},
          3 => {name: "punctuation.definition.parameters.begin.erlang"},
          4 => {name: "entity.name.function.macro.erlang"},
          5 => {name: "punctuation.definition.parameters.end.erlang"},
          6 => {name: "punctuation.section.directive.end.erlang"}},
        match: 
         /^\s*+(?<_1>-)\s*+(?<_2>ifndef)\s*+(?<_3>\()\s*+(?<_4>[a-zA-z\d@_]++)\s*+(?<_5>\))\s*+(?<_6>\.)/,
        name: "meta.directive.ifndef.erlang"},
       {captures: 
         {1 => {name: "punctuation.section.directive.begin.erlang"},
          2 => {name: "keyword.control.directive.undef.erlang"},
          3 => {name: "punctuation.definition.parameters.begin.erlang"},
          4 => {name: "entity.name.function.macro.erlang"},
          5 => {name: "punctuation.definition.parameters.end.erlang"},
          6 => {name: "punctuation.section.directive.end.erlang"}},
        match: 
         /^\s*+(?<_1>-)\s*+(?<_2>undef)\s*+(?<_3>\()\s*+(?<_4>[a-zA-z\d@_]++)\s*+(?<_5>\))\s*+(?<_6>\.)/,
        name: "meta.directive.undef.erlang"}]},
   :"macro-usage" => 
    {captures: 
      {1 => {name: "keyword.operator.macro.erlang"},
       2 => {name: "entity.name.function.macro.erlang"}},
     match: /(?<_1>\?\??)\s*+(?<_2>[a-zA-Z\d@_]++)/,
     name: "meta.macro-usage.erlang"},
   :"module-directive" => 
    {captures: 
      {1 => {name: "punctuation.section.directive.begin.erlang"},
       2 => {name: "keyword.control.directive.module.erlang"},
       3 => {name: "punctuation.definition.parameters.begin.erlang"},
       4 => {name: "entity.name.type.class.module.definition.erlang"},
       5 => {name: "punctuation.definition.parameters.end.erlang"},
       6 => {name: "punctuation.section.directive.end.erlang"}},
     match: 
      /^\s*+(?<_1>-)\s*+(?<_2>module)\s*+(?<_3>\()\s*+(?<_4>[a-z][a-zA-Z\d@_]*+)\s*+(?<_5>\))\s*+(?<_6>\.)/,
     name: "meta.directive.module.erlang"},
   number: 
    {begin: /(?=\d)/,
     end: "(?!\\d)",
     patterns: 
      [{captures: 
         {1 => {name: "punctuation.separator.integer-float.erlang"},
          3 => {name: "punctuation.separator.float-exponent.erlang"}},
        match: /\d++(?<_1>\.)\d++(?<_2>(?<_3>[eE][\+\-])?\d++)?/,
        name: "constant.numeric.float.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /2(?<_1>#)[0-1]++/,
        name: "constant.numeric.integer.binary.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /3(?<_1>#)[0-2]++/,
        name: "constant.numeric.integer.base-3.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /4(?<_1>#)[0-3]++/,
        name: "constant.numeric.integer.base-4.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /5(?<_1>#)[0-4]++/,
        name: "constant.numeric.integer.base-5.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /6(?<_1>#)[0-5]++/,
        name: "constant.numeric.integer.base-6.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /7(?<_1>#)[0-6]++/,
        name: "constant.numeric.integer.base-7.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /8(?<_1>#)[0-7]++/,
        name: "constant.numeric.integer.octal.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /9(?<_1>#)[0-8]++/,
        name: "constant.numeric.integer.base-9.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /10(?<_1>#)\d++/,
        name: "constant.numeric.integer.decimal.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /11(?<_1>#)[\daA]++/,
        name: "constant.numeric.integer.base-11.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /12(?<_1>#)[\da-bA-B]++/,
        name: "constant.numeric.integer.base-12.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /13(?<_1>#)[\da-cA-C]++/,
        name: "constant.numeric.integer.base-13.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /14(?<_1>#)[\da-dA-D]++/,
        name: "constant.numeric.integer.base-14.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /15(?<_1>#)[\da-eA-E]++/,
        name: "constant.numeric.integer.base-15.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /16(?<_1>#)\h++/,
        name: "constant.numeric.integer.hexadecimal.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /17(?<_1>#)[\da-gA-G]++/,
        name: "constant.numeric.integer.base-17.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /18(?<_1>#)[\da-hA-H]++/,
        name: "constant.numeric.integer.base-18.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /19(?<_1>#)[\da-iA-I]++/,
        name: "constant.numeric.integer.base-19.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /20(?<_1>#)[\da-jA-J]++/,
        name: "constant.numeric.integer.base-20.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /21(?<_1>#)[\da-kA-K]++/,
        name: "constant.numeric.integer.base-21.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /22(?<_1>#)[\da-lA-L]++/,
        name: "constant.numeric.integer.base-22.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /23(?<_1>#)[\da-mA-M]++/,
        name: "constant.numeric.integer.base-23.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /24(?<_1>#)[\da-nA-N]++/,
        name: "constant.numeric.integer.base-24.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /25(?<_1>#)[\da-oA-O]++/,
        name: "constant.numeric.integer.base-25.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /26(?<_1>#)[\da-pA-P]++/,
        name: "constant.numeric.integer.base-26.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /27(?<_1>#)[\da-qA-Q]++/,
        name: "constant.numeric.integer.base-27.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /28(?<_1>#)[\da-rA-R]++/,
        name: "constant.numeric.integer.base-28.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /29(?<_1>#)[\da-sA-S]++/,
        name: "constant.numeric.integer.base-29.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /30(?<_1>#)[\da-tA-T]++/,
        name: "constant.numeric.integer.base-30.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /31(?<_1>#)[\da-uA-U]++/,
        name: "constant.numeric.integer.base-31.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /32(?<_1>#)[\da-vA-V]++/,
        name: "constant.numeric.integer.base-32.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /33(?<_1>#)[\da-wA-W]++/,
        name: "constant.numeric.integer.base-33.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /34(?<_1>#)[\da-xA-X]++/,
        name: "constant.numeric.integer.base-34.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /35(?<_1>#)[\da-yA-Y]++/,
        name: "constant.numeric.integer.base-35.erlang"},
       {captures: {1 => {name: "punctuation.separator.base-integer.erlang"}},
        match: /36(?<_1>#)[\da-zA-Z]++/,
        name: "constant.numeric.integer.base-36.erlang"},
       {match: /\d++#[\da-zA-Z]++/, name: "invalid.illegal.integer.erlang"},
       {match: /\d++/, name: "constant.numeric.integer.decimal.erlang"}]},
   :"parenthesized-expression" => 
    {begin: /(?<_1>\()/,
     beginCaptures: 
      {1 => {name: "punctuation.section.expression.begin.erlang"}},
     end: "(\\))",
     endCaptures: {1 => {name: "punctuation.section.expression.end.erlang"}},
     name: "meta.expression.parenthesized",
     patterns: [{include: "#everything-else"}]},
   :"record-directive" => 
    {begin: 
      /^\s*+(?<_1>-)\s*+(?<_2>record)\s*+(?<_3>\()\s*+(?<_4>[a-z][a-zA-Z\d@_]*+)\s*+(?<_5>,)/,
     beginCaptures: 
      {1 => {name: "punctuation.section.directive.begin.erlang"},
       2 => {name: "keyword.control.directive.import.erlang"},
       3 => {name: "punctuation.definition.parameters.begin.erlang"},
       4 => {name: "entity.name.type.class.record.definition.erlang"},
       5 => {name: "punctuation.separator.parameters.erlang"}},
     end: "((\\}))\\s*+(\\))\\s*+(\\.)",
     endCaptures: 
      {1 => {name: "meta.structure.record.erlang"},
       2 => {name: "punctuation.definition.class.record.end.erlang"},
       3 => {name: "punctuation.definition.parameters.end.erlang"},
       4 => {name: "punctuation.section.directive.end.erlang"}},
     name: "meta.directive.record.erlang",
     patterns: [{include: "#internal-record-body"}]},
   :"record-usage" => 
    {patterns: 
      [{captures: 
         {1 => {name: "keyword.operator.record.erlang"},
          2 => {name: "entity.name.type.class.record.erlang"},
          3 => {name: "punctuation.separator.record-field.erlang"},
          4 => {name: "variable.other.field.erlang"}},
        match: 
         /(?<_1>#)\s*+(?<_2>[a-z][a-zA-Z\d@_]*+)\s*+(?<_3>\.)\s*+(?<_4>[a-z][a-zA-Z\d@_]*+)/,
        name: "meta.record-usage.erlang"},
       {begin: /(?<_1>#)\s*+(?<_2>[a-z][a-zA-Z\d@_]*+)/,
        beginCaptures: 
         {1 => {name: "keyword.operator.record.erlang"},
          2 => {name: "entity.name.type.class.record.erlang"}},
        end: "((\\}))",
        endCaptures: 
         {1 => {name: "meta.structure.record.erlang"},
          2 => {name: "punctuation.definition.class.record.end.erlang"}},
        name: "meta.record-usage.erlang",
        patterns: [{include: "#internal-record-body"}]}]},
   string: 
    {begin: /(?<_1>")/,
     beginCaptures: 
      {1 => {name: "punctuation.definition.string.begin.erlang"}},
     end: "(\")",
     endCaptures: {1 => {name: "punctuation.definition.string.end.erlang"}},
     name: "string.quoted.double.erlang",
     patterns: 
      [{captures: 
         {1 => {name: "punctuation.definition.escape.erlang"},
          3 => {name: "punctuation.definition.escape.erlang"}},
        match: /(?<_1>\\)(?<_2>[bdefnrstv\\'"]|(?<_3>\^)[@-_]|[0-7]{1,3})/,
        name: "constant.character.escape.erlang"},
       {match: /\\\^?.?/, name: "invalid.illegal.string.erlang"},
       {captures: 
         {1 => {name: "punctuation.definition.placeholder.erlang"},
          10 => {name: "punctuation.separator.placeholder-parts.erlang"},
          12 => {name: "punctuation.separator.placeholder-parts.erlang"},
          3 => {name: "punctuation.separator.placeholder-parts.erlang"},
          4 => {name: "punctuation.separator.placeholder-parts.erlang"},
          6 => {name: "punctuation.separator.placeholder-parts.erlang"},
          8 => {name: "punctuation.separator.placeholder-parts.erlang"}},
        match: 
         /(?<_1>~)(?<_2>(?<_3>\-)?\d++|(?<_4>\*))?(?<_5>(?<_6>\.)(?<_7>\d++|(?<_8>\*)))?(?<_9>(?<_10>\.)(?<_11>(?<_12>\*)|.))?[~cfegswpWPBX#bx\+ni]/,
        name: "constant.other.placeholder.erlang"},
       {captures: 
         {1 => {name: "punctuation.definition.placeholder.erlang"},
          2 => {name: "punctuation.separator.placeholder-parts.erlang"}},
        match: /(?<_1>~)(?<_2>\*)?(?<_3>\d++)?[~du\-#fsacl]/,
        name: "constant.other.placeholder.erlang"},
       {match: /~.?/, name: "invalid.illegal.string.erlang"}]},
   :"symbolic-operator" => 
    {match: /\+\+|\+|--|-|\*|\/=|\/|=\/=|=:=|==|=<|=|<-|<|>=|>|!/,
     name: "keyword.operator.symbolic.erlang"},
   :"textual-operator" => 
    {match: 
      /\b(?<_1>andalso|band|and|bxor|xor|bor|orelse|or|bnot|not|bsl|bsr|div|rem)\b/,
     name: "keyword.operator.textual.erlang"},
   tuple: 
    {begin: /(?<_1>\{)/,
     beginCaptures: {1 => {name: "punctuation.definition.tuple.begin.erlang"}},
     end: "(\\})",
     endCaptures: {1 => {name: "punctuation.definition.tuple.end.erlang"}},
     name: "meta.structure.tuple.erlang",
     patterns: 
      [{match: /,/, name: "punctuation.separator.tuple.erlang"},
       {include: "#everything-else"}]},
   variable: 
    {captures: 
      {1 => {name: "variable.other.erlang"},
       2 => {name: "variable.language.omitted.erlang"}},
     match: /(?<_1>_[a-zA-Z\d@_]++|[A-Z][a-zA-Z\d@_]*+)|(?<_2>_)/}},
 scopeName: "source.erlang",
 uuid: "58EA597D-5158-4BF7-9FB2-B05135D1E166"}
