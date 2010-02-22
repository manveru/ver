# Encoding: UTF-8

{fileTypes: [],
 foldingStartMarker: 
  /(?<_1><(?i:(?<_2>head|table|tr|div|style|script|ul|ol|form|dl))\b.*?>|{% (?<_3>block|comment|filter|for|if|ifchanged|ifequal|ifnotequal))/,
 foldingStopMarker: 
  /(?<_1><\/(?i:(?<_2>head|table|tr|div|style|script|ul|ol|form|dl))>|{% (?<_3>endblock|endblocktrans|endcomment|endfilter|endfor|endif|endifchanged|endifequal|endifnotequal) %})/,
 keyEquivalent: "^~D",
 name: "HTML (Django)",
 patterns: 
  [{comment: 
     "Since html is valid in Django templates include the html patterns",
    include: "text.html.basic"},
   {begin: /{% comment %}/,
    end: "{% endcomment %}",
    name: "comment.block.django.template"},
   {begin: /{#/, end: "#}", name: "comment.line.django.template"},
   {begin: /{{/, end: "}}", name: "variable.other.django.template"},
   {begin: /(?<_1>{%)/,
    captures: {1 => {name: "entity.other.django.tagbraces"}},
    end: "(%})",
    name: "meta.scope.django.template.tag",
    patterns: 
     [{match: 
        /\b(?<_1>autoescape|endautoescape|block|endblock|blocktrans|endblocktrans|plural|debug|extends|filter|firstof|for|endfor|if|include|else|endif|ifchanged|endifchanged|ifequal|endifequal|ifnotequal|endifnotequal|load|now|regroup|ssi|spaceless|templatetag|widthratio)\b/,
       name: "keyword.control.django.template"},
      {match: /\b(?<_1>and|or|not|in|by|as)\b/,
       name: "keyword.operator.django.template"},
      {match: 
        /\|(?<_1>add|addslashes|capfirst|center|cut|date|default|default_if_none|dictsort|dictsortreversed|divisibleby|escape|filesizeformat|first|fix_ampersands|floatformat|get_digit|join|length|length_is|linebreaks|linebreaksbr|linenumbers|ljust|lower|make_list|phone2numeric|pluralize|pprint|random|removetags|rjust|safe|slice|slugify|stringformat|striptags|time|timesince|title|truncatewords|unordered_list|upper|urlencode|urlize|urlizetrunc|wordcount|wordwrap|yesno)\b/,
       name: "support.function.filter.django"},
      {begin: /'|"/, end: "'|\"", name: "string.other.django.template.tag"},
      {match: /[a-zA-Z_]+/, name: "string.unquoted.django.template.tag"}]}],
 scopeName: "text.html.django",
 uuid: "F4B0A70C-ECF6-4660-BC26-785216E3CF02"}
