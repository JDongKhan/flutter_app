import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_component/demo/login/second/widget/verify_code_button.dart';
import 'package:jd_core/jd_core.dart';
import 'package:jd_core/view_model/widget/provider_widget.dart';
import 'package:provider/provider.dart';

import '../common/user_center_view_model.dart';
import '../vm/register_vm.dart';

///没有多余的手机号了，只能登录，没法注册

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterVM registerVM = RegisterVM();
  UserCenterViewModel userViewModel;

  double horPadding;
  @override
  void initState() {
    horPadding = jd_getWidth(30);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.userViewModel = context.read<UserCenterViewModel>();
    return Scaffold(
      body: ProviderWidget<RegisterVM>(
        model: registerVM,
        builder: (ctx, model) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: horPadding),
            color: Colors.white,
            width: jd_getWidth(750),
            height: jd_getHeight(1334),
            child: Column(
              children: <Widget>[
                appBar(),
                SizedBox(height: jd_getWidth(100)),

                ///input area
                inputArea(),
                SizedBox(height: jd_getWidth(100)),

                ///btn
                GestureDetector(
                  onTap: clickBtn,
                  child: buildBtn(registerVM.getBtnText(),
                      registerVM.getBgColor(), Colors.white),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget inputArea() {
    switch (registerVM.phase) {
      case Phase.MobileNumber:
        return inputPhone();
      case Phase.Password:
        return inputPWD();
      case Phase.VerifyCode:
        return inputVerifyCode();
        break;
      case Phase.SetPWD:
        // TODO: Handle this case.
        break;
      case Phase.NickName:
        // TODO: Handle this case.
        break;
    }
  }

  Widget inputPWD() {
    return Container(
      height: jd_getWidth(80),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey, width: jd_getWidth(1)))),
      child: TextField(
        controller: registerVM.pwdController,
        onChanged: (text) {
          registerVM.setPWD(text);
        },
        obscureText: true,
        style: TextStyle(color: Colors.black, fontSize: jd_getSp(32)),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '请输入密码',
          hintStyle: TextStyle(color: Colors.grey, fontSize: jd_getSp(30)),
          suffixIcon: GestureDetector(
            onTap: () {
              if (registerVM.pwdController != null) {
                registerVM.clearPWD();
              }
            },
            child: Icon(
              Icons.clear,
              color: Colors.grey,
              size: jd_getWidth(50),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputPhone() {
    return Container(
      height: jd_getWidth(80),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey, width: jd_getWidth(1)))),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: registerVM.phoneController,
        inputFormatters: [
          FilteringTextInputFormatter(RegExp('[0-9]'), allow: true),
          LengthLimitingTextInputFormatter(11),
        ],
        onChanged: (text) {
          registerVM.setPhone(text);
        },
        style: TextStyle(color: Colors.black, fontSize: jd_getSp(32)),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '请输入手机号',
          hintStyle: TextStyle(color: Colors.grey, fontSize: jd_getSp(30)),
          suffixIcon: GestureDetector(
            onTap: () {
              if (registerVM.phoneController != null) {
                registerVM.clearPhone();
              }
            },
            child: Icon(
              Icons.clear,
              color: Colors.grey,
              size: jd_getWidth(50),
            ),
          ),
        ),
      ),
    );
  }

  //获取验证码
  Widget inputVerifyCode() {
    return Container(
      height: jd_getWidth(80),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey, width: jd_getWidth(1)))),
      child: TextField(
        controller: registerVM.codeController,
        onChanged: (text) {
          registerVM.setCode(text);
        },
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter(RegExp('[0-9]'), allow: true),
          LengthLimitingTextInputFormatter(6),
        ],
        style: TextStyle(color: Colors.black, fontSize: jd_getSp(32)),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '请输入验证码',
          hintStyle: TextStyle(color: Colors.grey, fontSize: jd_getSp(30)),
          suffixIcon: VerifyCodeButton(),
        ),
      ),
    );
  }

  Widget buildBtn(String title, Color bgColor, Color textColor) {
    return Container(
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

  Widget appBar() {
    return Container(
      width: jd_getWidth(750),
      height: jd_getWidth(160),
      alignment: Alignment.bottomLeft,
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: clickBackBtn,
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: jd_getWidth(40),
            ),
          ),
          SizedBox(width: jd_getWidth(30)),
          Text(
            '手机号登录',
            style: TextStyle(color: Colors.black, fontSize: jd_getSp(32)),
          ),
        ],
      ),
    );
  }

  void clickBackBtn() {
    switch (registerVM.phase) {
      case Phase.MobileNumber:
        Navigator.of(context).pop();
        break;
      case Phase.Password:
        registerVM.updatePhase(Phase.MobileNumber);
        break;
      case Phase.VerifyCode:
        registerVM.updatePhase(Phase.MobileNumber);
        break;
      case Phase.SetPWD:
        // TODO: Handle this case.
        break;
      case Phase.NickName:
        // TODO: Handle this case.
        break;
    }
  }

  void clickBtn() {
    switch (registerVM.phase) {
      case Phase.MobileNumber:
        if (registerVM.phone.isEmpty) {
          JDToast.toast('手机号不能为空');
          return;
        }
        //调接口检查是否注册过了
        registerVM.checkAccount().then((value) => {
              if (value == null)
                {
                  registerVM.updatePhase(Phase.VerifyCode),
                }
              else if (value['loginType'] == 0)
                {
                  registerVM.updatePhase(Phase.VerifyCode),
                }
              else
                {
                  registerVM.updatePhase(Phase.Password),
                }
            });

        break;
      case Phase.Password:
        if (registerVM.pwd.isEmpty) {
          JDToast.toast('密码不能为空');
          return;
        }
        registerVM.login().then((userEntity) {
          if (userEntity != null && userEntity.code == 200) {
            userViewModel.saveUser(userEntity);
            Navigator.of(context).pop(userEntity);
          }
        });
        //registerVM.updatePhase(Phase.MobileNumber);
        break;
      case Phase.VerifyCode:
        if (registerVM.code.isEmpty) {
          JDToast.toast('验证码不能为空');
          return;
        }
        registerVM.login().then((userEntity) {
          if (userEntity != null && userEntity.code == 200) {
            userViewModel.saveUser(userEntity);
            Navigator.of(context).pop(userEntity);
          }
        });
        break;
      case Phase.SetPWD:
        // TODO: Handle this case.
        break;
      case Phase.NickName:
        // TODO: Handle this case.
        break;
    }
  }
}
