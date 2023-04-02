import 'package:flutter/material.dart';
import 'package:futsoul_user/models/time_slot.dart';
import 'package:futsoul_user/utils/colors.dart';
import 'package:futsoul_user/utils/custom_text_styles.dart';

class TimeSlotCard extends StatelessWidget {
  final TimeSlot timeSlot;
  final bool isSelected;
  final VoidCallback onTap;
  const TimeSlotCard({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.timeSlot,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return InkWell(
      onTap: timeSlot.isBooked! ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
            color: timeSlot.isBooked!
                ? theme.colorScheme.onSurface.withOpacity(0.5)
                : isSelected
                    ? AppColors.primaryColor
                    : theme.colorScheme.background,
            borderRadius: BorderRadius.circular(10),
            boxShadow: timeSlot.isBooked!
                ? null
                : [
                    BoxShadow(
                        offset: const Offset(1, 1),
                        spreadRadius: 1,
                        blurRadius: 8,
                        color: theme.colorScheme.shadow)
                  ]),
        child: Text(
          "${timeSlot.time?.toUpperCase()}",
          style: CustomTextStyles.f12W400(
              color: timeSlot.isBooked!
                  ? AppColors.secondaryTextColor
                  : isSelected
                      ? AppColors.backGroundColor
                      : theme.colorScheme.onBackground),
        ),
      ),
    );
  }
}
