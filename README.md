#include <openssl/ssl.h>
#include <openssl/err.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <jni.h>

extern "C"
JNIEXPORT jint JNICALL
Java_com_example_ssldemo_openssl_OpenSSLSocket_nativeConnect(JNIEnv *env, jobject thiz,
                                                              jlong sslPtr, jstring jhost,
                                                              jint port) {
    const char *host = env->GetStringUTFChars(jhost, nullptr);

    SSL *ssl = reinterpret_cast<SSL *>(sslPtr);
    if (!ssl) {
        ERR_print_errors_fp(stderr);
        env->ReleaseStringUTFChars(jhost, host);
        return -1;
    }

    // 创建 socket
    int sock = socket(AF_INET, SOCK_STREAM, 0);
    if (sock < 0) {
        perror("Socket creation failed");
        env->ReleaseStringUTFChars(jhost, host);
        return -1;
    }

    // 设置服务器地址
    struct sockaddr_in server_addr{};
    server_addr.sin_family = AF_INET;
    server_addr.sin_port = htons(port);
    if (inet_pton(AF_INET, host, &server_addr.sin_addr) <= 0) {
        perror("Invalid address");
        close(sock);
        env->ReleaseStringUTFChars(jhost, host);
        return -1;
    }

    // 连接服务器
    if (connect(sock, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
        perror("Connection failed");
        close(sock);
        env->ReleaseStringUTFChars(jhost, host);
        return -1;
    }

    // 绑定 socket 到 OpenSSL
    SSL_set_fd(ssl, sock);

    // 执行 SSL 握手
    if (SSL_connect(ssl) <= 0) {
        ERR_print_errors_fp(stderr);
        close(sock);
        env->ReleaseStringUTFChars(jhost, host);
        return -1;
    }

    printf("Connected successfully to %s:%d\n", host, port);

    env->ReleaseStringUTFChars(jhost, host);
    return sock;  // 返回 socket 描述符
}