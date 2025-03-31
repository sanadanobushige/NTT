#include <android/log.h>

#define TAG "NativeLog"  // Logcat 中的 Tag
#define LOGD(...) __android_log_print(ANDROID_LOG_DEBUG, TAG, __VA_ARGS__)  // Debug 级别日志
#define LOGE(...) __android_log_print(ANDROID_LOG_ERROR, TAG, __VA_ARGS__)  // Error 级别日志

extern "C"
JNIEXPORT void JNICALL
Java_com_example_myapp_NativeLib_nativeMethod(JNIEnv *env, jobject thiz) {
    LOGD("This is a debug log from C code");
    LOGE("This is an error log from C code, value: %d", 42);
}