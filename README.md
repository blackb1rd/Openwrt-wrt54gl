Openwrt-wrt54gl
===================
This project based on kamikaze(revision 18801) and development for kernel 2.4(brcm-2.4)

Why kernel 2.4?
===================
- support repeater mode.
- support WDS(Wireless distribution system) mode.
- kernel 2.6 has a more bugs. ref [ticket #7768](https://dev.openwrt.org/ticket/7768) [ticket #9029](https://dev.openwrt.org/ticket/9029)

Building OpenWrt Kamikaze
===================
1. Install packages required by the OpenWrt Kamikaze buildsystem  [ref. http://wiki.openwrt.org/doc/howto/buildroot.exigence](http://wiki.openwrt.org/doc/howto/buildroot.exigence)

2. Downloading Sources
```shell
git clone https://github.com/rainb0wb1rd/Openwrt-wrt54gl.git
```

3. Downloading and Installing Feeds(Optional)
```shell
./scripts/feeds update
./scripts/feeds install PACKAGENAME
```

4. Configure Kamikaze (select target system) and the packages
```shell
make menuconfig
```

5. Finally build Kamikaze
```
make
```

Troubleshooting
===================
Building error with package Luci
- removing `local variant` in file `build_dir/mipsel/luci-0.8.8/build/mkversion.sh`
