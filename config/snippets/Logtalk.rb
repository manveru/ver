# Encoding: UTF-8

{nil => 
  {scope: "source.logtalk",
   name: "    Prototype with protocol",
   content: 
    "\n:- object(${1:Prototype},\n\timplements(${2:Protocol})).\n\n\t:- info([\n\t\tversion is 1.0,\n\t\tauthor is '$TM_FULLNAME',\n\t\tdate is `date +%Y/%m/%d`,\n\t\tcomment is '${3:Description}']).\n\n$0\n\n:- end_object.\n"},
 "category" => 
  {scope: "source.logtalk",
   name: "Category",
   content: 
    "\n:- category(${1:Category}).\n\n\t:- info([\n\t\tversion is 1.0,\n\t\tauthor is '$TM_FULLNAME',\n\t\tdate is `date +%Y/%m/%d`,\n\t\tcomment is '${2:Description}']).\n\n$0\n\n:- end_category.\n"},
 "class" => 
  {scope: "source.logtalk",
   name: "Class",
   content: 
    "\n:- object(${1:Class},\n\tspecializes(${2:Superclass})).\n\n\t:- info([\n\t\tversion is 1.0,\n\t\tauthor is '$TM_FULLNAME',\n\t\tdate is `date +%Y/%m/%d`,\n\t\tcomment is '${3:Description}']).\n\n$0\n\n:- end_object.\n"},
 "instance" => 
  {scope: "source.logtalk",
   name: "Instance",
   content: 
    "\n:- object(${1:Instance},\n\tinstantiates(${2:Class})).\n\n\t:- info([\n\t\tversion is 1.0,\n\t\tauthor is '$TM_FULLNAME',\n\t\tdate is `date +%Y/%m/%d`,\n\t\tcomment is '${3:Description}']).\n\n$0\n\n:- end_object.\n"},
 "private0" => 
  {scope: "source.logtalk",
   name: "    (with no arguments)",
   content: 
    "\t:- private(${1:Functor}/0).\n\t:- mode(${1:Functor}, ${2:Solutions}).\n\t:- info(${1:Functor}/0, [\n\t\tcomment is '${3:Description}']).\n\n$0"},
 "private" => 
  {scope: "source.logtalk",
   name: "Private predicate",
   content: 
    "\t:- private(${1:Functor}/${2:Arity}).\n\t:- mode(${1:Functor}(${3:Arguments}), ${4:Solutions}).\n\t:- info(${1:Functor}/${2:Arity}, [\n\t\tcomment is '${5:Description}',\n\t\targuments is ['$6'-'$7']]).\n\n$0"},
 "protected0" => 
  {scope: "source.logtalk",
   name: "    (with no arguments)",
   content: 
    "\t:- protected(${1:Functor}/0).\n\t:- mode(${1:Functor}, ${2:Solutions}).\n\t:- info(${1:Functor}/0, [\n\t\tcomment is '${3:Description}']).\n\n$0"},
 "protected" => 
  {scope: "source.logtalk",
   name: "Protected predicate",
   content: 
    "\t:- protected(${1:Functor}/${2:Arity}).\n\t:- mode(${1:Functor}(${3:Arguments}), ${4:Solutions}).\n\t:- info(${1:Functor}/${2:Arity}, [\n\t\tcomment is '${5:Description}',\n\t\targuments is ['$6'-'$7']]).\n\n$0"},
 "protocol" => 
  {scope: "source.logtalk",
   name: "Protocol",
   content: 
    "\n:- protocol(${1:Protocol}).\n\n\t:- info([\n\t\tversion is 1.0,\n\t\tauthor is '$TM_FULLNAME',\n\t\tdate is `date +%Y/%m/%d`,\n\t\tcomment is '${2:Description}']).\n\n$0\n\n:- end_protocol.\n"},
 "object" => 
  {scope: "source.logtalk",
   name: "Prototype",
   content: 
    "\n:- object(${1:Object}).\n\n\t:- info([\n\t\tversion is 1.0,\n\t\tauthor is '$TM_FULLNAME',\n\t\tdate is `date +%Y/%m/%d`,\n\t\tcomment is '${2:Description}']).\n\n$0\n\n:- end_object.\n"},
 "public0" => 
  {scope: "source.logtalk",
   name: "    (with no arguments)",
   content: 
    "\t:- public(${1:Functor}/0).\n\t:- mode(${1:Functor}, ${2:Solutions}).\n\t:- info(${1:Functor}/0, [\n\t\tcomment is '${3:Description}']).\n\n$0"},
 "public" => 
  {scope: "source.logtalk",
   name: "Public predicate",
   content: 
    "\t:- public(${1:Functor}/${2:Arity}).\n\t:- mode(${1:Functor}(${3:Arguments}), ${4:Solutions}).\n\t:- info(${1:Functor}/${2:Arity}, [\n\t\tcomment is '${5:Description}',\n\t\targuments is ['$6'-'$7']]).\n\n$0"}}
