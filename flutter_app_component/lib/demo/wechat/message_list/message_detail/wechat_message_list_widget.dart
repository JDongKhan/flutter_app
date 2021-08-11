import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_core/jd_core.dart';

import 'bubble_widget.dart';

/// @author jd

class Message {
  const Message({
    this.time,
    this.message,
    this.isMe,
    this.name,
  });
  final String time;
  final String message;
  final bool isMe;
  final String name;
}

class WechatMessageListWidget extends StatefulWidget {
  @override
  _WechatMessageListWidgetState createState() =>
      _WechatMessageListWidgetState();
}

class _WechatMessageListWidgetState extends State<WechatMessageListWidget> {
  List message = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    message = List.generate(
      50,
      (int index) => Message(
        time: '2021-01-01 06:30:$index',
        message:
            ' this is $index message  this is $index message  this is $index message  this is $index message  this is $index message  this is $index message  this is $index message  this is $index message  this is $index message  this is $index message  this is $index message',
        isMe: (index % 10) == 0,
      ),
    );

    _jumpToBottom();

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _jumpToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ///首次加载需要调两次才能滚动到底
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      Future.delayed(const Duration(milliseconds: 50), () {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return list();
  }

  Widget list() {
    return ListView.builder(
        itemCount: message.length,
        controller: _scrollController,
        // padding: const EdgeInsets.all(10),
        itemBuilder: (BuildContext context, int index) {
          Message m = message[index];
          return Container(
            padding:
                const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
            child: m.isMe ? _myMessage(m) : _otherMessage(m),
          );
        });
  }

  Widget _otherMessage(Message m) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(
                JDAssetBundle.getImgPath('user_head_1'),
              ),
            ),
          ),
        ),
        Expanded(
            child: Container(
                margin: const EdgeInsets.only(left: 10, right: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('xiao ming'),
                    const SizedBox(
                      height: 5,
                    ),
                    BubbleWidget(
                      child: Text(m.message),
                    ),
                  ],
                ))),
      ],
    );
  }

  Widget _myMessage(Message m) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(left: 50, right: 10),
            child: BubbleWidget(
              direction: BubbleDirection.right,
              child: Text(m.message),
            ),
          ),
        ),
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(
                JDAssetBundle.getImgPath('user_head_0'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
