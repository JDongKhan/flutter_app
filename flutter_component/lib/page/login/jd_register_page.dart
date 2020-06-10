import 'package:flutter/material.dart';
import 'package:flutter_component/utils/jd_asset_bundle.dart';
import 'package:flutter_component/utils/jd_toast_utils.dart';
import 'package:flutter_component/widget/blurRect/jd_blurrect.dart';

class JDRegisterPage extends StatefulWidget {
  State createState() => _JDRegisterPageState();
}

class _JDRegisterPageState extends State<JDRegisterPage> {
  FocusNode _namefocusNode, _pw1focusNode, _pw2focusNode;
  TextEditingController _nameController, _pw1Controller,_pw2Controller;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _pw1Controller = TextEditingController();
    _pw2Controller = TextEditingController();
    _namefocusNode = FocusNode();
    _pw1focusNode = FocusNode();
    _pw2focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildBackground(),
          BlurRectWidget(
            child: Container(),
            sigmaX: 20,
            sigmaY: 20,
          ),
          SafeArea(//安全区，主要兼容屏幕
            child: _buildRegester(),
          ),
          SafeArea(
            child: Container(
              child: IconButton(onPressed: () {
                Navigator.of(context).pop();
              }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
            ),
          ),
        ]
      ),
    );
  }

  Widget _buildBackground() {
    return Image.asset(
      JDAssetBundle.getImgPath("login_background"),
      fit: BoxFit.fill,
      width: double.infinity,
      height: double.infinity,
    );
  }

  Widget _buildRegester() {
    return ListView(
      children: <Widget>[
        const SizedBox(height: 40.0),// 空出80高度
        const Center(//居中
          child: Text(
            '注册',
            style: TextStyle(fontSize: 30.0,color: Colors.white),
          ),
        ),
        const SizedBox(height: 50.0),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            focusNode: _namefocusNode,
            controller: _nameController,
            obscureText: false,
            textInputAction: TextInputAction.next,
            onSubmitted: (input) {
              _namefocusNode.unfocus();
              FocusScope.of(context).requestFocus(_pw1focusNode);
            },
            decoration: const InputDecoration(
              icon: Icon(Icons.account_box,color: Colors.white,),
              labelText: '手机号',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            focusNode: _pw1focusNode,
            controller: _pw1Controller,
            obscureText: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (input) {
              _pw1focusNode.unfocus();
            },
            decoration: const InputDecoration(
                labelText: '登录密码',
                icon: Icon(Icons.settings,color: Colors.white),
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                )
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            focusNode: _pw2focusNode,
            controller: _pw2Controller,
            obscureText: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (input) {
              _pw2focusNode.unfocus();
            },
            decoration: const InputDecoration(
                labelText: '确认密码',
                icon: Icon(Icons.settings,color: Colors.white),
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                )
            ),
          ),
        ),
        ButtonBar(
          children: <Widget>[
            SizedBox(
              width: 80,
              height: 40,
              child:  RaisedButton(
                color: Colors.cyan,
                textColor: Colors.white,
                highlightColor: Colors.blue[100],
                colorBrightness: Brightness.dark,
                splashColor: Colors.grey,
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                onPressed: (){
                  _registAction();
                },
                child: const Text('确定'),
              ),
            ),
          ],
        )
      ],
    );
  }

  void _registAction() {
    String account = _nameController.text;
    String password = _pw1Controller.text;
    String password_2 = _pw2Controller.text;

    if (account == '' || password == '' || password_2 == '') {
      JDToast.toast("账号或密码不能为空");
      return;
    }

    if (password != password_2) {
      JDToast.toast("两次密码不一致");
      return;
    }
  }

}