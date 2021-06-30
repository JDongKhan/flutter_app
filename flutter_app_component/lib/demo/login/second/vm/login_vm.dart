import 'package:jd_core/jd_core.dart';
import 'package:jd_core/view_model/single_view_model.dart';

class LoginVM extends SingleViewModel {
  String localAccount;

  @override
  Future loadData() async {
    //读取本地缓存的账号
    final entity = StorageUtil.getString('localAccount');
    localAccount = entity;
    return true;
  }

  @override
  onCompleted(data) {}
}
