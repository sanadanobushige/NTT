	
                                                                                                    	2025-03-26 10:35:01.227  1112-21366 CCTUploader             com.google.android.gms.persistent    W  Clearcut transport failed to make network request after 4012 milliseconds.
                                                                                                    java.io.IOException: bpcw: Failed to process request
                                                                                                    	at alfp.a(:com.google.android.gms@242335041@24.23.35 (190800-646585959):106)
                                                                                                    	at algl.b(:com.google.android.gms@242335041@24.23.35 (190800-646585959):367)
                                                                                                    	at com.google.android.gms.clearcut.uploader.QosUploaderChimeraService.g(:com.google.android.gms@242335041@24.23.35 (190800-646585959):1469)
                                                                                                    	at com.google.android.gms.clearcut.uploader.QosUploaderChimeraService.a(:com.google.android.gms@242335041@24.23.35 (190800-646585959):24)
                                                                                                    	at bpjj.call(:com.google.android.gms@242335041@24.23.35 (190800-646585959):32)
                                                                                                    	at java.util.concurrent.FutureTask.run(FutureTask.java:264)
                                                                                                    	at angs.c(:com.google.android.gms@242335041@24.23.35 (190800-646585959):50)
                                                                                                    	at angs.run(:com.google.android.gms@242335041@24.23.35 (190800-646585959):76)
                                                                                                    	at java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1145)
                                                                                                    	at java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:644)
                                                                                                    	at anmg.run(:com.google.android.gms@242335041@24.23.35 (190800-646585959):8)
                                                                                                    	at java.lang.Thread.run(Thread.java:1012)
                                                                                                    Caused by: bpcw: Failed to process request
                                                                                                    	at bpgb.b(:com.google.android.gms@242335041@24.23.35 (190800-646585959):19)
                                                                                                    	at bpgp.onFailed(:com.google.android.gms@242335041@24.23.35 (190800-646585959):13)
                                                                                                    	at m.mw.onFailed(:com.google.android.gms.dynamite_cronetdynamite@242335041@24.23.35 (190800-0):3)
                                                                                                    	at m.lw.run(:com.google.android.gms.dynamite_cronetdynamite@242335041@24.23.35 (190800-0):9)
                                                                                                    	at etxk.execute(:com.google.android.gms@242335041@24.23.35 (190800-646585959):1)
                                                                                                    	at org.chromium.net.impl.CronetUrlRequest.onNativeAdapterDestroyed(:com.google.android.gms.dynamite_cronetdynamite@242335041@24.23.35 (190800-0):18)
                                                                                                    Caused by: m.mj: Exception in CronetUrlRequest: net::ERR_QUIC_PROTOCOL_ERROR, ErrorCode=10, InternalErrorCode=-356, Retryable=false, QuicDetailedErrorCode=25
                                                                                                    	at org.chromium.net.impl.CronetUrlRequest.onError(:com.google.android.gms.dynamite_cronetdynamite@242335041@24.23.35 (190800-0):6)
2025-03-26 10:35:01.277  1112-29780 NetworkScheduler.Stats  com.google.android.gms.persistent    I  (REDACTED) Task %s/%s finished executing. cause:%s result: %s elapsed_millis: %s uptime_millis: %s exec_start_elapsed_seconds: %s
