List<Futsal> futsalsFromJson(List<dynamic> futsalsJson) => List<Futsal>.from(
    futsalsJson.map((futsalJson) => Futsal.fromJson(futsalJson)));

class Futsal {
  int? id;
  String? name;
  String? phone;
  String? email;
  bool? isAvailable;
  String? fromDate;
  String? toDate;
  String? futsalName;
  String? location;
  String? banner;
  String? image;
  String? price;
  String? description;
  String? createdAt;
  String? updatedAt;

  Futsal(
      {this.id,
      this.name,
      this.phone,
      this.email,
      this.isAvailable,
      this.fromDate,
      this.toDate,
      this.futsalName,
      this.location,
      this.banner,
      this.image,
      this.price,
      this.description,
      this.createdAt,
      this.updatedAt});

  Futsal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    isAvailable = json['is_available'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    futsalName = json['futsal_name'];
    location = json['location'];
    banner = json['banner'];
    image = json['image'];
    price = json['price'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['is_available'] = this.isAvailable;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['futsal_name'] = this.futsalName;
    data['location'] = this.location;
    data['banner'] = this.banner;
    data['image'] = this.image;
    data['price'] = this.price;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
