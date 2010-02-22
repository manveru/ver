# Encoding: UTF-8

{fileTypes: ["m", "h"],
 foldingStartMarker: 
  /(?x)
	 \/\*\*(?!\*)
	|^(?![^{]*?\/\/|[^{]*?\/\*(?!.*?\*\/.*?\{)).*?\{\s*(?<_1>$|\/\/|\/\*(?!.*?\*\/.*\S))
	|^@(?<_2>interface|protocol|implementation)\b
	/,
 foldingStopMarker: /(?<!\*)\*\*\/|^\s*\}|^@end\b/,
 keyEquivalent: "^~O",
 name: "Objective-C",
 patterns: 
  [{begin: 
     /(?<_1>(?<_2>@)(?<_3>interface|protocol))(?!.+;)\s+(?<_4>[A-Za-z_][A-Za-z0-9_]*)\s*(?<_5>(?<_6>:)(?:\s*)(?<_7>[A-Za-z][A-Za-z0-9]*))?(?<_8>\s|\n)?/,
    captures: 
     {1 => {name: "storage.type.objc"},
      2 => {name: "punctuation.definition.storage.type.objc"},
      4 => {name: "entity.name.type.objc"},
      6 => {name: "punctuation.definition.entity.other.inherited-class.objc"},
      7 => {name: "entity.other.inherited-class.objc"},
      8 => {name: "meta.divider.objc"},
      9 => {name: "meta.inherited-class.objc"}},
    contentName: "meta.scope.interface.objc",
    end: "((@)end)\\b",
    name: "meta.interface-or-protocol.objc",
    patterns: [{include: "#interface_innards"}]},
   {begin: 
     /(?<_1>(?<_2>@)(?<_3>implementation))\s+(?<_4>[A-Za-z_][A-Za-z0-9_]*)\s*(?::\s*(?<_5>[A-Za-z][A-Za-z0-9]*))?/,
    captures: 
     {1 => {name: "storage.type.objc"},
      2 => {name: "punctuation.definition.storage.type.objc"},
      4 => {name: "entity.name.type.objc"},
      5 => {name: "entity.other.inherited-class.objc"}},
    contentName: "meta.scope.implementation.objc",
    end: "((@)end)\\b",
    name: "meta.implementation.objc",
    patterns: [{include: "#implementation_innards"}]},
   {begin: /@"/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.objc"}},
    end: "\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.objc"}},
    name: "string.quoted.double.objc",
    patterns: 
     [{match: /\\(?<_1>\\|[abefnrtv'"?]|[0-3]\d{,2}|[4-7]\d?|x[a-zA-Z0-9]+)/,
       name: "constant.character.escape.objc"},
      {match: /\\./, name: "invalid.illegal.unknown-escape.objc"}]},
   {begin: /\b(?<_1>id)\s*(?=<)/,
    beginCaptures: {1 => {name: "storage.type.objc"}},
    end: "(?<=>)",
    name: "meta.id-with-protocol.objc",
    patterns: [{include: "#protocol_list"}]},
   {match: /\b(?<_1>NS_DURING|NS_HANDLER|NS_ENDHANDLER)\b/,
    name: "keyword.control.macro.objc"},
   {captures: {1 => {name: "punctuation.definition.keyword.objc"}},
    match: /(?<_1>@)(?<_2>try|catch|finally|throw)\b/,
    name: "keyword.control.exception.objc"},
   {captures: {1 => {name: "punctuation.definition.keyword.objc"}},
    match: /(?<_1>@)(?<_2>synchronized)\b/,
    name: "keyword.control.synchronize.objc"},
   {captures: {1 => {name: "punctuation.definition.keyword.objc"}},
    match: /(?<_1>@)(?<_2>required|optional)\b/,
    name: "keyword.control.protocol-specification.objc"},
   {captures: {1 => {name: "punctuation.definition.keyword.objc"}},
    match: /(?<_1>@)(?<_2>defs|encode)\b/,
    name: "keyword.other.objc"},
   {match: /\bid\b(?<_1>\s|\n)?/, name: "storage.type.id.objc"},
   {match: /\b(?<_1>IBOutlet|IBAction|BOOL|SEL|id|unichar|IMP|Class)\b/,
    name: "storage.type.objc"},
   {captures: {1 => {name: "punctuation.definition.storage.type.objc"}},
    match: /(?<_1>@)(?<_2>class|protocol)\b/,
    name: "storage.type.objc"},
   {begin: /(?<_1>(?<_2>@)selector)\s*(?<_3>\()/,
    beginCaptures: 
     {1 => {name: "storage.type.objc"},
      2 => {name: "punctuation.definition.storage.type.objc"},
      3 => {name: "punctuation.definition.storage.type.objc"}},
    contentName: "meta.selector.method-name.objc",
    end: "(\\))",
    endCaptures: {1 => {name: "punctuation.definition.storage.type.objc"}},
    name: "meta.selector.objc",
    patterns: 
     [{captures: {1 => {name: "punctuation.separator.arguments.objc"}},
       match: /\b(?:[a-zA-Z_:][\w]*)+/,
       name: "support.function.any-method.name-of-parameter.objc"}]},
   {captures: {1 => {name: "punctuation.definition.storage.modifier.objc"}},
    match: /(?<_1>@)(?<_2>synchronized|public|private|protected)\b/,
    name: "storage.modifier.objc"},
   {match: /\b(?<_1>YES|NO|Nil|nil)\b/, name: "constant.language.objc"},
   {match: /\bNSApp\b/, name: "support.variable.foundation"},
   {captures: 
     {1 => {name: "punctuation.whitespace.support.function.cocoa.leopard"},
      2 => {name: "support.function.cocoa.leopard"}},
    match: 
     /(?<_1>\s*)\b(?<_2>NS(?<_3>Rect(?<_4>ToCGRect|FromCGRect)|MakeCollectable|S(?<_5>tringFromProtocol|ize(?<_6>ToCGSize|FromCGSize))|Draw(?<_7>NinePartImage|ThreePartImage)|P(?<_8>oint(?<_9>ToCGPoint|FromCGPoint)|rotocolFromString)|EventMaskFromType|Value))\b/},
   {captures: 
     {1 => {name: "punctuation.whitespace.support.function.leading.cocoa"},
      2 => {name: "support.function.cocoa"}},
    match: 
     /(?<_1>\s*)\b(?<_2>NS(?<_3>R(?<_4>ound(?<_5>DownToMultipleOfPageSize|UpToMultipleOfPageSize)|un(?<_6>CriticalAlertPanel(?<_7>RelativeToWindow)?|InformationalAlertPanel(?<_8>RelativeToWindow)?|AlertPanel(?<_9>RelativeToWindow)?)|e(?<_10>set(?<_11>MapTable|HashTable)|c(?<_12>ycleZone|t(?<_13>Clip(?<_14>List)?|F(?<_15>ill(?<_16>UsingOperation|List(?<_17>UsingOperation|With(?<_18>Grays|Colors(?<_19>UsingOperation)?))?)?|romString))|ordAllocationEvent)|turnAddress|leaseAlertPanel|a(?<_20>dPixel|l(?<_21>MemoryAvailable|locateCollectable))|gisterServicesProvider)|angeFromString)|Get(?<_22>SizeAndAlignment|CriticalAlertPanel|InformationalAlertPanel|UncaughtExceptionHandler|FileType(?<_23>s)?|WindowServerMemory|AlertPanel)|M(?<_24>i(?<_25>n(?<_26>X|Y)|d(?<_27>X|Y))|ouseInRect|a(?<_28>p(?<_29>Remove|Get|Member|Insert(?<_30>IfAbsent|KnownAbsent)?)|ke(?<_31>R(?<_32>ect|ange)|Size|Point)|x(?<_33>Range|X|Y)))|B(?<_34>itsPer(?<_35>SampleFromDepth|PixelFromDepth)|e(?<_36>stDepth|ep|gin(?<_37>CriticalAlertSheet|InformationalAlertSheet|AlertSheet)))|S(?<_38>ho(?<_39>uldRetainWithZone|w(?<_40>sServicesMenuItem|AnimationEffect))|tringFrom(?<_41>R(?<_42>ect|ange)|MapTable|S(?<_43>ize|elector)|HashTable|Class|Point)|izeFromString|e(?<_44>t(?<_45>ShowsServicesMenuItem|ZoneName|UncaughtExceptionHandler|FocusRingStyle)|lectorFromString|archPathForDirectoriesInDomains)|wap(?<_46>Big(?<_47>ShortToHost|IntToHost|DoubleToHost|FloatToHost|Long(?<_48>ToHost|LongToHost))|Short|Host(?<_49>ShortTo(?<_50>Big|Little)|IntTo(?<_51>Big|Little)|DoubleTo(?<_52>Big|Little)|FloatTo(?<_53>Big|Little)|Long(?<_54>To(?<_55>Big|Little)|LongTo(?<_56>Big|Little)))|Int|Double|Float|L(?<_57>ittle(?<_58>ShortToHost|IntToHost|DoubleToHost|FloatToHost|Long(?<_59>ToHost|LongToHost))|ong(?<_60>Long)?)))|H(?<_61>ighlightRect|o(?<_62>stByteOrder|meDirectory(?<_63>ForUser)?)|eight|ash(?<_64>Remove|Get|Insert(?<_65>IfAbsent|KnownAbsent)?)|FSType(?<_66>CodeFromFileType|OfFile))|N(?<_67>umberOfColorComponents|ext(?<_68>MapEnumeratorPair|HashEnumeratorItem))|C(?<_69>o(?<_70>n(?<_71>tainsRect|vert(?<_72>GlyphsToPackedGlyphs|Swapped(?<_73>DoubleToHost|FloatToHost)|Host(?<_74>DoubleToSwapped|FloatToSwapped)))|unt(?<_75>MapTable|HashTable|Frames|Windows(?<_76>ForContext)?)|py(?<_77>M(?<_78>emoryPages|apTableWithZone)|Bits|HashTableWithZone|Object)|lorSpaceFromDepth|mpare(?<_79>MapTables|HashTables))|lassFromString|reate(?<_80>MapTable(?<_81>WithZone)?|HashTable(?<_82>WithZone)?|Zone|File(?<_83>namePboardType|ContentsPboardType)))|TemporaryDirectory|I(?<_84>s(?<_85>ControllerMarker|EmptyRect|FreedObject)|n(?<_86>setRect|crementExtraRefCount|te(?<_87>r(?<_88>sect(?<_89>sRect|ionR(?<_90>ect|ange))|faceStyleForKey)|gralRect)))|Zone(?<_91>Realloc|Malloc|Name|Calloc|Fr(?<_92>omPointer|ee))|O(?<_93>penStepRootDirectory|ffsetRect)|D(?<_94>i(?<_95>sableScreenUpdates|videRect)|ottedFrameRect|e(?<_96>c(?<_97>imal(?<_98>Round|Multiply|S(?<_99>tring|ubtract)|Normalize|Co(?<_100>py|mpa(?<_101>ct|re))|IsNotANumber|Divide|Power|Add)|rementExtraRefCountWasZero)|faultMallocZone|allocate(?<_102>MemoryPages|Object))|raw(?<_103>Gr(?<_104>oove|ayBezel)|B(?<_105>itmap|utton)|ColorTiledRects|TiledRects|DarkBezel|W(?<_106>hiteBezel|indowBackground)|LightBezel))|U(?<_107>serName|n(?<_108>ionR(?<_109>ect|ange)|registerServicesProvider)|pdateDynamicServices)|Java(?<_110>Bundle(?<_111>Setup|Cleanup)|Setup(?<_112>VirtualMachine)?|Needs(?<_113>ToLoadClasses|VirtualMachine)|ClassesF(?<_114>orBundle|romPath)|ObjectNamedInPath|ProvidesClasses)|P(?<_115>oint(?<_116>InRect|FromString)|erformService|lanarFromDepth|ageSize)|E(?<_117>n(?<_118>d(?<_119>MapTableEnumeration|HashTableEnumeration)|umerate(?<_120>MapTable|HashTable)|ableScreenUpdates)|qual(?<_121>R(?<_122>ects|anges)|Sizes|Points)|raseRect|xtraRefCount)|F(?<_123>ileTypeForHFSTypeCode|ullUserName|r(?<_124>ee(?<_125>MapTable|HashTable)|ame(?<_126>Rect(?<_127>WithWidth(?<_128>UsingOperation)?)?|Address)))|Wi(?<_129>ndowList(?<_130>ForContext)?|dth)|Lo(?<_131>cationInRange|g(?<_132>v|PageSize)?)|A(?<_133>ccessibility(?<_134>R(?<_135>oleDescription(?<_136>ForUIElement)?|aiseBadArgumentException)|Unignored(?<_137>Children(?<_138>ForOnlyChild)?|Descendant|Ancestor)|PostNotification|ActionDescription)|pplication(?<_139>Main|Load)|vailableWindowDepths|ll(?<_140>MapTable(?<_141>Values|Keys)|HashTableObjects|ocate(?<_142>MemoryPages|Collectable|Object)))))\b/},
   {match: 
     /\bNS(?<_1>RuleEditor|G(?<_2>arbageCollector|radient)|MapTable|HashTable|Co(?<_3>ndition|llectionView(?<_4>Item)?)|T(?<_5>oolbarItemGroup|extInputClient|r(?<_6>eeNode|ackingArea))|InvocationOperation|Operation(?<_7>Queue)?|D(?<_8>ictionaryController|ockTile)|P(?<_9>ointer(?<_10>Functions|Array)|athC(?<_11>o(?<_12>ntrol(?<_13>Delegate)?|mponentCell)|ell(?<_14>Delegate)?)|r(?<_15>intPanelAccessorizing|edicateEditor(?<_16>RowTemplate)?))|ViewController|FastEnumeration|Animat(?<_17>ionContext|ablePropertyContainer))\b/,
    name: "support.class.cocoa.leopard"},
   {match: 
     /\bNS(?<_1>R(?<_2>u(?<_3>nLoop|ler(?<_4>Marker|View))|e(?<_5>sponder|cursiveLock|lativeSpecifier)|an(?<_6>domSpecifier|geSpecifier))|G(?<_7>etCommand|lyph(?<_8>Generator|Storage|Info)|raphicsContext)|XML(?<_9>Node|D(?<_10>ocument|TD(?<_11>Node)?)|Parser|Element)|M(?<_12>iddleSpecifier|ov(?<_13>ie(?<_14>View)?|eCommand)|utable(?<_15>S(?<_16>tring|et)|C(?<_17>haracterSet|opying)|IndexSet|D(?<_18>ictionary|ata)|URLRequest|ParagraphStyle|A(?<_19>ttributedString|rray))|e(?<_20>ssagePort(?<_21>NameServer)?|nu(?<_22>Item(?<_23>Cell)?|View)?|t(?<_24>hodSignature|adata(?<_25>Item|Query(?<_26>ResultGroup|AttributeValueTuple)?)))|a(?<_27>ch(?<_28>BootstrapServer|Port)|trix))|B(?<_29>itmapImageRep|ox|u(?<_30>ndle|tton(?<_31>Cell)?)|ezierPath|rowser(?<_32>Cell)?)|S(?<_33>hadow|c(?<_34>anner|r(?<_35>ipt(?<_36>SuiteRegistry|C(?<_37>o(?<_38>ercionHandler|mmand(?<_39>Description)?)|lassDescription)|ObjectSpecifier|ExecutionContext|WhoseTest)|oll(?<_40>er|View)|een))|t(?<_41>epper(?<_42>Cell)?|atus(?<_43>Bar|Item)|r(?<_44>ing|eam))|imple(?<_45>HorizontalTypesetter|CString)|o(?<_46>cketPort(?<_47>NameServer)?|und|rtDescriptor)|p(?<_48>e(?<_49>cifierTest|ech(?<_50>Recognizer|Synthesizer)|ll(?<_51>Server|Checker))|litView)|e(?<_52>cureTextField(?<_53>Cell)?|t(?<_54>Command)?|archField(?<_55>Cell)?|rializer|gmentedC(?<_56>ontrol|ell))|lider(?<_57>Cell)?|avePanel)|H(?<_58>ost|TTP(?<_59>Cookie(?<_60>Storage)?|URLResponse)|elpManager)|N(?<_61>ib(?<_62>Con(?<_63>nector|trolConnector)|OutletConnector)?|otification(?<_64>Center|Queue)?|u(?<_65>ll|mber(?<_66>Formatter)?)|etService(?<_67>Browser)?|ameSpecifier)|C(?<_68>ha(?<_69>ngeSpelling|racterSet)|o(?<_70>n(?<_71>stantString|nection|trol(?<_72>ler)?|ditionLock)|d(?<_73>ing|er)|unt(?<_74>Command|edSet)|pying|lor(?<_75>Space|P(?<_76>ick(?<_77>ing(?<_78>Custom|Default)|er)|anel)|Well|List)?|m(?<_79>p(?<_80>oundPredicate|arisonPredicate)|boBox(?<_81>Cell)?))|u(?<_82>stomImageRep|rsor)|IImageRep|ell|l(?<_83>ipView|o(?<_84>seCommand|neCommand)|assDescription)|a(?<_85>ched(?<_86>ImageRep|URLResponse)|lendar(?<_87>Date)?)|reateCommand)|T(?<_88>hread|ypesetter|ime(?<_89>Zone|r)|o(?<_90>olbar(?<_91>Item(?<_92>Validations)?)?|kenField(?<_93>Cell)?)|ext(?<_94>Block|Storage|Container|Tab(?<_95>le(?<_96>Block)?)?|Input|View|Field(?<_97>Cell)?|List|Attachment(?<_98>Cell)?)?|a(?<_99>sk|b(?<_100>le(?<_101>Header(?<_102>Cell|View)|Column|View)|View(?<_103>Item)?))|reeController)|I(?<_104>n(?<_105>dex(?<_106>S(?<_107>pecifier|et)|Path)|put(?<_108>Manager|S(?<_109>tream|erv(?<_110>iceProvider|er(?<_111>MouseTracker)?)))|vocation)|gnoreMisspelledWords|mage(?<_112>Rep|Cell|View)?)|O(?<_113>ut(?<_114>putStream|lineView)|pen(?<_115>GL(?<_116>Context|Pixel(?<_117>Buffer|Format)|View)|Panel)|bj(?<_118>CTypeSerializationCallBack|ect(?<_119>Controller)?))|D(?<_120>i(?<_121>st(?<_122>antObject(?<_123>Request)?|ributed(?<_124>NotificationCenter|Lock))|ctionary|rectoryEnumerator)|ocument(?<_125>Controller)?|e(?<_126>serializer|cimalNumber(?<_127>Behaviors|Handler)?|leteCommand)|at(?<_128>e(?<_129>Components|Picker(?<_130>Cell)?|Formatter)?|a)|ra(?<_131>wer|ggingInfo))|U(?<_132>ser(?<_133>InterfaceValidations|Defaults(?<_134>Controller)?)|RL(?<_135>Re(?<_136>sponse|quest)|Handle(?<_137>Client)?|C(?<_138>onnection|ache|redential(?<_139>Storage)?)|Download(?<_140>Delegate)?|Prot(?<_141>ocol(?<_142>Client)?|ectionSpace)|AuthenticationChallenge(?<_143>Sender)?)?|n(?<_144>iqueIDSpecifier|doManager|archiver))|P(?<_145>ipe|o(?<_146>sitionalSpecifier|pUpButton(?<_147>Cell)?|rt(?<_148>Message|NameServer|Coder)?)|ICTImageRep|ersistentDocument|DFImageRep|a(?<_149>steboard|nel|ragraphStyle|geLayout)|r(?<_150>int(?<_151>Info|er|Operation|Panel)|o(?<_152>cessInfo|tocolChecker|perty(?<_153>Specifier|ListSerialization)|gressIndicator|xy)|edicate))|E(?<_154>numerator|vent|PSImageRep|rror|x(?<_155>ception|istsCommand|pression))|V(?<_156>iew(?<_157>Animation)?|al(?<_158>idated(?<_159>ToobarItem|UserInterfaceItem)|ue(?<_160>Transformer)?))|Keyed(?<_161>Unarchiver|Archiver)|Qui(?<_162>ckDrawView|tCommand)|F(?<_163>ile(?<_164>Manager|Handle|Wrapper)|o(?<_165>nt(?<_166>Manager|Descriptor|Panel)?|rm(?<_167>Cell|atter)))|W(?<_168>hoseSpecifier|indow(?<_169>Controller)?|orkspace)|L(?<_170>o(?<_171>c(?<_172>k(?<_173>ing)?|ale)|gicalTest)|evelIndicator(?<_174>Cell)?|ayoutManager)|A(?<_175>ssertionHandler|nimation|ctionCell|ttributedString|utoreleasePool|TSTypesetter|ppl(?<_176>ication|e(?<_177>Script|Event(?<_178>Manager|Descriptor)))|ffineTransform|lert|r(?<_179>chiver|ray(?<_180>Controller)?)))\b/,
    name: "support.class.cocoa"},
   {match: 
     /\bNS(?<_1>R(?<_2>oundingMode|ule(?<_3>Editor(?<_4>RowType|NestingMode)|rOrientation)|e(?<_5>questUserAttentionType|lativePosition))|G(?<_6>lyphInscription|radientDrawingOptions)|XML(?<_7>NodeKind|D(?<_8>ocumentContentKind|TDNodeKind)|ParserError)|M(?<_9>ultibyteGlyphPacking|apTableOptions)|B(?<_10>itmapFormat|oxType|ezierPathElement|ackgroundStyle|rowserDropOperation)|S(?<_11>tr(?<_12>ing(?<_13>CompareOptions|DrawingOptions|EncodingConversionOptions)|eam(?<_14>Status|Event))|p(?<_15>eechBoundary|litViewDividerStyle)|e(?<_16>archPathD(?<_17>irectory|omainMask)|gmentS(?<_18>tyle|witchTracking))|liderType|aveOptions)|H(?<_19>TTPCookieAcceptPolicy|ashTableOptions)|N(?<_20>otification(?<_21>SuspensionBehavior|Coalescing)|umberFormatter(?<_22>RoundingMode|Behavior|Style|PadPosition)|etService(?<_23>sError|Options))|C(?<_24>haracterCollection|o(?<_25>lor(?<_26>RenderingIntent|SpaceModel|PanelMode)|mp(?<_27>oundPredicateType|arisonPredicateModifier))|ellStateValue|al(?<_28>culationError|endarUnit))|T(?<_29>ypesetterControlCharacterAction|imeZoneNameStyle|e(?<_30>stComparisonOperation|xt(?<_31>Block(?<_32>Dimension|V(?<_33>erticalAlignment|alueType)|Layer)|TableLayoutAlgorithm|FieldBezelStyle))|ableView(?<_34>SelectionHighlightStyle|ColumnAutoresizingStyle)|rackingAreaOptions)|I(?<_35>n(?<_36>sertionPosition|te(?<_37>rfaceStyle|ger))|mage(?<_38>RepLoadStatus|Scaling|CacheMode|FrameStyle|LoadStatus|Alignment))|Ope(?<_39>nGLPixelFormatAttribute|rationQueuePriority)|Date(?<_40>Picker(?<_41>Mode|Style)|Formatter(?<_42>Behavior|Style))|U(?<_43>RL(?<_44>RequestCachePolicy|HandleStatus|C(?<_45>acheStoragePolicy|redentialPersistence))|Integer)|P(?<_46>o(?<_47>stingStyle|int(?<_48>ingDeviceType|erFunctionsOptions)|pUpArrowPosition)|athStyle|r(?<_49>int(?<_50>ing(?<_51>Orientation|PaginationMode)|erTableStatus|PanelOptions)|opertyList(?<_52>MutabilityOptions|Format)|edicateOperatorType))|ExpressionType|KeyValue(?<_53>SetMutationKind|Change)|QTMovieLoopMode|F(?<_54>indPanel(?<_55>SubstringMatchType|Action)|o(?<_56>nt(?<_57>RenderingMode|FamilyClass)|cusRingPlacement))|W(?<_58>hoseSubelementIdentifier|ind(?<_59>ingRule|ow(?<_60>B(?<_61>utton|ackingLocation)|SharingType|CollectionBehavior)))|L(?<_62>ine(?<_63>MovementDirection|SweepDirection|CapStyle|JoinStyle)|evelIndicatorStyle)|Animation(?<_64>BlockingMode|Curve))\b/,
    name: "support.type.cocoa.leopard"},
   {match: 
     /\bC(?<_1>I(?<_2>Sampler|Co(?<_3>ntext|lor)|Image(?<_4>Accumulator)?|PlugIn(?<_5>Registration)?|Vector|Kernel|Filter(?<_6>Generator|Shape)?)|A(?<_7>Renderer|MediaTiming(?<_8>Function)?|BasicAnimation|ScrollLayer|Constraint(?<_9>LayoutManager)?|T(?<_10>iledLayer|extLayer|rans(?<_11>ition|action))|OpenGLLayer|PropertyAnimation|KeyframeAnimation|Layer|A(?<_12>nimation(?<_13>Group)?|ction)))\b/,
    name: "support.class.quartz"},
   {match: 
     /\bC(?<_1>G(?<_2>Float|Point|Size|Rect)|IFormat|AConstraintAttribute)\b/,
    name: "support.type.quartz"},
   {match: 
     /\bNS(?<_1>R(?<_2>ect(?<_3>Edge)?|ange)|G(?<_4>lyph(?<_5>Relation|LayoutMode)?|radientType)|M(?<_6>odalSession|a(?<_7>trixMode|p(?<_8>Table|Enumerator)))|B(?<_9>itmapImageFileType|orderType|uttonType|ezelStyle|ackingStoreType|rowserColumnResizingType)|S(?<_10>cr(?<_11>oll(?<_12>er(?<_13>Part|Arrow)|ArrowPosition)|eenAuxiliaryOpaque)|tringEncoding|ize|ocketNativeHandle|election(?<_14>Granularity|Direction|Affinity)|wapped(?<_15>Double|Float)|aveOperationType)|Ha(?<_16>sh(?<_17>Table|Enumerator)|ndler(?<_18>2)?)|C(?<_19>o(?<_20>ntrol(?<_21>Size|Tint)|mp(?<_22>ositingOperation|arisonResult))|ell(?<_23>State|Type|ImagePosition|Attribute))|T(?<_24>hreadPrivate|ypesetterGlyphInfo|i(?<_25>ckMarkPosition|tlePosition|meInterval)|o(?<_26>ol(?<_27>TipTag|bar(?<_28>SizeMode|DisplayMode))|kenStyle)|IFFCompression|ext(?<_29>TabType|Alignment)|ab(?<_30>State|leViewDropOperation|ViewType)|rackingRectTag)|ImageInterpolation|Zone|OpenGL(?<_31>ContextAuxiliary|PixelFormatAuxiliary)|D(?<_32>ocumentChangeType|atePickerElementFlags|ra(?<_33>werState|gOperation))|UsableScrollerParts|P(?<_34>oint|r(?<_35>intingPageOrder|ogressIndicator(?<_36>Style|Th(?<_37>ickness|readInfo))))|EventType|KeyValueObservingOptions|Fo(?<_38>nt(?<_39>SymbolicTraits|TraitMask|Action)|cusRingType)|W(?<_40>indow(?<_41>OrderingMode|Depth)|orkspace(?<_42>IconCreationOptions|LaunchOptions)|ritingDirection)|L(?<_43>ineBreakMode|ayout(?<_44>Status|Direction))|A(?<_45>nimation(?<_46>Progress|Effect)|ppl(?<_47>ication(?<_48>TerminateReply|DelegateReply|PrintReply)|eEventManagerSuspensionID)|ffineTransformStruct|lertStyle))\b/,
    name: "support.type.cocoa"},
   {match: /\bNS(?<_1>NotFound|Ordered(?<_2>Ascending|Descending|Same))\b/,
    name: "support.constant.cocoa"},
   {match: 
     /\bNS(?<_1>MenuDidBeginTracking|ViewDidUpdateTrackingAreas)?Notification\b/,
    name: "support.constant.notification.cocoa.leopard"},
   {match: 
     /\bNS(?<_1>Menu(?<_2>Did(?<_3>RemoveItem|SendAction|ChangeItem|EndTracking|AddItem)|WillSendAction)|S(?<_4>ystemColorsDidChange|plitView(?<_5>DidResizeSubviews|WillResizeSubviews))|C(?<_6>o(?<_7>nt(?<_8>extHelpModeDid(?<_9>Deactivate|Activate)|rolT(?<_10>intDidChange|extDid(?<_11>BeginEditing|Change|EndEditing)))|lor(?<_12>PanelColorDidChange|ListDidChange)|mboBox(?<_13>Selection(?<_14>IsChanging|DidChange)|Will(?<_15>Dismiss|PopUp)))|lassDescriptionNeededForClass)|T(?<_16>oolbar(?<_17>DidRemoveItem|WillAddItem)|ext(?<_18>Storage(?<_19>DidProcessEditing|WillProcessEditing)|Did(?<_20>BeginEditing|Change|EndEditing)|View(?<_21>DidChange(?<_22>Selection|TypingAttributes)|WillChangeNotifyingTextView))|ableView(?<_23>Selection(?<_24>IsChanging|DidChange)|ColumnDid(?<_25>Resize|Move)))|ImageRepRegistryDidChange|OutlineView(?<_26>Selection(?<_27>IsChanging|DidChange)|ColumnDid(?<_28>Resize|Move)|Item(?<_29>Did(?<_30>Collapse|Expand)|Will(?<_31>Collapse|Expand)))|Drawer(?<_32>Did(?<_33>Close|Open)|Will(?<_34>Close|Open))|PopUpButton(?<_35>CellWillPopUp|WillPopUp)|View(?<_36>GlobalFrameDidChange|BoundsDidChange|F(?<_37>ocusDidChange|rameDidChange))|FontSetChanged|W(?<_38>indow(?<_39>Did(?<_40>Resi(?<_41>ze|gn(?<_42>Main|Key))|M(?<_43>iniaturize|ove)|Become(?<_44>Main|Key)|ChangeScreen(?<_45>|Profile)|Deminiaturize|Update|E(?<_46>ndSheet|xpose))|Will(?<_47>M(?<_48>iniaturize|ove)|BeginSheet|Close))|orkspace(?<_49>SessionDid(?<_50>ResignActive|BecomeActive)|Did(?<_51>Mount|TerminateApplication|Unmount|PerformFileOperation|Wake|LaunchApplication)|Will(?<_52>Sleep|Unmount|PowerOff|LaunchApplication)))|A(?<_53>ntialiasThresholdChanged|ppl(?<_54>ication(?<_55>Did(?<_56>ResignActive|BecomeActive|Hide|ChangeScreenParameters|U(?<_57>nhide|pdate)|FinishLaunching)|Will(?<_58>ResignActive|BecomeActive|Hide|Terminate|U(?<_59>nhide|pdate)|FinishLaunching))|eEventManagerWillProcessFirstEvent)))Notification\b/,
    name: "support.constant.notification.cocoa"},
   {match: 
     /\bNS(?<_1>RuleEditor(?<_2>RowType(?<_3>Simple|Compound)|NestingMode(?<_4>Si(?<_5>ngle|mple)|Compound|List))|GradientDraws(?<_6>BeforeStartingLocation|AfterEndingLocation)|M(?<_7>inusSetExpressionType|a(?<_8>chPortDeallocate(?<_9>ReceiveRight|SendRight|None)|pTable(?<_10>StrongMemory|CopyIn|ZeroingWeakMemory|ObjectPointerPersonality)))|B(?<_11>oxCustom|undleExecutableArchitecture(?<_12>X86|I386|PPC(?<_13>64)?)|etweenPredicateOperatorType|ackgroundStyle(?<_14>Raised|Dark|L(?<_15>ight|owered)))|S(?<_16>tring(?<_17>DrawingTruncatesLastVisibleLine|EncodingConversion(?<_18>ExternalRepresentation|AllowLossy))|ubqueryExpressionType|p(?<_19>e(?<_20>ech(?<_21>SentenceBoundary|ImmediateBoundary|WordBoundary)|llingState(?<_22>GrammarFlag|SpellingFlag))|litViewDividerStyleThi(?<_23>n|ck))|e(?<_24>rvice(?<_25>RequestTimedOutError|M(?<_26>iscellaneousError|alformedServiceDictionaryError)|InvalidPasteboardDataError|ErrorM(?<_27>inimum|aximum)|Application(?<_28>NotFoundError|LaunchFailedError))|gmentStyle(?<_29>Round(?<_30>Rect|ed)|SmallSquare|Capsule|Textured(?<_31>Rounded|Square)|Automatic)))|H(?<_32>UDWindowMask|ashTable(?<_33>StrongMemory|CopyIn|ZeroingWeakMemory|ObjectPointerPersonality))|N(?<_34>oModeColorPanel|etServiceNoAutoRename)|C(?<_35>hangeRedone|o(?<_36>ntainsPredicateOperatorType|l(?<_37>orRenderingIntent(?<_38>RelativeColorimetric|Saturation|Default|Perceptual|AbsoluteColorimetric)|lectorDisabledOption))|ellHit(?<_39>None|ContentArea|TrackableArea|EditableTextArea))|T(?<_40>imeZoneNameStyle(?<_41>S(?<_42>hort(?<_43>Standard|DaylightSaving)|tandard)|DaylightSaving)|extFieldDatePickerStyle|ableViewSelectionHighlightStyle(?<_44>Regular|SourceList)|racking(?<_45>Mouse(?<_46>Moved|EnteredAndExited)|CursorUpdate|InVisibleRect|EnabledDuringMouseDrag|A(?<_47>ssumeInside|ctive(?<_48>In(?<_49>KeyWindow|ActiveApp)|WhenFirstResponder|Always))))|I(?<_50>n(?<_51>tersectSetExpressionType|dexedColorSpaceModel)|mageScale(?<_52>None|Proportionally(?<_53>Down|UpOrDown)|AxesIndependently))|Ope(?<_54>nGLPFAAllowOfflineRenderers|rationQueue(?<_55>DefaultMaxConcurrentOperationCount|Priority(?<_56>High|Normal|Very(?<_57>High|Low)|Low)))|D(?<_58>iacriticInsensitiveSearch|ownloadsDirectory)|U(?<_59>nionSetExpressionType|TF(?<_60>16(?<_61>BigEndianStringEncoding|StringEncoding|LittleEndianStringEncoding)|32(?<_62>BigEndianStringEncoding|StringEncoding|LittleEndianStringEncoding)))|P(?<_63>ointerFunctions(?<_64>Ma(?<_65>chVirtualMemory|llocMemory)|Str(?<_66>ongMemory|uctPersonality)|C(?<_67>StringPersonality|opyIn)|IntegerPersonality|ZeroingWeakMemory|O(?<_68>paque(?<_69>Memory|Personality)|bjectP(?<_70>ointerPersonality|ersonality)))|at(?<_71>hStyle(?<_72>Standard|NavigationBar|PopUp)|ternColorSpaceModel)|rintPanelShows(?<_73>Scaling|Copies|Orientation|P(?<_74>a(?<_75>perSize|ge(?<_76>Range|SetupAccessory))|review)))|Executable(?<_77>RuntimeMismatchError|NotLoadableError|ErrorM(?<_78>inimum|aximum)|L(?<_79>inkError|oadError)|ArchitectureMismatchError)|KeyValueObservingOption(?<_80>Initial|Prior)|F(?<_81>i(?<_82>ndPanelSubstringMatchType(?<_83>StartsWith|Contains|EndsWith|FullWord)|leRead(?<_84>TooLargeError|UnknownStringEncodingError))|orcedOrderingSearch)|Wi(?<_85>ndow(?<_86>BackingLocation(?<_87>MainMemory|Default|VideoMemory)|Sharing(?<_88>Read(?<_89>Only|Write)|None)|CollectionBehavior(?<_90>MoveToActiveSpace|CanJoinAllSpaces|Default))|dthInsensitiveSearch)|AggregateExpressionType)\b/,
    name: "support.constant.cocoa.leopard"},
   {match: 
     /\bNS(?<_1>R(?<_2>GB(?<_3>ModeColorPanel|ColorSpaceModel)|ight(?<_4>Mouse(?<_5>D(?<_6>own(?<_7>Mask)?|ragged(?<_8>Mask)?)|Up(?<_9>Mask)?)|T(?<_10>ext(?<_11>Movement|Alignment)|ab(?<_12>sBezelBorder|StopType))|ArrowFunctionKey)|ound(?<_13>RectBezelStyle|Bankers|ed(?<_14>BezelStyle|TokenStyle|DisclosureBezelStyle)|Down|Up|Plain|Line(?<_15>CapStyle|JoinStyle))|un(?<_16>StoppedResponse|ContinuesResponse|AbortedResponse)|e(?<_17>s(?<_18>izableWindowMask|et(?<_19>CursorRectsRunLoopOrdering|FunctionKey))|ce(?<_20>ssedBezelStyle|iver(?<_21>sCantHandleCommandScriptError|EvaluationScriptError))|turnTextMovement|doFunctionKey|quiredArgumentsMissingScriptError|l(?<_22>evancyLevelIndicatorStyle|ative(?<_23>Before|After))|gular(?<_24>SquareBezelStyle|ControlSize)|moveTraitFontAction)|a(?<_25>n(?<_26>domSubelement|geDateMode)|tingLevelIndicatorStyle|dio(?<_27>ModeMatrix|Button)))|G(?<_28>IFFileType|lyph(?<_29>Below|Inscribe(?<_30>B(?<_31>elow|ase)|Over(?<_32>strike|Below)|Above)|Layout(?<_33>WithPrevious|A(?<_34>tAPoint|gainstAPoint))|A(?<_35>ttribute(?<_36>BidiLevel|Soft|Inscribe|Elastic)|bove))|r(?<_37>ooveBorder|eaterThan(?<_38>Comparison|OrEqualTo(?<_39>Comparison|PredicateOperatorType)|PredicateOperatorType)|a(?<_40>y(?<_41>ModeColorPanel|ColorSpaceModel)|dient(?<_42>None|Con(?<_43>cave(?<_44>Strong|Weak)|vex(?<_45>Strong|Weak)))|phiteControlTint)))|XML(?<_46>N(?<_47>o(?<_48>tationDeclarationKind|de(?<_49>CompactEmptyElement|IsCDATA|OptionsNone|Use(?<_50>SingleQuotes|DoubleQuotes)|Pre(?<_51>serve(?<_52>NamespaceOrder|C(?<_53>haracterReferences|DATA)|DTD|Prefixes|E(?<_54>ntities|mptyElements)|Quotes|Whitespace|A(?<_55>ttributeOrder|ll))|ttyPrint)|ExpandEmptyElement))|amespaceKind)|CommentKind|TextKind|InvalidKind|D(?<_56>ocument(?<_57>X(?<_58>MLKind|HTMLKind|Include)|HTMLKind|T(?<_59>idy(?<_60>XML|HTML)|extKind)|IncludeContentTypeDeclaration|Validate|Kind)|TDKind)|P(?<_61>arser(?<_62>GTRequiredError|XMLDeclNot(?<_63>StartedError|FinishedError)|Mi(?<_64>splaced(?<_65>XMLDeclarationError|CDATAEndStringError)|xedContentDeclNot(?<_66>StartedError|FinishedError))|S(?<_67>t(?<_68>andaloneValueError|ringNot(?<_69>StartedError|ClosedError))|paceRequiredError|eparatorRequiredError)|N(?<_70>MTOKENRequiredError|o(?<_71>t(?<_72>ationNot(?<_73>StartedError|FinishedError)|WellBalancedError)|DTDError)|amespaceDeclarationError|AMERequiredError)|C(?<_74>haracterRef(?<_75>In(?<_76>DTDError|PrologError|EpilogError)|AtEOFError)|o(?<_77>nditionalSectionNot(?<_78>StartedError|FinishedError)|mment(?<_79>NotFinishedError|ContainsDoubleHyphenError))|DATANotFinishedError)|TagNameMismatchError|In(?<_80>ternalError|valid(?<_81>HexCharacterRefError|C(?<_82>haracter(?<_83>RefError|InEntityError|Error)|onditionalSectionError)|DecimalCharacterRefError|URIError|Encoding(?<_84>NameError|Error)))|OutOfMemoryError|D(?<_85>ocumentStartError|elegateAbortedParseError|OCTYPEDeclNotFinishedError)|U(?<_86>RI(?<_87>RequiredError|FragmentError)|n(?<_88>declaredEntityError|parsedEntityError|knownEncodingError|finishedTagError))|P(?<_89>CDATARequiredError|ublicIdentifierRequiredError|arsedEntityRef(?<_90>MissingSemiError|NoNameError|In(?<_91>Internal(?<_92>SubsetError|Error)|PrologError|EpilogError)|AtEOFError)|r(?<_93>ocessingInstructionNot(?<_94>StartedError|FinishedError)|ematureDocumentEndError))|E(?<_95>n(?<_96>codingNotSupportedError|tity(?<_97>Ref(?<_98>In(?<_99>DTDError|PrologError|EpilogError)|erence(?<_100>MissingSemiError|WithoutNameError)|LoopError|AtEOFError)|BoundaryError|Not(?<_101>StartedError|FinishedError)|Is(?<_102>ParameterError|ExternalError)|ValueRequiredError))|qualExpectedError|lementContentDeclNot(?<_103>StartedError|FinishedError)|xt(?<_104>ernalS(?<_105>tandaloneEntityError|ubsetNotFinishedError)|raContentError)|mptyDocumentError)|L(?<_106>iteralNot(?<_107>StartedError|FinishedError)|T(?<_108>RequiredError|SlashRequiredError)|essThanSymbolInAttributeError)|Attribute(?<_109>RedefinedError|HasNoValueError|Not(?<_110>StartedError|FinishedError)|ListNot(?<_111>StartedError|FinishedError)))|rocessingInstructionKind)|E(?<_112>ntity(?<_113>GeneralKind|DeclarationKind|UnparsedKind|P(?<_114>ar(?<_115>sedKind|ameterKind)|redefined))|lement(?<_116>Declaration(?<_117>MixedKind|UndefinedKind|E(?<_118>lementKind|mptyKind)|Kind|AnyKind)|Kind))|Attribute(?<_119>N(?<_120>MToken(?<_121>sKind|Kind)|otationKind)|CDATAKind|ID(?<_122>Ref(?<_123>sKind|Kind)|Kind)|DeclarationKind|En(?<_124>tit(?<_125>yKind|iesKind)|umerationKind)|Kind))|M(?<_126>i(?<_127>n(?<_128>XEdge|iaturizableWindowMask|YEdge|uteCalendarUnit)|terLineJoinStyle|ddleSubelement|xedState)|o(?<_129>nthCalendarUnit|deSwitchFunctionKey|use(?<_130>Moved(?<_131>Mask)?|E(?<_132>ntered(?<_133>Mask)?|ventSubtype|xited(?<_134>Mask)?))|veToBezierPathElement|mentary(?<_135>ChangeButton|Push(?<_136>Button|InButton)|Light(?<_137>Button)?))|enuFunctionKey|a(?<_138>c(?<_139>intoshInterfaceStyle|OSRomanStringEncoding)|tchesPredicateOperatorType|ppedRead|x(?<_140>XEdge|YEdge))|ACHOperatingSystem)|B(?<_141>MPFileType|o(?<_142>ttomTabsBezelBorder|ldFontMask|rderlessWindowMask|x(?<_143>Se(?<_144>condary|parator)|OldStyle|Primary))|uttLineCapStyle|e(?<_145>zelBorder|velLineJoinStyle|low(?<_146>Bottom|Top)|gin(?<_147>sWith(?<_148>Comparison|PredicateOperatorType)|FunctionKey))|lueControlTint|ack(?<_149>spaceCharacter|tabTextMovement|ingStore(?<_150>Retained|Buffered|Nonretained)|TabCharacter|wardsSearch|groundTab)|r(?<_151>owser(?<_152>NoColumnResizing|UserColumnResizing|AutoColumnResizing)|eakFunctionKey))|S(?<_153>h(?<_154>ift(?<_155>JISStringEncoding|KeyMask)|ow(?<_156>ControlGlyphs|InvisibleGlyphs)|adowlessSquareBezelStyle)|y(?<_157>s(?<_158>ReqFunctionKey|tem(?<_159>D(?<_160>omainMask|efined(?<_161>Mask)?)|FunctionKey))|mbolStringEncoding)|c(?<_162>a(?<_163>nnedOption|le(?<_164>None|ToFit|Proportionally))|r(?<_165>oll(?<_166>er(?<_167>NoPart|Increment(?<_168>Page|Line|Arrow)|Decrement(?<_169>Page|Line|Arrow)|Knob(?<_170>Slot)?|Arrows(?<_171>M(?<_172>inEnd|axEnd)|None|DefaultSetting))|Wheel(?<_173>Mask)?|LockFunctionKey)|eenChangedEventType))|t(?<_174>opFunctionKey|r(?<_175>ingDrawing(?<_176>OneShot|DisableScreenFontSubstitution|Uses(?<_177>DeviceMetrics|FontLeading|LineFragmentOrigin))|eam(?<_178>Status(?<_179>Reading|NotOpen|Closed|Open(?<_180>ing)?|Error|Writing|AtEnd)|Event(?<_181>Has(?<_182>BytesAvailable|SpaceAvailable)|None|OpenCompleted|E(?<_183>ndEncountered|rrorOccurred)))))|i(?<_184>ngle(?<_185>DateMode|UnderlineStyle)|ze(?<_186>DownFontAction|UpFontAction))|olarisOperatingSystem|unOSOperatingSystem|pecialPageOrder|e(?<_187>condCalendarUnit|lect(?<_188>By(?<_189>Character|Paragraph|Word)|i(?<_190>ng(?<_191>Next|Previous)|onAffinity(?<_192>Downstream|Upstream))|edTab|FunctionKey)|gmentSwitchTracking(?<_193>Momentary|Select(?<_194>One|Any)))|quareLineCapStyle|witchButton|ave(?<_195>ToOperation|Op(?<_196>tions(?<_197>Yes|No|Ask)|eration)|AsOperation)|mall(?<_198>SquareBezelStyle|C(?<_199>ontrolSize|apsFontMask)|IconButtonBezelStyle))|H(?<_200>ighlightModeMatrix|SBModeColorPanel|o(?<_201>ur(?<_202>Minute(?<_203>SecondDatePickerElementFlag|DatePickerElementFlag)|CalendarUnit)|rizontalRuler|meFunctionKey)|TTPCookieAcceptPolicy(?<_204>Never|OnlyFromMainDocumentDomain|Always)|e(?<_205>lp(?<_206>ButtonBezelStyle|KeyMask|FunctionKey)|avierFontAction)|PUXOperatingSystem)|Year(?<_207>MonthDa(?<_208>yDatePickerElementFlag|tePickerElementFlag)|CalendarUnit)|N(?<_209>o(?<_210>n(?<_211>StandardCharacterSetFontMask|ZeroWindingRule|activatingPanelMask|LossyASCIIStringEncoding)|Border|t(?<_212>ification(?<_213>SuspensionBehavior(?<_214>Hold|Coalesce|D(?<_215>eliverImmediately|rop))|NoCoalescing|CoalescingOn(?<_216>Sender|Name)|DeliverImmediately|PostToAllSessions)|PredicateType|EqualToPredicateOperatorType)|S(?<_217>cr(?<_218>iptError|ollerParts)|ubelement|pecifierError)|CellMask|T(?<_219>itle|opLevelContainersSpecifierError|abs(?<_220>BezelBorder|NoBorder|LineBorder))|I(?<_221>nterfaceStyle|mage)|UnderlineStyle|FontChangeAction)|u(?<_222>ll(?<_223>Glyph|CellType)|m(?<_224>eric(?<_225>Search|PadKeyMask)|berFormatter(?<_226>Round(?<_227>Half(?<_228>Down|Up|Even)|Ceiling|Down|Up|Floor)|Behavior(?<_229>10|Default)|S(?<_230>cientificStyle|pellOutStyle)|NoStyle|CurrencyStyle|DecimalStyle|P(?<_231>ercentStyle|ad(?<_232>Before(?<_233>Suffix|Prefix)|After(?<_234>Suffix|Prefix))))))|e(?<_235>t(?<_236>Services(?<_237>BadArgumentError|NotFoundError|C(?<_238>ollisionError|ancelledError)|TimeoutError|InvalidError|UnknownError|ActivityInProgress)|workDomainMask)|wlineCharacter|xt(?<_239>StepInterfaceStyle|FunctionKey))|EXTSTEPStringEncoding|a(?<_240>t(?<_241>iveShortGlyphPacking|uralTextAlignment)|rrowFontMask))|C(?<_242>hange(?<_243>ReadOtherContents|GrayCell(?<_244>Mask)?|BackgroundCell(?<_245>Mask)?|Cleared|Done|Undone|Autosaved)|MYK(?<_246>ModeColorPanel|ColorSpaceModel)|ircular(?<_247>BezelStyle|Slider)|o(?<_248>n(?<_249>stantValueExpressionType|t(?<_250>inuousCapacityLevelIndicatorStyle|entsCellMask|ain(?<_251>sComparison|erSpecifierError)|rol(?<_252>Glyph|KeyMask))|densedFontMask)|lor(?<_253>Panel(?<_254>RGBModeMask|GrayModeMask|HSBModeMask|C(?<_255>MYKModeMask|olorListModeMask|ustomPaletteModeMask|rayonModeMask)|WheelModeMask|AllModesMask)|ListModeColorPanel)|reServiceDirectory|m(?<_256>p(?<_257>osite(?<_258>XOR|Source(?<_259>In|O(?<_260>ut|ver)|Atop)|Highlight|C(?<_261>opy|lear)|Destination(?<_262>In|O(?<_263>ut|ver)|Atop)|Plus(?<_264>Darker|Lighter))|ressedFontMask)|mandKeyMask))|u(?<_265>stom(?<_266>SelectorPredicateOperatorType|PaletteModeColorPanel)|r(?<_267>sor(?<_268>Update(?<_269>Mask)?|PointingDevice)|veToBezierPathElement))|e(?<_270>nterT(?<_271>extAlignment|abStopType)|ll(?<_272>State|H(?<_273>ighlighted|as(?<_274>Image(?<_275>Horizontal|OnLeftOrBottom)|OverlappingImage))|ChangesContents|Is(?<_276>Bordered|InsetButton)|Disabled|Editable|LightsBy(?<_277>Gray|Background|Contents)|AllowsMixedState))|l(?<_278>ipPagination|o(?<_279>s(?<_280>ePathBezierPathElement|ableWindowMask)|ckAndCalendarDatePickerStyle)|ear(?<_281>ControlTint|DisplayFunctionKey|LineFunctionKey))|a(?<_282>seInsensitive(?<_283>Search|PredicateOption)|n(?<_284>notCreateScriptCommandError|cel(?<_285>Button|TextMovement))|chesDirectory|lculation(?<_286>NoError|Overflow|DivideByZero|Underflow|LossOfPrecision)|rriageReturnCharacter)|r(?<_287>itical(?<_288>Request|AlertStyle)|ayonModeColorPanel))|T(?<_289>hick(?<_290>SquareBezelStyle|erSquareBezelStyle)|ypesetter(?<_291>Behavior|HorizontalTabAction|ContainerBreakAction|ZeroAdvancementAction|OriginalBehavior|ParagraphBreakAction|WhitespaceAction|L(?<_292>ineBreakAction|atestBehavior))|i(?<_293>ckMark(?<_294>Right|Below|Left|Above)|tledWindowMask|meZoneDatePickerElementFlag)|o(?<_295>olbarItemVisibilityPriority(?<_296>Standard|High|User|Low)|pTabsBezelBorder|ggleButton)|IFF(?<_297>Compression(?<_298>N(?<_299>one|EXT)|CCITTFAX(?<_300>3|4)|OldJPEG|JPEG|PackBits|LZW)|FileType)|e(?<_301>rminate(?<_302>Now|Cancel|Later)|xt(?<_303>Read(?<_304>InapplicableDocumentTypeError|WriteErrorM(?<_305>inimum|aximum))|Block(?<_306>M(?<_307>i(?<_308>nimum(?<_309>Height|Width)|ddleAlignment)|a(?<_310>rgin|ximum(?<_311>Height|Width)))|B(?<_312>o(?<_313>ttomAlignment|rder)|aselineAlignment)|Height|TopAlignment|P(?<_314>ercentageValueType|adding)|Width|AbsoluteValueType)|StorageEdited(?<_315>Characters|Attributes)|CellType|ured(?<_316>RoundedBezelStyle|BackgroundWindowMask|SquareBezelStyle)|Table(?<_317>FixedLayoutAlgorithm|AutomaticLayoutAlgorithm)|Field(?<_318>RoundedBezel|SquareBezel|AndStepperDatePickerStyle)|WriteInapplicableDocumentTypeError|ListPrependEnclosingMarker))|woByteGlyphPacking|ab(?<_319>Character|TextMovement|le(?<_320>tP(?<_321>oint(?<_322>Mask|EventSubtype)?|roximity(?<_323>Mask|EventSubtype)?)|Column(?<_324>NoResizing|UserResizingMask|AutoresizingMask)|View(?<_325>ReverseSequentialColumnAutoresizingStyle|GridNone|S(?<_326>olid(?<_327>HorizontalGridLineMask|VerticalGridLineMask)|equentialColumnAutoresizingStyle)|NoColumnAutoresizing|UniformColumnAutoresizingStyle|FirstColumnOnlyAutoresizingStyle|LastColumnOnlyAutoresizingStyle)))|rackModeMatrix)|I(?<_328>n(?<_329>sert(?<_330>CharFunctionKey|FunctionKey|LineFunctionKey)|t(?<_331>Type|ernalS(?<_332>criptError|pecifierError))|dexSubelement|validIndexSpecifierError|formational(?<_333>Request|AlertStyle)|PredicateOperatorType)|talicFontMask|SO(?<_334>2022JPStringEncoding|Latin(?<_335>1StringEncoding|2StringEncoding))|dentityMappingCharacterCollection|llegalTextMovement|mage(?<_336>R(?<_337>ight|ep(?<_338>MatchesDevice|LoadStatus(?<_339>ReadingHeader|Completed|InvalidData|Un(?<_340>expectedEOF|knownType)|WillNeedAllData)))|Below|C(?<_341>ellType|ache(?<_342>BySize|Never|Default|Always))|Interpolation(?<_343>High|None|Default|Low)|O(?<_344>nly|verlaps)|Frame(?<_345>Gr(?<_346>oove|ayBezel)|Button|None|Photo)|L(?<_347>oadStatus(?<_348>ReadError|C(?<_349>ompleted|ancelled)|InvalidData|UnexpectedEOF)|eft)|A(?<_350>lign(?<_351>Right|Bottom(?<_352>Right|Left)?|Center|Top(?<_353>Right|Left)?|Left)|bove)))|O(?<_354>n(?<_355>State|eByteGlyphPacking|OffButton|lyScrollerArrows)|ther(?<_356>Mouse(?<_357>D(?<_358>own(?<_359>Mask)?|ragged(?<_360>Mask)?)|Up(?<_361>Mask)?)|TextMovement)|SF1OperatingSystem|pe(?<_362>n(?<_363>GL(?<_364>GO(?<_365>Re(?<_366>setLibrary|tainRenderers)|ClearFormatCache|FormatCacheSize)|PFA(?<_367>R(?<_368>obust|endererID)|M(?<_369>inimumPolicy|ulti(?<_370>sample|Screen)|PSafe|aximumPolicy)|BackingStore|S(?<_371>creenMask|te(?<_372>ncilSize|reo)|ingleRenderer|upersample|ample(?<_373>s|Buffers|Alpha))|NoRecovery|C(?<_374>o(?<_375>lor(?<_376>Size|Float)|mpliant)|losestPolicy)|OffScreen|D(?<_377>oubleBuffer|epthSize)|PixelBuffer|VirtualScreenCount|FullScreen|Window|A(?<_378>cc(?<_379>umSize|elerated)|ux(?<_380>Buffers|DepthStencil)|l(?<_381>phaSize|lRenderers))))|StepUnicodeReservedBase)|rationNotSupportedForKeyS(?<_382>criptError|pecifierError))|ffState|KButton|rPredicateType|bjC(?<_383>B(?<_384>itfield|oolType)|S(?<_385>hortType|tr(?<_386>ingType|uctType)|electorType)|NoType|CharType|ObjectType|DoubleType|UnionType|PointerType|VoidType|FloatType|Long(?<_387>Type|longType)|ArrayType))|D(?<_388>i(?<_389>s(?<_390>c(?<_391>losureBezelStyle|reteCapacityLevelIndicatorStyle)|playWindowRunLoopOrdering)|acriticInsensitivePredicateOption|rect(?<_392>Selection|PredicateModifier))|o(?<_393>c(?<_394>ModalWindowMask|ument(?<_395>Directory|ationDirectory))|ubleType|wn(?<_396>TextMovement|ArrowFunctionKey))|e(?<_397>s(?<_398>cendingPageOrder|ktopDirectory)|cimalTabStopType|v(?<_399>ice(?<_400>NColorSpaceModel|IndependentModifierFlagsMask)|eloper(?<_401>Directory|ApplicationDirectory))|fault(?<_402>ControlTint|TokenStyle)|lete(?<_403>Char(?<_404>acter|FunctionKey)|FunctionKey|LineFunctionKey)|moApplicationDirectory)|a(?<_405>yCalendarUnit|teFormatter(?<_406>MediumStyle|Behavior(?<_407>10|Default)|ShortStyle|NoStyle|FullStyle|LongStyle))|ra(?<_408>wer(?<_409>Clos(?<_410>ingState|edState)|Open(?<_411>ingState|State))|gOperation(?<_412>Generic|Move|None|Copy|Delete|Private|Every|Link|All)))|U(?<_413>ser(?<_414>CancelledError|D(?<_415>irectory|omainMask)|FunctionKey)|RL(?<_416>Handle(?<_417>NotLoaded|Load(?<_418>Succeeded|InProgress|Failed))|CredentialPersistence(?<_419>None|Permanent|ForSession))|n(?<_420>scaledWindowMask|cachedRead|i(?<_421>codeStringEncoding|talicFontMask|fiedTitleAndToolbarWindowMask)|d(?<_422>o(?<_423>CloseGroupingRunLoopOrdering|FunctionKey)|e(?<_424>finedDateComponent|rline(?<_425>Style(?<_426>Single|None|Thick|Double)|Pattern(?<_427>Solid|D(?<_428>ot|ash(?<_429>Dot(?<_430>Dot)?)?)))))|known(?<_431>ColorSpaceModel|P(?<_432>ointingDevice|ageOrder)|KeyS(?<_433>criptError|pecifierError))|boldFontMask)|tilityWindowMask|TF8StringEncoding|p(?<_434>dateWindowsRunLoopOrdering|TextMovement|ArrowFunctionKey))|J(?<_435>ustifiedTextAlignment|PEG(?<_436>2000FileType|FileType)|apaneseEUC(?<_437>GlyphPacking|StringEncoding))|P(?<_438>o(?<_439>s(?<_440>t(?<_441>Now|erFontMask|WhenIdle|ASAP)|iti(?<_442>on(?<_443>Replace|Be(?<_444>fore|ginning)|End|After)|ve(?<_445>IntType|DoubleType|FloatType)))|pUp(?<_446>NoArrow|ArrowAt(?<_447>Bottom|Center))|werOffEventType|rtraitOrientation)|NGFileType|ush(?<_448>InCell(?<_449>Mask)?|OnPushOffButton)|e(?<_450>n(?<_451>TipMask|UpperSideMask|PointingDevice|LowerSideMask)|riodic(?<_452>Mask)?)|P(?<_453>S(?<_454>caleField|tatus(?<_455>Title|Field)|aveButton)|N(?<_456>ote(?<_457>Title|Field)|ame(?<_458>Title|Field))|CopiesField|TitleField|ImageButton|OptionsButton|P(?<_459>a(?<_460>perFeedButton|ge(?<_461>Range(?<_462>To|From)|ChoiceMatrix))|reviewButton)|LayoutButton)|lainTextTokenStyle|a(?<_463>useFunctionKey|ragraphSeparatorCharacter|ge(?<_464>DownFunctionKey|UpFunctionKey))|r(?<_465>int(?<_466>ing(?<_467>ReplyLater|Success|Cancelled|Failure)|ScreenFunctionKey|erTable(?<_468>NotFound|OK|Error)|FunctionKey)|o(?<_469>p(?<_470>ertyList(?<_471>XMLFormat|MutableContainers(?<_472>AndLeaves)?|BinaryFormat|Immutable|OpenStepFormat)|rietaryStringEncoding)|gressIndicator(?<_473>BarStyle|SpinningStyle|Preferred(?<_474>SmallThickness|Thickness|LargeThickness|AquaThickness)))|e(?<_475>ssedTab|vFunctionKey))|L(?<_476>HeightForm|CancelButton|TitleField|ImageButton|O(?<_477>KButton|rientationMatrix)|UnitsButton|PaperNameButton|WidthForm))|E(?<_478>n(?<_479>terCharacter|d(?<_480>sWith(?<_481>Comparison|PredicateOperatorType)|FunctionKey))|v(?<_482>e(?<_483>nOddWindingRule|rySubelement)|aluatedObjectExpressionType)|qualTo(?<_484>Comparison|PredicateOperatorType)|ra(?<_485>serPointingDevice|CalendarUnit|DatePickerElementFlag)|x(?<_486>clude(?<_487>10|QuickDrawElementsIconCreationOption)|pandedFontMask|ecuteFunctionKey))|V(?<_488>i(?<_489>ew(?<_490>M(?<_491>in(?<_492>XMargin|YMargin)|ax(?<_493>XMargin|YMargin))|HeightSizable|NotSizable|WidthSizable)|aPanelFontAction)|erticalRuler|a(?<_494>lidationErrorM(?<_495>inimum|aximum)|riableExpressionType))|Key(?<_496>SpecifierEvaluationScriptError|Down(?<_497>Mask)?|Up(?<_498>Mask)?|PathExpressionType|Value(?<_499>MinusSetMutation|SetSetMutation|Change(?<_500>Re(?<_501>placement|moval)|Setting|Insertion)|IntersectSetMutation|ObservingOption(?<_502>New|Old)|UnionSetMutation|ValidationError))|QTMovie(?<_503>NormalPlayback|Looping(?<_504>BackAndForthPlayback|Playback))|F(?<_505>1(?<_506>1FunctionKey|7FunctionKey|2FunctionKey|8FunctionKey|3FunctionKey|9FunctionKey|4FunctionKey|5FunctionKey|FunctionKey|0FunctionKey|6FunctionKey)|7FunctionKey|i(?<_507>nd(?<_508>PanelAction(?<_509>Replace(?<_510>A(?<_511>ndFind|ll(?<_512>InSelection)?))?|S(?<_513>howFindPanel|e(?<_514>tFindString|lectAll(?<_515>InSelection)?))|Next|Previous)|FunctionKey)|tPagination|le(?<_516>Read(?<_517>No(?<_518>SuchFileError|PermissionError)|CorruptFileError|In(?<_519>validFileNameError|applicableStringEncodingError)|Un(?<_520>supportedSchemeError|knownError))|HandlingPanel(?<_521>CancelButton|OKButton)|NoSuchFileError|ErrorM(?<_522>inimum|aximum)|Write(?<_523>NoPermissionError|In(?<_524>validFileNameError|applicableStringEncodingError)|OutOfSpaceError|Un(?<_525>supportedSchemeError|knownError))|LockingError)|xedPitchFontMask)|2(?<_526>1FunctionKey|7FunctionKey|2FunctionKey|8FunctionKey|3FunctionKey|9FunctionKey|4FunctionKey|5FunctionKey|FunctionKey|0FunctionKey|6FunctionKey)|o(?<_527>nt(?<_528>Mo(?<_529>noSpaceTrait|dernSerifsClass)|BoldTrait|S(?<_530>ymbolicClass|criptsClass|labSerifsClass|ansSerifClass)|C(?<_531>o(?<_532>ndensedTrait|llectionApplicationOnlyMask)|larendonSerifsClass)|TransitionalSerifsClass|I(?<_533>ntegerAdvancementsRenderingMode|talicTrait)|O(?<_534>ldStyleSerifsClass|rnamentalsClass)|DefaultRenderingMode|U(?<_535>nknownClass|IOptimizedTrait)|Panel(?<_536>S(?<_537>hadowEffectModeMask|t(?<_538>andardModesMask|rikethroughEffectModeMask)|izeModeMask)|CollectionModeMask|TextColorEffectModeMask|DocumentColorEffectModeMask|UnderlineEffectModeMask|FaceModeMask|All(?<_539>ModesMask|EffectsModeMask))|ExpandedTrait|VerticalTrait|F(?<_540>amilyClassMask|reeformSerifsClass)|Antialiased(?<_541>RenderingMode|IntegerAdvancementsRenderingMode))|cusRing(?<_542>Below|Type(?<_543>None|Default|Exterior)|Only|Above)|urByteGlyphPacking|rm(?<_544>attingError(?<_545>M(?<_546>inimum|aximum))?|FeedCharacter))|8FunctionKey|unction(?<_547>ExpressionType|KeyMask)|3(?<_548>1FunctionKey|2FunctionKey|3FunctionKey|4FunctionKey|5FunctionKey|FunctionKey|0FunctionKey)|9FunctionKey|4FunctionKey|P(?<_549>RevertButton|S(?<_550>ize(?<_551>Title|Field)|etButton)|CurrentField|Preview(?<_552>Button|Field))|l(?<_553>oat(?<_554>ingPointSamplesBitmapFormat|Type)|agsChanged(?<_555>Mask)?)|axButton|5FunctionKey|6FunctionKey)|W(?<_556>heelModeColorPanel|indow(?<_557>s(?<_558>NTOperatingSystem|CP125(?<_559>1StringEncoding|2StringEncoding|3StringEncoding|4StringEncoding|0StringEncoding)|95(?<_560>InterfaceStyle|OperatingSystem))|M(?<_561>iniaturizeButton|ovedEventType)|Below|CloseButton|ToolbarButton|ZoomButton|Out|DocumentIconButton|ExposedEventType|Above)|orkspaceLaunch(?<_562>NewInstance|InhibitingBackgroundOnly|Default|PreferringClassic|WithoutA(?<_563>ctivation|ddingToRecents)|A(?<_564>sync|nd(?<_565>Hide(?<_566>Others)?|Print)|llowingClassicStartup))|eek(?<_567>day(?<_568>CalendarUnit|OrdinalCalendarUnit)|CalendarUnit)|a(?<_569>ntsBidiLevels|rningAlertStyle)|r(?<_570>itingDirection(?<_571>RightToLeft|Natural|LeftToRight)|apCalendarComponents))|L(?<_572>i(?<_573>stModeMatrix|ne(?<_574>Moves(?<_575>Right|Down|Up|Left)|B(?<_576>order|reakBy(?<_577>C(?<_578>harWrapping|lipping)|Truncating(?<_579>Middle|Head|Tail)|WordWrapping))|S(?<_580>eparatorCharacter|weep(?<_581>Right|Down|Up|Left))|ToBezierPathElement|DoesntMove|arSlider)|teralSearch|kePredicateOperatorType|ghterFontAction|braryDirectory)|ocalDomainMask|e(?<_582>ssThan(?<_583>Comparison|OrEqualTo(?<_584>Comparison|PredicateOperatorType)|PredicateOperatorType)|ft(?<_585>Mouse(?<_586>D(?<_587>own(?<_588>Mask)?|ragged(?<_589>Mask)?)|Up(?<_590>Mask)?)|T(?<_591>ext(?<_592>Movement|Alignment)|ab(?<_593>sBezelBorder|StopType))|ArrowFunctionKey))|a(?<_594>yout(?<_595>RightToLeft|NotDone|CantFit|OutOfGlyphs|Done|LeftToRight)|ndscapeOrientation)|ABColorSpaceModel)|A(?<_596>sc(?<_597>iiWithDoubleByteEUCGlyphPacking|endingPageOrder)|n(?<_598>y(?<_599>Type|PredicateModifier|EventMask)|choredSearch|imation(?<_600>Blocking|Nonblocking(?<_601>Threaded)?|E(?<_602>ffect(?<_603>DisappearingItemDefault|Poof)|ase(?<_604>In(?<_605>Out)?|Out))|Linear)|dPredicateType)|t(?<_606>Bottom|tachmentCharacter|omicWrite|Top)|SCIIStringEncoding|d(?<_607>obe(?<_608>GB1CharacterCollection|CNS1CharacterCollection|Japan(?<_609>1CharacterCollection|2CharacterCollection)|Korea1CharacterCollection)|dTraitFontAction|minApplicationDirectory)|uto(?<_610>saveOperation|Pagination)|pp(?<_611>lication(?<_612>SupportDirectory|D(?<_613>irectory|e(?<_614>fined(?<_615>Mask)?|legateReply(?<_616>Success|Cancel|Failure)|activatedEventType))|ActivatedEventType)|KitDefined(?<_617>Mask)?)|l(?<_618>ternateKeyMask|pha(?<_619>ShiftKeyMask|NonpremultipliedBitmapFormat|FirstBitmapFormat)|ert(?<_620>SecondButtonReturn|ThirdButtonReturn|OtherReturn|DefaultReturn|ErrorReturn|FirstButtonReturn|AlternateReturn)|l(?<_621>ScrollerParts|DomainsMask|PredicateModifier|LibrariesDirectory|ApplicationsDirectory))|rgument(?<_622>sWrongScriptError|EvaluationScriptError)|bove(?<_623>Bottom|Top)|WTEventType))\b/,
    name: "support.constant.cocoa"},
   {include: "source.c"},
   {include: "#bracketed_content"}],
 repository: 
  {bracketed_content: 
    {begin: /\[/,
     beginCaptures: {0 => {name: "punctuation.section.scope.begin.objc"}},
     end: "\\]",
     endCaptures: {0 => {name: "punctuation.section.scope.end.objc"}},
     name: "meta.bracketed.objc",
     patterns: 
      [{begin: 
         /(?=predicateWithFormat:)(?<=NSPredicate )(?<_1>predicateWithFormat:)/,
        beginCaptures: 
         {1 => {name: "support.function.any-method.objc"},
          2 => {name: "punctuation.separator.arguments.objc"}},
        end: "(?=\\])",
        name: "meta.function-call.predicate.objc",
        patterns: 
         [{captures: {1 => {name: "punctuation.separator.arguments.objc"}},
           match: /\bargument(?<_1>Array|s)(?<_2>:)/,
           name: "support.function.any-method.name-of-parameter.objc"},
          {captures: {1 => {name: "punctuation.separator.arguments.objc"}},
           match: /\b\w+(?<_1>:)/,
           name: "invalid.illegal.unknown-method.objc"},
          {begin: /@"/,
           beginCaptures: 
            {0 => {name: "punctuation.definition.string.begin.objc"}},
           end: "\"",
           endCaptures: 
            {0 => {name: "punctuation.definition.string.end.objc"}},
           name: "string.quoted.double.objc",
           patterns: 
            [{match: /\b(?<_1>AND|OR|NOT|IN)\b/,
              name: "keyword.operator.logical.predicate.cocoa"},
             {match: /\b(?<_1>ALL|ANY|SOME|NONE)\b/,
              name: "constant.language.predicate.cocoa"},
             {match: 
               /\b(?<_1>NULL|NIL|SELF|TRUE|YES|FALSE|NO|FIRST|LAST|SIZE)\b/,
              name: "constant.language.predicate.cocoa"},
             {match: /\b(?<_1>MATCHES|CONTAINS|BEGINSWITH|ENDSWITH|BETWEEN)\b/,
              name: "keyword.operator.comparison.predicate.cocoa"},
             {match: /\bC(?<_1>ASEINSENSITIVE|I)\b/,
              name: "keyword.other.modifier.predicate.cocoa"},
             {match: 
               /\b(?<_1>ANYKEY|SUBQUERY|CAST|TRUEPREDICATE|FALSEPREDICATE)\b/,
              name: "keyword.other.predicate.cocoa"},
             {match: 
               /\\(?<_1>\\|[abefnrtv'"?]|[0-3]\d{,2}|[4-7]\d?|x[a-zA-Z0-9]+)/,
              name: "constant.character.escape.objc"},
             {match: /\\./, name: "invalid.illegal.unknown-escape.objc"}]},
          {include: "#special_variables"},
          {include: "#c_functions"},
          {include: "$base"}]},
       {begin: /(?=\w)(?<=[\w\])"] )(?<_1>\w+(?:(?<_2>:)|(?=\])))/,
        beginCaptures: 
         {1 => {name: "support.function.any-method.objc"},
          2 => {name: "punctuation.separator.arguments.objc"}},
        end: "(?=\\])",
        name: "meta.function-call.objc",
        patterns: 
         [{captures: {1 => {name: "punctuation.separator.arguments.objc"}},
           match: /\b\w+(?<_1>:)/,
           name: "support.function.any-method.name-of-parameter.objc"},
          {include: "#special_variables"},
          {include: "#c_functions"},
          {include: "$base"}]},
       {include: "#special_variables"},
       {include: "#c_functions"},
       {include: "$self"}]},
   c_functions: 
    {patterns: 
      [{captures: 
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
        name: "meta.function-call.c"}]},
   comment: 
    {patterns: 
      [{begin: /\/\*/,
        captures: {0 => {name: "punctuation.definition.comment.objc"}},
        end: "\\*/",
        name: "comment.block.objc"},
       {begin: /\/\//,
        beginCaptures: {0 => {name: "punctuation.definition.comment.objc"}},
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
   implementation_innards: 
    {patterns: 
      [{include: "#preprocessor-rule-enabled-implementation"},
       {include: "#preprocessor-rule-disabled-implementation"},
       {include: "#preprocessor-rule-other-implementation"},
       {include: "#property_directive"},
       {include: "#special_variables"},
       {include: "#method_super"},
       {include: "$base"}]},
   interface_innards: 
    {patterns: 
      [{include: "#preprocessor-rule-enabled-interface"},
       {include: "#preprocessor-rule-disabled-interface"},
       {include: "#preprocessor-rule-other-interface"},
       {include: "#properties"},
       {include: "#protocol_list"},
       {include: "#method"},
       {include: "$base"}]},
   method: 
    {begin: /^(?<_1>-|\+)\s*/,
     end: "(?=\\{|#)|;",
     name: "meta.function.objc",
     patterns: 
      [{begin: /(?<_1>\()/,
        captures: 
         {1 => {name: "punctuation.definition.type.objc"},
          2 => {name: "entity.name.function.objc"}},
        end: "(\\))\\s*(\\w+\\b)",
        name: "meta.return-type.objc",
        patterns: 
         [{include: "#protocol_list"},
          {include: "#protocol_type_qualifier"},
          {include: "$base"}]},
       {match: /\b\w+(?=:)/,
        name: "entity.name.function.name-of-parameter.objc"},
       {begin: /(?<_1>(?<_2>:))\s*(?<_3>\()/,
        beginCaptures: 
         {1 => {name: "entity.name.function.name-of-parameter.objc"},
          2 => {name: "punctuation.separator.arguments.objc"},
          3 => {name: "punctuation.definition.type.objc"}},
        end: "(\\))\\s*(\\w+\\b)?",
        endCaptures: 
         {1 => {name: "punctuation.definition.type.objc"},
          2 => {name: "variable.parameter.function.objc"}},
        name: "meta.argument-type.objc",
        patterns: 
         [{include: "#protocol_list"},
          {include: "#protocol_type_qualifier"},
          {include: "$base"}]},
       {include: "#comment"}]},
   method_super: 
    {begin: /^(?=-|\+)/,
     end: "(?<=\\})|(?=#)",
     name: "meta.function-with-body.objc",
     patterns: [{include: "#method"}, {include: "$base"}]},
   :"pragma-mark" => 
    {captures: 
      {1 => {name: "meta.preprocessor.c"},
       2 => {name: "keyword.control.import.pragma.c"},
       3 => {name: "meta.toc-list.pragma-mark.c"}},
     match: /^\s*(?<_1>#\s*(?<_2>pragma\s+mark)\s+(?<_3>.*))/,
     name: "meta.section"},
   :"preprocessor-rule-disabled-implementation" => 
    {begin: /^\s*(?<_1>#(?<_2>if)\s+(?<_3>0)\b).*/,
     captures: 
      {1 => {name: "meta.preprocessor.c"},
       2 => {name: "keyword.control.import.if.c"},
       3 => {name: "constant.numeric.preprocessor.c"}},
     end: "^\\s*(#\\s*(endif)\\b.*?(?:(?=(?://|/\\*))|$))",
     patterns: 
      [{begin: /^\s*(?<_1>#\s*(?<_2>else)\b)/,
        captures: 
         {1 => {name: "meta.preprocessor.c"},
          2 => {name: "keyword.control.import.else.c"}},
        end: "(?=^\\s*#\\s*endif\\b.*?(?:(?=(?://|/\\*))|$))",
        patterns: [{include: "#interface_innards"}]},
       {begin: //,
        end: "(?=^\\s*#\\s*(else|endif)\\b.*?(?:(?=(?://|/\\*))|$))",
        name: "comment.block.preprocessor.if-branch.c",
        patterns: [{include: "#disabled"}, {include: "#pragma-mark"}]}]},
   :"preprocessor-rule-disabled-interface" => 
    {begin: /^\s*(?<_1>#(?<_2>if)\s+(?<_3>0)\b).*/,
     captures: 
      {1 => {name: "meta.preprocessor.c"},
       2 => {name: "keyword.control.import.if.c"},
       3 => {name: "constant.numeric.preprocessor.c"}},
     end: "^\\s*(#\\s*(endif)\\b.*?(?:(?=(?://|/\\*))|$))",
     patterns: 
      [{begin: /^\s*(?<_1>#\s*(?<_2>else)\b)/,
        captures: 
         {1 => {name: "meta.preprocessor.c"},
          2 => {name: "keyword.control.import.else.c"}},
        end: "(?=^\\s*#\\s*endif\\b.*?(?:(?=(?://|/\\*))|$))",
        patterns: [{include: "#interface_innards"}]},
       {begin: //,
        end: "(?=^\\s*#\\s*(else|endif)\\b.*?(?:(?=(?://|/\\*))|$))",
        name: "comment.block.preprocessor.if-branch.c",
        patterns: [{include: "#disabled"}, {include: "#pragma-mark"}]}]},
   :"preprocessor-rule-enabled-implementation" => 
    {begin: /^\s*(?<_1>#(?<_2>if)\s+(?<_3>0*1)\b)/,
     captures: 
      {1 => {name: "meta.preprocessor.c"},
       2 => {name: "keyword.control.import.if.c"},
       3 => {name: "constant.numeric.preprocessor.c"}},
     end: "^\\s*(#\\s*(endif)\\b.*?(?:(?=(?://|/\\*))|$))",
     patterns: 
      [{begin: /^\s*(?<_1>#\s*(?<_2>else)\b).*/,
        captures: 
         {1 => {name: "meta.preprocessor.c"},
          2 => {name: "keyword.control.import.else.c"}},
        contentName: "comment.block.preprocessor.else-branch.c",
        end: "(?=^\\s*#\\s*endif\\b.*?(?:(?=(?://|/\\*))|$))",
        patterns: [{include: "#disabled"}, {include: "#pragma-mark"}]},
       {begin: //,
        end: "(?=^\\s*#\\s*(else|endif)\\b.*?(?:(?=(?://|/\\*))|$))",
        patterns: [{include: "#implementation_innards"}]}]},
   :"preprocessor-rule-enabled-interface" => 
    {begin: /^\s*(?<_1>#(?<_2>if)\s+(?<_3>0*1)\b)/,
     captures: 
      {1 => {name: "meta.preprocessor.c"},
       2 => {name: "keyword.control.import.if.c"},
       3 => {name: "constant.numeric.preprocessor.c"}},
     end: "^\\s*(#\\s*(endif)\\b.*?(?:(?=(?://|/\\*))|$))",
     patterns: 
      [{begin: /^\s*(?<_1>#\s*(?<_2>else)\b).*/,
        captures: 
         {1 => {name: "meta.preprocessor.c"},
          2 => {name: "keyword.control.import.else.c"}},
        contentName: "comment.block.preprocessor.else-branch.c",
        end: "(?=^\\s*#\\s*endif\\b.*?(?:(?=(?://|/\\*))|$))",
        patterns: [{include: "#disabled"}, {include: "#pragma-mark"}]},
       {begin: //,
        end: "(?=^\\s*#\\s*(else|endif)\\b.*?(?:(?=(?://|/\\*))|$))",
        patterns: [{include: "#interface_innards"}]}]},
   :"preprocessor-rule-other-implementation" => 
    {begin: 
      /^\s*(?<_1>#\s*(?<_2>if(?<_3>n?def)?)\b.*?(?:(?=(?:\/\/|\/\*))|$))/,
     captures: 
      {1 => {name: "meta.preprocessor.c"},
       2 => {name: "keyword.control.import.c"}},
     end: "^\\s*(#\\s*(endif)\\b).*?(?:(?=(?://|/\\*))|$)",
     patterns: [{include: "#implementation_innards"}]},
   :"preprocessor-rule-other-interface" => 
    {begin: 
      /^\s*(?<_1>#\s*(?<_2>if(?<_3>n?def)?)\b.*?(?:(?=(?:\/\/|\/\*))|$))/,
     captures: 
      {1 => {name: "meta.preprocessor.c"},
       2 => {name: "keyword.control.import.c"}},
     end: "^\\s*(#\\s*(endif)\\b).*?(?:(?=(?://|/\\*))|$)",
     patterns: [{include: "#interface_innards"}]},
   properties: 
    {patterns: 
      [{begin: /(?<_1>(?<_2>@)property)\s*(?<_3>\()/,
        beginCaptures: 
         {1 => {name: "keyword.other.property.objc"},
          2 => {name: "punctuation.definition.keyword.objc"},
          3 => {name: "punctuation.section.scope.begin.objc"}},
        end: "(\\))",
        endCaptures: {1 => {name: "punctuation.section.scope.end.objc"}},
        name: "meta.property-with-attributes.objc",
        patterns: 
         [{match: 
            /\b(?<_1>getter|setter|readonly|readwrite|assign|retain|copy|nonatomic)\b/,
           name: "keyword.other.property.attribute"}]},
       {captures: 
         {1 => {name: "keyword.other.property.objc"},
          2 => {name: "punctuation.definition.keyword.objc"}},
        match: /(?<_1>(?<_2>@)property)\b/,
        name: "meta.property.objc"}]},
   property_directive: 
    {captures: {1 => {name: "punctuation.definition.keyword.objc"}},
     match: /(?<_1>@)(?<_2>dynamic|synthesize)\b/,
     name: "keyword.other.property.directive.objc"},
   protocol_list: 
    {begin: /(?<_1><)/,
     beginCaptures: {1 => {name: "punctuation.section.scope.begin.objc"}},
     end: "(>)",
     endCaptures: {1 => {name: "punctuation.section.scope.end.objc"}},
     name: "meta.protocol-list.objc",
     patterns: 
      [{match: 
         /\bNS(?<_1>GlyphStorage|M(?<_2>utableCopying|enuItem)|C(?<_3>hangeSpelling|o(?<_4>ding|pying|lorPicking(?<_5>Custom|Default)))|T(?<_6>oolbarItemValidations|ext(?<_7>Input|AttachmentCell))|I(?<_8>nputServ(?<_9>iceProvider|erMouseTracker)|gnoreMisspelledWords)|Obj(?<_10>CTypeSerializationCallBack|ect)|D(?<_11>ecimalNumberBehaviors|raggingInfo)|U(?<_12>serInterfaceValidations|RL(?<_13>HandleClient|DownloadDelegate|ProtocolClient|AuthenticationChallengeSender))|Validated(?<_14>ToobarItem|UserInterfaceItem)|Locking)\b/,
        name: "support.other.protocol.objc"}]},
   protocol_type_qualifier: 
    {match: /\b(?<_1>in|out|inout|oneway|bycopy|byref)\b/,
     name: "storage.modifier.protocol.objc"},
   special_variables: 
    {patterns: 
      [{match: /\b_cmd\b/, name: "variable.other.selector.objc"},
       {match: /\b(?<_1>self|super)\b/, name: "variable.language.objc"}]}},
 scopeName: "source.objc",
 uuid: "F85CC716-6B1C-11D9-9A20-000D93589AF6"}
