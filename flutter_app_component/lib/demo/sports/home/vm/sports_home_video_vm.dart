import 'package:flutter_app_component/demo/sports/home/model/sports_video.dart';
import 'package:flutter_app_component/demo/sports/home/widget/sports_list_player.dart';
import 'package:jd_core/network/jd_network_utils.dart';
import 'package:jd_core/view_model/refresh_list_view_model.dart';

/// @author jd

class SportsHomeVideoVM extends RefreshListViewModel<SportsVideo> {
  SportsListPlayerController sportsListPlayerController;

  void toPlay(SportsListPlayerController playerController) {
    if (sportsListPlayerController != null) {
      sportsListPlayerController.pause();
    }
    sportsListPlayerController = playerController;
    sportsListPlayerController.play();
  }

  @override
  Future<List<SportsVideo>> loadData({int pageNum}) async {
    JDNetworkResponse response = await JDNetwork.get(
        'http://baidu.com/sports_video_list.do',
        mock: true);
    List list = response.data;
    List<SportsVideo> contentList =
        list.map((e) => SportsVideo.fromJson(e)).toList();
    return contentList;
  }
}
