import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_app_component/demo/fishredux/OneCom/component.dart';
import 'package:flutter_app_component/demo/fishredux/OneCom/state.dart';
import 'package:flutter_app_component/demo/fishredux/ThreeCom/component.dart';
import 'package:flutter_app_component/demo/fishredux/ThreeCom/state.dart';

import 'state.dart';

// StaticFlowAdapter 静态相当于只有插件 ,这样的话除非组装在一起复用性极强，不然直接在page中用会简单点
class TwoPageAdapter extends StaticFlowAdapter<TwoPageState> {
  TwoPageAdapter()
      : super(
          slots: <Dependent<TwoPageState>>[
            OneComConnector() + OneComComponent(),
            ThreeComConnector() + ThreeComComponent(),
          ],
        );
}

class OneComConnector extends ConnOp<TwoPageState, OneComState> {
  @override
  OneComState get(TwoPageState state) {
    return OneComState(title: state.btnTitle);
  }

  @override
  void set(TwoPageState state, OneComState subState) {
    super.set(state, subState);
  }
}

class ThreeComConnector extends ConnOp<TwoPageState, ThreeComState> {
  @override
  ThreeComState get(TwoPageState state) {
    return ThreeComState(someString: state.passString);
  }

  @override
  void set(TwoPageState state, ThreeComState subState) {
    super.set(state, subState);
  }
}
