import 'package:flutter/material.dart';
import 'package:futsoul_merchant/models/off_day.dart';
import 'package:futsoul_merchant/utils/date_time_helper.dart';
import 'package:futsoul_merchant/widget/row/data_row.dart';

class OffDayRow extends StatelessWidget {
  final OffDay offDay;
  const OffDayRow({
    super.key,
    required this.offDay,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: const Offset(1, 1),
                blurRadius: 8,
                color: theme.colorScheme.shadow,
                spreadRadius: 1)
          ]),
      child: Column(
        children: [
          RowData(
              title1: "Start Date",
              title2: "End Date",
              data1: DateTimeHelper.dateWithYear(
                  DateTime.parse(offDay.startDate!)),
              data2: offDay.endDate != null
                  ? DateTimeHelper.dateWithYear(DateTime.parse(offDay.endDate!))
                  : "----"),
          const SizedBox(
            height: 10,
          ),
          RowData(
              title1: "Start Time",
              title2: "End Time",
              data1: offDay.startTime != null
                  ? DateTimeHelper.toTimeOfDay(offDay.startTime!)
                      .format(context)
                  : "----",
              data2: offDay.endTime != null
                  ? DateTimeHelper.toTimeOfDay(offDay.endTime!).format(context)
                  : "----")
        ],
      ),
    );
  }
}
