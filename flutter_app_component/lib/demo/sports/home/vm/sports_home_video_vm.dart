import 'package:flutter/cupertino.dart';
import 'package:flutter_app_component/demo/sports/home/model/sports_video.dart';
import 'package:jd_core/network/jd_network_utils.dart';
import 'package:jd_core/view_model/refresh_list_view_model.dart';

/// @author jd

class SportsHomeVideoVM extends RefreshListViewModel<SportsVideo> {
  bool isPlaying;

  ///作为当前播放的标示，也可以是url，担心url会重复，用实例靠谱点
  State playingState;

  void play(State from) {
    playingState = from;
    isPlaying = true;
    notifyListeners();
  }

  void pause(State from) {
    playingState = from;
    isPlaying = false;
    notifyListeners();
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
