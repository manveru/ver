# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "head -n$((TM_LINE_NUMBER-1))|tail -n1|sed 's/./-/g'|tail -c +$((TM_LINE_INDEX+1))",
  input: "document",
  name: "Subheading",
  output: "insertAsSnippet",
  scope: "text.setext",
  tabTrigger: "-",
  uuid: "95C6ECD1-69B9-4EB9-840B-C7753C226306"},
 {beforeRunningCommand: "nop",
  command: 
   "head -n$((TM_LINE_NUMBER-1))|tail -n1|sed 's/./=/g'|tail -c +$((TM_LINE_INDEX+1))",
  input: "document",
  name: "Title",
  output: "insertAsSnippet",
  scope: "text.setext",
  tabTrigger: "=",
  uuid: "8E5BEE2D-01D5-455A-A576-044DCC1243AA"}]
