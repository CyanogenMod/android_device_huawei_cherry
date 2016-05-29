#!/sbin/sh
#
# Copyright (C) 2016 CyanogenMod Project
#
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

PRODUCT_MODEL=`getprop ro.product.model`
NFC_MODEL="C8817D C8817E G620S-L01 Che1-CL10"

RESULT=$(echo $NFC_MODEL | grep "$PRODUCT_MODEL")

if [[ "$RESULT" != "" ]]
then
    # Remove NFC
    rm -rf /system/app/QNfc
    rm -rf /system/priv-app/Tag
    rm -rf /system/lib/*nfc*
    rm -rf /system/lib/hw/*nfc*
    rm -rf /system/etc/*nfc*
    rm -rf /system/etc/permissions/*nfc*
    rm -rf /system/framework/*nfc*
    rm -rf /system/vendor/lib/*nfc*
    rm -rf /system/vendor/firmware/*pn547*
fi
