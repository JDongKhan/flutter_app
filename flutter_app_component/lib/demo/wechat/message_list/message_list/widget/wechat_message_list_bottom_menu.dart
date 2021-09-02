import 'package:flutter/material.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd

class WeChatMessageListBottomMenuController extends ChangeNotifier {
  WeChatMessageListBottomMenuController(
      {double initOpacity = 0.0, bool animal = false})
      : _opacity = initOpacity,
        _animal = animal;
  double _opacity = 0.0;
  bool _animal = false;
  set opacity(double value) {
    _opacity = value;
    print('透明度:$_opacity');
    notifyListeners();
  }
}

class WeChatMessageListBottomMenu extends StatefulWidget {
  const WeChatMessageListBottomMenu({
    this.controller,
    this.onBack,
    this.onChange,
  });
  final WeChatMessageListBottomMenuController controller;
  final VoidCallback onBack;
  final ValueChanged<double> onChange;
  @override
  _WeChatMessageListBottomMenuState createState() =>
      _WeChatMessageListBottomMenuState();
}

class _WeChatMessageListBottomMenuState
    extends State<WeChatMessageListBottomMenu>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  final ScrollController _scrollController = ScrollController();

  double _bottomHeight = 40;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _animationController.value = widget.controller?._opacity;
    widget.controller?.addListener(() {
      if (widget.controller._animal) {
        _animationController.animateTo(widget.controller._opacity);
      } else {
        _animationController.value = widget.controller._opacity;
      }
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant WeChatMessageListBottomMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final double width = (jd_screenWidth() - 100) / 3 - 10;
    return Container(
      color: Colors.red,
      child: _toSizeTransition(
        child: Container(
          // transform: Matrix4.diagonal3Values(
          //     _opacityForContainer, _opacityForContainer, 0),
          // transformAlignment: Alignment.topCenter,
          child: Column(
            children: [
              Expanded(
                child: SafeArea(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification notification) {
                      if (notification is ScrollUpdateNotification &&
                          notification.dragDetails == null) {
                        if (notification.metrics.pixels >
                            notification.metrics.maxScrollExtent) {
                          _onBack();
                        }
                      }
                    },
                    child: GridView.builder(
                        controller: _scrollController,
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
              ),
              GestureDetector(
                onPanUpdate: (detail) {
                  _bottomHeight -= detail.delta.dy;
                  _bottomHeight = _bottomHeight.clamp(40.0, 100.0);
                  if (_bottomHeight == 100.0) {
                    _onBack();
                  } else {
                    setState(() {});
                  }
                },
                onPanCancel: () {
                  setState(() {
                    _bottomHeight = 40.0;
                  });
                },
                onPanEnd: (detail) {
                  setState(() {
                    _bottomHeight = 40.0;
                  });
                },
                child: Container(
                  color: Colors.pinkAccent,
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(top: 20),
                  child: SafeArea(
                    top: false,
                    child: Container(
                      height: _bottomHeight,
                      child: const Text(
                        '回到首页',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _toScaleTransition({
    Widget child,
  }) {
    return ScaleTransition(
      alignment: Alignment.topCenter,
      scale: _animationController,
      child: child,
    );
  }

  Widget _toFadeTransition({Widget child}) {
    return FadeTransition(
      opacity: _animationController,
      child: child,
    );
  }

  Widget _toSizeTransition({
    Widget child,
  }) {
    return SizeTransition(
      sizeFactor: _animationController,
      child: child,
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
