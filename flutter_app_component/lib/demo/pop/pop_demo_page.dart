import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_component/component/pop/pop_route.dart';
import 'package:jd_core/jd_core.dart';
import 'package:popup_window/popup_window.dart';

/// @author jd

class PopDemoPage extends StatefulWidget {
  @override
  _PopDemoPageState createState() => _PopDemoPageState();
}

class _PopDemoPageState extends State<PopDemoPage> {
  double windowHeight = 250;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PopDemo'),
        actions: [
          TextButton(
            onPressed: () {
              showPop();
            },
            child: Text('Pop'),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.red,
          ),
          Column(
            children: [
              _buildUserIcon(),
              PopupWindowButton(
                offset: Offset(0, windowHeight),
                buttonBuilder: (BuildContext context) {
                  return Text('Pop');
                },
                windowBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return FadeTransition(
                    opacity: animation,
                    child: SizeTransition(
                      sizeFactor: animation,
                      child: Container(
                        color: Colors.greenAccent,
                        height: windowHeight,
                      ),
                    ),
                  );
                },
                onWindowShow: () {
                  print('PopupWindowButton window show');
                },
                onWindowDismiss: () {
                  print('PopupWindowButton window dismiss');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showPop() {
    showWindow(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 0, 0),

      /// RelativeRect
      duration: 1,
      windowBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: SizeTransition(
            sizeFactor: animation,
            child: Column(
              children: [
                Container(
                  color: Colors.greenAccent,
                  height: windowHeight,
                ),
                Container(
                  color: Colors.black.withOpacity(0.1),
                  height: windowHeight,
                ),
              ],
            ),
          ),
        );
      },
      onWindowShow: null,
      onWindowDismiss: null,
    );
  }

  ///构建用户头像按钮
  ///点击头像弹出退出按钮
  Widget _buildUserIcon() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 22, 0, 0),
      child: GestureDetector(
        child: Container(
            child: Image.asset(
              JDAssetBundle.getImgPath('ali_connors'),
            ),
            width: 32,
            height: 32,
            alignment: AlignmentDirectional.bottomStart),
        onTap: _showExit,
      ),
    );
  }

  ///构建退出按钮
  Widget _buildExit() {
    return Container(
      width: 91,
      height: 36,
      child: Stack(
        children: <Widget>[
          Image.asset(
            JDAssetBundle.getImgPath('ali_connors'),
            fit: BoxFit.fill,
          ),
          Center(
            child: Text(
              'exit',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  ///弹出退出按钮
  ///点击退出调用onClick
  void _showExit() {
    Navigator.push(
      context,
      PopRoute(
        left: 64,
        top: 122,
        child: _buildExit(),
      ),
    );
  }
}
