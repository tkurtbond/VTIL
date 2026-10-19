# The VAX/VMS system's login, by telnet, for tools/vax-dcl.exp and
# tools/vtil-run.exp, modeled on Peaseblossom's tools/vax-login.tcl:
# "source" it, then "vax_login $host", which leaves the session at the
# prompt "VTILDCL> " ($prompt, a regular expression), or exits 2 with a
# message.  The login and password are read here from $VAX_NETRC (by
# default ~/.netrc-vtil-vax), never from a command line, and nothing is
# shown while the password is sent (log_user 0).

proc netrc_file {} {
  if {[info exists ::env(VAX_NETRC)] && $::env(VAX_NETRC) ne ""} { return $::env(VAX_NETRC) }
  return [file join $::env(HOME) .netrc-vtil-vax]
}

# login and password of "machine $host" in the netrc file
proc netrc {host} {
  if {[catch {open [netrc_file] r} f]} { fail "cannot read [netrc_file]" }
  set tokens [regexp -all -inline {\S+} [read $f]]
  close $f
  set login ""; set password ""; set here 0
  for {set i 0} {$i < [llength $tokens]} {incr i} {
    set t [lindex $tokens $i]
    if {$t eq "machine"} {
      if {$here && $login ne ""} break
      incr i; set here [expr {[lindex $tokens $i] eq $host}]
    } elseif {$t eq "default"} {
      if {$here && $login ne ""} break
      set here 0
    } elseif {$here && $t eq "login"} {
      incr i; set login [lindex $tokens $i]
    } elseif {$here && $t eq "password"} {
      incr i; set password [lindex $tokens $i]
    }
  }
  return [list $login $password]
}

proc fail {message} {
  puts stderr "[file rootname [file tail $::argv0]]: $message"
  exit 2
}

proc vax_login {host} {
  global spawn_id expect_out prompt
  lassign [netrc $host] login password
  if {$login eq "" || $password eq ""} { fail "no login and password for $host in [netrc_file]" }
  set saved [log_user]
  log_user 0
  spawn -noecho telnet $host
  expect {
    -re {Username: ?$} {}
    timeout { fail "no Username: prompt from $host" }
    eof { fail "telnet to $host closed" }
  }
  send "$login\r"
  expect {
    -re {Password: ?$} {}
    timeout { fail "no Password: prompt from $host" }
  }
  send "$password\r"
  unset password
  set prompt {\n\$ $}
  set answered 0
  expect {
    -re $prompt {}
    -re "\033(Z|\\\[0?c)" {
      if {!$answered} { send "\033\[?1;2c"; set answered 1 }
      exp_continue
    }
    -re {User authorization failure} { fail "login to $host refused" }
    timeout { fail "no DCL prompt after logging in to $host" }
  }
  send "SET PROMPT=\"VTILDCL> \"\r"
  set prompt {VTILDCL> $}
  expect {
    -re $prompt {}
    timeout { fail "SET PROMPT was not answered" }
  }
  log_user $saved
}
