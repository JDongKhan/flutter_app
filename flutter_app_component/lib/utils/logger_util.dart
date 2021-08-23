import 'package:flutter_app_component/debug/logger/log_console.dart';
import 'package:logger/logger.dart';

/// 日志工具
var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    printTime: true,
    colors: false,
    // printEmojis: false,
  ),
  output: UIAndConsoleOutput.instance,
);
