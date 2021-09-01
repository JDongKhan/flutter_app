import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../vm/sports_live_controller.dart';

/// @author jd
class SportsLivePlayerTopWidget extends StatefulWidget {
  @override
  _SportsLivePlayerTopWidgetState createState() =>
      _SportsLivePlayerTopWidgetState();
}

class _SportsLivePlayerTopWidgetState extends State<SportsLivePlayerTopWidget> {
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
    SportsLiveController controller = Get.find<SportsLiveController>();
    if (controller.orientation == Orientation.landscape) {
      return const Text(
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
          onPressed: () {},
          icon: const Icon(
            Icons.tv,
            size: 20,
            color: Colors.white,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_horiz,
            size: 20,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
