# Encoding: UTF-8

{nil => 
  {scope: 
    "source.python string.quoted.double.single-line meta.empty-string.double",
   name: "Inside String: Insert \"…\"",
   content: "\"$0\""},
 "def" => 
  {scope: "source.python",
   name: "New Function",
   content: 
    "def ${1:fname}(${2:`if [ \"$TM_CURRENT_LINE\" != \"\" ]\n\t\t\t\t# poor man's way ... check if there is an indent or not\n\t\t\t\t# (cuz we would have lost the class scope by this point)\n\t\t\t\tthen\n\t\t\t\t\techo \"self\"\n\t\t\t\tfi`}):\n\t${3/.+/\"\"\"/}${3:docstring for $1}${3/.+/\"\"\"\\n/}${3/.+/\\t/}${0:pass}"},
 "try" => 
  {scope: "source.python",
   name: "Try/Except/Finally",
   content: 
    "try:\n\t${1:pass}\nexcept ${2:Exception}, ${3:e}:\n\t${4:raise $3}\nfinally:\n\t${5:pass}"},
 "." => {scope: "source.python", name: "self", content: "self."},
 "defs" => 
  {scope: "source.python",
   name: "New Method",
   content: 
    "def ${1:mname}(self${2/([^,])?.*/(?1:, )/}${2:arg}):\n\t${3:pass}"},
 "ifmain" => 
  {scope: "source.python",
   name: "if __name__ == '__main__'",
   content: "if __name__ == '__main__':\n\t${1:main()}$0"},
 "property" => 
  {scope: "source.python",
   name: "New Property",
   content: 
    "def ${1:foo}():\n    doc = \"${2:The $1 property.}\"\n    def fget(self):\n        ${3:return self._$1}\n    def fset(self, value):\n        ${4:self._$1 = value}\n    def fdel(self):\n        ${5:del self._$1}\n    return locals()\n$1 = property(**$1())$0"},
 "class" => 
  {scope: "source.python",
   name: "New Class",
   content: 
    "class ${1:ClassName}(${2:object}):\n\t${3/.+/\"\"\"/}${3:docstring for $1}${3/.+/\"\"\"\\n/}${3/.+/\\t/}def __init__(self${4/([^,])?(.*)/(?1:, )/}${4:arg}):\n\t\t${5:super($1, self).__init__()}\n${4/(\\A\\s*,\\s*\\Z)|,?\\s*([A-Za-z_][a-zA-Z0-9_]*)\\s*(=[^,]*)?(,\\s*|$)/(?2:\\t\\tself.$2 = $2\\n)/g}\t\t$0"},
 "__" => {scope: "source.python", name: "__magic__", content: "__${1:init}__"}}
