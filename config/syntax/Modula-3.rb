# Encoding: UTF-8

{fileTypes: ["m3", "cm3"],
 keyEquivalent: "^~M",
 name: "Modula-3",
 patterns: 
  [{match: 
     /\b(?<_1>ANY|ARRAY|AS|BEGIN|BITS|BRANDED|BY|CASE|CONST|DIV|DO|ELSE|ELSIF|END|EVAL|EXCEPT|EXCEPTION|EXIT|EXPORTS|FINALLY|FOR|FROM|GENERIC|IF|IMPORT|INTERFACE|LOCK|LOOP|METHODS|MOD|MODULE|OBJECT|OF|OVERRIDES|PROCEDURE|RAISE|RAISES|READONLY|RECORD|REF|REPEAT|RETURN|REVEAL|ROOT|SET|THEN|TO|TRY|TYPE|TYPECASE|UNSAFE|UNTIL|UNTRACED|VALUE|VAR|WHILE|WITH|IN|NOT|AND|OR)\b/,
    name: "keyword.other.modula-3"},
   {match: 
     /\b(?<_1>ABS|ADDRESS|ADR|ADRSIZE|BITSIZE|BOOLEAN|BYTESIZE|CARDINAL|CEILING|CHAR|DEC|DISPOSE|EXTENDED|FIRST|FLOAT|FLOOR|INC|INTEGER|ISTYPE|LAST|LONGREAL|LOOPHOLE|MAX|MIN|MUTEX|NARROW|NEW|NUMBER|ORD|REAL|REFANY|ROUND|SUBARRAY|TEXT|TRUNC|TYPECODE|VAL)\b/,
    name: "storage.type.modula-3"},
   {match: /\b(?<_1>FALSE|NIL|NULL|TRUE)\b/,
    name: "constant.language.modula-3"},
   {match: 
     /\b(?<_1>(?<_2>0(?<_3>x|X)[0-9a-fA-F]*)|(?<_4>(?<_5>[0-9]+\.?[0-9]*)|(?<_6>\.[0-9]+))(?<_7>(?<_8>e|E)(?<_9>\+|-)?[0-9]+)?)(?<_10>L|l|UL|ul|u|U|F|f|ll|LL|ull|ULL)?\b/,
    name: "constant.numeric.modula-3"},
   {begin: /'/,
    beginCaptures: 
     {0 => {name: "punctuation.definition.string.begin.modula-3"}},
    end: "'",
    endCaptures: {0 => {name: "punctuation.definition.string.end.modula-3"}},
    name: "string.quoted.single.modula-3",
    patterns: 
     [{match: /\\(?<_1>[ntrf\\'"]|(?<_2>[0-7]{3}))/,
       name: "constant.character.escape.modula-3"}]},
   {begin: /"/,
    beginCaptures: 
     {0 => {name: "punctuation.definition.string.begin.modula-3"}},
    end: "\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.modula-3"}},
    name: "string.quoted.double.modula-3",
    patterns: 
     [{match: /\\(?<_1>[ntrf\\'"]|(?<_2>[0-7]{3}))/,
       name: "constant.character.escape.modula-3"}]},
   {begin: /\(\*/,
    captures: {0 => {name: "punctuation.definition.comment.modula-3"}},
    end: "\\*\\)",
    name: "comment.block.modula-3"}],
 scopeName: "source.modula-3",
 uuid: "479D53FA-6ED6-11D9-8471-0011242E4184"}
