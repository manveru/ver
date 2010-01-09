# Encoding: UTF-8

{"$" => 
  {scope: "source.js.jquery",
   name: "$ (Select DOM Element)",
   content: 
    "\\$(${1/(.+)/(?1:':)/}${1:string/element/array/function/jQuery object/string, context}${1/(.+)/(?1:':)/})$0"},
 "this" => 
  {scope: "source.js.jquery", name: "$(this)", content: "\\$(this)$0"},
 "$.ajax" => 
  {scope: "source.js.jquery",
   name: "$.ajax",
   content: 
    "\\$.ajax({\n  url: \"${1:mydomain.com/url}\",\n  type: \"${2:POST}\",\n${3/(.+)/(?1:  dataType\\: \":)/}${3:xml/html/script/json}${3/(.+)/(?1:\",\n:)/}${4/(.+)/(?1:  data\\: $.param\\( $\\(\":)/}${4:Element or Expression}${4/(.+)/(?1:\"\\) \\),\n:)/}${5/(.+)/(?1:  complete\\: function\\(\\) {:)/}${5:\n    //called when complete}${5/(.+)/(?1:  },\n:)/}${6/(.+)/(?1:  success\\: function\\(\\) {:)/}${6:\n    //called when successful}${6/(.+)/(?1: },\n:)/}${7/(.+)/(?1:  error\\: function\\(\\) {:)/}${7:\n    //called when there is an error}${7/(.+)/(?1:  },\n:)/}});\n$0"},
 "$.ajaxError" => 
  {scope: "source.js.jquery",
   name: "$.ajaxError",
   content: 
    ".ajaxError(function(${1:request, settings}) {\n  ${2://stuff to do when an AJAX call returns an error};\n});\n$0"},
 "$.ajaxSend" => 
  {scope: "source.js.jquery",
   name: "$.ajaxSend",
   content: 
    ".ajaxSend(function(${1:request, settings}) {\n  ${2://stuff to do before an AJAX request is sent};\n});\n$0"},
 "$.ajaxSetup" => 
  {scope: "source.js.jquery",
   name: "$.ajaxSetup",
   content: 
    "\\$.ajaxSetup({\n  url: \"${1:mydomain.com/url}\",\n  type: \"${2:POST}\",\n${3/(.+)/(?1:  dataType\\: \":)/}${3:xml/html/script/json}${3/(.+)/(?1:\",\n:)/}${4/(.+)/(?1:  data\\: $.param\\( $\\(\":)/}${4:Element or Expression}${4/(.+)/(?1:\"\\) \\),\n:)/}${5/(.+)/(?1:  complete\\: function\\(\\) {:)/}${5:\n    //called when complete}${5/(.+)/(?1:  },\n:)/}${6/(.+)/(?1:  success\\: function\\(\\) {:)/}${6:\n    //called when successful}${6/(.+)/(?1: },\n:)/}${7/(.+)/(?1:  error\\: function\\(\\) {:)/}${7:\n    //called when there is an error}${7/(.+)/(?1:  },\n:)/}});\n$0"},
 "$.ajaxSuccess" => 
  {scope: "source.js.jquery",
   name: "$.ajaxSuccess",
   content: 
    ".ajaxSuccess(function() {\n\t${1:// executes whenever an AJAX request completes successfully}\n});$0"},
 "$.get" => 
  {scope: "source.js.jquery",
   name: "$.get",
   content: 
    "\\$.get('${1:/test/ajax-test.xml}'${2/(.+)/(?1:, function\\(xml\\){\n :)/}${2:alert( $(\"title\",xml).text() )//optional stuff to do after get}${2/(.+)/(?1:;\n}:)/});\n$0"},
 "$.getIfModified" => 
  {scope: "source.js.jquery",
   name: "$.getIfModified",
   content: 
    "\\$.getIfModified('${1:/test/test.cgi}'${3/(.+)/(?1:, function\\(data\\){\n :)/}${3:alert( $\"Data loaded: \" + data )//optional stuff to do after get}${3/(.+)/(?1:;\n}:)/});\n$0"},
 "$.getJSON" => 
  {scope: "source.js.jquery",
   name: "$.getJSON",
   content: 
    "\\$.getJSON('${1:/path/to/file.cgi}'${2/(.+)/(?1:,{\n :)/}${2:param1: \"value1\", param2: \"value2\"}${2/(.+)/(?1:}:)/}${3/(.+)/(?1:,\n function\\(json\\){\n    :)/}${3://stuff to do after event occurs};${3/(.+)/(?1:\n}:)/});\n$0"},
 "$.getScript" => 
  {scope: "source.js.jquery",
   name: "$.getScript",
   content: 
    "\\$.getScript('${1:somescript.js}'${3/(.+)/(?1:, function\\(\\){\n :)/}${3://optional stuff to do after getScript}${3/(.+)/(?1:;\n}:)/});\n$0"},
 "$.post" => 
  {scope: "source.js.jquery",
   name: "$.post",
   content: 
    "\\$.post('${1:/path/to/file.cgi}'${2/(.+)/(?1:,{\n :)/}${2:param1: \"value1\", param2: \"value2\"}${2/(.+)/(?1:}:)/}${3/(.+)/(?1:,\n function\\(\\){\n    :)/}${3://stuff to do *after* page is loaded};${3/(.+)/(?1:\n}:)/});\n$0\n\n"},
 "$.trim" => 
  {scope: "source.js.jquery",
   name: "$.trim",
   content: "\\$.trim('${1:string}')$0"},
 ":" => 
  {scope: "source.js.jquery meta.selector.jquery",
   name: ":visible",
   content: ":visible\n"},
 ".add" => 
  {scope: "source.js.jquery",
   name: "add",
   content: ".add('${1:selector expression}')$0"},
 ".addClass" => 
  {scope: "source.js.jquery",
   name: "addClass",
   content: ".addClass('${1:class name}')$0"},
 ".after" => 
  {scope: "source.js.jquery",
   name: "after",
   content: ".after('${1:Some text <b>and bold!</b>}')$0"},
 "$.ajaxStart" => 
  {scope: "source.js.jquery",
   name: "$.ajaxStart",
   content: 
    "\\$.ajaxStart(function() {\n  ${1://stuff to do when an AJAX call is started and no other AJAX calls are in progress};\n});\n$0"},
 "$.ajaxStop" => 
  {scope: "source.js.jquery",
   name: "$.ajaxStop",
   content: 
    "\\$.ajaxStop(function() {\n  ${1://stuff to do when all AJAX calls have completed};\n});\n$0"},
 ".animate" => 
  {scope: "source.js.jquery",
   name: "animate",
   content: ".animate({${1:param1: value1, param2: value2}}, ${2:speed})$0"},
 ".append" => 
  {scope: "source.js.jquery",
   name: "append",
   content: ".append('${1:Some text <b>and bold!</b>}')$0"},
 ".appendTo" => 
  {scope: "source.js.jquery",
   name: "appendTo",
   content: ".appendTo('${1:selector expression}')$0"},
 ".attr" => 
  {scope: "source.js.jquery",
   name: "attr",
   content: 
    ".attr('${1:attribute}'${2/(.+)/(?1:, :)/}${2/(^[0-9]+$)|.+/(?1::')/}${2:value}${2/(^[0-9]+$)|.+/(?1::')/})$0"},
 ".before" => 
  {scope: "source.js.jquery",
   name: "before",
   content: ".before('${1:Some text <b>and bold!</b>}')$0"},
 ".bind" => 
  {scope: "source.js.jquery",
   name: "bind",
   content: 
    ".bind('${1:event name}', function(${2:event}) {\n\t${0:// Act on the event}\n});"},
 ".blur" => 
  {scope: "source.js.jquery",
   name: "blur",
   content: ".blur(${1:function() {\n\t${0:// Act on the event}\n\\}});"},
 ".change" => 
  {scope: "source.js.jquery",
   name: "change",
   content: ".change(${1:function() {\n\t${0:// Act on the event}\n\\}});"},
 ".children" => 
  {scope: "source.js.jquery",
   name: "children",
   content: 
    ".children(${1/(.+)/(?1:':)/}${1:selector expression}${1/(.+)/(?1:':)/})$0"},
 ".click" => 
  {scope: "source.js.jquery",
   name: "click",
   content: ".click(${1:function() {\n\t${0:// Act on the event}\n\\}});"},
 "clone" => {scope: "source.js.jquery", name: "clone", content: ".clone()$0"},
 ".contains" => 
  {scope: "source.js.jquery",
   name: "contains",
   content: ".contains('${1:text to find}')$0"},
 ".css" => 
  {scope: "source.js.jquery",
   name: "css",
   content: ".css('${1:attribute}', '${2:value}')$0"},
 ".dblclick" => 
  {scope: "source.js.jquery",
   name: "dblclick",
   content: ".dblclick(${1:function() {\n\t${0:// Act on the event}\n\\}});"},
 ".each" => 
  {scope: "source.js.jquery",
   name: "each",
   content: 
    ".each(function(index) {\n\t${0:this.innerHTML = this + \" is the element, \" + index + \" is the position\";}\n});"},
 ".end" => {scope: "source.js.jquery", name: "end", content: ".end()$0"},
 ".error" => 
  {scope: "source.js.jquery",
   name: "error",
   content: ".error(${1:function() {\n\t${0:// Act on the event}\n\\}});"},
 ".fadeIn" => 
  {scope: "source.js.jquery",
   name: "fadeIn",
   content: 
    ".fadeIn(${1/(^[0-9]+$)|.+/(?1::')/}${1:slow/400/fast}${1/(^[0-9]+$)|.+/(?1::')/})$0"},
 ".fadeOut" => 
  {scope: "source.js.jquery",
   name: "fadeOut",
   content: 
    ".fadeOut(${1/(^[0-9]+$)|.+/(?1::')/}${1:slow/400/fast}${1/(^[0-9]+$)|.+/(?1::')/})$0"},
 ".fadeTo" => 
  {scope: "source.js.jquery",
   name: "fadeTo",
   content: 
    ".fadeTo(${1/(^[0-9]+$)|.+/(?1::')/}${1:slow/400/fast}${1/(^[0-9]+$)|.+/(?1::')/}, ${2:0.5})$0"},
 ".filter" => 
  {scope: "source.js.jquery",
   name: "filter",
   content: ".filter('${1:selector expression}')$0"},
 ".find" => 
  {scope: "source.js.jquery",
   name: "find",
   content: ".find('${1:selector expression}')$0"},
 ".focus" => 
  {scope: "source.js.jquery",
   name: "focus",
   content: ".focus(${1:function() {\n\t${0:// Act on the event}\n\\}});"},
 ".get" => 
  {scope: "source.js.jquery",
   name: "get",
   content: ".get(${1:element index})$0"},
 ".height" => 
  {scope: "source.js.jquery",
   name: "height",
   content: ".height(${1:integer})$0"},
 ".hide" => 
  {scope: "source.js.jquery",
   name: "hide",
   content: 
    ".hide(${1/(^[0-9]+$)|.+/(?1::')/}${1:slow/400/fast}${1/(^[0-9]+$)|.+/(?1::')/})$0"},
 ".hover" => 
  {scope: "source.js.jquery",
   name: "hover",
   content: 
    ".hover(function() {\n\t${1:// Stuff to do when the mouse enters the element;}\n}, function() {\n\t${2:// Stuff to do when the mouse leaves the element;}\n});$0"},
 ".html" => 
  {scope: "source.js.jquery",
   name: "html",
   content: 
    ".html(${1/(.+)/(?1:':)/}${1:Some text <b>and bold!</b>}${1/(.+)/(?1:':)/})$0"},
 ".insertAfter" => 
  {scope: "source.js.jquery",
   name: "insertAfter",
   content: ".insertAfter('${1:selector expression}')$0"},
 ".insertBefore" => 
  {scope: "source.js.jquery",
   name: "insertBefore",
   content: ".insertBefore('${1:selector expression}')$0"},
 ".is" => 
  {scope: "source.js.jquery",
   name: "is",
   content: ".is('${1:selector expression}')$0"},
 ".load" => 
  {scope: "source.js.jquery",
   name: "load",
   content: ".load(${1:function() {\n\t${0:// Act on the event}\n\\}});"},
 ".loadIfModified" => 
  {scope: "source.js.jquery",
   name: "loadIfModified",
   content: 
    ".loadIfModified('${1:/path/to/file.html}'${2/(.+)/(?1:,{\n :)/}${2:param1: \"value1\", param2: \"value2\"}${2/(.+)/(?1:}:)/}${3/(.+)/(?1:,\n function\\(\\){\n    :)/}${3:// Stuff to do after the page is loaded}${3/(.+)/(?1:\n}:)/});\n$0"},
 ".mousedown" => 
  {scope: "source.js.jquery",
   name: "mousedown",
   content: ".mousedown(${1:function() {\n\t${0:// Act on the event}\n\\}});"},
 ".mousemove" => 
  {scope: "source.js.jquery",
   name: "mousemove",
   content: ".mousemove(${1:function() {\n\t${0:// Act on the event}\n\\}});"},
 ".mouseout" => 
  {scope: "source.js.jquery",
   name: "mouseout",
   content: ".mouseout(${1:function() {\n\t${0:// Act on the event}\n\\}});"},
 ".mouseover" => 
  {scope: "source.js.jquery",
   name: "mouseover",
   content: ".mouseover(${1:function() {\n\t${0:// Act on the event}\n\\}});"},
 ".mouseup" => 
  {scope: "source.js.jquery",
   name: "mouseup",
   content: ".mouseup(${1:function() {\n\t${0:// Act on the event}\n\\}});"},
 ".next" => 
  {scope: "source.js.jquery",
   name: "next",
   content: 
    ".next(${1/(.+)/(?1:':)/}${1:selector expression}${1/(.+)/(?1:':)/})$0"},
 ".not" => 
  {scope: "source.js.jquery",
   name: "not",
   content: ".not('${1:selector expression}')$0"},
 ".one" => 
  {scope: "source.js.jquery",
   name: "one",
   content: 
    ".one('${1:event name}', function(${2:event}) {\n\t${0:// Act on the event once}\n});"},
 ".parent" => 
  {scope: "source.js.jquery",
   name: "parent",
   content: 
    ".parent(${1/(.+)/(?1:':)/}${1:selector expression}${1/(.+)/(?1:':)/})$0"},
 ".parents" => 
  {scope: "source.js.jquery",
   name: "parents",
   content: 
    ".parents(${1/(.+)/(?1:':)/}${1:selector expression}${1/(.+)/(?1:':)/})$0"},
 ".prepend" => 
  {scope: "source.js.jquery",
   name: "prepend",
   content: ".prepend('${1:Some text <b>and bold!</b>}')$0"},
 ".prependTo" => 
  {scope: "source.js.jquery",
   name: "prependTo",
   content: ".prependTo('${1:selector expression}')$0"},
 ".prev" => 
  {scope: "source.js.jquery",
   name: "prev",
   content: 
    ".prev(${1/(.+)/(?1:':)/}${1:selector expression}${1/(.+)/(?1:':)/})$0"},
 "ready" => 
  {scope: "source.js.jquery",
   name: "document ready",
   content: 
    "\\$(document).ready(function() {\n\t${0:// Stuff to do as soon as the DOM is ready;}\n});\n"},
 ".remove" => 
  {scope: "source.js.jquery", name: "remove", content: ".remove()$0"},
 ".removeAttr" => 
  {scope: "source.js.jquery",
   name: "removeAttr",
   content: ".removeAttr('${1:attribute name}')$0"},
 ".removeClass" => 
  {scope: "source.js.jquery",
   name: "removeClass",
   content: ".removeClass('${1:class name}')$0"},
 ".reset" => 
  {scope: "source.js.jquery",
   name: "reset",
   content: ".reset(${1:function() {\n\t${0:// Act on the event}\n\\}});"},
 ".resize" => 
  {scope: "source.js.jquery",
   name: "resize",
   content: ".resize(${1:function() {\n\t${0:// Act on the event}\n\\}});"},
 ".scroll" => 
  {scope: "source.js.jquery",
   name: "scroll",
   content: ".scroll(${1:function() {\n\t${0:// Act on the event}\n\\}});"},
 ".select" => 
  {scope: "source.js.jquery",
   name: "select",
   content: ".select(function() {\n\t${0:// Act on the event}\n});"},
 ".show" => 
  {scope: "source.js.jquery",
   name: "show",
   content: 
    ".show(${1/(^[0-9]+$)|.+/(?1::')/}${1:slow/400/fast}${1/(^[0-9]+$)|.+/(?1::')/})$0"},
 ".siblings" => 
  {scope: "source.js.jquery",
   name: "siblings",
   content: 
    ".siblings(${1/(.+)/(?1:':)/}${1:selector expression}${1/(.+)/(?1:':)/})$0"},
 ".size" => {scope: "source.js.jquery", name: "size", content: ".size()$0"},
 ".slideDown" => 
  {scope: "source.js.jquery",
   name: "slideDown",
   content: 
    ".slideDown(${1/(^[0-9]+$)|.+/(?1::')/}${1:slow/400/fast}${1/(^[0-9]+$)|.+/(?1::')/})$0"},
 ".slideToggle" => 
  {scope: "source.js.jquery",
   name: "slideToggle",
   content: 
    ".slideToggle(${1/(^[0-9]+$)|.+/(?1::')/}${1:slow/400/fast}${1/(^[0-9]+$)|.+/(?1::')/})$0"},
 ".slideUp" => 
  {scope: "source.js.jquery",
   name: "slideUp",
   content: 
    ".slideUp(${1/(^[0-9]+$)|.+/(?1::')/}${1:slow/400/fast}${1/(^[0-9]+$)|.+/(?1::')/})$0"},
 ".submit" => 
  {scope: "source.js.jquery",
   name: "submit",
   content: ".submit(${1:function() {\n\t${0:// Act on the event}\n\\}});"},
 ".text" => 
  {scope: "source.js.jquery",
   name: "text",
   content: ".text(${1:'some text'})$0"},
 ".toggle" => 
  {scope: "source.js.jquery",
   name: "toggle (event)",
   content: 
    ".toggle(function() {\n\t${1:// Stuff to do every *odd* time the element is clicked;}\n}, function() {\n\t${2:// Stuff to do every *even* time the element is clicked;}\n});\n$0"},
 ".toggleClass" => 
  {scope: "source.js.jquery",
   name: "toggleClass",
   content: ".toggleClass('${1:class name}')$0"},
 ".trigger" => 
  {scope: "source.js.jquery",
   name: "trigger",
   content: ".trigger('${1:event name}')$0"},
 ".unbind" => 
  {scope: "source.js.jquery",
   name: "unbind",
   content: ".unbind('${1:event name}')$0"},
 ".val" => 
  {scope: "source.js.jquery",
   name: "val",
   content: ".val(${1/(.+)/(?1:':)/}${1:text}${1/(.+)/(?1:':)/})$0"},
 ".width" => 
  {scope: "source.js.jquery",
   name: "width",
   content: ".width(${1:integer})$0"},
 ".wrap" => 
  {scope: "source.js.jquery",
   name: "wrap",
   content: ".wrap('${1:&lt;div class=\"extra-wrapper\"&gt;&lt;/div&gt;}')$0"}}
