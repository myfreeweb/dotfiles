# https://github.com/jonashaag/klaus/blob/master/klaus/contrib/wsgi_autoreload.py
# + fix bugs + use kqueue instead of polling, because polling is bad

import os
from klaus import make_app
from watchdog.events import FileSystemEventHandler
from watchdog.observers import Observer
import uwsgi

class ReloadEventHandler(FileSystemEventHandler):
    def dispatch(self, event):
        uwsgi.queue_set(1, "RELOAD")

repos_root = os.environ['KLAUS_REPOS']

observer = Observer()
observer.daemon = True
observer.schedule(ReloadEventHandler(), repos_root, recursive=False)
observer.start()

global inner_app
inner_app = None
uwsgi.queue_set(1, "RELOAD")

def application(environ, start_response):
    global inner_app
    if uwsgi.queue_get(1) == "RELOAD":
        inner_app = make_app(
            [os.path.join(repos_root, x) for x in os.listdir(repos_root)],
            os.environ['KLAUS_SITE_NAME'],
            os.environ.get('KLAUS_USE_SMARTHTTP'),
            None
        )
        uwsgi.queue_set(1, "NOTHING")
    return inner_app(environ, start_response)
