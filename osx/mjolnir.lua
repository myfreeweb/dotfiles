local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"
local screen = require "mjolnir.screen"
local appfinder = require "mjolnir.cmsj.appfinder"
local grid = require "mjolnir.sd.grid"

local hyper = {"cmd", "alt", "ctrl", "shift"}

grid.MARGINX = 2
grid.MARGINY = 2

local gridset = function(x, y, w, h)
	return function()
		grid.set(window.focusedwindow(), {x=x, y=y, w=w, h=h}, screen.mainscreen())
	end
end


hotkey.bind(hyper, "q", gridset(0, 0, 2, 1))
hotkey.bind(hyper, "w", gridset(0, 0, 1, 1))
hotkey.bind(hyper, "f", gridset(1, 0, 1, 1))
hotkey.bind(hyper, "p", gridset(2, 0, 1, 1))

hotkey.bind(hyper, "a", gridset(0, 0, 2, 2))
hotkey.bind(hyper, "r", gridset(0, 0, 1, 2))
hotkey.bind(hyper, "s", gridset(1, 0, 1, 2))
hotkey.bind(hyper, "t", gridset(2, 0, 1, 2))

hotkey.bind(hyper, "z", gridset(0, 1, 2, 1))
hotkey.bind(hyper, "x", gridset(0, 1, 1, 1))
hotkey.bind(hyper, "c", gridset(1, 1, 1, 1))
hotkey.bind(hyper, "v", gridset(2, 1, 1, 1))

local app_shortcuts = {
	n = "Nightly",
	e = "iTerm",
	i = "Dash",
	o = "Mail"
}

for key, app_name in pairs(app_shortcuts) do
	hotkey.bind(hyper, key, function()
		appfinder.app_from_name(app_name):activate()
	end)
end
