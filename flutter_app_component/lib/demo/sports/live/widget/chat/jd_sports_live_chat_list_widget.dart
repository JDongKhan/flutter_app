import 'package:flutter/material.dart';

/// @author jd

class Message {
  final String time;
  final String message;
  final bool isMe;
  final String name;
  const Message({this.time, this.message, this.isMe, this.name});
}

class JDSportsLiveChatListWidget extends StatefulWidget {
  @override
  _JDSportsLiveChatListWidgetState createState() =>
      _JDSportsLiveChatListWidgetState();
}

class _JDSportsLiveChatListWidgetState
    extends State<JDSportsLiveChatListWidget> {
  List message = [];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    message = List.generate(
      50,
      (index) => Message(
        time: '2021-01-01 06:30:$index',
        message: ' this is $index message',
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
    return MediaQuery.removePadding(
      removeTop: true,
      removeBottom: true,
      context: context,
      child: ListView.builder(
          itemCount: message.length,
          controller: _scrollController,
          // padding: const EdgeInsets.all(10),
          itemBuilder: (BuildContext context, int index) {
            Message m = message[index];
            return Container(
              padding: const EdgeInsets.only(
                  left: 10, top: 10, right: 10, bottom: 10),
              child: m.isMe ? myMessage(m) : otherMessage(m),
            );
          }),
    );
  }

  Widget otherMessage(Message m) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Icon(Icons.people),
          ),
          TextSpan(
              text: '会跑马拉松的猫:',
              style: TextStyle(
                color: Colors.grey,
              )),
          TextSpan(
              text: m.message,
              style: TextStyle(
                color: Colors.black,
              )),
        ],
      ),
    );
  }

  Widget myMessage(Message m) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: 'Me:',
              style: TextStyle(
                color: Colors.red,
              )),
          TextSpan(
              text: m.message,
              style: TextStyle(
                color: Colors.black,
              )),
        ],
      ),
    );
    ;
  }
}
