# Encoding: UTF-8

{comment: 
  "TODO:\n• Try to improve parameters list syntax – scope numbers, ‘=’, ‘,’ and possibly be intelligent about entity ordering\n• Is meta.function-call the correct scope? I've added it to my theme but by default it's not highlighted",
 firstLineMatch: "^#!.*(?<!-)php[0-9]{0,1}\\b",
 foldingStartMarker: /(?<_1>\/\*|\{\s*$|<<<HTML)/,
 foldingStopMarker: /(?<_1>\*\/|^\s*\}|^HTML;)/,
 name: "PHP",
 patterns: 
  [{captures: 
     {1 => {name: "punctuation.whitespace.embedded.leading.php"},
      2 => {name: "source.php.embedded.line.empty.html"},
      3 => {name: "punctuation.section.embedded.begin.php"},
      4 => {name: "meta.consecutive-tags.php"},
      5 => {name: "source.php"},
      6 => {name: "punctuation.section.embedded.end.php"},
      7 => {name: "source.php"},
      8 => {name: "punctuation.whitespace.embedded.trailing.php"}},
    comment: "Matches empty tags.",
    match: 
     /(?x)
	(?<_1>^\s*)?							# 1 - Leading whitespace
	(?<_2>							# 2 - meta.embedded.line.empty.php
	(?<_3>						# 3 - Open Tag
	(?:
	(?<_4>(?<=\?>)<)		# 4 - Consecutive tags
	  | <
	)
	\?(?i:php|=)?
	)
	(?<_5>\s*)				# 5 - Loneliness
	(?<_6>(?<_7>\?)>)					# 6 - Close Tag
	# 7 - Scope ? as scope.php
	)
	(?<_8>
	\k<_1>							# Match nothing if there was no
	#   leading whitespace...
	  | (?<_9>\s*$\n)?					# or match trailing whitespace.
	)
	/},
   {begin: /^\s*(?=<\?)/,
    beginCaptures: 
     {0 => {name: "punctuation.whitespace.embedded.leading.php"}},
    comment: "Catches tags with preceeding whitespace.",
    end: "(?<=\\?>)(\\s*$\\n)?",
    endCaptures: {0 => {name: "punctuation.whitespace.embedded.trailing.php"}},
    patterns: 
     [{begin: /<\?(?i:php|=)?/,
       beginCaptures: {0 => {name: "punctuation.section.embedded.begin.php"}},
       end: "(\\?)>",
       endCaptures: 
        {0 => {name: "punctuation.section.embedded.end.php"},
         1 => {name: "source.php"}},
       name: "source.php.embedded.block.html",
       patterns: [{include: "#language"}]}]},
   {begin: /(?<_1>(?<_2>(?<=\?>)<)|<)\?(?i:php|=)?/,
    beginCaptures: 
     {0 => {name: "punctuation.section.embedded.begin.php"},
      2 => {name: "meta.consecutive-tags.php"}},
    comment: "Catches the remainder.",
    end: "(\\?)>",
    endCaptures: 
     {0 => {name: "punctuation.section.embedded.end.php"},
      1 => {name: "source.php"}},
    name: "source.php.embedded.line.html",
    patterns: [{include: "#language"}]}],
 repository: 
  {constants: 
    {patterns: 
      [{match: 
         /(?i)\b(?<_1>TRUE|FALSE|NULL|__(?<_2>FILE|FUNCTION|CLASS|METHOD|LINE)__|ON|OFF|YES|NO|NL|BR|TAB)\b/,
        name: "constant.language.php"},
       {match: 
         /\b(?<_1>DEFAULT_INCLUDE_PATH|E_(?<_2>ALL|COMPILE_(?<_3>ERROR|WARNING)|CORE_(?<_4>ERROR|WARNING)|(?<_5>RECOVERABLE_)?ERROR|NOTICE|PARSE|STRICT|USER_(?<_6>ERROR|NOTICE|WARNING)|WARNING)|PEAR_(?<_7>EXTENSION_DIR|INSTALL_DIR)|PHP_(?<_8>BINDIR|CONFIG_FILE_PATH|DATADIR|E(?<_9>OL|XTENSION_DIR)|L(?<_10>IBDIR|OCALSTATEDIR)|O(?<_11>S|UTPUT_HANDLER_CONT|UTPUT_HANDLER_END|UTPUT_HANDLER_START)|SYSCONFDIR|VERSION))\b/,
        name: "support.constant.core.php"},
       {match: 
         /\b(?<_1>A(?<_2>B(?<_3>DAY_(?<_4>[1-7])|MON_(?<_5>[0-9]{1,2}))|LT_DIGITS|M_STR|SSERT_(?<_6>ACTIVE|BAIL|CALLBACK|QUIET_EVAL|WARNING))|C(?<_7>ASE_(?<_8>LOWER|UPPER)|HAR_MAX|O(?<_9>DESET|NNECTION_(?<_10>ABORTED|NORMAL|TIMEOUT)|UNT_(?<_11>NORMAL|RECURSIVE))|REDITS_(?<_12>ALL|DOCS|FULLPAGE|GENERAL|GROUP|MODULES|QA|SAPI)|RNCYSTR|RYPT_(?<_13>BLOWFISH|EXT_DES|MD5|SALT_LENGTH|STD_DES)|URRENCY_SYMBOL)|D(?<_14>AY_(?<_15>[1-7])|ECIMAL_POINT|IRECTORY_SEPARATOR|_(?<_16>FMT|T_FMT))|E(?<_17>NT_(?<_18>COMPAT|NOQUOTES|QUOTES)|RA(?<_19>|_D_FMT|_D_T_FMT|_T_FMT|_YEAR)|XTR_(?<_20>IF_EXISTS|OVERWRITE|PREFIX_(?<_21>ALL|IF_EXISTS|INVALID|SAME)|SKIP))|FRAC_DIGITS|GROUPING|HTML_(?<_22>ENTITIES|SPECIALCHARS)|IN(?<_23>FO_(?<_24>ALL|CONFIGURATION|CREDITS|ENVIRONMENT|GENERAL|LICENSE|MODULES|VARIABLES)|I_(?<_25>ALL|PERDIR|SYSTEM|USER)|T_(?<_26>CURR_SYMBOL|FRAC_DIGITS))|L(?<_27>C_(?<_28>ALL|COLLATE|CTYPE|MESSAGES|MONETARY|NUMERIC|TIME)|O(?<_29>CK_(?<_30>EX|NB|SH|UN)|G_(?<_31>ALERT|AUTH(?<_32>|PRIV)|CONS|CRIT|CRON|DAEMON|DEBUG|EMERG|ERR|INFO|KERN|LOCAL(?<_33>[0-7])|LPR|MAIL|NDELAY|NEWS|NOTICE|NOWAIT|ODELAY|PERROR|PID|SYSLOG|USER|UUCP|WARNING)))|M(?<_34>ON_(?<_35>[0-9]{1,2}|DECIMAL_POINT|GROUPING|THOUSANDS_SEP)|YSQL_(?<_36>ASSOC|BOTH|NUM)|_(?<_37>1_PI|2_(?<_38>PI|SQRTPI)|E|L(?<_39>N10|N2|OG(?<_40>10E|2E))|PI(?<_41>|_2|_4)|SQRT1_2|SQRT2))|N(?<_42>EGATIVE_SIGN|O(?<_43>EXPR|STR)|_(?<_44>CS_PRECEDES|SEP_BY_SPACE|SIGN_POSN))|P(?<_45>ATH(?<_46>INFO_(?<_47>BASENAME|DIRNAME|EXTENSION|FILENAME)|_SEPARATOR)|M_STR|OSITIVE_SIGN|_(?<_48>CS_PRECEDES|SEP_BY_SPACE|SIGN_POSN))|RADIXCHAR|S(?<_49>EEK_(?<_50>CUR|END|SET)|ORT_(?<_51>ASC|DESC|NUMERIC|REGULAR|STRING)|TR_PAD_(?<_52>BOTH|LEFT|RIGHT))|T(?<_53>HOUS(?<_54>ANDS_SEP|EP)|_(?<_55>FMT(?<_56>|_AMPM)))|YES(?<_57>EXPR|STR))\b/,
        name: "support.constant.std.php"},
       {comment: 
         "In PHP, any identifier which is not a variable is taken to be a constant.\n\t\t\t\tHowever, if there is no constant defined with the given name then a notice\n\t\t\t\tis generated and the constant is assumed to have the value of its name.",
        match: /[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*/n,
        name: "constant.other.php"}]},
   :"function-call" => 
    {match: /[A-Za-z_][A-Za-z_0-9]*(?=\s*\()/, name: "meta.function-call.php"},
   instantiation: 
    {captures: 
      {1 => {name: "keyword.other.new.php"},
       2 => {name: "variable.other.php"},
       3 => {name: "support.class.php"},
       4 => {name: "support.class.php"}},
     match: 
      /(?i)\b(?<_1>new)\s+(?:(?<_2>\$[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*)|(?<_3>\w+))|(?<_4>\w+)(?=::)/n},
   interpolation: 
    {comment: 
      "http://www.php.net/manual/en/language.types.string.php#language.types.string.parsing",
     patterns: 
      [{match: /\\[0-7]{1,3}/, name: "constant.numeric.octal.php"},
       {match: /\\x[0-9A-Fa-f]{1,2}/, name: "constant.numeric.hex.php"},
       {match: /\\[nrt\\\$\"]/, name: "constant.character.escape.php"},
       {captures: 
         {1 => {name: "variable.other.php"},
          2 => {name: "punctuation.definition.variable.php"},
          4 => {name: "punctuation.definition.variable.php"}},
        comment: "Simple syntax with braces: \"foo${bar}baz\"",
        match: 
         /(?x)
	(?<_1>(?<_2>\$\{)(?<name>[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*)(?<_3>\}))
	/n},
       {captures: 
         {1 => {name: "variable.other.php"},
          10 => {name: "punctuation.definition.variable.php"},
          11 => {name: "string.unquoted.index.php"},
          12 => {name: "invalid.illegal.invalid-simple-array-index.php"},
          13 => {name: "keyword.operator.index-end.php"},
          2 => {name: "punctuation.definition.variable.php"},
          4 => {name: "keyword.operator.class.php"},
          5 => {name: "variable.other.property.php"},
          6 => {name: "invalid.illegal.php"},
          7 => {name: "keyword.operator.index-start.php"},
          8 => {name: "constant.numeric.index.php"},
          9 => {name: "variable.other.index.php"}},
        comment: "Simple syntax: $foo, $foo[0], $foo[$bar], $foo->bar",
        match: 
         /(?x)
	(?<_1>(?<_2>\$)(?<name>[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*))
	(?:
	(?<_3>->)
	(?:
	(?<_4>\g<name>)
	|
	(?<_5>\$\g<name>)
	)
	|
	(?<_6>\[)
	(?:(?<_7>\d+)|(?<_8>(?<_9>\$)\g<name>)|(?<_10>\w+)|(?<_11>.*?))
	(?<_12>\])
	)?
	/n},
       {begin: 
         /(?=(?<regex>(?#simple syntax)\$(?<name>[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*)(?:\[(?<index>[a-zA-Z0-9_\x7f-\xff]+|\$\g<name>)\]|->\g<name>(?<_1>\(.*?\))?)?|(?#simple syntax with braces)\$\{(?:\g<name>(?<indices>\[(?:\g<index>|'(?:\\.|[^'\\])*'|"(?:\g<regex>|\\.|[^"\\])*")\])?|\g<complex>|\$\{\g<complex>\})\}|(?#complex syntax)\{(?<complex>\$(?<segment>\g<name>(?<_2>\g<indices>*|\(.*?\))?)(?:->\g<segment>)*|\$\g<complex>|\$\{\g<complex>\})\}))\{/n,
        beginCaptures: {0 => {name: "punctuation.definition.variable.php"}},
        comment: 
         "Complex syntax. It seems this now supports complex method calls, as of PHP5.\n\t\t\t\t\t\t\t   I've put wildcards into the function call parameter lists to handle this, but this may break the pattern.\n\t\t\t\t\t\t\t   It also might be better to disable it as I shouldn't imagine it's used often (hopefully) and it may confuse PHP4 users.",
        end: "\\}",
        endCaptures: {0 => {name: "punctuation.definition.variable.php"}},
        patterns: 
         [{include: "#function-call"},
          {include: "#var_basic"},
          {include: "#object"},
          {include: "#numbers"},
          {match: /\[/, name: "keyword.operator.index-start.php"},
          {match: /\]/, name: "keyword.operator.index-end.php"}]}]},
   language: 
    {patterns: 
      [{begin: /(?=<<<\s*(?<_1>HTML|XML|SQL|JAVASCRIPT|CSS)\s*$)/,
        end: "(?!<?<<\\s*(HTML|XML|SQL|JAVASCRIPT|CSS)\\s*$)",
        name: "string.unquoted.heredoc.php",
        patterns: 
         [{begin: /(?<_1><<<)\s*(?<_2>HTML)\s*$\n?/,
           beginCaptures: 
            {0 => {name: "punctuation.section.embedded.begin.php"},
             1 => {name: "punctuation.definition.string.php"},
             2 => {name: "keyword.operator.heredoc.php"}},
           contentName: "text.html",
           end: "^(HTML)(;?)$\\n?",
           endCaptures: 
            {0 => {name: "punctuation.section.embedded.end.php"},
             1 => {name: "keyword.operator.heredoc.php"},
             2 => {name: "punctuation.definition.string.php"}},
           name: "meta.embedded.html",
           patterns: 
            [{include: "text.html.basic"}, {include: "#interpolation"}]},
          {begin: /(?<_1><<<)\s*(?<_2>XML)\s*$\n?/,
           beginCaptures: 
            {0 => {name: "punctuation.section.embedded.begin.php"},
             1 => {name: "punctuation.definition.string.php"},
             2 => {name: "keyword.operator.heredoc.php"}},
           contentName: "text.xml",
           end: "^(XML)(;?)$\\n?",
           endCaptures: 
            {0 => {name: "punctuation.section.embedded.end.php"},
             1 => {name: "keyword.operator.heredoc.php"},
             2 => {name: "punctuation.definition.string.php"}},
           name: "meta.embedded.xml",
           patterns: [{include: "text.xml"}, {include: "#interpolation"}]},
          {begin: /(?<_1><<<)\s*(?<_2>SQL)\s*$\n?/,
           beginCaptures: 
            {0 => {name: "punctuation.section.embedded.begin.php"},
             1 => {name: "punctuation.definition.string.php"},
             2 => {name: "keyword.operator.heredoc.php"}},
           contentName: "source.sql",
           end: "^(SQL)(;?)$\\n?",
           endCaptures: 
            {0 => {name: "punctuation.section.embedded.end.php"},
             1 => {name: "keyword.operator.heredoc.php"},
             2 => {name: "punctuation.definition.string.php"}},
           name: "meta.embedded.sql",
           patterns: [{include: "source.sql"}, {include: "#interpolation"}]},
          {begin: /(?<_1><<<)\s*(?<_2>JAVASCRIPT)\s*$\n?/,
           beginCaptures: 
            {0 => {name: "punctuation.section.embedded.begin.php"},
             1 => {name: "punctuation.definition.string.php"},
             2 => {name: "keyword.operator.heredoc.php"}},
           contentName: "source.js",
           end: "^(JAVASCRIPT)(;?)$\\n?",
           endCaptures: 
            {0 => {name: "punctuation.section.embedded.end.php"},
             1 => {name: "keyword.operator.heredoc.php"},
             2 => {name: "punctuation.definition.string.php"}},
           name: "meta.embedded.js",
           patterns: [{include: "source.js"}, {include: "#interpolation"}]},
          {begin: /(?<_1><<<)\s*(?<_2>CSS)\s*$\n?/,
           beginCaptures: 
            {0 => {name: "punctuation.section.embedded.begin.php"},
             1 => {name: "punctuation.definition.string.php"},
             2 => {name: "keyword.operator.heredoc.php"}},
           contentName: "source.css",
           end: "^(CSS)(;?)$\\n?",
           endCaptures: 
            {0 => {name: "punctuation.section.embedded.end.php"},
             1 => {name: "keyword.operator.heredoc.php"},
             2 => {name: "punctuation.definition.string.php"}},
           name: "meta.embedded.css",
           patterns: [{include: "source.css"}, {include: "#interpolation"}]}]},
       {begin: /\/\*\*(?:\#@\+)?\s*$/,
        captures: {0 => {name: "punctuation.definition.comment.php"}},
        comment: 
         "This now only highlights a docblock if the first line contains only /**\n\t\t\t\t\t\t\t\t- this is to stop highlighting everything as invalid when people do comment banners with /******** ...\n\t\t\t\t\t\t\t\t- Now matches /**\#@+ too - used for docblock templates: http://manual.phpdoc.org/HTMLframesConverter/default/phpDocumentor/tutorial_phpDocumentor.howto.pkg.html#basics.docblocktemplate",
        end: "\\*/",
        name: "comment.block.documentation.phpdoc.php",
        patterns: [{include: "#php_doc"}]},
       {begin: /\/\*/,
        captures: {0 => {name: "punctuation.definition.comment.php"}},
        end: "\\*/",
        name: "comment.block.php"},
       {captures: {1 => {name: "punctuation.definition.comment.php"}},
        match: /(?<_1>\/\/).*?(?<_2>$\n?|(?=\?>))/,
        name: "comment.line.double-slash.php"},
       {captures: {1 => {name: "punctuation.definition.comment.php"}},
        match: /(?<_1>#).*?(?<_2>$\n?|(?=\?>))/,
        name: "comment.line.number-sign.php"},
       {begin: 
         /^(?i)\s*(?<_1>interface)\s+(?<_2>[a-z0-9_]+)\s*(?<_3>extends)?\s*/,
        beginCaptures: 
         {1 => {name: "storage.type.interface.php"},
          2 => {name: "entity.name.type.interface.php"},
          3 => {name: "storage.modifier.extends.php"}},
        end: "$",
        name: "meta.interface.php",
        patterns: 
         [{match: /[a-zA-Z0-9_]+/, name: "entity.other.inherited-class.php"}]},
       {begin: 
         /(?i)^\s*(?<_1>abstract|final)?\s*(?<_2>class)\s+(?<_3>[a-z0-9_]+)\s*/,
        beginCaptures: 
         {1 => {name: "storage.modifier.abstract.php"},
          2 => {name: "storage.type.class.php"},
          3 => {name: "entity.name.type.class.php"}},
        end: "$",
        name: "meta.class.php",
        patterns: 
         [{captures: 
            {1 => {name: "storage.modifier.extends.php"},
             2 => {name: "entity.other.inherited-class.php"}},
           match: /(?i:(?<_1>extends))\s+(?<_2>[a-zA-Z0-9_]+)\s*/},
          {begin: /(?i:(?<_1>implements))\s+(?<_2>[a-zA-Z0-9_]+)\s*/,
           beginCaptures: 
            {1 => {name: "storage.modifier.implements.php"},
             2 => {name: "support.class.implements.php"}},
           end: "(?=\\s*\\b(?i:(extends)))|$",
           patterns: 
            [{captures: {1 => {name: "support.class.implements.php"}},
              match: /,\s*(?<_1>[a-zA-Z0-9_]+)\s*/}]}]},
       {match: 
         /\b(?<_1>break|c(?<_2>ase|ontinue)|d(?<_3>e(?<_4>clare|fault)|ie|o)|e(?<_5>lse(?<_6>if)?|nd(?<_7>declare|for(?<_8>each)?|if|switch|while)|xit)|for(?<_9>each)?|if|return|switch|use|while)\b/,
        name: "keyword.control.php"},
       {begin: /(?i)\b(?<_1>(?:require|include)(?:_once)?)\b\s*/,
        beginCaptures: {1 => {name: "keyword.control.import.include.php"}},
        end: "(?=\\s|;|$)",
        name: "meta.include.php",
        patterns: [{include: "#language"}]},
       {captures: 
         {1 => {name: "keyword.control.exception.php"},
          2 => {name: "support.class.php"},
          3 => {name: "variable.other.php"},
          4 => {name: "punctuation.definition.variable.php"}},
        match: 
         /\b(?<_1>catch)\b\s*\(\s*(?<_2>[A-Za-z_][A-Za-z_0-9]*)\s*(?<_3>(?<_4>\$+)[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*)\s*\)/n,
        name: "meta.catch.php"},
       {match: /\b(?<_1>catch|try|throw|exception)\b/,
        name: "keyword.control.exception.php"},
       {begin: 
         /(?:^\s*)(?<_1>(?:(?:final|abstract|public|private|protected|static)\s+)*)(?<_2>function)(?:\s+|(?<_3>\s*&\s*))(?:(?<_4>__(?:call|(?:con|de)struct|get|(?:is|un)?set|tostring|clone|set_state|sleep|wakeup|autoload))|(?<_5>[a-zA-Z0-9_]+))\s*(?<_6>\()/,
        beginCaptures: 
         {1 => {name: "storage.modifier.php"},
          2 => {name: "storage.type.function.php"},
          3 => {name: "storage.modifier.reference.php"},
          4 => {name: "support.function.magic.php"},
          5 => {name: "entity.name.function.php"},
          6 => {name: "punctuation.definition.parameters.begin.php"}},
        contentName: "meta.function.arguments.php",
        end: "\\)",
        endCaptures: 
         {1 => {name: "punctuation.definition.parameters.end.php"}},
        name: "meta.function.php",
        patterns: 
         [{begin: 
            /(?x)
	\s*(?<_1>array) # Typehint
	\s*(?<_2>&)? 					# Reference
	\s*(?<_3>(?<_4>\$+)[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*) # The variable name
	\s*(?<_5>=)	# A default value
	\s*(?<_6>array)\s*(?<_7>\()
	/n,
           beginCaptures: 
            {1 => {name: "storage.type.php"},
             2 => {name: "storage.modifier.php"},
             3 => {name: "variable.other.php"},
             4 => {name: "punctuation.definition.variable.php"},
             5 => {name: "keyword.operator.assignment.php"},
             6 => {name: "support.function.construct.php"},
             7 => {name: "punctuation.definition.array.begin.php"}},
           contentName: "meta.array.php",
           end: "\\)",
           endCaptures: {0 => {name: "punctuation.definition.array.end.php"}},
           name: "meta.function.argument.array.php",
           patterns: [{include: "#strings"}, {include: "#numbers"}]},
          {captures: 
            {1 => {name: "storage.type.php"},
             2 => {name: "storage.modifier.php"},
             3 => {name: "variable.other.php"},
             4 => {name: "punctuation.definition.variable.php"},
             5 => {name: "keyword.operator.assignment.php"},
             6 => {name: "constant.language.php"},
             7 => {name: "invalid.illegal.non-null-typehinted.php"}},
           match: 
            /(?x)
	\s*(?<_1>array) # Typehint
	\s*(?<_2>&)? 					# Reference
	\s*(?<_3>(?<_4>\$+)[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*) # The variable name
	(?:
	\s*(?<_5>=)	# A default value
	\s*(?i:
	(?<_6>NULL)
	|
	(?<_7>\S.*?)
	)?
	)?
	\s*(?=,|\)) # A closing parentheses (?<_8>end of argument list) or a comma
	/n,
           name: "meta.function.argument.array.php"},
          {captures: 
            {1 => {name: "support.class.php"},
             2 => {name: "storage.modifier.php"},
             3 => {name: "variable.other.php"},
             4 => {name: "punctuation.definition.variable.php"},
             5 => {name: "keyword.operator.assignment.php"},
             6 => {name: "constant.language.php"},
             7 => {name: "invalid.illegal.non-null-typehinted.php"}},
           match: 
            /(?x)
	\s*(?<_1>[A-Za-z_][A-Za-z_0-9]*) # Typehinted class name
	\s*(?<_2>&)? 					# Reference
	\s*(?<_3>(?<_4>\$+)[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*) # The variable name
	(?:
	\s*(?<_5>=)	# A default value
	\s*(?i:
	(?<_6>NULL)
	|
	(?<_7>\S.*?)
	)?
	)?
	\s*(?=,|\)) # A closing parentheses (?<_8>end of argument list) or a comma
	/n,
           name: "meta.function.argument.typehinted.php"},
          {captures: 
            {1 => {name: "storage.modifier.php"},
             2 => {name: "variable.other.php"},
             3 => {name: "punctuation.definition.variable.php"}},
           match: 
            /(?<_1>\s*&)?\s*(?<_2>(?<_3>\$+)[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*)\s*(?=,|\))/n,
           name: "meta.function.argument.no-default.php"},
          {begin: 
            /(?<_1>\s*&)?\s*(?<_2>(?<_3>\$+)[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*)(?:\s*(?<_4>=)\s*)\s*/n,
           captures: 
            {1 => {name: "storage.modifier.php"},
             2 => {name: "variable.other.php"},
             3 => {name: "punctuation.definition.variable.php"},
             4 => {name: "keyword.operator.assignment.php"}},
           end: "(?=,|\\))",
           name: "meta.function.argument.default.php",
           patterns: [{include: "#parameter-default-types"}]},
          {begin: /\/\*/,
           captures: {0 => {name: "punctuation.definition.comment.php"}},
           end: "\\*/",
           name: "comment.block.php"}]},
       {match: 
         /(?i)\b(?<_1>real|double|float|int(?<_2>eger)?|bool(?<_3>ean)?|string|class|clone|var|function|interface|parent|self|object)\b/,
        name: "storage.type.php"},
       {match: 
         /(?i)\b(?<_1>global|abstract|const|extends|implements|final|p(?<_2>r(?<_3>ivate|otected)|ublic)|static)\b/,
        name: "storage.modifier.php"},
       {include: "#object"},
       {captures: 
         {1 => {name: "keyword.operator.class.php"},
          2 => {name: "meta.function-call.static.php"},
          3 => {name: "variable.other.class.php"},
          4 => {name: "punctuation.definition.variable.php"},
          5 => {name: "constant.other.class.php"}},
        match: 
         /(?x)(?<_1>::)
                        (?:
        				    (?<_2>[A-Za-z_][A-Za-z_0-9]*)\s*\(
        				    |
        				    (?<_3>(?<_4>\$+)[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*)
        				    |
        				    (?<_5>[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*)
        				)?/n},
       {include: "#support"},
       {begin: /(?<_1><<<)\s*(?<_2>[a-zA-Z_]+[a-zA-Z0-9_]*)/,
        beginCaptures: 
         {1 => {name: "punctuation.definition.string.php"},
          2 => {name: "keyword.operator.heredoc.php"}},
        end: "^(\\2)(;?)$",
        endCaptures: 
         {1 => {name: "keyword.operator.heredoc.php"},
          2 => {name: "punctuation.definition.string.php"}},
        name: "string.unquoted.heredoc.php",
        patterns: [{include: "#interpolation"}]},
       {match: /=>/, name: "keyword.operator.key.php"},
       {match: /&(?=\s*(?<_1>\$|new|[A-Za-z_][A-Za-z_0-9]+(?=\s*\()))/,
        name: "storage.modifier.reference.php"},
       {match: /;/, name: "punctuation.terminator.expression.php"},
       {match: /(?<_1>@)/, name: "keyword.operator.error-control.php"},
       {match: /(?<_1>\-\-|\+\+)/,
        name: "keyword.operator.increment-decrement.php"},
       {match: /(?<_1>\-|\+|\*|\/|%)/,
        name: "keyword.operator.arithmetic.php"},
       {match: /(?i)(?<_1>!|&&|\|\|)|\b(?<_2>and|or|xor|as)\b/,
        name: "keyword.operator.logical.php"},
       {match: /<<|>>|~|\^|&|\|/, name: "keyword.operator.bitwise.php"},
       {match: /(?<_1>===|==|!==|!=|<=|>=|<>|<|>)/,
        name: "keyword.operator.comparison.php"},
       {match: /(?<_1>\.=|\.)/, name: "keyword.operator.string.php"},
       {match: /=/, name: "keyword.operator.assignment.php"},
       {captures: 
         {1 => {name: "keyword.operator.type.php"},
          2 => {name: "support.class.php"}},
        match: /(?i)\b(?<_1>instanceof)\b(?:\s+(?<_2>\w+))?/},
       {include: "#numbers"},
       {include: "#strings"},
       {include: "#string-backtick"},
       {include: "#function-call"},
       {include: "#variables"},
       {captures: 
         {1 => {name: "keyword.operator.php"},
          2 => {name: "variable.other.property.php"}},
        match: 
         /(?<=[a-zA-Z0-9_\x7f-\xff])(?<_1>->)(?<_2>[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*?)\b/n},
       {include: "#instantiation"},
       {include: "#constants"}]},
   numbers: 
    {match: 
      /\b(?<_1>(?<_2>0(?<_3>x|X)[0-9a-fA-F]*)|(?<_4>(?<_5>[0-9]+\.?[0-9]*)|(?<_6>\.[0-9]+))(?<_7>(?<_8>e|E)(?<_9>\+|-)?[0-9]+)?)\b/,
     name: "constant.numeric.php"},
   object: 
    {captures: 
      {1 => {name: "keyword.operator.class.php"},
       2 => {name: "meta.function-call.object.php"},
       3 => {name: "variable.other.property.php"},
       4 => {name: "punctuation.definition.variable.php"}},
     match: 
      /(?x)(?<_1>->)
    				(?:
    				    (?<_2>[A-Za-z_][A-Za-z_0-9]*)\s*\(
    				    |
    				    (?<_3>(?<_4>\$+)?[a-zA-Z_\x7f-\xff][a-zA-Z0-9_\x7f-\xff]*)
    				)?/n},
   :"parameter-default-types" => 
    {patterns: 
      [{include: "#strings"},
       {include: "#numbers"},
       {include: "#string-backtick"},
       {include: "#variables"},
       {match: /=>/, name: "keyword.operator.key.php"},
       {match: /=/, name: "keyword.operator.assignment.php"},
       {match: /&(?=\s*\$)/, name: "storage.modifier.reference.php"},
       {begin: /(?<_1>array)\s*(?<_2>\()/,
        beginCaptures: 
         {1 => {name: "support.function.construct.php"},
          2 => {name: "punctuation.definition.array.begin.php"}},
        end: "\\)",
        endCaptures: {0 => {name: "punctuation.definition.array.end.php"}},
        name: "meta.array.php",
        patterns: [{include: "#parameter-default-types"}]},
       {include: "#instantiation"},
       {include: "#constants"}]},
   php_doc: 
    {patterns: 
      [{comment: 
         "PHPDocumentor only recognises lines with an asterisk as the first non-whitespaces character",
        match: /^(?!\s*\*).*$\n?/,
        name: "invalid.illegal.missing-asterisk.phpdoc.php"},
       {captures: 
         {1 => {name: "keyword.other.phpdoc.php"},
          3 => {name: "storage.modifier.php"},
          4 => {name: "invalid.illegal.wrong-access-type.phpdoc.php"}},
        match: 
         /^\s*\*\s*(?<_1>@access)\s+(?<_2>(?<_3>public|private|protected)|(?<_4>.+))\s*$/},
       {match: 
         /(?<_1>(?<_2>https?|s?ftp|ftps|file|smb|afp|nfs|(?<_3>x-)?man|gopher|txmt):\/\/|mailto:)[-:@a-zA-Z0-9_.~%+\/?=&#]+(?<![.?:])/,
        name: "markup.underline.link.php"},
       {captures: 
         {1 => {name: "keyword.other.phpdoc.php"},
          2 => {name: "markup.underline.link.php"}},
        match: /(?<_1>@xlink)\s+(?<_2>.+)\s*$/},
       {match: 
         /\@(?<_1>a(?<_2>bstract|uthor)|c(?<_3>ategory|opyright)|example|global|internal|li(?<_4>cense|nk)|pa(?<_5>ckage|ram)|return|s(?<_6>ee|ince|tatic|ubpackage)|t(?<_7>hrows|odo)|v(?<_8>ar|ersion)|uses|deprecated|final)\b/,
        name: "keyword.other.phpdoc.php"},
       {captures: {1 => {name: "keyword.other.phpdoc.php"}},
        match: /\{(?<_1>@(?<_2>link)).+?\}/,
        name: "meta.tag.inline.phpdoc.php"}]},
   :"regex-double-quoted" => 
    {begin: /(?x)"\/ (?= (?<_1>\\.|[^"\/])++\/[imsxeADSUXu]*" )/,
     beginCaptures: {0 => {name: "punctuation.definition.string.begin.php"}},
     end: "(/)([imsxeADSUXu]*)(\")",
     endCaptures: {0 => {name: "punctuation.definition.string.end.php"}},
     name: "string.regexp.double-quoted.php",
     patterns: 
      [{comment: 
         "Escaped from the regexp – there can also be 2 backslashes (since 1 will escape the first)",
        match: /(?<_1>\\){1,2}[.$^\[\]{}]/,
        name: "constant.character.escape.regex.php"},
       {include: "#interpolation"},
       {captures: 
         {1 => {name: "punctuation.definition.arbitrary-repitition.php"},
          3 => {name: "punctuation.definition.arbitrary-repitition.php"}},
        match: /(?<_1>\{)\d+(?<_2>,\d+)?(?<_3>\})/,
        name: "string.regexp.arbitrary-repitition.php"},
       {begin: /\[(?:\^?\])?/,
        captures: {0 => {name: "punctuation.definition.character-class.php"}},
        end: "\\]",
        name: "string.regexp.character-class.php",
        patterns: [{include: "#interpolation"}]},
       {match: /[$^+*]/, name: "keyword.operator.regexp.php"}]},
   :"regex-single-quoted" => 
    {begin: /(?x)'\/ (?= (?<_1>\\.|[^'\/])++\/[imsxeADSUXu]*' )/,
     beginCaptures: {0 => {name: "punctuation.definition.string.begin.php"}},
     end: "(/)([imsxeADSUXu]*)(')",
     endCaptures: {0 => {name: "punctuation.definition.string.end.php"}},
     name: "string.regexp.single-quoted.php",
     patterns: 
      [{captures: 
         {1 => {name: "punctuation.definition.arbitrary-repitition.php"},
          3 => {name: "punctuation.definition.arbitrary-repitition.php"}},
        match: /(?<_1>\{)\d+(?<_2>,\d+)?(?<_3>\})/,
        name: "string.regexp.arbitrary-repitition.php"},
       {comment: 
         "Escaped from the regexp – there can also be 2 backslashes (since 1 will escape the first)",
        match: /(?<_1>\\){1,2}[.$^\[\]{}]/,
        name: "constant.character.escape.regex.php"},
       {comment: 
         "Escaped from the PHP string – there can also be 2 backslashes (since 1 will escape the first)",
        match: /\\{1,2}[\\']/,
        name: "constant.character.escape.php"},
       {begin: /\[(?:\^?\])?/,
        captures: {0 => {name: "punctuation.definition.character-class.php"}},
        end: "\\]",
        name: "string.regexp.character-class.php",
        patterns: 
         [{match: /\\[\\'\[\]]/, name: "constant.character.escape.php"}]},
       {match: /[$^+*]/, name: "keyword.operator.regexp.php"}]},
   :"sql-string-double-quoted" => 
    {begin: 
      /"\s*(?=(?<_1>SELECT|INSERT|UPDATE|DELETE|CREATE|REPLACE|ALTER)\b)/,
     beginCaptures: {0 => {name: "punctuation.definition.string.begin.php"}},
     contentName: "source.sql.embedded.php",
     end: "\"",
     endCaptures: {0 => {name: "punctuation.definition.string.end.php"}},
     name: "string.quoted.double.sql.php",
     patterns: 
      [{match: /#(?<_1>\\"|[^"])*(?="|$\n?)/,
        name: "comment.line.number-sign.sql"},
       {match: /--(?<_1>\\"|[^"])*(?="|$\n?)/,
        name: "comment.line.double-dash.sql"},
       {begin: /'(?=[^']*?")/,
        comment: 
         "Unclosed strings must be captured to avoid them eating the remainder of the PHP script\n\t\t\t\t\tSample case: $sql = \"SELECT * FROM bar WHERE foo = '\" . $variable . \"'\"",
        end: "(?=\")",
        name: "string.quoted.single.unclosed.sql",
        patterns: [{match: /\\[\\']/, name: "constant.character.escape.php"}]},
       {begin: /`(?=[^`]*?")/,
        comment: 
         "Unclosed strings must be captured to avoid them eating the remainder of the PHP script\n\t\t\t\t\tSample case: $sql = \"SELECT * FROM bar WHERE foo = '\" . $variable . \"'\"",
        end: "(?=\")",
        name: "string.quoted.other.backtick.unclosed.sql",
        patterns: [{match: /\\[\\']/, name: "constant.character.escape.php"}]},
       {begin: /\\"(?!(?<_1>[^\\"]|\\[^"])*\\")(?=(?<_2>\\[^"]|.)*?")/,
        comment: 
         "Unclosed strings must be captured to avoid them eating the remainder of the PHP script\n\t\t\t\t\tSample case: $sql = \"SELECT * FROM bar WHERE foo = '\" . $variable . \"'\"",
        end: "(?=\")",
        name: "string.quoted.double.unclosed.sql",
        patterns: [{match: /\\[\\']/, name: "constant.character.escape.php"}]},
       {begin: /\\"/,
        captures: {0 => {name: "constant.character.escape.php"}},
        end: "\\\\\"",
        name: "string.quoted.double.sql",
        patterns: [{include: "#interpolation"}]},
       {begin: /`/,
        end: "`",
        name: "string.quoted.other.backtick.sql",
        patterns: [{include: "#interpolation"}]},
       {begin: /'/,
        end: "'",
        name: "string.quoted.single.sql",
        patterns: [{include: "#interpolation"}]},
       {match: /\\./, name: "constant.character.escape.php"},
       {include: "#interpolation"},
       {include: "source.sql"}]},
   :"sql-string-single-quoted" => 
    {begin: 
      /'\s*(?=(?<_1>SELECT|INSERT|UPDATE|DELETE|CREATE|REPLACE|ALTER)\b)/,
     beginCaptures: {0 => {name: "punctuation.definition.string.begin.php"}},
     contentName: "source.sql.embedded.php",
     end: "'",
     endCaptures: {0 => {name: "punctuation.definition.string.end.php"}},
     name: "string.quoted.single.sql.php",
     patterns: 
      [{match: /#(?<_1>\\'|[^'])*(?='|$\n?)/,
        name: "comment.line.number-sign.sql"},
       {match: /--(?<_1>\\'|[^'])*(?='|$\n?)/,
        name: "comment.line.double-dash.sql"},
       {begin: /\\'(?!(?<_1>[^\\']|\\[^'])*\\')(?=(?<_2>\\[^']|.)*?')/,
        comment: 
         "Unclosed strings must be captured to avoid them eating the remainder of the PHP script\n\t\t\t\t\tSample case: $sql = \"SELECT * FROM bar WHERE foo = '\" . $variable . \"'\"",
        end: "(?=')",
        name: "string.quoted.single.unclosed.sql",
        patterns: [{match: /\\[\\']/, name: "constant.character.escape.php"}]},
       {begin: /`(?=[^`]*?')/,
        comment: 
         "Unclosed strings must be captured to avoid them eating the remainder of the PHP script\n\t\t\t\t\tSample case: $sql = \"SELECT * FROM bar WHERE foo = '\" . $variable . \"'\"",
        end: "(?=')",
        name: "string.quoted.other.backtick.unclosed.sql",
        patterns: [{match: /\\[\\']/, name: "constant.character.escape.php"}]},
       {begin: /"(?=[^"]*?')/,
        comment: 
         "Unclosed strings must be captured to avoid them eating the remainder of the PHP script\n\t\t\t\t\tSample case: $sql = \"SELECT * FROM bar WHERE foo = '\" . $variable . \"'\"",
        end: "(?=')",
        name: "string.quoted.double.unclosed.sql",
        patterns: [{match: /\\[\\']/, name: "constant.character.escape.php"}]},
       {begin: /\\'/,
        captures: {0 => {name: "constant.character.escape.php"}},
        end: "\\\\'",
        name: "string.quoted.single.sql"},
       {match: /\\[\\']/, name: "constant.character.escape.php"},
       {include: "source.sql"}]},
   :"string-backtick" => 
    {begin: /`/,
     beginCaptures: {0 => {name: "punctuation.definition.string.begin.php"}},
     end: "`",
     endCaptures: {0 => {name: "punctuation.definition.string.end.php"}},
     name: "string.interpolated.php",
     patterns: 
      [{match: /\\./, name: "constant.character.escape.php"},
       {include: "#interpolation"}]},
   :"string-double-quoted" => 
    {begin: /"/,
     beginCaptures: {0 => {name: "punctuation.definition.string.begin.php"}},
     comment: 
      "This contentName is just to allow the usage of “select scope” to select the string contents first, then the string with quotes",
     contentName: "meta.string-contents.quoted.double.php",
     end: "\"",
     endCaptures: {0 => {name: "punctuation.definition.string.end.php"}},
     name: "string.quoted.double.php",
     patterns: [{include: "#interpolation"}]},
   :"string-single-quoted" => 
    {begin: /'/,
     beginCaptures: {0 => {name: "punctuation.definition.string.begin.php"}},
     contentName: "meta.string-contents.quoted.single.php",
     end: "'",
     endCaptures: {0 => {name: "punctuation.definition.string.end.php"}},
     name: "string.quoted.single.php",
     patterns: [{match: /\\[\\']/, name: "constant.character.escape.php"}]},
   strings: 
    {patterns: 
      [{include: "#regex-double-quoted"},
       {include: "#sql-string-double-quoted"},
       {include: "#string-double-quoted"},
       {include: "#regex-single-quoted"},
       {include: "#sql-string-single-quoted"},
       {include: "#string-single-quoted"}]},
   support: 
    {patterns: 
      [{begin: /(?<_1>array)(?<_2>\()/,
        beginCaptures: 
         {1 => {name: "support.function.construct.php"},
          2 => {name: "punctuation.definition.array.begin.php"}},
        end: "\\)",
        endCaptures: {0 => {name: "punctuation.definition.array.end.php"}},
        name: "meta.array.php",
        patterns: [{include: "#language"}]},
       {match: 
         /(?i)\b(?<_1>s(?<_2>huffle|ort)|n(?<_3>ext|at(?<_4>sort|casesort))|c(?<_5>o(?<_6>unt|mpact)|urrent)|in_array|u(?<_7>sort|ksort|asort)|prev|e(?<_8>nd|xtract)|k(?<_9>sort|ey|rsort)|a(?<_10>sort|r(?<_11>sort|ray_(?<_12>s(?<_13>hift|um|plice|earch|lice)|c(?<_14>h(?<_15>unk|ange_key_case)|o(?<_16>unt_values|mbine))|intersect(?<_17>_(?<_18>u(?<_19>key|assoc)|key|assoc))?|diff(?<_20>_(?<_21>u(?<_22>key|assoc)|key|assoc))?|u(?<_23>n(?<_24>shift|ique)|intersect(?<_25>_(?<_26>uassoc|assoc))?|diff(?<_27>_(?<_28>uassoc|assoc))?)|p(?<_29>op|ush|ad|roduct)|values|key(?<_30>s|_exists)|f(?<_31>il(?<_32>ter|l(?<_33>_keys)?)|lip)|walk(?<_34>_recursive)?|r(?<_35>e(?<_36>duce|verse)|and)|m(?<_37>ultisort|erge(?<_38>_recursive)?|ap))))|r(?<_39>sort|eset|ange)|m(?<_40>in|ax))(?=\s*\()/,
        name: "support.function.array.php"},
       {match: /(?i)\bassert(?<_1>_options)?(?=\s*\()/,
        name: "support.function.assert.php"},
       {match: /(?i)\bdom_attr_is_id(?=\s*\()/,
        name: "support.function.attr.php"},
       {match: /(?i)\bbase64_(?<_1>decode|encode)(?=\s*\()/,
        name: "support.function.base64.php"},
       {match: 
         /(?i)\b(?<_1>highlight_(?<_2>string|file)|s(?<_3>ys_getloadavg|et_(?<_4>include_path|magic_quotes_runtime)|leep)|c(?<_5>on(?<_6>stant|nection_(?<_7>status|aborted))|all_user_(?<_8>func(?<_9>_array)?|method(?<_10>_array)?))|time_(?<_11>sleep_until|nanosleep)|i(?<_12>s_uploaded_file|n(?<_13>i_(?<_14>set|restore|get(?<_15>_all)?)|et_(?<_16>ntop|pton))|p2long|gnore_user_abort|mport_request_variables)|u(?<_17>sleep|nregister_tick_function)|error_(?<_18>log|get_last)|p(?<_19>hp_strip_whitespace|utenv|arse_ini_file|rint_r)|flush|long2ip|re(?<_20>store_include_path|gister_(?<_21>shutdown_function|tick_function))|get(?<_22>servby(?<_23>name|port)|opt|_(?<_24>c(?<_25>urrent_user|fg_var)|include_path|magic_quotes_(?<_26>gpc|runtime))|protobyn(?<_27>umber|ame)|env)|move_uploaded_file)(?=\s*\()/,
        name: "support.function.basic_functions.php"},
       {match: 
         /(?i)\bbc(?<_1>s(?<_2>cale|ub|qrt)|comp|div|pow(?<_3>mod)?|add|m(?<_4>od|ul))(?=\s*\()/,
        name: "support.function.bcmath.php"},
       {match: 
         /(?i)\bbirdstep_(?<_1>c(?<_2>o(?<_3>nnect|mmit)|lose)|off_autocommit|exec|f(?<_4>ieldn(?<_5>um|ame)|etch|reeresult)|autocommit|r(?<_6>ollback|esult))(?=\s*\()/,
        name: "support.function.birdstep.php"},
       {match: /(?i)\bget_browser(?=\s*\()/,
        name: "support.function.browscap.php"},
       {match: 
         /(?i)\b(?<_1>s(?<_2>tr(?<_3>nc(?<_4>asecmp|mp)|c(?<_5>asecmp|mp)|len)|et_e(?<_6>rror_handler|xception_handler))|c(?<_7>lass_exists|reate_function)|trigger_error|i(?<_8>s_(?<_9>subclass_of|a)|nterface_exists)|de(?<_10>fine(?<_11>d)?|bug_(?<_12>print_backtrace|backtrace))|zend_version|property_exists|e(?<_13>ach|rror_reporting|xtension_loaded)|func(?<_14>tion_exists|_(?<_15>num_args|get_arg(?<_16>s)?))|leak|restore_e(?<_17>rror_handler|xception_handler)|get_(?<_18>class(?<_19>_(?<_20>vars|methods))?|included_files|de(?<_21>clared_(?<_22>classes|interfaces)|fined_(?<_23>constants|vars|functions))|object_vars|extension_funcs|parent_class|loaded_extensions|resource_type)|method_exists)(?=\s*\()/,
        name: "support.function.builtin_functions.php"},
       {match: 
         /(?i)\bbz(?<_1>compress|decompress|open|err(?<_2>str|no|or)|read)(?=\s*\()/,
        name: "support.function.bz2.php"},
       {match: /(?i)\b(?<_1>jdtounix|unixtojd)(?=\s*\()/,
        name: "support.function.cal_unix.php"},
       {match: 
         /(?i)\b(?<_1>cal_(?<_2>to_jd|info|days_in_month|from_jd)|j(?<_3>d(?<_4>to(?<_5>j(?<_6>ulian|ewish)|french|gregorian)|dayofweek|monthname)|uliantojd|ewishtojd)|frenchtojd|gregoriantojd)(?=\s*\()/,
        name: "support.function.calendar.php"},
       {match: 
         /(?i)\bdom_characterdata_(?<_1>substring_data|insert_data|delete_data|append_data|replace_data)(?=\s*\()/,
        name: "support.function.characterdata.php"},
       {match: 
         /(?i)\bcom_(?<_1>create_guid|print_typeinfo|event_sink|load_typelib|get_active_object|message_pump)(?=\s*\()/,
        name: "support.function.com_com.php"},
       {match: 
         /(?i)\bvariant_(?<_1>s(?<_2>ub|et(?<_3>_type)?)|n(?<_4>ot|eg)|c(?<_5>a(?<_6>st|t)|mp)|i(?<_7>nt|div|mp)|or|d(?<_8>iv|ate_(?<_9>to_timestamp|from_timestamp))|pow|eqv|fix|a(?<_10>nd|dd|bs)|get_type|round|xor|m(?<_11>od|ul))(?=\s*\()/,
        name: "support.function.com_variant.php"},
       {match: /(?i)\bcrc32(?=\s*\()/, name: "support.function.crc32.php"},
       {match: /(?i)\bcrypt(?=\s*\()/, name: "support.function.crypt.php"},
       {match: 
         /(?i)\bctype_(?<_1>space|cntrl|digit|upper|p(?<_2>unct|rint)|lower|al(?<_3>num|pha)|graph|xdigit)(?=\s*\()/,
        name: "support.function.ctype.php"},
       {match: /(?i)\bconvert_cyr_string(?=\s*\()/,
        name: "support.function.cyr_convert.php"},
       {match: /(?i)\bstrptime(?=\s*\()/,
        name: "support.function.datetime.php"},
       {match: 
         /(?i)\bdba_(?<_1>handlers|sync|nextkey|close|insert|delete|op(?<_2>timize|en)|exists|popen|key_split|f(?<_3>irstkey|etch)|list|replace)(?=\s*\()/,
        name: "support.function.dba.php"},
       {match: 
         /(?i)\bdbase_(?<_1>num(?<_2>fields|records)|c(?<_3>lose|reate)|delete_record|open|pack|add_record|get_(?<_4>header_info|record(?<_5>_with_names)?)|replace_record)(?=\s*\()/,
        name: "support.function.dbase.php"},
       {match: 
         /(?i)\b(?<_1>scandir|c(?<_2>h(?<_3>dir|root)|losedir)|dir|opendir|re(?<_4>addir|winddir)|g(?<_5>etcwd|lob))(?=\s*\()/,
        name: "support.function.dir.php"},
       {match: /(?i)\bdl(?=\s*\()/, name: "support.function.dl.php"},
       {match: 
         /(?i)\b(?<_1>dns_(?<_2>check_record|get_(?<_3>record|mx))|gethostby(?<_4>name(?<_5>l)?|addr))(?=\s*\()/,
        name: "support.function.dns.php"},
       {match: 
         /(?i)\bdom_document_(?<_1>s(?<_2>chema_validate(?<_3>_file)?|ave(?<_4>_html(?<_5>_file)?|xml)?)|normalize_document|create_(?<_6>c(?<_7>datasection|omment)|text_node|document_fragment|processing_instruction|e(?<_8>ntity_reference|lement(?<_9>_ns)?)|attribute(?<_10>_ns)?)|import_node|validate|load(?<_11>_html(?<_12>_file)?|xml)?|adopt_node|re(?<_13>name_node|laxNG_validate_(?<_14>file|xml))|get_element(?<_15>s_by_tag_name(?<_16>_ns)?|_by_id)|xinclude)(?=\s*\()/,
        name: "support.function.document.php"},
       {match: 
         /(?i)\bdom_domconfiguration_(?<_1>set_parameter|can_set_parameter|get_parameter)(?=\s*\()/,
        name: "support.function.domconfiguration.php"},
       {match: /(?i)\bdom_domerrorhandler_handle_error(?=\s*\()/,
        name: "support.function.domerrorhandler.php"},
       {match: 
         /(?i)\bdom_domimplementation_(?<_1>has_feature|create_document(?<_2>_type)?|get_feature)(?=\s*\()/,
        name: "support.function.domimplementation.php"},
       {match: /(?i)\bdom_domimplementationlist_item(?=\s*\()/,
        name: "support.function.domimplementationlist.php"},
       {match: 
         /(?i)\bdom_domimplementationsource_get_domimplementation(?<_1>s)?(?=\s*\()/,
        name: "support.function.domimplementationsource.php"},
       {match: /(?i)\bdom_domstringlist_item(?=\s*\()/,
        name: "support.function.domstringlist.php"},
       {match: /(?i)\beaster_da(?<_1>ys|te)(?=\s*\()/,
        name: "support.function.easter.php"},
       {match: 
         /(?i)\bdom_element_(?<_1>has_attribute(?<_2>_ns)?|set_(?<_3>id_attribute(?<_4>_n(?<_5>s|ode))?|attribute(?<_6>_n(?<_7>s|ode(?<_8>_ns)?))?)|remove_attribute(?<_9>_n(?<_10>s|ode))?|get_(?<_11>elements_by_tag_name(?<_12>_ns)?|attribute(?<_13>_n(?<_14>s|ode(?<_15>_ns)?))?))(?=\s*\()/,
        name: "support.function.element.php"},
       {match: 
         /(?i)\b(?<_1>s(?<_2>hell_exec|ystem)|p(?<_3>assthru|roc_nice)|e(?<_4>scapeshell(?<_5>cmd|arg)|xec))(?=\s*\()/,
        name: "support.function.exec.php"},
       {match: 
         /(?i)\bexif_(?<_1>imagetype|t(?<_2>humbnail|agname)|read_data)(?=\s*\()/,
        name: "support.function.exif.php"},
       {match: 
         /(?i)\bfdf_(?<_1>header|s(?<_2>et_(?<_3>s(?<_4>tatus|ubmit_form_action)|target_frame|o(?<_5>n_import_javascript|pt)|javascript_action|encoding|v(?<_6>ersion|alue)|f(?<_7>ile|lags)|ap)|ave(?<_8>_string)?)|next_field_name|c(?<_9>lose|reate)|open(?<_10>_string)?|e(?<_11>num_values|rr(?<_12>no|or))|add_(?<_13>template|doc_javascript)|remove_item|get_(?<_14>status|opt|encoding|v(?<_15>ersion|alue)|f(?<_16>ile|lags)|a(?<_17>ttachment|p)))(?=\s*\()/,
        name: "support.function.fdf.php"},
       {match: 
         /(?i)\b(?<_1>sys_get_temp_dir|copy|t(?<_2>empnam|mpfile)|u(?<_3>nlink|mask)|p(?<_4>close|open)|f(?<_5>s(?<_6>canf|tat|eek)|nmatch|close|t(?<_7>ell|runcate)|ile(?<_8>_(?<_9>put_contents|get_contents))?|open|p(?<_10>utcsv|assthru)|eof|flush|write|lock|read|get(?<_11>s(?<_12>s)?|c(?<_13>sv)?))|r(?<_14>e(?<_15>name|a(?<_16>dfile|lpath)|wind)|mdir)|get_meta_tags|mkdir)(?=\s*\()/,
        name: "support.function.file.php"},
       {match: 
         /(?i)\b(?<_1>stat|c(?<_2>h(?<_3>own|grp|mod)|learstatcache)|is_(?<_4>dir|executable|file|link|writable|readable)|touch|disk_(?<_5>total_space|free_space)|file(?<_6>size|ctime|type|inode|owner|_exists|perms|atime|group|mtime)|l(?<_7>stat|chgrp))(?=\s*\()/,
        name: "support.function.filestat.php"},
       {match: 
         /(?i)\bfilter_(?<_1>has_var|input(?<_2>_array)?|var(?<_3>_array)?)(?=\s*\()/,
        name: "support.function.filter.php"},
       {match: 
         /(?i)\b(?<_1>sprintf|printf|v(?<_2>sprintf|printf|fprintf)|fprintf)(?=\s*\()/,
        name: "support.function.formatted_print.php"},
       {match: /(?i)\b(?<_1>pfsockopen|fsockopen)(?=\s*\()/,
        name: "support.function.fsock.php"},
       {match: /(?i)\bftok(?=\s*\()/, name: "support.function.ftok.php"},
       {match: 
         /(?i)\b(?<_1>image(?<_2>s(?<_3>y|tring(?<_4>up)?|et(?<_5>style|t(?<_6>hickness|ile)|pixel|brush)|avealpha|x)|c(?<_7>har(?<_8>up)?|o(?<_9>nvolution|py(?<_10>res(?<_11>ized|ampled)|merge(?<_12>gray)?)?|lor(?<_13>s(?<_14>total|et|forindex)|closest(?<_15>hwb|alpha)?|transparent|deallocate|exact(?<_16>alpha)?|a(?<_17>t|llocate(?<_18>alpha)?)|resolve(?<_19>alpha)?|match))|reate(?<_20>truecolor|from(?<_21>string|jpeg|png|wbmp|g(?<_22>if|d(?<_23>2(?<_24>part)?)?)|x(?<_25>pm|bm)))?)|2wbmp|t(?<_26>ypes|tf(?<_27>text|bbox)|ruecolortopalette)|i(?<_28>struecolor|nterlace)|d(?<_29>estroy|ashedline)|jpeg|ellipse|p(?<_30>s(?<_31>slantfont|copyfont|text|e(?<_32>ncodefont|xtendfont)|freefont|loadfont|bbox)|ng|olygon|alettecopy)|f(?<_33>t(?<_34>text|bbox)|il(?<_35>ter|l(?<_36>toborder|ed(?<_37>polygon|ellipse|arc|rectangle))?)|ont(?<_38>height|width))|wbmp|a(?<_39>ntialias|lphablending|rc)|l(?<_40>ine|oadfont|ayereffect)|r(?<_41>otate|ectangle)|g(?<_42>if|d(?<_43>2)?|ammacorrect|rab(?<_44>screen|window))|xbm)|jpeg2wbmp|png2wbmp|gd_info)(?=\s*\()/,
        name: "support.function.gd.php"},
       {match: 
         /(?i)\b(?<_1>ngettext|textdomain|d(?<_2>ngettext|c(?<_3>ngettext|gettext)|gettext)|gettext|bind(?<_4>textdomain|_textdomain_codeset))(?=\s*\()/,
        name: "support.function.gettext.php"},
       {match: 
         /(?i)\bgmp_(?<_1>hamdist|s(?<_2>can(?<_3>1|0)|ign|trval|ub|etbit|qrt(?<_4>rem)?)|c(?<_5>om|lrbit|mp)|ne(?<_6>g|xtprime)|in(?<_7>tval|it|vert)|or|div(?<_8>_(?<_9>q(?<_10>r)?|r)|exact)|jacobi|p(?<_11>o(?<_12>pcount|w(?<_13>m)?)|erfect_square|rob_prime)|fact|legendre|a(?<_14>nd|dd|bs)|random|gcd(?<_15>ext)?|xor|m(?<_16>od|ul))(?=\s*\()/,
        name: "support.function.gmp.php"},
       {match: 
         /(?i)\bhash(?<_1>_(?<_2>hmac(?<_3>_file)?|init|update(?<_4>_(?<_5>stream|file))?|fi(?<_6>nal|le)|algos))?(?=\s*\()/,
        name: "support.function.hash.php"},
       {match: /(?i)\bmd5(?<_1>_file)?(?=\s*\()/,
        name: "support.function.hash_md.php"},
       {match: /(?i)\bsha1(?<_1>_file)?(?=\s*\()/,
        name: "support.function.hash_sha.php"},
       {match: 
         /(?i)\b(?<_1>set(?<_2>cookie|rawcookie)|header(?<_3>s_(?<_4>sent|list))?)(?=\s*\()/,
        name: "support.function.head.php"},
       {match: 
         /(?i)\b(?<_1>html(?<_2>specialchars(?<_3>_decode)?|_entity_decode|entities)|get_html_translation_table)(?=\s*\()/,
        name: "support.function.html.php"},
       {match: /(?i)\bhttp_build_query(?=\s*\()/,
        name: "support.function.http.php"},
       {match: 
         /(?i)\bibase_blob_(?<_1>c(?<_2>ancel|lose|reate)|i(?<_3>nfo|mport)|open|echo|add|get)(?=\s*\()/,
        name: "support.function.ibase_blobs.php"},
       {match: 
         /(?i)\bibase_(?<_1>set_event_handler|free_event_handler|wait_event)(?=\s*\()/,
        name: "support.function.ibase_events.php"},
       {match: 
         /(?i)\bibase_(?<_1>n(?<_2>um_(?<_3>params|fields|rows)|ame_result)|execute|p(?<_4>aram_info|repare)|f(?<_5>ield_info|etch_(?<_6>object|assoc|row)|ree_(?<_7>query|result))|query|affected_rows)(?=\s*\()/,
        name: "support.function.ibase_query.php"},
       {match: 
         /(?i)\bibase_(?<_1>serv(?<_2>ice_(?<_3>detach|attach)|er_info)|d(?<_4>elete_user|b_info)|add_user|restore|backup|m(?<_5>odify_user|aintain_db))(?=\s*\()/,
        name: "support.function.ibase_service.php"},
       {match: 
         /(?i)\b(?<_1>iconv(?<_2>_(?<_3>s(?<_4>tr(?<_5>pos|len|rpos)|ubstr|et_encoding)|get_encoding|mime_(?<_6>decode(?<_7>_headers)?|encode)))?|ob_iconv_handler)(?=\s*\()/,
        name: "support.function.iconv.php"},
       {match: 
         /(?i)\b(?<_1>image_type_to_(?<_2>extension|mime_type)|getimagesize)(?=\s*\()/,
        name: "support.function.image.php"},
       {match: 
         /(?i)\b(?<_1>zend_logo_guid|php(?<_2>credits|info|_(?<_3>sapi_name|ini_scanned_files|uname|egg_logo_guid|logo_guid|real_logo_guid)|version))(?=\s*\()/,
        name: "support.function.info.php"},
       {match: 
         /(?i)\bibase_(?<_1>c(?<_2>o(?<_3>nnect|mmit(?<_4>_ret)?)|lose)|trans|drop_db|pconnect|err(?<_5>code|msg)|gen_id|rollback(?<_6>_ret)?)(?=\s*\()/,
        name: "support.function.interbase.php"},
       {match: 
         /(?i)\bcurl_(?<_1>setopt(?<_2>_array)?|c(?<_3>opy_handle|lose)|init|e(?<_4>rr(?<_5>no|or)|xec)|version|getinfo)(?=\s*\()/,
        name: "support.function.interface.php"},
       {match: /(?i)\biptc(?<_1>parse|embed)(?=\s*\()/,
        name: "support.function.iptc.php"},
       {match: /(?i)\bjson_(?<_1>decode|encode)(?=\s*\()/,
        name: "support.function.json.php"},
       {match: /(?i)\blcg_value(?=\s*\()/, name: "support.function.lcg.php"},
       {match: 
         /(?i)\bldap_(?<_1>s(?<_2>tart_tls|ort|e(?<_3>t_(?<_4>option|rebind_proc)|arch)|asl_bind)|next_(?<_5>entry|attribute|reference)|co(?<_6>nnect|unt_entries|mpare)|t61_to_8859|8859_to_t61|d(?<_7>n2ufn|elete)|unbind|parse_re(?<_8>sult|ference)|e(?<_9>rr(?<_10>no|2str|or)|xplode_dn)|f(?<_11>irst_(?<_12>entry|attribute|reference)|ree_result)|add|list|get_(?<_13>option|dn|entries|values_len|attributes)|re(?<_14>name|ad)|mod_(?<_15>del|add|replace)|bind)(?=\s*\()/,
        name: "support.function.ldap.php"},
       {match: /(?i)\blevenshtein(?=\s*\()/,
        name: "support.function.levenshtein.php"},
       {match: 
         /(?i)\blibxml_(?<_1>set_streams_context|clear_errors|use_internal_errors|get_(?<_2>errors|last_error))(?=\s*\()/,
        name: "support.function.libxml.php"},
       {match: /(?i)\b(?<_1>symlink|link(?<_2>info)?|readlink)(?=\s*\()/,
        name: "support.function.link.php"},
       {match: /(?i)\b(?<_1>ezmlm_hash|mail)(?=\s*\()/,
        name: "support.function.mail.php"},
       {match: /(?i)\bset_time_limit(?=\s*\()/,
        name: "support.function.main.php"},
       {match: 
         /(?i)\b(?<_1>h(?<_2>ypot|exdec)|s(?<_3>in(?<_4>h)?|qrt)|number_format|c(?<_5>os(?<_6>h)?|eil)|is_(?<_7>nan|infinite|finite)|tan(?<_8>h)?|octdec|de(?<_9>c(?<_10>hex|oct|bin)|g2rad)|exp(?<_11>m1)?|p(?<_12>i|ow)|f(?<_13>loor|mod)|log(?<_14>1(?<_15>p|0))?|a(?<_16>sin(?<_17>h)?|cos(?<_18>h)?|tan(?<_19>h|2)?|bs)|r(?<_20>ound|ad2deg)|b(?<_21>indec|ase_convert))(?=\s*\()/,
        name: "support.function.math.php"},
       {match: 
         /(?i)\bmb_(?<_1>s(?<_2>tr(?<_3>str|cut|to(?<_4>upper|lower)|i(?<_5>str|pos|mwidth)|pos|width|len|r(?<_6>chr|i(?<_7>chr|pos)|pos))|ubst(?<_8>itute_character|r(?<_9>_count)?)|end_mail)|http_(?<_10>input|output)|c(?<_11>heck_encoding|onvert_(?<_12>case|encoding|variables|kana))|internal_encoding|output_handler|de(?<_13>code_(?<_14>numericentity|mimeheader)|tect_(?<_15>order|encoding))|encode_(?<_16>numericentity|mimeheader)|p(?<_17>arse_str|referred_mime_name)|l(?<_18>ist_(?<_19>encodings(?<_20>_alias_names)?|mime_names)|anguage)|get_info)(?=\s*\()/,
        name: "support.function.mbstring.php"},
       {match: 
         /(?i)\bm(?<_1>crypt_(?<_2>c(?<_3>fb|reate_iv|bc)|ofb|decrypt|e(?<_4>cb|nc(?<_5>_(?<_6>self_test|is_block_(?<_7>algorithm(?<_8>_mode)?|mode)|get_(?<_9>supported_key_sizes|iv_size|key_size|algorithms_name|modes_name|block_size))|rypt))|list_(?<_10>algorithms|modes)|ge(?<_11>neric(?<_12>_(?<_13>init|deinit))?|t_(?<_14>cipher_name|iv_size|key_size|block_size))|module_(?<_15>self_test|close|is_block_(?<_16>algorithm(?<_17>_mode)?|mode)|open|get_(?<_18>supported_key_sizes|algo_(?<_19>key_size|block_size))))|decrypt_generic)(?=\s*\()/,
        name: "support.function.mcrypt.php"},
       {match: /(?i)\bmd5(?<_1>_file)?(?=\s*\()/,
        name: "support.function.md5.php"},
       {match: /(?i)\bmetaphone(?=\s*\()/,
        name: "support.function.metaphone.php"},
       {match: 
         /(?i)\bmhash(?<_1>_(?<_2>count|keygen_s2k|get_(?<_3>hash_name|block_size)))?(?=\s*\()/,
        name: "support.function.mhash.php"},
       {match: /(?i)\b(?<_1>get(?<_2>timeofday|rusage)|microtime)(?=\s*\()/,
        name: "support.function.microtime.php"},
       {match: /(?i)\bmime_content_type(?=\s*\()/,
        name: "support.function.mime_magic.php"},
       {match: 
         /(?i)\b(?<_1>swf(?<_2>prebuiltclip_init|videostream_init)|ming_(?<_3>set(?<_4>scale|cubicthreshold)|use(?<_5>swfversion|constants)|keypress))(?=\s*\()/,
        name: "support.function.ming.php"},
       {match: 
         /(?i)\bcurl_multi_(?<_1>select|close|in(?<_2>it|fo_read)|exec|add_handle|getcontent|remove_handle)(?=\s*\()/,
        name: "support.function.multi.php"},
       {match: 
         /(?i)\bmysqli_(?<_1>s(?<_2>sl_set|t(?<_3>ore_result|at|mt_(?<_4>s(?<_5>tore_result|end_long_data|qlstate)|num_rows|close|in(?<_6>sert_id|it)|data_seek|p(?<_7>aram_count|repare)|e(?<_8>rr(?<_9>no|or)|xecute)|f(?<_10>ield_count|etch|ree_result)|a(?<_11>ttr_(?<_12>set|get)|ffected_rows)|res(?<_13>ult_metadata|et)|bind_(?<_14>param|result)))|e(?<_15>t_local_infile_(?<_16>handler|default)|lect_db)|qlstate)|n(?<_17>um_(?<_18>fields|rows)|ext_result)|c(?<_19>ha(?<_20>nge_user|racter_set_name)|ommit|lose)|thread_(?<_21>safe|id)|in(?<_22>sert_id|it|fo)|options|d(?<_23>ump_debug_info|ebug|ata_seek)|use_result|p(?<_24>ing|repare)|err(?<_25>no|or)|kill|f(?<_26>ield_(?<_27>seek|count|tell)|etch_(?<_28>field(?<_29>s|_direct)?|lengths|row)|ree_result)|warning_count|a(?<_30>utocommit|ffected_rows)|r(?<_31>ollback|eal_(?<_32>connect|escape_string|query))|get_(?<_33>server_(?<_34>info|version)|host_info|client_(?<_35>info|version)|proto_info)|more_results)(?=\s*\()/,
        name: "support.function.mysqli_api.php"},
       {match: /(?i)\bmysqli_embedded_server_(?<_1>start|end)(?=\s*\()/,
        name: "support.function.mysqli_embedded.php"},
       {match: 
         /(?i)\bmysqli_(?<_1>s(?<_2>tmt_get_warnings|et_charset)|connect(?<_3>_err(?<_4>no|or))?|query|fetch_(?<_5>object|a(?<_6>ssoc|rray))|get_(?<_7>charset|warnings)|multi_query)(?=\s*\()/,
        name: "support.function.mysqli_nonapi.php"},
       {match: 
         /(?i)\bmysqli_(?<_1>s(?<_2>end_query|lave_query)|disable_r(?<_3>pl_parse|eads_from_master)|enable_r(?<_4>pl_parse|eads_from_master)|rpl_(?<_5>p(?<_6>arse_enabled|robe)|query_type)|master_query)(?=\s*\()/,
        name: "support.function.mysqli_repl.php"},
       {match: /(?i)\bmysqli_report(?=\s*\()/,
        name: "support.function.mysqli_report.php"},
       {match: 
         /(?i)\bdom_namednodemap_(?<_1>set_named_item(?<_2>_ns)?|item|remove_named_item(?<_3>_ns)?|get_named_item(?<_4>_ns)?)(?=\s*\()/,
        name: "support.function.namednodemap.php"},
       {match: /(?i)\bdom_namelist_get_name(?<_1>space_uri)?(?=\s*\()/,
        name: "support.function.namelist.php"},
       {match: 
         /(?i)\bncurses_(?<_1>s(?<_2>how_panel|cr(?<_3>_(?<_4>set|init|dump|restore)|l)|ta(?<_5>nd(?<_6>out|end)|rt_color)|lk_(?<_7>set|noutrefresh|c(?<_8>olor|lear)|init|touch|attr(?<_9>set|o(?<_10>n|ff))?|re(?<_11>store|fresh))|avetty)|h(?<_12>ide_panel|line|a(?<_13>s_(?<_14>colors|i(?<_15>c|l)|key)|lfdelay))|n(?<_16>o(?<_17>nl|cbreak|echo|qiflush|raw)|ew(?<_18>_panel|pad|win)|apms|l)|c(?<_19>olor_(?<_20>set|content)|urs_set|l(?<_21>ear|rto(?<_22>eol|bot))|an_change_color|break)|t(?<_23>ypeahead|imeout|op_panel|erm(?<_24>name|attrs))|i(?<_25>sendwin|n(?<_26>s(?<_27>str|ch|tr|delln|ertln)|ch|it(?<_28>_(?<_29>color|pair))?))|d(?<_30>oupdate|e(?<_31>f(?<_32>ine_key|_(?<_33>shell_mode|prog_mode))|l(?<_34>ch|_panel|eteln|ay_output|win)))|u(?<_35>se_(?<_36>default_colors|e(?<_37>nv|xtended_names))|nget(?<_38>ch|mouse)|pdate_panels)|p(?<_39>noutrefresh|utp|a(?<_40>nel_(?<_41>window|above|below)|ir_content)|refresh)|e(?<_42>cho(?<_43>char)?|nd|rase(?<_44>char)?)|v(?<_45>idattr|line)|k(?<_46>illchar|ey(?<_47>ok|pad))|qiflush|f(?<_48>ilter|l(?<_49>ushinp|ash))|longname|w(?<_50>stand(?<_51>out|end)|hline|noutrefresh|c(?<_52>olor_set|lear)|erase|vline|a(?<_53>ttr(?<_54>set|o(?<_55>n|ff))|dd(?<_56>str|ch))|getch|refresh|mo(?<_57>use_trafo|ve)|border)|a(?<_58>ssume_default_colors|ttr(?<_59>set|o(?<_60>n|ff))|dd(?<_61>str|nstr|ch(?<_62>str|nstr)?))|r(?<_63>e(?<_64>set(?<_65>ty|_(?<_66>shell_mode|prog_mode))|place_panel|fresh)|aw)|get(?<_67>yx|ch|m(?<_68>ouse|axyx))|b(?<_69>o(?<_70>ttom_panel|rder)|eep|kgd(?<_71>set)?|audrate)|m(?<_72>o(?<_73>use(?<_74>interval|_trafo|mask)|ve(?<_75>_panel)?)|eta|v(?<_76>hline|cur|inch|delch|vline|waddstr|add(?<_77>str|nstr|ch(?<_78>str|nstr)?)|getch)))(?=\s*\()/,
        name: "support.function.ncurses_functions.php"},
       {match: 
         /(?i)\bdom_node_(?<_1>set_user_data|has_(?<_2>child_nodes|attributes)|normalize|c(?<_3>ompare_document_position|lone_node)|i(?<_4>s_(?<_5>s(?<_6>upported|ame_node)|default_namespace|equal_node)|nsert_before)|lookup_(?<_7>namespace_uri|prefix)|append_child|get_(?<_8>user_data|feature)|re(?<_9>place_child|move_child))(?=\s*\()/,
        name: "support.function.node.php"},
       {match: /(?i)\bdom_nodelist_item(?=\s*\()/,
        name: "support.function.nodelist.php"},
       {match: 
         /(?i)\bnsapi_(?<_1>virtual|re(?<_2>sponse_headers|quest_headers))(?=\s*\()/,
        name: "support.function.nsapi.php"},
       {match: 
         /(?i)\boci(?<_1>setbufferinglob|_(?<_2>s(?<_3>tatement_type|e(?<_4>t_prefetch|rver_version))|c(?<_5>o(?<_6>nnect|llection_(?<_7>size|trim|element_(?<_8>assign|get)|a(?<_9>ssign|ppend)|max)|mmit)|lose|ancel)|n(?<_10>um_(?<_11>fields|rows)|ew_(?<_12>c(?<_13>o(?<_14>nnect|llection)|ursor)|descriptor))|internal_debug|define_by_name|p(?<_15>connect|a(?<_16>ssword_change|rse))|e(?<_17>rror|xecute)|f(?<_18>ield_(?<_19>s(?<_20>cale|ize)|name|is_null|type(?<_21>_raw)?|precision)|etch(?<_22>_(?<_23>object|a(?<_24>ssoc|ll|rray)|row))?|ree_(?<_25>statement|collection|descriptor))|lob_(?<_26>s(?<_27>ize|eek|ave)|c(?<_28>opy|lose)|t(?<_29>ell|runcate)|i(?<_30>s_equal|mport)|e(?<_31>of|rase|xport)|flush|append|write(?<_32>_temporary)?|load|re(?<_33>wind|ad))|r(?<_34>ollback|esult)|bind_(?<_35>array_by_name|by_name))|fetchinto|getbufferinglob)(?=\s*\()/,
        name: "support.function.oci8_interface.php"},
       {match: 
         /(?i)\bopenssl_(?<_1>s(?<_2>ign|eal)|csr_(?<_3>sign|new|export(?<_4>_to_file)?|get_(?<_5>subject|public_key))|open|error_string|p(?<_6>ublic_(?<_7>decrypt|encrypt)|k(?<_8>cs(?<_9>12_(?<_10>export(?<_11>_to_file)?|read)|7_(?<_12>sign|decrypt|encrypt|verify))|ey_(?<_13>new|export(?<_14>_to_file)?|free|get_(?<_15>details|p(?<_16>ublic|rivate))))|rivate_(?<_17>decrypt|encrypt))|verify|x509_(?<_18>check(?<_19>_private_key|purpose)|parse|export(?<_20>_to_file)?|free|read))(?=\s*\()/,
        name: "support.function.openssl.php"},
       {match: 
         /(?i)\bo(?<_1>utput_(?<_2>add_rewrite_var|reset_rewrite_vars)|b_(?<_3>start|clean|implicit_flush|end_(?<_4>clean|flush)|flush|list_handlers|get_(?<_5>status|c(?<_6>ontents|lean)|flush|le(?<_7>ngth|vel))))(?=\s*\()/,
        name: "support.function.output.php"},
       {match: /(?i)\b(?<_1>unpack|pack)(?=\s*\()/,
        name: "support.function.pack.php"},
       {match: /(?i)\bget(?<_1>lastmod|my(?<_2>inode|uid|pid|gid))(?=\s*\()/,
        name: "support.function.pageinfo.php"},
       {match: 
         /(?i)\bpcntl_(?<_1>s(?<_2>ignal|etpriority)|exec|fork|w(?<_3>stopsig|termsig|if(?<_4>s(?<_5>ignaled|topped)|exited)|exitstatus|ait(?<_6>pid)?)|alarm|getpriority)(?=\s*\()/,
        name: "support.function.pcntl.php"},
       {match: /(?i)\bpdo_drivers(?=\s*\()/, name: "support.function.pdo.php"},
       {match: /(?i)\bpdo_drivers(?=\s*\()/,
        name: "support.function.pdo_dbh.php"},
       {match: 
         /(?i)\bpg_(?<_1>se(?<_2>nd_(?<_3>execute|prepare|query(?<_4>_params)?)|t_(?<_5>client_encoding|error_verbosity)|lect)|host|num_(?<_6>fields|rows)|c(?<_7>o(?<_8>n(?<_9>nect(?<_10>ion_(?<_11>status|reset|busy))?|vert)|py_(?<_12>to|from))|ancel_query|l(?<_13>ient_encoding|ose))|insert|t(?<_14>ty|ra(?<_15>nsaction_status|ce))|options|d(?<_16>elete|bname)|u(?<_17>n(?<_18>trace|escape_bytea)|pdate)|e(?<_19>scape_(?<_20>string|bytea)|nd_copy|xecute)|p(?<_21>connect|ing|ort|ut_line|arameter_status|repare)|version|f(?<_22>ield_(?<_23>size|n(?<_24>um|ame)|is_null|t(?<_25>ype(?<_26>_oid)?|able)|prtlen)|etch_(?<_27>object|a(?<_28>ssoc|ll(?<_29>_columns)?|rray)|r(?<_30>ow|esult))|ree_result)|query(?<_31>_params)?|affected_rows|l(?<_32>o_(?<_33>seek|c(?<_34>lose|reate)|tell|import|open|unlink|export|write|read(?<_35>_all)?)|ast_(?<_36>notice|oid|error))|get_(?<_37>notify|pid|result)|result_(?<_38>s(?<_39>tatus|eek)|error(?<_40>_field)?)|meta_data)(?=\s*\()/,
        name: "support.function.pgsql.php"},
       {match: 
         /(?i)\b(?<_1>virtual|apache_(?<_2>setenv|note|child_terminate|lookup_uri|get_(?<_3>version|modules)|re(?<_4>s(?<_5>et_timeout|ponse_headers)|quest_(?<_6>s(?<_7>ome_auth_required|ub_req_(?<_8>lookup_(?<_9>uri|file)|method_uri)|e(?<_10>t_(?<_11>etag|last_modified)|rver_port)|atisfies)|headers(?<_12>_(?<_13>in|out))?|is_initial_req|discard_request_body|update_mtime|err_headers_out|log_error|auth_(?<_14>name|type)|r(?<_15>un|emote_host)|meets_conditions)))|getallheaders)(?=\s*\()/,
        name: "support.function.php_apache.php"},
       {match: 
         /(?i)\b(?<_1>str(?<_2>totime|ftime)|checkdate|time(?<_3>zone_(?<_4>name_(?<_5>from_abbr|get)|identifiers_list|transitions_get|o(?<_6>pen|ffset_get)|abbreviations_list))?|idate|date(?<_7>_(?<_8>sun(?<_9>set|_info|rise)|create|isodate_set|time(?<_10>zone_(?<_11>set|get)|_set)|d(?<_12>efault_timezone_(?<_13>set|get)|ate_set)|offset_get|parse|format|modify))?|localtime|g(?<_14>etdate|m(?<_15>strftime|date|mktime))|mktime)(?=\s*\()/,
        name: "support.function.php_date.php"},
       {match: /(?i)\bdom_import_simplexml(?=\s*\()/,
        name: "support.function.php_dom.php"},
       {match: 
         /(?i)\bfbsql_(?<_1>hostname|s(?<_2>t(?<_3>op_db|art_db)|e(?<_4>t_(?<_5>characterset|transaction|password|lob_mode)|lect_db))|n(?<_6>um_(?<_7>fields|rows)|ext_result)|c(?<_8>hange_user|o(?<_9>nnect|mmit)|lo(?<_10>se|b_size)|reate_(?<_11>clob|db|blob))|table_name|insert_id|d(?<_12>ata(?<_13>_seek|base(?<_14>_password)?)|rop_db|b_(?<_15>status|query))|username|err(?<_16>no|or)|p(?<_17>connect|assword)|f(?<_18>ield_(?<_19>seek|name|t(?<_20>ype|able)|flags|len)|etch_(?<_21>object|field|lengths|a(?<_22>ssoc|rray)|row)|ree_result)|query|warnings|list_(?<_23>tables|dbs|fields)|a(?<_24>utocommit|ffected_rows)|get_autostart_info|r(?<_25>o(?<_26>ws_fetched|llback)|e(?<_27>sult|ad_(?<_28>clob|blob)))|blob_size)(?=\s*\()/,
        name: "support.function.php_fbsql.php"},
       {match: 
         /(?i)\bftp_(?<_1>s(?<_2>sl_connect|ystype|i(?<_3>te|ze)|et_option)|n(?<_4>list|b_(?<_5>continue|put|f(?<_6>put|get)|get))|c(?<_7>h(?<_8>dir|mod)|dup|onnect|lose)|delete|exec|p(?<_9>ut|asv|wd)|f(?<_10>put|get)|alloc|login|get(?<_11>_option)?|r(?<_12>ename|aw(?<_13>list)?|mdir)|m(?<_14>dtm|kdir))(?=\s*\()/,
        name: "support.function.php_ftp.php"},
       {match: 
         /(?i)\b(?<_1>virtual|apache_(?<_2>setenv|note|get(?<_3>_(?<_4>version|modules)|env)|response_headers)|getallheaders)(?=\s*\()/,
        name: "support.function.php_functions.php"},
       {match: 
         /(?i)\bimap_(?<_1>header(?<_2>s|info)|s(?<_3>can|tatus|ort|ubscribe|e(?<_4>t(?<_5>_quota|flag_full|acl)|arch)|avebody)|c(?<_6>heck|l(?<_7>ose|earflag_full)|reatemailbox)|num_(?<_8>recent|msg)|t(?<_9>hread|imeout)|8bit|delete(?<_10>mailbox)?|open|u(?<_11>n(?<_12>subscribe|delete)|id|tf(?<_13>7_(?<_14>decode|encode)|8))|e(?<_15>rrors|xpunge)|ping|qprint|fetch(?<_16>header|structure|_overview|body)|l(?<_17>sub|ist|ast_error)|a(?<_18>ppend|lerts)|get(?<_19>subscribed|_quota(?<_20>root)?|acl|mailboxes)|r(?<_21>e(?<_22>namemailbox|open)|fc822_(?<_23>parse_(?<_24>headers|adrlist)|write_address))|m(?<_25>sgno|ime_header_decode|ail(?<_26>_(?<_27>co(?<_28>py|mpose)|move)|boxmsginfo)?)|b(?<_29>inary|ody(?<_30>struct)?|ase64))(?=\s*\()/,
        name: "support.function.php_imap.php"},
       {match: 
         /(?i)\bmb_(?<_1>split|ereg(?<_2>i(?<_3>_replace)?|_(?<_4>search(?<_5>_(?<_6>setpos|init|pos|get(?<_7>pos|regs)|regs))?|replace|match))?|regex_(?<_8>set_options|encoding))(?=\s*\()/,
        name: "support.function.php_mbregex.php"},
       {match: 
         /(?i)\bsmfi_(?<_1>set(?<_2>timeout|flags|reply)|chgheader|delrcpt|add(?<_3>header|rcpt)|replacebody|getsymval)(?=\s*\()/,
        name: "support.function.php_milter.php"},
       {match: 
         /(?i)\bmsql_(?<_1>select_db|num_(?<_2>fields|rows)|c(?<_3>onnect|lose|reate_db)|d(?<_4>ata_seek|rop_db|b_query)|error|pconnect|f(?<_5>ield_(?<_6>seek|name|t(?<_7>ype|able)|flags|len)|etch_(?<_8>object|field|array|row)|ree_result)|query|affected_rows|list_(?<_9>tables|dbs|fields)|result)(?=\s*\()/,
        name: "support.function.php_msql.php"},
       {match: 
         /(?i)\bmssql_(?<_1>select_db|n(?<_2>um_(?<_3>fields|rows)|ext_result)|c(?<_4>onnect|lose)|init|data_seek|execute|pconnect|query|f(?<_5>ield_(?<_6>seek|name|type|length)|etch_(?<_7>object|field|a(?<_8>ssoc|rray)|row|batch)|ree_(?<_9>statement|result))|g(?<_10>uid_string|et_last_message)|r(?<_11>ows_affected|esult)|bind|min_(?<_12>error_severity|message_severity))(?=\s*\()/,
        name: "support.function.php_mssql.php"},
       {match: 
         /(?i)\bmysql_(?<_1>s(?<_2>tat|e(?<_3>t_charset|lect_db))|num_(?<_4>fields|rows)|c(?<_5>onnect|l(?<_6>ient_encoding|ose)|reate_db)|thread_id|in(?<_7>sert_id|fo)|d(?<_8>ata_seek|rop_db|b_query)|unbuffered_query|e(?<_9>scape_string|rr(?<_10>no|or))|p(?<_11>connect|ing)|f(?<_12>ield_(?<_13>seek|name|t(?<_14>ype|able)|flags|len)|etch_(?<_15>object|field|lengths|a(?<_16>ssoc|rray)|row)|ree_result)|query|affected_rows|list_(?<_17>tables|dbs|processes|fields)|re(?<_18>sult|al_escape_string)|get_(?<_19>server_info|host_info|client_info|proto_info))(?=\s*\()/,
        name: "support.function.php_mysql.php"},
       {match: 
         /(?i)\b(?<_1>solid_fetch_prev|odbc_(?<_2>s(?<_3>tatistics|pecialcolumns|etoption)|n(?<_4>um_(?<_5>fields|rows)|ext_result)|c(?<_6>o(?<_7>nnect|lumn(?<_8>s|privileges)|mmit)|ursor|lose(?<_9>_all)?)|table(?<_10>s|privileges)|data_source|e(?<_11>rror(?<_12>msg)?|xec(?<_13>ute)?)|p(?<_14>connect|r(?<_15>imarykeys|ocedure(?<_16>s|columns)|epare))|f(?<_17>ield_(?<_18>scale|n(?<_19>um|ame)|type|len)|oreignkeys|etch_(?<_20>into|object|array|row)|ree_result)|autocommit|longreadlen|gettypeinfo|r(?<_21>ollback|esult(?<_22>_all)?)|binmode))(?=\s*\()/,
        name: "support.function.php_odbc.php"},
       {match: 
         /(?i)\bpreg_(?<_1>split|quote|last_error|grep|replace(?<_2>_callback)?|match(?<_3>_all)?)(?=\s*\()/,
        name: "support.function.php_pcre.php"},
       {match: 
         /(?i)\b(?<_1>spl_(?<_2>classes|object_hash|autoload(?<_3>_(?<_4>call|unregister|extensions|functions|register))?)|class_(?<_5>implements|parents))(?=\s*\()/,
        name: "support.function.php_spl.php"},
       {match: 
         /(?i)\bsybase_(?<_1>se(?<_2>t_message_handler|lect_db)|num_(?<_3>fields|rows)|c(?<_4>onnect|lose)|d(?<_5>eadlock_retry_count|ata_seek)|unbuffered_query|pconnect|f(?<_6>ield_seek|etch_(?<_7>object|field|a(?<_8>ssoc|rray)|row)|ree_result)|query|affected_rows|result|get_last_message|min_(?<_9>server_severity|client_severity))(?=\s*\()/,
        name: "support.function.php_sybase_ct.php"},
       {match: 
         /(?i)\bsybase_(?<_1>select_db|num_(?<_2>fields|rows)|c(?<_3>onnect|lose)|data_seek|pconnect|f(?<_4>ield_seek|etch_(?<_5>object|field|array|row)|ree_result)|query|affected_rows|result|get_last_message|min_(?<_6>error_severity|message_severity))(?=\s*\()/,
        name: "support.function.php_sybase_db.php"},
       {match: 
         /(?i)\bxmlwriter_(?<_1>s(?<_2>tart_(?<_3>c(?<_4>omment|data)|d(?<_5>td(?<_6>_(?<_7>e(?<_8>ntity|lement)|attlist))?|ocument)|pi|element(?<_9>_ns)?|attribute(?<_10>_ns)?)|et_indent(?<_11>_string)?)|text|o(?<_12>utput_memory|pen_(?<_13>uri|memory))|end_(?<_14>c(?<_15>omment|data)|d(?<_16>td(?<_17>_(?<_18>e(?<_19>ntity|lement)|attlist))?|ocument)|pi|element|attribute)|f(?<_20>ull_end_element|lush)|write_(?<_21>c(?<_22>omment|data)|dtd(?<_23>_(?<_24>e(?<_25>ntity|lement)|attlist))?|pi|element(?<_26>_ns)?|attribute(?<_27>_ns)?|raw))(?=\s*\()/,
        name: "support.function.php_xmlwriter.php"},
       {match: 
         /(?i)\b(?<_1>s(?<_2>tat(?<_3>Name|Index)|et(?<_4>Comment(?<_5>Name|Index)|ArchiveComment))|c(?<_6>lose|reateEmptyDir)|delete(?<_7>Name|Index)|open|zip_(?<_8>close|open|entry_(?<_9>name|c(?<_10>ompress(?<_11>ionmethod|edsize)|lose)|open|filesize|read)|read)|unchange(?<_12>Name|Index|All)|locateName|addF(?<_13>ile|romString)|rename(?<_14>Name|Index)|get(?<_15>Stream|Comment(?<_16>Name|Index)|NameIndex|From(?<_17>Name|Index)|ArchiveComment))(?=\s*\()/,
        name: "support.function.php_zip.php"},
       {match: 
         /(?i)\bposix_(?<_1>s(?<_2>trerror|et(?<_3>sid|uid|pgid|e(?<_4>uid|gid)|gid))|ctermid|i(?<_5>satty|nitgroups)|t(?<_6>tyname|imes)|uname|kill|access|get(?<_7>sid|cwd|_last_error|uid|e(?<_8>uid|gid)|p(?<_9>id|pid|w(?<_10>nam|uid)|g(?<_11>id|rp))|login|rlimit|g(?<_12>id|r(?<_13>nam|oups|gid)))|mk(?<_14>nod|fifo))(?=\s*\()/,
        name: "support.function.posix.php"},
       {match: /(?i)\bproc_(?<_1>close|terminate|open|get_status)(?=\s*\()/,
        name: "support.function.proc_open.php"},
       {match: 
         /(?i)\bpspell_(?<_1>s(?<_2>tore_replacement|uggest|ave_wordlist)|c(?<_3>heck|onfig_(?<_4>save_repl|create|ignore|d(?<_5>ict_dir|ata_dir)|personal|r(?<_6>untogether|epl)|mode)|lear_session)|new(?<_7>_(?<_8>config|personal))?|add_to_(?<_9>session|personal))(?=\s*\()/,
        name: "support.function.pspell.php"},
       {match: /(?i)\bquoted_printable_decode(?=\s*\()/,
        name: "support.function.quot_print.php"},
       {match: 
         /(?i)\b(?<_1>srand|getrandmax|rand|mt_(?<_2>srand|getrandmax|rand))(?=\s*\()/,
        name: "support.function.rand.php"},
       {match: 
         /(?i)\breadline(?<_1>_(?<_2>c(?<_3>ompletion_function|allback_(?<_4>handler_(?<_5>install|remove)|read_char)|lear_history)|info|on_new_line|write_history|list_history|add_history|re(?<_6>display|ad_history)))?(?=\s*\()/,
        name: "support.function.readline.php"},
       {match: /(?i)\brecode_(?<_1>string|file)(?=\s*\()/,
        name: "support.function.recode.php"},
       {match: 
         /(?i)\b(?<_1>s(?<_2>plit(?<_3>i)?|ql_regcase)|ereg(?<_4>i(?<_5>_replace)?|_replace)?)(?=\s*\()/,
        name: "support.function.reg.php"},
       {match: 
         /(?i)\bsession_(?<_1>s(?<_2>tart|et_(?<_3>save_handler|cookie_params)|ave_path)|cache_(?<_4>expire|limiter)|name|i(?<_5>s_registered|d)|de(?<_6>stroy|code)|un(?<_7>set|register)|encode|write_close|reg(?<_8>ister|enerate_id)|get_cookie_params|module_name)(?=\s*\()/,
        name: "support.function.session.php"},
       {match: /(?i)\bsha1(?<_1>_file)?(?=\s*\()/,
        name: "support.function.sha1.php"},
       {match: /(?i)\bshmop_(?<_1>size|close|delete|open|write|read)(?=\s*\()/,
        name: "support.function.shmop.php"},
       {match: 
         /(?i)\bsimplexml_(?<_1>import_dom|load_(?<_2>string|file))(?=\s*\()/,
        name: "support.function.simplexml.php"},
       {match: /(?i)\bconfirm_extname_compiled(?=\s*\()/,
        name: "support.function.skeleton.php"},
       {match: 
         /(?i)\b(?<_1>snmp(?<_2>set|2_(?<_3>set|walk|real_walk|get(?<_4>next)?)|3_(?<_5>set|walk|real_walk|get(?<_6>next)?)|_(?<_7>set_(?<_8>oid_output_format|enum_print|valueretrieval|quick_print)|read_mib|get_(?<_9>valueretrieval|quick_print))|walk|realwalk|get(?<_10>next)?)|php_snmpv3)(?=\s*\()/,
        name: "support.function.snmp.php"},
       {match: 
         /(?i)\bsocket_(?<_1>s(?<_2>hutdown|trerror|e(?<_3>nd(?<_4>to)?|t_(?<_5>nonblock|option|block)|lect))|c(?<_6>onnect|l(?<_7>ose|ear_error)|reate(?<_8>_(?<_9>pair|listen))?)|write|l(?<_10>isten|ast_error)|accept|get(?<_11>sockname|_option|peername)|re(?<_12>cv(?<_13>from)?|ad)|bind)(?=\s*\()/,
        name: "support.function.sockets.php"},
       {match: /(?i)\bsoundex(?=\s*\()/, name: "support.function.soundex.php"},
       {match: /(?i)\biterator_(?<_1>count|to_array|apply)(?=\s*\()/,
        name: "support.function.spl_iterators.php"},
       {match: 
         /(?i)\bsqlite_(?<_1>has_prev|s(?<_2>ingle_query|eek)|n(?<_3>um_(?<_4>fields|rows)|ext)|c(?<_5>hanges|olumn|urrent|lose|reate_(?<_6>function|aggregate))|open|u(?<_7>nbuffered_query|df_(?<_8>decode_binary|encode_binary))|e(?<_9>scape_string|rror_string|xec)|p(?<_10>open|rev)|key|valid|query|f(?<_11>ield_name|etch_(?<_12>single|column_types|object|a(?<_13>ll|rray))|actory)|l(?<_14>ib(?<_15>encoding|version)|ast_(?<_16>insert_rowid|error))|array_query|rewind|busy_timeout)(?=\s*\()/,
        name: "support.function.sqlite.php"},
       {match: 
         /(?i)\bstream_(?<_1>s(?<_2>ocket_(?<_3>s(?<_4>hutdown|e(?<_5>ndto|rver))|client|enable_crypto|pair|accept|recvfrom|get_name)|e(?<_6>t_(?<_7>timeout|write_buffer|blocking)|lect))|co(?<_8>ntext_(?<_9>set_(?<_10>option|params)|create|get_(?<_11>default|options))|py_to_stream)|filter_(?<_12>prepend|append|remove)|get_(?<_13>contents|transports|line|wrappers|meta_data))(?=\s*\()/,
        name: "support.function.streamsfuncs.php"},
       {match: 
         /(?i)\b(?<_1>hebrev(?<_2>c)?|s(?<_3>scanf|imilar_text|tr(?<_4>s(?<_5>tr|pn)|natc(?<_6>asecmp|mp)|c(?<_7>hr|spn|oll)|i(?<_8>str|p(?<_9>slashes|cslashes|os|_tags))|t(?<_10>o(?<_11>upper|k|lower)|r)|_(?<_12>s(?<_13>huffle|plit)|ireplace|pad|word_count|r(?<_14>ot13|ep(?<_15>eat|lace)))|p(?<_16>os|brk)|r(?<_17>chr|ipos|ev|pos))|ubstr(?<_18>_(?<_19>co(?<_20>unt|mpare)|replace))?|etlocale)|c(?<_21>h(?<_22>unk_split|r)|ount_chars)|nl(?<_23>2br|_langinfo)|implode|trim|ord|dirname|uc(?<_24>first|words)|join|pa(?<_25>thinfo|rse_str)|explode|quotemeta|add(?<_26>slashes|cslashes)|wordwrap|l(?<_27>trim|ocaleconv)|rtrim|money_format|b(?<_28>in2hex|asename))(?=\s*\()/,
        name: "support.function.string.php"},
       {match: /(?i)\bdom_string_extend_find_offset(?<_1>16|32)(?=\s*\()/,
        name: "support.function.string_extend.php"},
       {match: 
         /(?i)\b(?<_1>syslog|closelog|openlog|define_syslog_variables)(?=\s*\()/,
        name: "support.function.syslog.php"},
       {match: 
         /(?i)\bmsg_(?<_1>s(?<_2>tat_queue|e(?<_3>nd|t_queue))|re(?<_4>ceive|move_queue)|get_queue)(?=\s*\()/,
        name: "support.function.sysvmsg.php"},
       {match: /(?i)\bsem_(?<_1>acquire|re(?<_2>lease|move)|get)(?=\s*\()/,
        name: "support.function.sysvsem.php"},
       {match: 
         /(?i)\bshm_(?<_1>detach|put_var|attach|get_var|remove(?<_2>_var)?)(?=\s*\()/,
        name: "support.function.sysvshm.php"},
       {match: 
         /(?i)\bdom_text_(?<_1>split_text|is_whitespace_in_element_content|replace_whole_text)(?=\s*\()/,
        name: "support.function.text.php"},
       {match: 
         /(?i)\btidy_(?<_1>c(?<_2>onfig_count|lean_repair)|is_x(?<_3>html|ml)|diagnose|error_count|parse_(?<_4>string|file)|access_count|warning_count|repair_(?<_5>string|file)|get(?<_6>opt|_(?<_7>h(?<_8>tml(?<_9>_ver)?|ead)|status|config|o(?<_10>utput|pt_doc)|error_buffer|r(?<_11>oot|elease)|body)))(?=\s*\()/,
        name: "support.function.tidy.php"},
       {match: /(?i)\btoken_(?<_1>name|get_all)(?=\s*\()/,
        name: "support.function.tokenizer.php"},
       {match: 
         /(?i)\b(?<_1>s(?<_2>trval|ettype)|i(?<_3>s_(?<_4>s(?<_5>calar|tring)|callable|nu(?<_6>ll|meric)|object|float|array|long|resource|bool)|ntval)|floatval|gettype)(?=\s*\()/,
        name: "support.function.type.php"},
       {match: /(?i)\buniqid(?=\s*\()/, name: "support.function.uniqid.php"},
       {match: 
         /(?i)\b(?<_1>url(?<_2>decode|encode)|parse_url|get_headers|rawurl(?<_3>decode|encode))(?=\s*\()/,
        name: "support.function.url.php"},
       {match: 
         /(?i)\bstream_(?<_1>filter_register|get_filters|bucket_(?<_2>new|prepend|append|make_writeable))(?=\s*\()/,
        name: "support.function.user_filters.php"},
       {match: /(?i)\bdom_userdatahandler_handle(?=\s*\()/,
        name: "support.function.userdatahandler.php"},
       {match: 
         /(?i)\bstream_wrapper_(?<_1>unregister|re(?<_2>store|gister))(?=\s*\()/,
        name: "support.function.userspace.php"},
       {match: /(?i)\bconvert_uu(?<_1>decode|encode)(?=\s*\()/,
        name: "support.function.uuencode.php"},
       {match: 
         /(?i)\b(?<_1>serialize|debug_zval_dump|unserialize|var_(?<_2>dump|export)|memory_get_(?<_3>usage|peak_usage))(?=\s*\()/,
        name: "support.function.var.php"},
       {match: /(?i)\bversion_compare(?=\s*\()/,
        name: "support.function.versioning.php"},
       {match: 
         /(?i)\bwddx_(?<_1>serialize_va(?<_2>lue|rs)|deserialize|packet_(?<_3>start|end)|add_vars)(?=\s*\()/,
        name: "support.function.wddx.php"},
       {match: 
         /(?i)\b(?<_1>utf8_(?<_2>decode|encode)|xml_(?<_3>set_(?<_4>start_namespace_decl_handler|notation_decl_handler|character_data_handler|default_handler|object|unparsed_entity_decl_handler|processing_instruction_handler|e(?<_5>nd_namespace_decl_handler|lement_handler|xternal_entity_ref_handler))|error_string|parse(?<_6>_into_struct|r_(?<_7>set_option|create(?<_8>_ns)?|free|get_option))?|get_(?<_9>current_(?<_10>column_number|line_number|byte_index)|error_code)))(?=\s*\()/,
        name: "support.function.xml.php"},
       {match: 
         /(?i)\bxmlrpc_(?<_1>se(?<_2>t_type|rver_(?<_3>c(?<_4>all_method|reate)|destroy|add_introspection_data|register_(?<_5>introspection_callback|method)))|is_fault|decode(?<_6>_request)?|parse_method_descriptions|encode(?<_7>_request)?|get_type)(?=\s*\()/,
        name: "support.function.xmlrpc-epi-php.php"},
       {match: /(?i)\bdom_xpath_(?<_1>evaluate|query|register_ns)(?=\s*\()/,
        name: "support.function.xpath.php"},
       {match: 
         /(?i)\bxsl_xsltprocessor_(?<_1>has_exslt_support|set_parameter|transform_to_(?<_2>doc|uri|xml)|import_stylesheet|re(?<_3>gister_php_functions|move_parameter)|get_parameter)(?=\s*\()/,
        name: "support.function.xsltprocessor.php"},
       {match: 
         /(?i)\b(?<_1>ob_gzhandler|zlib_get_coding_type|readgzfile|gz(?<_2>compress|inflate|deflate|open|uncompress|encode|file))(?=\s*\()/,
        name: "support.function.zlib.php"},
       {match: /(?i)\bis_int(?<_1>eger)?(?=\s*\()/,
        name: "support.function.alias.php"},
       {match: 
         /(?i)\b(?<_1>Re(?<_2>cursive(?<_3>RegexIterator|CachingIterator|IteratorIterator|DirectoryIterator|FilterIterator|ArrayIterator)|flection(?<_4>Method|Class|Object|Extension|P(?<_5>arameter|roperty)|Function)?|gexIterator)|s(?<_6>tdClass|wf(?<_7>s(?<_8>hape|ound|prite)|text(?<_9>field)?|displayitem|f(?<_10>ill|ont(?<_11>cha(?<_12>r)?)?)|action|gradient|mo(?<_13>vie|rph)|b(?<_14>itmap|utton)))|XMLReader|tidyNode|S(?<_15>impleXML(?<_16>Iterator|Element)|oap(?<_17>Server|Header|Client|Param|Var|Fault)|pl(?<_18>TempFileObject|ObjectStorage|File(?<_19>Info|Object)))|NoRewindIterator|C(?<_20>OMPersistHelper|achingIterator)|I(?<_21>nfiniteIterator|teratorIterator)|D(?<_22>irectoryIterator|OM(?<_23>XPath|Node|C(?<_24>omment|dataSection)|Text|Document(?<_25>Fragment)?|ProcessingInstruction|E(?<_26>ntityReference|lement)|Attr))|P(?<_27>DO(?<_28>Statement)?|arentIterator)|E(?<_29>rrorException|mptyIterator|xception)|FilterIterator|LimitIterator|A(?<_30>p(?<_31>pendIterator|acheRequest)|rray(?<_32>Iterator|Object)))(?=\s*\()/,
        name: "support.class.builtin.php"},
       {match: 
         /(?i)\b(?<_1>(?<_2>print|echo)\b|(?<_3>isset|unset|e(?<_4>val|mpty)|list)(?=\s*\())/,
        name: "support.function.construct.php"}]},
   var_basic: 
    {captures: {1 => {name: "punctuation.definition.variable.php"}},
     match: 
      /(?x)
	            (?<_1>\$+)[a-zA-Z_\x7f-\xff]
	            [a-zA-Z0-9_\x7f-\xff]*?\b/n,
     name: "variable.other.php"},
   var_global: 
    {captures: {1 => {name: "punctuation.definition.variable.php"}},
     match: /(?<_1>\$)(?<_2>_(?<_3>COOKIE|FILES|GET|POST|REQUEST))\b/,
     name: "variable.other.global.php"},
   var_global_safer: 
    {captures: {2 => {name: "punctuation.definition.variable.php"}},
     match: 
      /(?<_1>(?<_2>\$)(?<_3>GLOBALS|_(?<_4>ENV|SERVER|SESSION)))|\b(?<_5>global)\b/,
     name: "variable.other.global.safer.php"},
   variables: 
    {patterns: 
      [{include: "#var_global"},
       {include: "#var_global_safer"},
       {include: "#var_basic"}]}},
 scopeName: "source.php",
 uuid: "22986475-8CA5-11D9-AEDD-000D93C8BE28"}
