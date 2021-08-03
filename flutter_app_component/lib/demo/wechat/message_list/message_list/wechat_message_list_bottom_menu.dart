import 'package:flutter/material.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd

class WeChatMessageListBottomMenu extends StatefulWidget {
  WeChatMessageListBottomMenu({this.opacity, this.onBack});
  final double opacity;
  final VoidCallback onBack;
  @override
  _WeChatMessageListBottomMenuState createState() =>
      _WeChatMessageListBottomMenuState();
}

class _WeChatMessageListBottomMenuState
    extends State<WeChatMessageListBottomMenu> {
  @override
  Widget build(BuildContext context) {
    double width = (jd_screenWidth() - 100) / 3 - 10;
    return Opacity(
      opacity: widget.opacity,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          transform: Matrix4.diagonal3Values(widget.opacity, widget.opacity, 0),
          transformAlignment: Alignment.topCenter,
          color: Colors.red,
          child: GridView.builder(
              padding: const EdgeInsets.all(10),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: width, //每个宽100
                crossAxisSpacing: 10,
                mainAxisExtent: 50,
              ),
              itemCount: 10,
              itemBuilder: (context, i) {
                return GestureDetector(
                  child: Text('菜单$i'),
                  onTap: () {
                    _onBack();
                  },
                );
              }),
        ),
      ),
    );
  }

  void _onBack() {
    if (widget.onBack != null) {
      widget.onBack();
    }
  }
}
