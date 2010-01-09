# Encoding: UTF-8

{"Unix.err" => {scope: "source.ocaml", name: "stderr", content: "Unix.stderr"},
 "Unix.ai_" => 
  {scope: "source.ocaml", name: "Socket type", content: "Unix.ai_socktype"},
 "Unix.SOB_" => 
  {scope: "source.ocaml",
   name: "Report whether socket listening is enabled",
   content: "Unix.SO_ACCEPTCONN"},
 "Unix.NI_" => 
  {scope: "source.ocaml",
   name: "Fail if host name cannot be determined",
   content: "Unix.NI_NAMEREQD"},
 "Unix.addr" => 
  {scope: "source.ocaml",
   name: "string_of_inet_addr",
   content: "Unix.string_of_inet_addr ${1:inet_addr}$0"},
 "Unix.fstat" => 
  {scope: "source.ocaml", name: "stat", content: "Unix.stat ${1:file_name}$0"},
 "Unix.SIG_" => 
  {scope: "source.ocaml",
   name: "Unblocked listed signals",
   content: "Unix.SIG_UNBLOCK"},
 "Unix.SHUTDOWN_" => 
  {scope: "source.ocaml",
   name: "Close socket for sending",
   content: "Unix.SHUTDOWN_SEND"},
 "Unix.open_" => 
  {scope: "source.ocaml",
   name: "Writes complete as ‘Synchronised I/O file integrity completion’",
   content: "Unix.O_SYNC"},
 "Unix.SOCK_" => 
  {scope: "source.ocaml", name: "Stream socket", content: "Unix.SOCK_STREAM"},
 "Unix.tm" => 
  {scope: "source.ocaml", name: "Year-1900", content: "Unix.tm_year"},
 "Unix.ITIMER_" => 
  {scope: "source.ocaml",
   name: "Decrement interval timer in virtual time",
   content: "Unix.ITIMER_VIRTUAL"},
 "Unix.term_" => 
  {scope: "source.ocaml",
   name: "Strip 8th bit on input characters",
   content: "Unix.c_istrip"},
 "Unix.AI_" => 
  {scope: "source.ocaml",
   name: "Set address to \"any\" for bind",
   content: "Unix.AI_PASSIVE"},
 "Unix.fperm" => 
  {scope: "source.ocaml", name: "umask", content: "Unix.umask ${1:mask}$0"},
 "Unix.FLUSH" => 
  {scope: "source.ocaml",
   name: "tcflush",
   content: "Unix.flush ${1:file_descr} Unix.FLUSH$0"},
 "Unix.ADDR_" => 
  {scope: "source.ocaml",
   name: "Unix domain socket address",
   content: "Unix.ADDR_UNIX ${1:name}$0"},
 "Unix.PF_" => 
  {scope: "source.ocaml", name: "Unix socket domain", content: "Unix.PF_UNIX"},
 "Unix.it_" => 
  {scope: "source.ocaml",
   name: "Interval timer current value",
   content: "Unix.it_value"},
 "Unix.LargeFile" => 
  {scope: "source.ocaml",
   name: "LargeFile.truncate",
   content: "Unix.LargeFile.truncate ${1:file_name} ${2:i64}$0"},
 "Unix.lock_t" => 
  {scope: "source.ocaml", name: "Unlock a region", content: "Unix.F_ULOCK"},
 "Unix.MSG_" => 
  {scope: "source.ocaml", name: "MSG_PEEK", content: "Unix.MSG_PEEK"},
 "Unix.SOI_" => 
  {scope: "source.ocaml",
   name: "Size of send buffer",
   content: "Unix.SO_SNDBUF"},
 "Unix.ni_" => 
  {scope: "source.ocaml",
   name: "Name of service or port number",
   content: "Unix.ni_service"},
 "Unix.FLOW" => 
  {scope: "source.ocaml", name: "Suspend output", content: "Unix.TCOOFF"},
 "Unix.fseek" => 
  {scope: "source.ocaml",
   name: "truncate",
   content: "Unix.truncate ${1:file_name} ${2:len}$0"},
 "Unix.TCSA" => 
  {scope: "source.ocaml",
   name: "Set term attribute now",
   content: "Unix.TCSANOW"},
 "Unix.proc" => 
  {scope: "source.ocaml",
   name: "waitpid",
   content: "Unix.waitpid [${1:wait_flags}] ${2:pid}$0"},
 "Unix.tms" => 
  {scope: "source.ocaml",
   name: "User time for process",
   content: "Unix.tms_utime"},
 "Unix.SOF_" => 
  {scope: "source.ocaml",
   name: "Timeout for output operations",
   content: "Unix.SO_SNDTIMEO"},
 "Unix.SOIO_" => 
  {scope: "source.ocaml",
   name: "Whether to linger on closed connections and for how long",
   content: "Unix.SO_LINGER"},
 "Unix.sock" => 
  {scope: "source.ocaml",
   name: "socketpair",
   content: "Unix.socketpair Unix.PF_$0 Unix.SOCK_ ${1:proto}"},
 "Unix.time" => 
  {scope: "source.ocaml",
   name: "utimes",
   content: 
    "Unix.utimes ${1:file_name} ${2:last_access_time} ${3:last_modified_time}${4:;}$0"},
 "Unix.dir" => 
  {scope: "source.ocaml",
   name: "rmdir",
   content: "Unix.rmdir ${1:dir_name}$0"},
 "Unix.fd" => 
  {scope: "source.ocaml",
   name: "set_nonblock",
   content: "Unix.set_nonblock ${1:file_descr}$0"},
 "Unix.file" => 
  {scope: "source.ocaml",
   name: "write",
   content: "Unix.write ${1:file_descr} ${2:buf} ${3:ofs} ${4:len}$0"},
 "Unix.run" => 
  {scope: "source.ocaml",
   name: "open_process_out",
   content: "Unix.open_process_out ${1:prog}$0"},
 "Unix.fch" => 
  {scope: "source.ocaml",
   name: "out_channel_of_descr",
   content: "Unix.out_channel_of_descr ${1:file_descr}$0"},
 "Unix.env" => 
  {scope: "source.ocaml",
   name: "putenv",
   content: "Unix.putenv ${1:ENV_VAR} ${2:value}$0"},
 "Unix.error" => 
  {scope: "source.ocaml",
   name: "handle_unix_error",
   content: "Unix.handle_unix_error ${1:func} ${2:arg}$0"},
 "Unix.connect" => 
  {scope: "source.ocaml",
   name: "shutdown_connection",
   content: "Unix.shutdown_connection ${1:in_channel}${2:;}$0"},
 "Unix.info" => 
  {scope: "source.ocaml",
   name: "getaddrinfo",
   content: "Unix.getaddrinfo ${1:host} ${2:service} ${3:[Unix.AI_$0]}"},
 "Unix.id" => 
  {scope: "source.ocaml",
   name: "setuid",
   content: "Unix.setuid ${1:uid}${2:;}$0"},
 "Unix.host" => 
  {scope: "source.ocaml",
   name: "getservbyport",
   content: "Unix.getprototbynumber ${1:port} ${2:proto_name}$0"},
 "Unix.sockopt" => 
  {scope: "source.ocaml",
   name: "setsockopt_optint",
   content: 
    "Unix.setsockopt_optint ${1:sock} Unix.SOIO_$0 ${2:value_option};"},
 "Unix.gr" => 
  {scope: "source.ocaml", name: "groups : passwd", content: "Unix.gr_passwd"},
 "Unix.h_" => 
  {scope: "source.ocaml", name: "hosts: name", content: "Unix.h_name"},
 "Unix.sig" => 
  {scope: "source.ocaml",
   name: "sigsuspend",
   content: "Unix.sigsuspend ${1:[${2:signal_list;}]}${3:;}$0"},
 "Unix.fn" => 
  {scope: "source.ocaml",
   name: "unlink",
   content: "Unix.unlink ${1:file_name}$0"},
 "Unix.lock" => 
  {scope: "source.ocaml",
   name: "lockf",
   content: "Unix.lockf ${1:file_descr} Unix.lock_t$0 ${2:size}"},
 "Unix.pipe" => 
  {scope: "source.ocaml", name: "pipe", content: "Unix.pipe ()${1:;}$0"},
 "Unix.pw" => 
  {scope: "source.ocaml", name: "passwd : uid", content: "Unix.pw_uid"},
 "Unix.p_" => 
  {scope: "source.ocaml",
   name: "protocols: protocol",
   content: "Unix.p_proto"},
 "Unix.link" => 
  {scope: "source.ocaml",
   name: "symlink",
   content: "Unix.symlink ${1:src_name} ${2:dest_name}$0"},
 "Unix.select" => 
  {scope: "source.ocaml",
   name: "select",
   content: 
    "Unix.select ${1:[${2:read_descr_list;}]} ${3:[${4:write_descr_list;}]} ${5:[${6:exceptional_descr_list;}]} ${7:timeout_float}$0"},
 "Unix.s_" => 
  {scope: "source.ocaml", name: "services: protocol", content: "Unix.s_proto"},
 "Unix.term" => 
  {scope: "source.ocaml",
   name: "terminal_io record",
   content: 
    "{ Unix.c_ignbrk = ${1:true}\n; Unix.c_brkint = ${2:true}\n; Unix.c_ignpar = ${3:true}\n; Unix.c_parmrk = ${4:true}\n; Unix.c_inpck  = ${5:true}\n; Unix.c_istrip = ${6:true}\n; Unix.c_inlcr  = ${7:true}\n; Unix.c_igncr  = ${8:true}\n; Unix.c_icrnl  = ${9:true}\n; Unix.c_ixon   = ${10:true}\n; Unix.c_ixoff  = ${11:true}\n; Unix.c_opost  = ${12:true}\n; Unix.c_obaud  = ${13:true}\n; Unix.c_ibaud  = ${14:true}\n; Unix.c_csize  = ${15:true}\n; Unix.c_cstopb = ${16:true}\n; Unix.c_cread  = ${17:true}\n; Unix.c_parenb = ${18:true}\n; Unix.c_parodd = ${19:true}\n; Unix.c_hupcl  = ${20:true}\n; Unix.c_clocal = ${21:true}\n; Unix.c_isig   = ${22:true}\n; Unix.c_icanon = ${23:true}\n; Unix.c_noflsh = ${24:true}\n; Unix.c_echo   = ${25:true}\n; Unix.c_echoe  = ${26:true}\n; Unix.c_echok  = ${27:true}\n; Unix.c_echonl = ${28:true}\n; Unix.c_vintr  = ${29:true}\n; Unix.c_vquit  = ${30:true}\n; Unix.c_verase = ${31:true}\n; Unix.c_vkill  = ${32:true}\n; Unix.c_veof   = ${33:true}\n; Unix.c_veol   = ${34:true}\n; Unix.c_vmin   = ${35:true}\n; Unix.c_vtime  = ${36:true}\n; Unix.c_vstart = ${37:true}\n; Unix.c_vstop  = ${38:true}\n}$0"},
 "Unix.in" => {scope: "source.ocaml", name: "stdin", content: "Unix.stdin"},
 "Unix.out" => {scope: "source.ocaml", name: "stdout", content: "Unix.stdout"}}
