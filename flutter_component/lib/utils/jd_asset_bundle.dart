import 'package:flutter/services.dart' show rootBundle;


class JDAssetBundle {

  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  static Future<String> loadString(String path) async {
    return rootBundle.loadString(path);
  }

}