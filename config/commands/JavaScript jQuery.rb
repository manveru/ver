# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "ref=${TM_SELECTED_TEXT:-$TM_CURRENT_WORD}\nprefix=\n\ncase \"$ref\" in\n\njQuery|each|size|length|get|index)\n\tsection=Core\n\t;;\nextend|noConflict)\n\tprefix=jQuery.\n\tsection=Core\n\t;;\nattr|removeAttr|addClass|removeClass|toggleClass|html|text|val)\n\tsection=Attributes\n\t;;\neq|hasClass|filter|is|map|not|slice|add|children|contents|find|next|nextAll|parent|parents|prev|prevAll|siblings|andSelf|end)\n\tsection=Traversing\n\t;;\nappend|appendTo|prepend|prependTo|after|before|insertAfter|insertBefore|wrap|wrapAll|wrapInner|replaceWith|replaceAll|empty|remove|clone)\n\tsection=Manipulation\n\t;;\ncss|offset|height|width)\n\tsection=CSS\n\t;;\nready|bind|one|trigger|triggerHandler|unbind|hover|toggle|blur|change|click|dblclick|error|focus|keydown|keypress|keyup|load|mousedown|mousemove|mouseout|mouseover|mouseup|resize|scroll|select|submit|unload)\n\tsection=Events\n\t;;\nshow|hide|toggle|slideDown|slideUp|slideToggle|fadeIn|fadeOut|fadeTo|animate|stop|queue|dequeue)\n\tsection=Effects\n\t;;\nload|ajaxComplete|ajaxError|ajaxSend|ajaxStart|ajaxStop|ajaxSuccess|serialize|serializeArray)\n\tsection=Ajax\n\t;;\najax|get|getJSON|getScript|post|ajaxSetup)\n\tprefix=jQuery.\n\tsection=Ajax\n\t;;\ncss|offset|height|width)\n\tsection=Utilities\n\t;;\nesac\n\n[[ -n \"$section\" ]] && exit_show_html \"<meta http-equiv='Refresh' content='0;URL=http://docs.jquery.com/$section/$prefix$ref'>\"\n\necho \"No documentation found.\"",
  fallbackInput: "word",
  input: "selection",
  keyEquivalent: "^h",
  name: "Documentation for Word / Selection",
  output: "showAsTooltip",
  scope: "source.js.jquery support.function.js.jquery",
  uuid: "690646D5-AC38-4EB9-8C41-776E4F55CB59"}]
