import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(TwoPageState state, Dispatch dispatch, ViewService viewService) {
  
  ListAdapter listAdapter = viewService.buildAdapter();
//  Widget oneSoltWidget = viewService.buildComponent("oneSolt");
  return Scaffold(
    appBar: AppBar(title: Text("第二个页面"),),
    body: ListView.builder(itemBuilder: listAdapter.itemBuilder,itemCount: listAdapter.itemCount,),
  );
}
