public class OpenSSLWrapper {

    static {
        // 加载本地库
        System.loadLibrary("openssl_native");
    }

    // 声明本地方法
    public native String getVersion();

    public static void main(String[] args) {
        OpenSSLWrapper wrapper = new OpenSSLWrapper();
        String version = wrapper.getVersion();
        System.out.println("OpenSSL Version: " + version);
    }
}