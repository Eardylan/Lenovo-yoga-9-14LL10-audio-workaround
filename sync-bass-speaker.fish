#!/usr/bin/env fish

set card 0
set last_volume ""

function sync_bass
    set volume (
        pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null |
        string match -r '[0-9]+%' |
        head -n 1 |
        string replace '%' ''
    )

    if test -z "$volume"
        return
    end

    if test "$volume" = "$last_volume"
        return
    end

    set --global last_volume "$volume"
    amixer -q -c $card set "Bass Speaker" "$volume%"
end

sync_bass

pactl subscribe | while read --local event
    if string match --quiet '*on sink*' "$event"
        sync_bass
    end
end
