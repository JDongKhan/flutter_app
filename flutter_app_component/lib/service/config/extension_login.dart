import 'services_path.dart';

/// @author jd

extension LoginService on ServicesPath {
  ///登录接口
  String get loginUrl => '${services.loginUrl}/user/login.do';
}
