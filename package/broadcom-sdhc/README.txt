Linksys WRT54G/WRT54GS/WRT54GL hardware mod - MMC/SD/SDHC card driver 
 
Version: 2.0.2 
 
Content: 
        Authors 
        Description 
        Building 
        Overlaying root file system 
        Changes / Release Notes 
 
 
Authors: 
 
  Madsuk/Rohde/Cyril CATTIAUX/Marc DENTY/rcichielo KRUSCH/Chris 
 
 
Description: 
 
  Rework of the 1.3.5 optimized driver posted on the opewnwrt forum. 
  Support for high capacity cards (sdhc) added. Other card types also still 
  supported. See the comments at the beginning of the sdhc.c file for a full 
  description of the module parameters and the release notes. 
  Supports the 2.4 kernel on broadcom devices only. 
 
 
Building: 
 
  Run "make menuconfig". You should see an sdhc module available under  
  Select menu "Kernel Modules--->Other Modules". 
  Select module "kmod-broadcom-sdhc" to be built as a module 
  Exit menuconfig saving your changes 
  Run 'make V=99'. 
 
  Shortcut hints for quick re-compiles and distributing modules to your 
  router while developing: 
 
    'make package/broadcom-sdhc-clean V=99' 
    'make package/broadcom-sdhc-compile V=99' 
    '(cd build_mipsel/broadcom-sdhc-2.01; make dist)' 
 
  Generated modules and ipkg found in "build_mipsel/broadcom-sdhc-2.0.1" 
 
 
Usage: 
 
  The /etc/init.d/sdhc script is used to start and stop sdhc services. 
  The configuration is explained & located in /etc/sdcard.conf file. 
  This script sets the appropriate gpiomask for /proc/diag/gpiomask, 
  loads the kernel module and mounts the first partition under /sdhc.  
  Modify /etc/sdcard.conf if you want a different behaviour: 
 
  /etc/init.d/sdhc start        - Start sdhc services - mount card if detected 
  /etc/init.d/sdhc stop         - Unmount card and stop sdhc services 
  /etc/init.d/sdhc status       - Print status of sdhc service and about  
                                  the sd card (size, manufacture date, serial ...) 
  /etc/init.d/sdhc test         - speed test the sd card 
  /etc/init.d/sdhc overlay_root - overlay root / with /sdcard 
 
Overlaying root file system: 
   
  Overlaying root can only be done on a not already overlayed filesystem. I suggest to  
  use a minimal jffs2 image. Add the line  
 
[ -x /etc/init.d/sdhc ] && /etc/init.d/sdhc overlay_root > /sdhc.log 
 
  to the end of /sbin/mount_root. Don't log the output to /tmp or 
  /tmp can't be unmounted and the sdcard /tmp be used instead. 
 
Changes / Release Notes: 
 
Version 2.0.2 - Sep 20, 2009 (bud.dhay[AT]suisse.org) 
 
- prepared source/files version 2.0.1 for complete inclusion in openwrt buildrootng 
- Bug Fix: start script choked when dbg was not set or 0 
- moved Usage/Release Notes in this Readme from sdhc.c header 
- Bug Fix: inserted default values for gpio's in init script 
- init script: load the debug module by default, load debug disabled only if existing  
               and debug is off 
- init script: new option overlay_root, documentation with the help option 
- conf file: added fsmodules parameter, necessary kernel modules for a successful mount 
 
Version 2.0.1 - Feb 8, 2009 
 
- Changed module name to sdhc (more people seem to use sdcards with this module). 
- Changed device directory to /dev/sdcard.  
- Build module without debugging (sdhc.o) and one with debugging enabled (sdhcd.o) 
  Module without debugging built in is 4Kb smaller and slightly faster. 
- Rename init script to sdcard. Modify script to load sdhc.o when no degugging is requested 
  in the config file, and sdhcd.o when debugging is requested.  
- Overhauled the module makefile to support building standalone or via buildrootng. 
- Bug Fix: card size calculated incorrectly for cards > 4GB (integer overflow) 
- Bug Fix: /dev/sdcard entry remained after module unloaded - it is now properly removed 
- Bug Fix: Device leak under /dev/discs/ - number of discs would grow by 1 each time an sd card 
  was mounted. Entries are now properly removed on module unload 
- Bug Fix: A cat of /proc/partitions after sdhc module was unloaded would cause a kernel fault. 
 
 
Version 2.0.0 - Mar 9, 2008 
 
- Rework of code base: 
 
1) Rework of functions that must honour max clock frequency. These functions 
   were generalized and condensed. Max clock frequency now managed through 2  
   global vars - no need to pass timing arguments. 
2) Logging functions replaced/simplified by variadic macros. 
3) Document and comment. Standardize layout, variables, style, etc. Split   
   card initialization function into separate source file. 
 
- Switch so module uses a dynamically assigned major number by default. Implement "major=" 
  module parameter to allow a specific major number to be assigned. 
- Implement module parameters "cs=", "clk=", "din=", "dout=" for specifying GPIO to card mapping. 
  Alter read/write algorithms to be more efficient with mappings in variables. 
- Implement module parameters "gpio_input=", "gpio_output=", "gpio_enable=", "gpio_control=" for  
  specifying GPIO register addresses. May be useful if you want to try using this module on other 
  broadcom based platforms where the gpio registers are located at different locations.  
- Debugging improvements. Implement "dbg=" module parameter to allow selective enabling of 
  debugging output by function. Only available when module compiled with debugging (-DDEBUG) 
- Initialize max_segments array so requests are clustered. "maxsec=" module parameter 
  sets the maximum number of sectors that can be clustered per request (default is 32). 
- Implement clustering support in the module request method. Improves speed by allowing more 
  clusters to be read/written per single invocation of a multi block read/write command. 
- Implement Support for high capacity (> 2GB) SDHC and MMC cards. 
- Implement /proc/sdhc/status for obtaining information about the detected card. 
- Maximum number of supported partitions reduced from 64 to 8 (memory use reduction). 
- Build using buildroot-ng environment. Generate ipkg file for installation. 
  With so little difference in speed, and only a 4k memory savings, compile debug enabled version 
 No newline at end of file