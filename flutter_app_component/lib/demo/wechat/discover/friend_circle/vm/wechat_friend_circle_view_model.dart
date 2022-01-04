import 'package:jd_core/jd_core.dart';
import 'package:jd_core/view_model/list_view_model.dart';

/// @author jd

class WechatFriendCircleViewModel extends ListViewModel {
  @override
  Future<List> loadData() async {
    NetworkResponse response =
        await Network.get('http://baidu.com/friend_circle.do', mock: true);
    return response.data;
  }
}
