# Encoding: UTF-8

{"ins" => 
  {scope: "source.js.prototype",
   name: "Insertion.Top",
   content: "new Insertion.Top(${1:element}, ${3:'${2:content}'});"},
 "all" => 
  {scope: "source.js.prototype",
   name: "Enum.all",
   content: "all(function(${1:value}) {\n\t$0\n});"},
 "class" => 
  {scope: "source.js.prototype",
   name: "Create Class Alt",
   content: 
    "var ${1:ClassName} = Class.create();\n${1:ClassName}.prototype = {\n  initialize : function(){\n    $0${10:${TM_SELECTED_TEXT:/*initialize*/}}\n  }${2:, /*Other methods?*/}\n};\n${4:${1:ClassName}.${3:instance} = new ${1:ClassName};\n}"},
 "each" => 
  {scope: "source.js.prototype",
   name: "Enum.each",
   content: "each(function(${1:value}) {\n\t$0\n});"},
 "reject" => 
  {scope: "source.js.prototype",
   name: "Enum.reject",
   content: "reject(function(${1:value}) {\n\t$0\n});"},
 "field" => 
  {scope: "source.js.prototype",
   name: "Field.select",
   content: "Field.select(${1:element};"},
 "evo" => 
  {scope: "source.js.prototype",
   name: "Event.observe",
   content: 
    "Event.observe(${2:element}, '${3:event name}', ${4:observer}${5:, ${6:useCapture}});"},
 "eff" => 
  {scope: "source.js.prototype",
   name: "Effect.Puff",
   content: "new Effect.Puff(${1:'${2:element}'}${3:, ${4:effect_options}});"},
 "pos" => 
  {scope: "source.js.prototype",
   name: "Position.within",
   content: "Position.within(${1:'${2:element}'}, ${3:x}, ${4:y});"},
 "bind" => 
  {scope: "source.js.prototype",
   name: "Function.bindAsEventListener",
   content: "bindAsEventListener(${1:this})"},
 "form" => 
  {scope: "source.js.prototype",
   name: "Form.disable",
   content: "Form.disable(${1:form});"},
 "ajax" => 
  {scope: "source.js.prototype",
   name: "Ajax.PeriodicalUpdater",
   content: 
    "new Ajax. PeriodicalUpdater(${1:'${2:element}'}, ${3:'${4:url}'}${5:, ${6:ajax_options}});"},
 "inj" => 
  {scope: "source.js.prototype",
   name: "Enum.inject",
   content: 
    "inject(${1:initial_value}, function(${2:accumulator}, ${3:value}) {\n\t$0\n\treturn $2;\n});"},
 "det" => 
  {scope: "source.js.prototype",
   name: "Enum.detect",
   content: "detect(function(${1:value}) {\n\t$0\n});"},
 "ext" => 
  {scope: "source.js.prototype",
   name: "Object.extend",
   content: "Object.extend(${1:destination}, ${2:source});"},
 "ajax_options" => 
  {scope: "source.js.prototype",
   name: "Ajax Options",
   content: 
    "{\n\t${1:onSuccess: function(${2:response}) {\n\t\t$3\n\t\\}}${5:,\n\tonFailure: function($2) {\n\t\t$6\n\t}}$0\n}"},
 "options" => 
  {scope: "source.js.prototype", name: "Options", content: "{\n\t$1\n}"},
 nil => 
  {scope: "source.js.prototype",
   name: "(function()...})",
   content: "(function(${1:value}) {\n\t${2:$1}$0\n});"},
 "inv" => 
  {scope: "source.js.prototype",
   name: "Enum.invoke",
   content: "invoke('${1:callback}');"},
 "effect_options" => 
  {scope: "source.js.prototype",
   name: "Effect Options",
   content: 
    "{\n\t${1:${2:duration}: ${3:1}}${5:,\n\tafterFinish: function() {\n\t\t$6\n\t\\}}$0\n}"},
 "eache" => 
  {scope: "source.js.prototype",
   name: "Enum.each (element)",
   content: "each(function(${1:element}) {\n\t$1 = \\$($1);\n\t$0\n});"},
 "coll" => 
  {scope: "source.js.prototype",
   name: "Enum.collect",
   content: "collect(function(${1:value}) {\n\t$0\n});"},
 "map" => 
  {scope: "source.js.prototype",
   name: "Enum.map",
   content: "map(function(${1:value}) {\n\t$0\n});"},
 "any" => 
  {scope: "source.js.prototype",
   name: "Enum.any",
   content: "any(function(${1:value}) {\n\t$0\n});"},
 "eachi" => 
  {scope: "source.js.prototype",
   name: "Enum.each (index)",
   content: "each(function(${1:value}, ${2:index}) {\n\t$0\n});"},
 "$" => {scope: "source.js.prototype", name: "$", content: "\\$(${2:'$1'})"}}
