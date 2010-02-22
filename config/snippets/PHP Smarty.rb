# Encoding: UTF-8

{"{assign" => 
  {scope: "source.smarty", name: "Assign", content: "{assign var=$1 value=$2"},
 "|esc" => 
  {scope: "source.smarty",
   name: "Escape",
   content: 
    "|escape:\"${1:html|htmlall|url|quotes|hex|hexentity|javascript}\" "},
 "|format" => 
  {scope: "source.smarty",
   name: "Date Format",
   content: "|date_format:\"${1:%b %e, %Y}\""},
 "{math" => 
  {scope: "source.smarty",
   name: "Math",
   content: "{math equation=\"${1:1+x}\" assign=$2 ${3:x=8}"},
 "|trunc" => 
  {scope: "source.smarty",
   name: "Truncate",
   content: "|truncate:${1:80}:${2:\"&hellip;\"}:${3:false}"},
 "|count" => 
  {scope: "source.smarty", name: "Count Words", content: "|count_words"},
 "{foreach" => 
  {scope: "source.smarty",
   name: "Foreach",
   content: 
    "{foreach from=\\$${1:varname} item=${2:item}${3: key=${4:key}}${5: name=${6:loop1}}}\n\t$0\n{/foreach"},
 "{if" => {scope: "source.smarty", name: "If", content: "{if $1}\n\t$0\n{/if"},
 "{inc" => 
  {scope: "source.smarty",
   name: "Include",
   content: "{include file=\"$1\"${2: assign=${3:var}}"},
 "{capture" => 
  {scope: "source.smarty",
   name: "Capture",
   content: "{capture${1: name=$2}${3: assign=$4}}$0{/capture"},
 "{ld" => {scope: "source.smarty", name: "Ldelim", content: "{ldelim"},
 "|cat" => 
  {scope: "source.smarty", name: "Cat", content: "|cat:\"${1:lorem ipsum}\""},
 "{config_load" => 
  {scope: "source.smarty",
   name: "Config Load",
   content: 
    "{config_load file=\"$1\"${2: section=\"$3\"}${4: scope=\"${5:local|parent|global}\"}"},
 "|cap" => 
  {scope: "source.smarty", name: "Capitalize", content: "|capitalize"},
 "{rd" => {scope: "source.smarty", name: "Rdelim", content: "{rdelim}"},
 "|def" => 
  {scope: "source.smarty", name: "Default", content: "|default:\"$1\" "},
 "|strip" => 
  {scope: "source.smarty", name: "Strip Tags", content: "|strip_tags"},
 "{counter" => 
  {scope: "source.smarty",
   name: "Counter",
   content: 
    "{counter name=\"$1\" start=${2:1}${3: skip=${4:2}}${5: assign=\"${6}\"}"},
 "{fetch" => 
  {scope: "source.smarty",
   name: "Fetch",
   content: "{fetch file=\"${1:filename}\"${2: assign=${3:var}}"},
 "{cycle" => 
  {scope: "source.smarty",
   name: "Cycle",
   content: "{cycle values=\"${1:on},${2:off}\"${3: name=\"${4:name}\"}"},
 "{lit" => 
  {scope: "source.smarty", name: "Literal", content: "{literal}$1{/literal"},
 "|regex" => 
  {scope: "source.smarty",
   name: "Regex Replace",
   content: "|regex_replace:\"/${1:.*}/\":\"$2\""},
 "{strip" => 
  {scope: "source.smarty", name: "Strip", content: "{strip}\n\t$1\n{/strip"},
 "|replace" => 
  {scope: "source.smarty",
   name: "Replace",
   content: "|replace:\"${1:needle}\":\"$2\" "},
 "|wrap" => 
  {scope: "source.smarty",
   name: "Word Wrap",
   content: "|wordwrap:${1:80}${2::\"${3:\\n}\"}"}}
