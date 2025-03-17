#include <jni.h>
#include <openssl/opensslv.h>
#include "OpenSSLWrapper.h"

JNIEXPORT jstring JNICALL Java_OpenSSLWrapper_getVersion(JNIEnv *env, jobject thisObj) {
    // 获取 OpenSSL 版本信息
    const char *version = OPENSSL_VERSION_TEXT;

    // 将版本信息返回给 Java
    return (*env)->NewStringUTF(env, version);
}