
# -----------------------------------------------------------------
# the boot image, which is a collection of other images.

INTERNAL_BOOTIMAGE_ARGS := \
	$(addprefix --second ,$(INSTALLED_2NDBOOTLOADER_TARGET)) \
	--kernel device/xiaomi/aries/kernel \
	--ramdisk $(INSTALLED_RAMDISK_TARGET)

# Assumes this has already been stripped
ifdef BOARD_KERNEL_CMDLINE
  INTERNAL_BOOTIMAGE_ARGS += --cmdline "$(BOARD_KERNEL_CMDLINE)"
endif
ifdef BOARD_KERNEL_BASE
  INTERNAL_BOOTIMAGE_ARGS += --base $(BOARD_KERNEL_BASE)
endif
ifdef BOARD_KERNEL_PAGESIZE
  INTERNAL_BOOTIMAGE_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
endif

$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_FILES)
	$(call pretty,"Target custom boot image: $@")
	$(hide) $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}" Made custom boot image: $@"${CL_RST}



# -----------------------------------------------------------------
# Recovery image

INTERNAL_RECOVERYIMAGE_ARGS := \
	$(addprefix --second ,$(INSTALLED_2NDBOOTLOADER_TARGET)) \
	--kernel device/xiaomi/aries/kernel \
	--ramdisk $(recovery_ramdisk)

# Assumes this has already been stripped
ifdef BOARD_KERNEL_CMDLINE
  INTERNAL_RECOVERYIMAGE_ARGS += --cmdline "$(BOARD_KERNEL_CMDLINE)"
endif
ifdef BOARD_KERNEL_BASE
  INTERNAL_RECOVERYIMAGE_ARGS += --base $(BOARD_KERNEL_BASE)
endif
ifdef BOARD_KERNEL_PAGESIZE
  INTERNAL_RECOVERYIMAGE_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)
endif
ifneq ($(BOARD_FORCE_RAMDISK_ADDRESS),)
  INTERNAL_RECOVERYIMAGE_ARGS += --ramdiskaddr $(BOARD_FORCE_RAMDISK_ADDRESS)
endif

$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) \
		$(recovery_ramdisk) \
		$(recovery_kernel)
	@echo -e ${CL_CYN}"----- Making custom recovery image ------"${CL_RST}
	$(hide) $(MKBOOTIMG) $(INTERNAL_RECOVERYIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}"Made custom recovery image: $@"${CL_RST}

$(recovery_uncompressed_ramdisk): $(MINIGZIP) \
	$(TARGET_RECOVERY_ROOT_TIMESTAMP)
	@echo -e ${CL_CYN}"----- Copying kernel modules to recovery ramdisk ------"${CL_RST}
	$(hide) mkdir -p $(TARGET_RECOVERY_ROOT_OUT)/lib/modules
	$(ACP) $(OUT)/system/lib/modules/symsearch.ko $(TARGET_RECOVERY_ROOT_OUT)/lib/modules/
	$(ACP) $(OUT)/system/lib/modules/disableversioncheck.ko $(TARGET_RECOVERY_ROOT_OUT)/lib/modules/
	@echo -e ${CL_CYN}"----- Making uncompressed recovery ramdisk ------"${CL_RST}
	$(MKBOOTFS) $(TARGET_RECOVERY_ROOT_OUT) > $@

