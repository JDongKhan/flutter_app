import 'package:flutter/widgets.dart';

/// @author jd

extension StateExtension on State {
  ///为state生成widget
  Widget toWidget({Key key}) {
    return _CommonWidget(
      state: this,
      key: key,
    );
  }
}

class _CommonWidget extends StatefulWidget {
  final State state;

  const _CommonWidget({Key key, this.state}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return state;
  }
}
