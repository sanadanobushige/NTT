OkHttpClient client = new OkHttpClient.Builder()
    .sslSocketFactory(new OpenSSLSocketFactory(sslCtxPtr), new CustomTrustManager())
    .connectionSpecs(Arrays.asList(
        new ConnectionSpec.Builder(ConnectionSpec.MODERN_TLS)
            .tlsVersions(TlsVersion.TLS_1_3, TlsVersion.TLS_1_2)
            .cipherSuites(
                CipherSuite.TLS_AES_128_GCM_SHA256,
                CipherSuite.TLS_AES_256_GCM_SHA384,
                CipherSuite.TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,
                CipherSuite.TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
            )
            .build()
    ))
    .build();