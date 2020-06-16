/// @author jd

class JDImage {
  JDImage(
      {this.sId,
      this.createdAt,
      this.desc,
      this.publishedAt,
      this.type,
      this.url,
      this.used,
      this.who});

  JDImage.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdAt = json['createdAt'];
    desc = json['desc'];
    publishedAt = json['publishedAt'];
    type = json['type'];
    url = json['url'];
    used = json['used'];
    who = json['who'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['desc'] = desc;
    data['publishedAt'] = publishedAt;
    data['type'] = type;
    data['url'] = url;
    data['used'] = used;
    data['who'] = who;
    return data;
  }

  String sId;
  String createdAt;
  String desc;
  String publishedAt;
  String type;
  String url;
  bool used;
  String who;
}
