# Encoding: UTF-8

{fileTypes: ["CMakeLists.txt", "cmake"],
 foldingStartMarker: /\/\*\*|\{\s*$/,
 foldingStopMarker: /\*\*\/|^\s*\}/,
 keyEquivalent: "^~C",
 name: "CMake Listfile",
 patterns: 
  [{begin: /(?i)^\s*(function|macro)\s*(\()/,
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
	((?:end)?(?:if|while|foreach|else)|return)
	|	# Or a function
	(s(?:tring|ite_name|ource_group|ubdir(?:s|_depends)|e(?:t(?:_(?:source_files_properties|t(?:ests_properties|arget_properties)|directory_properties|property))?|parate_arguments))|c(?:onfigure_file|reate_test_sourcelist|make(?:_(?:policy|minimum_required)| version 2.6-patch 0))|t(?:arget_link_libraries|ry_(?:compile|run))|i(?:n(?:stall(?:_(?:targets|programs|files))?|clude(?:_(?:directories|external_msproject|regular_expression))?)|f)|o(?:utput_required_files|ption)|define_property|u(?:se_mangled_mesa|tility_source)|project|e(?:n(?:d(?:if|f(?:oreach|unction)|while|macro)|able_(?:testing|language))|lse(?:if)?|x(?:port(?:_library_dependencies)?|ec(?:_program|ute_process)))|variable_(?:watch|requires)|qt_wrap_(?:cpp|ui)|f(?:i(?:nd_(?:p(?:a(?:ckage|th)|rogram)|file|library)|le)|oreach|unction|ltk_wrap_ui)|w(?:hile|rite_file)|l(?:i(?:st|nk_(?:directories|libraries))|oad_c(?:ommand|ache))|a(?:dd_(?:subdirectory|custom_(?:command|target)|test|de(?:pendencies|finitions)|executable|library)|ux_source_directory)|re(?:turn|move(?:_definitions)?)|get_(?:source_file_property|cmake_property|t(?:est_property|arget_property)|directory_property|property|filename_component)|m(?:essage|a(?:cro|th|ke_directory|rk_as_advanced))|b(?:uild_(?:name|command)|reak))
	|	# Or some function we don’t know about
	(\w+)
	)
	\s*(\()	# Finally, the opening parenthesis for the argument list
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
      /\b(R(UN(_(RESULT_VAR|OUTPUT_VARIABLE)|TIME(_DIRECTORY)?)|E(G(ULAR_EXPRESSION|EX)|MOVE(_(RECURSE|ITEM|DUPLICATES|AT))?|S(OURCE|ULT_VAR(IABLE)?)|NAME|TURN_VALUE|PLACE|VERSE|QUIRED(_VARIABLE)?|LATIVE(_PATH)?|AD(_WITH_PREFIX)?)|AN(GE|DOM))|G(R(OUP_(READ|EXECUTE)|EATER)|ET|LOB(_RECURSE|AL)?)|M(ODULE|ESSAGE|A(COSX_BUNDLE|TCH(ES|ALL)?|IN_DEPENDENCY|KE_DIRECTORY))|B(RIEF_DOCS|UNDLE|EFORE)|S(HARED|YSTEM|CRIPT|T(R(GREATER|I(NGS|P)|EQUAL|LESS)|AT(IC|US))|O(RT|URCE)|UBSTRING|E(ND_ERROR|T))|HEX|N(NNN|O(_(MODULE|SYSTEM_ENVIRONMENT_PATH|HEX_CONVERSION|CMAKE_(BUILDS_PATH|SYSTEM_PATH|PATH|ENVIRONMENT_PATH|FIND_ROOT_PATH)|DEFAULT_PATH)|T(E(QUAL)?)?)|EW(LINE_CONSUME)?|AME(S(PACE)?|_WE|LINK_(SKIP|ONLY))?)|C(XX|M(P|AKE_(CROSSCOMPILING|F(IND_ROOT_PATH_BOTH|LAGS)))?|O(M(M(ENT|AND(_NAME)?)|P(ILE_(RESULT_VAR|OUTPUT_VARIABLE|DEFINITIONS)|ONENT(S)?|ARE))|NFIG(S|UR(E(_FILE)?|ATIONS))|DE|PY(_FILE|ONLY))|VS|LEAR|ACHE(D_VARIABLE)?)|T(IMEOUT|O(_(NATIVE_PATH|CMAKE_PATH)|UPPER|LOWER)|EST(_VARIABLE)?|ARGET(S)?)|I(MP(ORTED|LICIT_DEPENDS)|S_(NEWER_THAN|DIRECTORY|ABSOLUTE)|N(SERT|HERITED|CLUDE_(INTERNALS|DIRECTORIES)|PUT_FILE))|O(R|NLY(_CMAKE_FIND_ROOT_PATH)?|UTPUT(_(STRIP_TRAILING_WHITESPACE|DIRECTORY|VARIABLE|QUIET|FILE))?|PTIONAL|FFSET|WNER_(READ|EXECUTE|WRITE)|LD)|D(BAR|IRECTORY(_PERMISSIONS)?|O(C|WNLOAD)|E(STINATION|PENDS|FINED)|FOO)|USE_SOURCE_PERMISSIONS|P(R(IVATE_HEADER|O(GRAM(S|_ARGS)?|PERT(Y|IES))|E(_(BUILD|LINK)|ORDER))|O(ST_BUILD|P|LICY)|U(BLIC_HEADER|SH)|ERMISSIONS|A(RENT_SCOPE|T(H(S|_(SUFFIXES|TO_MESA))?|TERN)))|E(RROR_(STRIP_TRAILING_WHITESPACE|VARIABLE|QUIET|FILE)|X(CLUDE(_FROM_ALL)?|T(RA_INCLUDE)?|ISTS|P(R|ORT)|ACT)|SCAPE_QUOTES|NV|QUAL)|V(ER(BATIM|SION)|A(R(IABLE)?|LUE))|QUIET|F(RAMEWORK|I(ND|LE(S(_MATCHING)?|_PERMISSIONS)?)|ORCE|U(NCTION|LL_DOCS)|ATAL_ERROR)|W(RITE|IN|ORKING_DIRECTORY)|L(I(MIT(_(COUNT|INPUT|OUTPUT))?|BRARY|NK_(INTERFACE_LIBRARIES|DIRECTORIES|LIBRARIES))|OG|E(SS|NGTH(_M(INIMUM|AXIMUM))?))|A(R(GS|CHIVE)|BSOLUTE|SCII|ND|PPEND|FTER|L(PHABET|L)))\b/,
     name: "keyword.other.argument-separator.cmake"},
   comments: 
    {captures: {1 => {name: "punctuation.definition.comment.cmake"}},
     match: /(#).*$\n?/,
     name: "comment.line.number-sign.cmake"},
   constants: 
    {match: /(?i)\b(FALSE|OFF|NO|(\w+-)?NOTFOUND)\b/,
     name: "constant.language.boolean.cmake"},
   escapes: 
    {patterns: 
      [{match: /\\["()\#$^ \\]/, name: "constant.character.escape.cmake"}]},
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
        match: /(?i)"(FALSE|OFF|NO|(.+-)?NOTFOUND)"/,
        name: "string.quoted.double.cmake"},
       {begin: /"/,
        end: "\"",
        name: "string.quoted.double.cmake",
        patterns: 
         [{match: /\\./, name: "constant.character.escape.cmake"},
          {include: "#variables"}]}]},
   variables: 
    {begin: /\$(ENV)?\{/,
     beginCaptures: 
      {0 => {name: "punctuation.definition.variable.begin.cmake"}},
     end: "\\}",
     endCaptures: {0 => {name: "punctuation.definition.variable.end.cmake"}},
     name: "variable.cmake",
     patterns: [{include: "#variables"}, {match: /\w+/}]}},
 scopeName: "source.cmake",
 uuid: "6E939107-5C78-455D-A7E6-1107ADC777C2"}
