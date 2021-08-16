import 'package:flutter/material.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd

class WeChatMessageListBottomMenu extends StatefulWidget {
  const WeChatMessageListBottomMenu({this.opacity, this.onBack});
  final double opacity;
  final VoidCallback onBack;
  @override
  _WeChatMessageListBottomMenuState createState() =>
      _WeChatMessageListBottomMenuState();
}

class _WeChatMessageListBottomMenuState
    extends State<WeChatMessageListBottomMenu>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant WeChatMessageListBottomMenu oldWidget) {
    _animationController.animateTo(widget.opacity);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final double width = (jd_screenWidth() - 100) / 3 - 10;
    return FadeTransition(
      opacity: _animationController,
      child: ScaleTransition(
        alignment: Alignment.topCenter,
        scale: _animationController,
        child: Container(
          // transform: Matrix4.diagonal3Values(
          //     _opacityForContainer, _opacityForContainer, 0),
          // transformAlignment: Alignment.topCenter,
          color: Colors.blue[100],
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

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
