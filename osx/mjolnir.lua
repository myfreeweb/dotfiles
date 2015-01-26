-- This came from Greg V's dotfiles:
--      https://github.com/myfreeweb/dotfiles
-- Feel free to steal it, but attribution is nice
--
-- The keys only make sense on the Colemak keyboard layout

local alert = require "mjolnir.alert"
local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"
local screen = require "mjolnir.screen"
local appfinder = require "mjolnir.cmsj.appfinder"
local grid = require "mjolnir.bg.grid"


local hyper = {"cmd", "alt", "ctrl", "shift"}


-- Grid

grid.MARGINX = 2
grid.MARGINY = 2
grid.GRIDHEIGHT = 2
grid.GRIDWIDTH = 6

local gridset = function(x, y, w, h)
	return function()
		local win = window.focusedwindow()
		if win then
			grid.set(win, {x=x, y=y, w=w, h=h}, screen.mainscreen())
		else
			alert.show("No focused window. Check your OS X Accessibility settings. Uncheck and check Mjolnir there if you have moved it.")
		end
	end
end

hotkey.bind(hyper, "q", gridset(0, 0, 4, 1))
hotkey.bind(hyper, "w", gridset(0, 0, 2, 1))
hotkey.bind(hyper, "f", gridset(2, 0, 2, 1))
hotkey.bind(hyper, "p", gridset(4, 0, 2, 1))
hotkey.bind(hyper, "g", gridset(2, 0, 4, 1))

hotkey.bind(hyper, "a", gridset(0, 0, 4, 2))
hotkey.bind(hyper, "r", gridset(0, 0, 2, 2))
hotkey.bind(hyper, "s", gridset(2, 0, 2, 2))
hotkey.bind(hyper, "t", gridset(4, 0, 2, 2))
hotkey.bind(hyper, "d", gridset(2, 0, 4, 2))

hotkey.bind(hyper, "z", gridset(0, 1, 4, 1))
hotkey.bind(hyper, "x", gridset(0, 1, 2, 1))
hotkey.bind(hyper, "c", gridset(2, 1, 2, 1))
hotkey.bind(hyper, "v", gridset(4, 1, 2, 1))
hotkey.bind(hyper, "b", gridset(2, 1, 4, 1))

hotkey.bind(hyper, "1", gridset(0, 0, 3, 2))
hotkey.bind(hyper, "2", gridset(3, 0, 3, 2))

-- App switching

local app_shortcuts = {
	n = "Firefox",
	e = "iTerm",
	i = "Dash",
	o = "Mail"
}

for key, app_name in pairs(app_shortcuts) do
	hotkey.bind(hyper, key, function()
		appfinder.app_from_name(app_name):activate()
	end)
end
