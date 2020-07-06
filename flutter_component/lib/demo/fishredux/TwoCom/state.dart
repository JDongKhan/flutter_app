import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class TwoComState implements Cloneable<TwoComState> {

  TextEditingController textEditingController = new TextEditingController(text: "默认输入文案");

  @override
  TwoComState clone() {
    return TwoComState()
      ..textEditingController = textEditingController;
  }
}

TwoComState initState(Map<String, dynamic> args) {
  return TwoComState();
}
