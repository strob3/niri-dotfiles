local currentLabel = ""
local refreshPending = false

local function renderIndicator(label)
    local container = barWidget.isVertical() and ui.column or ui.row

    barWidget.render(
        container({ gap = 6, align = "center" }, {
            ui.glyph({
                name = "keyboard",
                size = 18,
            }),
            ui.label({
                text = label,
            }),
        })
    )
end

local function refresh()
    if refreshPending then
        return
    end

    refreshPending = true

    local command = [[
        state=$(fcitx5-remote 2>/dev/null)
        im=$(fcitx5-remote -n 2>/dev/null)
        printf '%s|%s' "$state" "$im"
    ]]

    noctalia.runAsync(command, function(result)
        refreshPending = false

        if result.exitCode ~= 0 then
            return
        end

        local state, im = result.stdout:match(
            "^%s*(%d+)|([^%s\r\n]+)"
        )

        if not state then
            return
        end

        local label = "EN"

        if state == "2" and im == "mozc" then
            label = "あ"
        end

        if label ~= currentLabel then
            currentLabel = label
            renderIndicator(label)
        end

        barWidget.setTooltip(
            "Fcitx5: " .. label ..
            "\nClick to toggle input state"
        )
    end)
end

function update()
    noctalia.setUpdateInterval(1000)
    refresh()
end

function onClick()
    noctalia.runAsync(
        { "fcitx5-remote", "-t" },
        function()
            refresh()
        end
    )
end