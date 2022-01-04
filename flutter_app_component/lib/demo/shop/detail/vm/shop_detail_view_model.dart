import 'package:jd_core/jd_core.dart';
import 'package:jd_core/view_model/single_view_model.dart';

/// @author jd

class ShopDetailViewModel extends SingleViewModel {
  @override
  Future loadData() async {
    NetworkResponse response =
        await Network.get('http://baidu.com/message_list.do', mock: true);
    List list = response.data;
    return list;
  }

  @override
  void onCompleted(data) {}
}
