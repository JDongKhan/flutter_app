import 'package:flutter/material.dart';
import 'package:flutter_app_component/service/environment.dart';
import 'package:flutter_ume/flutter_ume.dart';
import 'package:flutter_ume/util/floating_widget.dart';
import 'package:jd_core/jd_core.dart';
import 'package:jd_core/utils/jd_enum_utils.dart';

/// @author jd

class EnvironmentPage extends StatefulWidget implements Pluggable {
  @override
  _EnvironmentPageState createState() => _EnvironmentPageState();

  @override
  Widget buildWidget(BuildContext context) =>
      FloatingWidget(contentWidget: this);

  @override
  String get displayName => 'Environment';

  @override
  ImageProvider<Object> get iconImageProvider =>
      AssetImage(JDAssetBundle.getIconPath('qunliao', format: 'webp'));

  @override
  String get name => 'Environment';

  @override
  void onTrigger() {}
}

class _EnvironmentPageState extends State<EnvironmentPage> {
  final List _environments = ['prd', 'sit', 'pre'];

  String _currentEnvironment = 'prd';

  @override
  void initState() {
    _currentEnvironment = EnumUtils.enumValueToString(environments.environment);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        children: _environments
            .map(
              (e) => ListTile(
                title: Text(e),
                trailing:
                    _currentEnvironment == e ? const Icon(Icons.check) : null,
                onTap: () {
                  setState(() {
                    _currentEnvironment = e;
                    //初始化环境配置
                    environments.init(env: e);
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
