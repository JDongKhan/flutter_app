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

class Environments {
  ///Environments 构造
  Environments({
    this.environment = Environment.prd,
    this.debug = false,
  }) {
    servicesPath = ServicesPath(environment);
  }

  ///工厂方法
  factory Environments.environment(Environment environment) {
    return Environments(environment: environment);
  }

  ///服务配置
  static ServicesPath servicesPath;

  ///环境
  final Environment environment;

  ///是否是debug
  final bool debug;
}
