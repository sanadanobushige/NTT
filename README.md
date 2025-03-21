import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.SSLSocket;
import java.io.IOException;
import java.net.InetAddress;
import java.net.Socket;

public class OpenSSLFactory extends SSLSocketFactory {
    private final long sslCtxPtr; // OpenSSL SSL_CTX 指针

    public OpenSSLFactory(long sslCtxPtr) {
        this.sslCtxPtr = sslCtxPtr;
    }

    @Override
    public Socket createSocket() throws IOException {
        return new OpenSSLSocket(sslCtxPtr);
    }

    @Override
    public Socket createSocket(String host, int port) throws IOException {
        return new OpenSSLSocket(sslCtxPtr, host, port);
    }

    @Override
    public Socket createSocket(Socket socket, String host, int port, boolean autoClose) throws IOException {
        return new OpenSSLSocket(sslCtxPtr, socket, host, port, autoClose);
    }

    @Override
    public Socket createSocket(InetAddress host, int port) throws IOException {
        return new OpenSSLSocket(sslCtxPtr, host.getHostAddress(), port);
    }

    @Override
    public Socket createSocket(InetAddress address, int port, InetAddress localAddress, int localPort) throws IOException {
        return new OpenSSLSocket(sslCtxPtr, address.getHostAddress(), port);
    }

    @Override
    public String[] getDefaultCipherSuites() {
        return new String[]{"TLS_AES_256_GCM_SHA384", "TLS_AES_128_GCM_SHA256"};
    }

    @Override
    public String[] getSupportedCipherSuites() {
        return getDefaultCipherSuites();
    }
}