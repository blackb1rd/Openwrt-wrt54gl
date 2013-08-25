# Use the default kernel version if the Makefile doesn't override it

ifeq ($(KERNEL),2.4)
  LINUX_VERSION?=2.4.35.4
endif
LINUX_RELEASE?=1

ifeq ($(LINUX_VERSION),2.4.35.4)
  LINUX_KERNEL_MD5SUM:=0de40d83cb9a216583b8046825f4d991
endif

# disable the md5sum check for unknown kernel versions
LINUX_KERNEL_MD5SUM?=x

KERNEL?=2.$(word 2,$(subst ., ,$(strip $(LINUX_VERSION))))
KERNEL_PATCHVER=$(shell echo '$(LINUX_VERSION)' | cut -d. -f1,2,3 | cut -d- -f1)

