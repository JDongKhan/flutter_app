/// authorImageUrl : "user_head_2"
/// authorName : "冉湖财经"
/// focusStatus : ""
/// title : "打天下容易守天下难，塔利班如果想重建阿富汗的社会秩序，肯定需要大把的资金，也正因为如此，现在很多人都在好奇，阿富汗中央银行所持有的资产，是不是会随着塔利班的到来，而转手到新主人的手上。"
/// source : ""
/// commentNum : "75"
/// time : "2021-08-18 15:00:00"
/// img : "meinv2"
/// flag : "2"

class SportsContent {
  String _authorImageUrl;
  String _authorName;
  String _focusStatus;
  String _title;
  String _source;
  String _commentNum;
  String _time;
  String _img;
  String _flag;

  String get authorImageUrl => _authorImageUrl;
  String get authorName => _authorName;
  String get focusStatus => _focusStatus;
  String get title => _title;
  String get source => _source;
  String get commentNum => _commentNum;
  String get time => _time;
  String get img => _img;
  String get flag => _flag;

  SportsContent(
      {String authorImageUrl,
      String authorName,
      String focusStatus,
      String title,
      String source,
      String commentNum,
      String time,
      String img,
      String flag}) {
    _authorImageUrl = authorImageUrl;
    _authorName = authorName;
    _focusStatus = focusStatus;
    _title = title;
    _source = source;
    _commentNum = commentNum;
    _time = time;
    _img = img;
    _flag = flag;
  }

  SportsContent.fromJson(dynamic json) {
    _authorImageUrl = json["authorImageUrl"];
    _authorName = json["authorName"];
    _focusStatus = json["focusStatus"];
    _title = json["title"];
    _source = json["source"];
    _commentNum = json["commentNum"];
    _time = json["time"];
    _img = json["img"];
    _flag = json["flag"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["authorImageUrl"] = _authorImageUrl;
    map["authorName"] = _authorName;
    map["focusStatus"] = _focusStatus;
    map["title"] = _title;
    map["source"] = _source;
    map["commentNum"] = _commentNum;
    map["time"] = _time;
    map["img"] = _img;
    map["flag"] = _flag;
    return map;
  }
}
