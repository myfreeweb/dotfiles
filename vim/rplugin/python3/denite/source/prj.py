import os
from os.path import join
from .base import Base

class Source(Base):
    def __init__(self, vim):
        super().__init__(vim)
        self.name = 'prj'
        self.kind = 'directory'

    def gather_candidates(self, context):
        with open(join(os.environ['HOME'], '.cache/repo-list'), 'r') as f:
            return [{'word': path.strip(),
                     'action__path': join('~/src/', path.strip())}
                    for path in f.readlines()]
