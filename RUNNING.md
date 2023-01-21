Notes About Using These Images
==============================

This is a collection of random tidbits regarding peculiarities of this image
and hardware.


## First Boot

First boot might take a little while (though not minutes), there's a rootfs
growing initramfs hook running called `resizerootfs` that you can disable after
first boot.


## Default Login

Username `pleb` with password `pleb`, you will be immediately prompted to change
your password the moment you log in.


## Use Wayland

If you want to get graphics acceleration, you must use Wayland. Panfrost is not
really tested on X11. You can still run X11 applications through XWayland.

As for how to install the Wayland versions of various desktop environments,
please consult [the Debian wiki](https://wiki.debian.org/Wayland).

(For Plasma, remember to choose "Wayland" on the bottom left on the login screen!)


## Firefox

To get a better experience in Firefox, you'll want to run it with
`MOZ_ENABLE_WAYLAND=1`. Export that in some script that gets run, e.g. on Plasma,
a script in `~/.config/plasma-workspace/env/`.

You'll then want to force WebRender on in `about:config`, but I forgor 💀 how to
do that.


## Known Limitations

Here are some known limitations of either software or hardware you should know
about before scratching your head for hours trying to figure out what's wrong.

### Quartz64 Model A - Bad USB 3

Due to a hardware bug involving the shared signal lines for SATA and USB 3 on
Quartz64 Model A, only very short USB 3 cables will work, and some devices may
not work at all. It's due to signalling problems. A revised Model A that gets
rid of the SATA port to fix this issue will be manufactured eventually.

### Limited HDMI Resolutions

Only a select few display output modes work, among them 1080p60. A notable
absence is 4K; your 4K monitor will likely just fall back to its 1080p mode.
This is a limitation of the mainline kernel's HDMI driver for the Rockchip
platforms, and needs consideration for older (buggier) Rockchip boards before
it can be fixed.

### Video Decode Acceleration

Only the Hantro hardware block in the RK3566 is active in mainline right now,
as we do not yet have a driver for rkvdec2. This means that while you get
VP8, MPEG-2 and H.264 (up to 1080p) decode acceleration, 4K H.264, VP9 and HEVC
are still missing.

The API the hardware decoding uses is v4l2-requests. This is a fairly new API
with limited userspace support. GStreamer has support for it, but FFmpeg does
not yet have upstream code to utilise it. Notably, this means that opening a
YouTube video in your web browser while looking at your CPU usage in a task
manager is not a proper way to evaluate whether hardware decoding is working,
as browsers do not yet support this API.

### Wi-Fi

Plebian (or Debian, for that matter) does not yet properly package the wireless
firmware needed for the Model B or SOQuartz's Wi-Fi chip. Therefore, Wi-Fi won't
work out of the box.
