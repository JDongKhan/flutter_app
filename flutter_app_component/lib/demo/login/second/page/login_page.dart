import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:jd_core/jd_core.dart';
import 'package:jd_core/view_model/widget/provider_widget.dart';
import 'package:jd_core/widget/webview/web_page.dart';

import '../vm/login_vm.dart';
import '../widget/logo_widget.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final Color redColor = Color.fromRGBO(220, 44, 31, 1);

  bool isAgree = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProviderWidget<LoginVM>(
        model: LoginVM(),
        builder: (ctx, model1) {
          return Container(
            width: jd_getWidth(750),
            height: jd_getHeight(1334),
            color: redColor,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: jd_getWidth(100)),
                  LogoWidget(),
                  SizedBox(height: jd_getWidth(260)),
                  GestureDetector(
                    onTap: () {
                      if (!isAgree) {
                        showHint();
                      } else {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => RegisterPage(),
                            ));
                      }
                    },
                    child: buildBtn('立即登录', Colors.white, redColor),
                  ),
                  SizedBox(height: jd_getWidth(40)),
                  GestureDetector(
                    onTap: () {
                      if (!isAgree) {
                        showHint();
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    child: buildBtn('立即体验', redColor, Colors.white),
                  ),
                  SizedBox(height: jd_getWidth(50)),

                  ///third
                  thirdLogin(),
                  SizedBox(height: jd_getWidth(50)),
                  contractWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void showHint() {
    JDToast.toast('请勾选下方的同意');
  }

  Widget contractWidget() {
    return Container(
      width: jd_getWidth(600),
      height: jd_getWidth(100),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              isAgree = !isAgree;
              setState(() {});
            },
            child: Container(
              alignment: Alignment.topLeft,
              color: redColor,
              width: jd_getWidth(80), //height: getWidthPx(30),
              child: Row(
                children: <Widget>[
                  checkWidget(),
                  Text(
                    '  同意',
                    style:
                        TextStyle(color: Colors.grey, fontSize: jd_getSp(18)),
                  )
                ],
              ),
            ),
          ),
          Text.rich(
            TextSpan(
              text: '登录即代表同意并阅读',
              style: TextStyle(
                fontSize: jd_getSp(22),
                color: Colors.white,
              ),
              children: [
                TextSpan(
                  text: '《用户协议》',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: jd_getSp(22),
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => WebPage(
                            title: '《用户协议》',
                            url: 'https://baidu.com',
                          ),
                        ),
                      );
                    },
                ),
                TextSpan(text: '和'),
                TextSpan(
                  text: '《隐私政策》',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: jd_getSp(22),
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => WebPage(
                            title: '《隐私政策》',
                            url: 'assets/data/my.html',
                          ),
                        ),
                      );
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget checkWidget() {
    return isAgree
        ? Icon(
            Icons.check,
            color: Colors.white,
            size: jd_getWidth(22),
          )
        : Icon(
            Icons.check_box_outline_blank,
            color: Colors.grey,
            size: jd_getWidth(22),
          );
  }

  Widget thirdLogin() {
    return Container(
      width: jd_getWidth(600),
      height: jd_getWidth(100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            JDAssetBundle.getIconPath('wechat'),
            width: jd_getWidth(80),
            height: jd_getWidth(80),
          ),
          Image.asset(
            JDAssetBundle.getIconPath('qq'),
            width: jd_getWidth(80),
            height: jd_getWidth(80),
          ),
          Image.asset(
            JDAssetBundle.getIconPath('weibo'),
            width: jd_getWidth(80),
            height: jd_getWidth(80),
          ),
          Image.asset(
            JDAssetBundle.getIconPath('logo'),
            width: jd_getWidth(80),
            height: jd_getWidth(80),
          ),
        ],
      ),
    );
  }

  Widget buildBtn(String title, Color bgColor, Color textColor) {
    return Container(
      width: jd_getWidth(600),
      height: jd_getWidth(100),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: Colors.white, width: jd_getWidth(1)),
          borderRadius: BorderRadius.circular(jd_getHeight(50))),
      child: Text(
        title,
        style: TextStyle(fontSize: jd_getSp(32), color: textColor),
      ),
    );
  }
}
