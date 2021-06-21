import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/// @author jd

class PageViewPage extends StatefulWidget {
  @override
  _PageViewPageState createState() => _PageViewPageState();
}

class _PageViewPageState extends State<PageViewPage> {
  Map<Type, GestureRecognizerFactory> _gestureRecognizers;
  Drag _drag;
  ScrollPhysics _physics = NeverScrollableScrollPhysics();
  bool _isOpened = false;
  final List _colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
  ];

  SlidableController controller;
  PageController _pageController;
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = 230;

  initGestureRecognizer() {
    _gestureRecognizers = <Type, GestureRecognizerFactory>{
      CustomHorizontalDragGestureRecognizer:
          GestureRecognizerFactoryWithHandlers<
                  CustomHorizontalDragGestureRecognizer>(
              () => CustomHorizontalDragGestureRecognizer(),
              (CustomHorizontalDragGestureRecognizer instance) {
        instance
          ..onStart = _handleDragStart
          ..onUpdate = _handleDragUpdate
          ..onEnd = _handleDragEnd
          ..onCancel = _handleDragCancel;
      }),
    };
  }

  _handleDragStart(details) {
    _drag = _pageController.position.drag(details, _disposeDrag);
  }

  _handleDragUpdate(details) {
    // 右滑pageview获取滑动事件
    if ((details.delta.dx > 0 || details.delta.dx == 0) && !_isOpened) {
      _refreshPhysics(false);
      _drag?.update(details);
    } else {
      _refreshPhysics(true);
      _drag?.cancel();
    }
  }

  // 滑动未停止不处理滑动事件
  _refreshPhysics(bool isSlideLeft) {
    if (isSlideLeft) {
      if (_physics.parent is BouncingScrollPhysics) {
        _physics.applyTo(NeverScrollableScrollPhysics());
      }
    } else {
      if (_physics.parent is NeverScrollableScrollPhysics) {
        _physics.applyTo(BouncingScrollPhysics());
      }
    }
  }

  _handleDragEnd(details) {
    _drag?.end(details);
  }

  _handleDragCancel() {
    assert(_drag == null);
    _drag?.cancel();
  }

  void _disposeDrag() {
    _drag = null;
  }

  @override
  void initState() {
    super.initState();
    initGestureRecognizer();
    _pageController = PageController(initialPage: 4, viewportFraction: 0.9);
    _pageController.addListener(() {
      setState(() {
        _currPageValue = _pageController.page;
      });
    });

    controller = SlidableController(
        onSlideAnimationChanged: (changed) {},
        onSlideIsOpenChanged: (open) {
          _isOpened = open;
        });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PageView'),
      ),
      body: Column(
        children: [
          Container(
            height: _height,
            child: RawGestureDetector(
              gestures: _gestureRecognizers,
              child: PageView.builder(
                itemCount: 10,
                physics: _physics,
                itemBuilder: (c, index) {
                  return _buildPageItem(index);
                },
                controller: _pageController,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildPageItem(int index) {
    Matrix4 matrix4 = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      //当前
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(
        1.0,
        currScale,
        1.0,
      )..setTranslationRaw(
          0.0,
          currTrans,
          0.0,
        );
    } else if (index == _currPageValue.floor() + 1) {
      //右边
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(
          0.0,
          currTrans,
          0.0,
        );
    } else if (index == _currPageValue.floor() - 1) {
      //左边
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix4 = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(
          0.0,
          currTrans,
          0.0,
        );
    } else {
      matrix4 = Matrix4.diagonal3Values(1.0, _scaleFactor, 1.0)
        ..setTranslationRaw(
          0.0,
          _height * (1 - _scaleFactor) / 2,
          0.0,
        );
    }
    return Transform(
      transform: matrix4,
      child: Container(
        color: _colors[index % 3],
        child: Slidable.builder(
          controller: controller,
          actionExtentRatio: 0.23,
          actionPane: const SlidableDrawerActionPane(),
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            color: Colors.red,
            child: ListTile(
              title: Text('title $index'),
              subtitle: Text('subtitle $index'),
            ),
          ),
          secondaryActionDelegate: SlideActionBuilderDelegate(
              builder: (BuildContext context, int index,
                  Animation<double> animation, SlidableRenderingMode step) {
                return SlideAction(
                  color: Theme.of(context).backgroundColor,
                  closeOnTap: false,
                  child: ClipOval(
                    child: Container(
                      height: 48,
                      width: 48,
                      padding: const EdgeInsets.all(12),
                      color: const Color(0xFFEB5147),
                      child: const Icon(Icons.ac_unit),
                    ),
                  ),
                );
              },
              actionCount: 1),
        ),
      ),
    );
  }
}

class CustomHorizontalDragGestureRecognizer
    extends HorizontalDragGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}
