DEVICE_PACKAGE_OVERLAYS := device/qcom/msm8916_32/overlay

TARGET_USES_QCOM_BSP := true
ifeq ($(TARGET_PRODUCT),msm8916_32)
TARGET_USES_QCA_NFC := other
endif

# Add QC Video Enhancements flag
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true

#QTIC flag
-include $(QCPATH)/common/config/qtic-config.mk

# media_profiles and media_codecs xmls for 8916
ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS), true)
PRODUCT_COPY_FILES += device/qcom/msm8916_32/media/media_profiles_8916.xml:system/etc/media_profiles.xml \
                      device/qcom/msm8916_32/media/media_codecs_8916.xml:system/etc/media_codecs.xml \
                      device/qcom/msm8916_32/media/media_codecs_8939.xml:system/etc/media_codecs_8939.xml \
                      device/qcom/msm8916_32/media/media_codecs_8929.xml:system/etc/media_codecs_8929.xml
endif

PRODUCT_PROPERTY_OVERRIDES += \
       dalvik.vm.heapgrowthlimit=128m \
       dalvik.vm.heapminfree=6m \
       dalvik.vm.heapstartsize=14m
$(call inherit-product, device/qcom/common/common.mk)

PRODUCT_NAME := msm8916_32
PRODUCT_DEVICE := msm8916_32

ifeq ($(strip $(TARGET_USES_QTIC)),true)
# font rendering engine feature switch
-include $(QCPATH)/common/config/rendering-engine.mk
ifneq (,$(strip $(wildcard $(PRODUCT_RENDERING_ENGINE_REVLIB))))
    MULTI_LANG_ENGINE := REVERIE
endif
endif

PRODUCT_BOOT_JARS += \
           qcmediaplayer \
           WfdCommon \
           oem-services \
           qcom.fmradio \
           org.codeaurora.Performance \
           tcmiface

# Audio configuration file
PRODUCT_COPY_FILES += \
    device/qcom/msm8916_32/audio_policy.conf:system/etc/audio_policy.conf \
    device/qcom/msm8916_32/audio_effects.conf:system/vendor/etc/audio_effects.conf \
    device/qcom/msm8916_32/mixer_paths_mtp.xml:system/etc/mixer_paths_mtp.xml \
    device/qcom/msm8916_32/mixer_paths_sbc.xml:system/etc/mixer_paths_sbc.xml \
    device/qcom/msm8916_32/mixer_paths_qrd_skuh.xml:system/etc/mixer_paths_qrd_skuh.xml \
    device/qcom/msm8916_32/mixer_paths_qrd_skui.xml:system/etc/mixer_paths_qrd_skui.xml \
    device/qcom/msm8916_32/mixer_paths_qrd_skuhf.xml:system/etc/mixer_paths_qrd_skuhf.xml \
    device/qcom/msm8916_32/mixer_paths_wcd9306.xml:system/etc/mixer_paths_wcd9306.xml \
    device/qcom/msm8916_32/mixer_paths_skuk.xml:system/etc/mixer_paths_skuk.xml \
    device/qcom/msm8916_32/mixer_paths_skul.xml:system/etc/mixer_paths_skul.xml \
    device/qcom/msm8916_32/mixer_paths.xml:system/etc/mixer_paths.xml \
    device/qcom/msm8916_32/sound_trigger_mixer_paths.xml:system/etc/sound_trigger_mixer_paths.xml \
    device/qcom/msm8916_32/sound_trigger_mixer_paths_wcd9306.xml:system/etc/sound_trigger_mixer_paths_wcd9306.xml \
    device/qcom/msm8916_32/sound_trigger_platform_info.xml:system/etc/sound_trigger_platform_info.xml \
    device/qcom/msm8916_32/mixer_paths_wcd9330.xml:system/etc/mixer_paths_wcd9330.xml

# ANT+ stack
PRODUCT_PACKAGES += \
    AntHalService \
    libantradio \
    antradio_app

PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    camera2.portability.force_api=1

# NFC packages
ifeq ($(TARGET_USES_QCA_NFC),true)
NFC_D := true

