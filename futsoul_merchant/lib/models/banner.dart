
List<Banner> bannersFromJson(List<dynamic> bannersJson) => List<Banner>.from(
    bannersJson.map((categoryJson) => Banner.fromJson(categoryJson)));

class Banner {
  int? id;
  String? image;
  String? createdAt;
  String? updatedAt;

  Banner({this.id, this.image, this.createdAt, this.updatedAt});

  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
