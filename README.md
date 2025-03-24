public class OpenSSLContext {
    static {
        System.loadLibrary("openssl_ssl"); // 加载 JNI 共享库
    }

    private native void closeSSLConnection(long sslPtr);

    private long sslPtr;

    public void closeConnection() {
        if (sslPtr != 0) {
            closeSSLConnection(sslPtr);
            sslPtr = 0;  // 避免重复释放
        }
    }
}