import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bobble_widget.dart';

class DemoLoginUI extends StatefulWidget {
  @override
  _DemoLoginUIState createState() => _DemoLoginUIState();
}

class _DemoLoginUIState extends State<DemoLoginUI>
    with TickerProviderStateMixin {
  AnimationController _fadeAnimationController;

  @override
  void initState() {
    _fadeAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1800));
    _fadeAnimationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: BobbleWidget(
          child: Stack(
            children: [
              //  第四部分 顶部的稳步
              buildTopText(),
              //  第五部分 输入区域
              buildBottomColumn()
            ],
          ),
        ),
      ),
    );
  }

  buildTopText() {
    return Positioned(
      left: 0,
      right: 0,
      top: 160,
      child: Text(
        'Hello World',
        style: TextStyle(fontSize: 44, color: Colors.deepPurple),
        textAlign: TextAlign.center,
      ),
    );
  }

  buildBottomColumn() {
    return Positioned(
      left: 44,
      right: 44,
      bottom: 84,
      child: FadeTransition(
        opacity: _fadeAnimationController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //  自定义文本输入框
            TextFieldWidget(
              obscureText: false,
              labelText: "账号",
              prefixIconData: Icons.phone_android_outlined,
            ),
            SizedBox(
              height: 14,
            ),
            TextFieldWidget(
              obscureText: true,
              labelText: "密码",
              prefixIconData: Icons.lock_outline,
              suffixIconData: Icons.visibility,
            ),
            SizedBox(
              height: 14,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(
                '忘记密码',
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 14, color: Colors.blue),
              ),
            ),

            SizedBox(
              height: 14,
            ),

            Container(
              height: 42,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('登录'),
              ),
            ),

            SizedBox(
              height: 12,
            ),

            Container(
              height: 42,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('注册'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldWidget extends StatelessWidget {
  Function(String value) onChanged;
  bool obscureText;
  String labelText;
  IconData prefixIconData;
  IconData suffixIconData;

  TextFieldWidget(
      {this.onChanged,
      this.obscureText,
      this.labelText,
      this.prefixIconData,
      this.suffixIconData});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      obscureText: obscureText,
      style: TextStyle(color: Colors.blue, fontSize: 14.0),
      //  输入框可用时边框配置
      decoration: InputDecoration(
        filled: true,
        labelText: labelText,
        // 去掉默认的下划线
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
        // 获取输入焦点时的边框样式
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.blue)),
        prefixIcon: Icon(
          prefixIconData,
          size: 18,
          color: Colors.blue,
        ),
        suffixIcon: Icon(
          suffixIconData,
          size: 18,
          color: Colors.blue,
        ),
      ),
    );
  }
}
