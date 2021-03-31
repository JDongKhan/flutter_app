import 'package:connectivity/connectivity.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:jd_core/network/jd_error_interceptor.dart';
import 'package:jd_core/network/jd_mock_interceptor.dart';
import 'package:jd_core/utils/jd_appinfo.dart';
import 'package:jd_core/utils/jd_toast_utils.dart';

import 'jd_retry_interceptor.dart';

typedef JDProgressCallback = void Function(int count, int total);

/// @author jd
class JDNetworkResponse {
  JDNetworkResponse(this.code, {this.errorMsg, this.data});
  int code;
  String errorMsg;
  dynamic data;
}

class JDNetwork {
  JDNetwork._() {
    final BaseOptions options = BaseOptions(
      connectTimeout: 20000,
      receiveTimeout: 3000,
      //请求的contentType,默认值是'application/json;charset=utf-8'
      //自动编码请求体，防止有汉字
      contentType: Headers.formUrlEncodedContentType,
      //接受响应数据，可选json/strem/plain/bytes,默认是json
      responseType: ResponseType.json,
    );
    _dio = Dio(options);
    _dio.interceptors
      ..add(JDNetworkMockInterceptor())
      ..add(JDErrorInterceptor())
      ..add(DioCacheManager(CacheConfig()).interceptor as Interceptor)
      ..add(LogInterceptor(requestBody: true, responseBody: true));
    //iOS和Android才支持本地目录
    if ((defaultTargetPlatform == TargetPlatform.iOS) ||
        (defaultTargetPlatform == TargetPlatform.android)) {
      _dio.interceptors.add(CookieManager(
          PersistCookieJar(dir: JDAppInfo.temporaryDirectory.path)));
    }

    //重试逻辑
    if (retryEnable) {
      _dio.interceptors.add(
        JDRetryOnConnectionChangeInterceptor(
          requestRetrier: JDDioConnectivityRequestRetrier(
            dio: _dio,
            connectivity: Connectivity(),
          ),
        ),
      );
    }

    // 在调试模式下需要抓包调试，所以我们使用代理，并禁用HTTPS证书校验
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

    _fetchTypes.addAll({
      'post': _dio.post,
      'put': _dio.put,
      'patch': _dio.patch,
      'delete': _dio.delete,
      'head': _dio.head,
    });
  }

  static bool retryEnable = false;
  CancelToken cancelToken = CancelToken();
  Dio _dio;

  factory JDNetwork() => _getInstance();
  static JDNetwork _instance;

  //是否是魔客
  static const bool _mock = true;

  static JDNetwork _getInstance() {
    return _instance ?? JDNetwork._();
  }

  /// get请求
  static Future<JDNetworkResponse> get(
    String url, {
    Map<String, dynamic> queryParameters,
    Options options,
    bool cache = false,
    bool mock = false,
    JDProgressCallback progressCallback,
  }) async {
    return await JDNetwork._getInstance()._fetch(
      url,
      queryParameters: queryParameters,
      options: options,
      cache: cache,
      mock: mock,
      progressCallback: progressCallback,
    );
  }

  /// post请求
  static Future<JDNetworkResponse> post(
    String url, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options options,
    bool cache = false,
    bool mock = false,
    JDProgressCallback progressCallback,
  }) async {
    return await JDNetwork._getInstance()._fetch(
      url,
      method: 'post',
      data: data,
      queryParameters: queryParameters,
      options: options,
      cache: cache,
      mock: mock,
      progressCallback: progressCallback,
    );
  }

  /// put请求
  static Future<JDNetworkResponse> put(
    String url, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options options,
    bool cache = false,
    bool mock = false,
    JDProgressCallback progressCallback,
  }) async {
    return await JDNetwork._getInstance()._fetch(
      url,
      method: 'put',
      data: data,
      queryParameters: queryParameters,
      options: options,
      cache: cache,
      mock: mock,
      progressCallback: progressCallback,
    );
  }

  /// patch请求
  static Future<JDNetworkResponse> patch(
    String url, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options options,
    bool cache = false,
    bool mock = false,
    JDProgressCallback progressCallback,
  }) async {
    return await JDNetwork._getInstance()._fetch(
      url,
      method: 'patch',
      data: data,
      queryParameters: queryParameters,
      options: options,
      cache: cache,
      mock: mock,
      progressCallback: progressCallback,
    );
  }

  /// delete请求
  static Future<JDNetworkResponse> delete(
    String url, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options options,
    bool cache = false,
    bool mock = false,
    JDProgressCallback progressCallback,
  }) async {
    return await JDNetwork._getInstance()._fetch(
      url,
      method: 'delete',
      data: data,
      queryParameters: queryParameters,
      options: options,
      cache: cache,
      mock: mock,
      progressCallback: progressCallback,
    );
  }

  /// head请求
  static Future<JDNetworkResponse> head(
    String url, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options options,
    bool cache = false,
    bool mock = false,
    JDProgressCallback progressCallback,
  }) async {
    return await JDNetwork._getInstance()._fetch(
      url,
      method: 'head',
      data: data,
      queryParameters: queryParameters,
      options: options,
      cache: cache,
      mock: mock,
      progressCallback: progressCallback,
    );
  }

  /// 下载文件
  static Future<dynamic> donloadFile(
    String urlPath,
    String savePath, {
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    dynamic data,
    Options options,
    JDProgressCallback progressCallback,
  }) async {
    //进度
    ProgressCallback callback = (int count, int total) {
      if (progressCallback != null) {
        progressCallback(count, total);
      }
    };
    Response response = await JDNetwork._getInstance()._dio.download(
        urlPath, savePath,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        data: data,
        options: options,
        onReceiveProgress: callback);
    return response.data;
  }

  ///取消请求，会取消所有使用cancelToken的请求，慎用！！！，如需要取消某一个，可自行管理
  static void cancel() {
    JDNetwork._getInstance().cancelToken.cancel('用户手动取消');
  }

  final Map<String, Function> _fetchTypes = {};

  ///请求处理
  Future<JDNetworkResponse> _fetch(
    String url, {
    String method = 'get',
    //data 可传FormData
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options options,
    bool cache = false,
    bool mock = false,
    JDProgressCallback progressCallback,
  }) async {
    final ConnectivityResult connResult =
        await Connectivity().checkConnectivity();
    if (connResult != null && connResult == ConnectivityResult.none) {
      JDToast.toast('网络连接失败');
      // throw DioError(error: JDUnreachableNetworkException());
    }

    options = options ?? Options();
    //添加额外参数
    options.extra
        .addAll(<String, dynamic>{'noCache': cache, 'mock': mock && _mock});
    //添加公共参数
    options.headers.addAll({
      'userAgent': 'MyApp',
    });

    //进度
    ProgressCallback callback = (int count, int total) {
      if (progressCallback != null) {
        progressCallback(count, total);
      }
    };

    // ignore: always_specify_types
    Response r;
    if (method == 'get') {
      //Get请求
      String fullPath = url;
      if (queryParameters != null && queryParameters.isNotEmpty) {
        final List<String> params = [];
        queryParameters.forEach((String key, dynamic value) {
          params.add('$key=$value');
        });
        fullPath += '?' + params.join(',');
      }
      r = await JDNetwork._getInstance()._dio.get<dynamic>(fullPath,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: callback);
    } else {
      //Post等其他请求
      r = await _fetchTypes[method]<dynamic>(url,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          progressCallback: callback);
    }
    //r.data 响应体
    //r.header 响应头
    //r.request 请求体
    //r.statusCode 状态码
    return JDNetworkResponse(0, data: r.data);
  }
}
