# Device Tree Overlays On Plebian

Since release v2023-02-28-1, Plebian supports using device tree overlays. In
short, device tree overlays are snippets to adjust the hardware description
used by the kernel to interface with non-self-enumerating devices such as I²C
and SPI. This hardware description is called the device tree, and overlays
modify this base device tree.

The usual reason to use device tree overlays is to interface with some sensor
or output device that uses I²C, I²S or SPI. However, you can also use it for
other purposes.


## Prerequisites

You'll need to be using Plebian release v2023-02-28-1 or newer, and have the
`devicetrees-plebian-quartz64` package installed. The latter is required for
the device trees to have the necessary symbols to be overlaid onto; if you're
building a custom kernel, pass `DTC_FLAGS="-@"` to your invocation of `make`.

It's also good to have the package `device-tree-compiler` installed in order to
be able to build device tree overlays.


## Example Overlays

You can find a set of example overlays for various boards, including a build
system for them, at <https://github.com/CounterPillow/overlay-examples>.

Ignore the "Installing" section of that README; it doesn't apply to Plebian in
the same way.


## Installing Device Tree Overlays

There are two methods of installing the overlays.

Method 1 is to simply place the `.dtbo` file into the `/boot/dtbo/` directory,
creating said directory if it doesn't already exist. Then run `u-boot-update`
and the device tree blob overlay will be picked up.

Method 2 conflicts with Method 1, and is to explicitly specify which device
tree overlay files you want to use. You'll still place your `.dtbo` files into
`/boot/dtbo/`, but edit `/etc/default/u-boot` to contain the line

```
U_BOOT_FDT_OVERLAYS="your-overlay-here.dtbo additional-separated-by-space.dtbo"
```

Note the lack of a `#` at the beginning of the line. After editing your file
like this, run `u-boot-update` to regenerate your `extlinux.conf`.

Method 2 will not pick up any `.dtbo` files *not* listed in the
`U_BOOT_FDT_OVERLAYS` variable. Any value of that variable other than it
being empty counts as it no longer automatically picking up whatever is in
`/boot/dtbo/`.


## Applying The Overlays

Device tree overlays are applied by u-boot. Therefore, it's necessary to reboot
in order for them to be applied.
