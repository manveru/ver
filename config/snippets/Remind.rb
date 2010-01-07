# Encoding: UTF-8

[{content: 
   "REM ${1:`date +'%b'`} ${2:`date +'%e'`} MSG ${4:${3:Someone}’s birthday}${6: (19${5:??})}",
  name: "Birthday",
  scope: "source.remind",
  tabTrigger: "bir",
  uuid: "7C3460D1-71B7-4120-B91E-D152668AB858"},
 {content: 
   "REM ${1:`LANG=en_US date +'%b'`} ${2:`date +'%e'`} ${3:`date +'%Y'`} MSG ${0:message…}",
  name: "Date Only",
  scope: "source.remind",
  tabTrigger: "rem",
  uuid: "3702D806-20BA-4FC7-9CF3-68B0D0381B7B"},
 {content: 
   "REM ${1:`LANG=en_US date +'%b'`} ${2/^(.)$|.*/(?1: )/}${2:`date +'%e'`} ${3:`date +'%Y'`}${4: AT ${5:16}:${6:00}} MSG ${0:message…}",
  name: "Date and Time",
  scope: "source.remind",
  tabTrigger: "at",
  uuid: "1A7FB4DA-03D5-483E-91F0-CC03394DB535"}]
