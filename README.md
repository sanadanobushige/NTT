gcc -shared -o openssl_native.dll -I"C:/Program Files/Java/jdk1.8.0_251/include" -I"C:/Program Files/Java/jdk1.8.0_251/include/win32" -I"C:/OpenSSL/include" -L"C:/OpenSSL/lib" -lssl -lcrypto -static OpenSSLWrapper.c