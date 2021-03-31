import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class OneComComponent extends Component<OneComState> {
  OneComComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<OneComState>(
                adapter: null,
                slots: <String, Dependent<OneComState>>{
                }),);

}
