# Encoding: UTF-8

[{content: 
   "- (${1:id})${2:thing}\n{\n\treturn $2;\n}\n\n- (void)set${2/./\\u$0/}:($1)aValue\n{\n\t$2 = aValue; \n}",
  name: "Accessors",
  scope: "source.js.objj",
  tabTrigger: "acc",
  uuid: "AA41BEF8-5F81-4A5A-85DE-2E81A112778B"},
 {content: 
   "@implementation ${1:class} : ${2:CPObject}\n{\n}\n\n- (id)init\n{\n\tif(self = [super init])\n\t{$0\n\t}\n\treturn self;\n}\n\n@end\n",
  name: "Class",
  scope: "source.js.objj",
  tabTrigger: "cla",
  uuid: "96C39647-4346-4750-9F96-58070F24EDE6"},
 {content: 
   "- (${1:id})${2:thing}\n{\n\treturn _$2;\n}\n\n- (void)set${2/./\\u$0/}:($1)aValue\n{\n\t_$2 = aValue; \n}",
  name: "_Accessors",
  scope: "source.js.objj",
  tabTrigger: "_acc",
  uuid: "85B0746B-AE1C-47B3-8B9A-2B9A95F4C71E"}]
