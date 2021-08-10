import 'package:flutter/cupertino.dart';

import 'config/services_path.dart';

/// @author jd

///环境配置
enum Environment {
  ///prd
  prd,

  ///sit
  sit,

  ///pre
  pre,
}

// ignore: avoid_classes_with_only_static_members
class Environments {
  ///初始化

  static void init({
    String environment = 'prd',
    bool debug = false,
  }) {
    debugPrint('初始化环境:$environment');
    if (environment == 'prd') {
      Environments.environment = Environment.prd;
    } else if (environment == 'sit') {
      Environments.environment = Environment.sit;
    } else if (environment == 'pre') {
      Environments.environment = Environment.pre;
    }
    Environments.debug = debug;
    servicesPath = ServicesPath(Environments.environment);
  }

  ///服务配置
  static ServicesPath servicesPath;

  ///环境
  static Environment environment;

  ///是否是debug
  static bool debug;
}
