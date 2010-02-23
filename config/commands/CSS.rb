# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  bundleUUID: "467B298F-6227-11D9-BFB1-000D93589AF6",
  command: 
   "#!/usr/bin/env ruby\nrequire \"\#{ENV['TM_SUPPORT_PATH']}/lib/codecompletion\"\npreference = 'Completions'\nchoices = []\n\nparsed_choices = TextmateCompletionsParser.new(nil, :scope => :css).to_ary\nchoices += parsed_choices if parsed_choices\n\nchoices += ['--']\n\nplist_choices = TextmateCompletionsPlist.new( \"\#{ENV['TM_BUNDLE_PATH']}/Preferences/\#{preference}.tmPreferences\" ).to_ary\nchoices += plist_choices if plist_choices\n\nprint TextmateCodeCompletion.new(choices,STDIN.read, :scope => :css).to_snippet\n",
  fallbackInput: "line",
  input: "selection",
  keyEquivalent: "~",
  name: "CodeCompletion CSS",
  output: "insertAsSnippet",
  scope: "source.css -meta.property-list",
  uuid: "E6FB4209-818E-40F5-9AFF-96E204F52A11"},
 {beforeRunningCommand: "nop",
  bundleUUID: "467B298F-6227-11D9-BFB1-000D93589AF6",
  command: 
   "#!/usr/bin/env ruby\nrequire \"\#{ENV['TM_SUPPORT_PATH']}/lib/codecompletion\"\nTextmateCodeCompletion.plist('Property Completions')\n",
  fallbackInput: "line",
  input: "selection",
  keyEquivalent: "~",
  name: "CodeCompletion CSS Properties",
  output: "insertAsSnippet",
  scope: 
   "source.css meta.property-list -meta.property-value, source.css meta.property-value punctuation.separator.key-value",
  uuid: "42E26C97-72AB-4953-807F-645AF7EDF59F"},
 {beforeRunningCommand: "nop",
  bundleUUID: "467B298F-6227-11D9-BFB1-000D93589AF6",
  command: 
   "#!/usr/bin/env ruby\nrequire \"\#{ENV['TM_SUPPORT_PATH']}/lib/codecompletion\"\npreference = 'Property Value Completions'\nchoices = []\n\nparsed_choices = TextmateCompletionsParser.new(nil, :scope => :css_values).to_ary\nchoices += parsed_choices if parsed_choices\n\nchoices += ['--']\n\nplist_choices = TextmateCompletionsPlist.new( \"\#{ENV['TM_BUNDLE_PATH']}/Preferences/\#{preference}.tmPreferences\" ).to_ary\nchoices += plist_choices if plist_choices\n\nprint TextmateCodeCompletion.new(choices,STDIN.read).to_snippet\n",
  fallbackInput: "line",
  input: "selection",
  keyEquivalent: "~",
  name: "CodeCompletion CSS Property Values",
  output: "insertAsSnippet",
  scope: "source.css meta.property-value",
  uuid: "35DFB6D6-E48B-4907-9030-019904DA0C5B"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\n#\n# Lookup current word as a CSS property on w3c.org\n#\n# The mapping below was generated using:\n# echo '$props = {'; curl -s http://www.w3.org/TR/CSS2/propidx.html|egrep \"(^|<tr><td>)<a href=\\\".*\\\" class=\\\"noxref\\\"><span class=\\\".*\\\">'.*'</span></a>\"|perl -pe \"s|(?:<tr><td>)?<a href=\\\"(.*)\\\" class=\\\"noxref\\\"><span class=\\\".*\\\">'(.*)'</span></a>|\\t\\\"\\$2\\\"\\t=> \\\"\\$1\\\",|\"; echo '}'\n\n$props = {\n\t\"azimuth\"\t=> \"aural.html#propdef-azimuth\",\n\t\"background\"\t=> \"colors.html#propdef-background\",\n\t\"background-attachment\"\t=> \"colors.html#propdef-background-attachment\",\n\t\"background-color\"\t=> \"colors.html#propdef-background-color\",\n\t\"background-image\"\t=> \"colors.html#propdef-background-image\",\n\t\"background-position\"\t=> \"colors.html#propdef-background-position\",\n\t\"background-repeat\"\t=> \"colors.html#propdef-background-repeat\",\n\t\"border\"\t=> \"box.html#propdef-border\",\n\t\"border-collapse\"\t=> \"tables.html#propdef-border-collapse\",\n\t\"border-color\"\t=> \"box.html#propdef-border-color\",\n\t\"border-spacing\"\t=> \"tables.html#propdef-border-spacing\",\n\t\"border-style\"\t=> \"box.html#propdef-border-style\",\n\t\"border-top\"\t=> \"box.html#propdef-border-top\",\n\t\"border-right\"\t=> \"box.html#propdef-border-right\",\n\t\"border-bottom\"\t=> \"box.html#propdef-border-bottom\",\n\t\"border-left\"\t=> \"box.html#propdef-border-left\",\n\t\"border-top-color\"\t=> \"box.html#propdef-border-top-color\",\n\t\"border-right-color\"\t=> \"box.html#propdef-border-right-color\",\n\t\"border-bottom-color\"\t=> \"box.html#propdef-border-bottom-color\",\n\t\"border-left-color\"\t=> \"box.html#propdef-border-left-color\",\n\t\"border-top-style\"\t=> \"box.html#propdef-border-top-style\",\n\t\"border-right-style\"\t=> \"box.html#propdef-border-right-style\",\n\t\"border-bottom-style\"\t=> \"box.html#propdef-border-bottom-style\",\n\t\"border-left-style\"\t=> \"box.html#propdef-border-left-style\",\n\t\"border-top-width\"\t=> \"box.html#propdef-border-top-width\",\n\t\"border-right-width\"\t=> \"box.html#propdef-border-right-width\",\n\t\"border-bottom-width\"\t=> \"box.html#propdef-border-bottom-width\",\n\t\"border-left-width\"\t=> \"box.html#propdef-border-left-width\",\n\t\"border-width\"\t=> \"box.html#propdef-border-width\",\n\t\"bottom\"\t=> \"visuren.html#propdef-bottom\",\n\t\"caption-side\"\t=> \"tables.html#propdef-caption-side\",\n\t\"clear\"\t=> \"visuren.html#propdef-clear\",\n\t\"clip\"\t=> \"visufx.html#propdef-clip\",\n\t\"color\"\t=> \"colors.html#propdef-color\",\n\t\"content\"\t=> \"generate.html#propdef-content\",\n\t\"counter-increment\"\t=> \"generate.html#propdef-counter-increment\",\n\t\"counter-reset\"\t=> \"generate.html#propdef-counter-reset\",\n\t\"cue\"\t=> \"aural.html#propdef-cue\",\n\t\"cue-after\"\t=> \"aural.html#propdef-cue-after\",\n\t\"cue-before\"\t=> \"aural.html#propdef-cue-before\",\n\t\"cursor\"\t=> \"ui.html#propdef-cursor\",\n\t\"direction\"\t=> \"visuren.html#propdef-direction\",\n\t\"display\"\t=> \"visuren.html#propdef-display\",\n\t\"elevation\"\t=> \"aural.html#propdef-elevation\",\n\t\"empty-cells\"\t=> \"tables.html#propdef-empty-cells\",\n\t\"float\"\t=> \"visuren.html#propdef-float\",\n\t\"font\"\t=> \"fonts.html#propdef-font\",\n\t\"font-family\"\t=> \"fonts.html#propdef-font-family\",\n\t\"font-size\"\t=> \"fonts.html#propdef-font-size\",\n\t\"font-size-adjust\"\t=> \"fonts.html#propdef-font-size-adjust\",\n\t\"font-stretch\"\t=> \"fonts.html#propdef-font-stretch\",\n\t\"font-style\"\t=> \"fonts.html#propdef-font-style\",\n\t\"font-variant\"\t=> \"fonts.html#propdef-font-variant\",\n\t\"font-weight\"\t=> \"fonts.html#propdef-font-weight\",\n\t\"height\"\t=> \"visudet.html#propdef-height\",\n\t\"left\"\t=> \"visuren.html#propdef-left\",\n\t\"letter-spacing\"\t=> \"text.html#propdef-letter-spacing\",\n\t\"line-height\"\t=> \"visudet.html#propdef-line-height\",\n\t\"list-style\"\t=> \"generate.html#propdef-list-style\",\n\t\"list-style-image\"\t=> \"generate.html#propdef-list-style-image\",\n\t\"list-style-position\"\t=> \"generate.html#propdef-list-style-position\",\n\t\"list-style-type\"\t=> \"generate.html#propdef-list-style-type\",\n\t\"margin\"\t=> \"box.html#propdef-margin\",\n\t\"margin-top\"\t=> \"box.html#propdef-margin-top\",\n\t\"margin-right\"\t=> \"box.html#propdef-margin-right\",\n\t\"margin-bottom\"\t=> \"box.html#propdef-margin-bottom\",\n\t\"margin-left\"\t=> \"box.html#propdef-margin-left\",\n\t\"marker-offset\"\t=> \"generate.html#propdef-marker-offset\",\n\t\"marks\"\t=> \"page.html#propdef-marks\",\n\t\"max-height\"\t=> \"visudet.html#propdef-max-height\",\n\t\"max-width\"\t=> \"visudet.html#propdef-max-width\",\n\t\"min-height\"\t=> \"visudet.html#propdef-min-height\",\n\t\"min-width\"\t=> \"visudet.html#propdef-min-width\",\n\t\"orphans\"\t=> \"page.html#propdef-orphans\",\n\t\"outline\"\t=> \"ui.html#propdef-outline\",\n\t\"outline-color\"\t=> \"ui.html#propdef-outline-color\",\n\t\"outline-style\"\t=> \"ui.html#propdef-outline-style\",\n\t\"outline-width\"\t=> \"ui.html#propdef-outline-width\",\n\t\"overflow\"\t=> \"visufx.html#propdef-overflow\",\n\t\"padding\"\t=> \"box.html#propdef-padding\",\n\t\"padding-top\"\t=> \"box.html#propdef-padding-top\",\n\t\"padding-right\"\t=> \"box.html#propdef-padding-right\",\n\t\"padding-bottom\"\t=> \"box.html#propdef-padding-bottom\",\n\t\"padding-left\"\t=> \"box.html#propdef-padding-left\",\n\t\"page\"\t=> \"page.html#propdef-page\",\n\t\"page-break-after\"\t=> \"page.html#propdef-page-break-after\",\n\t\"page-break-before\"\t=> \"page.html#propdef-page-break-before\",\n\t\"page-break-inside\"\t=> \"page.html#propdef-page-break-inside\",\n\t\"pause\"\t=> \"aural.html#propdef-pause\",\n\t\"pause-after\"\t=> \"aural.html#propdef-pause-after\",\n\t\"pause-before\"\t=> \"aural.html#propdef-pause-before\",\n\t\"pitch\"\t=> \"aural.html#propdef-pitch\",\n\t\"pitch-range\"\t=> \"aural.html#propdef-pitch-range\",\n\t\"play-during\"\t=> \"aural.html#propdef-play-during\",\n\t\"position\"\t=> \"visuren.html#propdef-position\",\n\t\"quotes\"\t=> \"generate.html#propdef-quotes\",\n\t\"richness\"\t=> \"aural.html#propdef-richness\",\n\t\"right\"\t=> \"visuren.html#propdef-right\",\n\t\"size\"\t=> \"page.html#propdef-size\",\n\t\"speak\"\t=> \"aural.html#propdef-speak\",\n\t\"speak-header\"\t=> \"tables.html#propdef-speak-header\",\n\t\"speak-numeral\"\t=> \"aural.html#propdef-speak-numeral\",\n\t\"speak-punctuation\"\t=> \"aural.html#propdef-speak-punctuation\",\n\t\"speech-rate\"\t=> \"aural.html#propdef-speech-rate\",\n\t\"stress\"\t=> \"aural.html#propdef-stress\",\n\t\"table-layout\"\t=> \"tables.html#propdef-table-layout\",\n\t\"text-align\"\t=> \"text.html#propdef-text-align\",\n\t\"text-decoration\"\t=> \"text.html#propdef-text-decoration\",\n\t\"text-indent\"\t=> \"text.html#propdef-text-indent\",\n\t\"text-shadow\"\t=> \"text.html#propdef-text-shadow\",\n\t\"text-transform\"\t=> \"text.html#propdef-text-transform\",\n\t\"top\"\t=> \"visuren.html#propdef-top\",\n\t\"unicode-bidi\"\t=> \"visuren.html#propdef-unicode-bidi\",\n\t\"vertical-align\"\t=> \"visudet.html#propdef-vertical-align\",\n\t\"visibility\"\t=> \"visufx.html#propdef-visibility\",\n\t\"voice-family\"\t=> \"aural.html#propdef-voice-family\",\n\t\"volume\"\t=> \"aural.html#propdef-volume\",\n\t\"white-space\"\t=> \"text.html#propdef-white-space\",\n\t\"widows\"\t=> \"page.html#propdef-widows\",\n\t\"width\"\t=> \"visudet.html#propdef-width\",\n\t\"word-spacing\"\t=> \"text.html#propdef-word-spacing\",\n\t\"z-index\"\t=> \"visuren.html#propdef-z-index\",\n}\n\ncur_line = ENV['TM_CURRENT_LINE']\ncur_word = ENV['TM_CURRENT_WORD']\n\n# since dash (‘-’) is not a word character, extend current word to neighboring word and dash characters\n$prop_name = /[-\\w]*\#{Regexp.escape cur_word}[-\\w]*/.match(cur_line)[0]\n\ndef request_prop_name\n  s = `\\\"\#{ENV['TM_SUPPORT_PATH']}/bin/CocoaDialog.app/Contents/MacOS/CocoaDialog\\\" inputbox --float --title 'Documentation for Property' --informative-text 'What property would you like to lookup?' --text '\#{$prop_name}' --button1 'Lookup' --button2 'Cancel' --button3 'Show All Properties'`\n  case (a = s.split(\"\\n\"))[0].to_i\n    when 1 then $props[a[1].to_s] || \"propidx.html\"\n    when 2 then abort \"<script>window.close()</script>\"\n    when 3 then \"propidx.html\"\n  end\nend\n\nprop_url = $props[$prop_name] || request_prop_name\nurl = \"http://www.w3.org/TR/CSS2/\" + prop_url\nputs \"<meta http-equiv='Refresh' content='0;URL=\#{url}'>\"\n",
  input: "none",
  keyEquivalent: "^h",
  name: "Documentation for Property",
  output: "showAsHTML",
  scope: "source.css",
  uuid: "50AA6E95-A754-4EBC-9C2A-68418C70D689"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\n\nrequire ENV['TM_SUPPORT_PATH'] + \"/lib/ui\"\nrequire ENV['TM_SUPPORT_PATH'] + \"/lib/exit_codes\"\ncolour = STDIN.read\n\n# http://www.w3schools.com/css/css_colornames.asp\nCOLOURS = {\n  'aliceblue'            => 'F0F8FF',\n  'antiquewhite'         => 'FAEBD7',\n  'aqua'                 => '00FFFF',\n  'aquamarine'           => '7FFFD4',\n  'azure'                => 'F0FFFF',\n  'beige'                => 'F5F5DC',\n  'bisque'               => 'FFE4C4',\n  'black'                => '000000',\n  'blanchedalmond'       => 'FFEBCD',\n  'blue'                 => '0000FF',\n  'blueviolet'           => '8A2BE2',\n  'brown'                => 'A52A2A',\n  'burlywood'            => 'DEB887',\n  'cadetblue'            => '5F9EA0',\n  'chartreuse'           => '7FFF00',\n  'chocolate'            => 'D2691E',\n  'coral'                => 'FF7F50',\n  'cornflowerblue'       => '6495ED',\n  'cornsilk'             => 'FFF8DC',\n  'crimson'              => 'DC143C',\n  'cyan'                 => '00FFFF',\n  'darkblue'             => '00008B',\n  'darkcyan'             => '008B8B',\n  'darkgoldenrod'        => 'B8860B',\n  'darkgray'             => 'A9A9A9',\n  'darkgrey'             => 'A9A9A9',\n  'darkgreen'            => '006400',\n  'darkkhaki'            => 'BDB76B',\n  'darkmagenta'          => '8B008B',\n  'darkolivegreen'       => '556B2F',\n  'darkorange'           => 'FF8C00',\n  'darkorchid'           => '9932CC',\n  'darkred'              => '8B0000',\n  'darksalmon'           => 'E9967A',\n  'darkseagreen'         => '8FBC8F',\n  'darkslateblue'        => '483D8B',\n  'darkslategray'        => '2F4F4F',\n  'darkslategrey'        => '2F4F4F',\n  'darkturquoise'        => '00CED1',\n  'darkviolet'           => '9400D3',\n  'deeppink'             => 'FF1493',\n  'deepskyblue'          => '00BFFF',\n  'dimgray'              => '696969',\n  'dimgrey'              => '696969',\n  'dodgerblue'           => '1E90FF',\n  'firebrick'            => 'B22222',\n  'floralwhite'          => 'FFFAF0',\n  'forestgreen'          => '228B22',\n  'fuchsia'              => 'FF00FF',\n  'gainsboro'            => 'DCDCDC',\n  'ghostwhite'           => 'F8F8FF',\n  'gold'                 => 'FFD700',\n  'goldenrod'            => 'DAA520',\n  'gray'                 => '808080',\n  'grey'                 => '808080',\n  'green'                => '008000',\n  'greenyellow'          => 'ADFF2F',\n  'honeydew'             => 'F0FFF0',\n  'hotpink'              => 'FF69B4',\n  'indianred'            => 'CD5C5C',\n  'indigo'               => '4B0082',\n  'ivory'                => 'FFFFF0',\n  'khaki'                => 'F0E68C',\n  'lavender'             => 'E6E6FA',\n  'lavenderblush'        => 'FFF0F5',\n  'lawngreen'            => '7CFC00',\n  'lemonchiffon'         => 'FFFACD',\n  'lightblue'            => 'ADD8E6',\n  'lightcoral'           => 'F08080',\n  'lightcyan'            => 'E0FFFF',\n  'lightgoldenrodyellow' => 'FAFAD2',\n  'lightgray'            => 'D3D3D3',\n  'lightgrey'            => 'D3D3D3',\n  'lightgreen'           => '90EE90',\n  'lightpink'            => 'FFB6C1',\n  'lightsalmon'          => 'FFA07A',\n  'lightseagreen'        => '20B2AA',\n  'lightskyblue'         => '87CEFA',\n  'lightslategray'       => '778899',\n  'lightslategrey'       => '778899',\n  'lightsteelblue'       => 'B0C4DE',\n  'lightyellow'          => 'FFFFE0',\n  'lime'                 => '00FF00',\n  'limegreen'            => '32CD32',\n  'linen'                => 'FAF0E6',\n  'magenta'              => 'FF00FF',\n  'maroon'               => '800000',\n  'mediumaquamarine'     => '66CDAA',\n  'mediumblue'           => '0000CD',\n  'mediumorchid'         => 'BA55D3',\n  'mediumpurple'         => '9370D8',\n  'mediumseagreen'       => '3CB371',\n  'mediumslateblue'      => '7B68EE',\n  'mediumspringgreen'    => '00FA9A',\n  'mediumturquoise'      => '48D1CC',\n  'mediumvioletred'      => 'C71585',\n  'midnightblue'         => '191970',\n  'mintcream'            => 'F5FFFA',\n  'mistyrose'            => 'FFE4E1',\n  'moccasin'             => 'FFE4B5',\n  'navajowhite'          => 'FFDEAD',\n  'navy'                 => '000080',\n  'oldlace'              => 'FDF5E6',\n  'olive'                => '808000',\n  'olivedrab'            => '6B8E23',\n  'orange'               => 'FFA500',\n  'orangered'            => 'FF4500',\n  'orchid'               => 'DA70D6',\n  'palegoldenrod'        => 'EEE8AA',\n  'palegreen'            => '98FB98',\n  'paleturquoise'        => 'AFEEEE',\n  'palevioletred'        => 'D87093',\n  'papayawhip'           => 'FFEFD5',\n  'peachpuff'            => 'FFDAB9',\n  'peru'                 => 'CD853F',\n  'pink'                 => 'FFC0CB',\n  'plum'                 => 'DDA0DD',\n  'powderblue'           => 'B0E0E6',\n  'purple'               => '800080',\n  'red'                  => 'FF0000',\n  'rosybrown'            => 'BC8F8F',\n  'royalblue'            => '4169E1',\n  'saddlebrown'          => '8B4513',\n  'salmon'               => 'FA8072',\n  'sandybrown'           => 'F4A460',\n  'seagreen'             => '2E8B57',\n  'seashell'             => 'FFF5EE',\n  'sienna'               => 'A0522D',\n  'silver'               => 'C0C0C0',\n  'skyblue'              => '87CEEB',\n  'slateblue'            => '6A5ACD',\n  'slategray'            => '708090',\n  'slategrey'            => '708090',\n  'snow'                 => 'FFFAFA',\n  'springgreen'          => '00FF7F',\n  'steelblue'            => '4682B4',\n  'tan'                  => 'D2B48C',\n  'teal'                 => '008080',\n  'thistle'              => 'D8BFD8',\n  'tomato'               => 'FF6347',\n  'turquoise'            => '40E0D0',\n  'violet'               => 'EE82EE',\n  'wheat'                => 'F5DEB3',\n  'white'                => 'FFFFFF',\n  'whitesmoke'           => 'F5F5F5',\n  'yellow'               => 'FFFF00',\n  'yellowgreen'          => '9ACD32',\n}\n\nif colour.length > 0 and colour[0] != ?#\n  colour.downcase!\n  # Convert named colours to their hex values\n  colour = '#' + COLOURS[colour] if COLOURS.has_key? colour\nend\n\nif res = TextMate::UI.request_color(colour)\n  print res\nelse\n  TextMate.exit_discard\nend\n",
  fallbackInput: "word",
  input: "selection",
  keyEquivalent: "@C",
  name: "Insert Color…",
  output: "replaceSelectedText",
  scope: "source.css, meta.tag string.quoted -source",
  uuid: "CC30D708-6E49-11D9-B411-000D93589AF6"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\n\nLIPSUM = \"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\"\n\ndef tag_preview(selector_list)\n\thtml = 'TEXT_INSERT'\n\tselectors = selector_list.split(/\\s+/)\n\tlast_tag = ''\n\ttext_insert = \"Generated preview for CSS selector \#{selector_list}.\"\n\n\tstar_class = ''\n\tstar_id = ''\n\thtml_class = ''\n\thtml_id = ''\n\tbody_class = ''\n\tbody_id = ''\n\n\tselectors.reverse.each do | selector |\n\t\tsinglet = false\n\t\ttag = selector.clone\n\t\tif (tag =~ /#(.+)/)\n\t\t\tid = (tag.scan(/#(.+)/))[0][0]\n\t\t\tid.gsub!(/\\..+/, '')\n\t\telse\n\t\t\tid = nil\n\t\tend\n\t\tif (tag =~ /\\.(.+)/)\n\t\t\tcls = (tag.scan(/\\.(.+)/))[0][0]\n\t\t\tcls.gsub!(/\\./, ' ')\n\t\t\tcls.gsub!(/\\#.+/, '')\n\t\telse\n\t\t\tcls = nil\n\t\tend\n\n\t\ttag.downcase!\n\t\ttag.sub!(/#(.+)/, '');\n\t\ttag.sub!(/\\.(.+)/, '');\n\t\ttag.sub!(/:.+/, '')\n\n\t\tcase tag\n\t\twhen '*'\n\t\t\tstar_class = \" \#{cls}\" if cls\n\t\t\tstar_id = \" id=\\\"\#{id}\\\"\" if id\n\t\t\tcls = nil\n\t\t\tid = nil\n\t\t\ttag = 'div'\n\t\twhen 'body'\n\t\t\tbody_class = \" \#{cls}\" if cls\n\t\t\tbody_id = \" id=\\\"\#{id}\\\"\" if id\n\t\t\tcls = nil\n\t\t\tid = nil\n\t\t\ttag = 'div'\n\t\twhen 'html'\n\t\t\thtml_class = \" \#{cls}\" if cls\n\t\t\thtml_id = \" id=\\\"\#{id}\\\"\" if id\n\t\t\tcls = nil\n\t\t\tid = nil\n\t\t\ttag = 'div'\n\t\tend\n\n\t\tnext if tag == '+'\n\n\t\tif selector =~ /^[#.]/\n\t\t\tcase last_tag\n\t\t\twhen 'li'\n\t\t\t\ttag = 'ul'\n\t\t\twhen 'td'\n\t\t\t\ttag = 'tr'\n\t\t\twhen 'tr'\n\t\t\t\ttag = 'table'\n\t\t\twhen /^h\\d/\n\t\t\t\ttag = 'div'\n\t\t\telse\n\t\t\t\ttag = 'span'\n\t\t\tend\n\t\tend\n\n\t\tif (tag =~ /\\[(.+?)\\]/)\n\t\t\ttag_attr = (tag.scan(/\\[(.+?)\\]/))[0][0]\n\t\t\ttag.gsub!(/\\[.+?\\]/, '')\n\t\telse\n\t\t\ttag_attr = nil\n\t\tend\n\t\tpart = \"<\" + tag\n\t\tpart += \" \#{tag_attr}\" if tag_attr\n\t\tpart += \" id=\\\"\#{id}\\\"\" if id\n\t\tpart += \" class=\\\"\#{cls}\\\"\" if cls\n\n\t\t# defaults for img tag\n\t\tcase tag\n\t\twhen 'img'\n\t\t\tpart += \" src=\\\"http://www.google.com/intl/en/images/logo.gif\\\"\"\n\t\t\tpart += \" alt=\\\"Preview of \#{selector_list}\\\"\"\n\t\t\tsinglet = true\n\t\twhen 'a'\n\t\t\tpart += \" href=\\\"\\#\\\"\"\n\t\twhen 'input'\n\t\t\topen_tag = part.clone\n\t\t\tpart += \" type=\\\"radio\\\" /> Radio\"\n\t\t\tpart += \"\#{open_tag} type=\\\"checkbox\\\" /> Checkbox<br />\"\n\t\t\tpart += \"\#{open_tag} type=\\\"text\\\" value=\\\"Text Field\\\" />\"\n\t\t\tpart += \"\#{open_tag} type=\\\"button\\\" value=\\\"Button\\\"\"\n\t\t\tsinglet = true\n\t\twhen 'select'\n\t\t\tpart += \"><option>Option 1</option><option>Option 2</option\"\n\t\t\thtml = ''\n\t\tend\n\n\t\tif (singlet)\n\t\t\tpart += \" />\"\n\t\telse\n\t\t\tpart += \">\"\n\t\t\tpart += html\n\t\t\tpart += \"</\" + tag + \">\"\n\t\tend\n\n\t\tcase tag\n\t\twhen /^h\\d/\n\t\t\ttext_insert = tag.sub(/^h(\\d+)/, \"Heading \\\\1\")\n\t\twhen 'p'\n\t\t\ttext_insert = LIPSUM\n\t\twhen 'object', 'img', 'input'\n\t\t\ttext_insert = \"\"\n\t\tend\n\n\t\thtml = part\n\t\tlast_tag = tag\n\tend\n\n\tif (last_tag)\n\t\tcase last_tag\n\t\twhen 'em', 'strong', 'b', 'i'\n\t\t\thtml = \"<p>\#{html}</p>\"\n\t\twhen 'li'\n\t\t\thtml = \"<ul>\#{html}</ul>\"\n\t\twhen 'td'\n\t\t\thtml = \"<table><tr>\#{html}</tr></table>\"\n\t\twhen 'tr'\n\t\t\thtml = \"<table>\#{html}</table>\"\n\t\twhen 'input', 'textarea', 'select'\n\t\t\thtml = \"<form method=\\\"get\\\">\#{html}</form>\"\n\t\tend\n\tend\n\n\thtml = \"<div>\#{html}</div>\"\n\thtml.sub!(/TEXT_INSERT/, text_insert)\n\n\treturn <<EOT\n<div class=\"__wrap_wrap\"><div class=\"__star_wrap\#{star_class}\"\#{star_id}><div class=\"__html_wrap\#{html_class}\"\#{html_id}><div class=\"__body_wrap\#{body_class}\"\#{body_id}>\#{html}</div></div></div></div>\nEOT\nend\n\ndef preview_css(str)\n\torig_css = str.clone\n\torig_css.gsub!(/<entity\\.name\\.tag\\.wildcard\\.css>\\*<\\/entity\\.name\\.tag\\.wildcard\\.css>/, '.__star_wrap')\n\torig_css.gsub!(/<entity\\.name\\.tag\\.css>body<\\/entity\\.name\\.tag\\.css>/, '.__body_wrap')\n\torig_css.gsub!(/<entity\\.name\\.tag\\.css>html<\\/entity\\.name\\.tag\\.css>/, '.__html_wrap')\n\n\torig_css.gsub!(/<.+?>/, '')\n\torig_css.gsub!(/&lt;\\/?style\\b.*?&gt;/m, '')\n\torig_css.strip!\n\n\t#meta.selector.css -> wraps the selector\n\t#meta.property-list.css -> wraps the properties\n\trules = str.scan(/<meta\\.selector\\.css>\\s*(.+?)\\s*<\\/meta\\.selector\\.css>.*?<meta\\.property-list\\.css>(.+?)<\\/meta\\.property-list\\.css>/m)\n\n\thtml = ''\n\tcss = ''\n\trule_num = 0\n\n\trules.each do | rule |\n\t\tselector = rule[0].gsub(/<.+?>/, '')\n\t\tstyles = rule[1].gsub(/<.+?>/, '')\n\t\tstyles.gsub!(/^\\s*\\{\\n*/m, '')\n\t\tstyles.gsub!(/\\s*\\}\\s*$/m, '')\n\t\tstyles.gsub!(/\\t/, ' ' * ENV['TM_TAB_SIZE'].to_i)\n\t\tselectors = selector.split(/\\s*,\\s*/m)\n\t\tselectors.each do | single_selector |\n\t\t\trule_num += 1\n\t\t\thtml += \"<div class=\\\"__rule_clear\\\"></div>\\n\\n\" if html != ''\n\t\t\thtml += \"<div class=\\\"__rule_selector\\\">\#{single_selector} <a class=\\\"__view_link\\\" href=\\\"javascript:viewCSS('__rule\#{rule_num}')\\\" title=\\\"Click to toggle CSS view\\\">CSS</a><div class=\\\"__rule\\\" id=\\\"__rule\#{rule_num}\\\" style=\\\"display: none\\\">\#{styles}</div></div>\\n\\n\"\n\t\t\thtml += tag_preview(single_selector) + \"\\n\\n\"\n\t\tend\n\tend\n\n\tfilename = ENV['TM_FILENAME'] || 'untitled'\n\tbase = ''\n\tbase = \"<base href=\\\"file://\#{ENV['TM_FILEPATH']}\\\" />\" if ENV['TM_FILEPATH']\n\n\treturn <<EOT\n<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \n\t\"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\">\n\t<head>\n\t\t\#{base}\n\t\t<meta http-equiv=\"Content-type\" content=\"text/html; charset=utf-8\" />\n\t\t<meta http-equiv=\"Content-Language\" content=\"en-us\" />\n\t\t<title>CSS Preview for \#{filename}</title>\n\t\t<style type=\"text/css\">\n\#{orig_css}\n.__wrap_wrap {\n\tposition: relative;\n\tmargin-top: 5px;\n\tmargin-bottom: 20px;\n\tborder-top: 1px solid #ccc;\n}\n.__rule_selector {\n\tfont-family: Times;\n\tfont-size: 16px;\n\tborder-top: 1px solid #ccc;\n}\n.__rule {\n\twhite-space: pre;\n\tword-wrap: break-word;\n\tfont-family: Monaco;\n\tfont-size: 11px;\n}\n.__view_link {\n\tfont-family: Monaco;\n\tfont-size: 11px;\n}\n.__rule_clear:after {\n\tcontent: \".\"; \n\tdisplay: block; \n\theight: 0; \n\tclear: both; \n\tvisibility: hidden;\n}\n\t\t</style>\n\t\t<script type=\"text/javascript\">\n\t\tfunction viewCSS(rule_id) {\n\t\t\tvar el = document.getElementById(rule_id);\n\t\t\tif (el) {\n\t\t\t\tif (el.style.display == 'none')\n\t\t\t\t\tel.style.display = 'block';\n\t\t\t\telse\n\t\t\t\t\tel.style.display = 'none';\n\t\t\t}\n\t\t}\n\t\t</script>\n\t</head>\n\t\n\t<body>\n\#{html}\n\t</body>\n</html>\nEOT\nend\n\nprint preview_css(STDIN.read)\n",
  fallbackInput: "scope",
  input: "selection",
  inputFormat: "xml",
  keyEquivalent: "^~@p",
  name: "Preview",
  output: "showAsHTML",
  scope: "source.css - text.html",
  uuid: "05554FE0-4A70-4F3E-81C5-72855D7EB428"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\n\nprint '<html><head><meta http-equiv=\"Refresh\" content=\"0; URL='\nprint 'http://jigsaw.w3.org/css-validator/validator?warning=1&profile=none&usermedium=all&text='\n\nscope = STDIN.read\n\nscope.gsub!(/<\\/?style.*?>/, '')\n\n((scope != nil && scope.size > 0) ? scope : $< ).each_byte do |b|\n\n  if b == 32\n    print '+'\n  elsif b.chr =~ /\\w/\n    print b.chr\n  else\n    printf '%%%02x', b\n  end\nend\n\nputs '#errors\"></head><body></body></html>'",
  fallbackInput: "scope",
  input: "selection",
  keyEquivalent: "^V",
  name: "Validate CSS",
  output: "showAsHTML",
  scope: "source.css",
  uuid: "45E5E5A1-84CC-11D9-970D-0011242E4184"}]
