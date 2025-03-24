import javax.net.ssl.*;
import java.io.IOException;
import java.net.Socket;
import java.security.KeyManagementException;
import java.security.NoSuchAlgorithmException;

public class OpenSSLSocketFactory extends SSLSocketFactory {
    static {
        System.loadLibrary("openssl_ssl"); // 加载 JNI 共享库
    }

    private final SSLContext sslContext;
    private long cachedSessionPtr = 0;  // 存储 SSL_SESSION 指针

    public OpenSSLSocketFactory() throws NoSuchAlgorithmException, KeyManagementException {
        this.sslContext = SSLContext.getInstance("TLS");
        this.sslContext.init(null, null, null);
    }

    @Override
    public Socket createSocket(Socket s, String host, int port, boolean autoClose) throws IOException {
        SSLSocket socket = (SSLSocket) sslContext.getSocketFactory().createSocket(s, host, port, autoClose);

        // 复用 SSL Session
        if (cachedSessionPtr != 0) {
            setSSLSession(socket, cachedSessionPtr);
        }

        socket.addHandshakeCompletedListener(event -> {
            // 监听握手完成，存储新的 Session
            cachedSessionPtr = getSSLSession(socket);
        });

        return socket;
    }

    // JNI 方法（C++ 实现）
    private native void setSSLSession(SSLSocket socket, long sessionPtr);
    private native long getSSLSession(SSLSocket socket);

    @Override
    public String[] getDefaultCipherSuites() {
        return new String[0];
    }

    @Override
    public String[] getSupportedCipherSuites() {
        return new String[0];
    }

    @Override
    public Socket createSocket(String host, int port) throws IOException {
        return createSocket(new Socket(), host, port, true);
    }

    @Override
    public Socket createSocket(String host, int port, InetAddress localHost, int localPort) throws IOException {
        return createSocket(new Socket(localHost, localPort), host, port, true);
    }

    @Override
    public Socket createSocket(InetAddress host, int port) throws IOException {
        return createSocket(new Socket(), host.getHostAddress(), port, true);
    }

    @Override
    public Socket createSocket(InetAddress address, int port, InetAddress localAddress, int localPort) throws IOException {
        return createSocket(new Socket(localAddress, localPort), address.getHostAddress(), port, true);
    }
}