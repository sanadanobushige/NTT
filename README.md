import javax.net.ssl.*;
import java.security.*;
import java.security.cert.*;
import java.util.*;
import java.io.*;

public class OpenSSLContext extends SSLContextSpi {
    static {
        System.loadLibrary("openssl_ssl"); // 加载 JNI 共享库
    }

    private long nativeCtx; // OpenSSL 的 SSL_CTX 指针

    // JNI 方法
    private native long createNativeSSLContext();
    private native void loadKeyAndCert(long ctx, byte[][] keyData, byte[][] certData);
    private native void loadTrustedCAs(long ctx, byte[][] caCerts);

    @Override
    protected void engineInit(KeyManager[] keyManagers, TrustManager[] trustManagers, SecureRandom secureRandom) throws KeyManagementException {
        nativeCtx = createNativeSSLContext(); // 创建 OpenSSL SSL_CTX

        try {
            if (keyManagers != null) {
                loadKeysFromKeyManager(keyManagers);
            }
            if (trustManagers != null) {
                loadCAsFromTrustManager(trustManagers);
            }
        } catch (Exception e) {
            throw new KeyManagementException("Failed to load keys or certificates", e);
        }
    }

    private void loadKeysFromKeyManager(KeyManager[] keyManagers) throws Exception {
        ArrayList<byte[]> keyList = new ArrayList<>();
        ArrayList<byte[]> certList = new ArrayList<>();

        for (KeyManager km : keyManagers) {
            if (km instanceof X509KeyManager) {
                X509KeyManager x509Km = (X509KeyManager) km;
                String[] aliases = x509Km.getClientAliases("RSA", null);
                if (aliases != null) {
                    for (String alias : aliases) {
                        PrivateKey key = x509Km.getPrivateKey(alias);
                        if (key != null) {
                            keyList.add(key.getEncoded());
                        }
                        X509Certificate[] chain = x509Km.getCertificateChain(alias);
                        if (chain != null) {
                            for (X509Certificate cert : chain) {
                                certList.add(cert.getEncoded());
                            }
                        }
                    }
                }
            }
        }

        byte[][] keyData = keyList.toArray(new byte[0][]);
        byte[][] certData = certList.toArray(new byte[0][]);
        loadKeyAndCert(nativeCtx, keyData, certData);
    }

    private void loadCAsFromTrustManager(TrustManager[] trustManagers) throws Exception {
        ArrayList<byte[]> caCertList = new ArrayList<>();

        for (TrustManager tm : trustManagers) {
            if (tm instanceof X509TrustManager) {
                X509TrustManager x509Tm = (X509TrustManager) tm;
                for (X509Certificate cert : x509Tm.getAcceptedIssuers()) {
                    caCertList.add(cert.getEncoded());
                }
            }
        }

        byte[][] caCerts = caCertList.toArray(new byte[0][]);
        loadTrustedCAs(nativeCtx, caCerts);
    }

    @Override
    protected SSLSocketFactory engineGetSocketFactory() {
        return new OpenSSLSocketFactory(nativeCtx);
    }

    @Override
    protected SSLServerSocketFactory engineGetServerSocketFactory() {
        return null; // 可选
    }

    @Override
    protected SSLEngine engineCreateSSLEngine() {
        return null; // 可选
    }

    @Override
    protected SSLEngine engineCreateSSLEngine(String host, int port) {
        return null; // 可选
    }

    @Override
    protected SSLSessionContext engineGetClientSessionContext() {
        return null;
    }

    @Override
    protected SSLSessionContext engineGetServerSessionContext() {
        return null;
    }
}