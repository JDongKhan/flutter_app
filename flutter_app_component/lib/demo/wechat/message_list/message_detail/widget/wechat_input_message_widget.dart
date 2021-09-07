import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd

enum WechatInputMessageStatus {
  text,
  voice,
}

class WechatInputMessageController extends ChangeNotifier {
  bool _hiddenKeyboard = false;

  void hiddenKeyboard() {
    _hiddenKeyboard = true;
    notifyListeners();
  }
}

class WechatInputMessageWidget extends StatefulWidget {
  const WechatInputMessageWidget({this.controller, Key key}) : super(key: key);
  final WechatInputMessageController controller;

  @override
  _WechatInputMessageWidgetState createState() =>
      _WechatInputMessageWidgetState();
}

class _WechatInputMessageWidgetState extends State<WechatInputMessageWidget>
    with SingleTickerProviderStateMixin {
  final FocusNode _focusNode = FocusNode();
  Animation _animation;
  AnimationController _animationController;
  final TextEditingController _textEditingController = TextEditingController();

  WechatInputMessageStatus _status = WechatInputMessageStatus.text;
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  final List<String> _list = [
    '照片',
    '拍摄',
    '视频通话',
    '位置',
    '红包',
    '转账',
    '语音输入',
    '收藏',
    '个人名片',
    '文件',
    '卡券',
  ];

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _animationController.reverse(from: 0);
      }
    });

    _animationController = AnimationController(
        duration: const Duration(
          milliseconds: 250,
        ),
        vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.addListener(() {});
    _animationController.reverse();

    widget.controller.addListener(() {
      if (widget.controller._hiddenKeyboard) {
        //收起键盘
        // FocusScope.of(context).requestFocus(FocusNode());
        _focusNode.unfocus();
        _animationController.reverse();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _bottom_input();
  }

  // ignore: non_constant_identifier_names
  Widget _bottom_input() {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.keyboard_voice),
                  onPressed: () {
                    // FocusScope.of(context).requestFocus(FocusNode());
                    _focusNode.unfocus();
                    _animationController.reverse(from: 0);
                    setState(() {
                      if (_status == WechatInputMessageStatus.text) {
                        _status = WechatInputMessageStatus.voice;
                      } else if (_status == WechatInputMessageStatus.voice) {
                        _status = WechatInputMessageStatus.text;
                      }
                    });
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: _status == WechatInputMessageStatus.voice
                        ? _voiceWidget()
                        : _input(),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  icon: const Icon(Icons.face),
                  onPressed: () {
                    // FocusScope.of(context).requestFocus(FocusNode());
                    _focusNode.unfocus();
                    _animationController.forward();
                    if (_status == WechatInputMessageStatus.voice) {
                      setState(() {
                        _status = WechatInputMessageStatus.text;
                      });
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    // FocusScope.of(context).requestFocus(FocusNode());
                    _focusNode.unfocus();
                    _animationController.forward();
                    if (_status == WechatInputMessageStatus.voice) {
                      setState(() {
                        _status = WechatInputMessageStatus.text;
                      });
                    }
                  },
                ),
              ],
            ),
            _menu(),
          ],
        ),
      ),
    );
  }

  Widget _input() {
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0xffeeeeee),
        ),
      ),
      child: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        minLines: 1,
        textInputAction: TextInputAction.send,
        focusNode: _focusNode,
        controller: _textEditingController,
        decoration: const InputDecoration(
          hintText: 'input message',
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          isCollapsed: true, //相当于高度包裹的意思，必须为true，不然有默认的最小高度
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          // isDense: true,
        ),
      ),
    );
  }

  Widget _input2() {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      minLines: 1,
      focusNode: _focusNode,
      decoration: const InputDecoration(
        hintText: 'input message',
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        isDense: true,
        border: OutlineInputBorder(
          gapPadding: 0,
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            width: 1,
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }

  Widget _voiceWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: const Center(
        child: Text('按住 说话'),
      ),
    );
  }

  Widget _menu() {
    const int maxMenuCountOfPage = 8;
    int _pageCount = _list.length ~/ maxMenuCountOfPage;
    if (_list.length % maxMenuCountOfPage > 0) {
      _pageCount++;
    }
    List<Widget> pageChildren = [];
    for (int i = 0; i < _pageCount; i++) {
      int startIndex = i * maxMenuCountOfPage;
      int endIndex = (i + 1) * maxMenuCountOfPage;
      if (endIndex > _list.length) {
        endIndex = _list.length;
      }

      List<Widget> gridChildren = [];
      for (int j = startIndex; j < endIndex; j++) {
        gridChildren.add(JDButton(
          text: Text(_list[j]),
          icon: Icon(Icons.camera),
          middlePadding: 20,
          action: () {},
        ));
      }
      pageChildren.add(GridView.count(
        crossAxisCount: 4,
        children: gridChildren,
      ));
    }
    return SizeTransition(
      sizeFactor: _animation as Animation<double>,
      child: Container(
        height: 260,
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                children: pageChildren,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPageIndex = page;
                  });
                },
              ),
            ),
            Container(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(pageChildren.length, (int index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPageIndex == index
                            ? Colors.blue
                            : Colors.grey),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
