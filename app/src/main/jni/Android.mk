LOCAL_PATH := $(call my-dir)

# 清除默认变量，准备设置本模块
include $(CLEAR_VARS)

# 设定编译的模块名称
LOCAL_MODULE := my_native_lib

# 源文件
LOCAL_SRC_FILES := native-lib.cpp

# 使用系统提供的 OpenSSL 动态库
LOCAL_LDLIBS := -llog  # 链接 Android 日志库（可选）

# 设置链接预编译的 OpenSSL 库
LOCAL_LDFLAGS := -L$(LOCAL_PATH)/../../../jniLibs/x86_64 -lssl -lcrypto

# 设置 OpenSSL 头文件路径
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../../libs/openssl/include

# 生成共享库
include $(BUILD_SHARED_LIBRARY)