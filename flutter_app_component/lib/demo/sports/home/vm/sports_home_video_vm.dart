import 'package:flutter_app_component/demo/sports/home/model/sports_content.dart';
import 'package:jd_core/network/jd_network_utils.dart';
import 'package:jd_core/view_model/refresh_list_view_model.dart';

/// @author jd

class SportsHomeVideoVm extends RefreshListViewModel<SportsContent> {
  List textAdList = ['我气哭了，这个垃圾游戏真难玩。', '开局十连抽，SSR登录就送。', '2021PP体育视频迎来大转折。'];
  List likeList = [
    {
      'img': 'bg_0',
      'title': '动态漫画.斗破苍穹',
      'remark': '好嗨呀！少年激燃战群豪！',
    },
    {
      'img': 'bg_1',
      'title': '斗罗大陆',
      'remark': '海神来了，大家快跑！',
    },
    {
      'img': 'bg_2',
      'title': '斗破苍穹 第4季',
      'remark': '区区云兽胆敢伤我徒儿？',
    },
    {
      'img': 'bg_3',
      'title': '全职法师',
      'remark': '唐月道出玄蛇真相！',
    },
    {
      'img': 'bg_4',
      'title': '万界独尊',
      'remark': '巧了！我救美少女的妹妹！',
    },
    {
      'img': 'bg_5',
      'title': '全职高手 第2季',
      'remark': '大结局，兴欣剑指挑战赛！',
    },
    {
      'img': 'bg_0',
      'title': '西行纪',
      'remark': '本大爷就是勇者傲雪！',
    },
  ];
  @override
  Future<List<SportsContent>> loadData({int pageNum}) async {
    JDNetworkResponse response = await JDNetwork.get(
        'http://baidu.com/sports_infomation_list.do',
        mock: true);
    List list = response.data;
    List<SportsContent> contentList =
        list.map((e) => SportsContent.fromJson(e)).toList();
    return contentList;
  }
}
