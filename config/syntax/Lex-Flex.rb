# Encoding: UTF-8

{fileTypes: ["l"],
 foldingStartMarker: /\/\*\*|\{\s*$/,
 foldingStopMarker: /\*\*\/|^\s*\}/,
 keyEquivalent: "^~L",
 name: "Lex/Flex",
 patterns: 
  [{begin: /\A(?!%%$)/,
    comment: "first section of the file - definitions",
    end: "^(?=%%$)",
    name: "meta.section.definitions.lex",
    patterns: 
     [{include: "#includes"},
      {begin: /\/\*/, end: "\\*/|$", name: "comment.block.c.lex"},
      {begin: /^(?i)(?<_1>[a-z_][a-z0-9_-]*)(?=\s|$)/,
       beginCaptures: {1 => {name: "entity.name.function.lex"}},
       end: "$",
       name: "meta.definition.lex",
       patterns: [{include: "#regexp"}]},
      {begin: /^(?<_1>%[sx])(?=\s|$)/,
       beginCaptures: 
        {1 => {name: "punctuation.definition.start-condition.lex"}},
       end: "$",
       name: "meta.start-condition.lex",
       patterns: 
        [{match: /(?i)[a-z_][a-z0-9_-]*/},
         {match: /\S/, name: "invalid.illegal.lex"}]},
      {begin: /^(?<_1>%option)\s(?=\S)/,
       beginCaptures: {1 => {name: "keyword.other.option.lex"}},
       end: "$",
       name: "meta.options.lex",
       patterns: 
        [{match: 
           /\b(?:(?:no)?(?:[78]bit|align|backup|batch|c\+\+|debug|default|ecs|fast|full|interactive|lex-compat|meta-ecs|perf-report|read|stdout|verbose|warn|array|pointer|input|unput|yy_(?:(?:push|pop|top)_state|scan_(?:buffer|bytes|string))|main|stack|stdinit|yylineno|yywrap)|(?:case(?:ful|less)|case-(?:in)?sensitive|(?:always|never)-interactive))\b/,
          name: "support.other.option.lex"}]},
      {begin: /^%(?:array|pointer)/,
       end: "$",
       name: "keyword.other.option.lex",
       patterns: [{match: /\S/, name: "invalid.illegal.lex"}]}]},
   {begin: /^(?<_1>%%)$/,
    beginCaptures: {1 => {name: "punctuation.separator.sections.lex"}},
    end: "\\Z.\\A(?# never end)",
    patterns: 
     [{begin: /^(?!%%$)/,
       comment: "second section of the file - rules",
       end: "^(?=%%$)",
       name: "meta.section.rules.lex",
       patterns: 
        [{begin: /^(?!$)/,
          end: "$",
          name: "meta.rule.lex",
          patterns: 
           [{include: "#includes"},
            {begin: 
              /(?i)^(?<_1><(?:(?:[a-z_][a-z0-9_-]*,)*[a-z_][a-z0-9_-]|\*)>)?(?:(?<_2><<EOF>>)(?<_3>\s*))?(?=\S)/,
             beginCaptures: 
              {1 => {name: "keyword.other.start-condition.lex"},
               2 => {name: "keyword.operator.eof.lex"},
               3 => {name: "invalid.illegal.regexp.lex"}},
             comment: "rule pattern",
             end: "(?=\\s)|$",
             patterns: [{include: "#regexp"}]},
            {begin: /(?<_1>%\{)/,
             beginCaptures: {1 => {name: "punctuation.definition.code.lex"}},
             comment: "TODO: %} should override embedded scopes",
             end: "(%\\})(.*)",
             endCaptures: 
              {1 => {name: "punctuation.terminator.code.lex"},
               2 => {name: "invalid.illegal.ignored.lex"}},
             patterns: [{include: "#csource"}]},
            {begin: /(?=\S)/,
             comment: "TODO: eol should override embedded scopes",
             end: "$",
             name: "meta.rule.action.lex",
             patterns: [{include: "#csource"}]}]}]},
      {begin: /^(?<_1>%%)$/,
       beginCaptures: {1 => {name: "punctuation.separator.sections.lex"}},
       comment: "third section of the file - user code",
       contentName: "meta.section.user-code.lex",
       end: "\\Z.\\A(?# never end)",
       patterns: [{include: "#csource"}]}]}],
 repository: 
  {csource: 
    {patterns: 
      [{match: 
         /\b(?:ECHO|BEGIN|REJECT|YY_FLUSH_BUFFER|YY_BREAK|yy(?:more|less|unput|input|terminate|text|leng|restart|_(?:push|pop|top)_state|_(?:create|switch_to|flush|delete)_buffer|_scan_(?:string|bytes|buffer)|_set_(?:bol|interactive))(?=\(|$))\b/,
        name: "support.function.c.lex"},
       {include: "source.c"}]},
   includes: 
    {patterns: 
      [{begin: /^%\{$/,
        comment: "TODO: $} should override the embedded scopes",
        end: "^%\\}$",
        name: "meta.embedded.source.c.lex",
        patterns: [{include: "source.c"}]},
       {begin: /^[ \t]+/,
        comment: "TODO: eol should override the embedded scopes",
        end: "$",
        name: "meta.embedded.source.c.lex",
        patterns: [{include: "source.c"}]}]},
   re_escape: 
    {match: /\\(?i:[0-9]{1,3}|x[0-9a-f]{1,2}|.)/,
     name: "constant.character.escape.lex"},
   rec_csource: 
    {begin: /\{/,
     end: "\\}",
     patterns: [{include: "source.c"}, {include: "#csource"}]},
   regexp: 
    {begin: /\G(?=\S)(?<_1>\^)?/,
     captures: {1 => {name: "keyword.control.anchor.regexp.lex"}},
     end: "(\\$)?(?:(?=\\s)|$)",
     name: "string.regexp.lex",
     patterns: [{include: "#subregexp"}]},
   subregexp: 
    {patterns: 
      [{include: "#re_escape"},
       {begin: /(?<_1>\[)(?<_2>\^)?-?/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.character-class.set.lex"},
          2 => {name: "keyword.operator.negation.regexp.lex"}},
        end: "-?(\\])",
        endCaptures: 
         {1 => {name: "punctuation.terminator.character-class.set.lex"}},
        name: "constant.other.character-class.set.lex",
        patterns: 
         [{include: "#re_escape"},
          {captures: {1 => {name: "invalid.illegal.regexp.lex"}},
           match: 
            /\[:(?:(?:alnum|alpha|blank|cntrl|x?digit|graph|lower|print|punct|space|upper)|(?<_1>.*?)):\]/,
           name: "constant.other.character-class.set.lex"}]},
       {match: /(?i){[a-z_][a-z0-9_-]*}/, name: "variable.other.lex"},
       {begin: /\{/,
        end: "\\}",
        name: "keyword.operator.quantifier.regexp.lex",
        patterns: 
         [{match: /(?<=\{)[0-9]*(?:,[0-9]*)?(?=\})/},
          {comment: "{3} counts should only have digit[,digit]",
           match: /[^}]/,
           name: "invalid.illegal.regexp.lex"}]},
       {begin: /"/,
        end: "\"",
        name: "string.quoted.double.regexp.lex",
        patterns: [{include: "#re_escape"}]},
       {begin: /(?<_1>[*+?])(?=[*+?])/,
        beginCaptures: {1 => {name: "keyword.operator.quantifier.regexp.lex"}},
        comment: "make ** or +? or other combinations illegal",
        end: "(?=[^*+?])",
        patterns: [{match: /./, name: "invalid.illegal.regexp.lex"}]},
       {match: /[*+?]/, name: "keyword.operator.quantifier.regexp.lex"},
       {comment: "<<EOF>> is handled in the rule pattern",
        match: /<<EOF>>/,
        name: "invalid.illegal.regexp.lex"},
       {begin: /(?<_1>\()/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.group.regexp.lex"}},
        end: "(\\))|(?=\\s)|$(?#end on whitespace because regex does)",
        endCaptures: {1 => {name: "punctuation.terminator.group.regexp.lex"}},
        name: "meta.group.regexp.lex",
        patterns: 
         [{match: /\//, name: "invalid.illegal.regexp.lex"},
          {include: "#subregexp"}]},
       {begin: /(?<_1>\/)/,
        beginCaptures: 
         {1 => {name: "keyword.operator.trailing-match.regexp.lex"}},
        comment: "detection of multiple trailing contexts",
        end: "(?=\\s)|$",
        patterns: 
         [{match: /\/|\$(?!\S)/, name: "invalid.illegal.regexp.lex"},
          {include: "#subregexp"}]}]}},
 scopeName: "source.lex",
 uuid: "92E842A0-9DE6-4D31-A6AC-1CDE0F9547C5"}
