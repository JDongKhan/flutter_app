import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'app_exceptions.dart';

class ErrorInterceptor extends Interceptor {
  @override
  Future onError(DioError err) {
    final AppException appException = AppException.create(err);
    // 错误提示
    debugPrint('DioError===: ${appException.toString()}');
    err.error = appException;
    return super.onError(err);
  }
}
