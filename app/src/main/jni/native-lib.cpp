#include <jni.h>
#include <string>
#include <openssl/ssl.h>

extern "C" JNIEXPORT jstring JNICALL
Java_com_example_ndkopenssl_MainActivity_getOpenSSLVersion(JNIEnv* env, jobject) {
    return env->NewStringUTF(OpenSSL_version(OPENSSL_VERSION));
}