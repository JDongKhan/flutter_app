/// id : 1001006
/// name : "童装/母婴"
/// keywords : ""
/// desc : "儿童服装，母婴用品"
/// pid : 0
/// iconUrl : "https://www.shequlianshang.com/dts/storage/82v1hfp98sbh7q6yhvhd.png?v=1.0"
/// picUrl : "https://www.shequlianshang.com/dts/storage/jsb109y9x1yr5kvpj4vz.png"
/// level : "L1"
/// sortOrder : 6
/// addTime : "2019-04-13 20:16:00"
/// updateTime : "2019-04-14 01:28:57"
/// deleted : null
/// subCategory : [{"id":100100601,"name":"当季热销","keywords":"","desc":"当季热销","pid":1001006,"iconUrl":"https://www.shequlianshang.com/dts/storage/g2t0liaiahvqns0311he.png?v=1.0","picUrl":"https://www.shequlianshang.com/dts/storage/jsb109y9x1yr5kvpj4vz.png","level":"L2","sortOrder":1,"addTime":"2019-04-13 20:16:00","updateTime":"2019-04-17 21:37:16","deleted":null,"subCategory":null},{"id":100100602,"name":"女宝专区","keywords":"","desc":"女孩专区","pid":1001006,"iconUrl":"https://www.shequlianshang.com/dts/storage/g2t0liaiahvqns0311he.png?v=1.0","picUrl":"https://www.shequlianshang.com/dts/storage/jsb109y9x1yr5kvpj4vz.png","level":"L2","sortOrder":2,"addTime":"2019-04-13 20:16:00","updateTime":"2019-04-17 21:36:29","deleted":null,"subCategory":null},{"id":100100603,"name":"男宝专区","keywords":"","desc":"男孩专区","pid":1001006,"iconUrl":"https://www.shequlianshang.com/dts/storage/g2t0liaiahvqns0311he.png?v=1.0","picUrl":"https://www.shequlianshang.com/dts/storage/jsb109y9x1yr5kvpj4vz.png","level":"L2","sortOrder":3,"addTime":"2019-04-13 20:16:00","updateTime":"2019-04-17 21:36:37","deleted":null,"subCategory":null},{"id":100100604,"name":"洗护喂养","keywords":"","desc":"洗护喂养","pid":1001006,"iconUrl":"https://www.shequlianshang.com/dts/storage/g2t0liaiahvqns0311he.png?v=1.0","picUrl":"https://www.shequlianshang.com/dts/storage/jsb109y9x1yr5kvpj4vz.png","level":"L2","sortOrder":4,"addTime":"2019-04-13 20:16:00","updateTime":"2019-04-17 21:36:43","deleted":null,"subCategory":null},{"id":100100605,"name":"玩具","keywords":"","desc":"玩具","pid":1001006,"iconUrl":"https://www.shequlianshang.com/dts/storage/g2t0liaiahvqns0311he.png?v=1.0","picUrl":"https://www.shequlianshang.com/dts/storage/jsb109y9x1yr5kvpj4vz.png","level":"L2","sortOrder":5,"addTime":"2019-04-13 20:16:00","updateTime":"2019-04-17 21:36:51","deleted":null,"subCategory":null}]

class Category {
  int _id;
  String _name;
  String _keywords;
  String _desc;
  int _pid;
  String _iconUrl;
  String _picUrl;
  String _level;
  int _sortOrder;
  String _addTime;
  String _updateTime;
  dynamic _deleted;
  List<SubCategory> _subCategory;

  int get id => _id;
  String get name => _name;
  String get keywords => _keywords;
  String get desc => _desc;
  int get pid => _pid;
  String get iconUrl => _iconUrl;
  String get picUrl => _picUrl;
  String get level => _level;
  int get sortOrder => _sortOrder;
  String get addTime => _addTime;
  String get updateTime => _updateTime;
  dynamic get deleted => _deleted;
  List<SubCategory> get subCategory => _subCategory;

