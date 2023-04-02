import 'dart:developer';

import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {

  int compareTo(TimeOfDay other) {
    log("$hour --> $minute");
    log("${other.hour} --> ${other.minute}");
    if (hour < other.hour) return -1;
    if (hour > other.hour) return 1;
    if (minute < other.minute) return -1;
    if (minute > other.minute) return 1;
    return 0;
  }

}