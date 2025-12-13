-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

local _M = {}
local modkey = RC.vars.modkey

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

-- {{{ Key bindings

function _M.get(globalkeys)
  -- Bind all key numbers to tags.
  -- Be careful: we use keycodes to make it work on any keyboard layout.
  -- This should map on the top row of your keyboard, usually 1 to 9.
  for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
    
      --  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
      -- View tag only.
      awful.key({ modkey }, "#" .. i + 9,
        function ()
          local screen = awful.screen.focused()
          local tag = screen.tags[i]
          if tag then
            tag:view_only()
          end
        end,
        {description = "view tag #"..i, group = "tag"}),

      --  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
      -- Toggle tag display.
      awful.key({ modkey, "Control" }, "#" .. i + 9,
        function ()
          local screen = awful.screen.focused()
          local tag = screen.tags[i]
          if tag then
            awful.tag.viewtoggle(tag)
          end
        end,
        {description = "toggle tag #" .. i, group = "tag"}),
      
      --  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
      -- Move client to tag.
      awful.key({ modkey, "Shift" }, "#" .. i + 9,
        function ()
          if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then
              client.focus:move_to_tag(tag)
            end
          end
        end,
        {description = "move focused client to tag #"..i, group = "tag"}),
      
      --  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
      -- Toggle tag on focused client.
      awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
        function ()
          if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then
              client.focus:toggle_tag(tag)
            end
          end
        end,
        {description = "toggle focused client on tag #" .. i, group = "tag"})

      --  -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

    -- --------------------------
    -- 🔊 AUDIO (PULSEAUDIO/PipeWire)
    -- --------------------------

    awful.key({}, "XF86AudioRaiseVolume",
        function() awful.spawn("pamixer -i 5") end,
        {description = "volume up", group = "audio"}),

    awful.key({}, "XF86AudioLowerVolume",
        function() awful.spawn("pamixer -d 5") end,
        {description = "volume down", group = "audio"}),

    awful.key({}, "XF86AudioMute",
        function() awful.spawn("pamixer -t") end,
        {description = "toggle mute", group = "audio"}),

    awful.key({}, "XF86AudioMicMute",
        function() awful.spawn("pamixer --default-source -t") end,
        {description = "toggle microphone", group = "audio"}),

    awful.key({}, "XF86AudioPlay",
        function() awful.spawn("playerctl play-pause") end,
        {description = "play/pause", group = "media"}),

    awful.key({}, "XF86AudioNext",
        function() awful.spawn("playerctl next") end,
        {description = "next track", group = "media"}),

    awful.key({}, "XF86AudioPrev",
        function() awful.spawn("playerctl previous") end,
        {description = "previous track", group = "media"}),

    -- --------------------------
    -- 💡 BRIGHTNESS
    -- --------------------------

    awful.key({}, "XF86MonBrightnessUp",
        function() awful.spawn("brightnessctl set +10%") end,
        {description = "brightness up", group = "brightness"}),

    awful.key({}, "XF86MonBrightnessDown",
        function() awful.spawn("brightnessctl set 10%-") end,
        {description = "brightness down", group = "brightness"}),

    -- --------------------------
    -- 🔒 LOCK SCREEN
    -- --------------------------
    awful.key({ modkey, "Control" }, "l",
        function() awful.spawn("i3lock-fancy") end,
        {description = "lock screen", group = "system"}),

    -- --------------------------
    -- 🔋 BATTERY INFO
    -- --------------------------
    awful.key({ modkey, "Shift" }, "b",
        function() awful.spawn.easy_async_with_shell("acpi -b", function(out)
            naughty.notify({ title = "Battery", text = out })
        end) end,
        {description = "show battery status", group = "system"}),

    -- --------------------------
    -- 🖥 SYSTEM (reboot/shutdown)
    -- --------------------------
    awful.key({ modkey, "Control" }, "s",
        function() awful.spawn("systemctl suspend") end,
        {description = "suspend", group = "system"}),

    awful.key({ modkey, "Control" }, "p",
        function() awful.spawn("systemctl poweroff") end,
        {description = "power off", group = "system"}),

    awful.key({ modkey, "Control" }, "r",
        function() awful.spawn("systemctl reboot") end,
        {description = "reboot", group = "system"})
    )
  end

  return globalkeys
end
-- }}}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