  Category(
      {int id,
      String name,
      String keywords,
      String desc,
      int pid,
      String iconUrl,
      String picUrl,
      String level,
      int sortOrder,
      String addTime,
      String updateTime,
      dynamic deleted,
      List<SubCategory> subCategory}) {
    _id = id;
    _name = name;
    _keywords = keywords;
    _desc = desc;
    _pid = pid;
    _iconUrl = iconUrl;
    _picUrl = picUrl;
    _level = level;
    _sortOrder = sortOrder;
    _addTime = addTime;
    _updateTime = updateTime;
    _deleted = deleted;
    _subCategory = subCategory;
  }

  Category.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _keywords = json["keywords"];
    _desc = json["desc"];
    _pid = json["pid"];
    _iconUrl = json["iconUrl"];
    _picUrl = json["picUrl"];
    _level = json["level"];
    _sortOrder = json["sortOrder"];
    _addTime = json["addTime"];
    _updateTime = json["updateTime"];
    _deleted = json["deleted"];
    if (json["subCategory"] != null) {
      _subCategory = [];
      json["subCategory"].forEach((v) {
        _subCategory.add(SubCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["keywords"] = _keywords;
    map["desc"] = _desc;
    map["pid"] = _pid;
    map["iconUrl"] = _iconUrl;
    map["picUrl"] = _picUrl;
    map["level"] = _level;
    map["sortOrder"] = _sortOrder;
    map["addTime"] = _addTime;
    map["updateTime"] = _updateTime;
    map["deleted"] = _deleted;
    if (_subCategory != null) {
      map["subCategory"] = _subCategory.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 100100601
/// name : "当季热销"
/// keywords : ""
/// desc : "当季热销"
/// pid : 1001006
/// iconUrl : "https://www.shequlianshang.com/dts/storage/g2t0liaiahvqns0311he.png?v=1.0"
/// picUrl : "https://www.shequlianshang.com/dts/storage/jsb109y9x1yr5kvpj4vz.png"
/// level : "L2"
/// sortOrder : 1
/// addTime : "2019-04-13 20:16:00"
/// updateTime : "2019-04-17 21:37:16"
/// deleted : null
/// subCategory : null

class SubCategory {
  int _id;
  String _name;
  String _keywords;
  String _desc;
  int _pid;
  String _iconUrl;
  String _picUrl;
  String _level;
  int _sortOrder;
  String _addTime;
  String _updateTime;
  dynamic _deleted;
  dynamic _subCategory;

  int get id => _id;
  String get name => _name;
  String get keywords => _keywords;
  String get desc => _desc;
  int get pid => _pid;
  String get iconUrl => _iconUrl;
  String get picUrl => _picUrl;
  String get level => _level;
  int get sortOrder => _sortOrder;
  String get addTime => _addTime;
  String get updateTime => _updateTime;
  dynamic get deleted => _deleted;
  dynamic get subCategory => _subCategory;

  SubCategory(
      {int id,
      String name,
      String keywords,
      String desc,
      int pid,
      String iconUrl,
      String picUrl,
      String level,
      int sortOrder,
      String addTime,
      String updateTime,
      dynamic deleted,
      dynamic subCategory}) {
    _id = id;
    _name = name;
    _keywords = keywords;
    _desc = desc;
    _pid = pid;
    _iconUrl = iconUrl;
    _picUrl = picUrl;
    _level = level;
    _sortOrder = sortOrder;
    _addTime = addTime;
    _updateTime = updateTime;
    _deleted = deleted;
    _subCategory = subCategory;
  }

  SubCategory.fromJson(dynamic json) {
    _id = json["id"];
    _name = json["name"];
    _keywords = json["keywords"];
    _desc = json["desc"];
    _pid = json["pid"];
    _iconUrl = json["iconUrl"];
    _picUrl = json["picUrl"];
    _level = json["level"];
    _sortOrder = json["sortOrder"];
    _addTime = json["addTime"];
    _updateTime = json["updateTime"];
    _deleted = json["deleted"];
    _subCategory = json["subCategory"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["name"] = _name;
    map["keywords"] = _keywords;
    map["desc"] = _desc;
    map["pid"] = _pid;
    map["iconUrl"] = _iconUrl;
    map["picUrl"] = _picUrl;
    map["level"] = _level;
    map["sortOrder"] = _sortOrder;
    map["addTime"] = _addTime;
    map["updateTime"] = _updateTime;
    map["deleted"] = _deleted;
    map["subCategory"] = _subCategory;
    return map;
  }
}
