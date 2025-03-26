Dns customDns = hostname -> {
    List<InetAddress> addresses = new ArrayList<>();
    addresses.add(InetAddress.getByName("192.168.1.100")); // 直接指定 IP，绕过 DNS 解析
    return addresses;
};

OkHttpClient client = new OkHttpClient.Builder()
        .dns(customDns)
        .build();