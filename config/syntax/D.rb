# Encoding: UTF-8

{comment: "D language",
 fileTypes: ["d", "di"],
 firstLineMatch: "^#!.*\\bg?dmd\\b.",
 foldingStartMarker: 
  /(?x)\/\*\*(?!\*)|^(?![^{]*?\/\/|[^{]*?\/\*(?!.*?\*\/.*?\{)).*?\{\s*(?<_1>$|\/\/|\/\*(?!.*?\*\/.*\S))/,
 foldingStopMarker: /(?<!\*)\*\*\/|^\s*\}/,
 keyEquivalent: "^~D",
 name: "D",
 patterns: 
  [{captures: {0 => {name: "punctuation.definition.comment.d"}},
    match: /\/\*\*\//,
    name: "comment.block.empty.d"},
   {include: "text.html.javadoc"},
   {begin: 
     /(?x)^\s*
	(?<_1>(?:\b(?<_2>public|private|protected|static|final|native|synchronized|abstract|export)\b\s*)*) # modifier
	(?<_3>class|interface)\s+
	(?<_4>\w+)\s* # identifier
	(?:\(\s*(?<_5>[^\)]+)\s*\)|)\s* # Template type
	(?:
	  \s*(?<_6>:)\s*
	  (?<_7>\w+)
	  (?:\s*,\s*(?<_8>\w+))?
	  (?:\s*,\s*(?<_9>\w+))?
	  (?:\s*,\s*(?<_10>\w+))?
	  (?:\s*,\s*(?<_11>\w+))?
	  (?:\s*,\s*(?<_12>\w+))?
	  (?:\s*,\s*(?<_13>\w+))?
	)? # super class
	/,
    beginCaptures: 
     {1 => {name: "storage.modifier.d"},
      10 => {name: "entity.other.inherited-class.d"},
      11 => {name: "entity.other.inherited-class.d"},
      12 => {name: "entity.other.inherited-class.d"},
      13 => {name: "entity.other.inherited-class.d"},
      3 => {name: "storage.type.structure.d"},
      4 => {name: "entity.name.type.class.d"},
      5 => {name: "storage.type.template.d"},
      6 => {name: "punctuation.separator.inheritance.d"},
      7 => {name: "entity.other.inherited-class.d"},
      8 => {name: "entity.other.inherited-class.d"},
      9 => {name: "entity.other.inherited-class.d"}},
    end: "(?={)",
    name: "meta.definition.class.d",
    patterns: 
     [{begin: /\b(?<_1>_|:)\b/,
       captures: {1 => {name: "storage.modifier.d"}},
       end: "(?={)",
       name: "meta.definition.class.extends.d",
       patterns: [{include: "#all-types"}]}]},
   {begin: 
     /(?x)^\s*
	(?<_1>(?:\b(?<_2>public|private|protected|static|final|native|synchronized|abstract|export)\b\s*)*) # modifier
	(?<_3>struct)\s+
	(?<_4>\w+)\s* # identifier
	(?:\(\s*(?<_5>[^\)]+)\s*\)|)\s* # Template type
	/,
    beginCaptures: 
     {1 => {name: "storage.modifier.d"},
      3 => {name: "storage.type.structure.d"},
      4 => {name: "entity.name.type.struct.d"},
      5 => {name: "storage.type.template.d"}},
    end: "(?={)",
    name: "meta.definition.struct.d",
    patterns: 
     [{begin: /\b(?<_1>_|:)\b/,
       captures: {1 => {name: "storage.modifier.d"}},
       end: "(?={)",
       name: "meta.definition.class.extends.d",
       patterns: [{include: "#all-types"}]}]},
   {begin: 
     /(?x)^\s*
	(?<_1>(?:\b(?<_2>public|private|protected|static|final|native|synchronized|abstract|threadsafe|transient|export)\b\s*)*) # modifier
	(?<_3>\b(?<_4>this))\s* # identifier
	(?!.*;)  # abort if line has a ;
	(?=\()/,
    captures: 
     {1 => {name: "storage.modifier.d"},
      3 => {name: "entity.name.function.constructor.d"}},
    end: "(?={)",
    name: "meta.definition.constructor.d",
    patterns: [{include: "$base"}]},
   {begin: 
     /(?x)
    				(?:  ^                                 # begin-of-line
    				  |  (?: (?<!else|new|=) )             #  or word + space before name
    				)
	(?<_1>(?:\b(?:public|private|protected|static|final|native|synchronized|abstract|threadsafe|transient|export)\b\s*)*) # modifier
    				(?<_2>~this) # actual name
    				 \s*(?<_3>\()                           # start bracket or end-of-line
    			/,
    captures: 
     {1 => {name: "storage.modifier.d"},
      2 => {name: "entity.name.function.destructor.d"}},
    end: "\\)",
    endCaptures: {0 => {name: "punctuation.definition.parameters.d"}},
    name: "meta.definition.destructor.d",
    patterns: [{include: "$base"}]},
   {begin: 
     /(?x)^\s*
	(?<_1>(?:\b(?:public|private|protected|static|final|native|lazy|synchronized|abstract|threadsafe|transient|export)\b\s*)*) # modifier
	(?<_2>\b(?:void|boolean|byte|char|short|int|float|long|double|[\w_]+[\w0-9_]*|(?:\w+\.)*[A-Z]\w+)\b(?:<(?:(?:(?:\w+\.)*[A-Z]\w+)(?:\s*,\s*)?)+>|(?:\[\s*\])*)?)\s* # type
	(?<_3>\w+)\s* # identifier
	(?!.*;)  # abort if line has a ;
	(?=\()/,
    beginCaptures: 
     {1 => {name: "storage.modifier.d"},
      2 => {name: "storage.type.structure.d"},
      3 => {name: "entity.name.function.d"}},
    end: "(?={)",
    name: "meta.definition.method.d",
    patterns: [{include: "$base"}]},
   {match: /\b(?<_1>[A-Z][A-Z0-9_]+)\b/, name: "constant.other.d"},
   {include: "#comments"},
   {include: "#all-types"},
   {match: /\b(?<_1>private|protected|public|export)\b/,
    name: "storage.modifier.access-control.d"},
   {match: 
     /\b(?<_1>auto|static|override|final|const|abstract|volatile|synchronized|lazy)\b/,
    name: "storage.modifier.d"},
   {match: /\b(?<_1>template|interface|class|enum|struct|union)\b/,
    name: "storage.type.structure.d"},
   {match: 
     /\b(?<_1>ushort|int|uint|long|ulong|float|void|byte|ubyte|double|bit|char|wchar|ucent|cent|short|bool|dchar|real|ireal|ifloat|idouble|creal|cfloat|cdouble|lazy)\b/,
    name: "storage.type.d"},
   {match: /\b(?<_1>try|catch|finally|throw)\b/,
    name: "keyword.control.exception.d"},
   {match: 
     /\b(?<_1>return|break|case|continue|default|do|while|for|switch|if|else)\b/,
    name: "keyword.control.d"},
   {match: /\b(?<_1>if|else|switch|iftype)\b/,
    name: "keyword.control.conditional.d"},
   {match: /\b(?<_1>goto|break|continue)\b/, name: "keyword.control.branch.d"},
   {match: /\b(?<_1>while|for|do|foreach(?<_2>_reverse)?)\b/,
    name: "keyword.control.repeat.d"},
   {match: 
     /\b(?<_1>version|return|with|invariant|body|scope|in|out|inout|asm|mixin|function|delegate)\b/,
    name: "keyword.control.statement.d"},
   {match: /\b(?<_1>pragma)\b/, name: "keyword.control.pragma.d"},
   {match: /\b(?<_1>alias|typedef)\b/, name: "keyword.control.alias.d"},
   {match: /\b(?<_1>import)\b/, name: "keyword.control.import.d"},
   {captures: 
     {1 => {name: "keyword.control.module.d"},
      2 => {name: "entity.name.function.package.d"}},
    match: /^\s*(?<_1>module)\s+(?<_2>[^ ;]+?);/,
    name: "meta.module.d"},
   {match: /\b(?<_1>true|false)\b/, name: "constant.language.boolean.d"},
   {match: /\b(?<_1>__FILE__|__LINE__|__DATE__|__TIME__|__TIMESTAMP__|null)\b/,
    name: "constant.language.d"},
   {match: /\b(?<_1>this|super)\b/, name: "variable.language.d"},
   {match: 
     /\b(?<_1>(?<_2>0(?<_3>x|X)[0-9a-fA-F]*)|(?<_4>(?<_5>[0-9]+\.?[0-9]*)|(?<_6>\.[0-9]+))(?<_7>(?<_8>e|E)(?<_9>\+|-)?[0-9]+)?)(?<_10>[LlFfUuDd]|UL|ul)?\b/,
    name: "constant.numeric.d"},
   {include: "#string_escaped_char"},
   {include: "#strings"},
   {match: /(?<_1>==|!=|<=|>=|<>|<|>)/, name: "keyword.operator.comparison.d"},
   {match: /(?<_1>\-\-|\+\+)/, name: "keyword.operator.increment-decrement.d"},
   {match: /(?<_1>\-|\+|\*|\/|~|%)/, name: "keyword.operator.arithmetic.d"},
   {match: /(?<_1>!|&&|\|\|)/, name: "keyword.operator.logical.d"},
   {match: 
     /\b(?<_1>opNeg|opCom|opPostInc|opPostDec|opCast|opAdd|opSub|opSub_r|opMul|opDiv|opDiv_r|opMod|opMod_r|opAnd|opOr|opXor|opShl|opShl_r|opShr|opShr_r|opUShr|opUShr_r|opCat|opCat_r|opEquals|opEquals|opCmp|opCmp|opCmp|opCmp|opAddAssign|opSubAssign|opMulAssign|opDivAssign|opModAssign|opAndAssign|opOrAssign|opXorAssign|opShlAssign|opShrAssign|opUShrAssign|opCatAssign|opIndex|opIndexAssign|opCall|opSlice|opSliceAssign|opPos|opAdd_r|opMul_r|opAnd_r|opOr_r|opXor_r)\b/,
    name: "keyword.operator.overload.d"},
   {match: /\b(?<_1>new|delete|typeof|typeid|cast|align|is)\b/,
    name: "keyword.operator.d"},
   {match: /\b(?<_1>new|throws)\b/, name: "keyword.other.class-fns.d"},
   {match: /\b(?<_1>package|extern)\b/, name: "keyword.other.external.d"},
   {match: /\b(?<_1>deprecated|unittest|debug)\b/,
    name: "keyword.other.debug.d"},
   {match: 
     /\b(?<_1>u_char|u_short|u_int|u_long|ushort|uint|u_quad_t|quad_t|qaddr_t|caddr_t|daddr_t|dev_t|fixpt_t|blkcnt_t|blksize_t|gid_t|in_addr_t|in_port_t|ino_t|key_t|mode_t|nlink_t|id_t|pid_t|off_t|segsz_t|swblk_t|uid_t|id_t|clock_t|size_t|ssize_t|time_t|useconds_t|suseconds_t)\b/,
    name: "support.type.sys-types.c"},
   {match: 
     /\b(?<_1>pthread_attr_t|pthread_cond_t|pthread_condattr_t|pthread_mutex_t|pthread_mutexattr_t|pthread_once_t|pthread_rwlock_t|pthread_rwlockattr_t|pthread_t|pthread_key_t)\b/,
    name: "support.type.pthread.c"},
   {match: 
     /\b(?<_1>int8_t|int16_t|int32_t|int64_t|uint8_t|uint16_t|uint32_t|uint64_t|int_least8_t|int_least16_t|int_least32_t|int_least64_t|uint_least8_t|uint_least16_t|uint_least32_t|uint_least64_t|int_fast8_t|int_fast16_t|int_fast32_t|int_fast64_t|uint_fast8_t|uint_fast16_t|uint_fast32_t|uint_fast64_t|intptr_t|uintptr_t|intmax_t|intmax_t|uintmax_t|uintmax_t)\b/,
    name: "support.type.stdint.c"}],
 repository: 
  {:"all-types" => 
    {patterns: 
      [{include: "#support-type-built-ins-d"},
       {include: "#support-type-d"},
       {include: "#storage-type-d"}]},
   comments: 
    {patterns: 
      [{begin: /\/\*/,
        captures: {0 => {name: "punctuation.definition.comment.d"}},
        end: "\\*/",
        name: "comment.block.d"},
       {begin: /\/\+/,
        captures: {0 => {name: "punctuation.definition.comment.d"}},
        end: "\\+/",
        name: "comment.block.nested.d"},
       {captures: {1 => {name: "punctuation.definition.comment.d"}},
        match: /(?<_1>\/\/).*$\n?/,
        name: "comment.line.double-slash.d"}]},
   constant_placeholder: 
    {match: 
      /(?i:%(?<_1>\([a-z_]+\))?#?0?\-?[ ]?\+?(?<_2>[0-9]*|\*)(?<_3>\.(?<_4>[0-9]*|\*))?[hL]?[a-z%])/,
     name: "constant.other.placeholder.d"},
   regular_expressions: 
    {comment: 
      "Change disabled to 1 to turn off syntax highlighting in “r” strings.",
     disabled: 1,
     patterns: [{include: "source.regexp.python"}]},
   :"statement-remainder" => 
    {patterns: 
      [{begin: /\(/,
        end: "(?=\\))",
        name: "meta.definition.param-list.d",
        patterns: [{include: "#all-types"}]},
       {begin: /(?<_1>throws)/,
        captures: {1 => {name: "keyword.other.class-fns.d"}},
        end: "(?={)",
        name: "meta.definition.throws.d",
        patterns: [{include: "#all-types"}]}]},
   :"storage-type-d" => 
    {match: 
      /\b(?<_1>void|byte|short|char|int|long|float|double|boolean|(?<_2>[a-z]\w+\.)*[A-Z]\w+)\b/,
     name: "storage.type.d"},
   string_escaped_char: 
    {patterns: 
      [{match: 
         /\\(?<_1>\\|[abefnprtv'"?]|[0-3]\d{,2}|x[0-9a-fA-F]{2}|u[0-9a-fA-F]{4}|U[0-9a-fA-F]{8}|&\w+;)/,
        name: "constant.character.escape.d"},
       {match: /\\./, name: "invalid.illegal.unknown-escape.d"}]},
   strings: 
    {patterns: 
      [{begin: /"/,
        beginCaptures: {0 => {name: "punctuation.definition.string.begin.d"}},
        end: "\"",
        endCaptures: {0 => {name: "punctuation.definition.string.end.d"}},
        name: "string.quoted.double.d",
        patterns: [{include: "#string_escaped_char"}]},
       {begin: /(?<_1>r)(?<_2>")/,
        beginCaptures: 
         {1 => {name: "storage.type.string.d"},
          2 => {name: "punctuation.definition.string.begin.d"}},
        end: "((?<=\")(\")|\")",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.d"},
          2 => {name: "meta.empty-string.double.d"}},
        name: "string.quoted.double.raw.d",
        patterns: [{include: "#regular_expressions"}]},
       {begin: /`/,
        beginCaptures: {0 => {name: "punctuation.definition.string.begin.d"}},
        end: "((?<=`)(`)|`)",
        endCaptures: 
         {1 => {name: "punctuation.definition.string.end.d"},
          2 => {name: "meta.empty-string.double.d"}},
        name: "string.quoted.double.raw.backtick.d"},
       {begin: /'/,
        beginCaptures: {0 => {name: "punctuation.definition.string.begin.d"}},
        end: "'",
        endCaptures: {0 => {name: "punctuation.definition.string.end.d"}},
        name: "string.quoted.single.d",
        patterns: [{include: "#string_escaped_char"}]}]},
   :"support-type-built-ins-classes-d" => 
    {match: 
      /\b(?<_1>AbstractServer|ArchiveMember|ArgParser|Barrier|BomSniffer|Buffer|BufferInput|BufferOutput|BufferSlice|BufferedFile|BufferedStream|BzipInput|BzipOutput|CFile|CacheInvalidatee|CacheInvalidator|CacheServer|CacheThread|Certificate|CertificateStore|CertificateStoreCtx|ChunkInput|ChunkOutput|ClassInfo|Cluster|ClusterCache|ClusterQueue|ClusterThread|CmdParser|ComObject|Compress|Condition|Conduit|Cookie|CookieParser|CookieStack|CounterInput|CounterOutput|DataFileInput|DataFileOutput|DataInput|DataOutput|Database|DatagramConduit|DeviceConduit|DigestInput|DigestOutput|DocPrinter|Document|DummyInputStream|DummyOutputStream|EndianInput|EndianOutput|EndianProtocol|EndianStream|EventSeekInputStream|EventSeekOutputStream|FTPConnection|Fiber|Field|File|FileConduit|FileFolder|FileGroup|FileInput|FileOutput|FilePath|FileScan|FilterStream|Foo|FormatOutput|GreedyInput|GreedyOutput|Gregorian|GrowBuffer|HeapCopy|HeapSlice|Hierarchy|HttpClient|HttpCookies|HttpCookiesView|HttpGet|HttpHeaders|HttpHeadersView|HttpParams|HttpPost|HttpStack|HttpTokens|HttpTriplet|IPv4Address|IUnknown|InputFilter|InternetAddress|InternetHost|Layout|LineInput|LineIterator|LinkedFolder|Log|MapInput|MapOutput|MappedBuffer|Md2|Md4|MemoryQueue|MemoryStream|MmFile|MmFileStream|ModuleInfo|MulticastConduit|Mutex|NativeProtocol|NetCall|NetHost|NetworkAlert|NetworkCache|NetworkCall|NetworkClient|NetworkCombo|NetworkMessage|NetworkQueue|NetworkRegistry|NetworkTask|NotImplemented|Object|Observer|OutBuffer|OutputFilter|PersistQueue|Pipe|PipeConduit|Print|PrivateKey|Process|Properties|Protocol|ProtocolReader|ProtocolWriter|PublicKey|PullParser|QueueFile|QueueServer|QueueThread|QueuedCache|QuoteIterator|Random|Range|ReadWriteMutex|Reader|Record|RegExp|RegExpT|RegexIterator|RollCall|SSLCtx|SSLServerSocket|SSLSocketConduit|SaxParser|SelectionKey|Semaphore|ServerSocket|ServerThread|Service|SimpleIterator|SliceInputStream|SliceSeekInputStream|SliceSeekOutputStream|SliceStream|SnoopInput|SnoopOutput|Socket|SocketConduit|SocketListener|SocketSet|SocketStream|Sprint|Stream|StreamIterator|TArrayStream|TaskServer|TaskThread|TcpSocket|Telnet|TempFile|Text|TextFileInput|TextFileOutput|TextView|Thread|ThreadGroup|ThreadLocal|ThreadPool|Token|TypeInfo|TypeInfo_AC|TypeInfo_Aa|TypeInfo_Ab|TypeInfo_Ac|TypeInfo_Ad|TypeInfo_Ae|TypeInfo_Af|TypeInfo_Ag|TypeInfo_Ah|TypeInfo_Ai|TypeInfo_Aj|TypeInfo_Ak|TypeInfo_Al|TypeInfo_Am|TypeInfo_Ao|TypeInfo_Ap|TypeInfo_Aq|TypeInfo_Ar|TypeInfo_Array|TypeInfo_As|TypeInfo_AssociativeArray|TypeInfo_At|TypeInfo_Au|TypeInfo_Av|TypeInfo_Aw|TypeInfo_C|TypeInfo_Class|TypeInfo_D|TypeInfo_Delegate|TypeInfo_Enum|TypeInfo_Function|TypeInfo_Interface|TypeInfo_P|TypeInfo_Pointer|TypeInfo_StaticArray|TypeInfo_Struct|TypeInfo_Tuple|TypeInfo_Typedef|TypeInfo_a|TypeInfo_b|TypeInfo_c|TypeInfo_d|TypeInfo_e|TypeInfo_f|TypeInfo_g|TypeInfo_h|TypeInfo_i|TypeInfo_j|TypeInfo_k|TypeInfo_l|TypeInfo_m|TypeInfo_o|TypeInfo_p|TypeInfo_q|TypeInfo_r|TypeInfo_s|TypeInfo_t|TypeInfo_u|TypeInfo_v|TypeInfo_w|TypedInput|TypedOutput|URIerror|UdpSocket|UnCompress|UniText|UnicodeBom|UnicodeFile|UnknownAddress|Uri|UtfInput|UtfOutput|VirtualFolder|WrapSeekInputStream|WrapSeekOutputStream|Writer|XmlPrinter|ZipArchive|ZipBlockReader|ZipBlockWriter|ZipEntry|ZipEntryVerifier|ZipFile|ZipFileGroup|ZipFolder|ZipSubFolder|ZipSubFolderEntry|ZipSubFolderGroup|ZlibInput|ZlibOutput)\b/,
     name: "support.type.built-ins.classes.d"},
   :"support-type-built-ins-d" => 
    {patterns: 
      [{include: "#support-type-built-ins-exceptions-d"},
       {include: "#support-type-built-ins-classes-d"},
       {include: "#support-type-built-ins-interfaces-d"},
       {include: "#support-type-built-ins-structs-d"}]},
   :"support-type-built-ins-exceptions-d" => 
    {match: 
      /\b(?<_1>AddressException|ArrayBoundsError|ArrayBoundsException|AssertError|AssertException|Base64CharException|Base64Exception|BzipClosedException|BzipException|ClusterEmptyException|ClusterFullException|ConvError|ConvOverflowError|ConversionException|CorruptedIteratorException|DatabaseException|DateParseError|Exception|FTPException|FiberException|FileException|FinalizeException|FormatError|HostException|IOException|IllegalArgumentException|IllegalElementException|InvalidKeyException|InvalidTypeException|LocaleException|ModuleCtorError|NoSuchElementException|OpenException|OpenRJException|OutOfMemoryException|PlatformException|ProcessCreateException|ProcessException|ProcessForkException|ProcessKillException|ProcessWaitException|ReadException|RegExpException|RegexException|RegistryException|SeekException|SharedLibException|SocketAcceptException|SocketException|StdioException|StreamException|StreamFileException|StringException|SwitchError|SwitchException|SyncException|TextException|ThreadError|ThreadException|UnboxException|UnicodeException|UtfException|VariantTypeMismatchException|Win32Exception|WriteException|XmlException|ZipChecksumException|ZipException|ZipExhaustedException|ZipNotSupportedException|ZlibClosedException|ZlibException|OurUnwindException|SysError)\b/,
     name: "support.type.built-ins.exceptions.d"},
   :"support-type-built-ins-interfaces-d" => 
    {match: 
      /\b(?<_1>Buffered|HttpParamsView|ICache|IChannel|IClassFactory|ICluster|IConduit|IConsumer|IEvent|IHierarchy|ILevel|IListener|IMessage|IMessageLoader|IOStream|IReadable|ISelectable|ISelectionSet|ISelector|IServer|IUnknown|IWritable|IXmlPrinter|InputStream|OutputStream|PathView|VfsFile|VfsFiles|VfsFolder|VfsFolderEntry|VfsFolders|VfsHost|VfsSync|ZipReader|ZipWriter)\b/,
     name: "support.type.built-ins.interfaces.d"},
   :"support-type-built-ins-structs-d" => 
    {match: 
      /\b(?<_1>ABC|ABCFLOAT|ACCEL|ACCESSTIMEOUT|ACCESS_ALLOWED_ACE|ACCESS_DENIED_ACE|ACE_HEADER|ACL|ACL_REVISION_INFORMATION|ACL_SIZE_INFORMATION|ACTION_HEADER|ADAPTER_STATUS|ADDJOB_INFO_1|ANIMATIONINFO|APPBARDATA|Argument|Atomic|Attribute|BITMAP|BITMAPCOREHEADER|BITMAPCOREINFO|BITMAPINFO|BITMAPINFOHEADER|BITMAPV4HEADER|BLOB|BROWSEINFO|BY_HANDLE_FILE_INFORMATION|Bar|Baz|BitArray|Box|BracketResult|ByteSwap|CANDIDATEFORM|CANDIDATELIST|CBTACTIVATESTRUCT|CBT_CREATEWND|CHARFORMAT|CHARRANGE|CHARSET|CHARSETINFO|CHAR_INFO|CIDA|CIEXYZ|CIEXYZTRIPLE|CLIENTCREATESTRUCT|CMINVOKECOMMANDINFO|COLORADJUSTMENT|COLORMAP|COMMCONFIG|COMMPROP|COMMTIMEOUTS|COMPAREITEMSTRUCT|COMPCOLOR|COMPOSITIONFORM|COMSTAT|CONNECTDLGSTRUCT|CONSOLE_CURSOR_INFO|CONTEXT|CONVCONTEXT|CONVINFO|COORD|COPYDATASTRUCT|CPINFO|CPLINFO|CREATESTRUCT|CREATE_PROCESS_DEBUG_INFO|CREATE_THREAD_DEBUG_INFO|CRITICAL_SECTION|CRITICAL_SECTION_DEBUG|CURRENCYFMT|CURSORSHAPE|CWPRETSTRUCT|CWPSTRUCT|CharClass|CharRange|Clock|CodePage|Console|DATATYPES_INFO_1|DCB|DDEACK|DDEADVISE|DDEDATA|DDELN|DDEML_MSG_HOOK_DATA|DDEPOKE|DDEUP|DEBUGHOOKINFO|DEBUG_EVENT|DELETEITEMSTRUCT|DEVMODE|DEVNAMES|DEV_BROADCAST_HDR|DEV_BROADCAST_OEM|DEV_BROADCAST_PORT|DEV_BROADCAST_VOLUME|DIBSECTION|DIR|DISCDLGSTRUCT|DISK_GEOMETRY|DISK_PERFORMANCE|DOCINFO|DOC_INFO_1|DOC_INFO_2|DRAGLISTINFO|DRAWITEMSTRUCT|DRAWTEXTPARAMS|DRIVER_INFO_1|DRIVER_INFO_2|DRIVER_INFO_3|DRIVE_LAYOUT_INFORMATION|Date|DateParse|DateTime|DirEntry|DynArg|EDITSTREAM|EMPTYRECORD|EMR|EMRABORTPATH|EMRANGLEARC|EMRARC|EMRBITBLT|EMRCREATEBRUSHINDIRECT|EMRCREATECOLORSPACE|EMRCREATEDIBPATTERNBRUSHPT|EMRCREATEMONOBRUSH|EMRCREATEPALETTE|EMRCREATEPEN|EMRELLIPSE|EMREOF|EMREXCLUDECLIPRECT|EMREXTCREATEFONTINDIRECTW|EMREXTCREATEPEN|EMREXTFLOODFILL|EMREXTSELECTCLIPRGN|EMREXTTEXTOUTA|EMRFILLPATH|EMRFILLRGN|EMRFORMAT|EMRFRAMERGN|EMRGDICOMMENT|EMRINVERTRGN|EMRLINETO|EMRMASKBLT|EMRMODIFYWORLDTRANSFORM|EMROFFSETCLIPRGN|EMRPLGBLT|EMRPOLYDRAW|EMRPOLYDRAW16|EMRPOLYLINE|EMRPOLYLINE16|EMRPOLYPOLYLINE|EMRPOLYPOLYLINE16|EMRPOLYTEXTOUTA|EMRRESIZEPALETTE|EMRRESTOREDC|EMRROUNDRECT|EMRSCALEVIEWPORTEXTEX|EMRSELECTCLIPPATH|EMRSELECTCOLORSPACE|EMRSELECTOBJECT|EMRSELECTPALETTE|EMRSETARCDIRECTION|EMRSETBKCOLOR|EMRSETCOLORADJUSTMENT|EMRSETDIBITSTODEVICE|EMRSETMAPPERFLAGS|EMRSETMITERLIMIT|EMRSETPALETTEENTRIES|EMRSETPIXELV|EMRSETVIEWPORTEXTEX|EMRSETVIEWPORTORGEX|EMRSETWORLDTRANSFORM|EMRSTRETCHBLT|EMRSTRETCHDIBITS|EMRTEXT|ENCORRECTTEXT|ENDROPFILES|ENHMETAHEADER|ENHMETARECORD|ENOLEOPFAILED|ENPROTECTED|ENSAVECLIPBOARD|ENUMLOGFONT|ENUMLOGFONTEX|ENUM_SERVICE_STATUS|EVENTLOGRECORD|EVENTMSG|EXCEPTION_DEBUG_INFO|EXCEPTION_POINTERS|EXCEPTION_RECORD|EXIT_PROCESS_DEBUG_INFO|EXIT_THREAD_DEBUG_INFO|EXTLOGFONT|EXTLOGPEN|EXT_BUTTON|EmptySlot|EndOfCDRecord|Environment|FILETIME|FILTERKEYS|FINDREPLACE|FINDTEXTEX|FIND_NAME_BUFFER|FIND_NAME_HEADER|FIXED|FLOATING_SAVE_AREA|FMS_GETDRIVEINFO|FMS_GETFILESEL|FMS_LOAD|FMS_TOOLBARLOAD|FOCUS_EVENT_RECORD|FONTSIGNATURE|FORMATRANGE|FORMAT_PARAMETERS|FORM_INFO_1|FileConst|FileHeader|FileRoots|FileSystem|FoldingCaseData|Foo|FtpConnectionDetail|FtpFeature|FtpFileInfo|FtpResponse|GC|GCP_RESULTS|GCStats|GENERIC_MAPPING|GLYPHMETRICS|GLYPHMETRICSFLOAT|GROUP_INFO_2|GUID|HANDLETABLE|HD_HITTESTINFO|HD_ITEM|HD_LAYOUT|HD_NOTIFY|HELPINFO|HELPWININFO|HIGHCONTRAST|HSZPAIR|HeaderElement|HttpConst|HttpHeader|HttpHeaderName|HttpResponses|HttpStatus|HttpToken|ICONINFO|ICONMETRICS|IMAGEINFO|IMAGE_DOS_HEADER|INPUT_RECORD|ITEMIDLIST|IeeeFlags|Interface|JOB_INFO_1|JOB_INFO_2|KERNINGPAIR|LANA_ENUM|LAYERPLANEDESCRIPTOR|LDT_ENTRY|LIST_ENTRY|LOAD_DLL_DEBUG_INFO|LOCALESIGNATURE|LOCALGROUP_INFO_0|LOCALGROUP_MEMBERS_INFO_0|LOCALGROUP_MEMBERS_INFO_3|LOGBRUSH|LOGCOLORSPACE|LOGFONT|LOGFONTA|LOGFONTW|LOGPALETTE|LOGPEN|LUID_AND_ATTRIBUTES|LV_COLUMN|LV_DISPINFO|LV_FINDINFO|LV_HITTESTINFO|LV_ITEM|LV_KEYDOWN|LocalFileHeader|MAT2|MD5_CTX|MDICREATESTRUCT|MEASUREITEMSTRUCT|MEMORYSTATUS|MEMORY_BASIC_INFORMATION|MENUEX_TEMPLATE_HEADER|MENUEX_TEMPLATE_ITEM|MENUITEMINFO|MENUITEMTEMPLATE|MENUITEMTEMPLATEHEADER|MENUTEMPLATE|MENU_EVENT_RECORD|METAFILEPICT|METARECORD|MINIMIZEDMETRICS|MINMAXINFO|MODEMDEVCAPS|MODEMSETTINGS|MONCBSTRUCT|MONCONVSTRUCT|MONERRSTRUCT|MONHSZSTRUCT|MONITOR_INFO_1|MONITOR_INFO_2|MONLINKSTRUCT|MONMSGSTRUCT|MOUSEHOOKSTRUCT|MOUSEKEYS|MOUSE_EVENT_RECORD|MSG|MSGBOXPARAMS|MSGFILTER|MULTIKEYHELP|NAME_BUFFER|NCB|NCCALCSIZE_PARAMS|NDDESHAREINFO|NETCONNECTINFOSTRUCT|NETINFOSTRUCT|NETRESOURCE|NEWCPLINFO|NEWTEXTMETRIC|NEWTEXTMETRICEX|NMHDR|NM_LISTVIEW|NM_TREEVIEW|NM_UPDOWNW|NONCLIENTMETRICS|NS_SERVICE_INFO|NUMBERFMT|OFNOTIFY|OFSTRUCT|OPENFILENAME|OPENFILENAMEA|OPENFILENAMEW|OSVERSIONINFO|OUTLINETEXTMETRIC|OUTPUT_DEBUG_STRING_INFO|OVERLAPPED|OffsetTypeInfo|PAINTSTRUCT|PALETTEENTRY|PANOSE|PARAFORMAT|PARTITION_INFORMATION|PERF_COUNTER_BLOCK|PERF_COUNTER_DEFINITION|PERF_DATA_BLOCK|PERF_INSTANCE_DEFINITION|PERF_OBJECT_TYPE|PIXELFORMATDESCRIPTOR|POINT|POINTFLOAT|POINTFX|POINTL|POINTS|POLYTEXT|PORT_INFO_1|PORT_INFO_2|PREVENT_MEDIA_REMOVAL|PRINTER_DEFAULTS|PRINTER_INFO_1|PRINTER_INFO_2|PRINTER_INFO_3|PRINTER_INFO_4|PRINTER_INFO_5|PRINTER_NOTIFY_INFO|PRINTER_NOTIFY_INFO_DATA|PRINTER_NOTIFY_OPTIONS|PRINTER_NOTIFY_OPTIONS_TYPE|PRINTPROCESSOR_INFO_1|PRIVILEGE_SET|PROCESS_HEAPENTRY|PROCESS_INFORMATION|PROPSHEETHEADER|PROPSHEETHEADER_U1|PROPSHEETHEADER_U2|PROPSHEETHEADER_U3|PROPSHEETPAGE|PROPSHEETPAGE_U1|PROPSHEETPAGE_U2|PROTOCOL_INFO|PROVIDOR_INFO_1|PSHNOTIFY|PUNCTUATION|PassByCopy|PassByRef|Phase1Info|PropertyConfigurator|QUERY_SERVICE_CONFIG|QUERY_SERVICE_LOCK_STATUS|RASAMB|RASCONN|RASCONNSTATUS|RASDIALEXTENSIONS|RASDIALPARAMS|RASENTRYNAME|RASPPPIP|RASPPPIPX|RASPPPNBF|RASTERIZER_STATUS|REASSIGN_BLOCKS|RECT|RECTL|REMOTE_NAME_INFO|REPASTESPECIAL|REQRESIZE|RGBQUAD|RGBTRIPLE|RGNDATA|RGNDATAHEADER|RIP_INFO|Runtime|SCROLLINFO|SECURITY_ATTRIBUTES|SECURITY_DESCRIPTOR|SECURITY_QUALITY_OF_SERVICE|SELCHANGE|SERIALKEYS|SERVICE_ADDRESS|SERVICE_ADDRESSES|SERVICE_INFO|SERVICE_STATUS|SERVICE_TABLE_ENTRY|SERVICE_TYPE_INFO_ABS|SERVICE_TYPE_VALUE_ABS|SESSION_BUFFER|SESSION_HEADER|SET_PARTITION_INFORMATION|SHFILEINFO|SHFILEOPSTRUCT|SHITEMID|SHNAMEMAPPING|SID|SID_AND_ATTRIBUTES|SID_IDENTIFIER_AUTHORITY|SINGLE_LIST_ENTRY|SIZE|SMALL_RECT|SOUNDSENTRY|STARTUPINFO|STICKYKEYS|STRRET|STYLEBUF|STYLESTRUCT|SYSTEMTIME|SYSTEM_AUDIT_ACE|SYSTEM_INFO|SYSTEM_INFO_U|SYSTEM_POWER_STATUS|Signal|SjLj_Function_Context|SpecialCaseData|TAPE_ERASE|TAPE_GET_DRIVE_PARAMETERS|TAPE_GET_MEDIA_PARAMETERS|TAPE_GET_POSITION|TAPE_PREPARE|TAPE_SET_DRIVE_PARAMETERS|TAPE_SET_MEDIA_PARAMETERS|TAPE_SET_POSITION|TAPE_WRITE_MARKS|TBADDBITMAP|TBBUTTON|TBNOTIFY|TBSAVEPARAMS|TCHOOSECOLOR|TCHOOSEFONT|TC_HITTESTINFO|TC_ITEM|TC_ITEMHEADER|TC_KEYDOWN|TEXTMETRIC|TEXTMETRICA|TEXTRANGE|TFINDTEXT|TIME_ZONE_INFORMATION|TOGGLEKEYS|TOKEN_CONTROL|TOKEN_DEFAULT_DACL|TOKEN_GROUPS|TOKEN_OWNER|TOKEN_PRIMARY_GROUP|TOKEN_PRIVILEGES|TOKEN_SOURCE|TOKEN_STATISTICS|TOKEN_USER|TOOLINFO|TOOLTIPTEXT|TPAGESETUPDLG|TPMPARAMS|TRANSMIT_FILE_BUFFERS|TREEITEM|TSMALLPOINT|TTHITTESTINFO|TTPOLYCURVE|TTPOLYGONHEADER|TVARIANT|TV_DISPINFO|TV_HITTESTINFO|TV_INSERTSTRUCT|TV_ITEM|TV_KEYDOWN|TV_SORTCB|Time|TimeOfDay|TimeSpan|Tuple|UDACCEL|ULARGE_INTEGER|UNIVERSAL_NAME_INFO|UNLOAD_DLL_DEBUG_INFO|USEROBJECTFLAGS|USER_INFO_0|USER_INFO_2|USER_INFO_3|UnicodeData|VALENT|VA_LIST|VERIFY_INFORMATION|VS_FIXEDFILEINFO|Variant|VfsFilterInfo|WIN32_FILE_ATTRIBUTE_DATA|WIN32_FIND_DATA|WIN32_FIND_DATAW|WIN32_STREAM_ID|WINDOWINFO|WINDOWPLACEMENT|WINDOWPOS|WINDOW_BUFFER_SIZE_RECORD|WNDCLASS|WNDCLASSA|WNDCLASSEX|WNDCLASSEXA|WSADATA|WallClock|XFORM|ZipEntryInfo)\b/,
     name: "support.type.built-ins.structs.d"},
   :"support-type-d" => 
    {match: /\b(?<_1>(?:tango|std)\.[\w\.]+)\b/, name: "support.type.d"}},
 scopeName: "source.d",
 uuid: "D7C3A109-0466-4C28-9ECF-10753300FF46"}
