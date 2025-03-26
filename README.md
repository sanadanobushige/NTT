import okhttp3.*;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.Proxy;
import java.util.List;

public class OkHttpEventListener extends EventListener {
    @Override
    public void callStart(Call call) {
        System.out.println("🔹 开始请求: " + call.request().url());
    }

    @Override
    public void dnsStart(Call call, String domainName) {
        System.out.println("🔹 DNS 解析: " + domainName);
    }

    @Override
    public void dnsEnd(Call call, String domainName, List<InetAddress> inetAddressList) {
        System.out.println("🔹 解析到 IP: " + inetAddressList);
    }

    @Override
    public void connectStart(Call call, InetSocketAddress inetSocketAddress, Proxy proxy) {
        System.out.println("🔹 连接目标地址: " + inetSocketAddress.getHostName());
        System.out.println("🔹 解析后的 IP: " + inetSocketAddress.getAddress());
        System.out.println("🔹 端口号: " + inetSocketAddress.getPort());
        System.out.println("🔹 代理: " + proxy);
    }

    @Override
    public void secureConnectStart(Call call) {
        System.out.println("🔹 开始 TLS/SSL 握手");
    }

    @Override
    public void secureConnectEnd(Call call, Handshake handshake) {
        System.out.println("🔹 TLS/SSL 握手完成");
        System.out.println("🔹 使用的协议: " + handshake.tlsVersion());
        System.out.println("🔹 服务器证书: " + handshake.peerCertificates());
    }

    @Override
    public void connectFailed(Call call, InetSocketAddress inetSocketAddress, Proxy proxy, Protocol protocol, Throwable throwable) {
        System.out.println("❌ 连接失败: " + throwable.getMessage());
    }

    @Override
    public void callEnd(Call call) {
        System.out.println("✅ 请求完成");
    }

    @Override
    public void callFailed(Call call, IOException ioe) {
        System.out.println("❌ 请求失败: " + ioe.getMessage());
    }
}