LOCAL_PATH := $(call my-dir)

INSTALLED_BOOTIMAGE_TARGET := $(PRODUCT_OUT)/boot.img
$(INSTALLED_BOOTIMAGE_TARGET): $(PRODUCT_OUT)/kernel $(MKBOOTIMG) $(MINIGZIP) $(INTERNAL_BOOTIMAGE_FILES)
	$(call pretty,"Boot image: $@")
	$(hide) cp -R device/semc/msm7x30-common/root/sbin/* $(PRODUCT_OUT)/root/sbin/
	$(hide) mkdir -p $(PRODUCT_OUT)/root/res/images/
	$(hide) cp -R device/semc/msm7x30-common/root/res/images/* $(PRODUCT_OUT)/root/res/images/
	$(hide) $(MKBOOTFS) $(PRODUCT_OUT)/root/ > $(PRODUCT_OUT)/combinedroot.cpio
	$(hide) cat $(PRODUCT_OUT)/combinedroot.cpio | gzip > $(PRODUCT_OUT)/combinedroot.fs
	$(hide) $(MKBOOTIMG) --kernel $(PRODUCT_OUT)/kernel --ramdisk $(PRODUCT_OUT)/combinedroot.fs --base $(BOARD_KERNEL_BASE) --pagesize 131072 --output $@

