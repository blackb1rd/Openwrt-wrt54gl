#=======================================================================================
# This makefile can be used to build the sdhc module either inside the buildrootng
# environment (recommended), or outside of it (mileage may vary).
#
# If you really want to use this makefile outside of buildrootng, then you must set
# the make variables correctly. There's no guarantee the compiler flags provided
# here will be correct if changes have been made to the openwrt build since this
# makefile was created.
#
# TARGETS:
#
#		all - build standard and debug modules - generate assembler listing
#
#	modules - build standard and debug modules
#
#		std - build standard module
#
#		dbg - build module with debugging enabled (slightly slower)
#
#		asm - generate assembly listing (used for performance tuning code)
#
#	  clean - delete all generated modules and assembly listings
#
#	   dist - push compiled modules to router for testing
#=======================================================================================

ifndef CFLAGS

#---------------------------------------------------------------------------------------
# The following variables are ignored if running as part of the buildrootng process.
# Set them properly if you choose to run this makefile outside of buildrootng.
#---------------------------------------------------------------------------------------
OPENWRT := /local/openwrt/kamikaze/7.09
CC		:= ${OPENWRT}/staging_dir_mipsel/bin/mipsel-linux-uclibc-gcc
CFLAGS	:= -D__KERNEL__ -I${OPENWRT}/build_mipsel/linux-2.4-brcm/linux-2.4.34/include -Wall -Wstrict-prototypes -Wno-trigraphs -Os -fno-strict-aliasing -fno-common -fno-builtin-sprintf -fomit-frame-pointer	-funit-at-a-time -I${OPENWRT}/build_mipsel/linux-2.4-brcm/linux-2.4.34/include/asm/gcc -G 0 -mno-abicalls -fno-pic -pipe  -finline-limit=100000 -mabi=32 -march=mips32 -Wa,-32 -Wa,-march=mips32 -Wa,-mips32 -Wa,--trap -DMODULE -mlong-calls -fno-common

endif

#---------------------------------------------------------------------------------------
# Set the following values properly if you want to use the dist target or to capture
# the enironment variables while buildrootng is compiling the modules
#---------------------------------------------------------------------------------------
DISTIP	:= 192.168.1.1
DISTDIR := /lib/modules/2.4.34
BUILDENV := /dev/null

#==== TARGETS ==========================================================================

all:	std dbg asm

modules:		std dbg
		env > ${BUILDENV}

std:	sdhc.o

dbg:	sdhcd.o

asm:	sdhc.a

clean:
		rm -f sdhc.o sdhcd.o sdhc.a

dist:
		scp ./*.o root@${DISTIP}:${DISTDIR}

sdhc.o: sdhc.c init.c spi.c Makefile
		$(CC) ${CFLAGS} -c -o sdhc.o sdhc.c

sdhcd.o:		sdhc.c init.c spi.c Makefile
		$(CC) ${CFLAGS} -DDEBUG -c -o sdhcd.o sdhc.c

sdhc.a: sdhc.c init.c spi.c Makefile
		$(CC) ${CFLAGS} -DDEBUG -S -c -o sdhc.a sdhc.c

ifeq ($(MAKING_MODULES),1)

-include $(TOPDIR)/Rules.make

endif
