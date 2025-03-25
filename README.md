import javax.net.ssl.X509TrustManager;
import java.security.cert.X509Certificate;

public class TrustAllCertsManager implements X509TrustManager {
    @Override
    public void checkClientTrusted(X509Certificate[] chain, String authType) {
        // 不做任何检查
    }

    @Override
    public void checkServerTrusted(X509Certificate[] chain, String authType) {
        // 不做任何检查
    }

    @Override
    public X509Certificate[] getAcceptedIssuers() {
        return new X509Certificate[0]; // 返回空数组
    }
}