#include <openssl/ssl.h>
#include <openssl/err.h>

JNIEXPORT void JNICALL Java_com_example_OpenSSLContext_closeSSLConnection(JNIEnv *env, jobject obj, jlong sslPtr) {
    if (sslPtr) {
        SSL *ssl = (SSL *)sslPtr;

        // 1. 正常关闭 SSL 连接
        int ret = SSL_shutdown(ssl);
        if (ret == 0) {
            // 双向关闭（SSL_shutdown 需要调用两次以完全关闭连接）
            SSL_shutdown(ssl);
        }

        // 2. 释放 SSL 资源
        SSL_free(ssl);
    }
}