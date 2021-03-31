import 'package:flutter/services.dart' show rootBundle;

/// @author jd
///获取本地资源
class JDAssetBundle {
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static Future<String> loadString(String path) async {
    return rootBundle.loadString(path);
  }
}
