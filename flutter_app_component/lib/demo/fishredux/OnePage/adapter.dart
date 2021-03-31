import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_app_component/demo/fishredux/OneCom/component.dart';
import 'package:flutter_app_component/demo/fishredux/OneCom/state.dart';
import 'package:flutter_app_component/demo/fishredux/ThreeCom/component.dart';
import 'package:flutter_app_component/demo/fishredux/ThreeCom/state.dart';
import 'package:flutter_app_component/demo/fishredux/TwoCom/component.dart';
import 'package:flutter_app_component/demo/fishredux/TwoCom/state.dart';

import 'state.dart';

//使用 DynamicFlowAdapter
class OnePageAdapter extends DynamicFlowAdapter<OnePageState> {
  OnePageAdapter()
      : super(
          pool: <String, Component<Object>>{
            "item1": OneComComponent(),
            "item2": TwoComComponent(),
            "item3": ThreeComComponent(),
          },
          connector: _OnePageConnector(),
        );
}

class _OnePageConnector extends ConnOp<OnePageState, List<ItemBean>> {
  @override
  List<ItemBean> get(OnePageState state) {
    //演示直接添加，比如两个固定栏 + 一个列表排布
    List<ItemBean> items = [];

    items.add(ItemBean("item1", OneComState()));

    items.add(ItemBean("item2", TwoComState()));

    List item3List = [];
    for (int i = 0; i < 30; i++) {
      item3List.add("这是文本列表 - " + i.toString());
    }
    items.addAll(item3List
        .map((str) => ItemBean("item3", ThreeComState(someString: str)))
        .toList());

    return items;
  }

  @override
  void set(OnePageState state, List<ItemBean> items) {}

  @override
  subReducer(reducer) {
    // TODO: implement subReducer
    return super.subReducer(reducer);
  }
}
