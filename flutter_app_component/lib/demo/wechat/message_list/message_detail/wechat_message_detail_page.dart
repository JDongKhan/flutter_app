import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'wechat_input_message_widget.dart';
import 'wechat_message_list_widget.dart';

/// @author jd

class WechatMessageDetailPage extends StatefulWidget {
  @override
  _WechatMessageDetailPageState createState() =>
      _WechatMessageDetailPageState();
}

class _WechatMessageDetailPageState extends State<WechatMessageDetailPage> {
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
        title: Text('Wechat'),
      ),
      body: SafeArea(
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
