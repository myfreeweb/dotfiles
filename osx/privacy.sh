#!/bin/sh
# Thanks:
#  https://github.com/drduh/OS-X-Yosemite-Security-and-Privacy-Guide

sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent; vacuum' 2>/dev/null

disable_agent() {
	launchctl unload -w "/System/Library/LaunchAgents/${1}.plist" 2>/dev/null
}

# I don't call from OS X
disable_agent com.apple.CallHistoryPluginHelper
disable_agent com.apple.CallHistorySyncHelper
disable_agent com.apple.telephonyutilities.callservicesd
# I don't play on OS X
disable_agent com.apple.gamed
# I probably don't use this stuff...
disable_agent com.apple.cloudfamilyrestrictionsd-mac
disable_agent com.apple.SafariCloudHistoryPushAgent
disable_agent com.apple.safaridavclient
disable_agent com.apple.security.cloudkeychainproxy
disable_agent com.apple.SocialPushAgent
disable_agent com.apple.cloudphotosd
disable_agent com.apple.CoreLocationAgent
disable_agent com.apple.locationmenu
disable_agent com.apple.EscrowSecurityAlert
disable_agent com.apple.imagent
disable_agent com.apple.IMLoggingAgent
