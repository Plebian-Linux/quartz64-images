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
