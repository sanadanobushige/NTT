java.lang.ClassCastException: com.example.ssldemo.openssl.OpenSSLSocket cannot be cast to javax.net.ssl.SSLSocket
                                                                                                    	at okhttp3.internal.connection.RealConnection.connectTls(RealConnection.kt:369)
                                                                                                    	at okhttp3.internal.connection.RealConnection.establishProtocol(RealConnection.kt:337)
                                                                                                    	at okhttp3.internal.connection.RealConnection.connect(RealConnection.kt:209)
                                                                                                    	at okhttp3.internal.connection.ExchangeFinder.findConnection(ExchangeFinder.kt:226)
                                                                                                    	at okhttp3.internal.connection.ExchangeFinder.findHealthyConnection(ExchangeFinder.kt:106)
                                                                                                    	at okhttp3.internal.connection.ExchangeFinder.find(ExchangeFinder.kt:74)
                                                                                                    	at okhttp3.internal.connection.RealCall.initExchange$okhttp(RealCall.kt:255)
                                                                                                    	at okhttp3.internal.connection.ConnectInterceptor.intercept(ConnectInterceptor.kt:32)
                                                                                                    	at okhttp3.internal.http.RealInterceptorChain.proceed(RealInterceptorChain.kt:109)
                                                                                                    	at okhttp3.internal.cache.CacheInterceptor.intercept(CacheInterceptor.kt:95)
                                                                                                    	at okhttp3.internal.http.RealInterceptorChain.proceed(RealInterceptorChain.kt:109)
                                                                                                    	at okhttp3.internal.http.BridgeInterceptor.intercept(BridgeInterceptor.kt:83)
                                                                                                    	at okhttp3.internal.http.RealInterceptorChain.proceed(RealInterceptorChain.kt:109)
                                                                                                    	at okhttp3.internal.http.RetryAndFollowUpInterceptor.intercept(RetryAndFollowUpInterceptor.kt:76)
                                                                                                    	at okhttp3.internal.http.RealInterceptorChain.proceed(RealInterceptorChain.kt:109)
                                                                                                    	at okhttp3.internal.connection.RealCall.getResponseWithInterceptorChain$okhttp(RealCall.kt:201)
                                                                                                    	at okhttp3.internal.connection.RealCall$AsyncCall.run(RealCall.kt:517)
                                                                                                    	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1145)
                                                                                                    	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:644)
                                                                                                    	at java.lang.Thread.run(Thread.java:1012)
---------------------------- PROCESS ENDED (7885) for package com.example.ssldemo ----------------------------
