import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(OnePageState state, Dispatch dispatch, ViewService viewService) {
  
  ListAdapter listAdapter = viewService.buildAdapter();
  
  return Scaffold(
    appBar: AppBar(title: Text("这是第一个页面"),),
    body: ListView.builder(itemBuilder: listAdapter.itemBuilder,itemCount: listAdapter.itemCount,),
  );
}
