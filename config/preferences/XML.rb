# Encoding: UTF-8

[{name: "Comments",
  scope: "text.xml",
  settings: 
   {shellVariables: 
     [{name: "TM_COMMENT_START", value: "<!-- "},
      {name: "TM_COMMENT_END", value: " -->"}]},
  uuid: "41A5608C-C589-411E-9581-548D7DE335AC"},
 {name: "Miscellaneous",
  scope: "text.xml",
  settings: 
   {comment: 
     "\n    /*\n     * Don't indent:\n     *  <?, </, <!\n     *  <whatever></whatever>\n     *  <whatever />\n     *  <% %>\n     *  <!-- -->\n     *  <%-- --%>\n     *\n     * Do indent:\n     *  <whatever>\n     *  <%\n     *  <!--\n     *  <%--\n     *\n     * Decrease indent for:\n     *  </whatever>\n     *  -->\n     *  --%>\n     */",
    decreaseIndentPattern: "^\\s*(</[^>]+>|-->|--%>)",
    highlightPairs: 
     [["(", ")"], ["[", "]"], ["{", "}"], ["\"", "\""], ["<", ">"]],
    increaseIndentPattern: 
     "^\\s*<(([^!/?]|%)(?!.+?([/%]>|</.+?>))|[%!]--\\s*$)"},
  uuid: "95788610-7E2E-45CE-9CCE-708FE0C90BF7"},
 {name: "Symbol List: Templates",
  scope: "text.xml.xsl meta.tag.xml.template",
  settings: 
   {showInSymbolList: 1,
    symbolTransformation: "s/^\\s*<xsl:template\\s+(.*)\\s*>/$1/"},
  uuid: "0B6F39CC-AF39-46CD-85FB-7F895D14F04A"}]
