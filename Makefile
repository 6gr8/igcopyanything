ARCHS = arm64 arm64e


TARGET := iphone:clang:latest:13.0
INSTALL_TARGET_PROCESSES = SpringBoard
export THEOS=/var/jb/var/mobile/theos
THEOS_PACKAGE_SCHEME=rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = igshotdxd

igshotdxd_CFLAGS = -fobjc-arc -Wno-deprecated-declarations -Wno-unused-variable -Wno-unused-value

include $(THEOS_MAKE_PATH)/tweak.mk
