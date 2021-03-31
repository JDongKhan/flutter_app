import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TwoComComponent extends Component<TwoComState> {
  TwoComComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<TwoComState>(
                adapter: null,
                slots: <String, Dependent<TwoComState>>{
                }),);

}
