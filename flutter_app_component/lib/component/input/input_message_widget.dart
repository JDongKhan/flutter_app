import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// @author jd

OverlayEntry overlayEntry;

void dismissInputMessage() {
  if (overlayEntry != null) {
    overlayEntry.remove();
    overlayEntry = null;
  }
}

void showInputMessage(BuildContext context) {
  dismissInputMessage();
  overlayEntry = OverlayEntry(builder: (context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(
        0.4,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Container(
            color: Colors.white,
            child: SafeArea(
              top: false,
              child: InputMessageWidget(),
            ),
          ),
        ],
      ),
    );
  });

  OverlayState overlay = Overlay.of(context);
  overlay.insert(overlayEntry);
}

class InputMessageWidget extends StatefulWidget {
  @override
  _InputMessageWidgetState createState() => _InputMessageWidgetState();
}

class _InputMessageWidgetState extends State<InputMessageWidget> {
  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _focusNode.requestFocus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _input(),
              ),
              Container(
                width: 100,
                child: Column(
                  children: [
                    Icon(Icons.open_in_full_outlined),
                    TextButton(
                      onPressed: () {},
                      child: Text('发布'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                  icon: Icon(Icons.message),
                  onPressed: () {
                    dismissInputMessage();
                  }),
              IconButton(icon: Icon(Icons.face), onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _input() {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.only(
        left: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: const Color(0xffEEEEEE),
        ),
      ),
      child: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: 4,
        minLines: 1,
        focusNode: _focusNode,
        decoration: const InputDecoration(
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
}
