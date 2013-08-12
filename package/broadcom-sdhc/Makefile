#
# High Capacity Media card driver. Handles high capacity and standard multimedia
# and secure digital cards
#
# This makefile is compatible for building under the kamikaze 8.09 branch
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=broadcom-sdhc
PKG_VERSION:=2.0.2
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

MAKEFLAGS_KMOD:= -C "$(LINUX_DIR)" \
				CROSS_COMPILE="$(TARGET_CROSS)" \
				ARCH="$(LINUX_KARCH)" \
				PATH="$(TARGET_PATH)" \
				SUBDIRS="$(PKG_BUILD_DIR)"

define KernelPackage/broadcom-sdhc
	SUBMENU:=Other modules
	DEPENDS:=@TARGET_brcm_2_4
	TITLE:= MMC/SD/SDHC card driver - Linksys WRT54G/GS/GL
	VERSION:=$(LINUX_VERSION)-$(BOARD)-$(PKG_VERSION)-$(PKG_RELEASE)
	FILES:=\
		$(PKG_BUILD_DIR)/sdhc.$(LINUX_KMOD_SUFFIX)\
		$(PKG_BUILD_DIR)/sdhcd.$(LINUX_KMOD_SUFFIX)
endef

define KernelPackage/broadcom-sdhc/description
		Driver for Linksys WRT54G/GS/GL MM/SD card modification.
		Supports standard and high capacity cards.
		May work for other broadcom based routers (Buffalo, etc).
endef

define Build/Prepare
		mkdir -p $(PKG_BUILD_DIR)
		$(CP) ./files/src/* $(PKG_BUILD_DIR)/
endef

define Build/Compile
		$(MAKE) $(MAKEFLAGS_KMOD) \
			modules
endef

define KernelPackage/broadcom-sdhc/install
		mkdir -p $(1)/etc/init.d
		install -m0755 ./files/sdcard.init $(1)/etc/init.d/sdcard
		install -m0644 ./files/sdcard.conf $(1)/etc/sdcard.conf
		$(CP) $(PKG_BUILD_DIR)/sdhc.o $(1)/lib/modules/$(LINUX_VERSION)/
		$(CP) $(PKG_BUILD_DIR)/sdhcd.o $(1)/lib/modules/$(LINUX_VERSION)/
endef

$(eval $(call KernelPackage,broadcom-sdhc))
