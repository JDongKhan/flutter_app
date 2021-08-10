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
  String get baseUrl => 'https://baidu.com';

  //login
  @override
  String get loginUrl => 'https://m.baidu.com/login';
}

class ServicesSit extends Services {
  //base url
  @override
  String get baseUrl => 'https://baidusit.com';

  //login
  @override
  String get loginUrl => 'https://m.baidusit.com/login';
}

class ServicesPre extends Services {
  //base url
  @override
  String get baseUrl => 'https://baidupre.com';

  //login
  @override
  String get loginUrl => 'https://m.baidupre.com/login';
}
