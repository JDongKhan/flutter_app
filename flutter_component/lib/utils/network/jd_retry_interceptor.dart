import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'jd_connectivity_request_retrier.dart';

class JDRetryOnConnectionChangeInterceptor extends Interceptor {
  JDRetryOnConnectionChangeInterceptor({
    @required this.requestRetrier,
  });

  final JDDioConnectivityRequestRetrier requestRetrier;

  @override
  Future onError(DioError err) async {
    if (_shouldRetry(err)) {
      try {
        return requestRetrier.scheduleRequestRetry(err.request);
      } catch (e) {
        return e;
      }
    }
    return err;
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.DEFAULT &&
        err.error != null &&
        err.error is SocketException;
  }
}
