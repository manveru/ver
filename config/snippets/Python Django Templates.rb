# Encoding: UTF-8

{nil => {scope: "text.html.django", name: "urlize", content: "|urlize"},
 "trans" => 
  {scope: "text.html.django",
   name: "trans",
   content: "{% trans \"${1:string to translate}\" %}"},
 "load" => {scope: "text.html.django", name: "load", content: "{% load $1 %}"},
 "debug" => {scope: "text.html.django", name: "debug", content: "{% debug %}"},
 "regroup" => 
  {scope: "text.html.django",
   name: "regroup",
   content: "{% regroup $1 by $2 as $3 %}"},
 "ssi" => 
  {scope: "text.html.django",
   name: "ssi",
   content: "{% ssi $1 ${2:parsed} %}"},
 "filter" => 
  {scope: "text.html.django",
   name: "filter",
   content: "{% filter $1 %}\n\t$2\n{% endfilter %}"},
 "now" => 
  {scope: "text.html.django", name: "now", content: "{% now \"$1\" %}"},
 "include" => 
  {scope: "text.html.django",
   name: "include",
   content: "{% include ${1:\"$2\"} %}"},
 "autoescape" => 
  {scope: "text.html.django",
   name: "autoescape",
   content: "{% autoescape ${1:off} %}\n\t$2\n{% endautoescape %}"},
 "ifchanged" => 
  {scope: "text.html.django",
   name: "ifchanged",
   content: "{% ifchanged %}$1{% endifchanged %}"},
 "blocktrans" => 
  {scope: "text.html.django",
   name: "blocktrans",
   content: 
    "{% blocktrans ${1:with ${2:var1} as ${3:var2}} %}\n\t$4{{ $3 }}\n{% endblocktrans %}"},
 "widthratio" => 
  {scope: "text.html.django",
   name: "widthratio",
   content: "{% widthratio ${1:this_value} ${2:max_value} ${3:100} %}"},
 "ifnotequal" => 
  {scope: "text.html.django",
   name: "ifnotequal",
   content: "{% ifnotequal $1 $2 %}\n\t$3\n{% endifnotequal %}"},
 "if" => 
  {scope: "text.html.django",
   name: "if",
   content: "{% if $1 %}\n\t$2\n{% endif %}"},
 "firstof" => 
  {scope: "text.html.django", name: "firstof", content: "{% firstof $1 %}"},
 "block" => 
  {scope: "text.html.django",
   name: "block",
   content: "{% block $1 %}\n\t$2\n{% endblock %}"},
 "for" => 
  {scope: "text.html.django",
   name: "for",
   content: "{% for $1 in $2 %}\n\t$3\n{% endfor %}"},
 "{{" => 
  {scope: "text.html.django",
   name: "templatetag: openvariable",
   content: "{% templatetag openvariable %}"},
 "{%" => 
  {scope: "text.html.django",
   name: "templatetag: openblock",
   content: "{% templatetag openblock %}"},
 "comment" => 
  {scope: "text.html.django",
   name: "comment",
   content: "{% comment %}\n\t$1\n{% endcomment %}"},
 "url" => 
  {scope: "text.html.django",
   name: "url",
   content: "{% url ${1:package.module.view_fn} ${2:value1,kwarg=value2} %}"},
 "}}" => 
  {scope: "text.html.django",
   name: "templatetag: closevariable",
   content: "{% templatetag closevariable %}"},
 "cycle" => 
  {scope: "text.html.django", name: "cycle", content: "{% cycle $1 as $2 %}"},
 "%}" => 
  {scope: "text.html.django",
   name: "templatetag: closeblock",
   content: "{% templatetag closeblock %}"},
 "extends" => 
  {scope: "text.html.django",
   name: "extends",
   content: "{% extends \"$1\" %}"},
 "ifequal" => 
  {scope: "text.html.django",
   name: "ifequal",
   content: "{% ifequal $1 $2 %}\n\t$3\n{% endifequal %}"}}
