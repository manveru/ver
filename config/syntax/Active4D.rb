# Encoding: UTF-8

{fileTypes: [],
 foldingStartMarker: 
  /(?x)
	(?<_1>^\s*(?i:if|while|for\ each|for|case\ of|repeat|method|save output)\b
	)/,
 foldingStopMarker: 
  /(?x)
	(?<_1>^\s*(?i:end\ (?<_2>if|while|for\ each|for|case|method|save output)|until)\b
	)/,
 keyEquivalent: "^~A",
 name: "Active4D",
 patterns: 
  [{captures: {1 => {name: "punctuation.definition.comment.active4d"}},
    match: /(?:(?<_1>`).*(?=%>)|(?<_2>`).*$\n)/,
    name: "comment.line.backtick.active4d"},
   {captures: {1 => {name: "punctuation.definition.comment.active4d"}},
    match: /(?:(?<_1>\/\/).*(?=%>)|(?<_2>\/\/).*$\n)/,
    name: "comment.line.double-slash.active4d"},
   {captures: {1 => {name: "punctuation.definition.comment.active4d"}},
    match: /(?<_1>\\\\).*$\n?/,
    name: "comment.line.double-backslash.continuation.active4d"},
   {begin: /\/\*/,
    captures: {0 => {name: "punctuation.definition.comment.active4d"}},
    end: "\\*/",
    name: "comment.block.active4d",
    patterns: [{include: "#fusedoc"}]},
   {begin: /"(?!"")/,
    beginCaptures: 
     {0 => {name: "punctuation.definition.string.begin.active4d"}},
    end: "\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.active4d"}},
    name: "string.quoted.double.active4d",
    patterns: [{include: "#escaped_char"}]},
   {begin: /"""/,
    beginCaptures: 
     {0 => {name: "punctuation.definition.string.begin.active4d"}},
    end: "\"\"\"",
    endCaptures: {0 => {name: "punctuation.definition.string.end.active4d"}},
    name: "string.quoted.triple.heredoc.active4d",
    patterns: [{include: "#escaped_char"}]},
   {begin: /'(?!'')/,
    beginCaptures: 
     {0 => {name: "punctuation.definition.string.begin.active4d"}},
    end: "'",
    endCaptures: {0 => {name: "punctuation.definition.string.end.active4d"}},
    name: "string.interpolated.quoted.single.active4d",
    patterns: [{include: "#interpolated_string"}]},
   {begin: /'''/,
    beginCaptures: 
     {0 => {name: "punctuation.definition.string.begin.active4d"}},
    end: "'''",
    endCaptures: {0 => {name: "punctuation.definition.string.end.active4d"}},
    name: "string.interpolated.quoted.triple.heredoc.active4d",
    patterns: [{include: "#interpolated_string"}]},
   {match: 
     /(?<![[:alpha:]])[\-]?(?:0x[[:xdigit:]]{1,4}|\d+(?<_1>\.\d+)?)(?![[:alpha:]])/,
    name: "constant.numeric.active4d"},
   {match: /\b(?i)(?<_1>true|false)\b/,
    name: "constant.language.boolean.active4d"},
   {captures: {1 => {name: "punctuation.definition.variable.active4d"}},
    match: /(?<_1>\$)[\w_]+/,
    name: "variable.other.local.active4d"},
   {captures: {1 => {name: "punctuation.definition.variable.active4d"}},
    match: /(?<_1>\<\>)[\w_]+/,
    name: "variable.other.interprocess.active4d"},
   {captures: 
     {1 => {name: "punctuation.definition.variable.active4d"},
      2 => {name: "punctuation.definition.variable.active4d"}},
    match: /(?<_1>\[)[^\[].*?(?<_2>\])(?<_3>[\w_ ]+)?/,
    name: "variable.other.table-field.active4d"},
   {captures: 
     {1 => {name: "punctuation.definition.constant.active4d"},
      2 => {name: "punctuation.definition.constant.active4d"}},
    match: /(?<_1>!)\d{1,2}[\/ \-]\d{1,2}[\/ \-]\d{1,4}(?<_2>!)/,
    name: "constant.other.date.active4d"},
   {captures: 
     {1 => {name: "punctuation.definition.constant.active4d"},
      2 => {name: "punctuation.definition.constant.active4d"}},
    match: /(?<_1>\?)\d{1,2}[: ]\d{1,2}[: ]\d{1,2}(?<_2>\?)/,
    name: "constant.other.time.active4d"},
   {match: 
     /(?i)\b(?<_1>Write Mode|UTF8 Text without length|UTF8 Text with length|UTF8 C string|Text without length|Text array|System date short|System date long|System date abbreviated|String array|Short|Real array|Read Mode|Read and Write|position from start|position from end|position from current|Pointer array|Picture array|No current record|New record|native byte ordering|Month Day Year|MM DD YYYY Forced|MM DD YYYY|MAXTEXTLEN|MAXLONG|Mac text without length|Mac text with length|Longint array|Long|little endian byte ordering|Line feed|Is Undefined|Is Time|Is Text|Is String Var|Is Real|Is Pointer|Is Picture|Is Longint|Is Integer|Is Date|Is Boolean|Is BLOB|Is Alpha Field|is a document|is a directory|Into variable|Into set|Into named selection|Into current selection|Integer array|Hour Min Sec|Hour Min|HH MM SS|HH MM AM PM|HH MM|Get Pathname|Date array|Carriage return|Boolean array|big endian byte ordering|Array 2D|Abbreviated|Abbr Month Day|A4D Parameter Mode Separate|A4D Parameter Mode Query|A4D Parameter Mode Form|A4D License Type OEM|A4D License Type Deployment|A4D Encoding Tags|A4D Encoding Quotes|A4D Encoding None|A4D Encoding HTML|A4D Encoding Extended|A4D Encoding Ampersand|A4D Encoding All|A4D Charset Win|A4D Charset UTF8|A4D Charset Shift_JIS|A4D Charset None|A4D Charset Mac|A4D Charset ISO Latin1|A4D Charset GB2312)\b/,
    name: "support.constant.active4d"},
   {comment: "4D and Active4D commands",
    match: 
     /(?i)\b(?<_1>_request|_query|_form|Year of|writep|writeln|writebr|write to console|write raw|write png|WRITE PICTURE FILE|write jpg|write jpeg|write gif|write blob|write|Win to Mac|week of year|variable name|VALIDATE TRANSACTION|utf to mac|utc to local time|utc to local datetime|USE SET|USE NAMED SELECTION|url to native path|url encode query|url encode path|url encode|url decode query|url decode path|url decode|Uppercase|unlock globals|UNLOAD RECORD|UNION|Undefined|type descriptor|Type|Trunc|True|trim|timestamp year|timestamp time|timestamp string|timestamp second|timestamp month|timestamp minute|timestamp millisecond|timestamp hour|timestamp difference|timestamp day|timestamp date|timestamp|time to longint|Time string|Time|Tickcount|throw|TEXT TO BLOB|Test semaphore|Test path name|Table name|Table|Substring|Structure file|STRING LIST TO ARRAY|String|START TRANSACTION|split string|SORT ARRAY|slice string|Size of array|set session timeout|set session array|set session|set script timeout|set response status|set response header|set response cookie path|set response cookie expires|set response cookie domain|set response cookie|set response buffer|SET QUERY LIMIT|SET QUERY DESTINATION|set platform charset|set output encoding|set output charset|set log level|set local|set global array|set global|set expires date|set expires|set error page|SET DOCUMENT POSITION|SET DEFAULT CENTURY|set current script timeout|set content type|set content charset|set collection array|set collection|set cache control|SET BLOB SIZE|SET AUTOMATIC RELATIONS|set array|session to blob|session query|session local|session internal id|session id|session has|session|Sequence number|SEND PACKET|Semaphore|SELECTION TO ARRAY|SELECTION RANGE TO ARRAY|Selected record number|SCAN INDEX|save upload to field|SAVE RECORD|save output|save collection|Round|right trim|response headers|response cookies|response buffer size|RESOLVE POINTER|resize array|require|requested url|request query|request info|request cookies|Replace string|REMOVE FROM SET|RELATE ONE SELECTION|RELATE ONE|RELATE MANY SELECTION|RELATE MANY|regex split|regex replace|regex quote pattern|regex match all|regex match|regex find in array|regex find all in array|regex callback replace|REDUCE SELECTION|redirect|Records in table|Records in set|Records in selection|Record number|RECEIVE PACKET|READ WRITE|READ PICTURE FILE|Read only state|READ ONLY|random between|Random|QUERY WITH ARRAY|QUERY SELECTION BY FORMULA|QUERY SELECTION|query params has|query params|QUERY BY FORMULA|QUERY|PREVIOUS RECORD|Position|Picture size|PICTURE PROPERTIES|parameter mode|param text|ORDER BY FORMULA|ORDER BY|Open document|ONE RECORD SELECT|Num|Not|nil pointer|Nil|NEXT RECORD|next item|new local collection|new global collection|new collection|native to url path|multisort named arrays|multisort arrays|MOVE DOCUMENT|more items|Month of|min of|Milliseconds|method exists|merge collections|md5 sum|max of|Mac to Win|mac to utf8|Mac to ISO|mac to html|Lowercase|longint to time|longint to blob|log message|Locked|lock globals|local variables|local time to utc|local datetime to utc|LOAD RECORD|load collection|LIST TO ARRAY|library list|Length|left trim|LAST RECORD|last of|last not of|join paths|join array|ISO to Mac|is table number valid|Is in set|is field number valid|is array|is an iterator|is a collection|INTERSECTION|interpolate string|Int|insert string|insert into array|INSERT ELEMENT|include into|include|in error|import|identical strings|html encode|hide session field|GOTO SELECTED RECORD|GOTO RECORD|globals has|globals|global|get version|get utc delta|get upload size|get upload remote filename|get upload extension|get upload encoding|get upload content type|get timestamp datetime|get time remaining|get session timeout|get session stats|get session names|get session item|get session array size|get session array|get session|get script timeout|get root|get response headers|get response header|get response cookies|get response cookie path|get response cookie expires|get response cookie domain|get response cookie|get response buffer|get request value|get request infos|get request info|get request cookies|get request cookie|get query params|get query param count|get query param choices|get query param|Get pointer|get platform charset|GET PICTURE FROM LIBRARY|get output encoding|get output charset|get log level|get local|get license info|get library list|get last table number|get last field number|get item value|get item type|get item key|get item array|Get indexed string|get global keys|get global item|get global array size|get global array|get global|get form variables|get form variable count|get form variable choices|get form variable|GET FIELD PROPERTIES|get field pointer|get field numbers|get expires date|get expires|get error page|Get document position|get current script timeout|get content type|get content charset|get collection keys|get collection item count|get collection item|get collection array size|get collection array|get collection|get call chain|get cache control|get auto relations|full requested url|form variables has|form variables|FOLDER LIST|FIRST RECORD|first of|first not of|Find index key|Find in array|fill array|filename of|file exists|Field name|Field|False|extension of|execute in 4d|EXECUTE|End selection|end save output|enclose|DOCUMENT TO BLOB|DOCUMENT LIST|DISTINCT VALUES|directory separator|directory of|directory exists|DIFFERENCE|Delete string|delete session item|DELETE SELECTION|delete response header|delete response cookie|DELETE RECORD|delete global|DELETE FOLDER|DELETE ELEMENT|DELETE DOCUMENT|delete collection item|DELAY PROCESS|defined|define|default directory|deep copy collection|deep clear collection|Dec|day of year|Day of|Day number|Date|C_TIME|C_TEXT|C_STRING|C_REAL|C_POINTER|C_PICTURE|C_LONGINT|C_DATE|C_BOOLEAN|C_BLOB|CUT NAMED SELECTION|Current time|current realm|Current process|current platform|current path|Current method name|current line number|current library name|current file|Current date|CREATE SET FROM ARRAY|CREATE SET|CREATE SELECTION FROM ARRAY|CREATE RECORD|CREATE FOLDER|CREATE EMPTY SET|Create document|count uploads|Count tables|count session items|count response headers|count response cookies|count request infos|count request cookies|count query params|Count in array|count globals|count form variables|Count fields|count collection items|copy upload|COPY SET|COPY NAMED SELECTION|COPY DOCUMENT|copy collection|COPY ARRAY|concat|compare strings|collection to blob|collection has|collection|CLOSE DOCUMENT|CLEAR VARIABLE|CLEAR SET|CLEAR SEMAPHORE|clear response buffer|CLEAR NAMED SELECTION|clear collection|clear buffer (?<_2>deprecated)|clear array|choose|Character code|Char|cell|capitalize|CANCEL TRANSACTION|call method|call 4d method|build query string|blowfish encrypt|blowfish decrypt|BLOB to text|blob to session|blob to longint|BLOB TO DOCUMENT|blob to collection|BLOB size|Before selection|base64 encode|base64 decode|AUTOMATIC RELATIONS|auto relate|authenticate|auth user|auth type|auth password|Ascii|ARRAY TEXT|ARRAY STRING|ARRAY REAL|ARRAY POINTER|ARRAY PICTURE|ARRAY LONGINT|ARRAY INTEGER|ARRAY DATE|ARRAY BOOLEAN|append to array|Append document|ALL RECORDS|add to timestamp|ADD TO SET|Add to date|add element|Abs|abandon session|abandon response cookie)\b/,
    name: "support.function.active4d"},
   {comment: "library methods",
    match: 
     /(?i)\b(?<_1>(?<_2>yearMonthDay|writeDumpStyles|writeBold|write|warnInvalidField|valueList|valueCountNoCase|valueCount|validPrice|validEmailAddress|validateTextFields|unlockAndLoad|truncateText|toJSON|timedOut|startObject|startArray|sourceRowCount|sort|setTitle|setTimeout|setSMTPHost|setSMTPAuthorization|setSeparator|setRelateOne|setMailMethod|setDivId|setDefaults|setColumnData|setColumnArray|setAt|sendMail|sendFuseaction|saveFormToSession|rowCount|reverseArray|rest|qualify|previous|prepend|postHandleError|persistent|ordinalOf|nextID|next|newFromSelection|newFromRowSet|newFromFile|newFromData|newFromCachedSelection|newFromArrays|newFromArray|new|move|maxRows|makeURL|makeSafeMailto|makeLinks|makeFuseboxLinks|listToArray|len|last|isLast|isFuseboxRequest|isFirst|isBeforeFirst|isAfterLast|insertAt|hideUniqueField|hideField|handleError|gotoRow|getVariablesIterator|getUniqueID|getTitle|getTimeout|getStarts|getStart|getSMTPHost|getSMTPAuthUser|getSMTPAuthPassword|getSMTPAuthorization|getRow|getPointerReferent|getPictureDescriptor|getPersistentList|getMonthName|getMailMethod|getEnd|getEmptyFields|getDefaults|getDayName|getData|getColumnSource|getColumn|getAt|fuseboxNew|formVariableListToQuery|formatUSPhone|first|findRow|findNoCase|findColumn|find|filterCollection|endObject|endArray|encodeString|encodeDate|encodeCollection|encodeBoolean|encodeArray|encode|embedVariables|embedQueryParams|embedFormVariables|embedFormVariableList|embedCollectionItems|embedCollection|dumpPersistent|dumpLib|dumpDefaults|dump session stats|dump session|dump selection|dump RowSet|dump request info|dump request|dump query params|dump locals|dump license info|dump form variables|dump collection|dump array|dump|deleteSelection|deleteAt|currentRow|core|containsNoCase|contains|columnCount|collectionToQuery|collectionItemsToQuery|clearPersistent|chopText|checkSession|checkboxState|changeDelims|camelCaseText|buildSelectValueMenu|buildSelectMenu|buildRecordList|buildOptionsFromSelection|buildOptionsFromRowSet|buildOptionsFromOptionList|buildOptionsFromOptionArray|buildOptionsFromLists|buildOptionsFromArrays|buildArrayValueList|buildArrayList|beforeFirst|articleFor|arrayToList|append|afterLast|addSelection|addRowSet|addMetaTag|addJS|addJavascript|addDumpStyles|addCSS|addArray|add))\b/,
    name: "support.function.active4d"},
   {match: /(?i)\b(?<_1>OK|Document|fusebox\.conf\.fuseaction|Error)\b/,
    name: "support.variable.active4d"},
   {captures: 
     {1 => {name: "support.class.active4d"},
      2 => {name: "support.function.active4d"}},
    match: 
     /(?<!\$)\b(?<_1>(?:a4d\.(?:console|debug|lists|utils|web|json)|Batch|Breadcrumbs|fusebox\.conf|fusebox\.head|fusebox|RowSet))\.(?<_2>[[:alpha:]][[[:alnum:]]_ ]+[[:alnum:]])/},
   {captures: 
     {1 => {name: "keyword.other.active4d"},
      2 => {name: "entity.name.function.active4d"}},
    comment: "method definition without parameters",
    match: /^\s*(?<_1>method)\s*(?<_2>"[^"]+")(?!\s*\()/,
    name: "meta.function.active4d"},
   {begin: /^\s*(?<_1>method)\s*(?<_2>(?<_3>")[^"]+(?<_4>"))\s*(?<_5>\()/,
    beginCaptures: 
     {1 => {name: "keyword.other.active4d"},
      2 => {name: "entity.name.function.active4d"},
      3 => {name: "punctuation.definition.entity.active4d"},
      4 => {name: "punctuation.definition.entity.active4d"},
      5 => {name: "punctuation.definition.parameters.active4d"}},
    comment: "method definition with parameters",
    end: "(\\))\\s*(?:(?:\\\\\\\\|//|`).*)?$",
    endCaptures: {1 => {name: "punctuation.definition.parameters.active4d"}},
    name: "meta.function.active4d",
    patterns: 
     [{captures: 
        {1 => {name: "keyword.operator.active4d"},
         2 => {name: "punctuation.definition.variable.active4d"},
         3 => {name: "punctuation.separator.parameters.active4d"}},
       match: /(?<_1>&)?(?<_2>\$)[\w_]+(?<_3>;)?/,
       name: "variable.parameter.function.active4d"},
      {begin: /(?<_1>=)/,
       beginCaptures: 
        {1 => {name: "punctuation.separator.key-value.active4d"}},
       end: "(;)|(?=\\))",
       endCaptures: {1 => {name: "punctuation.separator.parameters.active4d"}},
       patterns: [{include: "$self"}]}]},
   {match: 
     /(?x) (?<_1>
	:=
	|	\+=	
	|	\-=	
	|	\/=	
	|	\\=	
	|	\*=	
	|	\%=	
	|	\^=	
	|	&=	
	|	\|=	
	|	<<=	
	|	>>=	
	|	>	
	|	<	
	|	>=	
	|	<=	
	|	=	
	|	=~	
	|	\#	
	|	\#~	
	|	~	
	|	!~	
	|	\+
	|	\+\+	
	|	\-	
	|	\-\-	
	|	\/	
	|	\\	
	|	\*
	|	\*\+
	|	\*\/
	|	%	
	|	&	
	|	\|	
	|	\^	
	|	\^\|	
	|	<<
	|	>>
	|	\?\+
	|	\?\-
	|	\?\?
	|	\}
	|	\{
	|	;
	|	\:
	|	\]\]
	|	\[\[
	|	\->)/,
    name: "keyword.operator.active4d"},
   {match: 
     /\b(?i)(?<_1>end (?<_2>if|for each|for|while|case)|if|else|while|for each|for|case of|repeat|until|break|continue)\b/,
    name: "keyword.control.active4d"},
   {match: 
     /\b(?i)(?<_1>end method|method|define|return|exit|self|import|require|global|throw)\b/,
    name: "keyword.other.active4d"}],
 repository: 
  {escaped_char: {match: /\\./, name: "constant.character.escape.active4d"},
   escaped_interpolated_code: 
    {begin: /\\`/, end: "`", name: "string.interpolated.escaped.active4d"},
   escaped_interpolated_collection_ref: 
    {match: 
      /\\(?<_1>_form|_query|_request|globals|session)(?<_2>{(?<_3>".+?"|\d+|\$[\w_]+)})+(?<_4>\[\[\d+\]\])*/,
     name: "string.interpolated.escaped.active4d"},
   escaped_interpolated_table_field: 
    {match: /\\\[\w[\w_ ]*\][\w_]+(?<_1>\[\[\d+\]\])*/,
     name: "string.interpolated.escaped.active4d"},
   escaped_interpolated_variable: 
    {captures: {1 => {name: "punctuation.definition.variable.active4d"}},
     match: /\\\$[\w_]+(?<_1>{(?<_2>".+?"|\d+|\$[\w_]+)})*(?<_3>\[\[\d+\]\])*/,
     name: "string.interpolated.escaped.active4d"},
   fusedoc: 
    {begin: /(?=^\s*<fusedoc )/,
     end: "(?<=</fusedoc>)",
     name: "text.xml",
     patterns: [{include: "text.xml"}]},
   interpolated_code: 
    {begin: /`/,
     beginCaptures: 
      {0 => {name: "punctuation.definition.string.begin.active4d"}},
     end: "`",
     endCaptures: {0 => {name: "punctuation.definition.string.end.active4d"}},
     name: "source.interpolated.active4d",
     patterns: [{include: "$self"}]},
   interpolated_collection_ref: 
    {match: 
      /(?<_1>_form|_query|_request|globals|session)(?<_2>{(?<_3>".+?"|\d+|\$[\w_]+)})+(?<_4>\[\[\d+\]\])*/,
     name: "variable.other.interpolated.collection-ref.active4d"},
   interpolated_string: 
    {patterns: 
      [{include: "#escaped_interpolated_code"},
       {include: "#interpolated_code"},
       {include: "#escaped_interpolated_table_field"},
       {include: "#interpolated_table_field"},
       {include: "#escaped_interpolated_variable"},
       {include: "#interpolated_variable"},
       {include: "#escaped_interpolated_collection_ref"},
       {include: "#interpolated_collection_ref"}]},
   interpolated_table_field: 
    {match: /\[\w[\w_ ]*\][\w_]+(?<_1>\[\[\d+\]\])*/,
     name: "variable.other.interpolated.table-field.active4d"},
   interpolated_variable: 
    {captures: {1 => {name: "punctuation.definition.variable.active4d"}},
     match: 
      /(?<_1>\$)[\w_]+(?<_2>{(?<_3>".+?"|\d+|\$[\w_]+)})*(?<_4>\[\[\d+\]\])*/,
     name: "variable.other.interpolated.local.active4d"}},
 scopeName: "source.active4d",
 uuid: "8C2BF09D-AE95-479B-B516-F8DB62C86A0C"}
