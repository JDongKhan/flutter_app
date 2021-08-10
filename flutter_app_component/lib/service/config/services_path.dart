import '../environment.dart';
import 'services.dart';

/// @author jd

class ServicesPath {
  ServicesPath(Environment environment) {
    if (environment == Environment.prd) services = ServicesPrd();
    if (environment == Environment.sit) services = ServicesSit();
    if (environment == Environment.pre) services = ServicesPre();
  }

  Services services;

  ///登录接口
  String get loginUrl => '${services.loginUrl}/login.do';

  ///订单查询接口
  String get orderQueryUrl => '${services.baseUrl}/order_query.do';
}
