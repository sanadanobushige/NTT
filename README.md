if (inet_pton(AF_INET, host, &server_addr.sin_addr) <= 0) {
        perror("Invalid address");
        close(sock);
        env->ReleaseStringUTFChars(jhost, host);
        return -3;
    }
