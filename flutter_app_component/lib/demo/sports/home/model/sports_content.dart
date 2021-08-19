/// authorImageUrl : ""
/// authorName : ""
/// focusStatus : ""
/// title : ""
/// source : "小视频"
/// commentNum : ""
/// time : "2021-08-01 16:00:00"
/// img : ""
/// videos : [{"title":"李克强来到郑州地铁5号线视察，并强调安全第一","imgUrl":"meinv1"},{"title":"财富洗牌，重置底层经济逻辑","imgUrl":"meinv2"},{"title":"第一次去看我哥工作的地方，真的是很辛苦啊","imgUrl":"meinv1"},{"title":"这个夏天，让我来做你的女朋友，让你的心里凉凉的","imgUrl":"meinv2"},{"title":"王传福：我是来给美国解决就业的，干嘛要找我麻烦","imgUrl":"meinv1"},{"title":"选择一个好公司，然后深耕它","imgUrl":"meinv2"},{"title":"懂得逆向思维，利用它解决一切你想解决的问题","imgUrl":"meinv1"},{"title":"我真的很喜欢你呀，想要和你交个朋友。","imgUrl":"meinv2"}]
/// flag : "3"

class SportsContent {
  String _authorImageUrl;
  String _authorName;
  String _focusStatus;
  String _title;
  String _content;
  String _source;
  String _commentNum;
  String _time;
  String _img;
  List<Videos> _videos;
  List<String> _keywords;
  String _flag;

  String get authorImageUrl => _authorImageUrl;
  String get authorName => _authorName;
  String get focusStatus => _focusStatus;
  String get title => _title;
  String get content => _content;
  String get source => _source;
  String get commentNum => _commentNum;
  String get time => _time;
  String get img => _img;
  List<Videos> get videos => _videos;
  List<String> get keywords => _keywords;
  String get flag => _flag;

  SportsContent({
    String authorImageUrl,
    String authorName,
    String focusStatus,
    String title,
    String content,
    String source,
    String commentNum,
    String time,
    String img,
    List<Videos> videos,
    List<String> keywords,
    String flag,
  }) {
    _authorImageUrl = authorImageUrl;
    _authorName = authorName;
    _focusStatus = focusStatus;
    _title = title;
    _content = content;
    _source = source;
    _commentNum = commentNum;
    _time = time;
    _img = img;
    _videos = videos;
    _keywords = keywords;
    _flag = flag;
  }

  SportsContent.fromJson(dynamic json) {
    _authorImageUrl = json["authorImageUrl"];
    _authorName = json["authorName"];
    _focusStatus = json["focusStatus"];
    _title = json["title"];
    _content = json["content"];
    _source = json["source"];
    _commentNum = json["commentNum"];
    _time = json["time"];
    _img = json["img"];
    if (json["videos"] != null) {
      _videos = [];
      json["videos"].forEach((v) {
        _videos.add(Videos.fromJson(v));
      });
    }
    if (json["keywords"] != null) {
      _keywords = [];
      json["keywords"].forEach((v) {
        _keywords.add(v.toString());
      });
    }
    _flag = json["flag"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["authorImageUrl"] = _authorImageUrl;
    map["authorName"] = _authorName;
    map["focusStatus"] = _focusStatus;
    map["title"] = _title;
    map["content"] = _content;
    map["source"] = _source;
    map["commentNum"] = _commentNum;
    map["time"] = _time;
    map["img"] = _img;
    if (_videos != null) {
      map["videos"] = _videos.map((v) => v.toJson()).toList();
    }
    if (_keywords != null) {
      map["keywords"] = _keywords;
    }
    map["flag"] = _flag;
    return map;
  }
}

/// title : "李克强来到郑州地铁5号线视察，并强调安全第一"
/// imgUrl : "meinv1"

class Videos {
  String _title;
  String _imgUrl;

  String get title => _title;
  String get imgUrl => _imgUrl;

  Videos({String title, String imgUrl}) {
    _title = title;
    _imgUrl = imgUrl;
  }

  Videos.fromJson(dynamic json) {
    _title = json["title"];
    _imgUrl = json["imgUrl"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["title"] = _title;
    map["imgUrl"] = _imgUrl;
    return map;
  }
}
