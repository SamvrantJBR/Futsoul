import 'package:futsoul_user/models/futsals.dart';

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
  Futsal? merchant;

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
      this.merchant});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    merchantId = json['merchant_id'];
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
    merchant = json['merchant'] != null
        ? Futsal.fromJson(json['merchant'])
        : null;
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
    if (merchant != null) {
      data['merchant'] = merchant!.toJson();
    }
    return data;
  }
}



List<Booking> bookingsFromJson(List<dynamic> bookingsJson) =>
    List<Booking>.from(
        bookingsJson.map((bookingJson) => Booking.fromJson(bookingJson)));
