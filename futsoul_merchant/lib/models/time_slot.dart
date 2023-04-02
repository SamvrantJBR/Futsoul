class TimeSlot {
  String? date;
  String? time;
  String? start;
  String? end;
  bool? isBooked;

  TimeSlot({this.date, this.time, this.start, this.end, this.isBooked});

  TimeSlot.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    time = json['time'];
    start = json['start'];
    end = json['end'];
    isBooked = json['is_booked']??false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['time'] = time;
    data['start'] = start;
    data['end'] = end;
    data['is_booked'] = isBooked;
    return data;
  }
}

List<TimeSlot> timeSlotsFromJson(List<dynamic> timeslotsJson) => List<TimeSlot>.from(
    timeslotsJson.map((timeslotJson) => TimeSlot.fromJson(timeslotJson)));
