class User {
  int? id;
  String? name;
  String? futsalName;
  String? phone;
  String? location;
  String? image;
  String? banner;
  String? email;
  String? price;
  String? description;
  bool? isAvailable;
  bool? isCompleted;
  int? receivable;
  String? startTime;
  String? endTime;
  String? createdAt;

  User(
      {this.id,
      this.name,
      this.futsalName,
      this.phone,
      this.location,
      this.image,
      this.banner,
      this.email,
      this.price,
      this.description,
      this.isAvailable,
      this.isCompleted,
      this.receivable,
      this.startTime,
      this.endTime,
      this.createdAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    futsalName = json['futsal_name'];
    phone = json['phone'];
    location = json['location'];
    image = json['image'];
    banner = json['banner'];
    email = json['email'];
    price = json['price'];
    description = json['description'];
    isAvailable = json['is_available'];
    isCompleted = json['is_completed'];
    receivable = json['receivable'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['futsal_name'] = futsalName;
    data['phone'] = phone;
    data['location'] = location;
    data['image'] = image;
    data['banner'] = banner;
    data['email'] = email;
    data['price'] = price;
    data['description'] = description;
    data['is_available'] = isAvailable;
    data['is_completed'] = isCompleted;
    data['receivable'] = receivable;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['created_at'] = createdAt;
    return data;
  }
}
