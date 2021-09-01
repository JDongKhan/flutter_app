import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_app_component/debug/logger/log_console.dart';
import 'package:logger/logger.dart';

/// 日志工具
// var logger = Logger(
//   printer: PrettyPrinter(
//     methodCount: 1,
//     printTime: true,
//     colors: false,
//     // printEmojis: false,
//   ),
//   output: UIAndConsoleOutput.instance,
// );

var logger = Logger(
  printer: HybridPrinter(
    MyLog(),
  ),
  output: UIAndConsoleOutput.instance,
);

///自定义日志格式
class MyLog extends LogPrinter {
  static DateTime _startTime;

  MyLog() {
    _startTime ??= DateTime.now();
  }

  @override
  List<String> log(LogEvent event) {
    var messageStr = stringifyMessage(event.message);

    String stackTraceStr;
    if (event.stackTrace == null) {
      stackTraceStr = formatStackTrace(StackTrace.current, 1);
    } else {
      stackTraceStr = formatStackTrace(event.stackTrace, 1);
    }

    var errorStr = event.error?.toString();

    String timeStr = getTime();
    return ['$timeStr - $stackTraceStr(${event.level}) ', messageStr];
  }

  String stringifyMessage(dynamic message) {
    if (message is Map || message is Iterable) {
      var encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(message);
    } else {
      return message.toString();
    }
  }

  String formatStackTrace(StackTrace stackTrace, int methodCount) {
    String traceString = stackTrace.toString().split('\n')[4];
    int indexOfFileName = traceString.indexOf(RegExp(r'[A-Za-z_]+.dart'));
    var fileInfo = traceString.substring(indexOfFileName);
    fileInfo = fileInfo.replaceFirst(')', '');
    return fileInfo;
  }

  String getTime() {
    String _threeDigits(int n) {
      if (n >= 100) return '$n';
      if (n >= 10) return '0$n';
      return '00$n';
    }

    String _twoDigits(int n) {
      if (n >= 10) return '$n';
      return '0$n';
    }

    var now = DateTime.now();
    var h = _twoDigits(now.hour);
    var min = _twoDigits(now.minute);
    var sec = _twoDigits(now.second);
    var ms = _threeDigits(now.millisecond);
    var timeSinceStart = now.difference(_startTime).toString();
    return '$h:$min:$sec.$ms (+$timeSinceStart)';
  }
}

//自定义日志格式
void JDPrint(Object message) {
  if (kDebugMode) {
    StackTrace currentTrace = StackTrace.current;
    String traceString = currentTrace.toString().split('\n')[1];
    int indexOfFileName = traceString.indexOf(RegExp(r'[A-Za-z_]+.dart'));
    var fileInfo = traceString.substring(indexOfFileName);
    fileInfo = fileInfo.replaceFirst(')', '');
    // var listOfInfos = fileInfo.split(':');
    // String fileName = listOfInfos[0];
    // int lineNumber = int.parse(listOfInfos[1]);
    // var columnStr = listOfInfos[2];
    // columnStr = columnStr.replaceFirst(')', '');
    print('$fileInfo: ${message.toString()}');
  } else if (kReleaseMode) {
  } else if (kProfileMode) {}
}
