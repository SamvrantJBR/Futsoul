
List<OffDay> offDaysFromJson(List<dynamic> offDaysJson) =>
    List<OffDay>.from(
        offDaysJson.map((offDayJson) => OffDay.fromJson(offDayJson)));


class OffDay {
  int? id;
  String? merchantId;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? createdAt;
  String? updatedAt;

  OffDay(
      {this.id,
      this.merchantId,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.createdAt,
      this.updatedAt});

  OffDay.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    merchantId = json['merchant_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['merchant_id'] = merchantId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
