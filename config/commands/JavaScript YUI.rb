# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/php\n<?php\n\n$func = preg_replace('/[\\(\\) ;]/', '',  $_ENV['TM_CURRENT_WORD']);\n$scope = trim(preg_replace('/source\\.js\\.yui support\\.function\\.(.*?)\\.js\\.yui/', '$1', $_ENV['TM_SCOPE']));\n$anchor = '#' . $func;\n\nif(preg_match('|support\\.class\\.js\\.yui|', $scope)) {\n\t$scope = $func;\n\t$anchor = '';\n}\n\nswitch($scope) {\n\tcase 'YAHOO':\n\t\t$page = 'YAHOO.html'; break;\n\tcase 'YAHOO_config':\n\t\t$page = 'YAHOO_config.html'; break;\n\tcase 'lang':\n\t\t$page = 'YAHOO.lang.html'; break;\n\tcase 'DataSource':\n\tcase 'Column':\n\tcase 'ColumnEditor':\n\tcase 'ColumnSet':\n\tcase 'DataTable':\n\tcase 'Record':\n\tcase 'RecordSet':\n\tcase 'Sort':\n\tcase 'WidthResizer':\n\t\t$page = $scope . '.html'; break;\n\tcase 'Dom':\n\tcase 'Point':\n\tcase 'Region':\n\tcase 'Event':\n\tcase 'CustomEvent':\n\tcase 'EventProvider':\n\tcase 'Subscriber':\n\tcase 'Connect':\n\tcase 'Anim':\n\tcase 'AnimMgr':\n\tcase 'Bezier':\n\tcase 'ColorAnim':\n\tcase 'Easing':\n\tcase 'Motion':\n\tcase 'Scroll':\n\tcase 'DD':\n\tcase 'DDProxy':\n\tcase 'DDTarget':\n\tcase 'DragDrop':\n\tcase 'DragDropMgr':\n\tcase 'History':\n\tcase 'Config':\n\tcase 'KeyListener':\n\tcase 'Attribute':\n\tcase 'AttributeProvider':\n\tcase 'Element':\n\tcase 'Cookie':\n\tcase 'Get':\n\tcase 'ImageLoader':\n\tcase 'Resize':\n\tcase 'Selector':\n\tcase 'Storage':\n\tcase 'StorageEngineGears':\n\tcase 'StorageEngineHTML5':\n\tcase 'StorageEngineKeyed':\n\tcase 'StorageEngineSWF':\n\tcase 'StorageEvent':\n\tcase 'StorageManager':\n\tcase 'SWFStore':\n\tcase 'StyleSheet':\n\tcase 'YUILoader':\n\t\t$page = 'YAHOO.util.' . $scope . '.html'; break;\n\tcase 'AutoComplete':\n\tcase 'DS_JSArray':\n\tcase 'DS_JSFunction':\n\tcase 'DS_XHR':\n\tcase 'Calendar':\n\tcase 'Calendar2up':\n\tcase 'Calendar_Core':\n\tcase 'CalendarGroup':\n\tcase 'DateMath':\n\tcase 'Module':\n\tcase 'Overlay':\n\tcase 'OverlayManager':\n\tcase 'Tooltip':\n\tcase 'Panel':\n\tcase 'Dialog':\n\tcase 'SimpleDialog':\n\tcase 'ContainerEffect':\n\tcase 'Logger':\n\tcase 'LogMsg':\n\tcase 'LogReader':\n\tcase 'LogWriter':\n\tcase 'Menu':\n\tcase 'MenuItem':\n\tcase 'Menubar':\n\tcase 'MenuBarItem':\n\tcase 'MenuManager':\n\tcase 'MenuModule':\n\tcase 'MenuModuleItem':\n\tcase 'ContextMenu':\n\tcase 'ContextMenuItem':\n\tcase 'Slider':\n\tcase 'SliderThumb':\n\tcase 'Tab':\n\tcase 'TabView':\n\tcase 'Element':\n\tcase 'TreeView':\n\tcase 'Node':\n\tcase 'HTMLNode':\n\tcase 'MenuNode':\n\tcase 'TextNode':\n\tcase 'RootNode':\n\tcase 'TVAnim':\n\tcase 'TVFadeIn':\n\tcase 'TVFadeOut':\n\tcase 'Button':\n\tcase 'ButtonGroup':\n\tcase 'Column':\n\tcase 'ColumnEditor':\n\tcase 'ColumnSet':\n\tcase 'DataTable':\n\tcase 'Record':\n\tcase 'RecordSet':\n\tcase 'Sort':\n\tcase 'WidthResizer':\n\tcase 'SWF':\n\tcase 'DateCellEditor':\n\tcase 'DropdownCellEditor':\n\tcase 'RadioCellEditor':\n\tcase 'ScrollingDataTable':\n\tcase 'TextareaCellEditor':\n\tcase 'TextboxCellEditor':\n\t\t$page = 'YAHOO.widget.' . $scope . '.html'; break;\n\tdefault:\n\t\t$page = ''; $anchor = '';\n}\n\n$url = 'http://developer.yahoo.com/yui/docs/' . $page . $anchor;\necho '<meta http-equiv=\"Refresh\" content=\"0;URL' . $url . '\">';\n\n?>",
  fallbackInput: "word",
  input: "selection",
  keyEquivalent: "^h",
  name: "Documentation for Word / Selection",
  output: "showAsHTML",
  scope: "source.js.yui",
  uuid: "E43BD9CC-90BB-49A0-9644-15300E2A097F"}]