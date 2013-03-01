#
# Copyright (C) 2011 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# common msm8960 configs
$(call inherit-product, device/xiaomi/msm8960-common/msm8960.mk)

DEVICE_PACKAGE_OVERLAYS += device/xiaomi/aries/overlay

# Boot ramdisk setup
PRODUCT_COPY_FILES += \
    device/xiaomi/aries/ramdisk/init.qcom.rc:root/init.qcom.rc \
    device/xiaomi/aries/ramdisk/init.qcom.sh:root/init.qcom.sh \
    device/xiaomi/aries/ramdisk/init.qcom.usb.rc:root/init.qcom.usb.rc \
    device/xiaomi/aries/ramdisk/init.qcom.usb.sh:root/init.qcom.usb.sh \
    device/xiaomi/aries/ramdisk/init.target.rc:root/init.target.rc \
    device/xiaomi/aries/ramdisk/init.qcom.class_core.sh:root/init.qcom.class_core.sh \
    device/xiaomi/aries/ramdisk/init.qcom.class_main.sh:root/init.qcom.class_main.sh \
    device/xiaomi/aries/ramdisk/fstab.qcom:root/fstab.qcom \
    device/xiaomi/aries/ramdisk/ueventd.qcom.rc:root/ueventd.qcom.rc

# HTC BT audio config
PRODUCT_COPY_FILES += device/xiaomi/aries/configs/AudioBTID.csv:system/etc/AudioBTID.csv

# QC thermald config
PRODUCT_COPY_FILES += device/xiaomi/aries/configs/thermald.conf:system/etc/thermald.conf

# vold.fstab
PRODUCT_COPY_FILES += \
    device/xiaomi/aries/configs/vold.fstab:system/etc/vold.fstab

# wifi config
PRODUCT_COPY_FILES += \
    device/xiaomi/aries/configs/wpa_supplicant.conf:/system/etc/wifi/wpa_supplicant.conf

# Sound configs
PRODUCT_COPY_FILES += \
    device/xiaomi/aries/dsp/soundimage/srs_bypass.cfg:system/etc/soundimage/srs_bypass.cfg \
    device/xiaomi/aries/dsp/soundimage/srsfx_trumedia_51.cfg:system/etc/soundimage/srsfx_trumedia_51.cfg \
    device/xiaomi/aries/dsp/soundimage/srsfx_trumedia_movie.cfg:system/etc/soundimage/srsfx_trumedia_movie.cfg \
    device/xiaomi/aries/dsp/soundimage/srsfx_trumedia_music.cfg:system/etc/soundimage/srsfx_trumedia_music.cfg \
    device/xiaomi/aries/dsp/soundimage/srsfx_trumedia_voice.cfg:system/etc/soundimage/srsfx_trumedia_voice.cfg \
    device/xiaomi/aries/dsp/soundimage/srs_geq10.cfg:system/etc/soundimage/srs_geq10.cfg \
    device/xiaomi/aries/dsp/soundimage/srs_global.cfg:system/etc/soundimage/srs_global.cfg

PRODUCT_COPY_FILES += \
    device/xiaomi/aries/dsp/snd_soc_msm/snd_soc_msm_2x:/system/etc/snd_soc_msm/snd_soc_msm_2x

# Keylayouts and Keychars
PRODUCT_COPY_FILES += \
    device/xiaomi/aries/keylayout/atmel_mxt_ts.kl:system/usr/keylayout/atmel_mxt_ts.kl \
    device/xiaomi/aries/keylayout/Button_Jack.kl:system/usr/keylayout/Button_Jack.kl \
    device/xiaomi/aries/keylayout/cyttsp-i2c.kl:system/usr/keylayout/cyttsp-i2c.kl \
    device/xiaomi/aries/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    device/xiaomi/aries/keylayout/keypad_8960.kl:system/usr/keylayout/keypad_8960.kl \
    device/xiaomi/aries/keylayout/keypad_8960_liquid.kl:system/usr/keylayout/keypad_8960_liquid.kl \
    device/xiaomi/aries/keylayout/philips_remote_ir.kl:system/usr/keylayout/philips_remote_ir.kl \
    device/xiaomi/aries/keylayout/samsung_remote_ir.kl:system/usr/keylayout/samsung_remote_ir.kl \
    device/xiaomi/aries/keylayout/sensor00fn1a.kl:system/usr/keylayout/sensor00fn1a.kl \
    device/xiaomi/aries/keylayout/ue_rf4ce_remote.kl:system/usr/keylayout/ue_rf4ce_remote.kl

# NFCEE access control
ifeq ($(TARGET_BUILD_VARIANT),user)
    NFCEE_ACCESS_PATH := device/xiaomi/aries/configs/nfcee_access.xml
else
    NFCEE_ACCESS_PATH := device/xiaomi/aries/configs/nfcee_access_debug.xml
endif
PRODUCT_COPY_FILES += \
    $(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml

# GPS
#PRODUCT_PACKAGES += \
#    gps.aries \

# NFC Support
PRODUCT_PACKAGES += \
    libnfc \
    libnfc_jni \
    Nfc \
    Tag \
    com.android.nfc_extras

# Torch
PRODUCT_PACKAGES += \
    Torch

# Filesystem management tools
PRODUCT_PACKAGES += \
   make_ext4fs \
   e2fsck \
   setup_fs

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
    frameworks/base/nfc-extras/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
    frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml

# mount script
PRODUCT_COPY_FILES += \
    device/xiaomi/aries/prebuilt/mount_ext4.sh:/system/bin/mount_ext4.sh

# We have enough space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

# Set build date
PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi
PRODUCT_LOCALES += en_US

# call the proprietary setup
$(call inherit-product-if-exists, vendor/xiaomi/aries/aries-vendor.mk)

# call dalvik heap config
$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)

# Discard inherited values and use our own instead.
PRODUCT_DEVICE := aries
PRODUCT_NAME := aries
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := MI 2
PRODUCT_MANUFACTURER := Xiaomi
