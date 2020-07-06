import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_component/demo/fishredux/OnePage/adapter.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class OnePagePage extends Page<OnePageState, Map<String, dynamic>> {
  OnePagePage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<OnePageState>(
              adapter: NoneConn<OnePageState>() + OnePageAdapter(),
              slots: <String, Dependent<OnePageState>>{}),
          middleware: <Middleware<OnePageState>>[],
        );
}
