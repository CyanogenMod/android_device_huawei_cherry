# Copyright (C) 2016 The CyanogenMod Project
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

LOCAL_PATH := $(call my-dir)

# Libcutilz
include $(CLEAR_VARS)

LOCAL_SRC_FILES := huawei_cutilz.c

LOCAL_CLANG := true
LOCAL_MODULE := libhuawei_cutilz
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)
