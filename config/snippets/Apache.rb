# Encoding: UTF-8

{"vhost" => 
  {scope: "source.apache-config",
   name: "Virtual Host",
   content: 
    "<VirtualHost ${1:example.org}>\n\tServerAdmin webmaster@$1\n\tDocumentRoot /www/vhosts/$1\n\tServerName $1\n\tErrorLog logs/$1-error_log\n\tCustomLog logs/$1-access_log common\n</VirtualHost>"},
 "allow" => 
  {scope: "source.apache-config",
   name: "Allow Override",
   content: 
    "AllowOverride ${1:${2:AuthConfig }${3:FileInfo }${4:Indexes }${5:Limit }${6:Options}}"},
 "dir" => 
  {scope: "source.apache-config",
   name: "Directory",
   content: 
    "<Directory ${1:/Library/WebServer/${2:example/}}>\n\t$0\n</Directory>\n"},
 "opt" => 
  {scope: "source.apache-config",
   name: "Options",
   content: 
    "Options ${1:${2:All }${3:ExecCGI }${4:FollowSymLinks }${5:Includes }${6:IncludesNOEXEC }${7:Indexes }${8:MultiViews }${9:SymLinksIfOwnerMatch}}"}}
