import 'package:flutter/material.dart';

import 'sports_live_chat_bottom_widget.dart';
import 'sports_live_chat_list_widget.dart';

/// @author jd

class Message {
  final String time;
  final String message;
  final bool isMe;
  final String name;
  const Message({this.time, this.message, this.isMe, this.name});
}

class SportsLiveChatWidget extends StatefulWidget {
  @override
  _SportsLiveChatWidgetState createState() => _SportsLiveChatWidgetState();
}

class _SportsLiveChatWidgetState extends State<SportsLiveChatWidget> {
  final LiveChatInputMessageController _inputMessageController =
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
                child: SportsLiveChatListWidget(),
              ),
            ),
          ),
          SportsLiveChatBottomWidget(
            controller: _inputMessageController,
          ),
        ],
      ),
    );
  }
}
