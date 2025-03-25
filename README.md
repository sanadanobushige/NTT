extern "C"
JNIEXPORT void JNICALL
Java_OpenSSLSocketFactory_performHandshake(JNIEnv *env, jobject obj, jlong sslPtr) {
    SSL *ssl = (SSL *) sslPtr;
    if (!ssl) return;

    int ret = SSL_connect(ssl);
    if (ret == 1) {  // 握手成功
        printf("🔹 OpenSSL 握手完成！\n");
        SSL_SESSION *session = SSL_get_session(ssl);
        if (session) {
            SSL_SESSION_up_ref(session);
            // 这里可以存储 session
        }

        // 通知 Java 层
        jclass cls = env->GetObjectClass(obj);
        jmethodID mid = env->GetMethodID(cls, "onHandshakeComplete", "()V");
        if (mid) {
            env->CallVoidMethod(obj, mid);
        }
    }
}