# Encoding: UTF-8

[{content: "#import \"${1:${TM_FILENAME/\\...*$/.h/}}\"",
  name: "#import \"…\"",
  scope: "source.objc, source.objc++",
  tabTrigger: "imp",
  uuid: "1E3A92DA-7299-11D9-813A-000D93589AF6"},
 {content: "#import <${1:Cocoa/Cocoa.h}>",
  name: "#import <…>",
  scope: "source.objc, source.objc++",
  tabTrigger: "Imp",
  uuid: "20241464-7299-11D9-813A-000D93589AF6"},
 {content: "@selector(${1:method}:)",
  name: "@selector(…)",
  scope: "source.objc, source.objc++",
  tabTrigger: "sel",
  uuid: "7829F2EC-B8BA-11D9-AE51-000393A143CC"},
 {content: 
   "bind:@\"${2:binding}\" toObject:${3:observableController} withKeyPath:@\"${4:keyPath}\" options:${5:nil}",
  name: "Bind Property to Key Path of Object",
  scope: "source.objc, source.objc++",
  tabTrigger: "bind",
  uuid: "59FC2842-A645-11D9-B2CB-000D93589AF6"},
 {content: 
   "@interface ${1:${TM_FILENAME/.*?(\\w+).*|.*/(?1:$1:NSObject)/}} (${2:${TM_FILENAME/.*?\\w+\\W+(\\w+).*\\..+|.*/(?1:$1:Category)/}})\n@end\n\n@implementation $1 ($2)\n$0\n@end",
  name: "Category",
  scope: "source.objc, source.objc++",
  tabTrigger: "cat",
  uuid: "27AC6270-9900-11D9-9BB8-000A95A89C98"},
 {content: 
   "@implementation ${1:${TM_FILENAME/.*?(\\w+).*|.*/(?1:$1:NSObject)/}} (${2:${TM_FILENAME/.*?\\w+\\W+(\\w+).*\\..+|.*/(?1:$1:Category)/}})\n$0\n@end",
  name: "Category Implementation",
  scope: "source.objc, source.objc++",
  tabTrigger: "catm",
  uuid: "3E270C37-E7E2-4D1D-B28F-CEDD8DE0041C"},
 {content: 
   "@interface ${1:${TM_FILENAME/.*?(\\w+).*|.*/(?1:$1:NSObject)/}} (${2:${TM_FILENAME/.*?\\w+\\W+(\\w+).*\\..+|.*/(?1:$1:Category)/}})\n$0\n@end",
  name: "Category Interface",
  scope: "source.objc, source.objc++",
  tabTrigger: "cath",
  uuid: "596B13EC-9900-11D9-9BB8-000A95A89C98"},
 {content: 
   "@interface ${1:${TM_FILENAME/\\...*$|(^$)/(?1:object)/}} : ${2:NSObject}\n{\n}\n@end\n\n@implementation $1\n- (id)init\n{\n\tif((self = [super init]))\n\t{$0\n\t}\n\treturn self;\n}\n@end",
  name: "Class",
  scope: "source.objc, source.objc++ - meta.scope.implementation.objc",
  tabTrigger: "cl",
  uuid: "BC8B9C24-5F16-11D9-B9C3-000D93589AF6"},
 {content: 
   "@implementation ${1:${TM_FILENAME/\\...*$|(^$)/(?1:object)/}}\n- (id)init\n{\n\tif((self = [super init]))\n\t{$0\n\t}\n\treturn self;\n}\n@end",
  name: "Class Implementation",
  scope: "source.objc, source.objc++",
  tabTrigger: "clm",
  uuid: "BE0B2832-D88E-40BF-93EE-281DDA93840B"},
 {content: 
   "@interface ${1:${TM_FILENAME/\\...*$|(^$)/(?1:object)/}} : ${2:NSObject}\n{$3\n}\n$0\n@end",
  name: "Class Interface",
  scope: "source.objc, source.objc++",
  tabTrigger: "clh",
  uuid: "06F15373-9900-11D9-9BB8-000A95A89C98"},
 {content: 
   "+ (${1:id})${2:method}${3::(${4:id})${5:${4/(NS([AEIOQUY])?(\\w+).*)|(.)?.*/(?1:a(?2:n$2)$3:(?4:anArgument))/}}}\n{$0${1/^(void|IBAction)$|(.*)/(?2:\n\treturn nil;)/}\n}",
  name: "Class Method",
  scope: 
   "(source.objc | source.objc++) & meta.scope.implementation.objc - meta.function-with-body",
  tabTrigger: "M",
  uuid: "1251B9E2-6BF0-11D9-8384-000D93589AF6"},
 {content: 
   "- (${1:id})${2:attribute}\n{\n\t[self willAccessValueForKey:@\"${2: attribute}\"];\n\t${1:id} value = [self primitiveValueForKey:@\"${2: attribute}\"];\n\t[self didAccessValueForKey:@\"${2: attribute}\"];\n\treturn value;\n}\n\n- (void)set${2/./\\u$0/}:($1)aValue\n{\n\t[self willChangeValueForKey:@\"${2: attribute}\"];\n\t[self setPrimitiveValue:aValue forKey:@\"${2: attribute}\"];\n\t[self didChangeValueForKey:@\"${2: attribute}\"];\n}",
  name: "CoreData",
  scope: "source.objc, source.objc++",
  tabTrigger: "cdacc",
  uuid: "563B2FDB-A163-46FE-9380-4178EFC1AD14"},
 {content: 
   "if([${1:[self delegate]} respondsToSelector:@selector(${2:selfDidSomething:})])\n\t[$1 ${3:${2/((^\\s*([A-Za-z0-9_]*:)\\s*)|(:\\s*$)|(:\\s*))/(?2:$2self :\\:<>)(?4::)(?5: :)/g}}];\n",
  name: "Delegate Responds to Selector",
  scope: "source.objc, source.objc++",
  tabTrigger: "delegate",
  uuid: "622842E6-11F7-4D7B-A322-F1B8A1FE8CE5"},
 {content: 
   "[NSThread detachNewThreadSelector:@selector(${1:method}:) toTarget:${2:aTarget} withObject:${3:anArgument}]",
  name: "Detach New NSThread",
  scope: "source.objc, source.objc++",
  tabTrigger: "thread",
  uuid: "25AD69B4-905B-4EBC-A3B3-0BAB6D8BDD75"},
 {content: 
   "IBOutlet ${1:NSSomeClass}${TM_C_POINTER: *}${2:${1/^[A-Z](?:[A-Z]+|[a-z]+)([A-Z]\\w*)/\\l$1/}};",
  name: "IBOutlet",
  scope: "source.objc, source.objc++",
  tabTrigger: "ibo",
  uuid: "30C260A7-AFB1-11D9-9D48-000D93589AF6"},
 {content: 
   "- (void)addObjectTo${1:Things}:(${2:id})anObject;\n- (void)insertObject:($2)anObject in$1AtIndex:(unsigned int)i;\n- ($2)objectIn$1AtIndex:(unsigned int)i;\n- (unsigned int)indexOfObjectIn$1:($2)anObject;\n- (void)removeObjectFrom$1AtIndex:(unsigned int)i;\n- (unsigned int)countOf$1;\n- (NSArray${TM_C_POINTER/(^(.+?)\\s*$)?/(?1:$2: *)/})${1/./\\l$0/};\n- (void)set$1:(NSArray${TM_C_POINTER/(^(.+?)\\s*$)?/(?1:$2: *)/})new$1;",
  name: "Interface: Accessors for KVC Array",
  scope: 
   "source.objc meta.scope.interface, source.objc++ meta.scope.interface",
  tabTrigger: "arracc",
  uuid: "C125E6DB-7FB5-4B19-8648-0A5617B1B5BC"},
 {content: "- (${1:id})${2:thing};\n- (void)set${2/./\\u$0/}:($1)aValue;",
  name: "Interface: Accessors for Object",
  scope: 
   "source.objc meta.scope.interface, source.objc++ meta.scope.interface",
  tabTrigger: "objacc",
  uuid: "013BFEBB-A744-46F1-94A5-F851635E00FA"},
 {content: 
   "- (${1:unsigned int})${2:thing};\n- (void)set${2/./\\u$0/}:($1)new${2/./\\u$0/};",
  name: "Interface: Accessors for Primitive Type",
  scope: 
   "source.objc meta.scope.interface, source.objc++ meta.scope.interface",
  tabTrigger: "acc",
  uuid: "BA432891-294B-47A4-BECF-F3C95B3766C1"},
 {content: 
   "- (NSString${TM_C_POINTER/(^(.+?)\\s*$)?/(?1:$2: *)/})${1:thing};\n- (void)set${1/./\\u$0/}:(NSString${TM_C_POINTER/(^(.+?)\\s*$)?/(?1:$2: *)/})${2:a${1/.*/\\u$0/}};",
  name: "Interface: Accessors for String",
  scope: 
   "source.objc meta.scope.interface, source.objc++ meta.scope.interface",
  tabTrigger: "stracc",
  uuid: "35EB2F86-DEA0-443B-8DC2-4815F0478F67"},
 {content: "+ (${1:id})${0:method};",
  name: "Interface: Class Method",
  scope: 
   "source.objc meta.scope.interface, source.objc++ meta.scope.interface",
  tabTrigger: "M",
  uuid: "9D01148D-1073-40D2-936E-FFF67580D2B3"},
 {content: 
   "- (${1:id})${2:${TM_SELECTED_TEXT:method}}${3::(${4:id})${5:${4/(NS([AEIOQUY])?(\\w+).*)|(.)?.*/(?1:a(?2:n$2)$3:(?4:anArgument))/}}};",
  keyEquivalent: "^M",
  name: "Interface: Method",
  scope: 
   "source.objc meta.scope.interface, source.objc++ meta.scope.interface",
  tabTrigger: "m",
  uuid: "325B0A2B-5939-4805-80A1-6DED5B373283"},
 {content: 
   "- (void)addObjectTo${1:Things}:(${2:id})anObject\n{\n\t[${3:${1/./\\l$0/}} addObject:anObject];\n}\n\n- (void)insertObject:($2)anObject in$1AtIndex:(unsigned int)i \n{\n\t[$3 insertObject:anObject atIndex:i];\n}\n\n- ($2)objectIn$1AtIndex:(unsigned int)i\n{\n\treturn [$3 objectAtIndex:i];\n}\n\n- (unsigned int)indexOfObjectIn$1:($2)anObject\n{\n\treturn [$3 indexOfObject:anObject];\n}\n\n- (void)removeObjectFrom$1AtIndex:(unsigned int)i\n{\n\t[$3 removeObjectAtIndex:i];\n}\n\n- (unsigned int)countOf$1\n{\n\treturn [$3 count];\n}\n\n- (NSArray${TM_C_POINTER/(^(.+?)\\s*$)?/(?1:$2: *)/})${1/./\\l$0/}\n{\n\treturn $3;\n}\n\n- (void)set$1:(NSArray${TM_C_POINTER/(^(.+?)\\s*$)?/(?1:$2: *)/})new$1\n{\n\t[$3 setArray:new$1];\n}",
  name: "KVC Array",
  scope: 
   "(source.objc | source.objc++) & meta.scope.implementation.objc - meta.function-with-body",
  tabTrigger: "arracc",
  uuid: "DECC6BAC-94AF-429A-8609-D101C940D18D"},
 {content: "[self lockFocus];\n$0\n[self unlockFocus];",
  name: "Lock Focus",
  scope: "source.objc, source.objc++",
  tabTrigger: "focus",
  uuid: "3F57DB1B-9373-46A6-9B6E-19F2D25658DE"},
 {content: 
   "- (${1:id})${2:${TM_SELECTED_TEXT:method}}${3::(${4:id})${5:${4/(NS([AEIOQUY])?(\\w+).*)|(.)?.*/(?1:a(?2:n$2)$3:(?4:anArgument))/}}}\n{$0${1/^(void|IBAction)$|(.*)/(?2:\n\treturn nil;)/}\n}",
  keyEquivalent: "^M",
  name: "Method",
  scope: 
   "(source.objc | source.objc++) & meta.scope.implementation.objc - meta.function-with-body",
  tabTrigger: "m",
  uuid: "BC8B9DD7-5F16-11D9-B9C3-000D93589AF6"},
 {content: 
   "+ (void)initialize\n{\n\t[[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:\n\t\t$0@\"value\", @\"key\",\n\t\tnil]];\n}",
  name: "Method: Initialize",
  scope: 
   "(source.objc | source.objc++) & meta.scope.implementation.objc - meta.function-with-body",
  tabTrigger: "I",
  uuid: "366DBAB0-554B-4A38-966E-793DFE13A1EC"},
 {content: 
   "NSMutableArray${TM_C_POINTER: *}${1:array} = [NSMutableArray array];",
  name: "NSArray",
  scope: "source.objc, source.objc++",
  tabTrigger: "array",
  uuid: "BC8B9CAD-5F16-11D9-B9C3-000D93589AF6"},
 {content: 
   "unsigned int\t${1:object}Count = [${2:array} count];\n\nfor(unsigned int index = 0; index < ${1}Count; index += 1)\n{\n\t${3:id}\t${1} = [$2 objectAtIndex:index];\n\t$0\n}",
  name: "NSArray Loop",
  scope: "source.objc, source.objc++",
  tabTrigger: "forarray",
  uuid: "E0C97B6C-E546-4B73-9BEE-1207F6F920C3"},
 {content: 
   "NSAutoreleasePool${TM_C_POINTER: *}pool = [NSAutoreleasePool new];\n$0\n[pool drain];",
  name: "NSAutoreleasePool",
  scope: "source.objc, source.objc++",
  tabTrigger: "pool",
  uuid: "D402B10A-149B-414D-9961-110880389A8E"},
 {content: 
   "NSBezierPath${TM_C_POINTER: *}${1:path} = [NSBezierPath bezierPath];\n$0",
  name: "NSBezierPath",
  scope: "source.objc, source.objc++",
  tabTrigger: "bez",
  uuid: "917BA9ED-9A62-11D9-9A65-000A95A89C98"},
 {content: 
   "NSMutableDictionary${TM_C_POINTER: *}${1:dict} = [NSMutableDictionary dictionary];",
  name: "NSDictionary",
  scope: "source.objc, source.objc++",
  tabTrigger: "dict",
  uuid: "BC8B9D3A-5F16-11D9-B9C3-000D93589AF6"},
 {content: 
   "NSLog(@\"%s$1\", _cmd${1/[^%]*(%)?.*/(?1:, :\\);)/}$2${1/[^%]*(%)?.*/(?1:\\);)/}",
  name: "NSLog(.., _cmd)",
  scope: 
   "source.objc meta.scope.implementation, source.objc++ meta.scope.implementation",
  tabTrigger: "log",
  uuid: "A3555C49-D367-4CF5-8032-13B291820CD3"},
 {content: 
   "NSLog(@\"$1\"${1/[^%]*(%)?.*/(?1:, :\\);)/}$2${1/[^%]*(%)?.*/(?1:\\);)/}",
  name: "NSLog(…)",
  scope: "source.objc, source.objc++",
  tabTrigger: "log",
  uuid: "1251B7E8-6BF0-11D9-8384-000D93589AF6"},
 {content: 
   "int choice = NSRunAlertPanel(@\"${1:Something important!}\", @\"${2:Something important just happend, and now I need to ask you, do you want to continue?}\", @\"${3:Continue}\", @\"${4:Cancel}\", nil);\nif(choice == NSAlertDefaultReturn) // \"${3:Continue}\"\n{\n\t$0;\n}\nelse if(choice == NSAlertAlternateReturn) // \"${4:Cancel}\"\n{\n\t\n}",
  name: "NSRunAlertPanel",
  scope: "source.objc, source.objc++",
  tabTrigger: "alert",
  uuid: "9EF84198-BDAF-11D9-9140-000D93589AF6"},
 {content: "[NSString stringWithFormat:@\"$1\", $2]$0",
  name: "NSString With Format",
  scope: "source.objc, source.objc++",
  tabTrigger: "format",
  uuid: "B07879C7-F1E0-4606-93F1-1A948965CD0E"},
 {content: 
   "- (${1:id})${2:thing}\n{\n\treturn $2;\n}\n\n- (void)set${2/./\\u$0/}:($1)aValue\n{\n\t$0${1/( \\*)?$/(?1:$1: )/}old${2/./\\u$0/} = $2;\n\t$2 = [aValue retain];\n\t[old${2/./\\u$0/} release];\n}",
  name: "Object",
  scope: 
   "(source.objc | source.objc++) & meta.scope.implementation.objc - meta.function-with-body",
  tabTrigger: "objacc",
  uuid: "65844040-1D13-4F29-98CC-E742F151527F"},
 {content: 
   "- (${1:unsigned int})${2:thing}\n{\n\treturn ${3:$2};\n}\n\n- (void)set${2/./\\u$0/}:(${1:unsigned int})new${2/./\\u$0/}\n{\n\t$3 = new${2/./\\u$0/};\n}",
  name: "Primitive Type",
  scope: 
   "(source.objc | source.objc++) & meta.scope.implementation.objc - meta.function-with-body",
  tabTrigger: "acc",
  uuid: "DADC6C91-415F-463A-9C24-7A059BB5EE56"},
 {content: 
   "@property (${1/^(e)$|.*/(?1:r)/}${1:r}${1/^(?:(r)|(e)|(c)|(a))$|.*/(?1:etain)(?2:adonly)(?3:opy)(?4:ssign)/}) ${2:NSSomeClass}${TM_C_POINTER: *}${3:${2/^[A-Z](?:[A-Z]+|[a-z]+)([A-Z]\\w*)/\\l$1/}};",
  name: "Property (Objective-C 2.0)",
  scope: 
   "source.objc meta.scope.interface, source.objc++ meta.scope.interface",
  tabTrigger: "prop",
  uuid: "EE603767-8BA3-4F54-8DE5-0C9E64BE5DF7"},
 {content: "[[NSUserDefaults standardUserDefaults] objectForKey:${1:key}];",
  name: "Read Defaults Value",
  scope: "source.objc, source.objc++",
  tabTrigger: "getprefs",
  uuid: "3EF96A1F-B597-11D9-A114-000D93589AF6"},
 {content: 
   "[[NSNotificationCenter defaultCenter] addObserver:${1:self} selector:@selector(${3:${2/^([A-Z]{2})?(.+?)(Notification)?$/\\l$2/}}:) name:${2:NSWindowDidBecomeMainNotification} object:${4:nil}];",
  name: "Register for Notification",
  scope: 
   "source.objc meta.scope.implementation, source.objc++ meta.scope.implementation",
  tabTrigger: "obs",
  uuid: "E8107901-70F1-45D9-8633-81BD5E57CC89"},
 {content: 
   "${TM_COMMENT_START} ${4:Send $2 to $1, if $1 supports it}${TM_COMMENT_END}\nif ([${1:self} respondsToSelector:@selector(${2:someSelector:})])\n{\n    [$1 ${3:${2/((:\\s*$)|(:\\s*))/:<>(?3: )/g}}];\n}",
  name: "Responds to Selector",
  scope: "source.objc, source.objc++",
  tabTrigger: "responds",
  uuid: "171FBCAE-0D6F-4D42-B24F-871E3BB6DFF0"},
 {content: 
   "[NSGraphicsContext saveGraphicsState];\n$0\n[NSGraphicsContext restoreGraphicsState];\n",
  name: "Save and Restore Graphics Context",
  scope: "source.objc, source.objc++",
  tabTrigger: "gsave",
  uuid: "F2D5B215-2C10-40BC-B973-0A859A3E3CBD"},
 {content: 
   "- (NSString${TM_C_POINTER/(^(.+?)\\s*$)?/(?1:$2: *)/})${1:thing}\n{\n\treturn ${2:$1};\n}\n\n- (void)set${1/.*/\\u$0/}:(NSString${TM_C_POINTER/(^(.+?)\\s*$)?/(?1:$2: *)/})${3:a${1/.*/\\u$0/}}\n{\n\t$3 = [$3 copy];\n\t[$2 release];\n\t$2 = $3;\n}",
  name: "String",
  scope: 
   "(source.objc | source.objc++) & meta.scope.implementation.objc - meta.function-with-body",
  tabTrigger: "stracc",
  uuid: "5449EC50-98FE-11D9-9BB8-000A95A89C98"},
 {content: 
   "- (${1:id})${2:method}${3::(${4:id})${5:${4/(NS([AEIOQUY])?(\\w+).*)|(.)?.*/(?1:a(?2:n$2)$3:(?4:anArgument))/}}}\n{\n\t${1/^(void|IBAction)$|(.*)/(?2:$2 res = )/}[super ${2:method}${5/.+/:$0/}];$0${1/^(void|IBAction)$|(.*)/(?2:\n\treturn res;)/}\n}",
  name: "Sub-method (Call Super)",
  scope: 
   "(source.objc | source.objc++) & meta.scope.implementation.objc - meta.function-with-body",
  tabTrigger: "sm",
  uuid: "BC8B9E72-5F16-11D9-B9C3-000D93589AF6"},
 {content: "@synthesize ${1:property};",
  name: "Synthesize Property",
  scope: 
   "(source.objc | source.objc++) & meta.scope.implementation.objc - meta.function-with-body",
  tabTrigger: "syn",
  uuid: "C0B942C9-07CE-46B6-8FAE-CB8496F9F544"},
 {content: 
   "[[NSUserDefaults standardUserDefaults] setObject:${1:object} forKey:${2:key}];",
  name: "Write Defaults Value",
  scope: "source.objc, source.objc++",
  tabTrigger: "setprefs",
  uuid: "53672612-B597-11D9-A114-000D93589AF6"}]
