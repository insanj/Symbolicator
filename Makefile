TARGET = :clang
ARCHS = armv7 armv7s arm64
GO_EASY_ON_ME = 1

include theos/makefiles/common.mk

TWEAK_NAME = Symbolicator
Symbolicator_FILES = Tweak.xm Symbolicator.mm
Symbolicator_FRAMEWORKS = Foundation
Symbolicator_PRIVATE_FRAMEWORKS = AppSupport Symbolication

include $(THEOS_MAKE_PATH)/tweak.mk

internal-after-install::
	install.exec "killall -9 backboardd"
