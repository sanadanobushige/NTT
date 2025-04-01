import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;

public class HttpUrlConnectionExample {
    public static void main(String[] args) {
        try {
            // 1. 创建 URL 对象
            URL url = new URL("https://www.example.com");

            // 2. 打开连接
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();

            // 3. 设置请求方法（可选，默认是 GET）
            connection.setRequestMethod("GET");

            // 4. 连接服务器
            connection.connect();

            // 5. 获取响应代码
            int responseCode = connection.getResponseCode();
            System.out.println("Response Code: " + responseCode);

            // 6. 读取响应数据（如果需要）
            if (responseCode == HttpURLConnection.HTTP_OK) { // 200 OK
                InputStream inputStream = connection.getInputStream();
                byte[] data = inputStream.readAllBytes();
                String response = new String(data);
                System.out.println("Response Body: " + response);
                inputStream.close();
            }

            // 7. 断开连接
            connection.disconnect();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}