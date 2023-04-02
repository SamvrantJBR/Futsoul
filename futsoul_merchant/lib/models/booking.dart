List<Booking> bookingsFromJson(List<dynamic> bookingsJson) =>
    List<Booking>.from(
        bookingsJson.map((bookingJson) => Booking.fromJson(bookingJson)));

class Booking {
  int? id;
  String? userId;
  String? merchantId;
  String? transactionId;
  String? day;
  String? type;
  String? paymentToken;
  String? startTime;
  String? endTime;
  String? price;
  String? status;
  String? isCancelledAt;
  String? createdAt;
  String? updatedAt;
  String? fullName;
  String? email;
  String? phone;
  User? user;

  Booking(
      {this.id,
      this.userId,
      this.merchantId,
      this.transactionId,
      this.day,
      this.type,
      this.paymentToken,
      this.startTime,
      this.endTime,
      this.price,
      this.status,
      this.isCancelledAt,
      this.createdAt,
      this.updatedAt,
      this.fullName,
      this.email,
      this.phone,
      this.user});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'].toString();
    merchantId = json['merchant_id'].toString();
    transactionId = json['transaction_id'];
    day = json['day'];
    type = json['type'];
    paymentToken = json['payment_token'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    price = json['price'];
    status = json['status'];
    isCancelledAt = json['is_cancelled_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullName = json['full_name'];
    email = json['email'];
    phone = json['phone'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['merchant_id'] = merchantId;
    data['transaction_id'] = transactionId;
    data['day'] = day;
    data['type'] = type;
    data['payment_token'] = paymentToken;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['price'] = price;
    data['status'] = status;
    data['is_cancelled_at'] = isCancelledAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['full_name'] = fullName;
    data['email'] = email;
    data['phone'] = phone;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? createdAt;

  User(
      {this.id, this.name, this.email, this.phone, this.image, this.createdAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['image'] = image;
    data['created_at'] = createdAt;
    return data;
  }
}
