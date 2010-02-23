# Encoding: UTF-8

[{content: "- (BOOL)${1:method};",
  name: "- (BOOL)decl;",
  scope: "(source.objc | source.objc++) & meta.scope.interface",
  tabTrigger: "b",
  uuid: "2E4E33DA-B8B9-11D9-AE51-000393A143CC"},
 {content: "- (BOOL)${1:method}\n{\n\treturn ${2:value};\n}\n",
  name: "- (BOOL)method",
  scope: 
   "(source.objc | source.objc++) & meta.scope.implementation.objc - meta.function-with-body",
  tabTrigger: "b",
  uuid: "13CE9D22-B8B9-11D9-AE51-000393A143CC"},
 {content: "- (IBAction)${1:method}:(id)sender;",
  name: "- (IBAction)decl;",
  scope: "(source.objc | source.objc++) & meta.scope.interface",
  tabTrigger: "iba",
  uuid: "1ED92307-AE72-4F11-82C8-9A2751690C90"},
 {content: "- (IBAction)${1:method}:(id)sender\n{\n\t$0\n}\n",
  name: "- (IBAction)method",
  scope: 
   "(source.objc | source.objc++) & meta.scope.implementation.objc - meta.function-with-body",
  tabTrigger: "iba",
  uuid: "92BB3BAE-B8B9-11D9-AE51-000393A143CC"},
 {content: "- (id)${1:method};",
  name: "- (id)decl;",
  scope: "(source.objc | source.objc++) & meta.scope.interface",
  tabTrigger: "id",
  uuid: "7BF73194-B8B9-11D9-AE51-000393A143CC"},
 {content: "- (id)${1:method}\n{\n\treturn ${2:object};\n}",
  name: "- (id)method",
  scope: 
   "(source.objc | source.objc++) & meta.scope.implementation.objc - meta.function-with-body",
  tabTrigger: "id",
  uuid: "64C7F64A-B8B9-11D9-AE51-000393A143CC"},
 {content: "- (int)${1:method};",
  name: "- (int)decl;",
  scope: "(source.objc | source.objc++) & meta.scope.interface",
  tabTrigger: "i",
  uuid: "CBCFDA9F-B8BA-11D9-AE51-000393A143CC"},
 {content: "- (int)${1:method}\n{\n\treturn ${2:value};\n}\n",
  name: "- (int)method",
  scope: 
   "(source.objc | source.objc++) & meta.scope.implementation.objc - meta.function-with-body",
  tabTrigger: "i",
  uuid: "B71DF251-B8BA-11D9-AE51-000393A143CC"},
 {content: "- (void)${1:method}${2::(id)sender};",
  name: "- (void)decl;",
  scope: "(source.objc | source.objc++) & meta.scope.interface",
  tabTrigger: "v",
  uuid: "9DAAFC70-B8BA-11D9-AE51-000393A143CC"},
 {content: "- (void)${1:method}${2::(id)sender}\n{\n\t$0\n}\n",
  name: "- (void)method",
  scope: 
   "(source.objc | source.objc++) & meta.scope.implementation.objc - meta.function-with-body",
  tabTrigger: "v",
  uuid: "91A55D91-B8BA-11D9-AE51-000393A143CC"},
 {content: "- (void)awakeFromNib\n{\n\t$0\n}\n",
  name: "- awakeFromNib",
  scope: 
   "(source.objc | source.objc++) & meta.scope.implementation.objc - meta.function-with-body",
  tabTrigger: "awa",
  uuid: "B9311E3C-B8B8-11D9-AE51-000393A143CC"},
 {content: 
   "- (void)dealloc\n{\n\t[${1:ivar} release];\n\t[super dealloc];\n}\n",
  name: "- dealloc",
  scope: 
   "(source.objc | source.objc++) & meta.scope.implementation.objc - meta.function-with-body",
  tabTrigger: "d",
  uuid: "41ABB337-B8B9-11D9-AE51-000393A143CC"},
 {content: 
   "- (id)init\n{\n\tif((self = [super init]))\n\t{\n\t\t$0\n\t}\n\treturn self;\n}\n",
  name: "- init",
  scope: 
   "(source.objc | source.objc++) & meta.scope.implementation.objc - meta.function-with-body",
  tabTrigger: "init",
  uuid: "C9CD762E-B8B9-11D9-AE51-000393A143CC"},
 {content: 
   "[NSObject cancelPreviousPerformRequestsWithTarget:${1:self} selector:@selector(${2:method}:) object:${3:nil}];",
  name: "Cancel Perform Selector",
  scope: "source.objc, source.objc++",
  tabTrigger: "can",
  uuid: "151935C2-B8C0-11D9-AE51-000393A143CC"},
 {content: 
   "NSArray${TM_C_POINTER: *}${1:array} = [NSArray arrayWithObjects:\n\t\t\t\t\t\t${2:object},$0\n\t\t\t\t\t\tnil];",
  name: "NSArray With Objects",
  scope: "source.objc, source.objc++",
  tabTrigger: "ar",
  uuid: "E7576EB4-B8BC-11D9-AE51-000393A143CC"},
 {content: 
   "NSDictionary${TM_C_POINTER: *}${1:dict} = [NSDictionary dictionaryWithObjectsAndKeys:\n\t${2:object}, ${3:key},$0\n\tnil];\n",
  name: "NSDictionary With Objects and Keys",
  scope: "source.objc, source.objc++",
  tabTrigger: "dd",
  uuid: "BBAF783A-B8BC-11D9-AE51-000393A143CC"},
 {content: 
   "NSEnumerator${TM_C_POINTER: *}${2:${1:string}Enum} = [${3:$1Array} objectEnumerator];\n${5:id} ${4:curr${1/(.)(.*)/\\U$1\\E$2/}};\n\nwhile (($4 = [$2 nextObject])) {\n    $0\n}",
  name: "NSEnumerator Loop",
  scope: "source.objc, source.objc++",
  tabTrigger: "enum",
  uuid: "71439280-B8C0-11D9-AE51-000393A143CC"},
 {content: 
   "NSFileManager${TM_C_POINTER: *}${1:fm} = [NSFileManager defaultManager];",
  name: "NSFileManager",
  scope: "source.objc, source.objc++",
  tabTrigger: "fm",
  uuid: "AE9280E5-B8BE-11D9-AE51-000393A143CC"},
 {content: 
   "[NSString stringWithFormat:@\"${1:%@}\"${1/([^%]|%%)*(%.)?.*/(?2:, :])/}$2${1/([^%]|%%)*(%.)?.*/(?2:])/}",
  name: "NSString With Format",
  scope: "source.objc, source.objc++",
  tabTrigger: "ff",
  uuid: "CE7E1A78-B8C2-11D9-9635-000393A143CC"},
 {content: 
   "NSWorkspace${TM_C_POINTER: *}${1:workspace} = [NSWorkspace sharedWorkspace];",
  name: "NSWorkspace",
  scope: "source.objc, source.objc++",
  tabTrigger: "ws",
  uuid: "4BBEB085-B8C3-11D9-9635-000393A143CC"},
 {content: "NS_DURING\n\t$0\nNS_HANDLER\nNS_ENDHANDLER",
  name: "NS_DURING block",
  scope: "source.objc, source.objc++",
  tabTrigger: "during",
  uuid: "5992DC58-B8C0-11D9-AE51-000393A143CC"},
 {content: 
   "[self performSelector:@selector(${1:method}:) withObject:${2:nil} afterDelay:${3:1.0}];",
  name: "Perform Selector",
  scope: "source.objc, source.objc++",
  tabTrigger: "perf",
  uuid: "5DAD4AE0-B8BF-11D9-AE51-000393A143CC"},
 {content: 
   "[[NSNotificationCenter defaultCenter] postNotificationName:$1 object:self];",
  name: "Post Notification",
  scope: "source.objc, source.objc++",
  tabTrigger: "post",
  uuid: "A6B9C556-B8BF-11D9-AE51-000393A143CC"},
 {content: "[[NSNotificationCenter defaultCenter] removeObserver:self];",
  name: "Remove Observer",
  scope: "source.objc, source.objc++",
  tabTrigger: "ro",
  uuid: "79F1D540-B8BF-11D9-AE51-000393A143CC"},
 {content: "[NSNumber numberWith${1:Int}:${2:value}]",
  name: "[NSNumber ...",
  scope: "source.objc, source.objc++",
  tabTrigger: "nn",
  uuid: "1AF2C047-B8BC-11D9-AE51-000393A143CC"},
 {content: "[${1:object} release];",
  name: "[object release];",
  scope: "source.objc, source.objc++",
  tabTrigger: "rr",
  uuid: "E5A7F24B-B8BB-11D9-AE51-000393A143CC"},
 {content: "objectAtIndex:${1:i}",
  name: "objectAtIndex",
  scope: "meta.bracketed.objc",
  tabTrigger: "oi",
  uuid: "D4527EEE-B8BF-11D9-AE51-000393A143CC"},
 {content: "objectEnumerator",
  name: "objectEnumerator",
  scope: "meta.bracketed.objc",
  tabTrigger: "oe",
  uuid: "EF2A1830-B8BF-11D9-AE51-000393A143CC"},
 {content: "objectForKey:",
  name: "objectForKey",
  scope: "meta.bracketed.objc",
  tabTrigger: "ok",
  uuid: "E0E7FB1D-B8BF-11D9-AE51-000393A143CC"},
 {content: "setObject:$1 forKey:",
  name: "setObject:forKey:",
  scope: "meta.bracketed.objc",
  tabTrigger: "so",
  uuid: "CDFEF4EC-81C4-44EC-B638-3B93803AA2B5"}]
