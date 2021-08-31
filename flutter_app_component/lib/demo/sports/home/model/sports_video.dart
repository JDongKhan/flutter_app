/// face : "user_head_0"
/// name : "张维为"
/// foucs : "1"
/// title : "看看现在的美国，就会知道为什么希特勒当年能上台"
/// cover : "cover_0"
/// video_url : "assets/videos/video_1.mp4"
/// comment_num : "103"
/// thumbs : "20000"
/// search_keywork : "大家都在搜：希特勒恶魔的崛起"

class SportsVideo {
  String _face;
  String _name;
  String _foucs;
  String _title;
  String _cover;
  String _videoUrl;
  String _commentNum;
  String _thumbs;
  String _searchKeywork;

  String get face => _face;
  String get name => _name;
  String get foucs => _foucs;
  String get title => _title;
  String get cover => _cover;
  String get videoUrl => _videoUrl;
  String get commentNum => _commentNum;
  String get thumbs => _thumbs;
  String get searchKeywork => _searchKeywork;

  SportsVideo(
      {String face,
      String name,
      String foucs,
      String title,
      String cover,
      String videoUrl,
      String commentNum,
      String thumbs,
      String searchKeywork}) {
    _face = face;
    _name = name;
    _foucs = foucs;
    _title = title;
    _cover = cover;
    _videoUrl = videoUrl;
    _commentNum = commentNum;
    _thumbs = thumbs;
    _searchKeywork = searchKeywork;
  }

  SportsVideo.fromJson(dynamic json) {
    _face = json["face"];
    _name = json["name"];
    _foucs = json["foucs"];
    _title = json["title"];
    _cover = json["cover"];
    _videoUrl = json["video_url"];
    _commentNum = json["comment_num"];
    _thumbs = json["thumbs"];
    _searchKeywork = json["search_keywork"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["face"] = _face;
    map["name"] = _name;
    map["foucs"] = _foucs;
    map["title"] = _title;
    map["cover"] = _cover;
    map["video_url"] = _videoUrl;
    map["comment_num"] = _commentNum;
    map["thumbs"] = _thumbs;
    map["search_keywork"] = _searchKeywork;
    return map;
  }
}
