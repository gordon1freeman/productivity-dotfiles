-- Monitors
hl.monitor({
          output   = "eDP-1",
          mode     = "1920x1200@120.00Hz",
          position = "0x0",
          scale    = "1",
      })
-- Programs
local terminal    = "kitty"
local fileManager = "nautilus"
local menu        = "wofi --show drun"
local browser     = "zen-browser"

-- Autostart
hl.on("hyprland.start", function ()
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")
    hl.exec_cmd("waybar")
    hl.exec_cmd("mako")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("wl-paste --watch cliphist store")
end)

-- Environment
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")

-- Main config
hl.config({
    general = {
        gaps_in  = 10,
        gaps_out = 20,
        border_size = 2,
        col = {
            active_border   = { colors = { "rgba(a7c080ee)", "rgba(83c092ee)" }, angle = 45 },
            inactive_border = "rgba(272e33ee)",
        },
        resize_on_border = false,
        allow_tearing    = false,
        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        blur = {
            enabled = true,
            size    = 3,
            passes  = 6,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    scrolling = {
        fullscreen_on_one_column = true,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },

    input = {
        kb_layout    = "us,ru",
        kb_variant   = "",
        kb_model     = "",
        kb_options   = "grp:alt_shift_toggle",
        kb_rules     = "",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.curve("smooth", { type = "bezier", points = { { 0.22, 1 }, { 0.36, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "smooth" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "smooth" })
hl.animation({ leaf = "border", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "smooth" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "smooth", style = "slidefade" })

-- Keybinds
local mainMod = "SUPER"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + W",     hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + E",     hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + Q",     hl.dsp.window.close())
hl.bind(mainMod .. " + F",     hl.dsp.window.fullscreen())

-- Launcher & utilities
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd("bash -c 'pkill wofi || wofi --show drun'"))
hl.bind(mainMod .. " + TAB",   hl.dsp.exec_cmd("bash -c 'pkill wofi || ~/.config/hypr/scripts/window-switch.sh'"))
hl.bind(mainMod .. " + R",     hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + V",     hl.dsp.exec_cmd("bash -c 'cliphist list | wofi --dmenu | cliphist decode | wl-copy'"))
hl.bind(mainMod .. " + M",     hl.dsp.exec_cmd("bash -c 'pkill wlogout || wlogout -p layer-shell -b 2'"))
hl.bind(mainMod .. " + L",     hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + N",     hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-float.sh notes kitty --class=notes -e micro /home/kir/notes.md"))
hl.bind(mainMod .. " + grave", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-float.sh dropdown kitty --class=dropdown"))

-- Screenshots
hl.bind("Print",       hl.dsp.exec_cmd([[bash -c 'F="${HOME}/Pictures/screenshots/SS$(date +%Y-%m-%d_%H-%M-%S).png"; grim "$F" && wl-copy < "$F"']]))
hl.bind("CTRL + Print", hl.dsp.exec_cmd([[bash -c 'F="${HOME}/Pictures/screenshots/SS$(date +%Y-%m-%d_%H-%M-%S).png"; grim -g "$(slurp)" "$F" && wl-copy < "$F"']]))

-- Window management
hl.bind(mainMod .. " + SHIFT + Space",  hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P",              hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J",              hl.dsp.layout("togglesplit"))

-- Focus
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move window within workspace
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

-- Workspaces
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Mouse
hl.bind(mainMod .. " + mouse_down",   hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",     hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272",    hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273",    hl.dsp.window.resize(), { mouse = true })

-- Hardware (locked + repeating)
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),       { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),    { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                   { locked = true, repeating = true })
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"),                                  { locked = true })
hl.bind("XF86AudioPause",        hl.dsp.exec_cmd("playerctl play-pause"),                            { locked = true })
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"),                            { locked = true })
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"),                              { locked = true })

-- Window rules
hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

hl.window_rule({
    name   = "notes-float",
    match  = { class = "notes" },
    float  = true,
    size   = "monitor_w*0.6 monitor_h*0.6",
    center = true,
})

hl.window_rule({
    name  = "dropdown-float",
    match = { class = "dropdown" },
    float = true,
    size  = "monitor_w monitor_h*0.3",
    move  = "0 0",
})

-- Layer rules (blur)
hl.layer_rule({ name = "wofi-blur", match = { namespace = "wofi" }, blur = true })
hl.layer_rule({ name = "wofi-fix",  match = { namespace = "wofi" }, ignore_alpha = 0.2 })
