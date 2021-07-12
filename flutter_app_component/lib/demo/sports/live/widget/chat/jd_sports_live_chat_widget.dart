import 'package:flutter/material.dart';

import 'jd_sports_live_chat_bottom_widget.dart';
import 'jd_sports_live_chat_list_widget.dart';

/// @author jd

class Message {
  final String time;
  final String message;
  final bool isMe;
  final String name;
  const Message({this.time, this.message, this.isMe, this.name});
}

class JDSportsLiveChatWidget extends StatefulWidget {
  @override
  _JDSportsLiveChatWidgetState createState() => _JDSportsLiveChatWidgetState();
}

class _JDSportsLiveChatWidgetState extends State<JDSportsLiveChatWidget> {
  LiveChatInputMessageController _inputMessageController =
      LiveChatInputMessageController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[100],
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _inputMessageController.hiddenKeyboard();
                },
                child: JDSportsLiveChatListWidget(),
              ),
            ),
          ),
          JDSportsLiveChatBottomWidget(
            controller: _inputMessageController,
          ),
        ],
      ),
    );
  }
}
