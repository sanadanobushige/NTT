import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.X509TrustManager;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;

public class OpenSSLContext {
    static {
        System.loadLibrary("openssl_ssl"); // 加载 JNI 共享库
    }

    private SSLContext sslContext;

    public OpenSSLContext() throws NoSuchAlgorithmException, KeyManagementException {
        sslContext = SSLContext.getInstance("TLS");
        sslContext.init(null, new X509TrustManager[]{new OpenSSLTrustManager()}, null);
    }

    public SSLSocketFactory getSocketFactory() {
        return new OpenSSLSocketFactory();  // 使用 OpenSSL 作为底层
    }

    // 本地方法，C/C++ 实现
    public native long createNativeSSLContext();
}