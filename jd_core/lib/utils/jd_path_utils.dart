import 'dart:io';

import 'package:jd_core/utils/jd_appinfo.dart';
import 'package:path_provider/path_provider.dart';

/// @author jd
class JDPathUtils {
  static Future<Directory> getAppDocumentsDirectory() async {
    if (JDAppInfo.isIOS || JDAppInfo.isAndroid) {
      return getApplicationDocumentsDirectory();
    }
    return null;
  }

  static Future<Directory> getAppTemporaryDirectory() {
    if (JDAppInfo.isIOS || JDAppInfo.isAndroid) {
      return getTemporaryDirectory();
    }
    return null;
  }
}
