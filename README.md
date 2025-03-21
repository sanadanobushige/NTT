import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;

public class OpenSSLSocket extends Socket {
    private long sslCtxPtr;
    private long sslPtr; // OpenSSL 的 SSL 指针

    public OpenSSLSocket(long sslCtxPtr) {
        this.sslCtxPtr = sslCtxPtr;
        this.sslPtr = nativeCreateSSL(sslCtxPtr);
    }

    public OpenSSLSocket(long sslCtxPtr, String host, int port) throws IOException {
        this(sslCtxPtr);
        connect(host, port);
    }

    public OpenSSLSocket(long sslCtxPtr, Socket socket, String host, int port, boolean autoClose) throws IOException {
        this(sslCtxPtr);
        connect(socket, host, port, autoClose);
    }

    private native long nativeCreateSSL(long ctxPtr);
    private native void nativeConnect(long sslPtr, String host, int port);
    private native int nativeWrite(long sslPtr, byte[] data);
    private native int nativeRead(long sslPtr, byte[] buffer);

    public void connect(String host, int port) throws IOException {
        nativeConnect(sslPtr, host, port);
    }

    @Override
    public OutputStream getOutputStream() throws IOException {
        return new OutputStream() {
            @Override
            public void write(int b) throws IOException {
                byte[] data = {(byte) b};
                nativeWrite(sslPtr, data);
            }

            @Override
            public void write(byte[] b, int off, int len) throws IOException {
                byte[] data = new byte[len];
                System.arraycopy(b, off, data, 0, len);
                nativeWrite(sslPtr, data);
            }
        };
    }

    @Override
    public InputStream getInputStream() throws IOException {
        return new InputStream() {
            @Override
            public int read() throws IOException {
                byte[] buffer = new byte[1];
                int result = nativeRead(sslPtr, buffer);
                return (result > 0) ? buffer[0] & 0xFF : -1;
            }

            @Override
            public int read(byte[] b, int off, int len) throws IOException {
                byte[] buffer = new byte[len];
                int bytesRead = nativeRead(sslPtr, buffer);
                if (bytesRead > 0) {
                    System.arraycopy(buffer, 0, b, off, bytesRead);
                }
                return bytesRead;
            }
        };
    }
}