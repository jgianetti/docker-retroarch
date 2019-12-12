# Docker container for Retroarch - Tested on Debian

[Retroarch](https://www.retroarch.com/) is a frontend for emulators, game engines and media players.

## How to use

### Build

Container defaults UID=1000. You can override it at build stage.

```bash
docker build -t retroarch --build-arg UID=$(id -u) .
```

### Simple start

```bash
docker run -it --rm \
    -e DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /etc/machine-id:/etc/machine-id \
    -v $XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse \
    -v $HOME/.config/pulse/cookie:/tmp/pulse_cookie \
    -v $(pwd)/retroarch:/home/developer/retroarch \
    retroarch
```

### About the image

Based on debian-slim, the container runs `retroarch` as the user `developer` (default UID=1000).
It mounts `./retroarch/` at `~/retroarch/` to be able to persist libretro cores and mount roms, among other things.
Use `./retroarch/retroarch.cfg` to define custom settings.

## Parameters explained

### X11 display

To be able to render to the host, the container needs access to the X11 socket.

```bash
    -e DISPLAY
    -v /tmp/.X11-unix:/tmp/.X11-unix
```

### Pulseaudio

To be able to send audio to the host, the container needs access to the machine_id, pulse process and pulse cookie.
The container sets PULSE_COOKIE to `/tmp/pulse_cookie`.

```bash
    -v /etc/machine-id:/etc/machine-id
    -v $XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse
    -v $HOME/.config/pulse/cookie:/tmp/pulse_cookie
```

Mounting the pulse cookie at `$HOME` causes troubles with `$HOME/.config` ownership.
Either way, you can override it at runtime.
