extern "C"
JNIEXPORT void JNICALL
Java_com_example_ssldemo_openssl_OpenSSLSocketFactory_nativeConnect(JNIEnv *env, jobject thiz,
                                                                    jlong sslPtr, jstring jhost,
                                                                    jint port) {
    const char *host = env->GetStringUTFChars(jhost, NULL);

    BIO *bio = BIO_new_ssl_connect(reinterpret_cast<SSL *>(sslPtr));
    BIO_set_conn_hostname(bio, host);

    if (BIO_do_connect(bio) <= 0) {
        ERR_print_errors_fp(stderr);
    }
    env->ReleaseStringUTFChars(jhost, host);
}
