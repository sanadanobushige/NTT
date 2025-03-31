struct addrinfo hints{}, *res;
hints.ai_family = AF_INET;
if (getaddrinfo(host, NULL, &hints, &res) != 0) {
    perror("DNS resolution failed");
    close(sock);
    env->ReleaseStringUTFChars(jhost, host);
    return -3;
}
memcpy(&server_addr.sin_addr, &((struct sockaddr_in *)res->ai_addr)->sin_addr, sizeof(struct in_addr));
freeaddrinfo(res);