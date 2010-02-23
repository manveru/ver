# Encoding: UTF-8

[{content: 
   "AllowOverride ${1:${2:AuthConfig }${3:FileInfo }${4:Indexes }${5:Limit }${6:Options}}",
  name: "Allow Override",
  scope: "source.apache-config",
  tabTrigger: "allow",
  uuid: "C6256A3A-BC6E-4587-8D3C-6588AD5F89F5"},
 {content: 
   "<Directory ${1:/Library/WebServer/${2:example/}}>\n\t$0\n</Directory>\n",
  name: "Directory",
  scope: "source.apache-config",
  tabTrigger: "dir",
  uuid: "894AF995-B54F-43CC-8810-2A0CCD56B168"},
 {content: 
   "Options ${1:${2:All }${3:ExecCGI }${4:FollowSymLinks }${5:Includes }${6:IncludesNOEXEC }${7:Indexes }${8:MultiViews }${9:SymLinksIfOwnerMatch}}",
  name: "Options",
  scope: "source.apache-config",
  tabTrigger: "opt",
  uuid: "230ED58C-E1B9-4BA6-A034-6F5629B6F46C"},
 {content: 
   "<VirtualHost ${1:example.org}>\n\tServerAdmin webmaster@$1\n\tDocumentRoot /www/vhosts/$1\n\tServerName $1\n\tErrorLog logs/$1-error_log\n\tCustomLog logs/$1-access_log common\n</VirtualHost>",
  name: "Virtual Host",
  scope: "source.apache-config",
  tabTrigger: "vhost",
  uuid: "12F1DA22-C375-4DF5-B0C5-87BA2AA38AB0"}]
