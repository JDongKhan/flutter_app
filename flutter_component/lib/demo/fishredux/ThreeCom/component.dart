import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ThreeComComponent extends Component<ThreeComState> {
  ThreeComComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ThreeComState>(
                adapter: null,
                slots: <String, Dependent<ThreeComState>>{
                }),);

}
