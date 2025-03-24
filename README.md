#include <jni.h>
#include <openssl/ssl.h>

extern "C" JNIEXPORT jlong JNICALL Java_MySSLContext_nativeCreateSSLContext(JNIEnv* env, jobject obj) {
    SSL_CTX *ctx = SSL_CTX_new(TLS_client_method());
    return (jlong)ctx;
}

extern "C" JNIEXPORT void JNICALL Java_MySSLContext_nativeFreeSSLContext(JNIEnv* env, jobject obj, jlong ctxPtr) {
    SSL_CTX *ctx = (SSL_CTX *)ctxPtr;
    SSL_CTX_free(ctx);
}