# Encoding: UTF-8

{fileTypes: ["c", "h"],
 firstLineMatch: "-[*]-( Mode:)? C -[*]-",
 foldingStartMarker: 
  /(?x)
	 \/\*\*(?!\*)
	|^(?![^{]*?\/\/|[^{]*?\/\*(?!.*?\*\/.*?\{)).*?\{\s*(?<_1>$|\/\/|\/\*(?!.*?\*\/.*\S))
	/,
 foldingStopMarker: /(?<!\*)\*\*\/|^\s*\}/,
 keyEquivalent: "^~C",
 name: "C",
 patterns: 
  [{include: "#preprocessor-rule-enabled"},
   {include: "#preprocessor-rule-disabled"},
   {include: "#preprocessor-rule-other"},
   {include: "#comments"},
   {match: 
     /\b(?<_1>break|case|continue|default|do|else|for|goto|if|_Pragma|return|switch|while)\b/,
    name: "keyword.control.c"},
   {match: 
     /\b(?<_1>asm|__asm__|auto|bool|_Bool|char|_Complex|double|enum|float|_Imaginary|int|long|short|signed|struct|typedef|union|unsigned|void)\b/,
    name: "storage.type.c"},
   {match: /\b(?<_1>const|extern|register|restrict|static|volatile|inline)\b/,
    name: "storage.modifier.c"},
   {comment: "common C constant naming idiom -- kConstantVariable",
    match: /\bk[A-Z]\w*\b/,
    name: "constant.other.variable.mac-classic.c"},
   {match: /\bg[A-Z]\w*\b/,
    name: "variable.other.readwrite.global.mac-classic.c"},
   {match: /\bs[A-Z]\w*\b/,
    name: "variable.other.readwrite.static.mac-classic.c"},
   {match: /\b(?<_1>NULL|true|false|TRUE|FALSE)\b/,
    name: "constant.language.c"},
   {include: "#sizeof"},
   {match: 
     /\b(?<_1>(?<_2>0(?<_3>x|X)[0-9a-fA-F]*)|(?<_4>(?<_5>[0-9]+\.?[0-9]*)|(?<_6>\.[0-9]+))(?<_7>(?<_8>e|E)(?<_9>\+|-)?[0-9]+)?)(?<_10>L|l|UL|ul|u|U|F|f|ll|LL|ull|ULL)?\b/,
    name: "constant.numeric.c"},
   {begin: /"/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.c"}},
    end: "\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.c"}},
    name: "string.quoted.double.c",
    patterns: 
     [{include: "#string_escaped_char"}, {include: "#string_placeholder"}]},
   {begin: /'/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.c"}},
    end: "'",
    endCaptures: {0 => {name: "punctuation.definition.string.end.c"}},
    name: "string.quoted.single.c",
    patterns: [{include: "#string_escaped_char"}]},
   {begin: 
     /(?x)
        		^\s*\#\s*(?<_1>define)\s+             # define
        		(?<_2>(?<id>[a-zA-Z_][a-zA-Z0-9_]*))  # macro name
        		(?:                              # and optionally:
        		    (?<_3>\()                         # an open parenthesis
        		        (?<_4>
        		            \s* \g<id> \s*       # first argument
        		            (?<_5>(?<_6>,) \s* \g<id> \s*)*  # additional arguments
        		            (?:\.\.\.)?          # varargs ellipsis?
        		        )
        		    (?<_7>\))                         # a close parenthesis
        		)?
        	/,
    beginCaptures: 
     {1 => {name: "keyword.control.import.define.c"},
      2 => {name: "entity.name.function.preprocessor.c"},
      4 => {name: "punctuation.definition.parameters.c"},
      5 => {name: "variable.parameter.preprocessor.c"},
      7 => {name: "punctuation.separator.parameters.c"},
      8 => {name: "punctuation.definition.parameters.c"}},
    end: "(?=(?://|/\\*))|$",
    name: "meta.preprocessor.macro.c",
    patterns: 
     [{match: /(?>\\\s*\n)/, name: "punctuation.separator.continuation.c"},
      {include: "$base"}]},
   {begin: /^\s*#\s*(?<_1>error|warning)\b/,
    captures: {1 => {name: "keyword.control.import.error.c"}},
    end: "$",
    name: "meta.preprocessor.diagnostic.c",
    patterns: 
     [{match: /(?>\\\s*\n)/, name: "punctuation.separator.continuation.c"}]},
   {begin: /^\s*#\s*(?<_1>include|import)\b\s+/,
    captures: {1 => {name: "keyword.control.import.include.c"}},
    end: "(?=(?://|/\\*))|$",
    name: "meta.preprocessor.c.include",
    patterns: 
     [{match: /(?>\\\s*\n)/, name: "punctuation.separator.continuation.c"},
      {begin: /"/,
       beginCaptures: {0 => {name: "punctuation.definition.string.begin.c"}},
       end: "\"",
       endCaptures: {0 => {name: "punctuation.definition.string.end.c"}},
       name: "string.quoted.double.include.c"},
      {begin: /</,
       beginCaptures: {0 => {name: "punctuation.definition.string.begin.c"}},
       end: ">",
       endCaptures: {0 => {name: "punctuation.definition.string.end.c"}},
       name: "string.quoted.other.lt-gt.include.c"}]},
   {include: "#pragma-mark"},
   {begin: 
     /^\s*#\s*(?<_1>define|defined|elif|else|if|ifdef|ifndef|line|pragma|undef)\b/,
    captures: {1 => {name: "keyword.control.import.c"}},
    end: "(?=(?://|/\\*))|$",
    name: "meta.preprocessor.c",
    patterns: 
     [{match: /(?>\\\s*\n)/, name: "punctuation.separator.continuation.c"}]},
   {match: 
     /\b(?<_1>u_char|u_short|u_int|u_long|ushort|uint|u_quad_t|quad_t|qaddr_t|caddr_t|daddr_t|dev_t|fixpt_t|blkcnt_t|blksize_t|gid_t|in_addr_t|in_port_t|ino_t|key_t|mode_t|nlink_t|id_t|pid_t|off_t|segsz_t|swblk_t|uid_t|id_t|clock_t|size_t|ssize_t|time_t|useconds_t|suseconds_t)\b/,
    name: "support.type.sys-types.c"},
   {match: 
     /\b(?<_1>pthread_attr_t|pthread_cond_t|pthread_condattr_t|pthread_mutex_t|pthread_mutexattr_t|pthread_once_t|pthread_rwlock_t|pthread_rwlockattr_t|pthread_t|pthread_key_t)\b/,
    name: "support.type.pthread.c"},
   {match: 
     /\b(?<_1>int8_t|int16_t|int32_t|int64_t|uint8_t|uint16_t|uint32_t|uint64_t|int_least8_t|int_least16_t|int_least32_t|int_least64_t|uint_least8_t|uint_least16_t|uint_least32_t|uint_least64_t|int_fast8_t|int_fast16_t|int_fast32_t|int_fast64_t|uint_fast8_t|uint_fast16_t|uint_fast32_t|uint_fast64_t|intptr_t|uintptr_t|intmax_t|intmax_t|uintmax_t|uintmax_t)\b/,
    name: "support.type.stdint.c"},
   {match: /\b(?<_1>noErr|kNilOptions|kInvalidID|kVariableLengthArray)\b/,
    name: "support.constant.mac-classic.c"},
   {match: 
     /\b(?<_1>AbsoluteTime|Boolean|Byte|ByteCount|ByteOffset|BytePtr|CompTimeValue|ConstLogicalAddress|ConstStrFileNameParam|ConstStringPtr|Duration|Fixed|FixedPtr|Float32|Float32Point|Float64|Float80|Float96|FourCharCode|Fract|FractPtr|Handle|ItemCount|LogicalAddress|OptionBits|OSErr|OSStatus|OSType|OSTypePtr|PhysicalAddress|ProcessSerialNumber|ProcessSerialNumberPtr|ProcHandle|Ptr|ResType|ResTypePtr|ShortFixed|ShortFixedPtr|SignedByte|SInt16|SInt32|SInt64|SInt8|Size|StrFileName|StringHandle|StringPtr|TimeBase|TimeRecord|TimeScale|TimeValue|TimeValue64|UInt16|UInt32|UInt64|UInt8|UniChar|UniCharCount|UniCharCountPtr|UniCharPtr|UnicodeScalarValue|UniversalProcHandle|UniversalProcPtr|UnsignedFixed|UnsignedFixedPtr|UnsignedWide|UTF16Char|UTF32Char|UTF8Char)\b/,
    name: "support.type.mac-classic.c"},
   {include: "#block"},
   {begin: 
     /(?x)
    		(?:  ^                                 # begin-of-line
    		  |  
    		     (?: (?= \s )           (?<!else|new|return) (?<=\w)      #  or word + space before name
    		       | (?= \s*[A-Za-z_] ) (?<!&&)       (?<=[*&>])   #  or type modifier before name
    		     )
    		)
    		(?<_1>\s*) (?!(?<_2>while|for|do|if|else|switch|catch|enumerate|return|r?iterate)\s*\()
    		(?<_3>
    			(?: [A-Za-z_][A-Za-z0-9_]*+ | :: )++ |                  # actual name
    			(?: (?<=operator) (?: [-*&<>=+!]+ | \(\) | \[\] ) )  # if it is a C++ operator
    		)
    		 \s*(?=\()/,
    beginCaptures: 
     {1 => {name: "punctuation.whitespace.function.leading.c"},
      3 => {name: "entity.name.function.c"},
      4 => {name: "punctuation.definition.parameters.c"}},
    end: "(?<=\\})|(?=#)|(;)",
    name: "meta.function.c",
    patterns: 
     [{include: "#comments"},
      {include: "#parens"},
      {match: /\bconst\b/, name: "storage.modifier.c"},
      {include: "#block"}]}],
 repository: 
  {access: 
    {match: /\.[a-zA-Z_][a-zA-Z_0-9]*\b(?!\s*\()/,
     name: "variable.other.dot-access.c"},
   block: 
    {begin: /\{/,
     end: "\\}",
     name: "meta.block.c",
     patterns: [{include: "#block_innards"}]},
   block_innards: 
    {patterns: 
      [{include: "#preprocessor-rule-enabled-block"},
       {include: "#preprocessor-rule-disabled-block"},
       {include: "#preprocessor-rule-other-block"},
       {include: "#sizeof"},
       {include: "#access"},
       {captures: 
         {1 => {name: "punctuation.whitespace.support.function.leading.c"},
          2 => {name: "support.function.C99.c"}},
        match: 
         /(?<_1>\s*)\b(?<_2>hypot(?<_3>f|l)?|s(?<_4>scanf|ystem|nprintf|ca(?<_5>nf|lb(?<_6>n(?<_7>f|l)?|ln(?<_8>f|l)?))|i(?<_9>n(?<_10>h(?<_11>f|l)?|f|l)?|gn(?<_12>al|bit))|tr(?<_13>s(?<_14>tr|pn)|nc(?<_15>py|at|mp)|c(?<_16>spn|hr|oll|py|at|mp)|to(?<_17>imax|d|u(?<_18>l(?<_19>l)?|max)|k|f|l(?<_20>d|l)?)|error|pbrk|ftime|len|rchr|xfrm)|printf|et(?<_21>jmp|vbuf|locale|buf)|qrt(?<_22>f|l)?|w(?<_23>scanf|printf)|rand)|n(?<_24>e(?<_25>arbyint(?<_26>f|l)?|xt(?<_27>toward(?<_28>f|l)?|after(?<_29>f|l)?))|an(?<_30>f|l)?)|c(?<_31>s(?<_32>in(?<_33>h(?<_34>f|l)?|f|l)?|qrt(?<_35>f|l)?)|cos(?<_36>h(?<_37>f)?|f|l)?|imag(?<_38>f|l)?|t(?<_39>ime|an(?<_40>h(?<_41>f|l)?|f|l)?)|o(?<_42>s(?<_43>h(?<_44>f|l)?|f|l)?|nj(?<_45>f|l)?|pysign(?<_46>f|l)?)|p(?<_47>ow(?<_48>f|l)?|roj(?<_49>f|l)?)|e(?<_50>il(?<_51>f|l)?|xp(?<_52>f|l)?)|l(?<_53>o(?<_54>ck|g(?<_55>f|l)?)|earerr)|a(?<_56>sin(?<_57>h(?<_58>f|l)?|f|l)?|cos(?<_59>h(?<_60>f|l)?|f|l)?|tan(?<_61>h(?<_62>f|l)?|f|l)?|lloc|rg(?<_63>f|l)?|bs(?<_64>f|l)?)|real(?<_65>f|l)?|brt(?<_66>f|l)?)|t(?<_67>ime|o(?<_68>upper|lower)|an(?<_69>h(?<_70>f|l)?|f|l)?|runc(?<_71>f|l)?|gamma(?<_72>f|l)?|mp(?<_73>nam|file))|i(?<_74>s(?<_75>space|n(?<_76>ormal|an)|cntrl|inf|digit|u(?<_77>nordered|pper)|p(?<_78>unct|rint)|finite|w(?<_79>space|c(?<_80>ntrl|type)|digit|upper|p(?<_81>unct|rint)|lower|al(?<_82>num|pha)|graph|xdigit|blank)|l(?<_83>ower|ess(?<_84>equal|greater)?)|al(?<_85>num|pha)|gr(?<_86>eater(?<_87>equal)?|aph)|xdigit|blank)|logb(?<_88>f|l)?|max(?<_89>div|abs))|di(?<_90>v|fftime)|_Exit|unget(?<_91>c|wc)|p(?<_92>ow(?<_93>f|l)?|ut(?<_94>s|c(?<_95>har)?|wc(?<_96>har)?)|error|rintf)|e(?<_97>rf(?<_98>c(?<_99>f|l)?|f|l)?|x(?<_100>it|p(?<_101>2(?<_102>f|l)?|f|l|m1(?<_103>f|l)?)?))|v(?<_104>s(?<_105>scanf|nprintf|canf|printf|w(?<_106>scanf|printf))|printf|f(?<_107>scanf|printf|w(?<_108>scanf|printf))|w(?<_109>scanf|printf)|a_(?<_110>start|copy|end|arg))|qsort|f(?<_111>s(?<_112>canf|e(?<_113>tpos|ek))|close|tell|open|dim(?<_114>f|l)?|p(?<_115>classify|ut(?<_116>s|c|w(?<_117>s|c))|rintf)|e(?<_118>holdexcept|set(?<_119>e(?<_120>nv|xceptflag)|round)|clearexcept|testexcept|of|updateenv|r(?<_121>aiseexcept|ror)|get(?<_122>e(?<_123>nv|xceptflag)|round))|flush|w(?<_124>scanf|ide|printf|rite)|loor(?<_125>f|l)?|abs(?<_126>f|l)?|get(?<_127>s|c|pos|w(?<_128>s|c))|re(?<_129>open|e|ad|xp(?<_130>f|l)?)|m(?<_131>in(?<_132>f|l)?|od(?<_133>f|l)?|a(?<_134>f|l|x(?<_135>f|l)?)?))|l(?<_136>d(?<_137>iv|exp(?<_138>f|l)?)|o(?<_139>ngjmp|cal(?<_140>time|econv)|g(?<_141>1(?<_142>p(?<_143>f|l)?|0(?<_144>f|l)?)|2(?<_145>f|l)?|f|l|b(?<_146>f|l)?)?)|abs|l(?<_147>div|abs|r(?<_148>int(?<_149>f|l)?|ound(?<_150>f|l)?))|r(?<_151>int(?<_152>f|l)?|ound(?<_153>f|l)?)|gamma(?<_154>f|l)?)|w(?<_155>scanf|c(?<_156>s(?<_157>s(?<_158>tr|pn)|nc(?<_159>py|at|mp)|c(?<_160>spn|hr|oll|py|at|mp)|to(?<_161>imax|d|u(?<_162>l(?<_163>l)?|max)|k|f|l(?<_164>d|l)?|mbs)|pbrk|ftime|len|r(?<_165>chr|tombs)|xfrm)|to(?<_166>b|mb)|rtomb)|printf|mem(?<_167>set|c(?<_168>hr|py|mp)|move))|a(?<_169>s(?<_170>sert|ctime|in(?<_171>h(?<_172>f|l)?|f|l)?)|cos(?<_173>h(?<_174>f|l)?|f|l)?|t(?<_175>o(?<_176>i|f|l(?<_177>l)?)|exit|an(?<_178>h(?<_179>f|l)?|2(?<_180>f|l)?|f|l)?)|b(?<_181>s|ort))|g(?<_182>et(?<_183>s|c(?<_184>har)?|env|wc(?<_185>har)?)|mtime)|r(?<_186>int(?<_187>f|l)?|ound(?<_188>f|l)?|e(?<_189>name|alloc|wind|m(?<_190>ove|quo(?<_191>f|l)?|ainder(?<_192>f|l)?))|a(?<_193>nd|ise))|b(?<_194>search|towc)|m(?<_195>odf(?<_196>f|l)?|em(?<_197>set|c(?<_198>hr|py|mp)|move)|ktime|alloc|b(?<_199>s(?<_200>init|towcs|rtowcs)|towc|len|r(?<_201>towc|len))))\b/},
       {captures: 
         {1 => {name: "punctuation.whitespace.function-call.leading.c"},
          2 => {name: "support.function.any-method.c"},
          3 => {name: "punctuation.definition.parameters.c"}},
        match: 
         /(?x) (?: (?= \s )  (?:(?<=else|new|return) | (?<!\w)) (?<_1>\s+))?
	(?<_2>\b 
	(?!(?<_3>while|for|do|if|else|switch|catch|enumerate|return|r?iterate)\s*\()(?:(?!NS)[A-Za-z_][A-Za-z0-9_]*+\b | :: )++                  # actual name
	)
	 \s*(?<_4>\()/,
        name: "meta.function-call.c"},
       {captures: 
         {1 => {name: "variable.other.c"},
          2 => {name: "punctuation.definition.parameters.c"}},
        match: 
         /(?x)
	        (?x)
	(?:  
	     (?: (?= \s )           (?<!else|new|return) (?<=\w)\s+      #  or word + space before name
	     )
	)
	(?<_1>
	(?: [A-Za-z_][A-Za-z0-9_]*+ | :: )++    |              # actual name
	(?: (?<=operator) (?: [-*&<>=+!]+ | \(\) | \[\] ) )?  # if it is a C++ operator
	)
	 \s*(?<_2>\()/,
        name: "meta.initialization.c"},
       {include: "#block"},
       {include: "$base"}]},
   comments: 
    {patterns: 
      [{captures: {1 => {name: "meta.toc-list.banner.block.c"}},
        match: /^\/\* =(?<_1>\s*.*?)\s*= \*\/$\n?/,
        name: "comment.block.c"},
       {begin: /\/\*/,
        captures: {0 => {name: "punctuation.definition.comment.c"}},
        end: "\\*/",
        name: "comment.block.c"},
       {match: /\*\/.*\n/, name: "invalid.illegal.stray-comment-end.c"},
       {captures: {1 => {name: "meta.toc-list.banner.line.c"}},
        match: /^\/\/ =(?<_1>\s*.*?)\s*=\s*$\n?/,
        name: "comment.line.banner.c++"},
       {begin: /\/\//,
        beginCaptures: {0 => {name: "punctuation.definition.comment.c"}},
        end: "$\\n?",
        name: "comment.line.double-slash.c++",
        patterns: 
         [{match: /(?>\\\s*\n)/,
           name: "punctuation.separator.continuation.c++"}]}]},
   disabled: 
    {begin: /^\s*#\s*if(?<_1>n?def)?\b.*$/,
     comment: "eat nested preprocessor if(def)s",
     end: "^\\s*#\\s*endif\\b.*$",
     patterns: [{include: "#disabled"}, {include: "#pragma-mark"}]},
   parens: 
    {begin: /\(/,
     end: "\\)",
     name: "meta.parens.c",
     patterns: [{include: "$base"}]},
   :"pragma-mark" => 
    {captures: 
      {1 => {name: "meta.preprocessor.c"},
       2 => {name: "keyword.control.import.pragma.c"},
       3 => {name: "meta.toc-list.pragma-mark.c"}},
     match: /^\s*(?<_1>#\s*(?<_2>pragma\s+mark)\s+(?<_3>.*))/,
     name: "meta.section"},
   :"preprocessor-rule-disabled" => 
    {begin: /^\s*(?<_1>#(?<_2>if)\s+(?<_3>0)\b).*/,
     captures: 
      {1 => {name: "meta.preprocessor.c"},
       2 => {name: "keyword.control.import.if.c"},
       3 => {name: "constant.numeric.preprocessor.c"}},
     end: "^\\s*(#\\s*(endif)\\b)",
     patterns: 
      [{begin: /^\s*(?<_1>#\s*(?<_2>else)\b)/,
        captures: 
         {1 => {name: "meta.preprocessor.c"},
          2 => {name: "keyword.control.import.else.c"}},
        end: "(?=^\\s*#\\s*endif\\b.*$)",
        patterns: [{include: "$base"}]},
       {begin: //,
        end: "(?=^\\s*#\\s*(else|endif)\\b.*$)",
        name: "comment.block.preprocessor.if-branch",
        patterns: [{include: "#disabled"}, {include: "#pragma-mark"}]}]},
   :"preprocessor-rule-disabled-block" => 
    {begin: /^\s*(?<_1>#(?<_2>if)\s+(?<_3>0)\b).*/,
     captures: 
      {1 => {name: "meta.preprocessor.c"},
       2 => {name: "keyword.control.import.if.c"},
       3 => {name: "constant.numeric.preprocessor.c"}},
     end: "^\\s*(#\\s*(endif)\\b)",
     patterns: 
      [{begin: /^\s*(?<_1>#\s*(?<_2>else)\b)/,
        captures: 
         {1 => {name: "meta.preprocessor.c"},
          2 => {name: "keyword.control.import.else.c"}},
        end: "(?=^\\s*#\\s*endif\\b.*$)",
        patterns: [{include: "#block_innards"}]},
       {begin: //,
        end: "(?=^\\s*#\\s*(else|endif)\\b.*$)",
        name: "comment.block.preprocessor.if-branch.in-block",
        patterns: [{include: "#disabled"}, {include: "#pragma-mark"}]}]},
   :"preprocessor-rule-enabled" => 
    {begin: /^\s*(?<_1>#(?<_2>if)\s+(?<_3>0*1)\b)/,
     captures: 
      {1 => {name: "meta.preprocessor.c"},
       2 => {name: "keyword.control.import.if.c"},
       3 => {name: "constant.numeric.preprocessor.c"}},
     end: "^\\s*(#\\s*(endif)\\b)",
     patterns: 
      [{begin: /^\s*(?<_1>#\s*(?<_2>else)\b).*/,
        captures: 
         {1 => {name: "meta.preprocessor.c"},
          2 => {name: "keyword.control.import.else.c"}},
        contentName: "comment.block.preprocessor.else-branch",
        end: "(?=^\\s*#\\s*endif\\b.*$)",
        patterns: [{include: "#disabled"}, {include: "#pragma-mark"}]},
       {begin: //,
        end: "(?=^\\s*#\\s*(else|endif)\\b.*$)",
        patterns: [{include: "$base"}]}]},
   :"preprocessor-rule-enabled-block" => 
    {begin: /^\s*(?<_1>#(?<_2>if)\s+(?<_3>0*1)\b)/,
     captures: 
      {1 => {name: "meta.preprocessor.c"},
       2 => {name: "keyword.control.import.if.c"},
       3 => {name: "constant.numeric.preprocessor.c"}},
     end: "^\\s*(#\\s*(endif)\\b)",
     patterns: 
      [{begin: /^\s*(?<_1>#\s*(?<_2>else)\b).*/,
        captures: 
         {1 => {name: "meta.preprocessor.c"},
          2 => {name: "keyword.control.import.else.c"}},
        contentName: "comment.block.preprocessor.else-branch.in-block",
        end: "(?=^\\s*#\\s*endif\\b.*$)",
        patterns: [{include: "#disabled"}, {include: "#pragma-mark"}]},
       {begin: //,
        end: "(?=^\\s*#\\s*(else|endif)\\b.*$)",
        patterns: [{include: "#block_innards"}]}]},
   :"preprocessor-rule-other" => 
    {begin: 
      /^\s*(?<_1>#\s*(?<_2>if(?<_3>n?def)?)\b.*?(?:(?=(?:\/\/|\/\*))|$))/,
     captures: 
      {1 => {name: "meta.preprocessor.c"},
       2 => {name: "keyword.control.import.c"}},
     end: "^\\s*(#\\s*(endif)\\b).*$",
     patterns: [{include: "$base"}]},
   :"preprocessor-rule-other-block" => 
    {begin: 
      /^\s*(?<_1>#\s*(?<_2>if(?<_3>n?def)?)\b.*?(?:(?=(?:\/\/|\/\*))|$))/,
     captures: 
      {1 => {name: "meta.preprocessor.c"},
       2 => {name: "keyword.control.import.c"}},
     end: "^\\s*(#\\s*(endif)\\b).*$",
     patterns: [{include: "#block_innards"}]},
   sizeof: {match: /\b(?<_1>sizeof)\b/, name: "keyword.operator.sizeof.c"},
   string_escaped_char: 
    {patterns: 
      [{match: 
         /\\(?<_1>\\|[abefnprtv'"?]|[0-3]\d{,2}|[4-7]\d?|x[a-fA-F0-9]{,2})/,
        name: "constant.character.escape.c"},
       {match: /\\./, name: "invalid.illegal.unknown-escape.c"}]},
   string_placeholder: 
    {patterns: 
      [{match: 
         /(?x)%
    						(?<_1>\d+\$)?                             # field (?<_2>argument #)
    						[#0\- +']*                           # flags
    						[,;:_]?                              # separator character (?<_3>AltiVec)
    						(?<_4>(?<_5>-?\d+)|\*(?<_6>-?\d+\$)?)?              # minimum field width
    						(?<_7>\.(?<_8>(?<_9>-?\d+)|\*(?<_10>-?\d+\$)?)?)?         # precision
    						(?<_11>hh|h|ll|l|j|t|z|q|L|vh|vl|v|hv|hl)? # length modifier
    						[diouxXDOUeEfFgGaACcSspn%]           # conversion type
    					/,
        name: "constant.other.placeholder.c"},
       {match: /%/, name: "invalid.illegal.placeholder.c"}]}},
 scopeName: "source.c",
 uuid: "25066DC2-6B1D-11D9-9D5B-000D93589AF6"}
