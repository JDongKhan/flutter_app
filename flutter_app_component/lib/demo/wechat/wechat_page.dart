import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'wechat_input_message_widget.dart';
import 'wechat_message_list_widget.dart';

/// @author jd

class WechatPage extends StatefulWidget {
  @override
  _WechatPageState createState() => _WechatPageState();
}

class _WechatPageState extends State<WechatPage> {
  final WechatInputMessageController _inputMessageController =
      WechatInputMessageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wehchat'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.deepOrange,
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    _inputMessageController.hiddenKeyboard();
                  },
                  child: WechatMessageListWidget(),
                ),
              ),
            ),
            WechatInputMessageWidget(
              controller: _inputMessageController,
            ),
          ],
        ),
      ),
    );
  }
}
