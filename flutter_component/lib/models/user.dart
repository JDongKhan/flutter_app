
class User {
  String avatarUrl;
  String account;
  String role;
  String name;
  String company;
  String blog;
  String location;
  String email;
  String bio;
  int followers;
  int following;
  String createdAt;
  String updatedAt;

  User(
      {this.avatarUrl,
        this.account,
        this.role,
        this.name,
        this.company,
        this.blog,
        this.location,
        this.email,
        this.bio,
        this.followers,
        this.following,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map json) {
    if (json == null) {
      return;
    }
    avatarUrl = json['avatar_url'] as String;
    account = json['account'] as String;
    role = json['role'] as String;
    name = json['name'] as String;
    company = json['company'] as String;
    blog = json['blog'] as String;
    location = json['location'] as String;
    email = json['email'] as String;
    bio = json['bio'] as String;
    followers = json['followers'] as int;
    following = json['following'] as int;
    createdAt = json['created_at'] as String;
    updatedAt = json['updated_at'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar_url'] = this.avatarUrl;
    data['account'] = this.account;
    data['role'] = this.role;
    data['name'] = this.name;
    data['company'] = this.company;
    data['blog'] = this.blog;
    data['location'] = this.location;
    data['email'] = this.email;
    data['bio'] = this.bio;
    data['followers'] = this.followers;
    data['following'] = this.following;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}