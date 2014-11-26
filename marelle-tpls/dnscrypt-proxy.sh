#!/bin/sh
#
# PROVIDE: dnscrypt_proxy_%resolver%
# REQUIRE: SERVERS cleanvar
# BEFORE: local_unbound
# KEYWORD: shutdown
#

. /etc/rc.subr

name=dnscrypt_proxy_%name%
rcvar=dnscrypt_proxy_%name%_enable

load_rc_config ${name}

: ${dnscrypt_proxy_%name%_enable:="NO"}
: ${dnscrypt_proxy_%name%_uid="_dnscrypt-proxy"} # User to run daemon as
: ${dnscrypt_proxy_%name%_pidfile="/var/run/dnscrypt-proxy-%resolver%.pid"} # Path to pid file
: ${dnscrypt_proxy_%name%_logfile="/var/log/dnscrypt-proxy-%resolver%.log"} # Path to log file

command=/usr/local/sbin/dnscrypt-proxy
command_args="-d -p ${dnscrypt_proxy_%name%_pidfile} -l ${dnscrypt_proxy_%name%_logfile} -u ${dnscrypt_proxy_%name%_uid} -R %resolver% -a %ip%"
procname=/usr/local/sbin/dnscrypt-proxy
pidfile=${dnscrypt_proxy_%name%_pidfile}

run_rc_command "$1"
