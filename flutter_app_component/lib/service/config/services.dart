/// @author jd
///

abstract class Services {
  //base url
  String get baseUrl;
  //login
  String get loginUrl;
}

class ServicesPrd extends Services {
  //base url
  @override
  String get baseUrl => 'http://127.0.0.1:8080';

  //login
  @override
  String get loginUrl => 'http://127.0.0.1:8080/app/user/login';
}

class ServicesSit extends Services {
  //base url
  @override
  String get baseUrl => 'http://127.0.0.1:8080';

  //login
  @override
  String get loginUrl => 'http://127.0.0.1:8080/app/user/login';
}

class ServicesPre extends Services {
  //base url
  @override
  String get baseUrl => 'http://127.0.0.1:8080';

  //login
  @override
  String get loginUrl => 'http://localhost:8080/app/user/login';
}
