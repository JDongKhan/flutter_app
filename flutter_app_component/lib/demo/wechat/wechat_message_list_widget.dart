import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_core/jd_core.dart';

/// @author jd

class Message {
  final String time;
  final String message;
  final bool isMe;
  final String name;
  const Message({this.time, this.message, this.isMe, this.name});
}

class WechatMessageListWidget extends StatefulWidget {
  @override
  _WechatMessageListWidgetState createState() =>
      _WechatMessageListWidgetState();
}

class _WechatMessageListWidgetState extends State<WechatMessageListWidget> {
  List message = [];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    message = List.generate(
      50,
      (index) => Message(
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

  _jumpToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ///首次加载需要调两次才能滚动到底
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      Future.delayed(Duration(milliseconds: 50), () {
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
            child: m.isMe ? myMessage(m) : otherMessage(m),
          );
        });
  }

  Widget otherMessage(Message m) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(
                JDAssetBundle.getImgPath('ali_connors'),
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
                    Text(m.message),
                  ],
                ))),
      ],
    );
  }

  Widget myMessage(Message m) {
    return Row(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(left: 50, right: 10),
            child: Text(m.message),
          ),
        ),
        const Icon(Icons.people),
      ],
    );
  }
}
