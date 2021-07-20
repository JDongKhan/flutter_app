import 'package:flutter_app_component/component/logger/log_console.dart';
import 'package:logger/logger.dart';

/// @author jd

var logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    printTime: true,
    colors: false,
  ),
  output: UIAndConsoleOutput.instance,
);
