import javax.net.ssl.*;
import java.io.IOException;
import java.net.InetAddress;
import java.net.Socket;

public class OpenSSLSocketFactory extends SSLSocketFactory {
    static {
        System.loadLibrary("myopenssl");
    }

    private long nativeSSLContext; // OpenSSL 的 SSL_CTX 指针

    public OpenSSLSocketFactory() {
        nativeSSLContext = nativeCreateSSLContext();
    }

    private native long nativeCreateSSLContext();
    private native void nativeFreeSSLContext(long ctx);
    private native Socket nativeCreateSSLSocket(long ctx, String host, int port) throws IOException;

    @Override
    public Socket createSocket(String host, int port) throws IOException {
        return nativeCreateSSLSocket(nativeSSLContext, host, port);
    }

    @Override
    public Socket createSocket(Socket s, String host, int port, boolean autoClose) throws IOException {
        return createSocket(host, port);
    }

    @Override
    public String[] getDefaultCipherSuites() {
        return new String[]{"TLS_AES_256_GCM_SHA384", "TLS_AES_128_GCM_SHA256"};
    }

    @Override
    public String[] getSupportedCipherSuites() {
        return getDefaultCipherSuites();
    }

    @Override
    protected void finalize() throws Throwable {
        nativeFreeSSLContext(nativeSSLContext);
        super.finalize();
    }
}