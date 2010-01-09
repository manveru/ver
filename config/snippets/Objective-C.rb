# Encoding: UTF-8

{"imp" => 
  {scope: "source.objc, source.objc++",
   name: "#import \"…\"",
   content: "#import \"${1:${TM_FILENAME/\\...*$/.h/}}\""},
 "Imp" => 
  {scope: "source.objc, source.objc++",
   name: "#import <…>",
   content: "#import <${1:Cocoa/Cocoa.h}>"},
 "cl" => 
  {scope: "source.objc, source.objc++ - meta.scope.implementation.objc",
   name: "Class",
   content: 
    "@interface ${1:${TM_FILENAME/\\...*$|(^$)/(?1:object)/}} : ${2:NSObject}\n{\n}\n@end\n\n@implementation $1\n- (id)init\n{\n\tif((self = [super init]))\n\t{$0\n\t}\n\treturn self;\n}\n@end"},
 "array" => 
  {scope: "source.objc, source.objc++",
   name: "NSArray",
   content: 
    "NSMutableArray${TM_C_POINTER: *}${1:array} = [NSMutableArray array];"},
 "dict" => 
  {scope: "source.objc, source.objc++",
   name: "NSDictionary",
   content: 
    "NSMutableDictionary${TM_C_POINTER: *}${1:dict} = [NSMutableDictionary dictionary];"},
 "m" => 
  {scope: 
    "source.objc meta.scope.interface, source.objc++ meta.scope.interface",
   name: "Interface: Method",
   content: 
    "- (${1:id})${2:${TM_SELECTED_TEXT:method}}${3::(${4:id})${5:${4/(NS([AEIOQUY])?(\\w+).*)|(.)?.*/(?1:a(?2:n$2)$3:(?4:anArgument))/}}};"},
 "sm" => 
  {scope: 
    "(source.objc | source.objc++) & meta.scope.implementation.objc - meta.function-with-body",
   name: "Sub-method (Call Super)",
   content: 
    "- (${1:id})${2:method}${3::(${4:id})${5:${4/(NS([AEIOQUY])?(\\w+).*)|(.)?.*/(?1:a(?2:n$2)$3:(?4:anArgument))/}}}\n{\n\t${1/^(void|IBAction)$|(.*)/(?2:$2 res = )/}[super ${2:method}${5/.+/:$0/}];$0${1/^(void|IBAction)$|(.*)/(?2:\n\treturn res;)/}\n}"},
 "forarray" => 
  {scope: "source.objc, source.objc++",
   name: "NSArray Loop",
   content: 
    "unsigned int\t${1:object}Count = [${2:array} count];\n\nfor(unsigned int index = 0; index < ${1}Count; index += 1)\n{\n\t${3:id}\t${1} = [$2 objectAtIndex:index];\n\t$0\n}"},
 "objacc" => 
  {scope: 
    "source.objc meta.scope.interface, source.objc++ meta.scope.interface",
   name: "Interface: Accessors for Object",
   content: "- (${1:id})${2:thing};\n- (void)set${2/./\\u$0/}:($1)aValue;"},
 "cat" => 
  {scope: "source.objc, source.objc++",
   name: "Category",
   content: 
    "@interface ${1:${TM_FILENAME/.*?(\\w+).*|.*/(?1:$1:NSObject)/}} (${2:${TM_FILENAME/.*?\\w+\\W+(\\w+).*\\..+|.*/(?1:$1:Category)/}})\n@end\n\n@implementation $1 ($2)\n$0\n@end"},
 "cath" => 
  {scope: "source.objc, source.objc++",
   name: "Category Interface",
   content: 
    "@interface ${1:${TM_FILENAME/.*?(\\w+).*|.*/(?1:$1:NSObject)/}} (${2:${TM_FILENAME/.*?\\w+\\W+(\\w+).*\\..+|.*/(?1:$1:Category)/}})\n$0\n@end"},
 "clh" => 
  {scope: "source.objc, source.objc++",
   name: "Class Interface",
   content: 
    "@interface ${1:${TM_FILENAME/\\...*$|(^$)/(?1:object)/}} : ${2:NSObject}\n{$3\n}\n$0\n@end"},
 "M" => 
  {scope: 
    "source.objc meta.scope.interface, source.objc++ meta.scope.interface",
   name: "Interface: Class Method",
   content: "+ (${1:id})${0:method};"},
 "cdacc" => 
  {scope: "source.objc, source.objc++",
   name: "CoreData",
   content: 
    "- (${1:id})${2:attribute}\n{\n\t[self willAccessValueForKey:@\"${2: attribute}\"];\n\t${1:id} value = [self primitiveValueForKey:@\"${2: attribute}\"];\n\t[self didAccessValueForKey:@\"${2: attribute}\"];\n\treturn value;\n}\n\n- (void)set${2/./\\u$0/}:($1)aValue\n{\n\t[self willChangeValueForKey:@\"${2: attribute}\"];\n\t[self setPrimitiveValue:aValue forKey:@\"${2: attribute}\"];\n\t[self didChangeValueForKey:@\"${2: attribute}\"];\n}"},
 "delegate" => 
  {scope: "source.objc, source.objc++",
   name: "Delegate Responds to Selector",
   content: 
    "if([${1:[self delegate]} respondsToSelector:@selector(${2:selfDidSomething:})])\n\t[$1 ${3:${2/((^\\s*([A-Za-z0-9_]*:)\\s*)|(:\\s*$)|(:\\s*))/(?2:$2self :\\:<>)(?4::)(?5: :)/g}}];\n"},
 "ibo" => 
  {scope: "source.objc, source.objc++",
   name: "IBOutlet",
   content: 
    "IBOutlet ${1:NSSomeClass}${TM_C_POINTER: *}${2:${1/^[A-Z](?:[A-Z]+|[a-z]+)([A-Z]\\w*)/\\l$1/}};"},
 "I" => 
  {scope: 
    "(source.objc | source.objc++) & meta.scope.implementation.objc - meta.function-with-body",
   name: "Method: Initialize",
   content: 
    "+ (void)initialize\n{\n\t[[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:\n\t\t$0@\"value\", @\"key\",\n\t\tnil]];\n}"},
 "bind" => 
  {scope: "source.objc, source.objc++",
   name: "Bind Property to Key Path of Object",
   content: 
    "bind:@\"${2:binding}\" toObject:${3:observableController} withKeyPath:@\"${4:keyPath}\" options:${5:nil}"},
 "arracc" => 
  {scope: 
    "source.objc meta.scope.interface, source.objc++ meta.scope.interface",
   name: "Interface: Accessors for KVC Array",
   content: 
    "- (void)addObjectTo${1:Things}:(${2:id})anObject;\n- (void)insertObject:($2)anObject in$1AtIndex:(unsigned int)i;\n- ($2)objectIn$1AtIndex:(unsigned int)i;\n- (unsigned int)indexOfObjectIn$1:($2)anObject;\n- (void)removeObjectFrom$1AtIndex:(unsigned int)i;\n- (unsigned int)countOf$1;\n- (NSArray${TM_C_POINTER/(^(.+?)\\s*$)?/(?1:$2: *)/})${1/./\\l$0/};\n- (void)set$1:(NSArray${TM_C_POINTER/(^(.+?)\\s*$)?/(?1:$2: *)/})new$1;"},
 "focus" => 
  {scope: "source.objc, source.objc++",
   name: "Lock Focus",
   content: "[self lockFocus];\n$0\n[self unlockFocus];"},
 "pool" => 
  {scope: "source.objc, source.objc++",
   name: "NSAutoreleasePool",
   content: 
    "NSAutoreleasePool${TM_C_POINTER: *}pool = [NSAutoreleasePool new];\n$0\n[pool drain];"},
 "bez" => 
  {scope: "source.objc, source.objc++",
   name: "NSBezierPath",
   content: 
    "NSBezierPath${TM_C_POINTER: *}${1:path} = [NSBezierPath bezierPath];\n$0"},
 "log" => 
  {scope: 
    "source.objc meta.scope.implementation, source.objc++ meta.scope.implementation",
   name: "NSLog(.., _cmd)",
   content: 
    "NSLog(@\"%s$1\", _cmd${1/[^%]*(%)?.*/(?1:, :\\);)/}$2${1/[^%]*(%)?.*/(?1:\\);)/}"},
 "alert" => 
  {scope: "source.objc, source.objc++",
   name: "NSRunAlertPanel",
   content: 
    "int choice = NSRunAlertPanel(@\"${1:Something important!}\", @\"${2:Something important just happend, and now I need to ask you, do you want to continue?}\", @\"${3:Continue}\", @\"${4:Cancel}\", nil);\nif(choice == NSAlertDefaultReturn) // \"${3:Continue}\"\n{\n\t$0;\n}\nelse if(choice == NSAlertAlternateReturn) // \"${4:Cancel}\"\n{\n\t\n}"},
 "format" => 
  {scope: "source.objc, source.objc++",
   name: "NSString With Format",
   content: "[NSString stringWithFormat:@\"$1\", $2]$0"},
 "getprefs" => 
  {scope: "source.objc, source.objc++",
   name: "Read Defaults Value",
   content: "[[NSUserDefaults standardUserDefaults] objectForKey:${1:key}];"},
 "responds" => 
  {scope: "source.objc, source.objc++",
   name: "Responds to Selector",
   content: 
    "${TM_COMMENT_START} ${4:Send $2 to $1, if $1 supports it}${TM_COMMENT_END}\nif ([${1:self} respondsToSelector:@selector(${2:someSelector:})])\n{\n    [$1 ${3:${2/((:\\s*$)|(:\\s*))/:<>(?3: )/g}}];\n}"},
 "gsave" => 
  {scope: "source.objc, source.objc++",
   name: "Save and Restore Graphics Context",
   content: 
    "[NSGraphicsContext saveGraphicsState];\n$0\n[NSGraphicsContext restoreGraphicsState];\n"},
 "acc" => 
  {scope: 
    "source.objc meta.scope.interface, source.objc++ meta.scope.interface",
   name: "Interface: Accessors for Primitive Type",
   content: 
    "- (${1:unsigned int})${2:thing};\n- (void)set${2/./\\u$0/}:($1)new${2/./\\u$0/};"},
 "stracc" => 
  {scope: 
    "source.objc meta.scope.interface, source.objc++ meta.scope.interface",
   name: "Interface: Accessors for String",
   content: 
    "- (NSString${TM_C_POINTER/(^(.+?)\\s*$)?/(?1:$2: *)/})${1:thing};\n- (void)set${1/./\\u$0/}:(NSString${TM_C_POINTER/(^(.+?)\\s*$)?/(?1:$2: *)/})${2:a${1/.*/\\u$0/}};"},
 "setprefs" => 
  {scope: "source.objc, source.objc++",
   name: "Write Defaults Value",
   content: 
    "[[NSUserDefaults standardUserDefaults] setObject:${1:object} forKey:${2:key}];"},
 "sel" => 
  {scope: "source.objc, source.objc++",
   name: "@selector(…)",
   content: "@selector(${1:method}:)"},
 "catm" => 
  {scope: "source.objc, source.objc++",
   name: "Category Implementation",
   content: 
    "@implementation ${1:${TM_FILENAME/.*?(\\w+).*|.*/(?1:$1:NSObject)/}} (${2:${TM_FILENAME/.*?\\w+\\W+(\\w+).*\\..+|.*/(?1:$1:Category)/}})\n$0\n@end"},
 "clm" => 
  {scope: "source.objc, source.objc++",
   name: "Class Implementation",
   content: 
    "@implementation ${1:${TM_FILENAME/\\...*$|(^$)/(?1:object)/}}\n- (id)init\n{\n\tif((self = [super init]))\n\t{$0\n\t}\n\treturn self;\n}\n@end"},
 "thread" => 
  {scope: "source.objc, source.objc++",
   name: "Detach New NSThread",
   content: 
    "[NSThread detachNewThreadSelector:@selector(${1:method}:) toTarget:${2:aTarget} withObject:${3:anArgument}]"},
 "prop" => 
  {scope: 
    "source.objc meta.scope.interface, source.objc++ meta.scope.interface",
   name: "Property (Objective-C 2.0)",
   content: 
    "@property (${1/^(e)$|.*/(?1:r)/}${1:r}${1/^(?:(r)|(e)|(c)|(a))$|.*/(?1:etain)(?2:adonly)(?3:opy)(?4:ssign)/}) ${2:NSSomeClass}${TM_C_POINTER: *}${3:${2/^[A-Z](?:[A-Z]+|[a-z]+)([A-Z]\\w*)/\\l$1/}};"},
 "obs" => 
  {scope: 
    "source.objc meta.scope.implementation, source.objc++ meta.scope.implementation",
   name: "Register for Notification",
   content: 
    "[[NSNotificationCenter defaultCenter] addObserver:${1:self} selector:@selector(${3:${2/^([A-Z]{2})?(.+?)(Notification)?$/\\l$2/}}:) name:${2:NSWindowDidBecomeMainNotification} object:${4:nil}];"},
 "syn" => 
  {scope: 
    "(source.objc | source.objc++) & meta.scope.implementation.objc - meta.function-with-body",
   name: "Synthesize Property",
   content: "@synthesize ${1:property};"}}
