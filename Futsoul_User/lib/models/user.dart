class User {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? image;
  String? createdAt;

  User(
      {this.id, this.name, this.phone, this.email, this.image, this.createdAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['image'] = image;
    data['created_at'] = createdAt;
    return data;
  }
}
