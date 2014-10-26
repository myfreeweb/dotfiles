#!/usr/bin/env python
# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
#
# Thanks:
#  https://pthree.org/2011/03/24/hashcash-and-mutt/

import fileinput
import rfc822
import subprocess
import sys
import os

subprocess.call("%s %s" % (os.environ.get("EDITOR", "vim"), sys.argv[1]), shell=True)

file = open(sys.argv[1], 'r')
headers = rfc822.Message(file)

# Harvest all email addresses from the header
# Bcc ignored for privacy reasons / can't do multiple mails from editor script
addrs = lambda h: map(lambda m: m[1], headers.getaddrlist(h))
email_addrs = set(addrs("To")).union(set(addrs("Cc")))

# Check if an appropriate token is already generated for the mail
if headers.has_key("X-Hashcash"):
    for list in headers.getheaders("X-Hashcash"):
        email_addrs.remove(list.split(":")[3])

# Call the hashcash function from the operating system to mint tokens
tokens = []
for email in email_addrs:
    t = subprocess.Popen("hashcash -mX -Z 2 %s" % email, shell=True, stdout=subprocess.PIPE)
    tokens.append(t.stdout.read().strip())

# Write the newly minted tokens to the header
f = fileinput.FileInput(sys.argv[1], inplace=1)
for line in f:
    line = line.strip()
    print line
    if line.startswith("In-Reply-To"):
        print "\n".join(tokens)

file.close()
