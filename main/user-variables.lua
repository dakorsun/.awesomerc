local home = os.getenv("HOME")

-- {{{ Variable definitions
-- @DOC_LOAD_THEME@
-- Themes define colours, icons, font and wallpapers.
local _M = {

    terminal = "alacritty",

    -- Default modkey.
    -- Usually, Mod4 is the key with a logo between Control and Alt.
    -- If you do not like this or do not have such a key,
    -- I suggest you to remap Mod4 to another key using xmodmap or other tools.
    -- However, you can use another modifier like Mod1, but it may interact with others.
    modKey = "Mod1",

    editor = os.getenv("EDITOR") or "vim",
    editor_cmd = terminal .. " -e " .. editor
}

return _M
-- }}}
