class UserTokenModel {
  dynamic username;
  dynamic token;

  UserTokenModel({
    this.username,
    this.token,
  });

  UserTokenModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    token = json['token'];
  }
}


