if test -z "$WAYLAND_DISPLAY"; and test "$(tty)" = /dev/tty1
    exec uwsm start hyprland.desktop
end

function fish_greeting
end

if command -v zoxide >/dev/null 2>&1
    zoxide init fish | source
end

if command -v fzf >/dev/null 2>&1
    fzf_key_bindings
end

function fish_prompt
    set_color normal
    echo -n (prompt_pwd)

    if git rev-parse --is-inside-work-tree >/dev/null 2>&1
        echo -n (set_color 859289) (git branch --show-current)
    end

    echo -n (set_color normal) " ❯ "
end
