# snapcast-termux

This is my config to get snapcast working on android with termux and librespot. Requires the device to be rooted.

# Setup

```bash
pkg update && pkg upgrade
```

```bash
pkg install git snapcast-server ffmpeg libandroid-spawn
```

```bash
git clone https://github.com/woliver99/snapcast-termux.git
```

```bash
bash "./snapcast-termux/setup.sh"
```

```bash
source "$HOME/.bashrc"
```

```bash
snapserver-start.sh
```

# Info

You might be wondering why im resampling librespot through ffmpeg. Currently Snap.Net iOS has a [bug](https://github.com/stijnvdb88/Snap.Net/issues/52) where it will crash if its not the default sampleformat. So i just end up resampling the librespot audio witch is 44.1kHz to 48kHz instead of properly fixing the problem.

# TODO:

-   Restart librespot stream after snapcast restart, Use: https://github.com/librespot-org/librespot-java/tree/dev/api
