KERNEL_SRC ?= /lib/modules/$(shell uname -r)/build
M ?= $(shell pwd)

M=$(PWD)
BT_ROOT=$(KERNEL_SRC)/$(M)

KBUILD_OPTIONS += BT_ROOT=$(BT_ROOT)
KBUILD_OPTIONS += BOARD_PLATFORM=$(TARGET_BOARD_PLATFORM)
KBUILD_OPTIONS += CONFIG_BT_HW_SECURE_DISABLE=y
KBUILD_OPTIONS += CONFIG_MSM_BT_POWER=m
KBUILD_OPTIONS += CONFIG_BTFM_SLIM=m
# <linux/smcinvoke_object.h> lives in securemsm-kernel/include
KBUILD_OPTIONS += KCPPFLAGS="-I$(KERNEL_SRC)/../sm8635-modules/qcom/opensource/securemsm-kernel/include"
KBUILD_EXTRA_SYMBOLS := \
    $(OUT_DIR)/../sm8635-modules/qcom/opensource/securemsm-kernel/Module.symvers \
    $(OUT_DIR)/../sm8635-modules/qcom/opensource/wlan/platform/Module.symvers
KBUILD_OPTIONS += KBUILD_EXTRA_SYMBOLS="$(KBUILD_EXTRA_SYMBOLS)"

all:
	$(MAKE) -C $(KERNEL_SRC) M=$(M) modules $(KBUILD_OPTIONS)

modules_install:
	$(MAKE) INSTALL_MOD_STRIP=1 -C $(KERNEL_SRC) M=$(M) modules_install

clean:
	$(MAKE) -C $(KERNEL_SRC) M=$(M) clean
