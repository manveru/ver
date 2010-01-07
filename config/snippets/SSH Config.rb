# Encoding: UTF-8

[{content: "DynamicForward ${1:0000}",
  name: "DynamicForward",
  scope: "source.ssh-config",
  tabTrigger: "df",
  uuid: "C1383DD1-64AA-46E1-B9E9-5A243790B81B"},
 {content: 
   "Host ${1:AliasName}\n\tUser ${2:UserName}\n\tPort ${3:22}\n\tHostName ${4:hostname.com}\n",
  name: "Host",
  scope: "source.ssh-config",
  tabTrigger: "host",
  uuid: "215B06B5-5201-481E-87EC-6B912C3A33E9"},
 {content: "IdentityFile ${1:~/.ssh/filename}",
  name: "IdentityFile",
  scope: "source.ssh-config",
  tabTrigger: "idf",
  uuid: "4E6A957C-0BFD-4265-A701-43088ED0A365"},
 {content: "LocalForward ${1:LocalPort} ${2:DestHost}:${3:DestPort}",
  name: "LocalForward",
  scope: "source.ssh-config",
  tabTrigger: "lf",
  uuid: "C9DE9563-3446-49D3-B87C-8F12B0A2CC8B"}]
