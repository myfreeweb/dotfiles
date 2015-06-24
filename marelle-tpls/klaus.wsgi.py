# https://github.com/jonashaag/klaus/blob/master/klaus/contrib/wsgi_autoreload.py
# + fix bugs + use kqueue instead of polling, because polling is bad

import os
import waitress
from klaus import make_app
from watchdog.events import FileSystemEventHandler
from watchdog.observers import Observer

global reload
reload = True

class ReloadEventHandler(FileSystemEventHandler):
    def dispatch(self, event):
        global reload
        reload = True

repos_root = "/home/freebsd/src/github.com/myfreeweb"

observer = Observer()
observer.daemon = True
observer.schedule(ReloadEventHandler(), repos_root, recursive=False)
observer.start()

global inner_app
inner_app = None

def application(environ, start_response):
    global inner_app
    global reload
    if reload:
        inner_app = make_app(
            [os.path.join(repos_root, x) for x in os.listdir(repos_root)],
            "unrelenting.technology/git",
            "1",
            None
        )
        reload = False
    return inner_app(environ, start_response)

waitress.serve(application, unix_socket="/var/run/klaus/klaus.sock",
               unix_socket_perms='660',
               url_prefix="/git")
