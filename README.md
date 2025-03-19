#include <jni.h>
#include <openssl/ssl.h>
#include <openssl/err.h>
#include <openssl/x509.h>
#include <openssl/pem.h>

static SSL_CTX *ssl_ctx = NULL;  // 存储 OpenSSL 上下文

// JNI 方法：创建 OpenSSL SSL 上下文
JNIEXPORT jlong JNICALL Java_OpenSSLContext_createNativeSSLContext(JNIEnv *env, jobject obj) {
    SSL_CTX *ctx;
    const SSL_METHOD *method;

    // 初始化 OpenSSL
    OpenSSL_add_all_algorithms();  // 添加所有加密算法
    SSL_load_error_strings();      // 加载错误字符串

    method = TLS_client_method();  // 使用 TLS 客户端协议
    ctx = SSL_CTX_new(method);     // 创建 SSL 上下文

    if (!ctx) {
        ERR_print_errors_fp(stderr);  // 如果创建失败，打印错误信息
        return 0;  // 返回 0 表示失败
    }

    ssl_ctx = ctx;  // 存储上下文

    return (jlong) ctx;  // 返回 SSL_CTX 指针
}

// JNI 方法：获取 OpenSSL 上下文
JNIEXPORT jlong JNICALL Java_OpenSSLContext_getNativeSSLContext(JNIEnv *env, jobject obj) {
    return (jlong) ssl_ctx;  // 返回当前的 SSL 上下文指针
}

// JNI 方法：获取 SSLSocketFactory
JNIEXPORT jobject JNICALL Java_OpenSSLContext_getSocketFactory(JNIEnv *env, jobject obj) {
    // 在这里返回一个自定义的 OpenSSL SocketFactory 实现
    // 通常，这个类会通过 JNI 包装 OpenSSL 的 SSL 套接字功能。
    jclass socketFactoryClass = (*env)->FindClass(env, "javax/net/ssl/SSLSocketFactory");
    jmethodID constructor = (*env)->GetMethodID(env, socketFactoryClass, "<init>", "()V");

    jobject socketFactoryInstance = (*env)->NewObject(env, socketFactoryClass, constructor);
    return socketFactoryInstance;  // 返回一个 OpenSSL 包装的 SocketFactory 实例
}

// 清理 OpenSSL 上下文
JNIEXPORT void JNICALL Java_OpenSSLContext_cleanupSSLContext(JNIEnv *env, jobject obj) {
    if (ssl_ctx) {
        SSL_CTX_free(ssl_ctx);  // 释放 SSL 上下文
        ssl_ctx = NULL;
    }
}