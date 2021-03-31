import 'package:flutter/material.dart';
import 'package:jd_core/utils/jd_asset_bundle.dart';
import 'package:jd_core/widget//blurRect/jd_blurrect.dart';

class JDRegisterPage extends StatefulWidget {
  State createState() => _JDRegisterPageState();
}

class _JDRegisterPageState extends State<JDRegisterPage> {
  FocusNode _namefocusNode, _pw1focusNode, _pw2focusNode;
  TextEditingController _nameController, _pw1Controller, _pw2Controller;
  GlobalKey _formKey = new GlobalKey<FormState>();

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
      body: Stack(children: <Widget>[
        _buildBackground(),
        BlurRectWidget(
          child: Container(),
          sigmaX: 20,
          sigmaY: 20,
        ),
        SafeArea(
          //安全区，主要兼容屏幕
          child: _buildRegester(),
        ),
        SafeArea(
          child: Container(
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )),
          ),
        ),
      ]),
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
    return Form(
      key: _formKey,
      autovalidate: true,
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 40.0), // 空出80高度
          const Center(
            //居中
            child: Text(
              '注册',
              style: TextStyle(fontSize: 30.0, color: Colors.white),
            ),
          ),
          const SizedBox(height: 50.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              focusNode: _namefocusNode,
              controller: _nameController,
              obscureText: false,
              textInputAction: TextInputAction.next,
              validator: (String v) {
                // 校验用户名
                return v.trim().length > 0 ? null : '手机号不能为空';
              },
              onFieldSubmitted: (input) {
                _namefocusNode.unfocus();
                FocusScope.of(context).requestFocus(_pw1focusNode);
              },
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.account_box,
                  color: Colors.white,
                ),
                labelText: '手机号',
                labelStyle: TextStyle(color: Colors.white),
                errorStyle: TextStyle(color: Colors.black87),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
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
            child: TextFormField(
              focusNode: _pw1focusNode,
              controller: _pw1Controller,
              obscureText: true,
              textInputAction: TextInputAction.done,
              validator: (String v) {
                //校验密码
                return v.trim().length > 0 ? null : '密码不能少于6位';
              },
              onFieldSubmitted: (input) {
                _pw1focusNode.unfocus();
              },
              decoration: const InputDecoration(
                  labelText: '登录密码',
                  icon: Icon(Icons.settings, color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  errorStyle: TextStyle(color: Colors.black87),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              focusNode: _pw2focusNode,
              controller: _pw2Controller,
              obscureText: true,
              textInputAction: TextInputAction.done,
              validator: (String v) {
                //校验密码
                return v.trim().length > 0 ? null : '密码不能少于6位';
              },
              onFieldSubmitted: (input) {
                _pw2focusNode.unfocus();
              },
              decoration: const InputDecoration(
                  labelText: '确认密码',
                  icon: Icon(Icons.settings, color: Colors.white),
                  labelStyle: TextStyle(color: Colors.white),
                  errorStyle: TextStyle(color: Colors.black87),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  )),
            ),
          ),
          ButtonBar(
            children: <Widget>[
              SizedBox(
                width: 80,
                height: 40,
                child: RaisedButton(
                  color: Colors.cyan,
                  textColor: Colors.white,
                  highlightColor: Colors.blue[100],
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  onPressed: () {
                    _registAction();
                  },
                  child: const Text('确定'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _registAction() {
    String account = _nameController.text;
    String password = _pw1Controller.text;
    String password_2 = _pw2Controller.text;

    if (!(_formKey.currentState as FormState).validate()) {
      //验证通过提交数据
      return;
    }
  }
}
