import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

/// @author jd

class WechatFriendCircleNavigatorController extends ChangeNotifier {
  double alpha = 0.0;
  void changeAlpha(double alpha) {
    if (alpha != this.alpha) {
      this.alpha = alpha;
      notifyListeners();
    }
  }
}

class WechatFriendCircleNavigator extends StatefulWidget {
  final WechatFriendCircleNavigatorController controller;
  const WechatFriendCircleNavigator({
    @required this.controller,
  });
  @override
  _WechatFriendCircleNavigatorState createState() =>
      _WechatFriendCircleNavigatorState();
}

class _WechatFriendCircleNavigatorState
    extends State<WechatFriendCircleNavigator> with TickerProviderStateMixin {
  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          // color: Colors.blue,
          child: Stack(
            children: [
              Opacity(
                opacity: widget.controller.alpha,
                child: Container(
                  color: Colors.black87,
                  child: SafeArea(
                    bottom: false,
                    child: Container(
                      height: 44,
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Container(
                  height: 44,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                          onPressed: () {}),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
