# Encoding: UTF-8

{"rtebv" => 
  {scope: "source.groovy",
   name: "render(template:\"..\",bean:b,var:\"x\")",
   content: "render(template:\"${1:name}\",bean:${2:b}, var:\"${3:x}\")"},
 "g:>" => 
  {scope: "text.html.grails",
   name: "New short tag.. <g: />",
   content: "<g:${1:name} ${2:attr}=\"${3:value}\" />"},
 "msg" => 
  {scope: "source.groovy.embedded.html.grails",
   name: "g.message()",
   content: 
    "g.message(code:\"${1}\"${2:, args:${3}}${4:, default:\"${5}\"})$0"},
 "createlinkto" => 
  {scope: "text.html.grails",
   name: "<g:createLinkTo>",
   content: 
    "<g:createLinkTo ${1:dir=\"$2\" }${3:file=\"$4\" }${5:absolute=\"$6\" }${7:base=\"$8\" } />"},
 "each" => 
  {scope: "text.html.grails",
   name: "<g:each>",
   content: 
    "<g:each ${1:var=\"${2}\" }in=\"\\${$3}\">\n\t${0:$TM_SELECTED_TEXT}\n</g:each>"},
 "rv" => 
  {scope: "source.groovy",
   name: "render(view:\"..\")",
   content: "render(view:\"${1:name}\")"},
 "js" => 
  {scope: "text.html.grails",
   name: "<g:javascript>",
   content: "<g:javascript>\n\t${0:$TM_SELECTED_TEXT}\n</g:javascript>"},
 "select" => 
  {scope: "text.html.grails",
   name: "<g:select from=\"..\" >",
   content: 
    "<g:select name=\"${1:name}\" value=\"\\${${2:value}}\" from=\"\\${${3:[1,2,3]}}\" />"},
 "constraints" => 
  {scope: "source.groovy",
   name: "constraints",
   content: "static constraints = {\n\t$0\n}"},
 "form" => 
  {scope: "text.html.grails",
   name: "<g:form controller=\"..\" action=\"..\"> ",
   content: 
    "<g:form name=\"${1:name}\" controller=\"${2:controller}\" action=\"${3:action}\">\n\t${0:$TM_SELECTED_TEXT}\n</g:form>"},
 "bt" => 
  {scope: "source.groovy",
   name: "belongsTo",
   content: "static belongsTo = [${1:ClassName}]"},
 "rjson" => 
  {scope: "source.groovy",
   name: "render(contentType:\"text/json\") { ... } ",
   content: "render(contentType:\"text/json\", builder:\"json\") {\n\t$0\n}"},
 "while" => 
  {scope: "text.html.grails",
   name: "<g:while>",
   content: 
    "<g:while test=\"\\${$1}\">\n\t${0:$TM_SELECTED_TEXT}\n</g:while>\n"},
 "link" => 
  {scope: "text.html.grails",
   name: "<g:link>",
   content: 
    "<g:link ${1:action=\"$2\" }${3:controller=\"$4\" }${5:id=\"$6\" }${7:params=\"$8\" }${9:url=\"$10\" }${11:absolute=\"$12\" }${13:base=\"$14\" }>$15</g:link>"},
 "g:" => 
  {scope: "text.html.grails",
   name: "New tag.. <g: ></g:>",
   content: 
    "<g:${1:name} ${2:attr}=\"${3:value}\">${0:$TM_SELECTED_TEXT}</g:$1>"},
 "rt" => 
  {scope: "source.groovy",
   name: "render(text:\"..\")",
   content: "render(text:\"${1:value}\")"},
 "elseif" => 
  {scope: "text.html.grails",
   name: "<g:elseif>",
   content: 
    "<g:elseif test=\"\\${$1}\">\n\t${0:$TM_SELECTED_TEXT}\n</g:elseif>"},
 "input" => 
  {scope: "text.html.grails",
   name: "<g:field type=\"..\">",
   content: 
    "<g:field type=\"${1:type}\" name=\"${2:name}\" value=\"${3:someValue}\" />"},
 "rea" => 
  {scope: "source.groovy",
   name: "redirect(action:..)",
   content: "redirect(action:\"${1:name}\")"},
 "set" => 
  {scope: "text.html.grails",
   name: "<g:set>",
   content: 
    "<g:set ${1:var=\"$2\" }${3:value=\"$4\" }${5:scope=\"${6:request/page/flash/session}\" }/>"},
 "$" => 
  {scope: "text.html.grails",
   name: "${} (Embedded Source)",
   content: "\\${$0}"},
 "rtecb" => 
  {scope: "source.groovy",
   name: "render(template:\"..\",collection:c, var:\"x\")",
   content: 
    "render(template:\"${1:name}\",collection:${2:col}, var:\"${3:x}\")"},
 "cont" => 
  {scope: "source.groovy",
   name: "New Controller",
   content: "class ${1:Name}Controller {\n\tdef index = {\n\t\t $0\n\t}\n}"},
 "eav" => 
  {scope: "text.html.grails",
   name: "<g:each in=\"..\" var=\"i\">",
   content: 
    "<g:each in=\"\\${${1:item}}\" var=\"${2:i}\">\n\t${0:$TM_SELECTED_TEXT}\n</g:each>"},
 "rvm" => 
  {scope: "source.groovy",
   name: "render(view:\"..\", model:m)",
   content: "render(view:\"${1:name}\", model:[${2:name}:${3:obj}])"},
 "createlink" => 
  {scope: "text.html.grails",
   name: "<g:createLink>",
   content: 
    "<g:createLink ${1:action=\"$2\" }${3:controller=\"$4\" }${5:id=\"$6\" }${7:params=\"$8\" }${9:url=\"$10\" }${11:absolute=\"$12\" }${13:base=\"$14\" }>$15</g:createLink>"},
 "tag" => 
  {scope: "source.groovy",
   name: "New Tag",
   content: "def ${1:closureName} =  { attrs, body ->\n\t$0\n}"},
 "reca" => 
  {scope: "source.groovy",
   name: "redirect(controller:.., action:..)",
   content: "redirect(controller:\"${1:c}\",action:\"${2:a}\")"},
 "eavs" => 
  {scope: "text.html.grails",
   name: "<g:each in=\"..\" var=\"e\" status=\"i\">",
   content: 
    "<g:each in=\"\\${${1:item}}\" var=\"${2:e}\" status=\"${3:i}\">\n\t${0:$TM_SELECTED_TEXT}\n</g:each>"},
 "rteb" => 
  {scope: "source.groovy",
   name: "render(template:\"..\",bean:b)",
   content: "render(template:\"${1:name}\",bean:${2:b})"},
 "render" => 
  {scope: "text.html.grails",
   name: "<g:render>",
   content: 
    "<g:render ${1:template=\"$2\" }${3:bean=\"$4\" }${5:model=\"$6\" }${7:collection=\"$8\" }${9:var=\"$10\" }${11:plugin=\"$12\" }/>"},
 "taglib" => 
  {scope: "source.groovy",
   name: "New Tag Library",
   content: "class ${1:Name}TagLib {\n\t$0\n}"},
 "rtec" => 
  {scope: "source.groovy",
   name: "render(template:\"..\",collection:c)",
   content: "render(template:\"${1:name}\",collection:${1:col})"},
 "rte" => 
  {scope: "source.groovy",
   name: "render(template:\"..\")",
   content: "render(template:\"${1:name}\")"},
 "haserrors" => 
  {scope: "text.html.grails",
   name: "<g:hasErrors>",
   content: 
    "<g:hasErrors ${1:bean=\"$2\" }${3:model=\"$4\" }${5:field=\"$6\" }>\n\t$0\n</g:hasErrors>\n"},
 "if" => 
  {scope: "text.html.grails",
   name: "<g:if>",
   content: "<g:if test=\"\\${$1}\">\n\t${0:$TM_SELECTED_TEXT}\n</g:if>\n"},
 "jsl" => 
  {scope: "text.html.grails",
   name: "<g:javascript library=\"..\">",
   content: "<g:javascript library=\"${1:prototype}\" />"},
 "out" => 
  {scope: "text.html.grails",
   name: "out << \"\"",
   content: "out << \"${1:output}\""},
 "hm" => 
  {scope: "source.groovy",
   name: "hasMany",
   content: "static hasMany = [${1:items}:${2:ClassName}]"},
 "rec" => 
  {scope: "source.groovy",
   name: "redirect(controller:..)",
   content: "redirect(controller:\"${1:name}\")"},
 "rtc" => 
  {scope: "source.groovy",
   name: "render(text:\"..\", contentType:\"..\")",
   content: "render(text:\"${1:value}\", contentType:\"${2:text/xml}\")"},
 "recai" => 
  {scope: "source.groovy",
   name: "redirect(controller:.., action:.. , id:..)",
   content: "redirect(controller:\"${1:c}\",action:\"${2:a}\",id:${3:1})"},
 "rxml" => 
  {scope: "source.groovy",
   name: "render(contentType:\"text/xml\") { ... }",
   content: "render(contentType:\"text/xml\") {\n\t$0\n}"},
 "ea" => 
  {scope: "text.html.grails",
   name: "<g:each in=\"..\">",
   content: 
    "<g:each in=\"\\${${1:item}}\">\n\t${0:$TM_SELECTED_TEXT}\n</g:each>"},
 "else" => 
  {scope: "text.html.grails",
   name: "<g:else>",
   content: "<g:else>\n\t${0:$TM_SELECTED_TEXT}\n</g:else>"},
 "rtem" => 
  {scope: "source.groovy",
   name: "render(template:\"..\",model:m) ",
   content: "render(template:\"${1:name}\",model:[${2:name}:${3:obj}])"},
 "reai" => 
  {scope: "source.groovy",
   name: "redirect(action:.., id:...)",
   content: "redirect(action:\"${1:name}\",id:${2:1})"}}
