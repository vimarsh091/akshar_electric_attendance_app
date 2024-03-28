class SocialLoginData {
  String? name;
  String? email;

  SocialLoginData({this.name, required this.email});

  SocialLoginData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}
