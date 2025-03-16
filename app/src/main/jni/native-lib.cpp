#include <jni.h>
#include <string>
#include <openssl/opensslv.h>

extern "C" JNIEXPORT jstring JNICALL
Java_com_example_ndkopenssl_MainActivity_getOpenSSLVersion(JNIEnv *env, jobject /* this */) {
    std::string version = OPENSSL_VERSION_TEXT;
    return env->NewStringUTF(version.c_str());
}