# Encoding: UTF-8

{"_acc" => 
  {scope: "source.js.objj",
   name: "_Accessors",
   content: 
    "- (${1:id})${2:thing}\n{\n\treturn _$2;\n}\n\n- (void)set${2/./\\u$0/}:($1)aValue\n{\n\t_$2 = aValue; \n}"},
 "acc" => 
  {scope: "source.js.objj",
   name: "Accessors",
   content: 
    "- (${1:id})${2:thing}\n{\n\treturn $2;\n}\n\n- (void)set${2/./\\u$0/}:($1)aValue\n{\n\t$2 = aValue; \n}"},
 "cla" => 
  {scope: "source.js.objj",
   name: "Class",
   content: 
    "@implementation ${1:class} : ${2:CPObject}\n{\n}\n\n- (id)init\n{\n\tif(self = [super init])\n\t{$0\n\t}\n\treturn self;\n}\n\n@end\n"}}
