# Encoding: UTF-8

{"cfobject" => 
  {scope: "text.html.cfm",
   name: "cfobject (CORBA)",
   content: 
    "<cfobject type = \"corba\" context = \"$1\" class = \"$2\" name = \"$3\"${4: locale = \"${5:[ ]}\"}>$0\n\n"},
 "cferror" => 
  {scope: "text.html.cfm",
   name: "cferror",
   content: 
    "<cferror type = \"$1\" template = \"$2\"${3: mailTo = \"${4:[ ]}\" exception = \"${5:[ ]}\"}>$0"},
 "cfwddx" => 
  {scope: "text.html.cfm",
   name: "cfwddx",
   content: 
    "<cfwddx action = \"$1\"  input = \"$2\"${3: output = \"${4:required if action equals wddx2cfml}\"  topLevelVariable = \"${5:required if action = wddx2js or cfml2js}\" useTimeZoneInfo = \"${6:[ ]}\" validate = \"${7:[ ]}\"}>$0"},
 "cfhtmlhead" => 
  {scope: "text.html.cfm",
   name: "cfhtmlhead",
   content: "<cfhtmlhead text = \"$1\">$0"},
 "urlsessionformat" => 
  {scope: "text.html.cfm",
   name: "urlsessionformat",
   content: "URLSessionFormat(${1:request_URL})$0"},
 "evaluate" => 
  {scope: "text.html.cfm",
   name: "evaluate",
   content: 
    "Evaluate(${1:string_expression1}${2: [, string_expression2]}${3: [, ]})$0"},
 "getbasetaglist" => 
  {scope: "text.html.cfm",
   name: "getbasetaglist",
   content: "GetBaseTagList(${1:})$0"},
 "decrypt" => 
  {scope: "text.html.cfm",
   name: "decrypt",
   content: 
    "Decrypt(${1:encrypted_string}, ${2:key}${3: [, algorithm]}${4: [, encoding]}${5: [, IVorSalt]}${6: [, iterations]})$0"},
 "refindnocase" => 
  {scope: "text.html.cfm",
   name: "refindnocase",
   content: 
    "REFindNoCase(${1:reg_expression}, ${2:string}${3: [, start]}${4: [, returnsubexpressions]})$0"},
 "rereplace" => 
  {scope: "text.html.cfm",
   name: "rereplace",
   content: 
    "REReplace(${1:string}, ${2:reg_expression}, ${3:substring}${4: [, scope]})$0"},
 "cflog" => 
  {scope: "text.html.cfm",
   name: "cflog",
   content: 
    "<cflog text = \"$1\"${2: log = \"${3:[ ]}\" file = \"${4:[ ]}\" type = \"${5:[ ]}\" application = \"${6:[ ]}\"}>$0"},
 "xmlformat" => 
  {scope: "text.html.cfm",
   name: "xmlformat",
   content: "XmlFormat(${1:string})$0"},
 "datediff" => 
  {scope: "text.html.cfm",
   name: "datediff",
   content: "DateDiff(${1:\"datepart\"}, ${2:\"date1\"}, ${3:\"date2\"})$0"},
 "createodbcdatetime" => 
  {scope: "text.html.cfm",
   name: "createodbcdatetime",
   content: "CreateODBCDateTime(${1:date})$0"},
 "lscurrencyformat" => 
  {scope: "text.html.cfm",
   name: "lscurrencyformat",
   content: "LSCurrencyFormat(${1:number}${2: [, type]})$0"},
 "querynew" => 
  {scope: "text.html.cfm",
   name: "querynew",
   content: "QueryNew(${1:columnlist}${2: [, columntypelist]})$0"},
 "cfftp" => 
  {scope: "text.html.cfm",
   name: "cfftp",
   content: 
    "<cfftp action = \"$1\" username = \"$2\" password = \"$3\" server = \"$4\"${5: timeout = \"${6:[ ]}\" port = \"${7:[ ]}\" connection = \"${8:[ ]}\" proxyServer = \"${9:[ ]}\" retryCount = \"${10:[ ]}\" stopOnError = \"${11:[ ]}\" passive = \"yes\"}>$0"},
 "structkeyexists" => 
  {scope: "text.html.cfm",
   name: "structkeyexists",
   content: "StructKeyExists(${1:structure}, ${2:\"key\"})$0"},
 "cfregistry" => 
  {scope: "text.html.cfm",
   name: "cfregistry (delete)",
   content: "<cfregistry action = \"$1\" branch = \"$2\" entry = \"$3\">$0"},
 "getfunctionlist" => 
  {scope: "text.html.cfm",
   name: "getfunctionlist",
   content: "GetFunctionList(${1:})$0"},
 "hash" => 
  {scope: "text.html.cfm",
   name: "hash",
   content: "Hash(${1:string$}${2: [, algorithm]}${3: [, encoding]})$0"},
 "cfsetting" => 
  {scope: "text.html.cfm",
   name: "cfsetting",
   content: 
    "<cfsetting${1: enableCFoutputOnly = \"${2:[ ]}\" showDebugOutput = \"${3:no}\" requestTimeOut = \"${4:30}\"}>$0"},
 "cfscript" => 
  {scope: "text.html.cfm",
   name: "cfscript",
   content: "<cfscript>\n\t$1\n</cfscript>$0"},
 "getprofilesections" => 
  {scope: "text.html.cfm",
   name: "getprofilesections",
   content: "GetProfileSections(${1:iniFile})$0"},
 "structnew" => 
  {scope: "text.html.cfm", name: "structnew", content: "StructNew($1)$0"},
 "bitmaskclear" => 
  {scope: "text.html.cfm",
   name: "bitmaskclear",
   content: "BitMaskClear(${1:number}, ${2:start}, ${3:length})$0"},
 "dayofweek" => 
  {scope: "text.html.cfm",
   name: "dayofweek",
   content: "DayOfWeek(${1:\"date\"})$0"},
 "cffile" => 
  {scope: "text.html.cfm",
   name: "cffile rename",
   content: 
    "<cffile action = \"rename\" source = \"$1\" destination = \"$2\"${3:  mode = \"${4:[ ]}\" attributes = \"${5:[ ]}\"}>$0"},
 "cfargument" => 
  {scope: "text.html.cfm",
   name: "cfargument",
   content: 
    "<cfargument name=\"$1\"${2: type=\"${3:[ ]}\" required=\"${4:[ ]}\" default=\"${5:[ ]}\" displayname=\"${6:[ ]}\" hint=\"${7:[ ]}\"}>$0"},
 "listvaluecountnocase" => 
  {scope: "text.html.cfm",
   name: "listvaluecountnocase",
   content: 
    "ListValueCountNoCase(${1:list}, ${2:value}${3: [, delimiters ]})$0"},
 "iif" => 
  {scope: "text.html.cfm",
   name: "iif",
   content: 
    "IIf(${1:condition}, ${2:string_expression1}, ${3:string_expression2})$0"},
 "listchangedelims" => 
  {scope: "text.html.cfm",
   name: "listchangedelims",
   content: 
    "ListChangeDelims(${1:list}, ${2:new_delimiter}${3: [, delimiters ]})$0"},
 "arrayclear" => 
  {scope: "text.html.cfm",
   name: "arraycear",
   content: "ArrayClear(${1:array})$0"},
 "urldecode" => 
  {scope: "text.html.cfm",
   name: "urldecode",
   content: "URLDecode(${1:urlEncodedString}${2: [, charset]})$0"},
 "asin" => 
  {scope: "text.html.cfm", name: "asin", content: "ASin(${1:number})$0"},
 "arraysort" => 
  {scope: "text.html.cfm",
   name: "arraysort",
   content: "ArraySort(${1:array}, ${2:sort_type} ${3:[, sort_order ]})$0"},
 "listfind" => 
  {scope: "text.html.cfm",
   name: "listfind",
   content: "ListFind(${1:list}, ${2:value}${3: [, delimiters ]})$0"},
 "bitmaskset" => 
  {scope: "text.html.cfm",
   name: "bitmaskset",
   content: "BitMaskSet(${1:number}, ${2:mask}, ${3:start}, ${4:length})$0"},
 "lsnumberformat" => 
  {scope: "text.html.cfm",
   name: "lsnumberformat",
   content: "LSNumberFormat(${1:number}${2: [, mask ]})$0"},
 "listcontains" => 
  {scope: "text.html.cfm",
   name: "listcontains",
   content: "ListContains(${1:list}, ${2:substring}${3: [, delimiters ]})$0"},
 "minute" => 
  {scope: "text.html.cfm", name: "minute", content: "Minute(${1:date})$0"},
 "listqualify" => 
  {scope: "text.html.cfm",
   name: "listqualify",
   content: 
    "ListQualify(${1:list}, ${2:qualifier}${3: [, delimiters ]}${4: [, elements ]})$0"},
 "cftable" => 
  {scope: "text.html.cfm",
   name: "cftable",
   content: 
    "<cftable query = \"$1\"${2: maxRows = \"${3:[ ]}\" colSpacing = \"${4:[ ]}\" headerLines = \"${5:[ ]}\" startRow = \"${6:[ ]}\"}>\n\t$7\n</cftable>$0"},
 "createuuid" => 
  {scope: "text.html.cfm", name: "createuuid", content: "CreateUUID($1)$0"},
 "cfinvokeargument" => 
  {scope: "text.html.cfm",
   name: "cfinvokeargument",
   content: 
    "<cfinvokeargument name=\"$1\" value=\"$2\"${3: omit = \"${4:[ ]}\"}>$0"},
 "cfsilent" => 
  {scope: "text.html.cfm",
   name: "cfsilent",
   content: "<cfsilent>\n\t$1\n</cfsilent>$0"},
 "gettoken" => 
  {scope: "text.html.cfm",
   name: "gettoken",
   content: "GetToken(${1:string}, ${2:index} ${3:[, delimiters ]})$0"},
 "cftreeitem" => 
  {scope: "text.html.cfm",
   name: "cftreeitem",
   content: 
    "<cftreeitem  value = \"$1\"${2: display = \"${3:[ ]}\" parent = \"${4:[ ]}\" img = \"${5:[ ]}\" imgopen = \"${6:[ ]}\" href = \"${7:[ ]}\" target = \"${8:[ ]}\" query = \"${9:[ ]}\" queryAsRoot = \"${10:[ ]}\" expand = \"${11:[ ]}\"}>$0"},
 "gethttprequestdata" => 
  {scope: "text.html.cfm",
   name: "gethttprequestdata",
   content: "GetHttpRequestData(${1:})$0"},
 "structget" => 
  {scope: "text.html.cfm",
   name: "structget",
   content: "StructGet(${1:pathDesired})$0"},
 "binarydecode" => 
  {scope: "text.html.cfm",
   name: "binarydecode",
   content: "BinaryDecode(${1:string}, ${2:binaryencoding})$0"},
 "findnocase" => 
  {scope: "text.html.cfm",
   name: "findnocase",
   content: "FindNoCase(${1:substring}, ${2:string} ${3:[, start ]})$0"},
 "isk2serverabroker" => 
  {scope: "text.html.cfm",
   name: "isk2serverabroker",
   content: "IsK2ServerABroker(${1:})$0\t\t\t"},
 "dayofyear" => 
  {scope: "text.html.cfm",
   name: "dayofyear",
   content: "DayOfYear(${1:\"date\"})$0"},
 "queryaddrow" => 
  {scope: "text.html.cfm",
   name: "queryaddrow",
   content: "QueryAddRow(${1:query}${2: [,number]})$0"},
 "ucase" => 
  {scope: "text.html.cfm", name: "ucase", content: "UCase(${1:string})$0"},
 "getfilefrompath" => 
  {scope: "text.html.cfm",
   name: "getfilefrompath",
   content: "GetFileFromPath(${1:path})$0"},
 "sgn" => {scope: "text.html.cfm", name: "sgn", content: "Sgn(${1:number})$0"},
 "fileexists" => 
  {scope: "text.html.cfm",
   name: "fileexists",
   content: "FileExists(${1:absolute_path})$0"},
 "xmlelemnew" => 
  {scope: "text.html.cfm",
   name: "xmlelemnew",
   content: "XmlElemNew(${1:xmlObj}${2: [, namespace]}${3: [, childName]})$0"},
 "deleteclientvariable" => 
  {scope: "text.html.cfm",
   name: "deleteclientvariable",
   content: "DeleteClientVariable(${1:\"name\"})$0"},
 "lsiscurrency" => 
  {scope: "text.html.cfm",
   name: "lsiscurrency",
   content: "LSIsCurrency(${1:string})$0"},
 "isdate" => 
  {scope: "text.html.cfm", name: "isdate", content: "IsDate(${1:string})$0"},
 "encrypt" => 
  {scope: "text.html.cfm",
   name: "encrypt",
   content: 
    "Encrypt(${1:string}, ${2:key}${3: [, algorithm]}${4: [, encoding]}${5: [, IVorSalt]}${6: [, iterations]})$0"},
 "listfindnocase" => 
  {scope: "text.html.cfm",
   name: "listfindnocase",
   content: "ListFindNoCase(${1:list}, ${2:value}${3: [, delimiters ]})$0"},
 "structkeyarray" => 
  {scope: "text.html.cfm",
   name: "structkeyarray",
   content: "StructKeyArray(${1:structure})$0"},
 "week" => 
  {scope: "text.html.cfm", name: "week", content: "Week(${1:date})$0"},
 "getlocalhostip" => 
  {scope: "text.html.cfm",
   name: "getlocalhostip",
   content: "GetLocalHostIP(${1:})$0"},
 "directoryexists" => 
  {scope: "text.html.cfm",
   name: "directoryexists",
   content: "DirectoryExists(${1:absolute_path})$0"},
 "addsoaprequestheader" => 
  {scope: "text.html.cfm",
   name: "addsoaprequestheader",
   content: 
    "AddSOAPRequestHeader(${1:webservice}, ${2:namespace}, ${3:name}, ${4:value} ${5:[, mustunderstand]})$0"},
 "dollarformat" => 
  {scope: "text.html.cfm",
   name: "dollarformat",
   content: "DollarFormat(${1:number})$0"},
 "chr" => {scope: "text.html.cfm", name: "chr", content: "Chr(${1:number})$0"},
 "listappend" => 
  {scope: "text.html.cfm",
   name: "listappend",
   content: "ListAppend(${1:list}, ${2:value}${3: [, delimiters ]})$0"},
 "expandpath" => 
  {scope: "text.html.cfm",
   name: "expandpath",
   content: "Expandpath(${1:relative_path})$0"},
 "numberformat" => 
  {scope: "text.html.cfm",
   name: "numberformat",
   content: "NumberFormat(${1:number}${2: [, mask ]})$0"},
 "yesnoformat" => 
  {scope: "text.html.cfm",
   name: "yesnoformat",
   content: "YesNoFormat(${1:value})$0"},
 nil => 
  {scope: "text.html.cfm", name: "isDefined", content: "isDefined(\"$1\")$2"},
 "dateconvert" => 
  {scope: "text.html.cfm",
   name: "dateconvert",
   content: "DateConvert(${1:\"conversion-type\"}, ${2:\"date\"})$0"},
 "xmlchildpos" => 
  {scope: "text.html.cfm",
   name: "xmlchildpos",
   content: "XmlChildPos(${1:elem}, ${2:childName}, ${3:N})$0"},
 "tobinary" => 
  {scope: "text.html.cfm",
   name: "tobinary",
   content: "ToBinary(${1:string_in_Base64 or binary_value})$0"},
 "cfcatch" => 
  {scope: "text.html.cfm",
   name: "cfcatch",
   content: "<cfcatch type = \"$1\">\n\t$2\n</cfcatch>$0"},
 "replace" => 
  {scope: "text.html.cfm",
   name: "replace",
   content: 
    "Replace(${1:string}, ${2:substring1}, ${3:substring2}${4: [, scope]})$0"},
 "getencoding" => 
  {scope: "text.html.cfm",
   name: "getencoding",
   content: "GetEncoding(${1:scope_name})$0"},
 "insert" => 
  {scope: "text.html.cfm",
   name: "insert",
   content: "Insert(${1:substring}, ${2:string}, ${3:position})$0"},
 "year" => 
  {scope: "text.html.cfm", name: "year", content: "Year(${1:date})$0"},
 "cfselect" => 
  {scope: "text.html.cfm",
   name: "cfselect",
   content: 
    "<cfselect name = \"$1\"${2: label = \"${3:[ ]}\" style = \"${4:[ ]}\" size = \"${5:[ ]}\" required = \"${6:[ ]}\" message = \"${7:[ ]}\" onError = \"${8:[ ]}\" multiple = \"${9:[ ]}\" query = \"${10:[ ]}\" value = \"${11:[ ]}\" display = \"${12:[ ]}\" group = \"${13:[ ]}\" queryPosition = \"${14:[ ]}\" selected = \"${15:[ ]}\" onKeyUp = \"${16:[ ]}\" onKeyDown = \"${17:[ ]}\" onMouseUp = \"${18:[ ]}\" onMouseDown = \"${19:[ ]}\" onChange = \"${20:[ ]}\" onClick = \"${21:[ ]}\" enabled = \"${22:[ ]}\" visible = \"${23:[ ]}\" tooltip = \"${24:[ ]}\" height = \"${25:[ ]}\" width = \"${26:[ ]}\" editable=\"${27:[ ]}\"}>\n\t$28\n</cfselect>$0\n"},
 "listlast" => 
  {scope: "text.html.cfm",
   name: "listlast",
   content: "ListLast(${1:list}${2: [, delimiters]})$0"},
 "bitxor" => 
  {scope: "text.html.cfm",
   name: "bitxor",
   content: "BitXor(${1:number1}, ${2:number2})$0"},
 "listlen" => 
  {scope: "text.html.cfm",
   name: "listlen",
   content: "ListLen(${1:list}${2: [, delimiters ]})$0"},
 "cfloop" => 
  {scope: "text.html.cfm",
   name: "cfloop (date or time loop)",
   content: 
    "<cfloop from = \"${1:#createdate($2)#}\" to = \"${3:#createdate($4)#}\" index = \"${5:i}\"${6: step = \"${7:[ ]}\"}>\n\t$8\n</cfloop>$0\n\n"},
 "incrementvalue" => 
  {scope: "text.html.cfm",
   name: "incrementvalue",
   content: "IncrementValue(${1:number})$0"},
 "duplicate" => 
  {scope: "text.html.cfm",
   name: "duplicate",
   content: "Duplicate(${1:variable_name})$0"},
 "cftrace" => 
  {scope: "text.html.cfm",
   name: "cftrace",
   content: 
    "<cftrace${1: abort = \"${2:[ ]}\" category = \"${3:[ ]}\" inline = \"${4:[ ]}\" text = \"${5:[ ]}\" type = \"${6:[ ]}\" var = \"${7:[ ]}\"}>\n\t$8\n</cftrace>$0"},
 "log" => {scope: "text.html.cfm", name: "log", content: "Log(${1:number})$0"},
 "cflock" => 
  {scope: "text.html.cfm",
   name: "cflock",
   content: 
    "<cflock${1: timeout = \"${2:30}\" scope = \"${3:session}\" name = \"${4:[ ]}\"  throwOnTimeout = \"${5:no}\" type = \"${6:exclusive}\"}>\n\t$7\n</cflock>$0"},
 "xmlvalidate" => 
  {scope: "text.html.cfm",
   name: "xmlvalidate",
   content: "XmlValidate(${1:xmlDoc}${2: [, validator]})$0"},
 "lsparsecurrency" => 
  {scope: "text.html.cfm",
   name: "lsparsecurrency",
   content: "LSParseCurrency(${1:string})$0"},
 "sendgatewaymessage" => 
  {scope: "text.html.cfm",
   name: "sendgatewaymessage",
   content: "SendGatewayMessage(${1:gatewayID}, ${2:data})$0"},
 "de" => {scope: "text.html.cfm", name: "de", content: "DE(${1:string})$0"},
 "createdate" => 
  {scope: "text.html.cfm",
   name: "createdate",
   content: "CreateDate(${1:year}, ${2:month}, ${3:day})$0"},
 "structisempty" => 
  {scope: "text.html.cfm",
   name: "structisempty",
   content: "StructIsEmpty(${1:structure})$0"},
 "structfindvalue" => 
  {scope: "text.html.cfm",
   name: "structfindvalue",
   content: "StructFindValue(${1: top}, ${2:value}${3: [, scope]})$0"},
 "len" => 
  {scope: "text.html.cfm",
   name: "len",
   content: "Len(${1:string or binary object})$0"},
 "gettempdirectory" => 
  {scope: "text.html.cfm",
   name: "gettempdirectory",
   content: "GetTempDirectory(${1:})$0"},
 "xmlnew" => 
  {scope: "text.html.cfm",
   name: "xmlnew",
   content: "XmlNew(${1:[caseSensitive]})$0"},
 "toscript" => 
  {scope: "text.html.cfm",
   name: "toscript",
   content: 
    "ToScript(${1:cfvar}, ${2:javascriptvar}, ${3:outputformat}, ${4:ASFormat})$0"},
 "arrayavg" => 
  {scope: "text.html.cfm",
   name: "arrayavg",
   content: "ArrayAvg(${1:array})$0"},
 "gettempfile" => 
  {scope: "text.html.cfm",
   name: "gettempfile",
   content: "GetTempFile(${1:dir}, ${2:prefix})$0"},
 "parsedatetime" => 
  {scope: "text.html.cfm",
   name: "parsedatetime",
   content: "ParseDateTime(${1:date/time-string}${2: [, pop-conversion ]})$0"},
 "getsoapresponseheader" => 
  {scope: "text.html.cfm",
   name: "getsoapresponseheader",
   content: 
    "GetSOAPResponseHeader(${1:webservice}, ${2:namespace}, ${3:name} ${4:[, asXML]})$0"},
 "isobject" => 
  {scope: "text.html.cfm",
   name: "isobject",
   content: "IsObject(${1:value})$0"},
 "cfgridrow" => 
  {scope: "text.html.cfm",
   name: "cfgridrow",
   content: "<cfgridrow data = \"$1\">$0"},
 "getk2serverdoccountlimit" => 
  {scope: "text.html.cfm",
   name: "getk2serverdoccountlimit",
   content: "GetK2ServerDocCountLimit(${1:})$0"},
 "max" => 
  {scope: "text.html.cfm",
   name: "max",
   content: "Max(${1:number1}, ${2:number2})$0"},
 "bitand" => 
  {scope: "text.html.cfm",
   name: "bitand",
   content: "BitAnd(${1:number1}, ${2:number2})$0"},
 "arrayappend" => 
  {scope: "text.html.cfm",
   name: "arrayappend",
   content: "ArrayAppend(${1:array}, ${2:value})$0"},
 "binaryencode" => 
  {scope: "text.html.cfm",
   name: "binaryencode",
   content: "BinaryEncode(${1:binarydata}, ${2:encoding})$0"},
 "writeoutput" => 
  {scope: "text.html.cfm",
   name: "writeoutput",
   content: "WriteOutput(${1:string})$0"},
 "cfif" => 
  {scope: "text.html.cfm",
   name: "cfif else",
   content: "<cfif $1>\n\t$2\n<cfelse>\n\t$3\n</cfif>$0"},
 "rand" => 
  {scope: "text.html.cfm", name: "rand", content: "Rand(${1:[algorithm]})$0"},
 "cfquery" => 
  {scope: "text.html.cfm",
   name: "cfquery (update sql)",
   content: 
    "<cfquery name = \"$1\" datasource = \"$2\"${3: username = \"${4:[ ]}\" password = \"${5:[ ]}\"}>\n    update $6\n       set $7\n     where $8\n</cfquery>$0"},
 "bitnot" => 
  {scope: "text.html.cfm", name: "bitnot", content: "BitNot(${1:number})$0"},
 "randrange" => 
  {scope: "text.html.cfm",
   name: "randrange",
   content: "RandRange(${1:number1}, ${2:number2}${3: [, algorithm]})$0"},
 "charsetdecode" => 
  {scope: "text.html.cfm",
   name: "charsetdecode",
   content: "CharsetDecode(${1:string}, ${2:encoding})$0"},
 "getmetadata" => 
  {scope: "text.html.cfm",
   name: "getmetadata",
   content: "GetMetaData(${1:object})$0"},
 "rjustify" => 
  {scope: "text.html.cfm",
   name: "rjustify",
   content: "RJustify(${1:string}, ${2:length})$0"},
 "comparenocase" => 
  {scope: "text.html.cfm",
   name: "comparenocase",
   content: "CompareNoCase(${1:string1}, ${2:string2})$0"},
 "randomize" => 
  {scope: "text.html.cfm",
   name: "randomize",
   content: "Randomize(${1:number}${2: [, algorithm]})$0"},
 "setencoding" => 
  {scope: "text.html.cfm",
   name: "setencoding",
   content: "SetEncoding(${1:scope_name,charset})$0"},
 "cfabort" => 
  {scope: "text.html.cfm",
   name: "cfabort",
   content: "<cfabort showerror=\"$1\">$0"},
 "cfhttp" => 
  {scope: "text.html.cfm",
   name: "cfhttp",
   content: 
    "<cfhttp url = \"$1\"${2: port = \"${3:[ ]}\" method = \"${4:[ ]}\" proxyServer = \"${5:[ ]}\" proxyPort = \"${6:[ ]}\" proxyUser = \"${7:[ ]}\" proxyPassword = \"${8:[ ]}\" username = \"${9:[ ]}\" password = \"${10:[ ]}\" userAgent = \"${11:[ ]}\" charset = \"${12:[ ]}\" resolveURL = \"${13:[ ]}\" throwOnError = \"${14:[ ]}\" redirect = \"${15:[ ]}\" timeout = \"${16:[ ]}\" getAsBinary = \"${17:[ ]}\" multipart = \"${18:[ ]}\" path = \"${19:[ ]}\" file = \"${20:[ ]}\" name = \"${21:[ ]}\" columns = \"${22:[ ]}\" firstrowasheaders = \"${23:[ ]}\" delimiter = \"${24:[ ]}\" textQualifier = \"${25:[ ]}\" result = \"${26:[ ]}\"}>\n\t$27\n</cfhttp>$0"},
 "bitshln" => 
  {scope: "text.html.cfm",
   name: "bitshln",
   content: "BitSHLN(${1:number}, ${2:count})$0"},
 "structclear" => 
  {scope: "text.html.cfm",
   name: "structclear",
   content: "StructClear(${1:structure})$0"},
 "getbasetagdata" => 
  {scope: "text.html.cfm",
   name: "getbasetagdata",
   content: "GetBaseTagData(${1:tagname} ${2:[, instancenumber ]})$0"},
 "cfflush" => 
  {scope: "text.html.cfm",
   name: "cfflush",
   content: "<cfflush${1: interval = \"${2:[ ]}\"}>$0"},
 "reverse" => 
  {scope: "text.html.cfm", name: "reverse", content: "Reverse(${1:string})$0"},
 "cfcollection" => 
  {scope: "text.html.cfm",
   name: "cfcollection",
   content: 
    "<cfcollection action = \"$1\"${2: collection = \"${3:[ ]}\" path = \"${4:[ ]}\" language = \"${5:[ ]}\" name = \"${6:[ ]}\" categories = \"${7:[ ]}\" or \"${8:[ ]}\"}>$0"},
 "sin" => {scope: "text.html.cfm", name: "sin", content: "Sin(${1:number})$0"},
 "cfexit" => 
  {scope: "text.html.cfm",
   name: "cfexit",
   content: "<cfexit${1: method = \"${2:[ ]}\"}>$0"},
 "stripcr" => 
  {scope: "text.html.cfm", name: "stripcr", content: "StripCR(${1:string})$0"},
 "ljustify" => 
  {scope: "text.html.cfm",
   name: "ljustify",
   content: "LJustify(${1:string}, ${2:length})$0"},
 "cfgridupdate" => 
  {scope: "text.html.cfm",
   name: "cfgridupdate",
   content: 
    "<cfgridupdate grid = \"$1\" dataSource = \"$2\" tableName = \"$3\"${4: username = \"${5:[ ]}\" password = \"${6:[ ]}\" tableOwner = \"${7:[ ]}\" tableQualifier = \"${8:[ ]}\" keyOnly = \"${9:[ ]}\"}>$0"},
 "wrap" => 
  {scope: "text.html.cfm",
   name: "wrap",
   content: "Wrap(${1:string}, ${2:limit}${3: [, strip]})$0"},
 "cfxml" => 
  {scope: "text.html.cfm",
   name: "cfxml",
   content: "<cfxml variable=\"$1\"${2: caseSensitive=\"${3:[ ]}\"}>$0"},
 "cfdump" => 
  {scope: "text.html.cfm",
   name: "cfdump",
   content: 
    "<cfdump${1: var = \"${2:#variable#}\" expand = \"${3:[ ]}\" label = \"${4:[ ]}\" top = \"${5:[ ]}\"}>$0"},
 "cfdocument" => 
  {scope: "text.html.cfm",
   name: "cfdocument",
   content: 
    "<cfdocument format = \"$1\"${2: backgroundvisible = \"${3:[ ]}\" encryption = \"${4:[ ]}\" filename = \"${5:[ ]}\" fontembed = \"${6:[ ]}\" marginbottom = \"${7:[ ]}\" marginleft = \"${8:[ ]}\" marginright = \"${9:[ ]}\" margintop = \"${10:[ ]}\" mimetype = \"${11:[ ]}\" name = \"${12:[ ]}\" orientation = \"${13:[ ]}\" overwrite = \"${14:[ ]}\" ownerpassword = \"${15:[ ]}\" pageheight = \"${16:[ ]}\" pagetype = \"${17:[ ]}\" pagewidth = \"${18:[ ]}\" permissions = \"${19:[ ]}\" scale = \"${20:[ ]}\" src = \"${21:[ ]}\" srcfile = \"${22:[ ]}\" unit = \"${23:[ ]}\" userpassword = \"${24:[ ]}\"}>\n\t$25\n</cfdocument>$0\n\n"},
 "firstdayofmonth" => 
  {scope: "text.html.cfm",
   name: "firstdayofmonth",
   content: "FirstDayOfMonth(${1:date})$0"},
 "log10" => 
  {scope: "text.html.cfm", name: "log10", content: "Log10(${1:number})$0"},
 "lsparsedatetime" => 
  {scope: "text.html.cfm",
   name: "lsparsedatetime",
   content: "LSParseDateTime(${1:date/time-string})$0"},
 "cfhttpparam" => 
  {scope: "text.html.cfm",
   name: "cfhttpparam",
   content: 
    "<cfhttpparam type = \"$1\"${2: name = \"${3:[ ]}\" value = \"${4:[ ]}\" file = \"${5:[ ]}\" encoded = \"${6:[ ]}\" mimeType = \"${7:[ ]}\"}>$0"},
 "iswddx" => 
  {scope: "text.html.cfm", name: "iswddx", content: "IsWDDX(${1:value})$0"},
 "isbinary" => 
  {scope: "text.html.cfm",
   name: "isbinary",
   content: "IsBinary(${1:value})$0"},
 "cfntauthenticate" => 
  {scope: "text.html.cfm",
   name: "cfntauthenticate",
   content: 
    "<cfntauthenticate username=\"$1\" password=\"$2\" domain=\"$3\"${4: result=\"${5:[ ]}\" listGroups = \"${6:[ ]}\" throwOnError = \"${7:[ ]}\"}>$0"},
 "lsisnumeric" => 
  {scope: "text.html.cfm",
   name: "lsisnumeric",
   content: "LSIsNumeric(${1:string})$0"},
 "structcount" => 
  {scope: "text.html.cfm",
   name: "structcount",
   content: "StructCount(${1:structure})$0"},
 "now" => {scope: "text.html.cfm", name: "now", content: "Now(${1:})$0"},
 "isboolean" => 
  {scope: "text.html.cfm",
   name: "isboolean",
   content: "IsBoolean(${1:value})$0"},
 "cfprocparam" => 
  {scope: "text.html.cfm",
   name: "cfprocparam",
   content: 
    "<cfprocparam${1: type = \"${2:[ ]}\" variable = \"${3:required if type is out or inout}\" value = \"${4:required if type is in}\" CFSQLType = \"$5\" maxLength = \"${6:[ ]}\" scale = \"${7:[ ]}\" null = \"${8:[ ]}\"}>$0"},
 "isxmldoc" => 
  {scope: "text.html.cfm",
   name: "isxmldoc",
   content: "IsXmlDoc(${1:value})$0"},
 "monthasstring" => 
  {scope: "text.html.cfm",
   name: "monthasstring",
   content: "MonthAsString(${1:month_number})$0"},
 "lsdateformat" => 
  {scope: "text.html.cfm",
   name: "lsdateformat",
   content: "LSDateFormat(${1:date}${2: [, mask]})$0"},
 "gettickcount" => 
  {scope: "text.html.cfm",
   name: "gettickcount",
   content: "GetTickCount(${1:})$0"},
 "cfoutput" => 
  {scope: "text.html.cfm",
   name: "cfoutput (long)",
   content: 
    "<cfoutput${1: query = \"${2:[ ]}\" group = \"${3:[ ]}\" groupCaseSensitive = \"${4:[ ]}\" startRow = \"${5:[ ]}\" maxRows = \"${6:[ ]}\"}>\n\t$7\n</cfoutput>$0"},
 "cftree" => 
  {scope: "text.html.cfm",
   name: "cftree",
   content: 
    "<cftree \n\tname = \"$1\"${2:  \n\tformat=\"${3:[ ]}\"\n\trequired = \"${4:[ ]}\"\n\tdelimiter = \"${5:[ ]}\"\n\tcompletePath = \"${6:[ ]}\"\n\tappendKey = \"${7:[ ]}\"\n\thighlightHref = \"${8:[ ]}\"\n\tonValidate = \"${9:[ ]}\"\n\tmessage = \"${10:[ ]}\"\n\tonError = \"${11:[ ]}\"\n\tlookAndFeel = \"${12:[ ]}\"\n\tfont = \"${13:[ ]}\"\n\tfontSize = \"${14:[ ]}\"\n\titalic = \"${16:[ ]}\"\n\tbold = \"${17:[ ]}\"\n\theight = \"${18:[ ]}\"\n\twidth = \"${19:[ ]}\"\n\tvSpace = \"${20:[ ]}\"\n\thSpace = \"${21:[ ]}\"\n\talign = \"${22:[ ]}\"\n\tborder = \"${23:[ ]}\"\n\thScroll = \"${22:[ ]}\"\n\tvScroll = \"${24:[ ]}\"\n\tstyle= \"${25:[ ]}\"\n\tenabled = \"${26:[ ]}\"\n\tvisible = \"${27:[ ]}\"\n\ttooltip = \"${28:[ ]}\"\n\tonChange = \"${29:[ ]}\"\n\tnotSupported = \"${30:[ ]}\"\n\tonBlur = \"${31:[ ]}\"\n\tonFocus = \"${32:[ ]}\"}>\n\t$33\n</cftree>$0"},
 "cfform" => 
  {scope: "text.html.cfm",
   name: "cfform",
   content: 
    "<cfform${1: name = \"${2:[ ]}\" action = \"${3:[ ]}\" method = \"${4:post}\" format = \"${5:html}\" skin = \"${6:[ ]}\" style = \"${7:[ ]}\" preserveData = \"${8:[ ]}\" onSubmit = \"${9:[ ]}\" scriptSrc = \"${10:[ ]}\" codeBase = \"${11:[ ]}\" archive = \"${12:[ ]}\" onLoad = \"${13:[ ]}\" width = \"${14:[ ]}\" height = \"${15:[ ]}\" onError = \"${16:[ ]}\" wMode = \"${17:[ ]}\" accessible = \"${18:[ ]}\" preloader = \"${19:[ ]}\" timeout = \"${20:[ ]}\" class = \"${21:[ ]}\" enctype = \"${22:[ ]}\" id = \"${23:[ ]}\" onReset = \"${24:[ ]}\" target = \"${25:[ ]}\"}>\n\t$26\n</cfform>$0"},
 "isnumeric" => 
  {scope: "text.html.cfm",
   name: "isnumeric",
   content: "IsNumeric(${1:string})$0"},
 "cfpop" => 
  {scope: "text.html.cfm",
   name: "cfpop",
   content: 
    "<cfpop \n\tserver = \"$1\"${2:\n\tport = \"${3:[ ]}\"\n\tusername = \"${4:[ ]}\"\n\tpassword = \"${5:[ ]}\"\n\taction = \"${6:[ ]}\"\n\tname = \"${7:required if action is getall or getheaderonly}\"\n\tmessageNumber = \"${8:[ ]}\"\n\tuid = \"${9:[ ]}\" \n\tattachmentPath = \"${10:[ ]}\"\n\ttimeout = \"${11:[ ]}\"\n\tmaxRows = \"${12:[ ]}\"\n\tstartRow = \"${13:[ ]}\"\n\tgenerateUniqueFilenames = \"${14:[ ]}\"\n\tdebug = \"${15:[ ]}\"}>$0"},
 "cfcache" => 
  {scope: "text.html.cfm",
   name: "cfcache",
   content: 
    "<cfcache action = \"${2:[ ]}\" directory = \"${2:[ ]}\" timespan = \"${2:[ ]}\" expireURL = \"${2:[ ]}\" username = \"${2:[ ]}\" password = \"${2:[ ]}\" port = \"\" protocol = \"${2:[ ]}\">"},
 "dayofweekasstring" => 
  {scope: "text.html.cfm",
   name: "dayofweekasstring",
   content: "DayOfWeekAsString(${1:day_of_week})$0"},
 "cftimer" => 
  {scope: "text.html.cfm",
   name: "cftimer",
   content: 
    "<cftimer${1: label= \"${2:[ ]}\" type = \"${3:[ ]}\"}>\n\t$4\n</cftimer>$0"},
 "issoaprequest" => 
  {scope: "text.html.cfm",
   name: "issoaprequest",
   content: "IsSOAPRequest(${1:})$0"},
 "cfinvoke" => 
  {scope: "text.html.cfm",
   name: "cfinvoke",
   content: 
    "<cfinvoke component = \"$1\" method = \"$2\"${3: returnVariable = \"${4:[ ]}\" argumentCollection = \"${5:[ ]}\"}>$0"},
 "cfcontent" => 
  {scope: "text.html.cfm",
   name: "cfcontent",
   content: 
    "<cfcontent type = \"${1:[ ]}\" deleteFile = \"${2:[ ]}\" file = \"${3:[ ]}\" variable = \"${4:[ ]}\" reset = \"${5:[ ]}\">$0"},
 "ceiling" => 
  {scope: "text.html.cfm",
   name: "ceiling",
   content: "BitXor(${1:number1}, ${2:number2})$0"},
 "acos" => 
  {scope: "text.html.cfm", name: "acos", content: "ACos(${1:number})$0"},
 "structfind" => 
  {scope: "text.html.cfm",
   name: "structfind",
   content: "StructFind(${1:structure}, ${2:key})$0"},
 "asc" => {scope: "text.html.cfm", name: "asc", content: "Asc(${1:string})$0"},
 "isxmlelem" => 
  {scope: "text.html.cfm",
   name: "isxmlelem",
   content: "IsXmlElem(${1:value})$0"},
 "daysinmonth" => 
  {scope: "text.html.cfm",
   name: "daysinmonth",
   content: "DaysInMonth(${1:\"date\"})$0"},
 "cfstoredproc" => 
  {scope: "text.html.cfm",
   name: "cfstoredproc",
   content: 
    "<cfstoredproc procedure = \"$1\" dataSource = \"$2\"${3: username = \"${4:[ ]}\" password = \"${5:[ ]}\" blockFactor = \"${6:[ ]}\" debug = \"${7:[ ]}\" returnCode = \"${8:[ ]}\" result = \"${9:[ ]}\"}>$0"},
 "cfexecute" => 
  {scope: "text.html.cfm",
   name: "cfexecute",
   content: 
    "<cfexecute name = \"$1\"${2: arguments = \"${3:[ ]}\" outputFile = \"${4:[ ]}\" variable = \"${5:[ ]}\" timeout = \"${6:[ ]}\"}>\n\t$7\n</cfexecute>$0"},
 "cfmail" => 
  {scope: "text.html.cfm",
   name: "cfmail",
   content: 
    "<cfmail to=\"$1\" from=\"$2\" subject=\"$3\" server=\"$4\" type=\"${5:html}\">\n\t$6\n</cfmail>$0"},
 "structupdate" => 
  {scope: "text.html.cfm",
   name: "structupdate",
   content: "StructUpdate(${1:structure}, ${2:key}, ${3:value})$0"},
 "lsisdate" => 
  {scope: "text.html.cfm",
   name: "lsisdate",
   content: "LSIsDate(${1:string})$0"},
 "getlocale" => 
  {scope: "text.html.cfm", name: "getlocale", content: "GetLocale(${1:})$0"},
 "exp" => {scope: "text.html.cfm", name: "exp", content: "Exp(${1:number})$0"},
 "fix" => {scope: "text.html.cfm", name: "fix", content: "Fix(${1:number})$0"},
 "spanexcluding" => 
  {scope: "text.html.cfm",
   name: "spanexcluding",
   content: "SpanExcluding(${1:string}, ${2:set})$0"},
 "listrest" => 
  {scope: "text.html.cfm",
   name: "listrest",
   content: "ListRest(${1:list}${2: [, delimiters ]})$0"},
 "cfcomponent" => 
  {scope: "text.html.cfm",
   name: "cfcomponent",
   content: 
    "<cfcomponent${1: extends =\"${2:[ ]}\" output = \"${3:[ ]}\" style = \"${4:[ ]}\" namespace = \"${5:[ ]}\" serviceportname = \"${6:[ ]}\" porttypename = \"${7:[ ]}\" bindingname = \"${8:[ ]}\" wsdlfile = \"${9:[ ]}\" displayname = \"${10:[ ]}\" hint = \"${11:[ ]}\"}>\n\t$12\n</cfcomponent>$0"},
 "getdirectoryfrompath" => 
  {scope: "text.html.cfm",
   name: "getdirectoryfrompath",
   content: "GetDirectoryFromPath(${1:path})$0"},
 "bitshrn" => 
  {scope: "text.html.cfm",
   name: "bitshrn",
   content: "BitSHRN(${1:number}, ${2:count})$0"},
 "cfformitem" => 
  {scope: "text.html.cfm",
   name: "cfformitem",
   content: 
    "<cfformitem type = \"$1\"${2: style = \"${3:[ ]}\" width = \"${4:[ ]}\" height = \"${5:[ ]}\" visible = \"${6:[ ]}\" enabled = \"${7:[ ]}\" tooltip = \"${8:[ ]}\" bind = \"${9:[ ]}\"}>\n\t$10\n</cfformitem>$0"},
 "removechars" => 
  {scope: "text.html.cfm",
   name: "removechars",
   content: "RemoveChars(${1:string}, ${2:start}, ${3:count})$0"},
 "isdefined" => 
  {scope: "text.html.cfm",
   name: "isdefined",
   content: "IsDefined(${1:\"variable_name\"})$0"},
 "isk2serverdoccountexceeded" => 
  {scope: "text.html.cfm",
   name: "isk2serverdoccountexceeded",
   content: "IsK2ServerDocCountExceeded(${1:})$0\t\t\t\t"},
 "cfsearch" => 
  {scope: "text.html.cfm",
   name: "cfsearch",
   content: 
    "<cfsearch \n\tname = \"$1\"\n\tcollection = \"$2\"${3:\n\tcategory = \"${4:[ ]}\"\n\tcategoryTree = \"${5:[ ]}\"\n\tstatus = \"${6:[ ]}\"\n\ttype = \"${7:[ ]}\"\n\tcriteria = \"${8:[ ]}\"\n\tmaxRows = \"${9:[ ]}\"\n\tstartRow = \"${10:[ ]}\"\n\tsuggestions = \"${11:[ ]}\"\n\tcontextPassages = \"${12:[ ]}\"\n\tcontextBytes = \"${13:[ ]}\"\n\tcontextHighlightBegin = \"${14:[ ]}\"\n\tcontextHighlightEnd = \"${15:[ ]}\"\n\tpreviousCriteria = \"${16:[ ]}\"\n\tlanguage = \"${17:[ ]}\"}>$0\n\n"},
 "cfcol" => 
  {scope: "text.html.cfm",
   name: "cfcol",
   content: 
    "<cfcol header = \"$1\" text = \"$2\"${3: width = \"${4:[ ]}\" align = \"${5:[ ]}\"}>$0\n\n"},
 "listprepend" => 
  {scope: "text.html.cfm",
   name: "listprepend",
   content: "ListPrepend(${1:list}, ${2:value}${3: [, delimiters ]})$0"},
 "cflocation" => 
  {scope: "text.html.cfm",
   name: "cflocation",
   content: "<cflocation url = \"$1\">$0"},
 "tobase64" => 
  {scope: "text.html.cfm",
   name: "tobase64",
   content: "ToBase64(${1:string or binary_object}${2: [, encoding]})$0"},
 "decryptbinary" => 
  {scope: "text.html.cfm",
   name: "decryptbinary",
   content: 
    "DecryptBinary(${1:bytes}, ${2:key}, ${3:[, algorithm]} ${4:[, IVorSalt]} ${5:[, iterations]})$0"},
 "cffunction" => 
  {scope: "text.html.cfm",
   name: "cffunction",
   content: 
    "<cffunction name = \"$1\"${2: returnType = \"${3:[ ]}\" roles = \"${4:[ ]}\" access = \"${5:[ ]}\" description = \"${6:[ ]}\" = \"${7:[ ]}\" displayName = \"${8:[ ]}\" hint = \"${9:[ ]}\"}>\n\t$10\n</cffunction>$0"},
 "rtrim" => 
  {scope: "text.html.cfm", name: "rtrim", content: "RTrim(${1:string})$0"},
 "listinsertat" => 
  {scope: "text.html.cfm",
   name: "listinsertat",
   content: 
    "ListInsertAt(${1:list}, ${2:position}, ${3:value}${4: [, delimiters]})$0"},
 "cftransaction" => 
  {scope: "text.html.cfm",
   name: "cftransaction",
   content: 
    "<cftransaction${1: action = \"${2:[ ]}\" isolation = \"${3:[ ]}\"}>\n\t$4\n</cftransaction>$0"},
 "charsetencode" => 
  {scope: "text.html.cfm",
   name: "charsetencode",
   content: "CharsetEncode(${1:binaryobject}, ${2:encoding})$0"},
 "lstimeformat" => 
  {scope: "text.html.cfm",
   name: "lstimeformat",
   content: "LSTimeFormat(${1:time}${2: [, mask ]})$0"},
 "cfapplet" => 
  {scope: "text.html.cfm",
   name: "cfapplet",
   content: 
    "<cfapplet appletSource = \"$1\" name = \"$2\"${3: height = \"${4:[ ]}\" width = \"${5:[ ]}\" vSpace = \"${6:[ ]}\" hSpace = \"${7:[ ]}\" align = \"${8:[ ]}\" notSupported = \"${9:[ ]}\" param_1 = \"${10:[ ]}\" param_2 = \"${11:[ ]}\" param_n = \"${12:[ ]}\"}>$0\t"},
 "jsstringformat" => 
  {scope: "text.html.cfm",
   name: "jsstringformat",
   content: "JSStringFormat(${1:string})$0"},
 "arraymin" => 
  {scope: "text.html.cfm",
   name: "arraymin",
   content: "ArrayMin(${1:array})$0"},
 "isnumericdate" => 
  {scope: "text.html.cfm",
   name: "isnumericdate",
   content: "IsNumericDate(${1:number})$0"},
 "sqr" => {scope: "text.html.cfm", name: "sqr", content: "Sqr(${1:number})$0"},
 "getauthuser" => 
  {scope: "text.html.cfm",
   name: "getauthuser",
   content: "GetAuthUser(${1:})$0"},
 "rereplacenocase" => 
  {scope: "text.html.cfm",
   name: "rereplacenocase",
   content: 
    "REReplaceNoCase(${1:string}, ${2:reg_expression}, ${3:substring}${4: [, scope]})$0"},
 "listvaluecount" => 
  {scope: "text.html.cfm",
   name: "listvaluecount",
   content: "ListValueCount(${1:list}, ${2:value}${3: [, delimiters ]})$0"},
 "getpagecontext" => 
  {scope: "text.html.cfm",
   name: "getpagecontext",
   content: "GetPageContext(${1:})$0"},
 "htmleditformat" => 
  {scope: "text.html.cfm",
   name: "htmleditformat",
   content: "HTMLEditFormat(${1:string} ${2:[, version ]})$0"},
 "cfswitch" => 
  {scope: "text.html.cfm",
   name: "cfswitch",
   content: 
    "<cfswitch expression=\"$1\">\n\t<cfcase value=\"$2\">$3</cfcase>\n\t<cfdefaultcase>$4</cfdefaultcase>\n</cfswitch>$0"},
 "cfreportparam" => 
  {scope: "text.html.cfm",
   name: "cfreportparam",
   content: "<cfreportparam name = \"$1\" value = \"$2\">$0\n\n"},
 "getsoaprequest" => 
  {scope: "text.html.cfm",
   name: "getsoaprequest",
   content: "GetSOAPRequest(${1:})$0"},
 "getmetricdata" => 
  {scope: "text.html.cfm",
   name: "getmetricdata",
   content: "GetMetricData(${1:mode})$0"},
 "urlencodedformat" => 
  {scope: "text.html.cfm",
   name: "urlencodedformat",
   content: "URLEncodedFormat(${1:string}${2: [, charset]})$0"},
 "preservesinglequotes" => 
  {scope: "text.html.cfm",
   name: "preservesinglequotes",
   content: "PreserveSingleQuotes(${1:variable})$0"},
 "month" => 
  {scope: "text.html.cfm", name: "month", content: "Month(${1:date})$0"},
 "structinsert" => 
  {scope: "text.html.cfm",
   name: "structinsert",
   content: 
    "StructInsert(${1:structure}, ${2:key}, ${3:value}${4: [, allowoverwrite]})$0"},
 "xmlgetnodetype" => 
  {scope: "text.html.cfm",
   name: "xmlgetnodetype",
   content: "XmlGetNodeType(${1:xmlNode})$0"},
 "valuelist" => 
  {scope: "text.html.cfm",
   name: "valuelist",
   content: "ValueList(${1:query.column}${2: [, delimiter]})$0"},
 "arrayisempty" => 
  {scope: "text.html.cfm",
   name: "arrayisempty",
   content: "ArrayIsEmpty(${1:array})$0"},
 "cfobjectcache" => 
  {scope: "text.html.cfm",
   name: "cfobjectcache",
   content: "<cfobjectcache action = \"clear\">$0"},
 "listsort" => 
  {scope: "text.html.cfm",
   name: "listsort",
   content: 
    "ListSort(${1:list}, ${2:sort_type}${3: [, sort_order]}${4:[, delimiters]})$0"},
 "cfqueryparam" => 
  {scope: "text.html.cfm",
   name: "cfqueryparam",
   content: 
    "<cfqueryparam value = \"$1\"${2: CFSQLType = \"${3:[ ]}\" maxLength = \"${4:[ ]}\" scale = \"${5:[ ]}\" null = \"${6:[ ]}\" list = \"${7:[ ]}\" separator = \"${8:[ ]}\"}>$0"},
 "createodbcdate" => 
  {scope: "text.html.cfm",
   name: "createodbcdate",
   content: "CreateODBCDate(${1:date})$0"},
 "mid" => 
  {scope: "text.html.cfm",
   name: "mid",
   content: "Mid(${1:string}, ${2:start}, ${3:count})$0"},
 "replacelist" => 
  {scope: "text.html.cfm",
   name: "replacelist",
   content: "ReplaceList(${1:string}, ${2:list1}, ${3:list2})$0"},
 "arrayinsertat" => 
  {scope: "text.html.cfm",
   name: "arrayinsertat",
   content: "ArrayInsertAt(${1:array}, ${2:position}, ${3:value})$0"},
 "find" => 
  {scope: "text.html.cfm",
   name: "find",
   content: "Find(${1:substring}, ${2:string} ${3:[, start ]})$0"},
 "cfdocumentitem" => 
  {scope: "text.html.cfm",
   name: "cfdocumentitem",
   content: "<cfdocumentitem type = \"$1\">\n\t$2\n</cfdocumentitem>$0"},
 "cfslider" => 
  {scope: "text.html.cfm",
   name: "cfslider",
   content: 
    "<cfslider \n\tname = \"$1\"${2: \n\tlabel = \"${3:[ ]}\"\n\trange = \"${4:[ ]}\"\n\tscale = \"${5:[ ]}\"\n\tvalue = \"${6:[ ]}\"\n\tonValidate = \"${7:[ ]}\"\n\tmessage = \"${8:[ ]}\"\n\tonError = \"${9:[ ]}\"\n\theight = \"${10:[ ]}\"\n\twidth = \"${11:[ ]}\"\n\tvSpace = \"${12:[ ]}\"\n\thSpace = \"${13:[ ]}\"\n\talign = \"${14:[ ]}\"\n\tlookAndFeel = \"${15:[ ]}\"\n\tvertical = \"${16:[ ]}\"\n\tbgColor = \"${17:[ ]}\"\n\ttextColor = \"${18:[ ]}\"\n\tfont = \"${19:[ ]}\"\n\tfontSize = \"${20:[ ]}\"\n\titalic = \"${21:[ ]}\"\n\tbold = \"${22:[ ]}\"\n\tnotSupported = \"${23:[ ]}\"}>$0\n\n"},
 "xmlparse" => 
  {scope: "text.html.cfm",
   name: "xmlparse",
   content: 
    "XmlParse(${1:xmlText}${2: [, caseSensitive ]}${3: [, validator]})$0"},
 "gethttptimestring" => 
  {scope: "text.html.cfm",
   name: "gethttptimestring",
   content: "GetHttpTimeString(${1:date_time_object})$0"},
 "cfchart" => 
  {scope: "text.html.cfm",
   name: "cfchart",
   content: 
    "<cfchart\n\tname = \"$1\"${2:\n\tbackgroundColor = \"${3:[ ]}\"\n\tchartHeight = \"${4:[ ]}\"\n\tchartWidth = \"${5:[ ]}\"\n\tdataBackgroundColor = \"${6:[ ]}\"\n\tfont = \"${7:[ ]}\"\n\tfontBold = \"${8:[ ]}\"\n\tfontItalic = \"${9:[ ]}\"\n\tfontSize = \"${10:[ ]}\"\n\tforegroundColor = \"${11:[ ]}\"\n\tformat = \"${12:[ ]}\"\n\tgridlines = \"${13:[ ]}\"\n\tlabelFormat = \"${14:[ ]}\"\n\tmarkerSize = \"${15:[ ]}\"\n\tpieSliceStyle = \"${16:[ ]}\"\n\tscaleFrom = \"${17:[ ]}\"\n\tscaleTo = \"${18:[ ]}\"\n\tseriesPlacement = \"${19:[ ]}\"\n\tshow3D = \"${20:[ ]}\"\n\tshowBorder = \"${21:[ ]}\"\n\tshowLegend = \"${22:[ ]}\"\n\tshowMarkers = \"${23:[ ]}\"\n\tshowXGridlines = \"${24:[ ]}\"\n\tshowYGridlines = \"${25:[ ]}\"\n\tsortXAxis = \"${26:[ ]}\"\n\ttipBGColor = \"${27:[ ]}\"\n\ttipStyle = \"${28:[ ]}\"\n\ttitle = \"${29:[ ]}\"\n\turl = \"${30:[ ]}\"\n\txAxisTitle = \"${31:[ ]}\"\n\txAxisType = \"${32:[ ]}\"\n\txOffset = \"${33:[ ]}\"\n\tyAxisTitle = \"${34:[ ]}\"\n\tyAxisType = \"${35:[ ]}\"\n\tyOffset = \"${36:[ ]}\"}>\n</cfchart>$0"},
 "issimplevalue" => 
  {scope: "text.html.cfm",
   name: "issimplevalue",
   content: "IsSimpleValue(${1:value})$0"},
 "getcurrenttemplatepath" => 
  {scope: "text.html.cfm",
   name: "getcurrenttemplatepath",
   content: "GetCurrentTemplatePath(${1:})$0"},
 "isleapyear" => 
  {scope: "text.html.cfm",
   name: "isleapyear",
   content: "IsLeapYear(${1:year})$0"},
 "tostring" => 
  {scope: "text.html.cfm",
   name: "tostring",
   content: "ToString(${1:value}${2: [, encoding]})$0"},
 "isuserinrole" => 
  {scope: "text.html.cfm",
   name: "isuserinrole",
   content: "IsUserInRole(${1:\"role_name\"})$0"},
 "cfthrow" => 
  {scope: "text.html.cfm",
   name: "cfthrow",
   content: 
    "<cfthrow${1: type = \"${2:[ ]}\" message = \"${3:[ ]}\" detail = \"${4:[ ]} \" errorCode = \"${5:[ ]} \" extendedInfo = \"${6:[ ]}\" object = \"${7:[ ]}\"}>$0"},
 "arrayswap" => 
  {scope: "text.html.cfm",
   name: "arrayswap",
   content: "ArraySwap(${1:array}, ${2:position1}, ${3:position2})$0"},
 "gettimezoneinfo" => 
  {scope: "text.html.cfm",
   name: "gettimezoneinfo",
   content: "GetTimeZoneInfo(${1:})$0"},
 "datecompare" => 
  {scope: "text.html.cfm",
   name: "datecompare",
   content: 
    "DateCompare(${1:\"date1\"}, ${2:\"date2\"} ${3:[, \"datePart\"]})$0"},
 "getlocaledisplayname" => 
  {scope: "text.html.cfm",
   name: "getlocaledisplayname",
   content: "GetLocaleDisplayName(${1:[locale]}${2: [, inLocale]})$0"},
 "structdelete" => 
  {scope: "text.html.cfm",
   name: "structdelete",
   content: 
    "StructDelete(${1:structure}, ${2:key}${3: [, indicatenotexisting]})$0"},
 "cfchartseries" => 
  {scope: "text.html.cfm",
   name: "cfchartseries",
   content: 
    "<cfchartseries type=\"$1\"${2: colorlist = \"${3:[ ]}\" itemColumn=\"${4:[ ]}\" markerStyle=\"${5:[ ]}\" paintStyle=\"${6:[ ]}\" query=\"${7:[ ]}\" seriesColor=\"${8:[ ]}\" seriesLabel=\"${9:[ ]}\" valueColumn=\"${10:[ ]}\" dataLabelStyle=\"${11:[ ]}\"}>\n\t$12\n</cfchartseries>$0"},
 "cfcalendar" => 
  {scope: "text.html.cfm",
   name: "cfcalendar",
   content: 
    "<cfcalendar name = \"$1\"${2: height = \"${3:[ ]}\" width = \"${4:[ ]}\" selectedDate = \"${5:[ ]}\" startRange = \"${6:[ ]}\" endRange = \"${7:[ ]}\" disabled = \"${8:[ ]}\" mask = \"${9:[ ]}\" dayNames = \"${10:[ ]}\" monthNames = \"${11:[ ]}\" style=\"${12:[ ]}\" enabled = \"${13:[ ]}\" visible = \"${14:[ ]}\" tooltip = \"${15:[ ]}\" onChange = \"${16:[ ]}\" onBlur = \"${17:[ ]}\" onFocus = \"${18:[ ]}\"}>$0"},
 "cfsavecontent" => 
  {scope: "text.html.cfm",
   name: "cfsavecontent",
   content: "<cfsavecontent variable = \"$1\">\n\t$2\n</cfsavecontent>$0"},
 "createtime" => 
  {scope: "text.html.cfm",
   name: "createtime",
   content: "CreateTime(${1:hour}, ${2:minute}, ${3:second})$0"},
 "atn" => {scope: "text.html.cfm", name: "atn", content: "Atn(${1:number})$0"},
 "round" => 
  {scope: "text.html.cfm", name: "round", content: "Round(${1:number})$0"},
 "dateformat" => 
  {scope: "text.html.cfm",
   name: "dateformat",
   content: "DateFormat(${1:\"date\"} ${2:[, \"mask\"]})$0"},
 "listsetat" => 
  {scope: "text.html.cfm",
   name: "listsetat",
   content: 
    "ListSetAt(${1:list}, ${2:position}, ${3:value}${4: [, delimiters]})$0"},
 "lseurocurrencyformat" => 
  {scope: "text.html.cfm",
   name: "lseurocurrencyformat",
   content: "LSEuroCurrencyFormat(${1:currency-number}${2: [, type]})$0"},
 "cfgrid" => 
  {scope: "text.html.cfm",
   name: "cfgrid",
   content: 
    "<cfgrid name = \"$1\"${2: format = \"${3:[ ]}\" height = \"${4:[ ]}\" width = \"${5:[ ]}\" query = \"${6:[ ]}\" selectMode = \"${7:[ ]}\" insert = \"${8:[ ]}\" delete = \"${9:[ ]}\" font = \"${10:[ ]}\" fontSize = \"${11:[ ]}\" italic = \"${12:[ ]}\" bold = \"${13:[ ]}\" textColor = \"${14:[ ]}\" gridLines = \"${15:[ ]}\" rowHeight = \"${16:[ ]}\" colHeaders = \"${17:[ ]}\" colHeaderFont = \"${18:[ ]}\" colHeaderFontSize = \"${19:[ ]}\" colHeaderItalic = \"${20:[ ]}\" colHeaderBold = \"${21:[ ]}\" colHeaderTextColor = \"${22:[ ]}\" bgColor = \"${23:[ ]}\" maxRows = \"${24:[ ]}\" style= \"${25:[ ]}\" enabled = \"${26:[ ]}\" visible = \"${27:[ ]}\" toolTip = \"${28:[ ]}\" onChange = \"${29:[ ]}\" autoWidth = \"${30:[ ]}\" vSpace = \"${31:[ ]}\" hSpace = \"${32:[ ]}\" align = \"${33:[ ]}\" sort = \"${34:[ ]}\" href = \"${35:[ ]}\" hrefKey = \"${36:[ ]}\" target = \"${37:[ ]}\" appendKey = \"${38:[ ]}\" highlightHref = \"${39:[ ]}\" onValidate = \"${40:[ ]}\" onError = \"${41:[ ]}\" gridDataAlign = \"${42:[ ]}\" rowHeaders = \"${43:[ ]}\" rowHeaderAlign = \"${44:[ ]}\" rowHeaderFont = \"${45:[ ]}\" rowHeaderFontSize = \"${46:[ ]}\" rowHeaderItalic = \"${47:[ ]}\" rowHeaderBold = \"${48:[ ]}\" rowHeaderTextColor = \"${49:[ ]}\" colHeaderAlign = \"${50:[ ]}\" selectColor = \"${51:[ ]}\" notSupported = \"${52:[ ]}\" pictureBar = \"${53:[ ]}\" insertButton = \"${54:[ ]}\" deleteButton = \"${55:[ ]}\" sortAscendingButton = \"${56:[ ]}\" sortDescendingButton = \"${57:[ ]}\" onBlur = \"${58:[ ]}\" onFocus = \"${59:[ ]}\"}>\n\t$60\n</cfgrid>$0"},
 "getk2serverdoccount" => 
  {scope: "text.html.cfm",
   name: "getk2serverdoccount",
   content: "GetK2ServerDocCount(${1:})$0"},
 "tan" => {scope: "text.html.cfm", name: "tan", content: "Tan(${1:number})$0"},
 "dateadd" => 
  {scope: "text.html.cfm",
   name: "dateadd",
   content: "DateAdd(${1:\"datepart\"}, ${2:number}, ${3:\"date\"})$0"},
 "cos" => {scope: "text.html.cfm", name: "cos", content: "Cos(${1:number})$0"},
 "cftextarea" => 
  {scope: "text.html.cfm",
   name: "cftextarea",
   content: 
    "<cftextarea name = \"$1\"${2: label = \"${3:[ ]}\" style = \"${4:[ ]}\" required = \"${5:[ ]}\" validate = \"${6:[ ]}\" validateAt= \"${7:[ ]}\" message = \"${8:[ ]}\" range = \"${9:[ ]}\" maxlength = \"${10:[ ]}\" pattern = \"${11:[ ]}\" onValidate = \"${12:[ ]}\" onError = \"${13:[ ]}\" disabled = \"${14:[ ]}\" value = \"${15:[ ]}\" bind = \"${16:[ ]}\" onKeyUp = \"${17:[ ]}\" onKeyDown = \"${18:[ ]}\" onMouseUp = \"${19:[ ]}\" onMouseDown = \"${20:[ ]}\" onChange = \"${21:[ ]}\" onClick = \"${22:[ ]}\" enabled = \"${23:[ ]}\" visible = \"${24:[ ]}\" tooltip = \"${25:[ ]}\" height = \"${26:[ ]}\" width = \"${27:[ ]}\" html = \"${28:[ ]}\"}>\n\t$29\n</cftextarea>$0"},
 "cfgridcolumn" => 
  {scope: "text.html.cfm",
   name: "cfgridcolumn",
   content: 
    "<cfgridcolumn name = \"$1\"${2: header = \"${3:[ ]}\" width = \"${4:[ ]}\" type = \"${5:[ ]}\" display = \"${6:[ ]}\" select = \"${7:[ ]}\" font = \"${8:[ ]}\" fontSize = \"${9:[ ]}\" italic = \"${10:[ ]}\" bold = \"${11:[ ]}\" textColor = \"${12:[ ]}\" bgColor = \"${13:[ ]}\" dataAlign = \"${14:[ ]}\" mask= \"${15:[ ]}\" href = \"${16:[ ]}\" hrefKey = \"${17:[ ]}\" target = \"${18:[ ]}\" headerFont = \"${19:[ ]}\" headerFontSize = \"${20:[ ]}\" headerItalic = \"${21:[ ]}\" headerBold = \"${22:[ ]}\" headerTextColor = \"${23:[ ]}\" headerAlign = \"${24:[ ]}\" numberFormat = \"${25:[ ]}\" values = \"${26:[ ]}\" valuesDisplay = \"${27:[ ]}\" valuesDelimiter = \"${28:[ ]}\"}>$0\n\n"},
 "structkeylist" => 
  {scope: "text.html.cfm",
   name: "structkeylist",
   content: "StructKeyList(${1:structure}${2: [, delimiter]})$0"},
 "islocalhost" => 
  {scope: "text.html.cfm",
   name: "islocalhost",
   content: "IsLocalHost(${1:ipaddress})$0"},
 "cfprocessingdirective" => 
  {scope: "text.html.cfm",
   name: "cfprocessingdirective",
   content: 
    "<cfprocessingdirective suppressWhiteSpace = \"${1:yes or no}\"${2: pageEncoding = \"${3:[ ]}\"}>\n\t$4\n</cfprocessingdirective>$0"},
 "cjustify" => 
  {scope: "text.html.cfm",
   name: "cjustify",
   content: "Cjustify(${1:string}, ${2:length})$0"},
 "val" => {scope: "text.html.cfm", name: "val", content: "Val(${1:string})$0"},
 "lsparsenumber" => 
  {scope: "text.html.cfm",
   name: "lsparsenumber",
   content: "LSParseNumber(${1:string})$0"},
 "inputbasen" => 
  {scope: "text.html.cfm",
   name: "inputbasen",
   content: "InputBaseN(${1:string}, ${2:radix})$0"},
 "quarter" => 
  {scope: "text.html.cfm", name: "quarter", content: "Quarter(${1:date})$0"},
 "javacast" => 
  {scope: "text.html.cfm",
   name: "javacast",
   content: "JavaCast(${1:type}, ${2:variable})$0"},
 "getcontextroot" => 
  {scope: "text.html.cfm",
   name: "getcontextroot",
   content: "GetContextRoot(${1:})$0"},
 "abs" => {scope: "text.html.cfm", name: "abs", content: "Abs(${1:number})$0"},
 "arrayset" => 
  {scope: "text.html.cfm",
   name: "arrayset",
   content: 
    "ArraySet(${1:array}, ${2:start_pos}, ${3:end_pos}, ${4:value})$0"},
 "structcopy" => 
  {scope: "text.html.cfm",
   name: "structcopy",
   content: "StructCopy(${1:structure})$0"},
 "cfmailparam" => 
  {scope: "text.html.cfm",
   name: "cfmailparam",
   content: 
    "<cfmailparam file = \"${1:[ ]}\" type =\"${2:[ ]}\" contentID = \"${3:[ ]}\" disposition = \"${4:[ ]}\">$5"},
 "cfdirectory" => 
  {scope: "text.html.cfm",
   name: "cfdirectory",
   content: 
    "<cfdirectory directory = \"$1\" action = \"${2:[ ]}\" name = \"${3:[ ]}\" filter = \"${4:[ ]}\" mode = \"${5:[ ]}\" sort = \"${6:[ ]}\" newDirectory = \"${7:[ ]}\" recurse = \"${8:[ ]}\">$0"},
 "spanincluding" => 
  {scope: "text.html.cfm",
   name: "spanincluding",
   content: "SpanIncluding(${1:string}, ${2:set})$0"},
 "datepart" => 
  {scope: "text.html.cfm",
   name: "datepart",
   content: "DatePart(${1:\"datepart\"}, ${2:\"date\"})$0"},
 "arrayresize" => 
  {scope: "text.html.cfm",
   name: "arrayresize",
   content: "ArrayResize(${1:array}, ${2:minimum_size})$0"},
 "cfupdate" => 
  {scope: "text.html.cfm",
   name: "cfupdate",
   content: 
    "<cfupdate dataSource = \"$1\" tableName = \"$2\"${3: tableOwner = \"${4:[ ]}\" tableQualifier = \"${5:[ ]}\" username = \"${6:[ ]}\" password = \"${7:[ ]}\" formFields = \"${8:[ ]}\"}>$0"},
 "htmlcodeformat" => 
  {scope: "text.html.cfm",
   name: "htmlcodeformat",
   content: "HTMLCodeFormat(${1:string} ${2:[, version ]})$0"},
 "isquery" => 
  {scope: "text.html.cfm", name: "isquery", content: "IsQuery(${1:value})$0"},
 "isxml" => 
  {scope: "text.html.cfm", name: "isxml", content: "IsXML(${1:value})$0"},
 "formatbasen" => 
  {scope: "text.html.cfm",
   name: "formatbasen",
   content: "FormatBaseN(${1:number}, ${2:radix})$0"},
 "timeformat" => 
  {scope: "text.html.cfm",
   name: "timeformat",
   content: "TimeFormat(${1:time}${2: [, mask]})$0"},
 "ltrim" => 
  {scope: "text.html.cfm", name: "ltrim", content: "LTrim(${1:string})$0"},
 "cfapplication" => 
  {scope: "text.html.cfm",
   name: "cfapplication",
   content: 
    "<cfapplication\n\tname = \"$1\"${2: \n\tloginStorage = \"$3\"\n\tclientManagement = \"$4\"\n\tclientStorage = \"$5\" \n\tsetClientCookies = \"$6\"\n\tsessionManagement = \"$7\"\n\tsessionTimeout = #CreateTimeSpan(${8:days}, ${9:hours}, ${10:minutes}, ${11:seconds})#\n\tapplicationTimeout =  #CreateTimeSpan(${12:days}, ${13:hours}, ${14:minutes}, ${15:seconds})#\n\tsetDomainCookies = \"$16\"}>$0"},
 "day" => 
  {scope: "text.html.cfm", name: "day", content: "Day(${1:\"date\"})$0"},
 "isxmlroot" => 
  {scope: "text.html.cfm",
   name: "isxmlroot",
   content: "IsXmlRoot(${1:value})$0"},
 "repeatstring" => 
  {scope: "text.html.cfm",
   name: "repeatstring",
   content: "RepeatString(${1:string}, ${2:count})$0"},
 "cfbreak" => {scope: "text.html.cfm", name: "cfbreak", content: "<cfbreak>"},
 "cfschedule" => 
  {scope: "text.html.cfm",
   name: "cfschedule",
   content: 
    "<cfschedule\n\taction = \"$1\"\n\ttask = \"$2\"${3:\n\toperation = \"${4:[required if action equals update]}\"\n\tfile = \"${5:[required if publish equals yes]}\"\n\tpath = \"${6:[required if publish equals yes]}\"\n\tstartDate = \"${7:[required if action equals update]}\"\n\tstartTime = \"${8:[required if action equals update]}\"\n\turl = \"${9:[required if action equals update]}\"\n\tport = \"${10:[ ]}\"\n\tpublish = \"${11:[ ]}\"\n\tendDate = \"${12:[ ]}\"\n\tendTime = \"${13:[ ]}\"\n\tinterval = \"${14:[required if action equals update]}\"\n\trequestTimeOut = \"${15:[ ]}\"\n\tusername = \"${16:[ ]}\"\n\tpassword = \"${17:[ ]}\"\n\tproxyServer = \"${18:[ ]}\"\n\tproxyPort = \"${19:[ ]}\"\n\tproxyUser = \"${20:[ ]}\"\n\tproxyPassword = \"${21:[ ]}\"\n\tresolveURL = \"${22:[ ]}\"}>$0"},
 "setvariable" => 
  {scope: "text.html.cfm",
   name: "setvariable",
   content: "SetVariable(${1:name}, ${2:value})$0"},
 "cfindex" => 
  {scope: "text.html.cfm",
   name: "cfindex",
   content: 
    "<cfindex collection = \"$1\" action = \"$2\"${3: type = \"${4:[ ]}\" title = \"${5:[ ]}\" key = \"${6:[ ]}\" body = \"${7:[ ]}\" custom1 = \"${8:[ ]}\" custom2 = \"${9:[ ]}\" custom3 = \"${10:[ ]}\" custom4 = \"${11:[ ]}\" category = \"${12:[ ]}\" categoryTree = \"${13:[ ]}\" URLpath = \"${14:[ ]}\" extensions = \"${15:[ ]}\" query = \"${16:[ ]}\" recurse = \"${17:[ ]}\" language = \"${18:[ ]}\" status = \"${19:[ ]}\" prefix = \"${20:[ ]}\"}>$0"},
 "getsoapresponse" => 
  {scope: "text.html.cfm",
   name: "getsoapresponse",
   content: "GetSOAPResponse(${1:webservice})$0"},
 "arraynew" => 
  {scope: "text.html.cfm",
   name: "arraynew",
   content: "ArrayNew(${1:dimension})$0"},
 "addsoapresponseheader" => 
  {scope: "text.html.cfm",
   name: "addsoapresponseheader",
   content: 
    "AddSOAPResponseHeader(${1:namespace}, ${2:name}, ${3:value} ${4:[, mustunderstand]})$0"},
 "generatesecretkey" => 
  {scope: "text.html.cfm",
   name: "generatesecretkey",
   content: "GenerateSecretKey(${1:algorithm})$0"},
 "left" => 
  {scope: "text.html.cfm",
   name: "left",
   content: "Left(${1:string}, ${2:count})$0"},
 "arraylen" => 
  {scope: "text.html.cfm",
   name: "arraylen",
   content: "ArrayLen(${1:array})$0"},
 "cfchartdata" => 
  {scope: "text.html.cfm",
   name: "cfchartdata",
   content: "<cfchartdata item = \"$1\" value = \"$2\">$0"},
 "listfirst" => 
  {scope: "text.html.cfm",
   name: "listfirst",
   content: "ListFirst(${1:list}${2: [, delimiters]})$0"},
 "quotedvaluelist" => 
  {scope: "text.html.cfm",
   name: "quotedvaluelist",
   content: "QuotedValueList(${1:query.column}${2: [, delimiter]})$0"},
 "structappend" => 
  {scope: "text.html.cfm",
   name: "structappend",
   content: "StructAppend(${1:struct1}, ${2:struct2}, ${3:overwriteFlag})$0"},
 "compare" => 
  {scope: "text.html.cfm",
   name: "compare",
   content: "Compare(${1:string1}, ${2:string2})$0"},
 "right" => 
  {scope: "text.html.cfm",
   name: "right",
   content: "Right(${1:string}, ${2:count})$0"},
 "bitmaskread" => 
  {scope: "text.html.cfm",
   name: "bitmaskread",
   content: "BitMaskRead(${1:number}, ${2:start}, ${3:length})$0"},
 "cfldap" => 
  {scope: "text.html.cfm",
   name: "cfldap",
   content: 
    "<cfldap \n\tserver = \"$1\"${2: \n\tport = \"${3:[ ]}\"\n\tusername = \"${4:[ ]}\"\n\tpassword = \"${5:[ ]}\"\n\taction = \"${6:[ ]}\"\n\tname = \"${7:[ ]}\"\n\ttimeout = \"${8:[ ]}\"\n\tmaxRows = \"${9:[ ]}\"\n\tstart = \"${10:[ ]}\"\n\tscope = \"${11:[ ]}\"\n\tattributes = \"${12:[ ]}\"\n\treturnAsBinary = \"${13:[ ]}\"\n\tfilter = \"${14:[ ]}\"\n\tsort = \"${15:[ ]}\"\n\tsortControl = \"${16:[ ]}\"\n\tdn = \"${17:[ ]}\"\n\tstartRow = \"${18:[ ]}\"\n\tmodifyType = \"${19:[ ]}\"\n\trebind = \"${20:[ ]}\"\n\treferral = \"${21:[ ]}\"\n\tsecure = \"${22:[ ]}\"\n\tseparator = \"${23:[ ]}\"\n\tdelimiter = \"${24:[ ]}\"}>$0\n\n"},
 "int" => {scope: "text.html.cfm", name: "int", content: "Int(${1:number})$0"},
 "daysinyear" => 
  {scope: "text.html.cfm",
   name: "daysinyear",
   content: "DaysInYear(${1:\"date\"})$0"},
 "replacenocase" => 
  {scope: "text.html.cfm",
   name: "replacenocase",
   content: 
    "ReplaceNoCase(${1:string}, ${2:substring1}, ${3:substring2}${4: [, scope]})$0"},
 "setlocale" => 
  {scope: "text.html.cfm",
   name: "setlocale",
   content: "SetLocale(${1:new_locale})$0"},
 "arraymax" => 
  {scope: "text.html.cfm",
   name: "arraymax",
   content: "ArrayMax(${1:array})$0"},
 "getsoaprequestheader" => 
  {scope: "text.html.cfm",
   name: "getsoaprequestheader",
   content: 
    "GetSOAPRequestHeader(${1:namespace}, ${2:name} ${3:[, asXML]})$0"},
 "cftry" => 
  {scope: "text.html.cfm",
   name: "cftry",
   content: "<cftry>\n\t$1\n</cftry>$0"},
 "paragraphformat" => 
  {scope: "text.html.cfm",
   name: "paragraphformat",
   content: "ParagraphFormat(${1:string})$0"},
 "cfcookie" => 
  {scope: "text.html.cfm",
   name: "cfcookie",
   content: 
    "<cfcookie name = \"$1\"${2: value = \"${3:[ ]}\" expires = \"${4:[ ]}\" secure = \"${5:[ ]}\" path = \"${6:[ ]}\" domain = \"${7:[ ]}\"}>$0"},
 "cfdocumentsection" => 
  {scope: "text.html.cfm",
   name: "cfdocumentsection",
   content: 
    "<cfdocumentsection${1: margintop = \"${2:[ ]}\" marginbottom = \"${3:[ ]}\" marginleft = \"${4:[ ]}\" marginright = \"${5:[ ]}\" mimetype = \"${6:[ ]}\" src = \"${7:[ ]}\" srcfile = \"${8:[ ]}\"}>\n\t$9\n</cfdocumentsection>$0\n\n"},
 "iscustomfunction" => 
  {scope: "text.html.cfm",
   name: "iscustomfunction",
   content: "IsCustomFunction(${1:name})$0"},
 "isxmlnode" => 
  {scope: "text.html.cfm",
   name: "isxmlnode",
   content: "IsXmlNode(${1:value})$0"},
 "arrayprepend" => 
  {scope: "text.html.cfm",
   name: "arrayprepend",
   content: "ArrayPrepend(${1:array}, ${2:value})$0"},
 "cfreport" => 
  {scope: "text.html.cfm",
   name: "cfreport",
   content: 
    "<cfreport template = \"$1\" format = \"$2\"${3: name = \"${4:[ ]}\" filename = \"${5:[ ]}\" query = \"${6:[ ]}\" overwrite = \"${7:[ ]}\" encryption = \"${8:[ ]}\" ownerpassword = \"${9:[ ]}\" userpassword = \"${10:[ ]}\" permissions = \"${11:[ ]}\"}>\n\t$12\n</cfreport>$0"},
 "getprofilestring" => 
  {scope: "text.html.cfm",
   name: "getprofilestring",
   content: "GetProfileString(${1:iniPath}, ${2:section}, ${3:entry})$0"},
 "decrementvalue" => 
  {scope: "text.html.cfm",
   name: "decrementvalue",
   content: "DecrementValue(${1:number})$0"},
 "cfinclude" => 
  {scope: "text.html.cfm",
   name: "cfinclude",
   content: "<cfinclude template = \"$1\">$0"},
 "isvalid" => 
  {scope: "text.html.cfm",
   name: "isvalid",
   content: "IsValid(${1:type}, ${2:value})$0"},
 "xmlsearch" => 
  {scope: "text.html.cfm",
   name: "xmlsearch",
   content: "XmlSearch(${1:xmlDoc}, ${2:xPathString})$0"},
 "querysetcell" => 
  {scope: "text.html.cfm",
   name: "querysetcell",
   content: 
    "QuerySetCell(${1:query}, ${2:column_name}, ${3:value}${4: [, row_number ]})$0"},
 "getgatewayhelper" => 
  {scope: "text.html.cfm",
   name: "getgatewayhelper",
   content: "GetGatewayHelper(${1:gatewayID})$0"},
 "listcontainsnocase" => 
  {scope: "text.html.cfm",
   name: "listcontainsnocase",
   content: 
    "ListContainsNoCase(${1:list}, ${2:substring} ${3:[, delimiters ]})$0"},
 "cfinsert" => 
  {scope: "text.html.cfm",
   name: "cfinsert",
   content: 
    "<cfinsert dataSource = \"$1\" tableName = \"$2\"${3: tableOwner = \"${4:[ ]}\" tableQualifier = \"${5:[ ]}\" username = \"${6:[ ]}\" password = \"${7:[ ]}\" formFields = \"${8:[ ]}\"}>$0"},
 "cfprocresult" => 
  {scope: "text.html.cfm",
   name: "cfprocresult",
   content: 
    "<cfprocresult name = \"$1\"${2: resultSet = \"${3:[ ]}\" maxRows = \"${4:[ ]}\"}>$0"},
 "structfindkey" => 
  {scope: "text.html.cfm",
   name: "structfindkey",
   content: "StructFindKey(${1:top}, ${2:value}, ${3:scope})$0"},
 "isk2serveronline" => 
  {scope: "text.html.cfm",
   name: "isk2serveronline",
   content: "IsK2ServerOnline(${1:})$0"},
 "cfheader" => 
  {scope: "text.html.cfm",
   name: "cfheader",
   content: 
    "<cfheader name = \"$1\"${2: value = \"${3:[ ]}\" charset=\"${4:[ ]}\"}>$0"},
 "createdatetime" => 
  {scope: "text.html.cfm",
   name: "createdatetime",
   content: 
    "CreateDateTime(${1:year}, ${2:month}, ${3:day}, ${4:hour}, ${5:minute}, ${6:second})$0"},
 "listdeleteat" => 
  {scope: "text.html.cfm",
   name: "listdeleteat",
   content: "ListDeleteAt(${1:list}, ${2:position}${3: [, delimiters ]})$0"},
 "getbasetemplatepath" => 
  {scope: "text.html.cfm",
   name: "getbasetemplatepath",
   content: "GetBaseTemplatePath(${1:})$0"},
 "queryaddcolumn" => 
  {scope: "text.html.cfm",
   name: "queryaddcolumn",
   content: 
    "QueryAddColumn(${1:query}, ${2:column-name}${3: [, datatype]}${4: [, array-name]})$0"},
 "createtimespan" => 
  {scope: "text.html.cfm",
   name: "createtimespan",
   content: 
    "CreateTimeSpan(${1:days}, ${2:hours}, ${3:minutes}, ${4:seconds})$0"},
 "isstruct" => 
  {scope: "text.html.cfm",
   name: "isstruct",
   content: "IsStruct(${1:variable})$0"},
 "isdebugmode" => 
  {scope: "text.html.cfm", name: "isdebugmode", content: "IsDebugMode($1)$0"},
 "cfcase" => 
  {scope: "text.html.cfm",
   name: "cfcase",
   content: 
    "<cfcase value = \"$1\"${2: delimiters = \"${3:[ ]}\"}>$4</cfcase>$0"},
 "refind" => 
  {scope: "text.html.cfm",
   name: "refind",
   content: 
    "REFind(${1:reg_expression}, ${2:string}${3: [, start]}${4: [, returnsubexpressions]})$0"},
 "encryptbinary" => 
  {scope: "text.html.cfm",
   name: "encryptbinary",
   content: 
    "EncryptBinary(${1:bytes}, ${2:key}${3: [, algorithm]}${4: [, IVorSalt]}${5: [, iterations]})$0"},
 "lcase" => 
  {scope: "text.html.cfm", name: "lcase", content: "LCase(${1:string})$0"},
 "cfreturn" => 
  {scope: "text.html.cfm", name: "cfreturn", content: "<cfreturn $1>$0"},
 "structsort" => 
  {scope: "text.html.cfm",
   name: "structsort",
   content: 
    "StructSort(${1:base}, ${2:sortType}, ${3:sortOrder}, ${4:pathToSubElement})$0"},
 "isxmlattribute" => 
  {scope: "text.html.cfm",
   name: "isxmlattribute",
   content: "IsXmlAttribute(${1:value})$0"},
 "cfproperty" => 
  {scope: "text.html.cfm",
   name: "cfproperty",
   content: 
    "<cfproperty name=\"$1\"${2: type=\"${3:[ ]}\" required=\"${4:[ ]}\" default=\"${5:[ ]}\" displayname=\"${6:[ ]}\" hint=\"${7:[ ]}\"}>$0"},
 "second" => 
  {scope: "text.html.cfm", name: "second", content: "Second(${1:date})$0"},
 "listtoarray" => 
  {scope: "text.html.cfm",
   name: "listtoarray",
   content: "ListToArray(${1:list}${2: [, delimiters ]})$0"},
 "decimalformat" => 
  {scope: "text.html.cfm",
   name: "decimalformat",
   content: "DecimalFormat(${1:number})$0"},
 "cfrethrow" => 
  {scope: "text.html.cfm", name: "cfrethrow", content: "<cfrethrow>"},
 "bitor" => 
  {scope: "text.html.cfm",
   name: "bitor",
   content: "BitOr(${1:number1}, ${2:number2})$0"},
 "cfmailpart" => 
  {scope: "text.html.cfm",
   name: "cfmailpart",
   content: 
    "<cfmailpart type=\"$1\"${2: charset=\"${3:[ ]}\" wraptext=\"${4:[ ]}\"}>\n\t$5\n</cfmailpart>$0"},
 "lsparseeurocurrency" => 
  {scope: "text.html.cfm",
   name: "lsparseeurocurrency",
   content: "LSParseEuroCurrency(${1:currency-string})$0"},
 "cfassociate" => 
  {scope: "text.html.cfm",
   name: "cfassociate",
   content: 
    "<cfassociate${1: baseTag = \"${2:[ ]}\" dataCollection = \"${3:[ ]}\"}>$0"},
 "setprofilestring" => 
  {scope: "text.html.cfm",
   name: "setprofilestring",
   content: 
    "SetProfileString(${1:iniPath}, ${2:section}, ${3:entry}, ${4:value})$0"},
 "cfmodule" => 
  {scope: "text.html.cfm",
   name: "cfmodule",
   content: 
    "<cfmodule${1: template = \"${2:required unless name attribute is used}\" name = \"${3:required unless template attribute is used}\" attributeCollection = \"${4:[ ]}\" attribute_name1 = \"${5:[ ]}\" attribute_name2 = \"${6:[ ]}\"}>$0"},
 "releasecomobject" => 
  {scope: "text.html.cfm",
   name: "releasecomobject",
   content: "ReleaseComObject(${1:objectName})$0"},
 "min" => 
  {scope: "text.html.cfm",
   name: "min",
   content: "Min(${1:number1}, ${2:number2})$0"},
 "getclientvariableslist" => 
  {scope: "text.html.cfm",
   name: "getclientvariableslist",
   content: "GetClientVariablesList(${1:})$0"},
 "arraysum" => 
  {scope: "text.html.cfm",
   name: "arraysum",
   content: "ArraySum(${1:array})$0"},
 "cfimport" => 
  {scope: "text.html.cfm",
   name: "cfimport",
   content: "<cfimport taglib = \"$1\" prefix = \"$2\">$0"},
 "cfset" => 
  {scope: "text.html.cfm",
   name: "cfset",
   content: "<cfset $1 = $0${TM_XHTML}>"},
 "trim" => 
  {scope: "text.html.cfm", name: "trim", content: "Trim(${1:string})$0"},
 "findoneof" => 
  {scope: "text.html.cfm",
   name: "findoneof",
   content: "FindOneOf(${1:set}, ${2:string} ${3:[, start ]})$0"},
 "arraydeleteat" => 
  {scope: "text.html.cfm",
   name: "arraydeleteat",
   content: "ArrayDeleteAt(${1:array}, ${2:position})$0"},
 "cfparam" => 
  {scope: "text.html.cfm",
   name: "cfparam",
   content: 
    "<cfparam name=\"$1\"${2: type=\"${3:[string]}\" default=\"${4:[ ]}\"}>$0"},
 "cflogin" => 
  {scope: "text.html.cfm",
   name: "cflogin",
   content: 
    "<cflogin${1: idletimeout = \"${2:1800}\" applicationToken = \"${3:[ ]}\" cookieDomain = \"${4:[ ]}\"}>\n\t<cfloginuser name = \"$5\" password = \"$6\" roles = \"${7:[ ]}\">$8\n</cflogin>$0"},
 "isarray" => 
  {scope: "text.html.cfm",
   name: "isarray",
   content: "IsArray(${1:value} ${2:[, number ]})$0"},
 "cfinput" => 
  {scope: "text.html.cfm",
   name: "cfinput",
   content: 
    "<cfinput name = \"$1\"${2: type = \"${3:[ ]}\" label = \"${4:[ ]}\" style = \"${5:[ ]}\" required = \"${6:[ ]}\" mask = \"${7:[ ]}\" validate = \"${8:[ ]}\" validateAt= \"${9:[ ]}\" message = \"${10:[ ]}\" range = \"${11:[ ]}\" maxlength = \"${12:[ ]}\" pattern = \"${13:[ ]}\" onValidate = \"${14:[ ]}\" onError = \"${15:[ ]}\" size = \"${16:[ ]}\" value = \"${17:[ ]}\" bind = \"${18:[ ]}\" checked = \"${19:[ ]}\" disabled = \"${20:[ ]}\" src = \"${21:[ ]}\" onKeyUp = \"${22:[ ]}\" onKeyDown = \"${23:[ ]}\" onMouseUp = \"${24:[ ]}\" onMouseDown = \"${25:[ ]}\" onChange = \"${26:[ ]}\" onClick = \"${27:[ ]}\" firstDayOfWeek = \"${28:[ ]}\" dayNames = \"${29:[ ]}\" monthNames = \"${30:[ ]}\" enabled = \"${31:[ ]}\" visible = \"${32:[ ]}\" toolTip = \"${33:[ ]}\" height = \"${34:[ ]}\" width = \"${35:[ ]}\"}>$0"},
 "arraytolist" => 
  {scope: "text.html.cfm",
   name: "arraytolist",
   content: "ArrayToList(${1:array} ${2:[, delimiter ]})$0"},
 "getexception" => 
  {scope: "text.html.cfm",
   name: "getexception",
   content: "GetException(${1:object})$0"},
 "hour" => 
  {scope: "text.html.cfm", name: "hour", content: "hour(${1:date})$0"},
 "pi" => {scope: "text.html.cfm", name: "pi", content: "Pi($1)$0"},
 "cfformgroup" => 
  {scope: "text.html.cfm",
   name: "cfformgroup",
   content: 
    "<cfformgroup type = \"$1\" label = \"${2:[ ]}\" style = \"${3:[ ]}\" selectedIndex = \"${4:[ ]}\" width = \"${5:[ ]}\" height = \"${6:[ ]}\" enabled = \"${7:[ ]}\" visible = \"${8:[ ]}\" OnChange = \"${9:[ ]}\" toolTip = \"${10:[ ]}\" id = \"${11:[ ]}\">\n\t$12\n</cfformgroup>$0"},
 "createodbctime" => 
  {scope: "text.html.cfm",
   name: "createodbctime",
   content: "CreateODBCTime(${1:date})$0"},
 "xmltransform" => 
  {scope: "text.html.cfm",
   name: "xmltransform",
   content: "XmlTransform(${1:xml}, ${2:xsl}${3: [, parameters]})$0"},
 "listgetat" => 
  {scope: "text.html.cfm",
   name: "listgetat",
   content: "ListGetAt(${1:list}, ${2:position}${3: [, delimiters]})$0"}}
