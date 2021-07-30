import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/painting/image_provider.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_ume/flutter_ume.dart';
import 'package:flutter_ume/util/floating_widget.dart';
import 'package:jd_core/jd_core.dart';

import 'ume_log_console.dart';

/// @author jd

class LoggerPlugin implements Pluggable {
  LoggerPlugin({Key key});

  @override
  Widget buildWidget(BuildContext context) {
    return FloatingWidget(
      contentWidget: LogConsole(),
    );
  }

  @override
  String get displayName => 'Logger';

  @override
  ImageProvider<Object> get iconImageProvider => AssetImage(
        JDAssetBundle.getIconPath('other', format: 'webp'),
      );

  @override
  String get name => 'Logger';

  @override
  void onTrigger() {}
}
