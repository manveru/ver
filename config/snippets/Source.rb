# Encoding: UTF-8

[{content: 
   "\n`# extract comment type from the scope name\n# and convert it to the actual character(s)\nCH=$(perl <<<$TM_SCOPE -pe 's/.*\\bcomment\\.line\\.([^. ]*).*/$1/')\ngrep -w ^$CH <<EOF|cut -f2|tr -d \\n\ndouble-slash\t//\ndouble-dash\t--\nnumber-sign\t#\npercentage\t%\nasterisk\t*\nsemicolon\t;\napostrophe\t'\nbacktick\t\\\\\\`\nat-sign\t@\ndouble-backslash\t\\\\\\\\\ndouble-dot\t..\ndouble-number-sign\t##\nexclamation\t!\nslash\t/\nEOF` $0",
  keyEquivalent: "",
  name: "Continue Line Comment",
  scope: "comment.line",
  uuid: "C5C928A6-AC7E-11D9-98E4-000D93589AF6"},
 {content: "\\\"${0:$TM_SELECTED_TEXT}\\\"",
  keyEquivalent: "@\"",
  name: "Double Quotes — \\\"…\\\"",
  uuid: "9D896CE5-A52E-11D9-8CF2-000D93589AF6"},
 {content: 
   "${TM_COMMENT_START/\\s*$/ /}==${1/(.)|(?m:\\n.*)/(?1:=)/g}==${TM_COMMENT_END/^\\s*(.+)/ $1/}\n${TM_COMMENT_START/\\s*$/ /}= ${1:${TM_SELECTED_TEXT:Banner}} =${TM_COMMENT_END/\\s*(.+)/ $1/}\n${TM_COMMENT_START/\\s*$/ /}==${1/(.)|(?m:\\n.*)/(?1:=)/g}==${TM_COMMENT_END/\\s*(.+)/ $1/}",
  keyEquivalent: "^B",
  name: "Insert Comment Banner",
  uuid: "7DE18A58-37A7-4F6B-8059-4365DCF27E46"},
 {content: "\\n",
  keyEquivalent: "^\n",
  name: "Newline — \\n",
  scope: "source",
  uuid: "DB79A3E7-ED7C-433E-AA0E-40B2EF7FB4AD"},
 {content: "\\'${0:$TM_SELECTED_TEXT}\\'",
  keyEquivalent: "~@\"",
  name: "Single Quotes — \\'…\\'",
  uuid: "AD6BAC7C-A52E-11D9-8CF2-000D93589AF6"}]
