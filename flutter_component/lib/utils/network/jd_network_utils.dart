import 'dart:io';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_component/global/jd_global.dart';
import 'package:flutter_component/utils/network/jd_network_cache.dart';

/**
 *
 * @author jd
 *
 */

class JDNetwork {

  factory JDNetwork() => _getInstance();

  JDNetwork._() {
    final BaseOptions options = BaseOptions(
      connectTimeout: 20000,
      receiveTimeout: 3000,
    );
    _dio = Dio(options);
    _dio.interceptors
      ..add(JDNetworkCacheInterceptor())
      ..add(DioCacheManager(CacheConfig(baseUrl: "http://www.google.cn"))
          .interceptor as Interceptor)
      ..add(CookieManager(
          PersistCookieJar(dir: JDGlobal.temporaryDirectory.path)));

//    if (!kReleaseMode) {
//      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//          (client) {
//        client.findProxy = (uri) {
//          return 'PROXY 10.1.10.250:8888';
//        };
//        //代理工具会提供一个抓包的自签名证书，会通不过证书校验，所以我们禁用证书校验
//        client.badCertificateCallback =
//            (X509Certificate cert, String host, int port) => true;
//      };
//    }
  }

  static JDNetwork _instance;
  Dio _dio;
  //是否是魔客
  static const bool _mock = true;

  static JDNetwork _getInstance() {
    return _instance ?? JDNetwork._();
  }

  static Future<Response<dynamic>> get(String url,
      {Options options, bool cache = false, bool mock = false}) async {
    options = options ?? Options();
    options.extra.addAll(<String, dynamic>{'noCache': cache, 'mock': mock && _mock });
    return await JDNetwork._getInstance()
        ._dio
        .get<dynamic>(url, options: options);
  }

  static Future<Response<dynamic>> post(String url,
      {dynamic data,
      Map<String, dynamic> queryParameters,
      Options options,
      bool mock = false}) async {
    options = options ?? Options();
    options.extra.addAll(<String, dynamic>{'mock': mock && _mock});
    return await JDNetwork._getInstance()._dio.post<dynamic>(url,
        data: data, queryParameters: queryParameters, options: options);
  }
}
