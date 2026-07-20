#!/usr/bin/env fish

set --global card 0
set --global last_value -1

function sync_bass
    # Allow PipeWire/ALSA to finish updating Speaker first.
    sleep 0.05

    set speaker_value (
        amixer -c $card sget Speaker 2>/dev/null |
        string match -r 'Front Left: Playback [0-9]+' |
        head -n 1 |
        string replace -r '.*Playback ' ''
    )

    if test -z "$speaker_value"
        return
    end

    if test "$speaker_value" = "$last_value"
        return
    end

    set --global last_value $speaker_value
    amixer -q -c $card sset "Bass Speaker" $speaker_value
end

sync_bass

pactl subscribe | while read --local event
    if string match --quiet '*change*on sink*' "$event"
        sync_bass
    end
end
