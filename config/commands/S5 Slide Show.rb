# Encoding: UTF-8

[{beforeRunningCommand: "saveActiveFile",
  command: 
   "#!/usr/bin/env ruby\nrequire \"\#{ENV['TM_BUNDLE_SUPPORT']}/lib/s5.rb\"\nprint S5.new(STDIN.readlines.join).to_html",
  input: "document",
  keyEquivalent: "^H",
  name: "Convert to HTML",
  output: "openAsNewDocument",
  scope: "source.s5, source.s5 text.html.markdown",
  uuid: "C1EC9501-B96E-4E6E-8F0A-2BECF19D0F30"},
 {beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\nrequire 'fileutils'\n\nsrc = ENV['TM_BUNDLE_SUPPORT'] + \"/ui\"\ndst = ENV['TM_DIRECTORY']\n\nabort \"This action only works for saved documents.\" if dst.nil?\nabort \"The S5 ‘ui’ directory already exists.\"       if File.directory?(dst + \"/ui\")\n\nbegin\n  FileUtils.cp_r(src, dst)\n  puts \"Theme files copied successfully.\"\nrescue Exception => e\n  puts \"Error copying files to “\#{dst}”.\", e\nend\n",
  input: "none",
  name: "Copy Theme to Document Location",
  output: "showAsTooltip",
  scope: "source.s5",
  uuid: "8B63721C-EDE4-42D4-8589-B6EA1D4F2D5B"},
 {beforeRunningCommand: "nop",
  command: 
   ". \"$TM_SUPPORT_PATH/lib/webpreview.sh\"\nhtml_header \"S5 Slide Show Help\" \"S5 Slide Show\"\n\"$TM_SUPPORT_PATH/lib/markdown_to_help.rb\" <<'EOF'|SmartyPants.pl\n\nS5 is a slide show format based entirely on XHTML, CSS, and JavaScript. To read all about S5, visit the [S5 project web site][3].\n\n# Getting Started\n\nThe best way to start a new presentation is to use the \"New from Template\" option from the \"File\" menu, choosing \"S5 Presentation\" from the \"S5\" menu. This will give you a basic presentation file which you can then start modifying.\n\nTo quickly enter a new slide, type \"slide\" and hit the tab key. If you just want to create the dividing marker inbetween slides, type \"cut\" and hit the tab key.\n\nThe formatting of the slides themselves is Markdown, which is pretty ideal for entering lots of bullet lists and headings. S5 does support most any HTML you enter into the slide as well, including images. Refer to the [S5 project site][3] for further documentation on writing slides.\n\n# Headers\n\nThe S5 document format supports a set of \"header\" lines that are always placed at the top of the document. These provide extra metadata regarding the presentation itself. If you create a blank presentation using the above instructions, you will see some of these. The list of headers you may specify include:\n\n* Title - The title of the presentation.\n* Subtitle - The subtitle of the presentation (optional).\n* Presenter (or Author) - Your name or the name of the person that will be presenting the presentation.\n* Company (or Organization) - The name of the presenter's company.\n* Location - The location where the presentation will be given.\n* Date - The date the presentation will be given.\n* Controls - Specifies whether the navigation controls are always visible or not. The value for this should be either \"hidden\" or \"visible\" (the default is to be visible).\n* View - Specifies the default view of the presentation. Should be either \"slideshow\" or \"outline\" (the default is \"slideshow\").\n* Theme - The name of a S5 theme directory. This should be a directory name that contains a S5 compatible theme. The directory should be immediately under the \"ui\" directory (see Directory Layout section below). The default value for theme is \"default\".\n\nHeader lines are written with the heading keyword followed with a colon (\":\") and then the value for the keyword follows.\n\n    Title: Presentation title\n\nMany of these headings are optional, but some are required in the sense that omitting them will adversely affect the appearance of the presentation.\n\n# Content Layout\n\nS5 supports placing \"handout\" and \"note\" sections within individual slides. You can notate these portions of a slide using the \"note\" and \"hand\" tab-triggered snippets. For example, a slide with text, handout and notes would look like this:\n\n    Slide Text\n\n    __________\n\n    Handout section\n\n    ##########\n\n    Presentation notes.\n\nThe presentation notes are displayed in the popup-notes/control window that is new to S5 1.2.\n\nHandout notes are included when printing the presentation.\n\n# Commands\n\n* **Present**: Formats the presentation and opens it in your web browser.\n* **Convert to HTML**: Converts the presentation into HTML, creating a new document.\n* **Copy theme files**: Places a copy of the S5 support files into the same directory where your presentation resides.\n\n# Directory Layout\n\nThe S5 bundle includes a copy of the S5 default theme. Executing the \"Present\" command will load the default theme files from the S5 Bundle directory. If you want to include a copy of the S5 support files with your presentation document, use the \"Copy theme files\" command to make a copy of the S5 support files into the directory your presentation document is in. Additional custom themes can be copied into the \"ui\" folder. The theme can be specified using the \"Theme\" header (as described above). If you have a file named \"MyPresentation.s5\", the S5 \"ui\" folder should be placed in the same folder, and the directory would look something like this:\n\n<pre>MyPresentation.s5\nui/\nui/s5-notes.html\nui/default/\nui/default/blank.gif\nui/default/bodybg.gif\nui/default/framing.css\nui/default/iepngfix.htc\nui/default/opera.css\nui/default/notes.css\nui/default/outline.css\nui/default/pretty.css\nui/default/print.css\nui/default/s5-core.css\nui/default/slides.css\nui/default/slides.js\n</pre>\n\nNote that if your presentation is part of a TextMate project, the S5 Bundle will look for the \"ui\" directory first in the directory of your presentation file and if not found there, it will also check the top-level project directory as well.\n\n# Credits\n\nThis bundle is maintained by [Brad Choate][1]. The S5 CSS and HTML framework was developed by [Eric Meyer][2]. Many additional resources regarding S5, including documentation and additional themes may be found at the [S5 project site][3].\n\n[1]: http://bradchoate.com/\n[2]: http://www.meyerweb.com/eric/\n[3]: http://www.meyerweb.com/eric/tools/s5/\n\nEOF\nhtml_footer",
  fallbackInput: "scope",
  input: "none",
  name: "Help",
  output: "showAsHTML",
  scope: "source.s5",
  uuid: "0A8006CB-834C-4AC5-BAFE-672EB5F19417"},
 {beforeRunningCommand: "saveActiveFile",
  command: 
   "#!/usr/bin/env ruby\nrequire \"\#{ENV['TM_BUNDLE_SUPPORT']}/lib/s5.rb\"\ns5 = S5.new(STDIN.readlines.join)\nhtml = s5.to_html\nslide_anchor = ''\nif s5.current_slide_number\n  slide_anchor = \"#slide\#{s5.current_slide_number}\"\nend\nfilename = ENV['TM_FILEPATH'].dup\nif (filename =~ /\\.s5$/)\n  filename.sub!(/\\.s5$/, '.html')\nelse\n  filename += '.html'\nend\nFile.open(filename, \"w\") do | fout |\n  fout.print html\nend\nfilename.gsub!(/ /, '%20')\n%x{open file://\#{filename}\#{slide_anchor}}\nexit 200",
  input: "document",
  keyEquivalent: "^@p",
  name: "Present",
  output: "showAsTooltip",
  scope: "source.s5",
  uuid: "171DDC95-11B1-4044-80E3-328589A4994A"}]
