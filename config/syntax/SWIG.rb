# Encoding: UTF-8

{fileTypes: ["i", "swg"],
 foldingStartMarker: /(?<_1>\/\*\*|%?\{\s*$)/,
 foldingStopMarker: /(?<_1>\*\*\/|^\s*%?\})/,
 keyEquivalent: "^~S",
 name: "SWIG",
 patterns: 
  [{comment: 
     "SWIG files contain C or C++ code, so it's logical to derive from the C++ rules",
    include: "source.c++"},
   {captures: {1 => {name: "punctuation.definition.keyword.swig"}},
    match: /(?<_1>%)(?<_2>header|init|inline|native|runtime|wrapper)\b/,
    name: "keyword.other.directive.inlinecode.swig"},
   {captures: {1 => {name: "punctuation.definition.keyword.swig"}},
    match: 
     /(?<_1>\$)(?<_2>[\*&]*[1-9]+(?<_3>_name|_type|_ltype|_basetype|_mangle|_descriptor){0,1}|action|input|result|symname)\b/,
    name: "keyword.other.function-parameter.swig"},
   {match: 
     /\b(?<_1>in|out|typecheck|arginit|default|check|argout|freearg|newfree|memberin|varin|varout|throws|numinputs)\b/,
    name: "support.function.type.swig"},
   {captures: {1 => {name: "punctuation.definition.keyword.swig"}},
    match: 
     /(?<_1>%)(?<_2>apply|callback|clear|constant|contract|define|enddef|extend|feature|ignore|insert|makedefault|module|nocallback|nodefault|rename|typemap|varargs|template)\b/,
    name: "keyword.other.directive.swig"},
   {captures: {1 => {name: "keyword.control.import.swig"}},
    match: 
     /\(\s*(?<_1>allegrocl|chicken|csharp|guile|java|modula3|mzscheme|ocaml|perl|php|pike|python|ruby|sexp|tcl|xml)\b/,
    name: "meta.preprocessor.swig"},
   {begin: 
     /^\s*(?<_1>%)\s*(?<_2>include|import)\b\s+(?<_3>"?[A-Za-z0-9\._]+"?)/,
    captures: 
     {1 => {name: "punctuation.definition.preprocessor.swig"},
      2 => {name: "keyword.control.import.swig"},
      3 => {name: "string.quoted.double.swig"}},
    end: "$",
    name: "meta.preprocessor.swig"},
   {captures: {1 => {name: "punctuation.definition.preprocessor.swig"}},
    match: /(?<_1>%)(?<_2>[A-Za-z]+[A-Za-z0-9_]*)\b/,
    name: "meta.preprocessor.macro.swig"},
   {match: 
     /\bSWIG_TYPECHECK_(?<_1>POINTER|VOIDPTR|BOOL|UINT8|INT8|UINT16|INT16|UINT32|INT32|UINT64|INT64|UINT128|INT128|INTEGER|FLOAT|DOUBLE|COMPLEX|UNICHAR|UNISTRING|CHAR|STRING|BOOL_ARRAY|INT8_ARRAY|INT16_ARRAY|INT32_ARRAY|INT64_ARRAY|INT128_ARRAY|FLOAT_ARRAY|DOUBLE_ARRAY|CHAR_ARRAY|STRING_ARRAY)\b/,
    name: "storage.type.swig"},
   {captures: {1 => {name: "punctuation.section.embedded.swig"}},
    match: /(?<_1>%\{|%\})/,
    name: "source.swig.codeblock"}],
 scopeName: "source.swig",
 uuid: "C781B0D0-BED9-11D9-A141-000393A143CC"}
