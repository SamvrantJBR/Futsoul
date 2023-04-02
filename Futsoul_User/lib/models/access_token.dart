class AccessToken {
  String? type;
  String? accessToken;

  AccessToken({this.type, this.accessToken});

  AccessToken.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['accessToken'] = accessToken;
    return data;
  }

  @override
  String toString() {
    return "$type $accessToken";
  }

}
