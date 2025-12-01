-- Standard awesome library
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Theme handling library
local beautiful = require("beautiful")

local M = {}  -- menu
local _M = {} -- module

local terminal = RC.vars.modkey
local editor = RC.vars.editor
local editor_cmd = RC.vars.editor_cmd

M.awesome = {
    { "hotkeys", function()
        hotkeys_popup.show_help(nil, awful.screen.focused())
    end },
    { "manual",          terminal .. " -e man awesome" },
    { "edit config",     editor_cmd .. " " .. awesome.conffile },
    { "Terminal",        terminal },
    { "Shutdown/Logout", "oblogout" },
    { "restart",         awesome.restart },
    { "quit",            function() awesome.quit() end }
}

function _M.get()
    local menu_items = {
        { "awesome",       M.awesome, beautiful.awesome_subicon }
        { "open terminal", terminal }
    }

    return menu_items
end

return setmetatable(
    {},
    { __call = function(_, ...) return _M.get(...) end }
)
