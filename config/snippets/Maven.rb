# Encoding: UTF-8

{"dep" => 
  {scope: "text.xml.pom",
   name: "dependency",
   content: 
    "<dependency>\n\t<groupId>$1</groupId>\n\t<artifactId>$2</artifactId>\n\t<version>$3</version>${4/(.+)/(?1:\n\t)/}${4:<scope>$5</scope>}${6/(.+)/(?1:\n\t)/}${6:<classifier>$7</classifier>}\n</dependency>$0"}}
