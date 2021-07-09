import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../jd_sports_live_controller.dart';

/// @author jd
class JDSportsLivePlayerTopWidget extends StatefulWidget {
  @override
  _JDSportsLivePlayerTopWidgetState createState() =>
      _JDSportsLivePlayerTopWidgetState();
}

class _JDSportsLivePlayerTopWidgetState
    extends State<JDSportsLivePlayerTopWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          width: 50,
        ),
        Expanded(
          child: _buildTitleWidget(),
        ),
        _buildRightActionWidget(),
      ],
    );
  }

  Widget _buildTitleWidget() {
    JDSportsLiveController controller = context.watch<JDSportsLiveController>();
    if (controller.orientation == Orientation.landscape) {
      return Text(
        '我是播放器',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      );
    }
    return Container();
  }

  Widget _buildRightActionWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            Icons.tv,
            color: Colors.white,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.more_horiz,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
