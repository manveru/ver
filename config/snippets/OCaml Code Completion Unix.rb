# Encoding: UTF-8

{"Unix.PF_" => 
  {scope: "source.ocaml",
   name: "Internet socket domain",
   content: "Unix.PF_INET"},
 "Unix.in" => {scope: "source.ocaml", name: "stdin", content: "Unix.stdin"},
 "Unix.err" => 
  {scope: "source.ocaml",
   name: "Connection reset by peer",
   content: "Unix.ECONNRESET"},
 "Unix.open_" => 
  {scope: "source.ocaml",
   name: "Open for reading and writing",
   content: "Unix.O_RDWR"},
 "Unix.proc" => 
  {scope: "source.ocaml",
   name: "Wait flag : Don't block if children alive",
   content: "Unix.WNOHANG"},
 "Unix.AI_" => 
  {scope: "source.ocaml",
   name: "Impose the given socket type",
   content: "(Unix.AI_SOCKTYPE UNIX.SOCK_$0)"},
 "Unix.SOI_" => 
  {scope: "source.ocaml",
   name: "Report error status and clear it",
   content: "Unix.SO_ERROR"},
 "Unix.run" => 
  {scope: "source.ocaml",
   name: "create_process",
   content: 
    "Unix.create_process ${1:prog} ${2:[${3:arg_list;}]} ${4:new_stdin_descr} ${5:new_stdout_descr} ${6:new_stderr_descr}$0"},
 "Unix.env" => 
  {scope: "source.ocaml",
   name: "getenv",
   content: "Unix.getenv ${1:ENV_VAR}$0"},
 "Unix.term_" => 
  {scope: "source.ocaml",
   name: "Enable parity generation and detection",
   content: "Unix.c_parenb"},
 "Unix.fseek" => 
  {scope: "source.ocaml",
   name: "lseek",
   content: "Unix.lseek ${1:file_descr} ${2:ofs} Unix.fseek$0"},
 "Unix.ai_" => 
  {scope: "source.ocaml", name: "Socket type", content: "Unix.ai_socktype"},
 "Unix.sock" => 
  {scope: "source.ocaml",
   name: "socketpair",
   content: "Unix.socketpair Unix.PF_$0 Unix.SOCK_ ${1:proto}"},
 "Unix.NI_" => 
  {scope: "source.ocaml",
   name: "Always return host as IP addresss",
   content: "Unix.NI_NUMERICHOST"},
 "Unix.SOB_" => 
  {scope: "source.ocaml",
   name: "Leave out-of-band data in line",
   content: "Unix.SO_OOBINLINE"},
 "Unix.TCSA" => 
  {scope: "source.ocaml",
   name: "Set term attribute now",
   content: "Unix.TCSANOW"},
 "Unix.tm" => 
  {scope: "source.ocaml",
   name: "Day of year (0..365)",
   content: "Unix.tm_yday"},
 "Unix.FLUSH" => 
  {scope: "source.ocaml", name: "Flush both", content: "Unix.TCIOFLUSH"},
 "Unix.fstat" => 
  {scope: "source.ocaml", name: "Directory", content: "Unix.S_DIR"},
 "Unix.s_" => 
  {scope: "source.ocaml", name: "services: name", content: "Unix.s_name"},
 "Unix.fperm" => 
  {scope: "source.ocaml",
   name: "fchown",
   content: "Unix.fchown ${1:file_descr} ${2:uid} ${3:gid}$0"},
 "Unix.fd" => 
  {scope: "source.ocaml",
   name: "set_close_on_exec",
   content: "Unix.set_close_on_exec ${1:file_descr}$0"},
 "Unix.id" => 
  {scope: "source.ocaml",
   name: "getgrnam",
   content: "Unix.getgrnam ${1:name}$0"},
 "Unix.SOF_" => 
  {scope: "source.ocaml",
   name: "Timeout for input operations",
   content: "Unix.SO_RCVTIMEO"},
 "Unix.fch" => 
  {scope: "source.ocaml",
   name: "in_channel_of_descr",
   content: "Unix.in_channel_of_descr ${1:file_descr}$0"},
 "Unix.link" => 
  {scope: "source.ocaml",
   name: "symlink",
   content: "Unix.symlink ${1:src_name} ${2:dest_name}$0"},
 "Unix.host" => 
  {scope: "source.ocaml",
   name: "getprotobynumber",
   content: "Unix.getprototbynumber ${1:proto}$0"},
 "Unix.LargeFile" => 
  {scope: "source.ocaml",
   name: "LargeFile: Last modification time",
   content: "Unix.LargeFile.st_mtime"},
 "Unix.term" => 
  {scope: "source.ocaml",
   name: "terminal_io record",
   content: 
    "{ Unix.c_ignbrk = ${1:true}\n; Unix.c_brkint = ${2:true}\n; Unix.c_ignpar = ${3:true}\n; Unix.c_parmrk = ${4:true}\n; Unix.c_inpck  = ${5:true}\n; Unix.c_istrip = ${6:true}\n; Unix.c_inlcr  = ${7:true}\n; Unix.c_igncr  = ${8:true}\n; Unix.c_icrnl  = ${9:true}\n; Unix.c_ixon   = ${10:true}\n; Unix.c_ixoff  = ${11:true}\n; Unix.c_opost  = ${12:true}\n; Unix.c_obaud  = ${13:true}\n; Unix.c_ibaud  = ${14:true}\n; Unix.c_csize  = ${15:true}\n; Unix.c_cstopb = ${16:true}\n; Unix.c_cread  = ${17:true}\n; Unix.c_parenb = ${18:true}\n; Unix.c_parodd = ${19:true}\n; Unix.c_hupcl  = ${20:true}\n; Unix.c_clocal = ${21:true}\n; Unix.c_isig   = ${22:true}\n; Unix.c_icanon = ${23:true}\n; Unix.c_noflsh = ${24:true}\n; Unix.c_echo   = ${25:true}\n; Unix.c_echoe  = ${26:true}\n; Unix.c_echok  = ${27:true}\n; Unix.c_echonl = ${28:true}\n; Unix.c_vintr  = ${29:true}\n; Unix.c_vquit  = ${30:true}\n; Unix.c_verase = ${31:true}\n; Unix.c_vkill  = ${32:true}\n; Unix.c_veof   = ${33:true}\n; Unix.c_veol   = ${34:true}\n; Unix.c_vmin   = ${35:true}\n; Unix.c_vtime  = ${36:true}\n; Unix.c_vstart = ${37:true}\n; Unix.c_vstop  = ${38:true}\n}$0"},
 "Unix.ITIMER_" => 
  {scope: "source.ocaml",
   name: "Decrement interval timer in virtual time",
   content: "Unix.ITIMER_VIRTUAL"},
 "Unix.p_" => 
  {scope: "source.ocaml", name: "protocols: name", content: "Unix.p_name"},
 "Unix.MSG_" => 
  {scope: "source.ocaml", name: "MSG_PEEK", content: "Unix.MSG_PEEK"},
 "Unix.fn" => 
  {scope: "source.ocaml",
   name: "rename",
   content: "Unix.rename ${1:old_file_name} ${2:new_file_name}$0"},
 "Unix.time" => 
  {scope: "source.ocaml",
   name: "getitimer",
   content: "Unix.getitimer Unix.ITIMER_$0"},
 "Unix.gr" => 
  {scope: "source.ocaml", name: "groups : mem", content: "Unix.gr_mem"},
 "Unix.pipe" => 
  {scope: "source.ocaml",
   name: "mkfifo",
   content: "Unix.mkfifo ${1:pipe_name} 0o${2:644}$0"},
 "Unix.sockopt" => 
  {scope: "source.ocaml",
   name: "setsockopt",
   content: "Unix.setsockopt ${1:sock} Unix.SOB_$0 ${2:true};"},
 "Unix.file" => 
  {scope: "source.ocaml",
   name: "read",
   content: "Unix.read ${1:file_descr} ${2:buf} ${3:ofs} ${4:len}$0"},
 "Unix.it_" => 
  {scope: "source.ocaml",
   name: "Interval timer current value",
   content: "Unix.it_value"},
 "Unix.tms" => 
  {scope: "source.ocaml",
   name: "User time for process",
   content: "Unix.tms_utime"},
 "Unix.SIG_" => 
  {scope: "source.ocaml",
   name: "Unblocked listed signals",
   content: "Unix.SIG_UNBLOCK"},
 "Unix.SOIO_" => 
  {scope: "source.ocaml",
   name: "Whether to linger on closed connections and for how long",
   content: "Unix.SO_LINGER"},
 "Unix.SOCK_" => 
  {scope: "source.ocaml", name: "Raw socket", content: "Unix.SOCK_RAW"},
 "Unix.ni_" => 
  {scope: "source.ocaml",
   name: "Name of service or port number",
   content: "Unix.ni_service"},
 "Unix.lock_t" => 
  {scope: "source.ocaml",
   name: "Lock a region for reading, non-blocking",
   content: "Unix.F_TRLOCK"},
 "Unix.dir" => 
  {scope: "source.ocaml",
   name: "readdir",
   content: "Unix.readdir ${1:dir_handle}$0"},
 "Unix.addr" => 
  {scope: "source.ocaml",
   name: "string_of_inet_addr",
   content: "Unix.string_of_inet_addr ${1:inet_addr}$0"},
 "Unix.info" => 
  {scope: "source.ocaml",
   name: "getaddrinfo",
   content: "Unix.getaddrinfo ${1:host} ${2:service} ${3:[Unix.AI_$0]}"},
 "Unix.h_" => 
  {scope: "source.ocaml", name: "hosts: aliases", content: "Unix.h_aliases"},
 "Unix.pw" => 
  {scope: "source.ocaml", name: "passwd : dir", content: "Unix.pw_dir"},
 "Unix.sig" => 
  {scope: "source.ocaml",
   name: "sigprocmask",
   content: "Unix.sigprocmask Unix.SIG_$0 [${1:signal list}]"},
 "Unix.SHUTDOWN_" => 
  {scope: "source.ocaml",
   name: "Close socket for receiving",
   content: "Unix.SHUTDOWN_RECEIVE"},
 "Unix.ADDR_" => 
  {scope: "source.ocaml",
   name: "Internet domain socket address",
   content: "Unix.ADDR_INET ${1:(${2:addr}, ${3:port})}$0"},
 "Unix.FLOW" => 
  {scope: "source.ocaml",
   name: "Suspend input (send STOP character)",
   content: "Unix.TCIOFF"},
 "Unix.select" => 
  {scope: "source.ocaml",
   name: "select",
   content: 
    "Unix.select ${1:[${2:read_descr_list;}]} ${3:[${4:write_descr_list;}]} ${5:[${6:exceptional_descr_list;}]} ${7:timeout_float}$0"},
 "Unix.connect" => 
  {scope: "source.ocaml",
   name: "open_connection",
   content: "Unix.open_connection Unix.ADDR_$0"},
 "Unix.error" => 
  {scope: "source.ocaml",
   name: "handle_unix_error",
   content: "Unix.handle_unix_error ${1:func} ${2:arg}$0"},
 "Unix.lock" => 
  {scope: "source.ocaml",
   name: "lockf",
   content: "Unix.lockf ${1:file_descr} Unix.lock_t$0 ${2:size}"},
 "Unix.out" => {scope: "source.ocaml", name: "stdout", content: "Unix.stdout"}}
