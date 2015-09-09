# coding: utf-8
# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
# Feel free to steal it, but attribution is nice
#
# thanks:
# https://github.com/zacharyvoase/dotfiles/blob/master/pythonrc
# https://github.com/sontek/dotfiles/blob/master/_pythonrc.py
# http://brianlyttle.com/2011/10/python-interpreter-tab-completion-on-os-x/
# http://stackoverflow.com/questions/7116038/python-tab-completion-mac-osx-10-7-lion

import rlcompleter
import subprocess
import readline
import inspect
import atexit
import sys
import os
home = os.environ["HOME"]

def _nope(what):
    sys.stdout.write("\x1b[31m✗ %s\x1b[0m  " % what)

def _yep(what):
    sys.stdout.write("\x1b[32m✔ %s\x1b[0m  " % what)

try:
    from see import see
    _yep("see")
except ImportError:
    _nope("see")

def src(obj):
    def highlight(source):
        try:
            import pygments
            import pygments.formatters
            import pygments.lexers
        except ImportError:
            return source
        lexer = pygments.lexers.get_lexer_by_name('python')
        formatter = pygments.formatters.terminal.TerminalFormatter()
        return pygments.highlight(source, lexer, formatter)
    source = inspect.getsource(obj)
    pager = subprocess.Popen(['less', '-R'], stdin=subprocess.PIPE)
    pager.communicate(highlight(source))
    pager.wait()

try:
    class TabCompleter(rlcompleter.Completer):
        """Completer that supports indenting"""
        def complete(self, text, state):
            if not text:
                return ('    ', None)[state]
            else:
                return rlcompleter.Completer.complete(self, text, state)
    readline.set_completer(TabCompleter().complete)
    readline.set_history_length(1000)
    if 'libedit' in readline.__doc__:
        readline.parse_and_bind("bind '\t' rl_complete")
    else:
        readline.parse_and_bind(open("%s/.inputrc" % home).read())
    HISTFILE = "%s/.tmp/history_python" % home
    try:
        readline.read_history_file(HISTFILE)
    except: pass
    atexit.register(readline.write_history_file, HISTFILE)
    _yep("rlcompleter")
except:
    _nope("rlcompleter")

if "DJANGO_SETTINGS_MODULE" in os.environ:
    from django.db.models.loading import get_models
    from django.test.client import Client
    from django.test.utils import setup_test_environment, teardown_test_environment
    from django.conf import settings as S

    class DjangoModels(object):
        """Loop through all the models in INSTALLED_APPS and import them."""
        def __init__(self):
            for m in get_models():
                setattr(self, m.__name__, m)

    M = DjangoModels()
    C = Client()
    _yep("django")

sys.stdout.write("\n")
