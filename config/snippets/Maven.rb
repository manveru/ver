# Encoding: UTF-8

[{content: 
   "<dependency>\n\t<groupId>$1</groupId>\n\t<artifactId>$2</artifactId>\n\t<version>$3</version>${4/(.+)/(?1:\n\t)/}${4:<scope>$5</scope>}${6/(.+)/(?1:\n\t)/}${6:<classifier>$7</classifier>}\n</dependency>$0",
  name: "dependency",
  scope: "text.xml.pom",
  tabTrigger: "dep",
  uuid: "8A46FDB2-94F2-4811-B979-8BF697D1FF84"}]
