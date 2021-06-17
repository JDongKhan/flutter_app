import 'package:flutter/material.dart';
import 'package:flutter_app_component/component/auto_complete_text_field.dart';

class JDTextFieldPage extends StatefulWidget {
  @override
  State createState() => _JDTextFieldPageState();
}

class _JDTextFieldPageState extends State<JDTextFieldPage> {
  final TextEditingController _unameController = TextEditingController();

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  FocusScopeNode focusScopeNode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TextField"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              //会卡死
//            autofocus: true,
              focusNode: focusNode1, //关联focusNode1
              controller: _unameController, //设置controller
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: "用户名",
                hintText: "用户名或邮箱",
                prefixIcon: Icon(Icons.person),
                // 未获得焦点下划线设为灰色
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                //获得焦点下划线设为蓝色
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            TextField(
              keyboardType: TextInputType.text,
              focusNode: focusNode2, //关联focusNode2
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                  labelText: "密码",
                  hintText: "您的登录密码",
                  prefixIcon: Icon(Icons.lock)),
              obscureText: true,
            ),
            AutoCompleteTextField(
              decoration: InputDecoration(labelText: 'Country'),
              completeList: [
                'First',
                'Second',
                'Third',
              ],
            ),
            AutoCompleteTextField(
                decoration: InputDecoration(labelText: 'Country2')),
            AutoCompleteTextField(
                decoration: InputDecoration(labelText: 'Country3')),
            AutoCompleteTextField(
                decoration: InputDecoration(labelText: 'Country4')),
            AutoCompleteTextField(
                decoration: InputDecoration(labelText: 'Country5')),
            Builder(builder: (BuildContext ctx) {
              return Column(
                children: <Widget>[
                  RaisedButton(
                    child: const Text("移动焦点"),
                    onPressed: () {
                      //将焦点从第一个TextField移到第二个TextField
                      // 这是一种写法 FocusScope.of(context).requestFocus(focusNode2);
                      // 这是第二种写法
                      focusScopeNode ??= FocusScope.of(context);
                      focusScopeNode.requestFocus(focusNode2);
                    },
                  ),
                  RaisedButton(
                    child: const Text('隐藏键盘'),
                    onPressed: () {
                      // 当所有编辑框都失去焦点时键盘就会收起
                      focusNode1.unfocus();
                      focusNode2.unfocus();
                    },
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
