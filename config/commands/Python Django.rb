# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "if [ $TM_SELECTED_TEXT]\nthen\n\topen \"http://www.google.com/search?as_q=$TM_SELECTED_TEXT&as_sitesearch=www.djangoproject.com\"\nelse\n\topen \"http://www.google.com/search?as_q=$TM_CURRENT_WORD&as_sitesearch=www.djangoproject.com\"\nfi",
  input: "none",
  keyEquivalent: "^h",
  name: "Search online documentation",
  output: "discard",
  scope: "source.python.django, text.html.django",
  uuid: "5F79A28E-E2FA-4266-A069-2983B8828C04"}]
