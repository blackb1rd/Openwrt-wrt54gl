#
# Copyright (C) 2006-2009 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# $Id: Makefile 15966 2009-05-21 19:18:59Z nbd $

include $(TOPDIR)/rules.mk

PKG_NAME:=hostapd
PKG_VERSION:=0.6.6
PKG_RELEASE:=1.1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://hostap.epitest.fi/releases/
PKG_SOURCE_SUBDIR:=hostapd-$(PKG_VERSION)
PKG_SOURCE_VERSION:=$(PKG_REV)
PKG_MD5SUM:=cba36847d38c753731afefe1460f5f90
PKG_BUILD_DEPENDS:=PACKAGE_kmod-madwifi:madwifi

include $(INCLUDE_DIR)/package.mk
STAMP_CONFIGURED:=$(STAMP_CONFIGURED)_$(call confvar,CONFIG_PACKAGE_kmod-madwifi CONFIG_PACKAGE_hostapd CONFIG_PACKAGE_hostapd-mini)

define Package/hostapd/Default
  SECTION:=net
  CATEGORY:=Network
  TITLE:=IEEE 802.1x Authenticator
  URL:=http://hostap.epitest.fi/
  DEPENDS:=@!TARGET_avr32
endef

define Package/hostapd
$(call Package/hostapd/Default)
  TITLE+= (full)
  DEPENDS+= +PACKAGE_hostapd:libopenssl
endef

#define Package/hostapd/conffiles
#/etc/hostapd.conf
#endef

define Package/hostapd/description
 This package contains a full featured IEEE 802.1x/WPA/EAP/RADIUS 
 Authenticator.
endef

define Package/hostapd-mini
$(call Package/hostapd/Default)
  TITLE+= (WPA-PSK only)
endef

#define Package/hostapd-mini/conffiles
#/etc/hostapd.conf
#endef

define Package/hostapd-mini/description
 This package contains a minimal IEEE 802.1x/WPA/EAP/RADIUS Authenticator 
 (WPA-PSK only).
endef

define Package/hostapd-utils
  $(call Package/hostapd/Default)
  TITLE+= (utils)
  DEPENDS:=@PACKAGE_hostapd||PACKAGE_hostapd-mini
endef

define Package/hostapd-utils/description
 This package contains a command line utility to control the 
 IEEE 802.1x/WPA/EAP/RADIUS Authenticator.
endef

define Build/ConfigureTarget
	rm -rf $(PKG_BUILD_DIR)/hostapd.$(1)
	mkdir -p $(PKG_BUILD_DIR)/hostapd.$(1)
	$(CP) \
		$(PKG_BUILD_DIR)/hostapd \
		$(PKG_BUILD_DIR)/src \
		$(PKG_BUILD_DIR)/hostapd.$(1)/
	$(CP) ./files/$(1).config $(PKG_BUILD_DIR)/hostapd.$(1)/hostapd/.config
	$(if $(CONFIG_PACKAGE_kmod-madwifi),,$(SED) 's,^CONFIG_DRIVER_MADWIFI,#CONFIG_DRIVER_MADWIFI,g' $(PKG_BUILD_DIR)/hostapd.$(1)/hostapd/.config)
endef

define Build/CompileTarget
	CFLAGS="$(TARGET_CFLAGS) -I$(STAGING_DIR)/usr/include/madwifi -I$(STAGING_DIR)/usr/include" \
	$(MAKE) -C $(PKG_BUILD_DIR)/hostapd.$(1)/hostapd \
		$(TARGET_CONFIGURE_OPTS) \
		LIBS="$(TARGET_LDFLAGS) -L$(STAGING_DIR)/usr/lib \
			$(if $(findstring default,$(1)),-lssl -lcrypto)" \
		hostapd hostapd_cli
	$(CP) $(PKG_BUILD_DIR)/hostapd.$(1)/hostapd/hostapd_cli $(PKG_BUILD_DIR)/
endef

define Package/InstallTemplate
	$(INSTALL_DIR) $$(1)/lib/wifi
	$(INSTALL_DATA) ./files/hostapd.sh $$(1)/lib/wifi/hostapd.sh
	$(INSTALL_DIR) $$(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/hostapd.$(2)/hostapd/hostapd $$(1)/usr/sbin/
# config is managed through uci
#	$(INSTALL_DIR) $$(1)/etc
#	$(INSTALL_CONF) $(PKG_BUILD_DIR)/hostapd.$(2)/hostapd/hostapd.conf $$(1)/etc/hostapd.conf 
endef

define Package/Template
 ifneq ($(CONFIG_PACKAGE_$(1)),)
  define Build/Configure/$(2)
	$(call Build/ConfigureTarget,$(2))
  endef
  define Build/Compile/$(2)
	$(call Build/CompileTarget,$(2))
  endef
  define Package/$(1)/install
	$(call Package/InstallTemplate,$(1),$(2))
  endef
 endif
endef

define Build/Configure
	rm -f $(PKG_BUILD_DIR)/.configured*
	$(call Build/Configure/default)
	$(call Build/Configure/mini)
endef

define Build/Compile
	$(call Build/Compile/default)
	$(call Build/Compile/mini)
endef

define Build/Clean
	rm -rf $(PKG_BUILD_DIR)_default
	rm -rf $(PKG_BUILD_DIR)_mini
endef

define Package/hostapd-utils/install
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/hostapd_cli $(1)/usr/sbin/
endef

$(eval $(call Package/Template,hostapd,default))
$(eval $(call Package/Template,hostapd-mini,mini))

$(eval $(call BuildPackage,hostapd))
$(eval $(call BuildPackage,hostapd-mini))
$(eval $(call BuildPackage,hostapd-utils))
