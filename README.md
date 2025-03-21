#include <jni.h>
#include <openssl/ssl.h>
#include <openssl/err.h>

extern "C"
JNIEXPORT jlong JNICALL
Java_com_example_myapp_OpenSSLSocket_nativeCreateSSL(JNIEnv *env, jobject thiz, jlong ctxPtr) {
    SSL *ssl = SSL_new(reinterpret_cast<SSL_CTX *>(ctxPtr));
    return reinterpret_cast<jlong>(ssl);
}

extern "C"
JNIEXPORT void JNICALL
Java_com_example_myapp_OpenSSLSocket_nativeConnect(JNIEnv *env, jobject thiz, jlong sslPtr, jstring jhost, jint port) {
    const char *host = env->GetStringUTFChars(jhost, NULL);
    
    BIO *bio = BIO_new_ssl_connect(reinterpret_cast<SSL *>(sslPtr));
    BIO_set_conn_hostname(bio, host);
    
    if (BIO_do_connect(bio) <= 0) {
        ERR_print_errors_fp(stderr);
    }
    
    env->ReleaseStringUTFChars(jhost, host);
}

extern "C"
JNIEXPORT jint JNICALL
Java_com_example_myapp_OpenSSLSocket_nativeWrite(JNIEnv *env, jobject thiz, jlong sslPtr, jbyteArray data) {
    jsize len = env->GetArrayLength(data);
    jbyte *buf = env->GetByteArrayElements(data, NULL);

    int result = SSL_write(reinterpret_cast<SSL *>(sslPtr), buf, len);

    env->ReleaseByteArrayElements(data, buf, JNI_ABORT);
    return result;
}

extern "C"
JNIEXPORT jint JNICALL
Java_com_example_myapp_OpenSSLSocket_nativeRead(JNIEnv *env, jobject thiz, jlong sslPtr, jbyteArray buffer) {
    jsize len = env->GetArrayLength(buffer);
    jbyte *buf = env->GetByteArrayElements(buffer, NULL);

    int result = SSL_read(reinterpret_cast<SSL *>(sslPtr), buf, len);

    env->ReleaseByteArrayElements(buffer, buf, 0);
    return result;
}