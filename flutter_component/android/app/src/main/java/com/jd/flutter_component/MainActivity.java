package com.jd.flutter_component;

import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.util.Log;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    String channel = getChannel(this);
    Log.d("channel",channel);
  }

  //获取渠道号
  private static String getChannel(Context context) {
    try {
      PackageManager pm = context.getPackageManager();

      ApplicationInfo appInfo = pm.getApplicationInfo(context.getPackageName(), PackageManager.GET_META_DATA);
      if (appInfo.metaData != null) {
        return appInfo.metaData.getString("UMENG_CHANNEL");
      }
    } catch (PackageManager.NameNotFoundException e) {
      e.printStackTrace();
    }
    return "";
  }

}
