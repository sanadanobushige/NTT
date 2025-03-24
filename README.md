public class MySSLContext extends SSLContextSpi {
    static {
        System.loadLibrary("myopenssl");
    }

    private long nativeSSLContext; // 存储 C++ 端 OpenSSL 句柄

    public MySSLContext() {
        nativeSSLContext = nativeCreateSSLContext();
    }

    private native long nativeCreateSSLContext();
    private native void nativeFreeSSLContext(long ctx);
    private native SSLSocketFactory nativeGetSSLSocketFactory(long ctx);

    @Override
    protected void engineInit(KeyManager[] km, TrustManager[] tm, SecureRandom sr) {
        // 可在 JNI 层初始化 OpenSSL
    }

    @Override
    protected SSLSocketFactory engineGetSocketFactory() {
        return nativeGetSSLSocketFactory(nativeSSLContext);
    }

    @Override
    protected void finalize() throws Throwable {
        nativeFreeSSLContext(nativeSSLContext);
        super.finalize();
    }
}