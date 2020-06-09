/// @author jd

class JDImage {
  String sId;
  String createdAt;
  String desc;
  String publishedAt;
  String type;
  String url;
  bool used;
  String who;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['desc'] = this.desc;
    data['publishedAt'] = this.publishedAt;
    data['type'] = this.type;
    data['url'] = this.url;
    data['used'] = this.used;
    data['who'] = this.who;
    return data;
  }
}
