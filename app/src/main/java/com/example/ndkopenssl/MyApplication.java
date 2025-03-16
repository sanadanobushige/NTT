package com.example.ndkopenssl;

import android.app.Application;

public class MyApplication extends Application {
    static {
        System.loadLibrary("crypto");
        System.loadLibrary("ssl");
    }

    @Override
    public void onCreate() {
        super.onCreate();

    }
}