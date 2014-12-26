Openwrt-wrt54gl
===================
This project based on kamikaze(revision 18801) and development for kernel 2.4(brcm-2.4)

How different original kamikaze?
===================
- Support Secure Digital High Capacity (SDHC).
- Upgrade binutils to new version.
- Fixed bug compiling error in Luci package.

Why brcm-2.4?
===================
- Support repeater mode.
- Support WDS(Wireless distribution system) mode.
- brcm47xx can't mount SDcard on extroot [ticket #7768](https://dev.openwrt.org/ticket/7768).
- brcm47xx has a problem with driver wireless.
- brcm47xx has a more bugs. ref [ticket #9029](https://dev.openwrt.org/ticket/9029) [ticket #14114](https://dev.openwrt.org/ticket/14114) [ticket #12767](https://dev.openwrt.org/ticket/12767)

Building OpenWrt Kamikaze
===================
1. Install packages required by the OpenWrt Kamikaze buildsystem
   [http://wiki.openwrt.org/doc/howto/buildroot.exigence](http://wiki.openwrt.org/doc/howto/buildroot.exigence)

2. Downloading Sources
   ```shell
   git clone https://github.com/blackb1rd/Openwrt-wrt54gl.git
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
