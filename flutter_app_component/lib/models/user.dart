class User {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar_url'] = avatarUrl;
    data['account'] = account;
    data['role'] = role;
    data['name'] = name;
    data['company'] = company;
    data['blog'] = blog;
    data['location'] = location;
    data['email'] = email;
    data['bio'] = bio;
    data['followers'] = followers;
    data['following'] = following;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

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
}
