# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\nrequire 'rexml/document'\n\ndef serialize(source, dest)\n  if source.is_a? REXML::Text\n    dest.add_text(source.dup)\n    return dest\n  end\n\n  d2 = dest.add_element('xsl:element', 'name' => source.expanded_name)\n  source.attributes.each { |(k,v)| d2.add_element('xsl:attribute', 'name' => k).text = v }\n  source.children.each { |node| serialize(node, d2)}\n  dest\nend\n\nsource = REXML::Document.new(STDIN.read)\ndest   = REXML::Document.new\n\nprint serialize(source.elements[1], dest).to_s",
  fallbackInput: "document",
  input: "selection",
  name: "Create XSL Generator for Selection",
  output: "replaceSelectedText",
  scope: "text.xml",
  uuid: "67E7372F-C15F-4009-AE5B-975F2BC9DD91"},
 {beforeRunningCommand: "nop",
  command: 
   "if [[ \"$TM_SOFT_TABS\" = \"YES\" ]];\n\tthen export XMLLINT_INDENT=`ruby -e\"print(' ' * ${TM_TAB_SIZE})\"`\n\telse export XMLLINT_INDENT=$'\\t'\nfi\nresult=`xmllint --format - 2>&1`\nif [[ $? > 0 ]];\n\tthen exit_show_tool_tip \"Errors: $result\"\n\telse echo \"$result\"\nfi",
  input: "selection",
  keyEquivalent: "^H",
  name: "Tidy",
  output: "replaceSelectedText",
  scope: "text.xml",
  uuid: "A1DAE610-1E05-4174-BB6D-A51E22DB0764"},
 {beforeRunningCommand: "nop",
  command: 
   "xmllint --htmlout --valid - 2>&1|perl -pe 's|^((?:</?[^>]+>)*)(.*?):(\\d+):(.*error.*)|$1<a href=\"txmt://open?line=$3\">$4</a>|'",
  input: "document",
  keyEquivalent: "^V",
  name: "Validate Syntax",
  output: "showAsHTML",
  scope: "text.xml",
  uuid: "F216B838-965F-11D9-9561-000D93589AF6"}]
