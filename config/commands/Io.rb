# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\nrequire ENV[\"TM_SUPPORT_PATH\"] + \"/lib/tm/executor\"\nrequire ENV[\"TM_SUPPORT_PATH\"] + \"/lib/tm/save_current_document\"\n\nTextMate.save_current_document\nTextMate::Executor.make_project_master_current_document\n\nTextMate::Executor.run(ENV[\"TM_IO\"] || \"io\", ENV[\"TM_FILEPATH\"], :version_args => [\"2>&1\", '<<< \"System version; System exit;\"'])\n",
  input: "document",
  keyEquivalent: "@r",
  name: "Run Script",
  output: "showAsHTML",
  scope: "source.io",
  uuid: "F35C936A-92CD-4D36-925D-F4457A52BCEE"}]
