# Encoding: UTF-8

[{content: "enum ${1:Name} {\n\t${2:FIELD} = ${3:1},$0\n}",
  name: "enum",
  scope: "source.thrift -meta",
  tabTrigger: "enu",
  uuid: "C1341136-77B4-433A-A17D-C0ECE06A3402"},
 {content: "exception ${1:Name} {\n\t1: string message,$0\n}",
  name: "exception",
  scope: "source.thrift -meta",
  tabTrigger: "exc",
  uuid: "4B087906-E44D-48BF-8601-2BB95E285CAF"},
 {content: 
   "service ${1:Name}${2/.+/ extends /m}${2:Super} {\n\t${3:void} ${4:method}(${5:args})\n}",
  name: "service",
  scope: "source.thrift -meta",
  tabTrigger: "ser",
  uuid: "90593423-A61F-4BAF-8368-EFA79DC347E1"},
 {content: 
   "struct ${1:Name} {\n\t${2:1}${2/.+/: /m}${3:i32} ${4:field}${5/.+/ = /m}${5:value},$0\n}",
  name: "struct",
  scope: "source.thrift -meta",
  tabTrigger: "str",
  uuid: "FA5FBCA2-12D6-4C3B-A9A0-5B9C9AD141AD"}]
