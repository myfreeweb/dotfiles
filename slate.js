slate.src('~/Code/dotfiles/reslate/reslate.js');
// $.debug = true;

slate.alias('hyper', 'ctrl;shift;alt;cmd');

slate.configAll({
  keyboardLayout: 'colemak',
  defaultToCurrentScreen: true,
  nudgePercentOf: 'screenSize',
  resizePercentOf: 'screenSize',
  secondsBetweenRepeat: 0.1,
  undoOps: [
    'active-snapshot',
    'chain',
    'grid',
    'layout',
    'move',
    'resize',
    'sequence',
    'shell',
    'push'
  ]
});

slate.bindAll({
  hyper: {
    n: $.focus('Nightly'),
    e: $.focus('iTerm'),
    i: $.focus('Dash'),
    o: $.focus('Finder'),
    k: $.focus('iTunes'),
    m: $.focus('Textual'),
    'return': $('center', 'center'),
    z: 'undo',
    tab: 'hint'
  }
});
