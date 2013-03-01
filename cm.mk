$(call inherit-product, vendor/cm/config/common_full_phone.mk)

$(call inherit-product, vendor/cm/config/cdma.mk)

# Enhanced NFC
$(call inherit-product, vendor/cm/config/nfc_enhanced.mk)

# Inherit device configuration
$(call inherit-product, device/xiaomi/aries/aries.mk)

# Device naming
PRODUCT_DEVICE := aries
PRODUCT_NAME := cm_aries
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := MI 2
PRODUCT_MANUFACTURER := Xiaomi

# Set build fingerprint / ID / Product Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=aries BUILD_ID=IMM76D BUILD_FINGERPRINT="Xiaomi/aries/aries:4.0.4/IMM76D/99866.1:user/release-keys" PRIVATE_BUILD_DESC="2.13.651.1 CL99866 release-keys"

# Release name
PRODUCT_RELEASE_NAME := aries
-include vendor/cm/config/common_versions.mk
