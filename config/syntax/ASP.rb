# Encoding: UTF-8

{comment: 
  "ASP SCRIPTING DICTIONARY – By Rich Barton: Version 1.0 (based on PHP Scripting Dictionary by Justin French, Sune Foldager and Allan Odgaard) Note: .asp is handled by asp/html",
 fileTypes: ["asa"],
 foldingStartMarker: 
  /(?i)^\s*(?<_1>Public|Private)?\s*(?<_2>Class|Function|Sub|Property)\s*(?<_3>[a-zA-Z_]\w*)\s*(?<_4>\(.*\)\s*)?$/,
 foldingStopMarker: /(?i)^\s*End (?<_1>Class|Function|Sub|Property)\s*$/,
 keyEquivalent: "^~A",
 name: "ASP",
 patterns: 
  [{captures: 
     {1 => {name: "storage.type.function.asp"},
      2 => {name: "entity.name.function.asp"},
      3 => {name: "punctuation.definition.parameters.asp"},
      4 => {name: "variable.parameter.function.asp"},
      5 => {name: "punctuation.definition.parameters.asp"}},
    match: 
     /^\s*(?<_1>(?i:function|sub))\s*(?<_2>[a-zA-Z_]\w*)\s*(?<_3>\()(?<_4>[^)]*)(?<_5>\)).*\n?/,
    name: "meta.function.asp"},
   {captures: {1 => {name: "punctuation.definition.comment.asp"}},
    match: /(?<_1>').*$\n?/,
    name: "comment.line.apostrophe.asp"},
   {captures: {1 => {name: "punctuation.definition.comment.asp"}},
    match: /(?<_1>REM ).*$\n?/,
    name: "comment.line.rem.asp"},
   {match: 
     /(?i:\b(?<_1>If|Then|Else|ElseIf|End If|While|Wend|For|To|Each|In|Step|Case|Select|End Select|Return|Continue|Do|Until|Loop|Next|With|Exit Do|Exit For|Exit Function|Exit Property|Exit Sub)\b)/,
    name: "keyword.control.asp"},
   {match: /=|>=|<|>|<|<>|\+|-|\*|\^|&|\b(?i:(?<_1>Mod|And|Not|Or|Xor|Is))\b/,
    name: "keyword.operator.asp"},
   {match: 
     /(?i:\b(?<_1>Call|Class|Const|Dim|Redim|Function|Sub|Property|End Property|End sub|End Function|Set|Let|Get|New|Randomize|Option Explicit|On Error Resume Next|On Error GoTo)\b)/,
    name: "storage.type.asp"},
   {match: /(?i:\b(?<_1>Private|Public|Default)\b)/,
    name: "storage.modifier.asp"},
   {match: /(?i:\b(?<_1>Empty|False|Nothing|Null|True)\b)/,
    name: "constant.language.asp"},
   {begin: /"/,
    beginCaptures: {0 => {name: "punctuation.definition.string.begin.asp"}},
    end: "\"(?!\")",
    endCaptures: {0 => {name: "punctuation.definition.string.end.asp"}},
    name: "string.quoted.double.asp",
    patterns: 
     [{match: /""/, name: "constant.character.escape.apostrophe.asp"}]},
   {captures: {1 => {name: "punctuation.definition.variable.asp"}},
    match: /(?<_1>\$)[a-zA-Z_x7f-xff][a-zA-Z0-9_x7f-xff]*?\b/,
    name: "variable.other.asp"},
   {match: 
     /(?i:\b(?<_1>Application|ObjectContext|Request|Response|Server|Session)\b)/,
    name: "support.class.asp"},
   {match: 
     /(?i:\b(?<_1>Contents|StaticObjects|ClientCertificate|Cookies|Form|QueryString|ServerVariables)\b)/,
    name: "support.class.collection.asp"},
   {match: 
     /(?i:\b(?<_1>TotalBytes|Buffer|CacheControl|Charset|ContentType|Expires|ExpiresAbsolute|IsClientConnected|PICS|Status|ScriptTimeout|CodePage|LCID|SessionID|Timeout)\b)/,
    name: "support.constant.asp"},
   {match: 
     /(?i:\b(?<_1>Lock|Unlock|SetAbort|SetComplete|BianryRead|AddHeader|AppendToLog|BinaryWrite|Clear|End|Flush|Redirect|Write|CreateObject|HTMLEncode|MapPath|URLEncode|Abandon)\b)/,
    name: "support.function.asp"},
   {match: 
     /(?i:\b(?<_1>Application_OnEnd|Application_OnStart|OnTransactionAbort|OnTransactionCommit|Session_OnEnd|Session_OnStart|Class_Initialize|Class_Terminate)\b)/,
    name: "support.function.event.asp"},
   {match: 
     /(?i:\b(?<_1>Array|Add|Asc|Atn|CBool|CByte|CCur|CDate|CDbl|Chr|CInt|CLng|Conversions|Cos|CreateObject|CSng|CStr|Date|DateAdd|DateDiff|DatePart|DateSerial|DateValue|Day|Derived|Math|Escape|Eval|Exists|Exp|Filter|FormatCurrency|FormatDateTime|FormatNumber|FormatPercent|GetLocale|GetObject|GetRef|Hex|Hour|InputBox|InStr|InStrRev|Int|Fix|IsArray|IsDate|IsEmpty|IsNull|IsNumeric|IsObject|Item|Items|Join|Keys|LBound|LCase|Left|Len|LoadPicture|Log|LTrim|RTrim|Trim|Maths|Mid|Minute|Month|MonthName|MsgBox|Now|Oct|Remove|RemoveAll|Replace|RGB|Right|Rnd|Round|ScriptEngine|ScriptEngineBuildVersion|ScriptEngineMajorVersion|ScriptEngineMinorVersion|Second|SetLocale|Sgn|Sin|Space|Split|Sqr|StrComp|String|StrReverse|Tan|Time|Timer|TimeSerial|TimeValue|TypeName|UBound|UCase|Unescape|VarType|Weekday|WeekdayName|Year)\b)/,
    name: "support.function.vb.asp"},
   {match: 
     /\b(?<_1>(?<_2>0(?<_3>x|X)[0-9a-fA-F]*)|(?<_4>(?<_5>[0-9]+\.?[0-9]*)|(?<_6>\.[0-9]+))(?<_7>(?<_8>e|E)(?<_9>\+|-)?[0-9]+)?)(?<_10>L|l|UL|ul|u|U|F|f)?\b/,
    name: "constant.numeric.asp"},
   {match: 
     /(?i:\b(?<_1>vbtrue|fvbalse|vbcr|vbcrlf|vbformfeed|vblf|vbnewline|vbnullchar|vbnullstring|vbtab|vbverticaltab|vbbinarycompare|vbtextcomparevbsunday|vbmonday|vbtuesday|vbwednesday|vbthursday|vbfriday|vbsaturday|vbusesystemdayofweek|vbfirstjan1|vbfirstfourdays|vbfirstfullweek|vbgeneraldate|vblongdate|vbshortdate|vblongtime|vbshorttime|vbobjecterror|vbEmpty|vbNull|vbInteger|vbLong|vbSingle|vbDouble|vbCurrency|vbDate|vbString|vbObject|vbError|vbBoolean|vbVariant|vbDataObject|vbDecimal|vbByte|vbArray)\b)/,
    name: "support.type.vb.asp"}],
 scopeName: "source.asp",
 uuid: "291022B4-6B1D-11D9-90EB-000D93589AF6"}
