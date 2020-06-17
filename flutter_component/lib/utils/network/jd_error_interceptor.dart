import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'jd_app_exceptions.dart';

class JDErrorInterceptor extends Interceptor {
  @override
  Future onError(DioError err) {
    JDAppException appException = JDAppException.create(err);
    // 错误提示
    debugPrint('DioError===: ${appException.toString()}');
    err.error = appException;
    return super.onError(err);
  }
}
