import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// @author jd

class WechatInputMessageController extends ChangeNotifier {
  bool _hiddenKeyboard = false;

  hiddenKeyboard() {
    _hiddenKeyboard = true;
    notifyListeners();
  }
}

class WechatInputMessageWidget extends StatefulWidget {
  final WechatInputMessageController controller;

  const WechatInputMessageWidget({this.controller, Key key}) : super(key: key);

  @override
  _WechatInputMessageWidgetState createState() =>
      _WechatInputMessageWidgetState();
}

class _WechatInputMessageWidgetState extends State<WechatInputMessageWidget>
    with SingleTickerProviderStateMixin {
  FocusNode _focusNode = FocusNode();
  Animation _animation;
  AnimationController _animationController;

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _animationController.reverse(from: 0);
      }
    });

    _animationController = AnimationController(
        duration: Duration(
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
    return bottom_input();
  }

  Widget bottom_input() {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Row(
            children: [
              TextButton(
                child: Text('Voice'),
                onPressed: () {
                  // FocusScope.of(context).requestFocus(FocusNode());
                  _focusNode.unfocus();
                  _animationController.reverse(from: 0);
                },
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: input(),
              ),
              const SizedBox(
                width: 10,
              ),
              TextButton(
                child: Text('Face'),
                onPressed: () {
                  // FocusScope.of(context).requestFocus(FocusNode());
                  _focusNode.unfocus();
                  _animationController.forward();
                },
              ),
              TextButton(
                child: Text('+'),
                onPressed: () {
                  // FocusScope.of(context).requestFocus(FocusNode());
                  _focusNode.unfocus();
                  _animationController.forward();
                },
              ),
            ],
          ),
          menu(),
        ],
      ),
    );
  }

  Widget input() {
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0x000000),
        ),
      ),
      child: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        minLines: 1,
        focusNode: _focusNode,
        decoration: InputDecoration(
          hintText: 'input message',
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          // isDense: true,
        ),
      ),
    );
  }

  Widget input2() {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      minLines: 1,
      focusNode: _focusNode,
      decoration: InputDecoration(
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

  Widget menu() {
    return SizeTransition(
      sizeFactor: _animation as Animation<double>,
      child: Container(
        height: 310,
        child: GridView.count(
          crossAxisCount: 4,
          children: [
            TextButton(
              child: Text('Menu 1'),
              onPressed: () {},
            ),
            TextButton(
              child: Text('Menu 2'),
              onPressed: () {},
            ),
            TextButton(
              child: Text('Menu 3'),
              onPressed: () {},
            ),
            TextButton(
              child: Text('Menu 4'),
              onPressed: () {},
            ),
            TextButton(
              child: Text('Menu 5'),
              onPressed: () {},
            ),
            TextButton(
              child: Text('Menu 6'),
              onPressed: () {},
            ),
            TextButton(
              child: Text('Menu 7'),
              onPressed: () {},
            ),
            TextButton(
              child: Text('Menu 8'),
              onPressed: () {},
            ),
            TextButton(
              child: Text('Menu 9'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