ifeq ($(NFC_D), true)
    PRODUCT_PACKAGES += \
        libnfcD-nci \
        libnfcD_nci_jni \
        nfc_nci.msm8916 \
        NfcDNci \
        Tag \
        com.android.nfc_extras \
        com.android.nfc.helper
else
    PRODUCT_PACKAGES += \
    libnfc-nci \
    libnfc_nci_jni \
    nfc_nci.msm8916 \
    NfcNci \
    Tag \
    com.android.nfc_extras
endif

# file that declares the MIFARE NFC constant
# Commands to migrate prefs from com.android.nfc3 to com.android.nfc
# NFC access control + feature files + configuration
PRODUCT_COPY_FILES += \
        packages/apps/Nfc/migrate_nfc.txt:system/etc/updatecmds/migrate_nfc.txt \
        frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml \
        frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
        frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml
endif # TARGET_USES_QCA_NFC

# Feature definition files for msm8916
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml

#fstab.qcom
PRODUCT_PACKAGES += fstab.qcom

PRODUCT_PACKAGES += \
    libqcomvisualizer \
    libqcompostprocbundle \
    libqcomvoiceprocessing

#OEM Services library
PRODUCT_PACKAGES += oem-services
PRODUCT_PACKAGES += libsubsystem_control
PRODUCT_PACKAGES += libSubSystemShutdown

PRODUCT_PACKAGES += wcnss_service

# MSM IRQ Balancer configuration file
PRODUCT_COPY_FILES += \
    device/qcom/msm8916_32/msm_irqbalance.conf:system/vendor/etc/msm_irqbalance.conf

#wlan driver
PRODUCT_COPY_FILES += \
    device/qcom/msm8916_32/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    device/qcom/msm8916_32/WCNSS_wlan_dictionary.dat:persist/WCNSS_wlan_dictionary.dat \
    device/qcom/msm8916_32/WCNSS_qcom_wlan_nv.bin:persist/WCNSS_qcom_wlan_nv.bin

PRODUCT_PACKAGES += \
    wpa_supplicant_overlay.conf \
    p2p_supplicant_overlay.conf
#ANT+ stack
PRODUCT_PACKAGES += \
AntHalService \
libantradio \
antradio_app

#HBTP
PRODUCT_PACKAGES += hbtp_daemon
PRODUCT_PACKAGES += libhbtpclient.so
PRODUCT_PACKAGES += libhbtpfrmwk.so
PRODUCT_PACKAGES += libhbtparm.so
PRODUCT_PACKAGES += libafehal_5_rohm_v3.so
PRODUCT_PACKAGES += hbtp_8939_5_rohm_v3.cfg
PRODUCT_PACKAGES += hbtpcfg_8939_5_rohm_v3.dat
PRODUCT_PACKAGES += libafehal_5_rohm_v4.so
PRODUCT_PACKAGES += hbtp_8939_5_rohm_v4.cfg
PRODUCT_PACKAGES += hbtpcfg_8939_5_rohm_v4.dat
PRODUCT_PACKAGES += libafehal_5p5_rohm_v4.so
PRODUCT_PACKAGES += hbtp_8939_5p5_rohm_v4.cfg
PRODUCT_PACKAGES += hbtpcfg_8939_5p5_rohm_v4.dat
PRODUCT_PACKAGES += libafehal_6_rohm_v3.so
PRODUCT_PACKAGES += hbtp_8939_6_rohm_v3.cfg
PRODUCT_PACKAGES += hbtpcfg_8939_6_rohm_v3.dat

# Defined the locales
PRODUCT_LOCALES += th_TH vi_VN tl_PH hi_IN ar_EG ru_RU tr_TR pt_BR bn_IN mr_IN ta_IN te_IN zh_HK \
        in_ID my_MM km_KH sw_KE uk_UA pl_PL sr_RS sl_SI fa_IR kn_IN ml_IN ur_IN gu_IN or_IN

# Add the overlay path
ifeq ($(strip $(TARGET_USES_QTIC)),true)
PRODUCT_PACKAGE_OVERLAYS := $(QCPATH)/qrdplus/Extension/res-overlay \
        $(PRODUCT_PACKAGE_OVERLAYS)
endif
