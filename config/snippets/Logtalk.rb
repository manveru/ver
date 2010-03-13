# Encoding: UTF-8

[{content: 
   "\t:- private(${1:Functor}/0).\n\t:- mode(${1:Functor}, ${2:Solutions}).\n\t:- info(${1:Functor}/0, [\n\t\tcomment is '${3:Description}']).\n\n$0",
  name: "    (with no arguments)",
  scope: "source.logtalk",
  tabTrigger: "private0",
  uuid: "DBFDEDF5-7F59-11D9-BA7A-000A95DAA580"},
 {content: 
   "\t:- protected(${1:Functor}/0).\n\t:- mode(${1:Functor}, ${2:Solutions}).\n\t:- info(${1:Functor}/0, [\n\t\tcomment is '${3:Description}']).\n\n$0",
  name: "    (with no arguments)",
  scope: "source.logtalk",
  tabTrigger: "protected0",
  uuid: "4A25F29C-7F59-11D9-BA7A-000A95DAA580"},
 {content: 
   "\t:- public(${1:Functor}/0).\n\t:- mode(${1:Functor}, ${2:Solutions}).\n\t:- info(${1:Functor}/0, [\n\t\tcomment is '${3:Description}']).\n\n$0",
  name: "    (with no arguments)",
  scope: "source.logtalk",
  tabTrigger: "public0",
  uuid: "D96B0926-7F56-11D9-BA7A-000A95DAA580"},
 {content: 
   "\n:- category(${1:Category},\n\timplements(${2:Protocol})).\n\n\t:- info([\n\t\tversion is 1.0,\n\t\tauthor is '$TM_FULLNAME',\n\t\tdate is `date +%Y/%m/%d`,\n\t\tcomment is '${3:Description}']).\n\n$0\n\n:- end_category.\n",
  name: "    Category with protocol",
  scope: "source.logtalk",
  uuid: "8A263B8A-73F7-11D9-8083-000D93589AF6"},
 {content: 
   "\n:- object(${1:Class},\n\timplements(${2:Protocol}),\n\timports(${3:Category}),\n\tinstantiates(${4:Metaclass}),\n\tspecializes(${5:Superclass})).\n\n\t:- info([\n\t\tversion is 1.0,\n\t\tauthor is '$TM_FULLNAME',\n\t\tdate is `date +%Y/%m/%d`,\n\t\tcomment is '${6:Description}']).\n\n$0\n\n:- end_object.\n",
  name: "    Class with all",
  scope: "source.logtalk",
  uuid: "8A26A112-73F7-11D9-8083-000D93589AF6"},
 {content: 
   "\n:- object(${1:Class},\n\timports(${2:Category}),\n\tspecializes(${3:Superclass})).\n\n\t:- info([\n\t\tversion is 1.0,\n\t\tauthor is '$TM_FULLNAME',\n\t\tdate is `date +%Y/%m/%d`,\n\t\tcomment is '${4:Description}']).\n\n$0\n\n:- end_object.\n",
  name: "    Class with category",
  scope: "source.logtalk",
  uuid: "8A26CCD5-73F7-11D9-8083-000D93589AF6"},
 {content: 
   "\n:- object(${1:Class},\n\tinstantiates(${2:Metaclass}),\n\tspecializes(${3:Superclass})).\n\n\t:- info([\n\t\tversion is 1.0,\n\t\tauthor is '$TM_FULLNAME',\n\t\tdate is `date +%Y/%m/%d`,\n\t\tcomment is '${4:Description}']).\n\n$0\n\n:- end_object.\n",
  name: "    Class with metaclass",
  scope: "source.logtalk",
  uuid: "8A270068-73F7-11D9-8083-000D93589AF6"},
 {content: 
   "\n:- object(${1:Class},\n\timplements(${2:Protocol}),\n\tspecializes(${3:Superclass})).\n\n\t:- info([\n\t\tversion is 1.0,\n\t\tauthor is '$TM_FULLNAME',\n\t\tdate is `date +%Y/%m/%d`,\n\t\tcomment is '${4:Description}']).\n\n$0\n\n:- end_object.\n",
  name: "    Class with protocol",
  scope: "source.logtalk",
  uuid: "8A272A62-73F7-11D9-8083-000D93589AF6"},
 {content: 
   "\n:- protocol(${1:Extended},\n\textends(${2:Minimal})).\n\n\t:- info([\n\t\tversion is 1.0,\n\t\tauthor is '$TM_FULLNAME',\n\t\tdate is `date +%Y/%m/%d`,\n\t\tcomment is '${3:Description}']).\n\n$0\n\n:- end_protocol.\n",
  name: "    Extended protocol",
  scope: "source.logtalk",
  uuid: "8A277A4C-73F7-11D9-8083-000D93589AF6"},
 {content: 
   "\n:- object(${1:Instance},\n\timplements(${2:Protocol}),\n\timports(${3:Category}),\n\tinstantiates(${4:Class})).\n\n\t:- info([\n\t\tversion is 1.0,\n\t\tauthor is '$TM_FULLNAME',\n\t\tdate is `date +%Y/%m/%d`,\n\t\tcomment is '${5:Description}']).\n\n$0\n\n:- end_object.\n",
  name: "    Instance with all",
  scope: "source.logtalk",
  uuid: "8A27A016-73F7-11D9-8083-000D93589AF6"},
 {content: 
   "\n:- object(${1:Instance},\n\timports(${2:Category}),\n\tinstantiates(${3:Class})).\n\n\t:- info([\n\t\tversion is 1.0,\n\t\tauthor is '$TM_FULLNAME',\n\t\tdate is `date +%Y/%m/%d`,\n\t\tcomment is '${4:Description}']).\n\n$0\n\n:- end_object.\n",
  name: "    Instance with category",
  scope: "source.logtalk",
  uuid: "8A27C6D7-73F7-11D9-8083-000D93589AF6"},
 {content: 
   "\n:- object(${1:Instance},\n\timplements(${2:Protocol}),\n\tinstantiates(${3:Class})).\n\n\t:- info([\n\t\tversion is 1.0,\n\t\tauthor is '$TM_FULLNAME',\n\t\tdate is `date +%Y/%m/%d`,\n\t\tcomment is '${4:Description}']).\n\n$0\n\n:- end_object.\n",
  name: "    Instance with protocol",
  scope: "source.logtalk",
  uuid: "8A27EAEC-73F7-11D9-8083-000D93589AF6"},
 {content: 
   "\n:- object(${1:Prototype},\n\timplements(${2:Protocol}),\n\timports(${3:Category}),\n\textends(${4:Parent})).\n\n\t:- info([\n\t\tversion is 1.0,\n\t\tauthor is '$TM_FULLNAME',\n\t\tdate is `date +%Y/%m/%d`,\n\t\tcomment is '${5:Description}']).\n\n$0\n\n:- end_object.\n",
  name: "    Prototype with all",
  scope: "source.logtalk",
  uuid: "8A28E048-73F7-11D9-8083-000D93589AF6"},
 {content: 
   "\n:- object(${1:Prototype},\n\timports(${2:Category})).\n\n\t:- info([\n\t\tversion is 1.0,\n\t\tauthor is '$TM_FULLNAME',\n\t\tdate is `date +%Y/%m/%d`,\n\t\tcomment is '${3:Description}']).\n\n$0\n\n:- end_object.\n",
  name: "    Prototype with category",
  scope: "source.logtalk",
  uuid: "8A290A27-73F7-11D9-8083-000D93589AF6"},
 {content: 
   "\n:- object(${1:Prototype},\n\textends(${2:Parent})).\n\n\t:- info([\n\t\tversion is 1.0,\n\t\tauthor is '$TM_FULLNAME',\n\t\tdate is `date +%Y/%m/%d`,\n\t\tcomment is '${3:Description}']).\n\n$0\n\n:- end_object.\n",
  name: "    Prototype with parent",
  scope: "source.logtalk",
  uuid: "8A292E31-73F7-11D9-8083-000D93589AF6"},
 {content: 
   "\n:- object(${1:Prototype},\n\timplements(${2:Protocol})).\n\n\t:- info([\n\t\tversion is 1.0,\n\t\tauthor is '$TM_FULLNAME',\n\t\tdate is `date +%Y/%m/%d`,\n\t\tcomment is '${3:Description}']).\n\n$0\n\n:- end_object.\n",
  name: "    Prototype with protocol",
  scope: "source.logtalk",
  uuid: "8A29547D-73F7-11D9-8083-000D93589AF6"},
 {content: 
   "\n:- category(${1:Category}).\n\n\t:- info([\n\t\tversion is 1.0,\n\t\tauthor is '$TM_FULLNAME',\n\t\tdate is `date +%Y/%m/%d`,\n\t\tcomment is '${2:Description}']).\n\n$0\n\n:- end_category.\n",
  name: "Category",
  scope: "source.logtalk",
  tabTrigger: "category",
  uuid: "8A2679C6-73F7-11D9-8083-000D93589AF6"},
 {content: 
   "\n:- object(${1:Class},\n\tspecializes(${2:Superclass})).\n\n\t:- info([\n\t\tversion is 1.0,\n\t\tauthor is '$TM_FULLNAME',\n\t\tdate is `date +%Y/%m/%d`,\n\t\tcomment is '${3:Description}']).\n\n$0\n\n:- end_object.\n",
  name: "Class",
  scope: "source.logtalk",
  tabTrigger: "class",
  uuid: "8A275494-73F7-11D9-8083-000D93589AF6"},
 {content: 
   "\n:- object(${1:Instance},\n\tinstantiates(${2:Class})).\n\n\t:- info([\n\t\tversion is 1.0,\n\t\tauthor is '$TM_FULLNAME',\n\t\tdate is `date +%Y/%m/%d`,\n\t\tcomment is '${3:Description}']).\n\n$0\n\n:- end_object.\n",
  name: "Instance",
  scope: "source.logtalk",
  tabTrigger: "instance",
  uuid: "8A2814B5-73F7-11D9-8083-000D93589AF6"},
 {content: 
   "\t:- private(${1:Functor}/${2:Arity}).\n\t:- mode(${1:Functor}(${3:Arguments}), ${4:Solutions}).\n\t:- info(${1:Functor}/${2:Arity}, [\n\t\tcomment is '${5:Description}',\n\t\targuments is ['$6'-'$7']]).\n\n$0",
  name: "Private predicate",
  scope: "source.logtalk",
  tabTrigger: "private",
  uuid: "8A284660-73F7-11D9-8083-000D93589AF6"},
 {content: 
   "\t:- protected(${1:Functor}/${2:Arity}).\n\t:- mode(${1:Functor}(${3:Arguments}), ${4:Solutions}).\n\t:- info(${1:Functor}/${2:Arity}, [\n\t\tcomment is '${5:Description}',\n\t\targuments is ['$6'-'$7']]).\n\n$0",
  name: "Protected predicate",
  scope: "source.logtalk",
  tabTrigger: "protected",
  uuid: "8A286F7E-73F7-11D9-8083-000D93589AF6"},
 {content: 
   "\n:- protocol(${1:Protocol}).\n\n\t:- info([\n\t\tversion is 1.0,\n\t\tauthor is '$TM_FULLNAME',\n\t\tdate is `date +%Y/%m/%d`,\n\t\tcomment is '${2:Description}']).\n\n$0\n\n:- end_protocol.\n",
  name: "Protocol",
  scope: "source.logtalk",
  tabTrigger: "protocol",
  uuid: "8A28B0F6-73F7-11D9-8083-000D93589AF6"},
 {content: 
   "\n:- object(${1:Object}).\n\n\t:- info([\n\t\tversion is 1.0,\n\t\tauthor is '$TM_FULLNAME',\n\t\tdate is `date +%Y/%m/%d`,\n\t\tcomment is '${2:Description}']).\n\n$0\n\n:- end_object.\n",
  name: "Prototype",
  scope: "source.logtalk",
  tabTrigger: "object",
  uuid: "8A298BE0-73F7-11D9-8083-000D93589AF6"},
 {content: 
   "\t:- public(${1:Functor}/${2:Arity}).\n\t:- mode(${1:Functor}(${3:Arguments}), ${4:Solutions}).\n\t:- info(${1:Functor}/${2:Arity}, [\n\t\tcomment is '${5:Description}',\n\t\targuments is ['$6'-'$7']]).\n\n$0",
  name: "Public predicate",
  scope: "source.logtalk",
  tabTrigger: "public",
  uuid: "8A29B12E-73F7-11D9-8083-000D93589AF6"}]
