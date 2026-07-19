# Lenovo-yoga-9-14LL10-audio-workaround:
The Lenovo Yoga Slim 9 (83CX) exposes `Speaker` and `Bass Speaker` as separate ALSA controls, but the default ALSA UCM profile only updates `Speaker`, leaving the woofers out of sync. This Fish script listens for PipeWire volume events and mirrors the current sink volume to `Bass Speaker` with near-zero CPU usage. 

also this was vibe coded with gpt so isnt too pretty
