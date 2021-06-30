import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// @author jd

class VerifyCodeButton extends StatefulWidget {
  @override
  _VerifyCodeButtonState createState() => _VerifyCodeButtonState();
}

class _VerifyCodeButtonState extends State<VerifyCodeButton> {
  int maxTime = 60;
  int currentTime = 0;
  Timer countDownTimer;
  void startTimer() {
    countDownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        currentTime++;
        if (currentTime >= maxTime) {
          currentTime = 0;
          countDownTimer.cancel();
          countDownTimer = null;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    int remain = maxTime - currentTime;
    bool can = remain > 0 && currentTime > 0;
    return TextButton(
      onPressed: can
          ? null
          : () {
              startTimer();
            },
      child: Text(can ? '获取验证码($remain)' : '获取验证码'),
    );
  }

  @override
  void dispose() {
    super.dispose();
    countDownTimer?.cancel();
  }
}
