# Encoding: UTF-8

{"bir" => 
  {scope: "source.remind",
   name: "Birthday",
   content: 
    "REM ${1:`date +'%b'`} ${2:`date +'%e'`} MSG ${4:${3:Someone}’s birthday}${6: (19${5:??})}"},
 "rem" => 
  {scope: "source.remind",
   name: "Date Only",
   content: 
    "REM ${1:`LANG=en_US date +'%b'`} ${2:`date +'%e'`} ${3:`date +'%Y'`} MSG ${0:message…}"},
 "at" => 
  {scope: "source.remind",
   name: "Date and Time",
   content: 
    "REM ${1:`LANG=en_US date +'%b'`} ${2/^(.)$|.*/(?1: )/}${2:`date +'%e'`} ${3:`date +'%Y'`}${4: AT ${5:16}:${6:00}} MSG ${0:message…}"}}
