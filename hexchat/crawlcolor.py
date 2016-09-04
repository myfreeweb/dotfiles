# ##crawl announcements colorizer for HexChat
# by Greg V, https://unrelenting.technology
#
# Regexps from the original Irssi script:
#  https://voyager.lupomesky.cz/crawl/irssi-colorizer/

from __future__ import print_function
from functools import reduce # ugh python 3 what are you doing

import re
import hexchat

__module_name__ = 'Crawl Color'
__module_version__ = '1.0'
__module_description__ = 'Colorizes ##crawl bot announcements'

BOTS = {
    'Henzell':  (' CAO', 10),
    'Gretell':  (' CDO', 3 ),
    'Sizzell':  ('CSZO', 1 ),
    'Lantell':  (' CUE', 6 ),
    'Ruffell':  (' RHF', 7 ),
    'Rotatell': ('CBRO', 2 ),
    'Eksell':   (' CXC', 9 ),
    'Jorgrell': (' CJR', 5 ),
}

REPLACEMENTS = list(map(lambda rx: (re.compile(rx[0]), rx[1]), [
    (r'^([a-zA-Z0-9_]+ the [^ ]+) \((L\d{1,2} \w{4})\)', '\x02\\1\x02\x0F (\x03\\2\x0F)'),
    (r'^([a-zA-Z0-9_]+) \((L\d{1,2} \w{4})\)', '\x02\\1\x02\x0F (\x03\\2\x0F)'),
    (r'became a worshipper of (.+)\.', '\x0310became a worshipper of \x02\\1\x02.\x0F'),
    (r'became the champion of (.+)\.', '\x0310\x02became the champion of \\1\x02.\x0F'),
    (r'abandoned (.+)\.', '\x0310abandoned \\1.\x0F'),
    (r'mollified (.+)\.', '\x0310mollified \\1.\x0F'),
    (r'([\w\s,]+) (by|to|blew themself up|shot themself with|dead) (.+) (on|in) (.+), with (\d+ points) after (\d+ turns) and ([0-9:,]+)\.',
     '\x035\\1 \\2 \x02\\3\x02 \\4 \x02\\5\x02, with \x02\\6\x02 after \x02\\7\x02 and \x02\\8\x02.'),
    (r'killed (.+)\.', '\x037killed \\1.\x0F'),
    (r'banished (.+)\.', '\x037banished \\1.\x0F'),
    (r'found (a|an) (\w+) rune of Zot\.', 'found \\1 \x02\\2 rune\x0F of Zot.'),
    (r'(.*)quit the game (in|on) (.+), with (\d+ points) after (\d+ turns) and ([0-9:,]+)\.',
     '\x035\\1quit the game \\2 \x02\\3\x02, with \x02\\4\x02 after \x02\\5\x02 and \x02\\6\x02.\x0F'),
    (r'entered (.*)\.', '\x036entered \x02\\1\x02.\x0F'),
    (r'was cast into the Abyss!', '\x036was cast into \x02the Abyss!\x0F'),
    (r'entered the Abyss!', '\x036entered \x02the Abyss\x02!\x0F'),
    (r'escaped from the Abyss!', '\x036escaped from the Abyss!\x0F'),
    (r'escaped \(hah\) into the Abyss!', '\x036escaped (hah) into \x02the Abyss\x02!\x0F'),
    (r'fell down a shaft to (.+).', '\x036fell down a shaft to \x02\\1\x02.\x0F'),
    (r'reached (level \d{1,2}) of ((|the )[\w\s]+)\.', '\x036reached \x02\\1\x02 of \x02\\2\x02.\x0F'),
    (r'left a Ziggurat at level (\d+)\.', '\x036left \x02a Ziggurat\x02 at level \x02\\1\x02.\x0F'),
    (r'found the Orb of Zot!', '\x02found the Orb of Zot!\x02'),
    (r'([\w\s,]+)escaped with the Orb and (\d{1,2}) runes, with (\d+ points) after (\d+ turns) and ([0-9:,]+)\.',
     '\\1\x16escaped with the Orb and \\2 runes\x16, with \x02\\3\x02 after \x02\\4\x02 and \x02\\5\x02.'),
]))

def on_message(word, word_eol, userdata):
    if hexchat.get_info('channel') == '##crawl':
        msg_nick, msg_text = word[:2]
        if msg_nick in BOTS:
            msg_nick = "\x02\x03{}{}\x02".format(
                BOTS[msg_nick][1],
                BOTS[msg_nick][0]
            )
            msg_text = reduce(lambda s, rx: rx[0].sub(rx[1], s), REPLACEMENTS, msg_text)
            hexchat.emit_print("Channel Message", msg_nick, msg_text, "@")
            return hexchat.EAT_ALL

hexchat.hook_print('Channel Message', on_message)
print("\x0304", __module_name__, "successfully loaded.\x03")
