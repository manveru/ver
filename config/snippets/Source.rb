# Encoding: UTF-8

{nil => 
  {scope: nil,
   name: "Insert Comment Banner",
   content: 
    "${TM_COMMENT_START/\\s*$/ /}==${1/(.)|(?m:\\n.*)/(?1:=)/g}==${TM_COMMENT_END/^\\s*(.+)/ $1/}\n${TM_COMMENT_START/\\s*$/ /}= ${1:${TM_SELECTED_TEXT:Banner}} =${TM_COMMENT_END/\\s*(.+)/ $1/}\n${TM_COMMENT_START/\\s*$/ /}==${1/(.)|(?m:\\n.*)/(?1:=)/g}==${TM_COMMENT_END/\\s*(.+)/ $1/}"}}
