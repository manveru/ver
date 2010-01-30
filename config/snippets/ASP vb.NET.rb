# Encoding: UTF-8

{"asp:" => 
  {scope: "text.html.asp.net",
   name: "asp:TemplateColumn",
   content: 
    "<asp:TemplateColumn HeaderText=\"${1:${TM_SELECTED_TEXT:ColumnName}}\" ${2:ReadOnly=\"True\" ${3:FooterText=\"${1:${TM_SELECTED_TEXT:ColumnName}}\" }}>\n\t<ItemTemplate>${9:\n\t\t<%# DataBinder.Eval(Container.DataItem, \"${1:${TM_SELECTED_TEXT:ColumnName}}\"${8:, \"{0:C\\}\"}) %>$0\n\t}</ItemTemplate>${10:\n\t<EditItemTemplate>${11:\n\t\t<input name=\"${1:${TM_SELECTED_TEXT:ColumnName}}\" type=\"text\" value=\"<%# DataBinder.Eval(Container.DataItem, \"${1:${TM_SELECTED_TEXT:ColumnName}}\"${8:, \"{0:C\\}\"}) %>\" size=\"\" maxlength=\"\" />\n\t}</EditItemTemplate>}\n</asp:TemplateColumn>"},
 "function" => 
  {scope: "source.asp",
   name: "Function",
   content: 
    "Function ${1:Process}(${2:This_Item} As ${3:String}) As ${4:Boolean}\n\tReturn ${5:True}$0\nEnd Function\n"},
 "sql" => 
  {scope: "source.asp",
   name: "SqlCommand",
   content: 
    "Dim $4_CON As New System.Data.SQLClient.SQLConnection(System.Configuration.ConfigurationSettings.AppSettings(\"MM_CONNECTION_STRING_${2:CFC_LIVE}\"))\nDim $4_COM As New System.Data.SQLClient.SqlCommand( \"${1:${TM_SELECTED_TEXT:UPDATE Users SET Clue = 1 WHERE username = 'taylott'}}\", $4_CON)\n$4_COM.Connection.Open()\n$4_COM.ExecuteNonQuery()\n$4_COM.Connection.Close()\n"},
 nil => 
  {scope: "source.asp -string",
   name: "vbUpperCase",
   content: "StrConv(${1:${TM_SELECTED_TEXT:\"String\"}}, vbUpperCase)"},
 "sub" => 
  {scope: "source.asp",
   name: "Sub",
   content: 
    "sub ${2:Process}(${2:sender as Object, e as EventArgs})\n\t${1:${TM_SELECTED_TEXT:'Do that thing you do}}$0\nend sub\n"},
 "#" => 
  {scope: "text.html.asp.net",
   name: "# Container.DataItem",
   content: 
    "<%# DataBinder.Eval(Container.DataItem, \"${1:${TM_SELECTED_TEXT:ColumnName}}\"${2:, \"{0:C\\}\"}) %>$0"},
 "format" => 
  {scope: "source.asp",
   name: "String.Format()",
   content: 
    "${3:String.Format(\"${2:{0:c\\}}\", ${1:${TM_SELECTED_TEXT:price}})}"},
 "IIf" => 
  {scope: "text.html.asp",
   name: "If then HTML",
   content: 
    "<% if ${2:Is_This_True?} %>${1:${TM_SELECTED_TEXT:True}}${4:<% else %>$3}<% end if %>$0"},
 "datagrid" => 
  {scope: "text.html.asp",
   name: "MM:DataGrid Sort Page Search",
   content: 
    "${9:<div id=\"search_${1:Orders}\">\n  <form action=\"\" method=\"get\">\n    Search <input name=\"s\" value=\"<%= Request.Querystring(\"s\") %>\" />\n    <input type=\"submit\" value=\"Search ${1:Orders}\" />\n  </form>\n</div>\n}<div id=\"${1:Orders}\">\n${7:\t<%@ Register TagPrefix=\"MM\" Namespace=\"DreamweaverCtrls\" Assembly=\"DreamweaverCtrls,version=1.0.0.0,publicKeyToken=836f606ede05d46a,culture=neutral\" %>\n\t<mm:pagebind runat=\"server\" PostBackBind=\"true\" />\n}\t<mm:dataset ID=\"${1:Orders}\"\n\t runat=\"Server\"\n\t IsStoredProcedure=\"false\"\n\t ConnectionString='<%# System.Configuration.ConfigurationSettings.AppSettings(\"MM_CONNECTION_STRING_${3:Common_LIVE}\") %>'\n\t DatabaseType='<%# System.Configuration.ConfigurationSettings.AppSettings(\"MM_CONNECTION_DATABASETYPE_${3:Common_LIVE}\") %>'\n\t CommandText='<%# \"${2:select * from users where clue is not null}    ORDER BY \"+ IIf((Not Request.Querystring(\"sortOn\") Is Nothing), Request.Querystring(\"sortOn\"), \"${4:username}\") +\" \"+ Request.Querystring(\"sortDir\") %>'\n\t Debug=\"true\" PageSize=\"25\"\n\t >\n\t\t<parameters>${5:\n\t\t\t<parameter  name=\"@s\"  value='<%# \"%\" + IIf((Not Request.Querystring(\"s\") Is Nothing), Request.Querystring(\"s\"), \"\") + \"%\" %>'  type=\"VarChar\"   />\n\t\t}</parameters>\n\t</mm:dataset>\n\t<script runat=\"server\">\n\tSub ${1:Orders}_sortCommand(sender as Object, e as DataGridSortCommandEventArgs)\n\t\tdim sortDir as string = \"\"\n\t\tif Request.QueryString(\"sortOn\") = e.SortExpression then\n\t\t\tif (Request.QueryString(\"sortDir\") = \"\")\n\t\t\t\tsortDir = \"ASC\"\n\t\t\telse if (Request.QueryString(\"sortDir\") = \"ASC\")\n\t\t\t\tsortDir = \"DESC\"\n\t\t\telse if (Request.QueryString(\"sortDir\") = \"DESC\")\n\t\t\t\tsortDir = \"ASC\"\n\t\t\tend if\n\t\telse\n\t\t\tsortDir = \"ASC\"\n\t\tend if\n\t\tResponse.Redirect(Request.ServerVariables(\"SCRIPT_NAME\") + \"?sortOn=\" + e.SortExpression + \"&sortDir=\" + sortDir + \"&s=\" + Request.Querystring(\"s\"))\n\tend sub\n\t</script>\n\t<asp:DataGrid ID=\"${1:Orders}_DG\"\n\t\t\t\tDataKeyField=\"${4:username}\"\n\t\t\t\tAutoGenerateColumns=\"true\"\n\t\t\t\t\n\t\t\t\trunat=\"server\"\n\t\t\t\tAllowSorting=\"true\"\n\t\t\t\tOnSortCommand=\"${1:Orders}_sortCommand\"\n\t\t\t\t\n\t\t\t\tDataSource=\"<%# ${1:Orders}.DefaultView %>\"\n\t\t\t\tOnItemDataBound=\"${1:Orders}.OnDataGridItemDataBound\"\n\t\t\t\t\n\t\t\t\tAllowPaging=\"true\"\n\t\t\t\tAllowCustomPaging=\"true\"\n\t\t\t\tPageSize=\"<%# ${1:Orders}.PageSize %>\"\n\t\t\t\tOnPageIndexChanged=\"${1:Orders}.OnDataGridPageIndexChanged\"\n\t\t\t\tvirtualitemcount=\"<%# ${1:Orders}.RecordCount %>\"\n\t\t\t\tPagerStyle-Mode=\"NumericPages\"\n\t\t\t\tPagerStyle-Position=\"${10:Bottom|Top|TopAndBottom}\"\n\t\t\t\t\n\t\t\t\tShowHeader=\"true\"\n\t\t\t\tShowFooter=\"false\"\n\t\t\t\tEnableViewstate=\"false\"\n\t\t>\n\t\t<headerstyle           CssClass=\"headerstyle\"          />\n\t\t<itemstyle             CssClass=\"itemstyle\"            />\n\t\t<alternatingitemstyle  CssClass=\"alternatingitemstyle\" />\n\t\t<footerstyle           CssClass=\"footerstyle\"          />\n\t\t<pagerstyle            CssClass=\"pagerstyle\"           />\n\t\t<columns>\n\t\t\t$0\n\t\t</columns>\n\t</asp:DataGrid>\n</div>\n"},
 "write" => 
  {scope: "source.asp",
   name: "Response.Write()",
   content: 
    "${3:Response.Write(${1:${TM_SELECTED_TEXT:\"Hello World!!!!1!\"}})}"},
 "=" => {scope: "text.html.asp", name: "<%= %>", content: "<%= $0 %>"},
 "p" => 
  {scope: "text.html.asp",
   name: "<%>",
   content: "<%${2:=} ${1:${TM_SELECTED_TEXT:Content}}$0 %>"}}
