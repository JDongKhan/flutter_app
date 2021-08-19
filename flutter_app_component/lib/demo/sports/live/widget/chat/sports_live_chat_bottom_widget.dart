import 'package:flutter/material.dart';

/// @author jd
///

class LiveChatInputMessageController extends ChangeNotifier {
  bool _hiddenKeyboard = false;

  void hiddenKeyboard() {
    _hiddenKeyboard = true;
    notifyListeners();
  }
}

class SportsLiveChatBottomWidget extends StatefulWidget {
  const SportsLiveChatBottomWidget({this.controller});
  final LiveChatInputMessageController controller;
  @override
  _SportsLiveChatBottomWidgetState createState() =>
      _SportsLiveChatBottomWidgetState();
}

class _SportsLiveChatBottomWidgetState extends State<SportsLiveChatBottomWidget>
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
    return _bottomInput();
  }

  Widget _bottomInput() {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.keyboard_voice),
                  onPressed: () {
                    // FocusScope.of(context).requestFocus(FocusNode());
                    _focusNode.unfocus();
                    _animationController.reverse();
                  },
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: _input(),
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
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
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
      ),
    );
  }

  Widget _input() {
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0x00000000),
        ),
      ),
      child: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        minLines: 1,
        focusNode: _focusNode,
        style: const TextStyle(
          fontSize: 14,
        ),
        decoration: const InputDecoration(
          hintText: '请输入你想说的话',
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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

  Widget menu() {
    return SizeTransition(
      sizeFactor: _animation as Animation<double>,
      child: Container(
        height: 260,
        color: Colors.grey[100],
        child: GridView.count(
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          crossAxisCount: 3,
          children: [
            TextButton(
              child: const Text('Menu 1'),
              style: TextButton.styleFrom(backgroundColor: Colors.blue[100]),
              onPressed: () {},
            ),
            TextButton(
              child: const Text('Menu 2'),
              style: TextButton.styleFrom(backgroundColor: Colors.blue[100]),
              onPressed: () {},
            ),
            TextButton(
              child: const Text('Menu 3'),
              style: TextButton.styleFrom(backgroundColor: Colors.blue[100]),
              onPressed: () {},
            ),
            TextButton(
              child: const Text('Menu 4'),
              style: TextButton.styleFrom(backgroundColor: Colors.blue[100]),
              onPressed: () {},
            ),
            TextButton(
              child: const Text('Menu 5'),
              style: TextButton.styleFrom(backgroundColor: Colors.blue[100]),
              onPressed: () {},
            ),
            TextButton(
              child: const Text('Menu 6'),
              style: TextButton.styleFrom(backgroundColor: Colors.blue[100]),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
