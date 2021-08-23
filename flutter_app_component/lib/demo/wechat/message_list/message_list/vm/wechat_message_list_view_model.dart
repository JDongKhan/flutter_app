import 'package:jd_core/jd_core.dart';
import 'package:jd_core/view_model/list_view_model.dart';

/// @author jd

class WechatMessageListViewModel extends ListViewModel {
  @override
  Future<List> loadData() async {
    JDNetworkResponse response =
        await JDNetwork.get('http://baidu.com/message_list.do', mock: true);
    List list = response.data;
    return list;
  }
}
