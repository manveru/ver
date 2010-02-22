# Encoding: UTF-8

{fileTypes: ["CMakeLists.txt", "cmake"],
 foldingStartMarker: /\/\*\*|\{\s*$/,
 foldingStopMarker: /\*\*\/|^\s*\}/,
 keyEquivalent: "^~C",
 name: "CMake Listfile",
 patterns: 
  [{begin: /(?i)^\s*(?<_1>function|macro)\s*(?<_2>\()/,
    beginCaptures: 
     {1 => {name: "support.function.cmake"},
      2 => {name: "punctuation.definition.parameters.begin.command.cmake"}},
    contentName: "meta.function-call.function.cmake",
    end: "(\\))",
    endCaptures: 
     {1 => {name: "punctuation.definition.parameters.end.command.cmake"}},
    name: "meta.function-call.command.cmake",
    patterns: [{include: "#argument-constants"}, {include: "#items"}]},
   {begin: 
     /(?ix)
	^\s*	# Start of the line with optional preceding space
	(?:	# Either a control flow keyword
	(?<_1>(?:end)?(?:if|while|foreach|else)|return)
	|	# Or a function
	(?<_2>s(?:tring|ite_name|ource_group|ubdir(?:s|_depends)|e(?:t(?:_(?:source_files_properties|t(?:ests_properties|arget_properties)|directory_properties|property))?|parate_arguments))|c(?:onfigure_file|reate_test_sourcelist|make(?:_(?:policy|minimum_required)| version 2.6-patch 0))|t(?:arget_link_libraries|ry_(?:compile|run))|i(?:n(?:stall(?:_(?:targets|programs|files))?|clude(?:_(?:directories|external_msproject|regular_expression))?)|f)|o(?:utput_required_files|ption)|define_property|u(?:se_mangled_mesa|tility_source)|project|e(?:n(?:d(?:if|f(?:oreach|unction)|while|macro)|able_(?:testing|language))|lse(?:if)?|x(?:port(?:_library_dependencies)?|ec(?:_program|ute_process)))|variable_(?:watch|requires)|qt_wrap_(?:cpp|ui)|f(?:i(?:nd_(?:p(?:a(?:ckage|th)|rogram)|file|library)|le)|oreach|unction|ltk_wrap_ui)|w(?:hile|rite_file)|l(?:i(?:st|nk_(?:directories|libraries))|oad_c(?:ommand|ache))|a(?:dd_(?:subdirectory|custom_(?:command|target)|test|de(?:pendencies|finitions)|executable|library)|ux_source_directory)|re(?:turn|move(?:_definitions)?)|get_(?:source_file_property|cmake_property|t(?:est_property|arget_property)|directory_property|property|filename_component)|m(?:essage|a(?:cro|th|ke_directory|rk_as_advanced))|b(?:uild_(?:name|command)|reak))
	|	# Or some function we don’t know about
	(?<_3>\w+)
	)
	\s*(?<_4>\()	# Finally, the opening parenthesis for the argument list
	/,
    beginCaptures: 
     {1 => {name: "keyword.control.cmake"},
      2 => {name: "support.function.cmake"},
      3 => {name: "punctuation.definition.parameters.begin.command.cmake"}},
    comment: 
     "The command list is simply generated with:\n\t\t\t\tcmake --help-command-list | ruby /Library/Application\\ Support/TextMate/Bundles/Objective-C.tmbundle/Support/list_to_regexp.rb | pbcopy",
    end: "(\\))",
    endCaptures: 
     {1 => {name: "punctuation.definition.parameters.end.command.cmake"}},
    name: "meta.function-call.command.cmake",
    patterns: [{include: "#argument-constants"}, {include: "#items"}]},
   {include: "#items"}],
 repository: 
  {:"argument-constants" => 
    {comment: 
      "There is a script in bundle support for generating this list:\n\t\t\t\truby arg_separators.rb | /Library/Application\\ Support/TextMate/Bundles/Objective-C.tmbundle/Support/list_to_regexp.rb | pbcopy",
     match: 
      /\b(?<_1>R(?<_2>UN(?<_3>_(?<_4>RESULT_VAR|OUTPUT_VARIABLE)|TIME(?<_5>_DIRECTORY)?)|E(?<_6>G(?<_7>ULAR_EXPRESSION|EX)|MOVE(?<_8>_(?<_9>RECURSE|ITEM|DUPLICATES|AT))?|S(?<_10>OURCE|ULT_VAR(?<_11>IABLE)?)|NAME|TURN_VALUE|PLACE|VERSE|QUIRED(?<_12>_VARIABLE)?|LATIVE(?<_13>_PATH)?|AD(?<_14>_WITH_PREFIX)?)|AN(?<_15>GE|DOM))|G(?<_16>R(?<_17>OUP_(?<_18>READ|EXECUTE)|EATER)|ET|LOB(?<_19>_RECURSE|AL)?)|M(?<_20>ODULE|ESSAGE|A(?<_21>COSX_BUNDLE|TCH(?<_22>ES|ALL)?|IN_DEPENDENCY|KE_DIRECTORY))|B(?<_23>RIEF_DOCS|UNDLE|EFORE)|S(?<_24>HARED|YSTEM|CRIPT|T(?<_25>R(?<_26>GREATER|I(?<_27>NGS|P)|EQUAL|LESS)|AT(?<_28>IC|US))|O(?<_29>RT|URCE)|UBSTRING|E(?<_30>ND_ERROR|T))|HEX|N(?<_31>NNN|O(?<_32>_(?<_33>MODULE|SYSTEM_ENVIRONMENT_PATH|HEX_CONVERSION|CMAKE_(?<_34>BUILDS_PATH|SYSTEM_PATH|PATH|ENVIRONMENT_PATH|FIND_ROOT_PATH)|DEFAULT_PATH)|T(?<_35>E(?<_36>QUAL)?)?)|EW(?<_37>LINE_CONSUME)?|AME(?<_38>S(?<_39>PACE)?|_WE|LINK_(?<_40>SKIP|ONLY))?)|C(?<_41>XX|M(?<_42>P|AKE_(?<_43>CROSSCOMPILING|F(?<_44>IND_ROOT_PATH_BOTH|LAGS)))?|O(?<_45>M(?<_46>M(?<_47>ENT|AND(?<_48>_NAME)?)|P(?<_49>ILE_(?<_50>RESULT_VAR|OUTPUT_VARIABLE|DEFINITIONS)|ONENT(?<_51>S)?|ARE))|NFIG(?<_52>S|UR(?<_53>E(?<_54>_FILE)?|ATIONS))|DE|PY(?<_55>_FILE|ONLY))|VS|LEAR|ACHE(?<_56>D_VARIABLE)?)|T(?<_57>IMEOUT|O(?<_58>_(?<_59>NATIVE_PATH|CMAKE_PATH)|UPPER|LOWER)|EST(?<_60>_VARIABLE)?|ARGET(?<_61>S)?)|I(?<_62>MP(?<_63>ORTED|LICIT_DEPENDS)|S_(?<_64>NEWER_THAN|DIRECTORY|ABSOLUTE)|N(?<_65>SERT|HERITED|CLUDE_(?<_66>INTERNALS|DIRECTORIES)|PUT_FILE))|O(?<_67>R|NLY(?<_68>_CMAKE_FIND_ROOT_PATH)?|UTPUT(?<_69>_(?<_70>STRIP_TRAILING_WHITESPACE|DIRECTORY|VARIABLE|QUIET|FILE))?|PTIONAL|FFSET|WNER_(?<_71>READ|EXECUTE|WRITE)|LD)|D(?<_72>BAR|IRECTORY(?<_73>_PERMISSIONS)?|O(?<_74>C|WNLOAD)|E(?<_75>STINATION|PENDS|FINED)|FOO)|USE_SOURCE_PERMISSIONS|P(?<_76>R(?<_77>IVATE_HEADER|O(?<_78>GRAM(?<_79>S|_ARGS)?|PERT(?<_80>Y|IES))|E(?<_81>_(?<_82>BUILD|LINK)|ORDER))|O(?<_83>ST_BUILD|P|LICY)|U(?<_84>BLIC_HEADER|SH)|ERMISSIONS|A(?<_85>RENT_SCOPE|T(?<_86>H(?<_87>S|_(?<_88>SUFFIXES|TO_MESA))?|TERN)))|E(?<_89>RROR_(?<_90>STRIP_TRAILING_WHITESPACE|VARIABLE|QUIET|FILE)|X(?<_91>CLUDE(?<_92>_FROM_ALL)?|T(?<_93>RA_INCLUDE)?|ISTS|P(?<_94>R|ORT)|ACT)|SCAPE_QUOTES|NV|QUAL)|V(?<_95>ER(?<_96>BATIM|SION)|A(?<_97>R(?<_98>IABLE)?|LUE))|QUIET|F(?<_99>RAMEWORK|I(?<_100>ND|LE(?<_101>S(?<_102>_MATCHING)?|_PERMISSIONS)?)|ORCE|U(?<_103>NCTION|LL_DOCS)|ATAL_ERROR)|W(?<_104>RITE|IN|ORKING_DIRECTORY)|L(?<_105>I(?<_106>MIT(?<_107>_(?<_108>COUNT|INPUT|OUTPUT))?|BRARY|NK_(?<_109>INTERFACE_LIBRARIES|DIRECTORIES|LIBRARIES))|OG|E(?<_110>SS|NGTH(?<_111>_M(?<_112>INIMUM|AXIMUM))?))|A(?<_113>R(?<_114>GS|CHIVE)|BSOLUTE|SCII|ND|PPEND|FTER|L(?<_115>PHABET|L)))\b/,
     name: "keyword.other.argument-separator.cmake"},
   comments: 
    {captures: {1 => {name: "punctuation.definition.comment.cmake"}},
     match: /(?<_1>#).*$\n?/,
     name: "comment.line.number-sign.cmake"},
   constants: 
    {match: /(?i)\b(?<_1>FALSE|OFF|NO|(?<_2>\w+-)?NOTFOUND)\b/,
     name: "constant.language.boolean.cmake"},
   escapes: 
    {patterns: 
      [{match: /\\["(?<_1>)\#$^ \\]/,
        name: "constant.character.escape.cmake"}]},
   items: 
    {patterns: 
      [{include: "#comments"},
       {include: "#constants"},
       {include: "#strings"},
       {include: "#variables"},
       {include: "#escapes"}]},
   strings: 
    {patterns: 
      [{captures: {1 => {name: "constant.language.boolean.cmake"}},
        match: /(?i)"(?<_1>FALSE|OFF|NO|(?<_2>.+-)?NOTFOUND)"/,
        name: "string.quoted.double.cmake"},
       {begin: /"/,
        end: "\"",
        name: "string.quoted.double.cmake",
        patterns: 
         [{match: /\\./, name: "constant.character.escape.cmake"},
          {include: "#variables"}]}]},
   variables: 
    {begin: /\$(?<_1>ENV)?\{/,
     beginCaptures: 
      {0 => {name: "punctuation.definition.variable.begin.cmake"}},
     end: "\\}",
     endCaptures: {0 => {name: "punctuation.definition.variable.end.cmake"}},
     name: "variable.cmake",
     patterns: [{include: "#variables"}, {match: /\w+/}]}},
 scopeName: "source.cmake",
 uuid: "6E939107-5C78-455D-A7E6-1107ADC777C2"}
