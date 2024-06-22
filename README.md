# snapcast-termux

My config to get snapcast working on android with termux and librespot. Requires the device to be rooted.

# Setup

```bash
pkg update && pkg upgrade
```

```bash
pkg install git snapcast ffmpeg
```

```bash
git clone https://github.com/yourusername/snapcast-termux.git
```

```bash
bash "./snapcast-termux/setup.sh"
```

```bash
snapserver-start.sh
```

# TODO:

-   Restart librespot stream after snapcast restart, Use: https://github.com/librespot-org/librespot-java/tree/dev/api
