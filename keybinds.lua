local mod = "SUPER"

---@function Binding keys shorthand
---@param keys string
---@param action function | HL.Dispatcher
---@param options ? HL.BindOptions
local function bind_key(keys, action, options)
	hl.bind(mod .. " + " .. keys, action, options)
end

--- Focus
bind_key("H", hl.dsp.focus({ direction = "l" }))
bind_key("L", hl.dsp.focus({ direction = "r" }))
bind_key("J", hl.dsp.focus({ direction = "d" }))
bind_key("K", hl.dsp.focus({ direction = "u" }))

--- Workspace
bind_key("CTRL + J", hl.dsp.focus({
	workspace = "r+1", on_current_monitor = true
}))
bind_key("CTRL + K", hl.dsp.focus({
	workspace = "r-1", on_current_monitor = true
}))

for i = 1, 9 do
	local keycode = i + 9;
	bind_key("code:" .. keycode, hl.dsp.focus({ workspace = "m~" .. i }))
	bind_key("SHIFT + code:" .. keycode, hl.dsp.window.move({ workspace = "m~" .. i }))
end

--- Window
bind_key("Q", hl.dsp.window.close())
bind_key("SHIFT + Q", hl.dsp.window.kill())
bind_key("M", hl.dsp.window.fullscreen())
bind_key("F", hl.dsp.window.float({ action = "toggle" }))
bind_key("C", hl.dsp.window.center())

bind_key("SHIFT + H", hl.dsp.window.move({ direction = "l" }))
bind_key("SHIFT + L", hl.dsp.window.move({ direction = "r" }))
bind_key("SHIFT + J", hl.dsp.window.move({ direction = "d" }))
bind_key("SHIFT + K", hl.dsp.window.move({ direction = "u" }))

bind_key("CTRL + SHIFT + J", hl.dsp.window.move({ workspace = "r+1" }))
bind_key("CTRL + SHIFT + K", hl.dsp.window.move({ workspace = "r-1" }))

bind_key("CTRL + L", hl.dsp.window.resize({ x = 10, y = 0, relative = true, window = "activeWindow" }))
bind_key("CTRL + H", hl.dsp.window.resize({ x = -10, y = 0, relative = true, window = "activeWindow" }))

--- Mouse Binds
bind_key("mouse:272", hl.dsp.window.drag(), {
	mouse = true,
})
bind_key("mouse:273", hl.dsp.window.resize(), {
	mouse = true,
})

--- Touchpad binds
hl.gesture({
	fingers = 3,
	direction = "vertical",
	action = "workspace"
})

--- Managing hyprland
bind_key("DELETE", hl.dsp.exit())

--- Key Utilities
bind_key("RETURN", hl.dsp.exec_cmd("kitty"))
