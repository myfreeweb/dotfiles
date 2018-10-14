#!/usr/bin/env python3
# Thanks:
#  https://pthree.org/2011/03/24/hashcash-and-mutt/

from email.generator import Generator
from email.parser import FeedParser
from email.utils import getaddresses
import fileinput
import subprocess
import sys
import os

filename = sys.argv[1]
subprocess.call("%s %s" % (os.environ.get("EDITOR", "vim"), filename), shell=True)

parser = FeedParser()
for line in fileinput.FileInput(filename, inplace=1):
    parser.feed(line)
msg = parser.close()

# Harvest all email addresses from the header
# Bcc ignored for privacy reasons / can't do multiple mails from editor script
addrs = lambda h: [m[1].lower() for m in getaddresses(msg.get_all(h, []))]
email_addrs = set(addrs("To")).union(set(addrs("Cc")))

# Check if an appropriate token is already generated for the mail
for hash in msg.get_all("X-Hashcash", []):
    email_addrs.discard(hash.split(":")[3])

# Call the hashcash function from the operating system to mint tokens
for email in email_addrs:
    t = subprocess.Popen("hashcash -mq -Z 2 %s" % email, shell=True, stdout=subprocess.PIPE)
    cash = t.stdout.read()
    if sys.version_info[0] >= 3:
        cash = cash.decode('utf-8')
    msg["X-Hashcash"] = cash.strip()

# Write out the message!
with open(filename, 'w') as msg_out:
    Generator(msg_out, mangle_from_=False).flatten(msg)
