# Encoding: UTF-8

{"anim" => 
  {scope: "source.js.yui",
   name: "Scroll",
   content: 
    "new ${YUI_SCROLL:YAHOO.util.Scroll}(${1:element}${2:, ${3:scrollAttributes}, ${4:duration}, ${5:YAHOO.util.Easing.easeOut}}$0);"},
 "auto" => 
  {scope: "source.js.yui",
   name: "DS_XHR",
   content: "new YAHOO.widget.DS_XHR(${1:server}, ${2:schema});$0"},
 "but" => 
  {scope: "source.js.yui",
   name: "Button.set",
   content: "set(${1:attribute}, ${2:value});$0"},
 "cal" => 
  {scope: "source.js.yui", name: "Calendar.render", content: "render();"},
 "col" => 
  {scope: "source.js.yui",
   name: "ColumnSet",
   content: 
    "new ${YUI_COLUMNSET:YAHOO.widget.ColumnSet}(${1:columnHeaders});$0"},
 "conn" => 
  {scope: "source.js.yui",
   name: "Connect.setForm",
   content: "${YUI_CONNECT:YAHOO.util.Connect}.setForm('${1:form-id}');"},
 "async" => 
  {scope: "source.js.yui",
   name: "Connect.asyncRequest",
   content: 
    "${YUI_CONNECT:YAHOO.util.Connect}.asyncRequest('${1:POST}', '${2:URI}', ${3:{ success: ${4:successFunc}, failure: ${5:failureFunc} \\}}${6:, ${7:postData}});"},
 "con" => 
  {scope: "source.js.yui", name: "Overlay.center", content: "center();"},
 "context" => 
  {scope: "source.js.yui",
   name: "ContextMenu.addItem",
   content: 
    "addItem(${1:new YAHOO.widget.ContextMenuItem(${2:element}${3:, ${4:configs}})});$0"},
 "cookie" => 
  {scope: "source.js.yui",
   name: "Cookie.setSub",
   content: 
    "${YUI_COOKIE:YAHOO.util.Cookie}.setSub('${1:name}', '${2:subName}', ${3:value}${4:, { path: '${5:path}', domain: '${6:domain}', expires: ${7:dateObject}, secure: ${8:false} }});$0"},
 "event" => 
  {scope: "source.js.yui",
   name: "Event.stopPropagation",
   content: "${YUI_EVENT:YAHOO.util.Event}.stopPropagation(${1:e});"},
 "dd" => 
  {scope: "source.js.yui",
   name: "DDTarget",
   content: "new ${YUI_DDTARGET:YAHOO.util.DDTarget}(${1:element});"},
 "ds" => 
  {scope: "source.js.yui",
   name: "DataSource.responseType",
   content: 
    "responseType = ${YUI_DATASOURCE:YAHOO.util.DataSource}.${1:TYPE_JSON};$0"},
 "dt" => 
  {scope: "source.js.yui",
   name: "DataTable.getSelectedRows",
   content: "getSelectedRows();$0"},
 "newcon" => 
  {scope: "source.js.yui",
   name: "Tooltip",
   content: 
    "new ${YUI_TOOLTIP:YAHOO.widget.Tooltip}(${1:element}${2:, ${3:{ ${4:context: \"${5:myContextEl}\", }${6:text: \"${7:Tooltip text}\", }${8:showDelay: ${9:500} }\\}}});$0"},
 "dom" => 
  {scope: "source.js.yui",
   name: "Dom.setStyle",
   content: 
    "${YUI_DOM:YAHOO.util.Dom}.setStyle(${1:element}, '${2:property}', '${3:value}');$0"},
 "ease" => 
  {scope: "source.js.yui",
   name: "Ease.elasticOut",
   content: "${YUI_EASING:YAHOO.util.Easing}.elasticOut"},
 "el" => 
  {scope: "source.js.yui",
   name: "Element.setStyle",
   content: "setStyle(${1:element}, '${2:property}', '${3:value}');$0"},
 "add" => 
  {scope: "source.js.yui",
   name: "Event.addListener",
   content: 
    "${YUI_EVENT:YAHOO.util.Event}.addListener(${1:element}, '${2:event}', ${3:function}${4:, ${5:scopeObject}, ${6:true}});"},
 "on" => 
  {scope: "source.js.yui",
   name: "Event.on",
   content: 
    "${YUI_EVENT:YAHOO.util.Event}.on(${1:element}, '${2:event}', ${3:function}${4:, ${5:scopeObject}, ${6:true}});"},
 "stop" => 
  {scope: "source.js.yui",
   name: "Event.stopEvent",
   content: "${YUI_EVENT:YAHOO.util.Event}.stopEvent(${1:e});"},
 "get" => 
  {scope: "source.js.yui",
   name: "Dom.get",
   content: "${YUI_DOM:YAHOO.util.Dom}.get(${1:'elementId'})$0"},
 "hist" => 
  {scope: "source.js.yui",
   name: "History.register",
   content: 
    "${YUI_HISTORY:YAHOO.util.History}.register(${1:'moduleName'}, ${2:moduleInitialState}, ${3:moduleStateChangeHandler});$0"},
 "json" => 
  {scope: "source.js.yui",
   name: "JSON.stringify",
   content: 
    "${YUI_JSON:YAHOO.lang.JSON}.stringify(${1:obj}${2:, ${3:whitelist}, ${4:indentCharDepth}});$0"},
 "newlog" => 
  {scope: "source.js.yui",
   name: "LogWriter",
   content: 
    "new ${YUI_LOGWRITER:YAHOO.widget.LogWriter}(${1:sourceString});$0"},
 "logr" => 
  {scope: "source.js.yui", name: "LogReader.show", content: "show();"},
 "logger" => 
  {scope: "source.js.yui",
   name: "Logger.reset",
   content: "${YUI_LOGGER:YAHOO.widget.Logger}.reset(); "},
 "menu" => {scope: "source.js.yui", name: "Menu.show", content: "show();"},
 "menubar" => 
  {scope: "source.js.yui",
   name: "Menubar",
   content: 
    "new ${YUI_MENUBAR:YAHOO.widget.Menubar}(${1:element}${2:, ${3:configs}});$0"},
 "name" => 
  {scope: "source.js.yui",
   name: "Namespace Variables",
   content: 
    "// Add any variable that you changed in Namespace Preferences here:\n\nvar ${YUI_LANG} = YAHOO.lang;\nvar ${YUI_DOM} = YAHOO.util.Dom;\nvar ${YUI_EVENT} = YAHOO.util.Event;\nvar ${YUI_CONNECT} = YAHOO.util.Connect;\nvar ${YUI_ANIM} = YAHOO.util.Anim;"},
 "swf" => 
  {scope: "source.js.yui",
   name: "SWF",
   content: 
    "var ${1:swf} = new ${YUI_SWF:YAHOO.widget.SWF}('${2:containerId}', '${3:file.swf}', ${4:params});$0"},
 "sel" => 
  {scope: "source.js.yui",
   name: "Selector.test",
   content: 
    "${YUI_SELECTOR:YAHOO.util.Selector}.test(${1:nodes}, '${2:selector}');$0"},
 "slider" => 
  {scope: "source.js.yui",
   name: "Slider.subscribe",
   content: "subscribe(\"${1:eventName}\", ${2:func});$0"},
 "stor" => 
  {scope: "source.js.yui",
   name: "Storage.setItem",
   content: "${1:storageEngine}.setItem(${2:'key'}, ${3:data});$0"},
 "style" => 
  {scope: "source.js.yui",
   name: "StyleSheet.unset",
   content: "${1:sheet}.unset('${1:selector}', '${2:display}');$0"},
 "tab" => 
  {scope: "source.js.yui",
   name: "Tab.set",
   content: "set(\"${1:attrName}\", ${2:value});$0"},
 "tree" => 
  {scope: "source.js.yui",
   name: "TreeView.subscribe",
   content: "subscribe(\"${1:eventName}\", ${2:func});$0"},
 "lang" => 
  {scope: "source.js.yui",
   name: "YAHOO.lang.trim",
   content: "${YUI_LANG:YAHOO.lang}.trim(${1:string})"},
 "config" => 
  {scope: "source.js.yui",
   name: "YAHOO_config",
   content: "${YUI_CONFIG:YAHOO_config} = { listener: ${1:callbackFunc} };"},
 "env" => 
  {scope: "source.js.yui",
   name: "YAHOO.env.getVersion",
   content: "${YUI_ENV:YAHOO.env}.getVersion(${1:componentName})"},
 "hasown" => 
  {scope: "source.js.yui",
   name: "YAHOO.lang.hasOwnProperty",
   content: 
    "${YUI_LANG:YAHOO.lang}.hasOwnProperty(${1:object}, ${2:property})"},
 "log" => 
  {scope: "source.js.yui",
   name: "YAHOO.log",
   content: "${YUI_YAHOO:YAHOO}.log(${1:message});"},
 "Y" => 
  {scope: "source.js.yui",
   name: "YAHOO.namespace",
   content: "${YUI_YAHOO:YAHOO}.namespace('${1:namespace}');"},
 "loader" => 
  {scope: "source.js.yui",
   name: "YUILoader",
   content: 
    "var ${1:sheet} = ${YUI_STYLESHEET:YAHOO.util.StyleSheet}($0);\n\nvar ${1:loader} = new ${YUI_LOADER:YAHOO.util.YUILoader}({\n\trequire: [\"colorpicker\", \"treeview\"],\n\tloadOptional: true,\n\ttimeout: 10000,\n\tcombine: true,\n\n\tonSuccess: function() {\n\n\t}\n});\n\n"}}
