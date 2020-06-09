import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_component/utils/jd_asset_bundle.dart';
import 'package:path/path.dart' as path;

/**
 *
 * @author jd
 *
 */


class JDNetworkCacheInterceptor extends Interceptor {

  @override
  Future<dynamic> onRequest(RequestOptions options) async {
    if (options.extra['mock'] == true ) {
      final String jsonPath = 'assets/jsons/${path.basenameWithoutExtension(options.path)}.json';
      final String jsonString  = await JDAssetBundle.loadString(jsonPath);
      dynamic json = jsonDecode(jsonString);
      await Future<dynamic>.delayed(const Duration(milliseconds: 1000));
      return Response<dynamic>(
          data: json,
          headers: Headers(),
          extra: options.extra,
          statusCode:200);
    }
    return options;
  }

  @override
  Future onResponse(Response response) async {
     return response;
  }

  @override
  Future onError(DioError err) async {
    return err;
  }
}
