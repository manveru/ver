# Encoding: UTF-8

[{beforeRunningCommand: "nop",
  command: 
   "#!/usr/bin/env ruby\nrequire 'strscan'\n\ndef indent\n  \" \" * $indent * 4\nend\n\ns = StringScanner.new(STDIN.read)\nbrace_stack = []\ncomma_needed = false\nfirst_line = true\n$indent = 0\nuntil s.eos?\n  if s.scan(/\\{/m)\n    if comma_needed then puts \",\" else puts end\n    comma_needed = false\n    print indent + \"{\"\n    first_line = false\n    $indent += 1\n    brace_stack.push \"{\"\n  elsif s.scan(/\\}/m)\n    $indent -= 1\n    print \"\\n\" + indent + \"}\"\n    if (b = brace_stack.pop) != \"{\"\n      puts \"Expected '}' (\#{brace_stack.inspect} / \#{b})\"\n      exit -1\n    end\n  elsif s.scan(/\\[/m)\n    if comma_needed then puts \",\" else puts end\n    comma_needed = false\n    print indent + \"[\"\n    $indent += 1\n    brace_stack.push \"[\"\n  elsif s.scan(/\\]/m)\n    $indent -= 1\n    print \"\\n\" + indent + \"]\"\n    if (b = brace_stack.pop) != \"[\"\n      puts \"Expected ']' (\#{brace_stack.inspect} / \#{b})\"\n      exit -2\n    end\n  elsif s.scan(/,/m)\n    comma_needed = true\n    #print \"==\#{brace_stack.inspect}==\"\n    #puts (brace_stack.last == \"{\" ? \"\" : indent) + \",\"\n  else\n    if comma_needed then puts \",\" else puts end\n    comma_needed = false\n    print indent + s.scan(/[^{}\\[\\],]+/m)\n  end\nend",
  input: "selection",
  keyEquivalent: "^H",
  name: "Reformat Document / Selection",
  output: "replaceSelectedText",
  scope: "source.json",
  uuid: "4B74F2DE-E051-4E8D-9124-EBD90A2CDD2B"}]
