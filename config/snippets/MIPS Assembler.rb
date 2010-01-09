# Encoding: UTF-8

{"hello" => 
  {scope: "source.mips",
   name: "Hello World (mips)",
   content: 
    "#  a basic example in mips-assembler: hello world.\n#  tested with xspim-7.0\n   \n\t.text\n\t.globl main\n\t\nmain:\n\tli       \\$v0, 4            # call = 4 = print_string\n\tla       \\$a0, hello_string # set \\$a0 to point to the string\n\tsyscall                    # print it.\n\tli       \\$v0, 10           # call = 10 = exit\n\tsyscall                    # done.\n\t\n\t\n\t.data\n\t\nhello_string:  .asciiz  \"Hello World!\"\n$1"}}
