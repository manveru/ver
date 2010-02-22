# Encoding: UTF-8

{fileTypes: ["pro", "pri"],
 keyEquivalent: "^~Q",
 name: "qmake Project file",
 patterns: 
  [{begin: /(?<_1>TEMPLATE)\s*(?<_2>=)/,
    captures: 
     {1 => {name: "variable.language.qmake"},
      2 => {name: "punctuation.separator.key-value.qmake"}},
    end: "$\\n?",
    name: "markup.other.template.qmake",
    patterns: 
     [{match: /\b(?<_1>app|lib|subdirs|vcapp|vclib)\b/,
       name: "keyword.other.qmake"}]},
   {begin: /(?<_1>CONFIG)\s*(?<_2>\+|\-)?(?<_3>=)/,
    captures: 
     {1 => {name: "variable.language.qmake"},
      3 => {name: "punctuation.separator.key-value.qmake"}},
    end: "$\\n?",
    name: "markup.other.config.qmake",
    patterns: 
     [{match: 
        /\b(?<_1>release|debug|warn_(?<_2>on|off)|qt|opengl|thread|x11|windows|console|dll|staticlib|plugin|designer|uic3|no_lflags_merge|exceptions|rtti|stl|flat|app_bundle|no_batch|qtestlib|ppc|x86)\b/,
       name: "keyword.other.qmake"}]},
   {begin: /(?<_1>QT)\s*(?<_2>\+|\-)?(?<_3>=)/,
    captures: 
     {1 => {name: "variable.language.qmake"},
      3 => {name: "punctuation.separator.key-value.qmake"}},
    end: "$\\n?",
    name: "markup.other.qt.qmake",
    patterns: 
     [{match: /\b(?<_1>core|gui|network|opengl|sql|svg|xml|qt3support)\b/,
       name: "keyword.other.qmake"}]},
   {match: 
     /\b(?<_1>R(?<_2>C(?<_3>C_DIR|_FILE)|E(?<_4>S_FILE|QUIRES))|M(?<_5>OC_DIR|AKE(?<_6>_MAKEFILE|FILE(?<_7>_GENERATOR)?))|S(?<_8>RCMOC|OURCES|UBDIRS)|HEADERS|YACC(?<_9>SOURCES|IMPLS|OBJECTS)|CONFIG|T(?<_10>RANSLATIONS|ARGET(?<_11>_(?<_12>EXT|\d+(?<_13>\.\d+\.\d+)?))?)|INCLUDEPATH|OBJ(?<_14>MOC|ECTS(?<_15>_DIR)?)|D(?<_16>SP_TEMPLATE|ISTFILES|E(?<_17>STDIR(?<_18>_TARGET)?|PENDPATH|F(?<_19>_FILE|INES))|LLDESTDIR)|UI(?<_20>C(?<_21>IMPLS|OBJECTS)|_(?<_22>SOURCES_DIR|HEADERS_DIR|DIR))|P(?<_23>RE(?<_24>COMPILED_HEADER|_TARGETDEPS)|OST_TARGETDEPS)|V(?<_25>PATH|ER(?<_26>SION|_(?<_27>M(?<_28>IN|AJ)|PAT)))|Q(?<_29>MAKE(?<_30>SPEC|_(?<_31>RUN_C(?<_32>XX(?<_33>_IMP)?|C(?<_34>_IMP)?)|MOC_SRC|C(?<_35>XXFLAGS_(?<_36>RELEASE|MT(?<_37>_D(?<_38>BG|LL(?<_39>DBG)?))?|SHLIB|THREAD|DEBUG|WARN_O(?<_40>N|FF))|FLAGS_(?<_41>RELEASE|MT(?<_42>_D(?<_43>BG|LL(?<_44>DBG)?))?|SHLIB|THREAD|DEBUG|WARN_O(?<_45>N|FF))|LEAN)|TARGET|IN(?<_46>CDIR(?<_47>_(?<_48>X|THREAD|OPENGL|QT))?|FO_PLIST)|UIC|P(?<_49>RE_LINK|OST_LINK)|EXT(?<_50>_(?<_51>MOC|H|CPP|YACC|OBJ|UI|PRL|LEX)|ENSION_SHLIB)|Q(?<_52>MAKE|T_DLL)|F(?<_53>ILETAGS|AILED_REQUIREMENTS)|L(?<_54>N_SHLIB|I(?<_55>B(?<_56>S(?<_57>_(?<_58>RT(?<_59>MT)?|X|CONSOLE|THREAD|OPENGL(?<_60>_QT)?|QT(?<_61>_(?<_62>OPENGL|DLL))?|WINDOWS))?|_FLAG|DIR(?<_63>_(?<_64>X|OPENGL|QT|FLAGS))?)|NK_SHLIB_CMD)|FLAGS(?<_65>_(?<_66>RELEASE|S(?<_67>H(?<_68>LIB|APP)|ONAME)|CONSOLE(?<_69>_DLL)?|THREAD|DEBUG|PLUGIN|QT_DLL|WINDOWS(?<_70>_DLL)?))?)|A(?<_71>R_CMD|PP_(?<_72>OR_DLL|FLAG))))?|T_THREAD)|FORMS|L(?<_73>IBS|EX(?<_74>SOURCES|IMPLS|OBJECTS)))\b/,
    name: "variable.language.qmake"},
   {begin: 
     /(?<_1>\b(?<_2>[\w\d_]+\.[\w\d_]+|[A-Z_]+))?\s*(?<_3>\+|\-)?(?<_4>=)/,
    captures: 
     {1 => {name: "variable.other.qmake"},
      4 => {name: "punctuation.separator.key-value.qmake"}},
    end: "$\\n?",
    name: "markup.other.assignment.qmake",
    patterns: 
     [{captures: {1 => {name: "punctuation.definition.variable.qmake"}},
       match: /(?<_1>\$\$)(?<_2>[A-Z_]+|[\w\d_]+\.[\w\d_]+)|\$\([\w\d_]+\)/,
       name: "variable.other.qmake"},
      {match: /[\w\d\/_\-\.\:]+/, name: "constant.other.filename.qmake"},
      {begin: /"/,
       beginCaptures: 
        {0 => {name: "punctuation.definition.string.begin.qmake"}},
       end: "\"",
       endCaptures: {0 => {name: "punctuation.definition.string.end.qmake"}},
       name: "string.quoted.double.qmake"},
      {begin: /`/,
       beginCaptures: 
        {0 => {name: "punctuation.definition.string.begin.qmake"}},
       end: "`",
       endCaptures: {0 => {name: "punctuation.definition.string.end.qmake"}},
       name: "string.interpolated.qmake"},
      {begin: /(?<_1>\\)/,
       captures: {1 => {name: "string.regexp.qmake"}},
       end: "^[^#]",
       name: "markup.other.assignment.continuation.qmake",
       patterns: 
        [{captures: {1 => {name: "punctuation.definition.comment.qmake"}},
          match: /(?<_1>#).*$\n?/,
          name: "comment.line.number-sign.qmake"}]},
      {captures: {1 => {name: "punctuation.definition.comment.qmake"}},
       match: /(?<_1>#).*$\n?/,
       name: "comment.line.number-sign.qmake"}]},
   {begin: 
     /\b(?<_1>basename|CONFIG|contains|count|dirname|error|exists|find|for|include|infile|isEmpty|join|member|message|prompt|quote|sprintf|system|unique|warning)\s*(?<_2>\()/,
    beginCaptures: 
     {1 => {name: "entity.name.function.qmake"},
      2 => {name: "punctuation.definition.parameters.qmake"}},
    comment: "entity.name.function.qmake",
    contentName: "variable.parameter.qmake",
    end: "(\\))",
    endCaptures: {1 => {name: "punctuation.definition.parameters.qmake"}}},
   {match: /\b(?<_1>unix|win32|mac|debug|release)\b/,
    name: "keyword.other.scope.qmake"},
   {captures: {1 => {name: "punctuation.definition.comment.qmake"}},
    match: /(?<_1>#).*$\n?/,
    name: "comment.line.number-sign.qmake"}],
 scopeName: "source.qmake",
 uuid: "3D54A8F9-17CA-422A-A1D6-DE5F98B9DEF4"}
