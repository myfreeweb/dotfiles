#!/bin/sh
#
# PROVIDE: klaus
# REQUIRE: SERVERS cleanvar
# BEFORE: nginx
# KEYWORD: shutdown
#

. /etc/rc.subr

name=klaus
rcvar=klaus_enable

load_rc_config ${name}

: ${klaus_enable:="NO"}
: ${klaus_user="www"} # User to run daemon as
: ${klaus_group="www"} # Group to run daemon as
: ${klaus_pidfile="/var/run/klaus/klaus.pid"} # Path to pid file
: ${klaus_socket="/var/run/klaus/klaus.sock"} # Path to socket

command=/usr/local/bin/uwsgi
command_args="-w klauswsgireload --master --socket ${klaus_socket} --die-on-term --daemonize /dev/stdout --logger syslog:uwsgi_klaus --pidfile2 ${klaus_pidfile} --uid ${klaus_user} --gid ${klaus_group} --enable-threads --queue 16 --env KLAUS_SITE_NAME='unrelenting.technology/git' --env KLAUS_REPOS='/home/dovahkiin/src/github.com/myfreeweb' --env KLAUS_USE_SMARTHTTP=1"
procname=/usr/local/bin/uwsgi
pidfile=${klaus_pidfile}

run_rc_command "$1"
