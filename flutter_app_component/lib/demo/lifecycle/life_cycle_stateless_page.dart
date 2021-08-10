import 'package:flutter/material.dart';

/// @author jd

class LifeCyclController extends ChangeNotifier {
  int count = 10;
}

class LifeCycleStatelessPage extends StatelessWidget {
  LifeCycleStatelessPage({this.controller});
  LifeCyclController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text('count:${controller.count}'),
          TextButton(
            onPressed: () {
              controller.count++;
              StatelessElement element = context;
              element.markNeedsBuild();
            },
            child: Text('刷新点击按钮'),
          ),
        ],
      ),
    );
  }
}
