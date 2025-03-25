package com.example.ssldemo.openssl;

import android.util.Log;

import javax.net.ssl.SSLSocketFactory;
import java.io.IOException;
import java.net.InetAddress;
import java.net.Socket;
import java.net.UnknownHostException;

public class OpenSSLSocketFactory extends SSLSocketFactory {
    private static final String TAG = "OpenSSL";
    private final long sslCtxPtr;
    public OpenSSLSocketFactory(long sslCtxPtr) {
        Log.d(TAG,"OpenSSLSocketFactory");
        this.sslCtxPtr = sslCtxPtr;
    }
    @Override
    public Socket createSocket() throws IOException {
        Log.d(TAG,"createSocket1");
        return new OpenSSLSocket(sslCtxPtr);
    }
    @Override
    public Socket createSocket(String host, int port) throws IOException {
        Log.d(TAG,"createSocket2");
        return new OpenSSLSocket(sslCtxPtr, host, port);
    }

    @Override
    public Socket createSocket(String s, int i, InetAddress inetAddress, int i1) throws IOException, UnknownHostException {

        Log.d(TAG,"createSocket3");
        return null;
    }


    @Override
    public Socket createSocket(InetAddress host, int port) throws IOException {
        Log.d(TAG,"createSocket5");
        return new OpenSSLSocket(sslCtxPtr, host.getHostAddress(), port);
    }
    @Override
    public Socket createSocket(InetAddress address, int port, InetAddress localAddress, int localPort) throws IOException {
        Log.d(TAG,"createSocket6");
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

    @Override
    public Socket createSocket(Socket socket, String s, int i, boolean b) throws IOException {
        Log.d(TAG,"createSocket4");
        return null;
    }
}
